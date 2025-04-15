import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulation_type/insulation_type.dart';
import 'package:insulation_app/models/pipe_size/pipe_size.dart';

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
          DropdownButtonFormField<PipeSize>(
            value: selectedSize,
            items: pipeSizes.map((size) {
              return DropdownMenuItem<PipeSize>(
                value: size,
                child: Text(size.label),
              );
            }).toList(),
            onChanged: (value) {
              selectedSize = value;
            },
            decoration: const InputDecoration(labelText: "Välj dimensioner"),
          ),

          const SizedBox(height: 10),

          //Pipe Length input
          TextField(
            controller: lengthController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Rör längd (m)"),
          ),

          const SizedBox(height: 10),

          // Material dropdown

          DropdownButtonFormField<InsulationType>(
            value: selectedFirstLayer,
            items: materials.map((mat) {
              return DropdownMenuItem<InsulationType>(
                value: mat,
                child: Text(mat.name),
              );
            }).toList(),
            onChanged: (value) {
              selectedFirstLayer = value;
            },
            decoration: const InputDecoration(labelText: "Första lager"),
          ),

          const SizedBox(height: 10),

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
            onChanged: (value) {
              selectedSecondLayer = value;
            },
            decoration:
                const InputDecoration(labelText: "Andra lager (valfritt)"),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Avbryt")),
        ElevatedButton(
          onPressed: () {
            if (selectedSize != null &&
                selectedFirstLayer != null &&
                lengthController.text.isNotEmpty) {
              double length = double.parse(lengthController.text);
              onAddPipe(selectedSize!, selectedFirstLayer!, selectedSecondLayer,
                  length);
              Navigator.pop(context);
            }
          },
          child: const Text("Lägg till"),
        ),
      ],
    );
  }
}
