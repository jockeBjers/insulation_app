import 'package:hive/hive.dart';
import 'package:insulation_app/models/pipe_size.dart';
import 'package:insulation_app/models/insulation_type.dart';
import 'package:insulation_app/models/project.dart';

void registerAdapters() {
  Hive.registerAdapter(PipeSizeAdapter());
  Hive.registerAdapter(InsulationTypeAdapter());
	Hive.registerAdapter(ProjectAdapter());
}
