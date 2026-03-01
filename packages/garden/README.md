# Garden

Transactional data structures for Dart.

## Description

Garden offers data structures to augment Dart primitives and collections with in-memory transaction support.

The primary class is a `Garden`, which allows you to `grow` connected `Leaf` instances. The garden offers methods to `branch`, `commit`, and `revert` all its leaves at once. As leaves are mutated, they record the inverse operation to an undo stack.

Below is a usage example in which a `turn` leaf is tentatively modified, then reverted to a previous state.

```dart
// Create a new garden.
final garden = Garden();

// Grow a connected value, in this case a simple integer.
// All leaves must be created inside a `garden.grow` call.
final turn = garden.grow(() => ValueLeaf(0));

garden.branch();        // Begin tentative execution.
print(turn.value);      // 0

turn.value += 1;        // Perform some mutation(s).
print(turn.value);      // 1

garden.revert();        // Undo everything since the last branch.
print(turn.value);      // 0

// garden.commit();     // Alternatively: store it permanently.
// print(turn.value);   // 1
```

## Leaves

Currently, the following leaves are available:

| Leaf        | Usage                                                                               |
|-------------|-------------------------------------------------------------------------------------|
| `ValueLeaf` | Boxes a primitive value.                                                            |
| `ListLeaf`  | Drop-in `List` replacement.                                                         |
| `SetLeaf`   | Drop-in `Set` replacement.                                                          |
| `MapLeaf`   | Drop-in `Map` replacement.                                                          |
| `RngLeaf`   | Drop-in `Random` replacement, powered by [`chaos`](https://pub.dev/packages/chaos). |

## Serialization

The undo functionality stores function pointers. In other words, **this library cannot serialize its undo stack**. This makes `garden` a great choice for in-memory simulations, but a poor one for use cases that require saving state mid-transaction (e.g. for subsequent continuation).

For serialization of the values themselves, unfortunately `json_serializable` does not support generic classes. [`dogs`](https://pub.dev/packages/dogs_core) is a fantastic alternative that *does*. For fast, transparent serialization, use [`garden_dogs`](https://pub.dev/packages/garden_dogs) and import its `GardenPlugin` into your `dogs` instance.

Note that this still does **not** serialize the undo stack.

## Motivation

I'm an indie game developer building games in Dart and Flutter.

I frequently employ AI self-play to develop mechanics and perform automated balance testing. In this scenario, there's usually a central game database with state operated on by game actions. When an AI searches for moves, it generally needs to make a *lot* of actions from each sub-state.

The naive approach is to serialize the entire game (e.g. to JSON) to clone it, but even a fairly small game can result in extremely poor simulation performance. `garden` allows simulation programs to make small changes - and then revert them just as quickly, enabling the entire empirical game design approach in a Dart ecosystem.
