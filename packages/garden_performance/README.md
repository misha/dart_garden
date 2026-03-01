# Garden Performance

Performance benchmarks for `garden` leaf operations.

## Usage

Run all benchmarks:

```bash
rps perftest
```

Run a specific leaf type:

```bash
rps perftest list
```

Run specific operations on a leaf:

```bash
rps perftest map update updateAll
```

The available leaves and their operations are as follows:

| Leaf    | Operations                                                             |
|---------|------------------------------------------------------------------------|
| `value` | `set`                                                                  |
| `list`  | `set`, `add`, `addAll`, `insert`, `insertAll`, `remove`, `removeAt`, `removeRange`, `removeWhere`, `removeWhereSparse`, `removeLast`, `clear` |
| `set`   | `add`, `addAll`, `remove`, `removeAll`, `removeWhere`, `clear`                      |
| `map`   | `set`, `remove`, `update`, `updateAll`, `clear`                        |

## Options

| Flag               | Description                                | Default  |
|--------------------|--------------------------------------------|----------|
| `-n`, `--runs`     | Iterations per test.                       | `100000` |
| `-s`, `--seed`     | RNG seed for reproducible data.            | `12345`  |
| `--save`           | Write results to `performance.json`.       | off      |
| `--save-if-better` | Write results only if total time improved. | off      |

## Comparing Runs

When a `performance.json` file exists, subsequent runs automatically display deltas against it:

```
value set           	6.3 ms    	(+0.1 ms / +2%)
list add            	4.1 ms    	(-0.3 ms / -7%)
===
total               	1457 ms   	(-12.0 ms / -1%)
```
