import 'package:garden/src/cell.dart';
import 'package:meta/meta.dart';

/// Coordinates transactional mutations across connected [Leaf] instances.
///
/// Mutations recorded while branched can later be [commit]ted or [rollback]ed.
class Garden {
  final _history = <Cell>[];
  int _version = 0;

  /// The current branching depth of the garden.
  int get version => _version;

  /// Whether the garden currently has an active branch.
  bool get isBranched => _version > 0;

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
    _version += 1;
  }

  /// Reverts mutations from the current branch level and exits that branch.
  ///
  /// Must be called only while branched.
  void rollback() {
    assert(isBranched);
    _version -= 1;

    while (_history.isNotEmpty && _history.last.version > _version) {
      _history.removeLast().undo();
    }
  }

  /// Commits all pending mutations and clears undo history.
  ///
  /// Must be called only while branched.
  void commit() {
    assert(isBranched);
    _version = 0;
    _history.clear();
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
    final cell = Cell(undo, garden._version);
    garden._history.add(cell);
  }
}
