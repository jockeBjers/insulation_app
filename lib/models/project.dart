import 'package:insulation_app/models/insulated_pipe.dart';

class Project {
  final String projectNumber;
  final String name;
  final DateTime date;
  final List<InsulatedPipe> pipes;

  Project({
    required this.projectNumber,
    required this.name,
    required this.date,
    required this.pipes,
  });
}
