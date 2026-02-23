import 'dart:async';

import 'package:garden/src/cell.dart';
import 'package:meta/meta.dart';

/// Coordinates transactional mutations across connected [Leaf] instances.
///
/// Mutations recorded while branched can later be [commit]ted or [revert]ed.
class Garden {
  @protected
  final history = <Cell>[];

  @protected
  int version = 0;

  /// Whether the garden currently has an active branch.
  bool get isBranched => version > 0;

  /// Runs [task] in this garden's zone and returns its result.
  ///
  /// Leaves must be created inside [grow] so they bind to this garden.
  T grow<T>(T Function() task) {
    return runZoned(task, zoneValues: {#garden: this});
  }

  /// Starts a new branch level for recording reversible mutations.
  void branch() {
    version += 1;
  }

  /// Commits all pending mutations and clears undo history.
  ///
  /// Must be called only while branched.
  void commit() {
    assert(isBranched);
    version = 0;
    history.clear();
  }

  /// Reverts mutations from the current branch level and exits that branch.
  ///
  /// Must be called only while branched.
  void revert() {
    assert(isBranched);
    version -= 1;

    while (history.isNotEmpty && history.last.version > version) {
      history.removeLast().undo();
    }
  }
}

/// Mixin for state wrappers that participate in a [Garden].
mixin Leaf {
  @protected
  final Garden garden = Zone.current[#garden];

  /// Records an inverse mutation to support [Garden.revert].
  @protected
  void record(Function undo) {
    if (!garden.isBranched) return;
    final cell = Cell(undo, garden.version);
    garden.history.add(cell);
  }
}
