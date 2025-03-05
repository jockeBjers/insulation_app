import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AddProjectDialog extends StatefulWidget {
  final Function(String, String, String, String, String, DateTime) onAddProject;

  const AddProjectDialog({super.key, required this.onAddProject});

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  final TextEditingController projectNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void openGoogleMaps() async {
    String address = Uri.encodeComponent(addressController.text);
    String url = "https://www.google.com/maps/search/?api=1&query=$address";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchCall() async {
    String phoneNumber = contactNumberController.text;
    final Uri urlParsed = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      throw 'Could not launch call to: $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
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
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: "Adress",
              suffixIcon: IconButton(
                icon: Icon(Icons.map),
                onPressed: openGoogleMaps,
              ),
            ),
          ),
          TextField(
            controller: contactPersonController,
            decoration: InputDecoration(labelText: "Kontaktperson"),
          ),
          TextField(
            controller: contactNumberController,
            decoration: InputDecoration(
              labelText: "Kontaktnummer",
              suffixIcon: IconButton(
                  icon: Icon(Icons.phone_android), onPressed: launchCall),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Datum: ${selectedDate.toLocal().toString().split(" ")[0]}"),
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
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Avbryt"),
        ),
        ElevatedButton(
          onPressed: () {
            if (projectNumberController.text.isNotEmpty &&
                nameController.text.isNotEmpty &&
                addressController.text.isNotEmpty) {
              widget.onAddProject(
                projectNumberController.text,
                nameController.text,
                addressController.text,
                contactPersonController.text,
                contactNumberController.text,
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
