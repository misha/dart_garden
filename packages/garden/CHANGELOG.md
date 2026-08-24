# Changelog

## 3.0.1

- Fixed a bug in `RngLeaf` causing it to fail to revert in branches of depth >1.
- Improved performance of all leaves by removing the internal `Cell` class.
- Added fast paths to allocating operations when unbranched.
- Added unbranched, search, and burst-style performance tests for realistic workload measurement.

## 3.0.0

- Each leaf must now be grown individually; no magic `Zone`-backed storage.
- `revert` renamed to `rollback` to match database transaction vocabulary.
- Remove `dogs` integration and mark the package discontinued.

## 2.1.2

- Reduced the `meta` dependency version requirement to `^1.17.0`.

## 2.1.1

- Optimize `clear` performance for `ListLeaf`, `SetLeaf`, `MapLeaf`, and `RelationLeaf`.

## 2.1.0

- Implements a `RelationLeaf` with supports for 1-1, 1-N, N-1, and N-1 relationships.

## 2.0.0

- Implements an `RngLeaf` using the `chaos` package.
- Adds various tests and scripts.
- Overhauls the README.md.

## 1.2.0

- Fill in remaining, unimplemented mutations in `ListLeaf`, `SetLeaf`, and `MapLeaf`.
- Perform optimization for the newly implemented mutations.
- Update README.md.

## 1.1.1

- Performance optimizations.

## 1.1.0

- Fixed several bugs in `ListLeaf`, `SetLeaf`, and `MapLeaf`.
- Implemented basic performance testing.
- Performed basic code optimization for all leaves and all implemented operations.

## 1.0.0

- Initial release.
- Added branching, commit, and revert support through `Garden`.
- Added built-in leaf types: `ValueLeaf`, `ListLeaf`, `SetLeaf`, and `MapLeaf`.
