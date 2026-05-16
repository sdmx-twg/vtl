# VTL maintenance scripts

## `validate_example_fixtures.py`

Checks every `vX.Y/docs/reference_manual/operators/**/examples/{*.json,*.csv}` pair:

| Check | Description |
|-------|-------------|
| `header_mismatch` | CSV column names match JSON `components[].name` (or scalar `name`) |
| `integer_decimal_notation` | `Integer` columns must not use `15.0` when `15` is meant |
| `row_column_count` | Each row has the same width as the header (explicit trailing commas) |
| `csv_without_json` | Orphan CSV without a matching `.json` |
| `json_without_csv` | Warning: JSON without `.csv` (error with `--strict`) |

```shell
DOC_VERSION=v2.1 python3 scripts/validate_example_fixtures.py
DOC_VERSION=v2.2 python3 scripts/validate_example_fixtures.py --strict
```

Exit code `1` fails CI.

## `generate_tck_files.py`

Builds `tck/vX.Y.zip` from validated examples. Requires `DOC_VERSION` and a successful validation run is recommended first.

```shell
DOC_VERSION=v2.1 python3 scripts/generate_tck_files.py
```
