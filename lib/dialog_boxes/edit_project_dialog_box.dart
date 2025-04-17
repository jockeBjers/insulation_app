import 'package:flutter/material.dart';
import 'package:insulation_app/models/projects/project.dart';
import 'package:insulation_app/dialog_boxes/dialog_form_fields.dart';

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
    await DialogFormFields.openGoogleMaps(addressController.text);
  }

  Future<void> launchCall() async {
    await DialogFormFields.launchPhoneCall(contactNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Redigera projekt"),
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
        submitButtonText: "Spara",
        onSubmit: () {
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
      ),
    );
  }
}
