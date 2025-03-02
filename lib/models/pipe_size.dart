import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'pipe_size.g.dart';

@HiveType(typeId: 3)
class PipeSize extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String label;

  @HiveField(1)
  final double diameter;

  PipeSize(this.label, this.diameter);

  @override
  List<Object> get props => [label, diameter];
}

final List<PipeSize> pipeSizes = [
  PipeSize("100 mm", 0.1),
  PipeSize("125 mm", 0.125),
  PipeSize("165 mm", 0.165),
  PipeSize("200 mm", 0.2),
  PipeSize("250 mm", 0.25),
  PipeSize("315 mm", 0.315),
  PipeSize("400 mm", 0.4),
  PipeSize("500 mm", 0.5),
  PipeSize("630 mm", 0.63),
  PipeSize("800 mm", 0.8),
];
