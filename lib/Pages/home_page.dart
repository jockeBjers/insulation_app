import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulated_pipe.dart';
import 'package:insulation_app/models/project.dart';
import 'package:insulation_app/util/add_pipe_dialog_box.dart';
import 'package:insulation_app/util/add_project_dialog_box.dart';
import 'package:insulation_app/util/widgets/custom_drawer.dart';
import 'package:insulation_app/util/widgets/pipe_list_view.dart';
import 'package:insulation_app/util/widgets/summary_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Project> projects = [];
  Project? selectedProject;

  @override
  void initState() {
    super.initState();
    if (projects.isNotEmpty) {
      selectedProject = projects[0];
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
              pipes.add(InsulatedPipe(
                size: selectedSize,
                length: length,
                firstLayerMaterial: firstLayer,
                secondLayerMaterial: secondLayer,
              ));
            });
            calculateTotalMaterial();
          },
        );
      },
    );
  }

  void removePipe(int index) {
    setState(() {
      pipes.removeAt(index);
    });
    calculateTotalMaterial();
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
          onAddProject: (projectNumber, name, date) {
            setState(() {
              projects.add(Project(
                projectNumber: projectNumber,
                name: name,
                date: date,
                pipes: [],
              ));
              selectProject(projects.last);
            });
          },
        );
      },
    );
  }

  void removeProject(int index) {
    setState(() {
      projects.removeAt(index);
    });
    if (projects.isNotEmpty) {
      selectProject(projects[0]);
    } else {
      selectedProject = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
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
                      "Datum: ${selectedProject!.date.toLocal().toString().split(" ")[0]}", // Only show date
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
        projects: projects,
        selectProject: selectProject,
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
                      : PipeListView(pipes: pipes, removePipe: removePipe)),

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
