# Garden

The branching data structure library for Dart.

## Description

Garden offers data structures to augment Dart primitives and collections with in-memory change tracking. The primary class is a `Garden`, which allows you to grow connected `Leaf` instances.

```dart
// Create a new garden.
final garden = Garden();

// Grow a connected value, in this case a simple integer.
// All leaves must be created inside a `garden.grow` call.
final turn = garden.grow(() => ValueLeaf(0));
```

The garden offers operations to `branch`, `commit`, and `revert` its leaves. As leaves are mutated, they record the inverse operation to an undo stack.

```dart
garden.branch();        // Begin tentative execution.
print(turn.value);      // 0

turn.value += 1;        // Perform some mutation(s).
print(turn.value);      // 1

garden.revert();        // Undo everything since the last branch.
print(turn.value);      // 0

// garden.commit();     // Alternatively: store it permanently.
// print(turn.value);   // 1
```

## Leaf Implementations

Currently, the following leaves are available:

| Leaf        | Usage                       |
|-------------|-----------------------------|
| `ValueLeaf` | Boxes a primitive value.    |
| `ListLeaf`  | Drop-in `List` replacement. |
| `SetLeaf`   | Drop-in `Set` replacement.  |
| `MapLeaf`   | Drop-in `Map` replacement.  |

Note that not all operations are implemented yet, especially things like `removeAll`, `removeWhere`, etc. If you run into an `UnimplementedError`, feel free to open an issue or a PR and we'll get it done.

Lastly, all private fields of `Garden` and `Leaf` are marked `@protected` if you would like to extend the garden or implement your own leaf types, e.g. an `RngLeaf` powered by [`chaos`](https://pub.dev/packages/chaos).

## Serialization

The undo functionality stores function pointers, minimizing allocations at the cost of serialization. This makes `garden` a good choice for in-memory simulations, but a poor one for use cases that require saving the undo stack to disk for subsequent continuation.

For serialization of the values themselves, unfortunately `json_serializable` does not support generic classes. `dogs` is a fantastic alternative that does. For fast, transparent serialization, use `garden_dogs` and import its `GardenPlugin` into your [`dogs`](https://pub.dev/packages/dogs) instance.

Note that this still does *not* serialize the undo stack.

## Motivation

I'm an indie game developer building games in Dart and Flutter.

I frequently employ AI self-play to develop mechanics and perform automated balance testing. In this scenario, there's usually a central game database with state operated on by game actions. When an AI searches for moves, it generally needs to make a *lot* of actions from each sub-state.

The naive approach is to serialize the entire game (e.g. to JSON) to clone it, but even a fairly small game can result in extremely poor simulation performance. `garden` allows simulation programs to make small changes - and then revert them just as quickly, enabling the entire empirical game design approach in a Dart ecosystem.
