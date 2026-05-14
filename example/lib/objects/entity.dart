import 'package:tictactoe/objects/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
sealed class Entity with _$Entity {
  const Entity._();

  const factory Entity.player(Token token) = Player;
  const factory Entity.piece(int id) = Piece;

  factory Entity.fromJson(Map<String, Object?> json) => _$EntityFromJson(json);
}
