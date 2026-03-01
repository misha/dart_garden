import 'package:meta/meta.dart';

@internal
final class Cell {
  const Cell(this.undo, this.version);

  final void Function() undo;
  final int version;
}
