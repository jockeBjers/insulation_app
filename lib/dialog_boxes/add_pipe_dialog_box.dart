import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulation_type/insulation_type.dart';
import 'package:insulation_app/models/pipe_size/pipe_size.dart';
import 'package:insulation_app/dialog_boxes/dialog_form_fields.dart';

class AddPipeDialog extends StatelessWidget {
  final Function(PipeSize, InsulationType, InsulationType?, double) onAddPipe;

  const AddPipeDialog({super.key, required this.onAddPipe});

  @override
  Widget build(BuildContext context) {
    PipeSize? selectedSize;
    InsulationType? selectedFirstLayer;
    InsulationType? selectedSecondLayer;
    final TextEditingController lengthController = TextEditingController();

    return AlertDialog(
      title: const Text("Lägg till"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pipe size dropdown
          DialogFormFields.buildPipeSizeDropdown(
            value: selectedSize,
            onChanged: (value) {
              selectedSize = value;
            },
          ),

          DialogFormFields.spacer(),

          DialogFormFields.buildLengthField(
            controller: lengthController,
          ),

          DialogFormFields.spacer(),

          DialogFormFields.buildFirstLayerDropdown(
            value: selectedFirstLayer,
            onChanged: (value) {
              selectedFirstLayer = value;
            },
          ),

          DialogFormFields.spacer(),

          DialogFormFields.buildSecondLayerDropdown(
            value: selectedSecondLayer,
            onChanged: (value) {
              selectedSecondLayer = value;
            },
          ),
        ],
      ),
      actions: DialogFormFields.buildDialogButtons(
        context: context,
        submitButtonText: "Lägg till",
        onSubmit: () {
          if (selectedSize != null &&
              selectedFirstLayer != null &&
              lengthController.text.isNotEmpty) {
            double length = double.parse(lengthController.text);
            onAddPipe(selectedSize!, selectedFirstLayer!, selectedSecondLayer,
                length);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
