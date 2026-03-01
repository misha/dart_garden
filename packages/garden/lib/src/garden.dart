import 'dart:async';

import 'package:garden/src/cell.dart';
import 'package:meta/meta.dart';

/// Coordinates transactional mutations across connected [Leaf] instances.
///
/// Mutations recorded while branched can later be [commit]ted or [revert]ed.
class Garden {
  final _history = <Cell>[];
  int _version = 0;

  /// The current branching depth of the garden.
  int get version => _version;

  /// Whether the garden currently has an active branch.
  bool get isBranched => _version > 0;

  /// Runs [task] in this garden's zone and returns its result.
  ///
  /// Leaves must be created inside [grow] so they bind to this garden.
  T grow<T>(T Function() task) {
    return runZoned(task, zoneValues: {#garden: this});
  }

  /// Starts a new branch level for recording reversible mutations.
  void branch() {
    _version += 1;
  }

  /// Commits all pending mutations and clears undo history.
  ///
  /// Must be called only while branched.
  void commit() {
    assert(isBranched);
    _version = 0;
    _history.clear();
  }

  /// Reverts mutations from the current branch level and exits that branch.
  ///
  /// Must be called only while branched.
  void revert() {
    assert(isBranched);
    _version -= 1;

    while (_history.isNotEmpty && _history.last.version > _version) {
      _history.removeLast().undo();
    }
  }
}

/// Mixin for state wrappers that participate in a [Garden].
mixin Leaf {
  @protected
  final Garden garden = Zone.current[#garden];

  /// Records an inverse mutation to support [Garden.revert].
  @protected
  void record(void Function() undo) {
    if (!garden.isBranched) return;
    final cell = Cell(undo, garden._version);
    garden._history.add(cell);
  }
}
