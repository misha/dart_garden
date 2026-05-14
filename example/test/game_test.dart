import 'package:tictactoe/game.dart';
import 'package:tictactoe/objects/entity.dart';
import 'package:tictactoe/objects/result.dart';
import 'package:test/test.dart';

void main() {
  final x = Player(.x);
  final o = Player(.o);

  test('simulation', () {
    final game = Game.initial();
    game.place(x, .new(0, 0));
    game.place(o, .new(0, 2));
    game.place(x, .new(2, 2));
    game.place(o, .new(2, 0));
    expect(game.isOver, isFalse);

    game.simulate(() {
      game.place(x, .new(1, 1));
      expect(game.isOver, isTrue);
      expect(game.result, Result.win(x));
    });

    expect(game.isOver, isFalse);

    game.simulate(() {
      game.place(x, .new(0, 1));
      game.place(o, .new(1, 1));
      expect(game.isOver, isTrue);
      expect(game.result, Result.win(o));
    });

    expect(game.isOver, isFalse);
  });

  test('serialization', () {
    final game = Game.initial();
    game.place(x, .new(0, 0));
    game.place(o, .new(1, 0));
    game.place(x, .new(1, 1));
    game.place(o, .new(2, 0));
    game.place(x, .new(2, 2));

    final save = game.save().toJson();

    expect(save['serial'], 6);
    expect(save['turn'], 4);
    expect(save['result'], isNotNull);
    expect((save['contents'] as List).length, 5);
    expect((save['owners'] as List).length, 5);

    final loaded = Game.load(.new(.fromJson(save)));
    expect(loaded.turn, game.turn);
    expect(loaded.result, game.result);
    expect(loaded.getContents(.new(0, 0)), isNotNull);
    expect(loaded.getContents(.new(1, 0)), isNotNull);
    expect(loaded.getContents(.new(1, 1)), isNotNull);
    expect(loaded.getContents(.new(2, 0)), isNotNull);
    expect(loaded.getContents(.new(2, 2)), isNotNull);
    expect(loaded.result, Result.win(x));
  });
}
