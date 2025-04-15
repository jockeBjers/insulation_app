import 'package:flutter/material.dart';
import 'package:insulation_app/Pages/project_detail_page.dart';
import 'package:insulation_app/models/projects/project.dart';
import 'package:insulation_app/services/firebase_service.dart';
import 'package:insulation_app/util/add_project_dialog_box.dart';
import 'package:insulation_app/util/edit_project_dialog_box.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final FirebaseService _firebaseService = FirebaseService();
  List<Project> _projects = [];
  bool _isLoading = true;

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  List<Project> _filteredProjects = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadProjects();

    _searchController.addListener(() {
      _filterProjects();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProjects() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _filteredProjects = _projects;
        _isSearching = false;
      });
      return;
    }

    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProjects = _projects.where((project) {
        return project.name.toLowerCase().contains(query) ||
            project.projectNumber.toLowerCase().contains(query) ||
            (project.address?.toLowerCase().contains(query) ?? false) ||
            (project.contactPerson?.toLowerCase().contains(query) ?? false);
      }).toList();
      _isSearching = true;
    });
  }

  Future<void> _loadProjects() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Project> projects = [];
      // Get current user to get their organization
      final currentUser = await _firebaseService.getCurrentUser();

      if (currentUser != null) {
        if (currentUser.organizationId.isNotEmpty) {
          // Load projects for the user's organization
          projects =
              await _firebaseService.getProjects(currentUser.organizationId);
        } else {
          // Load projects without organization filter
          projects = await _firebaseService.getAllProjects();
        }
      } else {
        // Load all projects if no user is found
        projects = await _firebaseService.getAllProjects();
      }

      setState(() {
        _projects = projects;
        _filteredProjects = projects;
      });
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load projects: ${e.toString()}')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> openGoogleMaps(String address) async {
    String encodedAddress = Uri.encodeComponent(address);
    String url =
        "https://www.google.com/maps/search/?api=1&query=$encodedAddress";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchCall(String phoneNumber) async {
    final Uri urlParsed = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      throw 'Could not launch call to: $phoneNumber';
    }
  }

  void showAddProjectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddProjectDialog(
          onAddProject: (projectNumber, name, address, contactPerson,
              contactNumber, date) async {
            try {
              // Get current user to get their organization
              final currentUser = await _firebaseService.getCurrentUser();

              final newProject = Project(
                id: null, // Firebase will generate ID
                projectNumber: projectNumber,
                name: name,
                address: address,
                date: date,
                organizationId: currentUser?.organizationId,
                contactPerson: contactPerson,
                contactNumber: contactNumber,
                pipes: [],
              );

              // Create project in Firestore
              final projectId =
                  await _firebaseService.createProject(newProject);

              // Fetch the newly created project
              final createdProject =
                  await _firebaseService.getProject(projectId);

              if (createdProject != null) {
                setState(() {
                  _projects.add(createdProject);
                  _filterProjects();
                });
              }
            } catch (e) {
              // Handle error
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to create project')),
                );
              }
            }
          },
        );
      },
    );
  }

  void editProject(Project project) {
    showDialog(
      context: context,
      builder: (context) {
        return EditProjectDialog(
          project: project,
          onEditProject: (updatedProject) async {
            try {
              // Update project in Firestore
              await _firebaseService.updateProject(updatedProject);

              // Update local state
              setState(() {
                final index =
                    _projects.indexWhere((p) => p.id == updatedProject.id);
                if (index != -1) {
                  _projects[index] = updatedProject;
                  _filterProjects();
                }
              });
            } catch (e) {
              // Handle error
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to update project')),
                );
              }
            }
          },
        );
      },
    );
  }

  void removeProject(String projectId) async {
    try {
      // Show confirmation dialog
      final bool confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Ta bort projekt'),
              content: const Text(
                  'Är du säker på att du vill ta bort projektet? Denna åtgärd kan inte ångras.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Avbryt'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Ta bort',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ) ??
          false;

      if (confirm) {
        // Delete project from Firestore
        await _firebaseService.deleteProject(projectId);

        // Update local state
        setState(() {
          _projects.removeWhere((p) => p.id == projectId);
          _filterProjects();
        });
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete project')),
        );
      }
    }
  }

  void navigateToProjectDetails(Project project) async {
    // Get the full project with all details
    final fullProject = await _firebaseService.getProject(project.id!);

    if (fullProject != null && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectDetailPage(project: fullProject),
        ),
      ).then((_) {
        // Refresh the projects list when returning from project details
        _loadProjects();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Laddar projekt...")),
        body:
            Center(child: CircularProgressIndicator(color: theme.primaryColor)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ISOLERAMERA",
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Tillbaka',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProjects,
            tooltip: 'Uppdatera',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withValues(alpha: .05),
              theme.colorScheme.primary.withValues(alpha: .2),
            ],
          ),
        ),
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Sök projekt...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _isSearching
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            // Projects header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Projekt (${_filteredProjects.length})",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Lägg till projekt"),
                    onPressed: showAddProjectDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Projects list
            Expanded(
              child: _filteredProjects.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isSearching
                                ? Icons.search_off
                                : Icons.folder_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _isSearching
                                ? "Inga matchande projekt hittades"
                                : "Inga projekt hittades",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                          if (!_isSearching) const SizedBox(height: 24),
                          if (!_isSearching)
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text("Lägg till projekt"),
                              onPressed: showAddProjectDialog,
                            ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: _filteredProjects.length,
                        itemBuilder: (context, index) {
                          final project = _filteredProjects[index];
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: index == _filteredProjects.length - 1
                                  ? 200.0
                                  : 0.0,
                            ),
                            child: Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${project.projectNumber} - ${project.name}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () => editProject(project),
                                      tooltip: 'Redigera projekt',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        if (project.id != null) {
                                          removeProject(project.id!);
                                        }
                                      },
                                      tooltip: 'Ta bort projekt',
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (project.address != null &&
                                          project.address!.isNotEmpty)
                                        InkWell(
                                          onTap: () =>
                                              openGoogleMaps(project.address!),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 16,
                                                color:
                                                    theme.colorScheme.secondary,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  project.address!,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 4),
                                      if (project.contactPerson != null &&
                                          project.contactPerson!.isNotEmpty)
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 16,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              project.contactPerson!,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 4),
                                      if (project.contactNumber != null &&
                                          project.contactNumber!.isNotEmpty)
                                        InkWell(
                                          onTap: () => launchCall(
                                              project.contactNumber!),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                size: 16,
                                                color:
                                                    theme.colorScheme.secondary,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                project.contactNumber!,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Datum: ${project.date.toLocal().toString().split(' ')[0]}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () => navigateToProjectDetails(project),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),

            // Footer
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  "© 2025 Isoleramera",
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
