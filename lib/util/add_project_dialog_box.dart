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
      title: const Text("Lägg till projekt"),
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
          child: const Text("Lägg till"),
        ),
      ],
    );
  }
}
