import 'package:hive/hive.dart';
import 'package:insulation_app/models/insulated_pipe.dart';

part 'project.g.dart';

@HiveType(typeId: 0)
class Project extends HiveObject {
  @HiveField(0)
  String projectNumber;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  List<InsulatedPipe> pipes;

  @HiveField(4)
  String address;

  @HiveField(5)
  String contactPerson;

  @HiveField(6)
  String contactNumber;

  Project(
      {required this.projectNumber,
      required this.name,
      required this.date,
      required this.pipes,
      this.address = "",
      this.contactPerson = "",
      this.contactNumber = ""});
}
