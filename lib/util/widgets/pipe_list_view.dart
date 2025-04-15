import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulated_pipes/insulated_pipe.dart';

class PipeListView extends StatelessWidget {
  final List<InsulatedPipe> pipes;
  final Function(int) removePipe;
  final Function({required InsulatedPipe pipe, required int index}) editPipe;

  const PipeListView({
    super.key,
    required this.pipes,
    required this.removePipe,
    required this.editPipe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: pipes.length,
      itemBuilder: (context, index) {
        final pipe = pipes[index];
        return Container(
          margin: EdgeInsets.only(
            bottom: index == pipes.length - 1 ? 200.0 : 0.0,
          ),
          child: Card(
            elevation: 2,
            color: theme.colorScheme.surface,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Rör: ${pipe.size.label}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue[700]),
                      onPressed: () {
                        editPipe(pipe: pipe, index: index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red[700]),
                      onPressed: () {
                        removePipe(index);
                      },
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Längd: ${pipe.length}m\n"
                    "Första lager: (${pipe.firstLayerMaterial.name}): ${pipe.getFirstLayerArea().ceil()} m², Bunt: ${pipe.getFirstLayerRolls().ceil()}"
                    "${pipe.secondLayerMaterial != null ? "\nAndra lager (${pipe.secondLayerMaterial!.name}): ${pipe.getSecondLayerArea().ceil()} m², Bunt: ${pipe.getSecondLayerRolls().ceil()}" : ""}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
