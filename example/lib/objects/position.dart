import 'package:freezed_annotation/freezed_annotation.dart';

part 'position.freezed.dart';
part 'position.g.dart';

@freezed
abstract class Position with _$Position {
  const factory Position(int x, int y) = _Position;

  factory Position.fromJson(Map<String, Object?> json) => _$PositionFromJson(json);
}
