import 'package:flutter/material.dart';
import 'package:insulation_app/dialog_boxes/dialog_form_fields.dart';

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
    await DialogFormFields.openGoogleMaps(addressController.text);
  }

  Future<void> launchCall() async {
    await DialogFormFields.launchPhoneCall(contactNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Lägg till projekt"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogFormFields.buildTextField(
              controller: projectNumberController,
              label: "Projektnummer",
            ),
            DialogFormFields.spacer(),
            DialogFormFields.buildTextField(
              controller: nameController,
              label: "Namn",
            ),
            DialogFormFields.spacer(),
            DialogFormFields.buildAddressField(
              controller: addressController,
              context: context,
              onOpenMap: openGoogleMaps,
            ),
            DialogFormFields.spacer(),
            DialogFormFields.buildTextField(
              controller: contactPersonController,
              label: "Kontaktperson",
            ),
            DialogFormFields.spacer(),
            DialogFormFields.buildPhoneField(
              controller: contactNumberController,
              context: context,
              onCallPhone: launchCall,
            ),
            DialogFormFields.spacer(),
            DialogFormFields.buildDatePicker(
              context: context,
              selectedDate: selectedDate,
              onDateChanged: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ],
        ),
      ),
      actions: DialogFormFields.buildDialogButtons(
        context: context,
        submitButtonText: "Lägg till",
        onSubmit: () {
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
      ),
    );
  }
}
