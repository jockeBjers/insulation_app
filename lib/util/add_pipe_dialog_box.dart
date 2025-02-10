import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulation_type.dart';
import 'package:insulation_app/models/pipe_size.dart';
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
      title: Text("Lägg till"),
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
            decoration: InputDecoration(labelText: "Välj dimensioner"),
          ),

          SizedBox(height: 10),

          //Pipe Length input
          TextField(
            controller: lengthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Rör längd (m)"),
          ),

          SizedBox(height: 10),

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
            decoration: InputDecoration(labelText: "Första lager"),
          ),

          DropdownButtonFormField<InsulationType?>(
            value: selectedSecondLayer,
            items: [
              DropdownMenuItem<InsulationType?>(
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
                InputDecoration(labelText: "Andra lager (valfritt)"),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Avbryt")),
        ElevatedButton(
          onPressed: () {
            if (selectedSize != null &&
                selectedFirstLayer != null &&
                lengthController.text.isNotEmpty) {
              double length = double.parse(lengthController.text);
              onAddPipe(selectedSize!, selectedFirstLayer!,
                  selectedSecondLayer, length);
              Navigator.pop(context);
            }
          },
          child: Text("Lägg till"),
        ),
      ],
    );
  }
}
