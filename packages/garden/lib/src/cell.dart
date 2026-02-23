import 'package:meta/meta.dart';

@internal
final class Cell {
  const Cell(this.undo, this.version);

  final Function undo;
  final int version;
}
