import 'package:flutter/material.dart';
import 'package:insulation_app/models/insulated_pipe.dart';

class PipeListView extends StatelessWidget {
  final List<InsulatedPipe> pipes;
  final Function(int) removePipe;

  const PipeListView({
    super.key,
    required this.pipes,
    required this.removePipe,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: pipes.length,
      itemBuilder: (context, index) {
        final pipe = pipes[index];
        return Container(
          margin: EdgeInsets.only(
            bottom: index == pipes.length - 1 ? 200.0 : 0.0,
          ),
          child: Card(
            elevation: 2,
            color: Theme.of(context).colorScheme.surface,
            margin: EdgeInsets.only(left: 10, right: 10, top: 16),
            child: ListTile(
              title: Text(
                  style: TextStyle(fontSize: 22), "Rör: ${pipe.size.label}"),
              subtitle: Text(
                  style: TextStyle(fontSize: 18),
                  "Längd: ${pipe.length}m\n"
                  "Första lager: (${pipe.firstLayerMaterial.name}): ${pipe.getFirstLayerArea().ceil()} m², Bunt: ${pipe.getFirstLayerRolls().ceil()}"
                  "${pipe.secondLayerMaterial != null ? "\nAndra lager (${pipe.secondLayerMaterial!.name}): ${pipe.getSecondLayerArea().ceil()} m², Bunt: ${pipe.getSecondLayerRolls().ceil()}" : ""}"),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  removePipe(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
