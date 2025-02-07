import 'package:insulation_app/models/insulation_type.dart';
import 'package:insulation_app/models/pipe_size.dart';
import 'package:insulation_app/util/insulation_calculator';

/// Pipe Model
class InsulatedPipe {
  final PipeSize size;
  final double length;
  final InsulationType material;

  InsulatedPipe({
    required this.size,
    required this.length,
    required this.material,
  });

}
