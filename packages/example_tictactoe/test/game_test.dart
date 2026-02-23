import 'package:dogs_core/dogs_core.dart';
import 'package:example_tictactoe/dogs.g.dart';
import 'package:example_tictactoe/game.dart';
import 'package:example_tictactoe/result.dart';
import 'package:garden_dogs/garden_dogs.dart';
import 'package:test/test.dart';

void main() {
  configureDogs(
    plugins: [
      GeneratedModelsPlugin(),
      GardenPlugin(),
    ],
  );

  test('gameplay', () {
    final game = TicTacToe.initial();
    game.place(.x, .new(0, 0));
    game.place(.o, .new(0, 2));
    game.place(.x, .new(2, 2));
    game.place(.o, .new(2, 0));
    expect(game.isOver, isFalse);

    game.simulate(() {
      game.place(.x, .new(1, 1));
      expect(game.isOver, isTrue);
      expect(game.result, Win(.x));
    });

    expect(game.isOver, isFalse);

    game.simulate(() {
      game.place(.x, .new(0, 1));
      game.place(.o, .new(1, 1));
      expect(game.isOver, isTrue);
      expect(game.result, Win(.o));
    });

    expect(game.isOver, isFalse);
  });

  test('serialization', () {
    final game = TicTacToe.initial();
    game.place(.x, .new(0, 0));
    game.place(.o, .new(1, 0));
    game.place(.x, .new(1, 1));
    game.place(.o, .new(2, 0));
    game.place(.x, .new(2, 2));

    final dump = game.dump();

    expect(dump['serial'], 5);
    expect(dump['turn'], 4);
    expect(dump['result'], isNotNull);
    expect((dump['contents'] as List).length, 5);
    expect((dump['owners'] as List).length, 5);

    final loaded = TicTacToe.load(dump);
    expect(loaded.turn, game.turn);
    expect(loaded.result, game.result);
    expect(loaded.contents(.new(0, 0)), isNotNull);
    expect(loaded.contents(.new(1, 0)), isNotNull);
    expect(loaded.contents(.new(1, 1)), isNotNull);
    expect(loaded.contents(.new(2, 0)), isNotNull);
    expect(loaded.contents(.new(2, 2)), isNotNull);
    expect(loaded.result, Win(.x));
  });
}
