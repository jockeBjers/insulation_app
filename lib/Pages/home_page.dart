import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insulation_app/models/insulated_pipe.dart';
import 'package:insulation_app/models/project.dart';
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
  late Box<Project> projectBox;
  Project? selectedProject;

  @override
  void initState() {
    super.initState();
    projectBox = Hive.box<Project>('projects');
    if (projectBox.isNotEmpty) {
      selectedProject = projectBox.values.first;
      calculateTotalMaterial();
    }
  }

  List<InsulatedPipe> get pipes => selectedProject?.pipes ?? [];

  void showAddPipeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddPipeDialog(
          onAddPipe: (selectedSize, firstLayer, secondLayer, length) {
            setState(() {
              final newPipe = InsulatedPipe(
                size: selectedSize,
                length: length,
                firstLayerMaterial: firstLayer,
                secondLayerMaterial: secondLayer,
              );
              selectedProject?.pipes.add(newPipe);
              selectedProject?.save();
              calculateTotalMaterial();
            });
          },
        );
      },
    );
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
          onEditPipe: (selectedSize, firstLayer, secondLayer, length) {
            setState(() {
              pipes[index] = InsulatedPipe(
                size: selectedSize,
                length: length,
                firstLayerMaterial: firstLayer,
                secondLayerMaterial: secondLayer,
              );
              selectedProject?.save();
              calculateTotalMaterial();
            });
          },
        );
      },
    );
  }

  void removePipe(int index) {
    setState(() {
      selectedProject?.pipes.removeAt(index);
      selectedProject?.save();
      calculateTotalMaterial();
    });
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

  void selectProject(Project project) {
    setState(() {
      selectedProject = project;
    });
    calculateTotalMaterial();
  }

  void showAddProjectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddProjectDialog(
          onAddProject: (projectNumber, name, address, contactPerson,
              contactNumber, date) {
            setState(() {
              final newProject = Project(
                projectNumber: projectNumber,
                name: name,
                address: address,
                date: date,
                contactPerson: contactPerson,
                contactNumber: contactNumber,
                pipes: [],
              );
              projectBox.put(projectNumber, newProject);
              selectProject(newProject);
            });
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
          onEditProject: (updatedProject) {
            setState(() {
              projectBox.put(updatedProject.projectNumber, updatedProject);
            });
          },
        );
      },
    );
  }

  void removeProject(int index) {
    setState(() {
      if (projectBox.isNotEmpty) {
        final project = projectBox.getAt(index);
        project?.delete();
        if (projectBox.isNotEmpty) {
          selectProject(projectBox.values.first);
        } else {
          selectedProject = null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Projektnummer: ${selectedProject!.projectNumber}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Datum: ${selectedProject!.date.toLocal().toString().split(" ")[0]}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Adress: ${selectedProject!.address}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              : Text(
                  "Isoleringsberäknaren",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
        ),
      ),

      // Drawer
      drawer: CustomDrawer(
        selectProject: selectProject,
        editProject: editProject,
        removeProject: removeProject,
        showAddProjectDialog: showAddProjectDialog,
      ),

      // Body
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 600,
          ),
          child: Column(
            children: [
              // List of pipes
              Expanded(
                  child: pipes.isEmpty
                      ? Center(child: Text("Inga rör tillagda"))
                      : PipeListView(
                          pipes: pipes,
                          removePipe: removePipe,
                          editPipe: editPipe,
                        )),

              // Summary view
              SummaryView(
                  total30: total30,
                  total50: total50,
                  total80: total80), // end container
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddPipeDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
