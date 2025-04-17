import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulation_type/insulation_type.dart';
import 'package:insulation_app/models/pipe_size/pipe_size.dart';
import 'package:insulation_app/dialog_boxes/dialog_form_fields.dart';

class EditPipeDialog extends StatelessWidget {
  final PipeSize initialSize;
  final InsulationType initialFirstLayer;
  final InsulationType? initialSecondLayer;
  final double initialLength;
  final Function(PipeSize, InsulationType, InsulationType?, double) onEditPipe;

  const EditPipeDialog({
    super.key,
    required this.initialSize,
    required this.initialFirstLayer,
    required this.initialSecondLayer,
    required this.initialLength,
    required this.onEditPipe,
  });

  @override
  Widget build(BuildContext context) {
    PipeSize selectedSize = initialSize;
    InsulationType selectedFirstLayer = initialFirstLayer;
    InsulationType? selectedSecondLayer = initialSecondLayer;
    final TextEditingController lengthController =
        TextEditingController(text: initialLength.toString());

    return AlertDialog(
      title: const Text("Redigera rör"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogFormFields.buildPipeSizeDropdown(
              value: selectedSize,
              onChanged: (value) => selectedSize = value!,
            ),
            DialogFormFields.spacer(),
            DialogFormFields.buildLengthField(
              controller: lengthController,
            ),
            DialogFormFields.spacer(),
            DialogFormFields.buildFirstLayerDropdown(
              value: selectedFirstLayer,
              onChanged: (value) => selectedFirstLayer = value!,
            ),
            DialogFormFields.spacer(),
            DialogFormFields.buildSecondLayerDropdown(
              value: selectedSecondLayer,
              onChanged: (value) => selectedSecondLayer = value,
            ),
          ],
        ),
      ),
      actions: DialogFormFields.buildDialogButtons(
        context: context,
        submitButtonText: "Spara",
        onSubmit: () {
          double length = double.parse(lengthController.text);
          onEditPipe(
              selectedSize, selectedFirstLayer, selectedSecondLayer, length);
          Navigator.pop(context);
        },
      ),
    );
  }
}
