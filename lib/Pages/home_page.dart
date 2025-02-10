import 'package:flutter/material.dart';

import 'package:insulation_app/models/insulated_pipe.dart';
import 'package:insulation_app/util/add_pipe_dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<InsulatedPipe> pipes = [];
  
  void showAddPipeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddPipeDialog(
          onAddPipe: (selectedSize, firstLayer, secondLayer, length) {
            setState(() {
              pipes.add(InsulatedPipe(
                size: selectedSize,
                length: length,
                firstLayerMaterial: firstLayer,
                secondLayerMaterial: secondLayer, 
              ));
            });
          },
        );
      },
    );
  }

  void removePipe(int index) {
    setState(() {
      pipes.removeAt(index);
    });
  }

  // Summary
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(style: TextStyle(fontSize: 25), "Insulation Calculator")),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              // List of pipes
              Expanded(
                child: pipes.isEmpty
                    ? Center(child: Text("No pipes in the list"))
                    : pipeListView(),
              ),

              // Summary view
              Column(

              
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddPipeDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  ListView pipeListView() {
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
                "Första lager: (${pipe.firstLayerMaterial!.name}): ${pipe.getFirstLayerArea().ceil()} m², Bunt: ${pipe.getFirstLayerRolls().ceil()}\n"
                "${pipe.secondLayerMaterial != null ? "Andra lager (${pipe.secondLayerMaterial!.name}): ${pipe.getSecondLayerArea().ceil()} m², Bunt: ${pipe.getSecondLayerRolls().ceil()}" : ""}",
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
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
