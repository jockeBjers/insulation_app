import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulated_pipes/insulated_pipe.dart';
import 'package:insulation_app/models/insulation_type/insulation_type.dart';
import 'package:insulation_app/models/projects/project.dart';
import 'package:insulation_app/services/firebase_service.dart';
import 'package:insulation_app/util/add_pipe_dialog_box.dart';
import 'package:insulation_app/util/edit_pipe_dialog_box.dart';
import 'package:insulation_app/util/widgets/pipe_list_view.dart';
import 'package:insulation_app/util/widgets/summary_bottom_sheet.dart';

class ProjectDetailPage extends StatefulWidget {
  final Project project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final FirebaseService _firebaseService = FirebaseService();
  late Project _project;
  bool _isLoading = true;

  // For summary calculations - using dynamic map
  Map<String, double> insulationTotals = {};

  @override
  void initState() {
    super.initState();
    _project = widget.project;
    _loadProject();
  }

  Future<void> _loadProject() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_project.id != null) {
        final updatedProject = await _firebaseService.getProject(_project.id!);
        if (updatedProject != null) {
          setState(() {
            _project = updatedProject;
            _calculateTotalMaterial();
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load project: ${e.toString()}')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _calculateTotalMaterial() {
    // Reset the map
    Map<String, double> newTotals = {};

    void addArea(InsulationType insulation, double area) {
      // Use the insulation name as the key instead of just thickness
      newTotals[insulation.name] =
          (newTotals[insulation.name] ?? 0) + area.ceil();
    }

    for (var pipe in _project.pipes) {
      addArea(pipe.firstLayerMaterial, pipe.getFirstLayerArea());
      if (pipe.secondLayerMaterial != null) {
        addArea(pipe.secondLayerMaterial!, pipe.getSecondLayerArea());
      }
    }

    setState(() {
      insulationTotals = newTotals;
    });
  }

  void _showSummaryDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
      ),
      builder: (context) {
        return SummaryBottomSheet(insulationTotals: insulationTotals);
      },
    );
  }

  void _showAddPipeDialog() {
    if (_project.id == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AddPipeDialog(
          onAddPipe: (selectedSize, firstLayer, secondLayer, length) async {
            final newPipe = InsulatedPipe(
              id: null, // Firebase will generate ID
              size: selectedSize,
              length: length,
              firstLayerMaterial: firstLayer,
              secondLayerMaterial: secondLayer,
            );

            // Create a new list with the new pipe added
            final updatedPipes = [..._project.pipes, newPipe];

            // Create a new project with the updated pipes list
            final updatedProject = _project.copyWith(pipes: updatedPipes);

            setState(() {
              _project = updatedProject;
            });

            // Update project in Firestore
            await _firebaseService.updateProject(updatedProject);
            _calculateTotalMaterial();
          },
        );
      },
    );
  }

  void removePipe(int index) async {
    try {
      // Show confirmation dialog
      final bool confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Ta bort rör'),
              content: const Text(
                  'Är du säker på att du vill ta bort detta rör? Denna åtgärd kan inte ångras.'),
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
        // Create a new list without the removed pipe
        final updatedPipes = [..._project.pipes];
        final pipeToRemove = updatedPipes[index];
        updatedPipes.removeAt(index);

        // Create a new project with the updated pipes list
        final updatedProject = _project.copyWith(pipes: updatedPipes);

        setState(() {
          _project = updatedProject;
        });

        // Delete pipe from Firestore if it has an ID
        if (pipeToRemove.id != null && _project.id != null) {
          await _firebaseService.updateProject(updatedProject);
        } else {
          // Otherwise just update the project in Firestore
          await _firebaseService.updateProject(updatedProject);
        }

        _calculateTotalMaterial();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete pipe: ${e.toString()}')),
        );
      }
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
            // Keep the same ID if it exists
            final updatedPipe = InsulatedPipe(
              id: pipe.id,
              size: selectedSize,
              length: length,
              firstLayerMaterial: firstLayer,
              secondLayerMaterial: secondLayer,
            );

            // Create a new list with the updated pipe
            final updatedPipes = [..._project.pipes];
            updatedPipes[index] = updatedPipe;

            // Create a new project with the updated pipes list
            final updatedProject = _project.copyWith(pipes: updatedPipes);

            setState(() {
              _project = updatedProject;
            });

            // Update project in Firestore
            await _firebaseService.updateProject(updatedProject);
            _calculateTotalMaterial();
          },
        );
      },
    );
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Tillbaka till projekt',
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ISOLERAMERA",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProject,
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
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 800,
                  ),
                  child: Column(
                    children: [
                      // Project info card
                      if (_project.address != null &&
                          _project.address!.isNotEmpty)
                        Card(
                          shape: const LinearBorder(),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${_project.projectNumber} - ${_project.name}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      _buildInfoRow(
                                        Icons.calendar_today,
                                        "Datum",
                                        _project.date
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0],
                                      ),
                                      if (_project.address != null &&
                                          _project.address!.isNotEmpty)
                                        _buildInfoRow(Icons.location_on,
                                            "Adress", _project.address!),
                                      if (_project.contactPerson != null &&
                                          _project.contactPerson!.isNotEmpty)
                                        _buildInfoRow(Icons.person, "Kontakt",
                                            _project.contactPerson!),
                                      if (_project.contactNumber != null &&
                                          _project.contactNumber!.isNotEmpty)
                                        _buildInfoRow(Icons.phone, "Telefon",
                                            _project.contactNumber!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Pipes header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Rör (${_project.pipes.length})",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add_chart_outlined),
                              label: const Text("Se total"),
                              onPressed: _showSummaryDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text("Lägg till rör"),
                              onPressed: _showAddPipeDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Pipes list
                      Expanded(
                        child: _project.pipes.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.plumbing_outlined,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Inga rör har lagts till i det här projektet",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.add),
                                      label:
                                          const Text("Lägg till första röret"),
                                      onPressed: _showAddPipeDialog,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        foregroundColor:
                                            theme.colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : PipeListView(
                                pipes: _project.pipes,
                                removePipe: removePipe,
                                editPipe: editPipe,
                              ),
                      ),
                    ],
                  ),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
