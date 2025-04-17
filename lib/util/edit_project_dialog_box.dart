import 'package:flutter/material.dart';
import 'package:insulation_app/models/projects/project.dart';
import 'package:url_launcher/url_launcher.dart';

class EditProjectDialog extends StatefulWidget {
  final Project project;
  final Function(Project) onEditProject;

  const EditProjectDialog({
    super.key,
    required this.project,
    required this.onEditProject,
  });

  @override
  State<EditProjectDialog> createState() => _EditProjectDialogState();
}

class _EditProjectDialogState extends State<EditProjectDialog> {
  late TextEditingController projectNumberController;
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController contactPersonController;
  late TextEditingController contactNumberController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    projectNumberController =
        TextEditingController(text: widget.project.projectNumber);
    nameController = TextEditingController(text: widget.project.name);
    addressController =
        TextEditingController(text: widget.project.address ?? '');
    contactPersonController =
        TextEditingController(text: widget.project.contactPerson ?? '');
    contactNumberController =
        TextEditingController(text: widget.project.contactNumber ?? '');
    selectedDate = widget.project.date;
  }

  Future<void> openGoogleMaps() async {
    String address = Uri.encodeComponent(addressController.text);
    String url = "https://www.google.com/maps/search/?api=1&query=$address";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
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
      title: const Text("Redigera projekt"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: projectNumberController,
              decoration: const InputDecoration(labelText: "Projektnummer"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Namn"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Adress",
                suffixIcon: IconButton(
                  icon: Icon(Icons.map,
                      color: Theme.of(context).colorScheme.secondary),
                  onPressed: openGoogleMaps,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactPersonController,
              decoration: const InputDecoration(labelText: "Kontaktperson"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactNumberController,
              decoration: InputDecoration(
                labelText: "Kontaktnummer",
                suffixIcon: IconButton(
                    icon: Icon(Icons.phone_android,
                        color: Theme.of(context).colorScheme.secondary),
                    onPressed: launchCall),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                final ThemeData theme = Theme.of(context);
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2026),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: theme.colorScheme.copyWith(
                          primary: theme.primaryColor,
                          onPrimary: Colors.white,
                          onSurface: Colors.black87,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedDate.toLocal().toString().split(" ")[0],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Avbryt"),
        ),
        ElevatedButton(
          onPressed: () {
            if (projectNumberController.text.isNotEmpty &&
                nameController.text.isNotEmpty) {
              widget.onEditProject(
                Project(
                  id: widget.project.id, // Preserve the existing ID
                  projectNumber: projectNumberController.text,
                  name: nameController.text,
                  address: addressController.text,
                  contactPerson: contactPersonController.text,
                  contactNumber: contactNumberController.text,
                  date: selectedDate,
                  organizationId:
                      widget.project.organizationId, // Include organization ID
                  pipes: widget.project.pipes,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: const Text("Spara"),
        ),
      ],
    );
  }
}
