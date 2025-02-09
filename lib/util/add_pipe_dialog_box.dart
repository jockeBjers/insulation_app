import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulation_type.dart';
import 'package:insulation_app/models/pipe_size.dart';

class AddPipeDialog extends StatelessWidget {
  final Function(PipeSize, InsulationType, double) onAddPipe;

  const AddPipeDialog({super.key, required this.onAddPipe});

  @override
  Widget build(BuildContext context) {
    PipeSize? selectedSize;
    InsulationType? selectedMaterial;
    final TextEditingController lengthController = TextEditingController();

    return AlertDialog(
      title: Text("Add new pipe"),
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
            decoration: InputDecoration(labelText: "Select Pipe Size"),
          ),

          SizedBox(height: 10),

          //Pipe Length input
          TextField(
            controller: lengthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Pipe length (m)"),
          ),

          SizedBox(height: 10),

          // Material dropdown
          DropdownButtonFormField<InsulationType>(
            value: selectedMaterial,
            items: materials.map((mat) {
              return DropdownMenuItem<InsulationType>(
                value: mat,
                child: Text(mat.name),
              );
            }).toList(),
            onChanged: (value) {
              selectedMaterial = value;
            },
            decoration: InputDecoration(labelText: "select Material"),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            if (selectedSize != null &&
                selectedMaterial != null &&
                lengthController.text.isNotEmpty) {
              double length = double.parse(lengthController.text);
              onAddPipe(selectedSize!, selectedMaterial!, length);
              Navigator.pop(context);
            }
          },
          child: Text("Add"),
        ),
      ], 
    );
  }
}
