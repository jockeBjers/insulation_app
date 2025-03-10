import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insulation_app/models/project.dart';

class CustomDrawer extends StatelessWidget {
  final Function(Project) selectProject;
  final Function(Project) editProject;
  final Function(int) removeProject;
  final VoidCallback showAddProjectDialog;

  const CustomDrawer({
    super.key,
    required this.selectProject,
    required this.editProject,
    required this.removeProject,
    required this.showAddProjectDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ValueListenableBuilder(
        valueListenable: Hive.box<Project>('projects').listenable(),
        builder: (context, Box<Project> box, _) {
          final projects = box.values.toList().cast<Project>();

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: projects.length +
                2, // +1 for the add project tile and +1 for the DrawerHeader
            itemBuilder: (context, index) {
              if (index == 0) {
                return DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      'Projekt',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              } else if (index == projects.length + 1) {
                return ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Lägg till projekt"),
                  onTap: () async {
                    Navigator.pop(context);
                    await Future.delayed(Duration(milliseconds: 300));
                    showAddProjectDialog();
                  },
                );
              } else {
                final projectIndex = index - 1;
                return Card(
                  child: ListTile(
                    title: Text(
                        " ${projects[projectIndex].projectNumber} - ${projects[projectIndex].name}"),
                    onTap: () {
                      selectProject(projects[projectIndex]);
                      Navigator.pop(context);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            editProject(projects[projectIndex]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeProject(projectIndex);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
