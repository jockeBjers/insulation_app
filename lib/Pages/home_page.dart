// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulated_pipes/insulated_pipe.dart';
import 'package:insulation_app/models/projects/project.dart';
import 'package:insulation_app/services/firebase_service.dart';
import 'package:insulation_app/util/add_pipe_dialog_box.dart';
import 'package:insulation_app/util/add_project_dialog_box.dart';
import 'package:insulation_app/util/edit_pipe_dialog_box.dart';
import 'package:insulation_app/util/edit_project_dialog_box.dart';
import 'package:insulation_app/util/widgets/custom_drawer.dart';
import 'package:insulation_app/util/widgets/pipe_list_view.dart';
import 'package:insulation_app/util/widgets/summary_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService _firebaseService = FirebaseService();
  List<Project> _projects = [];
  Project? selectedProject;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProjects();
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
        // Debug: Log the user and organization info
        print('Current user: ${currentUser.name}, role: ${currentUser.role}');
        print('Organization ID: ${currentUser.organizationId}');

        if (currentUser.organizationId.isNotEmpty) {
          // Load projects for the user's organization
          print(
              'Fetching projects for organization: ${currentUser.organizationId}');
          projects =
              await _firebaseService.getProjects(currentUser.organizationId);
          print('Found ${projects.length} projects for this organization');
        } else {
          print('Warning: User has no organization ID');
          // Load projects without organization filter
          projects = await _firebaseService.getAllProjects();
          print('Loaded ${projects.length} projects (all organizations)');
        }
      } else {
        print('Warning: No current user found');
        // Load projects without organization filter
        projects = await _firebaseService.getAllProjects();
        print('Loaded ${projects.length} projects (all organizations)');
      }

      setState(() {
        _projects = projects;
        if (_projects.isNotEmpty) {
          selectedProject = _projects.first;
          calculateTotalMaterial();
          print(
              'Selected first project: ${selectedProject?.name} (${selectedProject?.id})');
        } else {
          print('No projects available to select');
        }
      });
    } catch (e) {
      // Handle error
      print('Error loading projects: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<InsulatedPipe> get pipes => selectedProject?.pipes ?? [];
  void showAddPipeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddPipeDialog(
          onAddPipe: (selectedSize, firstLayer, secondLayer, length) async {
            if (selectedProject != null) {
              final newPipe = InsulatedPipe(
                id: null, // Firebase will generate ID
                size: selectedSize,
                length: length,
                firstLayerMaterial: firstLayer,
                secondLayerMaterial: secondLayer,
              );

              // Create a new list with the new pipe added
              final updatedPipes = [...selectedProject!.pipes, newPipe];

              // Create a new project with the updated pipes list
              final updatedProject =
                  selectedProject!.copyWith(pipes: updatedPipes);

              setState(() {
                selectedProject = updatedProject;
              });

              // Update project in Firestore
              await _firebaseService.updateProject(updatedProject);
              calculateTotalMaterial();
            }
          },
        );
      },
    );
  }

  void removePipe(int index) async {
    if (selectedProject != null) {
      // Create a new list without the removed pipe
      final updatedPipes = [...selectedProject!.pipes];
      updatedPipes.removeAt(index);

      // Create a new project with the updated pipes list
      final updatedProject = selectedProject!.copyWith(pipes: updatedPipes);

      setState(() {
        selectedProject = updatedProject;
      });

      // Update project in Firestore
      await _firebaseService.updateProject(updatedProject);
      calculateTotalMaterial();
    }
  }

  void editPipe({required InsulatedPipe pipe, required int index}) {
    showDialog(
      context: context,
      builder: (context) {
        return EditPipeDialog(
          initialSize: pipe.size,
          initialFirstLayer: pipe.firstLayerMaterial,
          initialSecondLayer: pipe.secondLayerMaterial,
          initialLength: pipe.length,
          onEditPipe: (selectedSize, firstLayer, secondLayer, length) async {
            if (selectedProject != null) {
              // Keep the same ID if it exists
              final updatedPipe = InsulatedPipe(
                id: pipe.id,
                size: selectedSize,
                length: length,
                firstLayerMaterial: firstLayer,
                secondLayerMaterial: secondLayer,
              );

              // Create a new list with the updated pipe
              final updatedPipes = [...selectedProject!.pipes];
              updatedPipes[index] = updatedPipe;

              // Create a new project with the updated pipes list
              final updatedProject =
                  selectedProject!.copyWith(pipes: updatedPipes);

              setState(() {
                selectedProject = updatedProject;
              });

              // Update project in Firestore
              await _firebaseService.updateProject(updatedProject);
              calculateTotalMaterial();
            }
          },
        );
      },
    );
  }

  //summary
  double total30 = 0;
  double total50 = 0;
  double total80 = 0;

  void calculateTotalMaterial() {
    double newTotal30 = 0;
    double newTotal50 = 0;
    double newTotal80 = 0;

    void addArea(double thickness, double area) {
      switch (thickness) {
        case 0.03:
          newTotal30 += area.ceil();
          break;
        case 0.05:
          newTotal50 += area.ceil();
          break;
        case 0.08:
          newTotal80 += area.ceil();
          break;
      }
    }

    for (var pipe in pipes) {
      addArea(pipe.firstLayerMaterial.insulationThickness,
          pipe.getFirstLayerArea());
      if (pipe.secondLayerMaterial != null) {
        addArea(pipe.secondLayerMaterial!.insulationThickness,
            pipe.getSecondLayerArea());
      }
    }

    setState(() {
      total30 = newTotal30;
      total50 = newTotal50;
      total80 = newTotal80;
    });
  }

  void selectProject(Project project) async {
    // Fetch the full project with all details
    final fullProject = await _firebaseService.getProject(project.id!);

    if (fullProject != null) {
      setState(() {
        selectedProject = fullProject;
      });
      calculateTotalMaterial();
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
                organizationId:
                    currentUser?.organizationId, // Make this optional
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
                  selectedProject = createdProject;
                });
                calculateTotalMaterial();
              }
            } catch (e) {
              // Handle error
              if (context.mounted) {
                print('Error creating project: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to create project')),
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
                }

                if (selectedProject?.id == updatedProject.id) {
                  selectedProject = updatedProject;
                }
              });
            } catch (e) {
              // Handle error
              if (context.mounted) {
                print('Error updating project: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update project')),
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
      // Delete project from Firestore
      await _firebaseService.deleteProject(projectId);

      // Update local state
      setState(() {
        _projects.removeWhere((p) => p.id == projectId);

        if (selectedProject?.id == projectId) {
          selectedProject = _projects.isNotEmpty ? _projects.first : null;
          calculateTotalMaterial();
        }
      });
    } catch (e) {
      // Handle error
      if (context.mounted) {
        print('Error deleting project: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete project')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Loading...")),
        body:
            Center(child: CircularProgressIndicator(color: theme.primaryColor)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: selectedProject != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedProject!.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      "Projektnummer: ${selectedProject!.projectNumber}",
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      "Datum: ${selectedProject!.date.toLocal().toString().split(" ")[0]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      "Adress: ${selectedProject!.address ?? ''}",
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                )
              : Text(
                  "Isoleringsberäknaren",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
        ),
      ),
      drawer: CustomDrawer(
        projects: _projects,
        selectProject: selectProject,
        editProject: editProject,
        removeProject: removeProject,
        showAddProjectDialog: showAddProjectDialog,
      ),
      body: Container(
        color: theme.colorScheme.onSurface,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: Column(
              children: [
                // List of pipes
                Expanded(
                  child: pipes.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.category_outlined,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Inga rör tillagda",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        )
                      : PipeListView(
                          pipes: pipes,
                          removePipe: removePipe,
                          editPipe: editPipe,
                        ),
                ),

                // Summary view
                SummaryView(
                  total30: total30,
                  total50: total50,
                  total80: total80,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddPipeDialog,
        backgroundColor: Colors.white,
        foregroundColor: theme.colorScheme.primary,
        child: Icon(Icons.add),
      ),
    );
  }
}
