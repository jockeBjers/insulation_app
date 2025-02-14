import 'package:flutter/material.dart';

class AddProjectDialog extends StatelessWidget {
  final Function(String, String, DateTime) onAddProject;
  const AddProjectDialog({super.key, required this.onAddProject});

  @override
  Widget build(BuildContext context) {
    final TextEditingController projectNumberController =
        TextEditingController();
    final TextEditingController nameController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    return AlertDialog(
      title: const Text("Lägg till projekt"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: projectNumberController,
            decoration: const InputDecoration(labelText: "Projektnummer"),
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Namn"),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text("datum: ${selectedDate.toLocal().toString().split(" ")[0]}"),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2026),
                  );
                  if (picked != null && picked != selectedDate) {
                    selectedDate = picked;
                  }
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(
            context,
          ),
          child: const Text("Avbryt"),
        ),
        ElevatedButton(
          onPressed: () {
            if (projectNumberController.text.isNotEmpty &&
                nameController.text.isNotEmpty) {
              onAddProject(
                projectNumberController.text,
                nameController.text,
                selectedDate,
              );
              Navigator.pop(context);
            }
          },
          child: Text("Lägg till"),
        ),
      ],
    );
  }
}
