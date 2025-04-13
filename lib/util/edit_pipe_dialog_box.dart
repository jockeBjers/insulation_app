import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulation_type/insulation_type.dart';
import 'package:insulation_app/models/pipe_size/pipe_size.dart';

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
            // Pipe size dropdown
            DropdownButtonFormField<PipeSize>(
              value: selectedSize,
              items: pipeSizes.map((size) {
                return DropdownMenuItem<PipeSize>(
                  value: size,
                  child: Text(size.label),
                );
              }).toList(),
              onChanged: (value) => selectedSize = value!,
              decoration: const InputDecoration(labelText: "Välj dimensioner"),
            ),

            const SizedBox(height: 10),

            // Pipe Length input
            TextFormField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Rör längd (m)"),
            ),

            const SizedBox(height: 10),

            // First Layer Material dropdown
            DropdownButtonFormField<InsulationType>(
              value: selectedFirstLayer,
              items: materials.map((mat) {
                return DropdownMenuItem<InsulationType>(
                  value: mat,
                  child: Text(mat.name),
                );
              }).toList(),
              onChanged: (value) => selectedFirstLayer = value!,
              decoration: const InputDecoration(labelText: "Första lager"),
            ),

            const SizedBox(height: 10),
            // Second Layer Material dropdown
            DropdownButtonFormField<InsulationType?>(
              value: selectedSecondLayer,
              items: [
                const DropdownMenuItem<InsulationType?>(
                  value: null,
                  child: Text("Inget andra lager"),
                ),
                ...materials.map((mat) {
                  return DropdownMenuItem<InsulationType?>(
                    value: mat,
                    child: Text(mat.name),
                  );
                }),
              ],
              onChanged: (value) => selectedSecondLayer = value,
              decoration:
                  const InputDecoration(labelText: "Andra lager (valfritt)"),
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
            double length = double.parse(lengthController.text);
            onEditPipe(
                selectedSize, selectedFirstLayer, selectedSecondLayer, length);
            Navigator.pop(context);
          },
          child: const Text("Spara"),
        ),
      ],
    );
  }
}
