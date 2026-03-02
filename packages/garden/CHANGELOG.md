# Changelog

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
