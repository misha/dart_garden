import 'package:dogs_core/dogs_core.dart';

@serializable
class Position with Dataclass<Position> {
  Position(this.x, this.y);

  final int x;
  final int y;
}
