import 'package:meta/meta.dart';

/// Coordinates transactional mutations across connected [Leaf] instances.
///
/// Mutations recorded while branched can later be [commit]ted or [rollback]ed.
class Garden {
  final _undos = <void Function()>[];
  final _marks = <int>[];

  /// The current branching depth of the garden.
  int get version => _marks.length;

  /// Whether the garden currently has an active branch.
  bool get isBranched => _marks.isNotEmpty;

  /// Adds the [leaf] to this garden.
  ///
  /// A leaf must only be added to exactly one garden.
  T grow<T extends Leaf>(T leaf) {
    return leaf
      ..garden = this
      .._initialized = true;
  }

  /// Starts a new branch level for recording reversible mutations.
  void branch() {
    _marks.add(_undos.length);
  }

  /// Reverts mutations from the current branch level and exits that branch.
  ///
  /// Must be called only while branched.
  void rollback() {
    assert(isBranched);
    final mark = _marks.removeLast();

    for (var at = _undos.length - 1; at >= mark; at -= 1) {
      _undos[at]();
    }

    _undos.length = mark;
  }

  /// Commits all pending mutations and clears undo history.
  ///
  /// Must be called only while branched.
  void commit() {
    assert(isBranched);
    _marks.clear();
    _undos.clear();
  }
}

/// Mixin for state wrappers that participate in a [Garden].
mixin Leaf {
  @protected
  late final Garden garden;
  bool _initialized = false;

  /// Records an inverse mutation to support [Garden.rollback].
  @protected
  void record(void Function() undo) {
    assert(_initialized, 'You must grow this leaf in a garden prior to usage.');
    if (!garden.isBranched) return;
    garden._undos.add(undo);
  }
}
