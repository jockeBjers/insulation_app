import 'package:flutter/material.dart';

import 'package:insulation_app/models/insulated_pipe.dart';
import 'package:insulation_app/models/project.dart';
import 'package:insulation_app/util/add_pipe_dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Project> projects = [
    Project(
      projectNumber: "13524",
      name: "Siemens",
      date: DateTime(2025, 2, 13),
      pipes: [],
    ),
    Project(
      projectNumber: "12343",
      name: "Häktet",
      date: DateTime(2025, 2, 13),
      pipes: [],
    ),
    Project(
      projectNumber: "34562",
      name: "Hagaskolan",
      date: DateTime(2025, 1, 23),
      pipes: [],
    ),
  ];

  late Project selectedProject;

  _HomePageState() {
    selectedProject = projects[0];
  }
  List<InsulatedPipe> get pipes => selectedProject.pipes;

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

    for (var pipe in pipes) {
      switch (pipe.firstLayerMaterial.insulationThickness) {
        case 0.03:
          newTotal30 += pipe.getFirstLayerArea();
          break;
        case 0.05:
          newTotal50 += pipe.getFirstLayerArea();
          break;
        case 0.08:
          newTotal80 += pipe.getFirstLayerArea();
          break;
      }
      switch (pipe.secondLayerMaterial?.insulationThickness) {
        case 0.03:
          newTotal30 += pipe.getSecondLayerArea();
          break;
        case 0.05:
          newTotal50 += pipe.getSecondLayerArea();
          break;
        case 0.08:
          newTotal80 += pipe.getSecondLayerArea();
          break;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedProject.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Projektnummer: ${selectedProject.projectNumber}",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Datum: ${selectedProject.date.toLocal().toString().split(" ")[0]}", // Only show date
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      // Drawer
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Projekt',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            for (var project in projects)
              Card(
                child: ListTile(
                  title: Text(" ${project.projectNumber} - ${project.name}"),
                  onTap: () {
                    selectProject(project);
                    Navigator.pop(context);
                  },
                ),
              ),
          ],
        ),
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
                    : pipeListView(),
              ),

              // Summary view
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(155, 158, 158, 158).withValues(),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total 30mm: ${total30.ceil()} m²",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Total 50mm: ${total50.ceil()} m²",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Total 80mm: ${total80.ceil()} m²",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ), // end container
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

  ListView pipeListView() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: pipes.length,
      itemBuilder: (context, index) {
        final pipe = pipes[index];
        return Container(
          margin: EdgeInsets.only(
            bottom: index == pipes.length - 1 ? 200.0 : 0.0,
          ),
          child: Card(
            elevation: 2,
            color: Theme.of(context).colorScheme.surface,
            margin: EdgeInsets.only(left: 10, right: 10, top: 16),
            child: ListTile(
              title: Text(
                  style: TextStyle(fontSize: 22), "Rör: ${pipe.size.label}"),
              subtitle: Text(
                  style: TextStyle(fontSize: 18),
                  "Längd: ${pipe.length}m\n"
                  "Första lager: (${pipe.firstLayerMaterial.name}): ${pipe.getFirstLayerArea().ceil()} m², Bunt: ${pipe.getFirstLayerRolls().ceil()}"
                  "${pipe.secondLayerMaterial != null ? "\nAndra lager (${pipe.secondLayerMaterial!.name}): ${pipe.getSecondLayerArea().ceil()} m², Bunt: ${pipe.getSecondLayerRolls().ceil()}" : ""}" /* "${pipe.firstLayerMaterial == pipe.secondLayerMaterial ? "\nTotal: ${pipe.getTotalArea().ceil()} m², Bunt: ${pipe.getTotalRolls().ceil()}" : ""}" */),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  removePipe(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
