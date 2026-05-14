import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/objects/entity.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed
sealed class Result with _$Result {
  const factory Result.win(Player winner) = WinResult;
  const factory Result.draw() = DrawResult;

  factory Result.fromJson(Map<String, Object?> json) => _$ResultFromJson(json);
}
