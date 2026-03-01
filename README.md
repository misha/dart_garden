# Garden Monorepo

Monorepo for the `garden` Dart ecosystem.

The main package documentation can be found [here](packages/garden).

## Packages

| Package                                             | Description                                |
|-----------------------------------------------------|--------------------------------------------|
| [`garden`](packages/garden)                         | Transactional data structures for Dart.    |
| [`garden_dogs`](packages/garden_dogs)               | `dogs` serialization support for `garden`. |
| [`garden_performance`](packages/garden_performance) | Performance benchmarks for `garden`.       |
| [`example_tictactoe`](packages/example_tictactoe)   | Tic-Tac-Toe example built on `garden`.     |

## Development

| Command           | Description                                        |
|-------------------|----------------------------------------------------|
| `melos bootstrap` | Synchronize dependencies across packages.          |
| `melos test`      | Run automated tests in packages with tests.        |
| `melos build`     | Run `build_runner` once where configured.          |
| `melos watch`     | Run `build_runner` in watch mode where configured. |

## Getting Started

Set up `melos`:

```bash
dart pub global activate melos
```

Launch with Code:

```bash
code main.code-workspace
```
