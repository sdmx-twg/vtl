#!/usr/bin/env python3
"""
Validate reference-manual operator examples: JSON structure metadata vs CSV data.

Designed to catch issues before TCK zip generation or doc builds (e.g. INTEGER
columns written as "15.0", CSV headers not matching component names, row width
mismatches). Aligns with strict CSV loaders used by conformance harnesses.

Usage:
    DOC_VERSION=v2.1 python3 scripts/validate_example_fixtures.py
    DOC_VERSION=v2.2 python3 scripts/validate_example_fixtures.py --strict

Exit codes:
    0 — no errors (warnings allowed unless --strict)
    1 — validation errors
    2 — invalid environment / missing doc tree
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import sys
from dataclasses import dataclass
from enum import Enum
from pathlib import Path
from typing import Iterator


class Severity(Enum):
    ERROR = "error"
    WARNING = "warning"


class IssueCode(Enum):
    HEADER_MISMATCH = "header_mismatch"
    INTEGER_DECIMAL = "integer_decimal_notation"
    ROW_WIDTH = "row_column_count"
    JSON_WITHOUT_CSV = "json_without_csv"
    CSV_WITHOUT_JSON = "csv_without_json"
    INVALID_JSON = "invalid_json"
    EMPTY_DATA = "empty_csv_data"


@dataclass(frozen=True)
class Issue:
    severity: Severity
    code: IssueCode
    path: Path
    message: str
    line: int | None = None

    def format(self, base: Path | None = None) -> str:
        location = str(self.path)
        if base is not None:
            try:
                location = str(self.path.relative_to(base))
            except ValueError:
                pass
        suffix = f":{self.line}" if self.line is not None else ""
        return f"{location}{suffix} [{self.code.value}] {self.message}"


@dataclass
class StructureSpec:
    name: str
    columns: list[str]
    integer_columns: list[str]
    kind: str  # "dataset" | "scalar"


def parse_structure(json_path: Path, data: object) -> StructureSpec | Issue:
    if not isinstance(data, dict):
        return Issue(
            Severity.ERROR,
            IssueCode.INVALID_JSON,
            json_path,
            "root must be a JSON object",
        )

    name = str(data.get("name") or json_path.stem)
    components = data.get("components")

    if components is None:
        if "name" in data and "type" in data:
            scalar_name = str(data["name"])
            return StructureSpec(
                name=name,
                columns=[scalar_name],
                integer_columns=(
                    [scalar_name]
                    if str(data.get("type", "")).lower() == "integer"
                    else []
                ),
                kind="scalar",
            )
        return Issue(
            Severity.ERROR,
            IssueCode.INVALID_JSON,
            json_path,
            'expected "components" array or scalar shape {"name", "type"}',
        )

    if not isinstance(components, list):
        return Issue(
            Severity.ERROR,
            IssueCode.INVALID_JSON,
            json_path,
            '"components" must be an array',
        )

    columns: list[str] = []
    integer_columns: list[str] = []
    for index, component in enumerate(components):
        if not isinstance(component, dict):
            return Issue(
                Severity.ERROR,
                IssueCode.INVALID_JSON,
                json_path,
                f"components[{index}] must be an object",
            )
        col_name = component.get("name")
        if not col_name:
            return Issue(
                Severity.ERROR,
                IssueCode.INVALID_JSON,
                json_path,
                f"components[{index}] missing name",
            )
        col_name = str(col_name)
        columns.append(col_name)
        if str(component.get("data_type", "")) == "Integer":
            integer_columns.append(col_name)

    return StructureSpec(
        name=name,
        columns=columns,
        integer_columns=integer_columns,
        kind="dataset",
    )


def is_whole_number_decimal(value: str) -> bool:
    text = value.strip()
    if not text or "." not in text:
        return False
    try:
        number = float(text)
    except ValueError:
        return False
    return number == int(number)


def validate_csv_against_structure(
    csv_path: Path,
    spec: StructureSpec,
) -> list[Issue]:
    issues: list[Issue] = []

    try:
        raw = csv_path.read_text(encoding="utf-8")
    except OSError as exc:
        return [
            Issue(
                Severity.ERROR,
                IssueCode.INVALID_JSON,
                csv_path,
                f"cannot read CSV: {exc}",
            )
        ]

    try:
        rows = list(csv.reader(raw.splitlines()))
    except csv.Error as exc:
        return [
            Issue(
                Severity.ERROR,
                IssueCode.INVALID_JSON,
                csv_path,
                f"cannot parse CSV: {exc}",
            )
        ]

    if not rows:
        return [
            Issue(
                Severity.ERROR,
                IssueCode.EMPTY_DATA,
                csv_path,
                "CSV file is empty",
            )
        ]

    header = [cell.strip() for cell in rows[0]]
    if not any(header):
        return [
            Issue(
                Severity.ERROR,
                IssueCode.EMPTY_DATA,
                csv_path,
                "CSV header row is empty",
            )
        ]

    header_set = set(header)
    expected_set = set(spec.columns)
    missing = [name for name in spec.columns if name not in header_set]
    extra = [name for name in header if name not in expected_set]

    if missing or extra:
        parts = [f"structure {spec.name!r}: CSV header does not match JSON metadata"]
        if missing:
            parts.append(f"  missing columns: {missing}")
        if extra:
            parts.append(f"  extra columns: {extra}")
        issues.append(
            Issue(
                Severity.ERROR,
                IssueCode.HEADER_MISMATCH,
                csv_path,
                "\n".join(parts),
                line=1,
            )
        )

    if len(rows) == 1 and spec.kind == "dataset":
        issues.append(
            Issue(
                Severity.WARNING,
                IssueCode.EMPTY_DATA,
                csv_path,
                f"structure {spec.name!r}: header only, no data rows",
                line=1,
            )
        )

    column_index = {name: header.index(name) for name in header if name in expected_set}

    for row_number, row in enumerate(rows[1:], start=2):
        if len(row) != len(header):
            issues.append(
                Issue(
                    Severity.ERROR,
                    IssueCode.ROW_WIDTH,
                    csv_path,
                    (
                        f"structure {spec.name!r}: row has {len(row)} field(s), "
                        f"header has {len(header)} (trailing empty columns must be explicit in CSV)"
                    ),
                    line=row_number,
                )
            )
            continue

        for column in spec.integer_columns:
            if column not in column_index:
                continue
            cell = row[column_index[column]].strip()
            if is_whole_number_decimal(cell):
                issues.append(
                    Issue(
                        Severity.ERROR,
                        IssueCode.INTEGER_DECIMAL,
                        csv_path,
                        (
                            f"structure {spec.name!r}: column {column!r} is INTEGER in JSON "
                            f"but value {cell!r} uses whole-number decimal notation (use {int(float(cell))!r})"
                        ),
                        line=row_number,
                    )
                )

    return issues


def iter_example_dirs(operators_root: Path) -> Iterator[Path]:
    yield from sorted(operators_root.glob("**/examples"))


def collect_issues(
    version_folder: Path,
    *,
    strict: bool,
) -> list[Issue]:
    operators_root = version_folder / "docs" / "reference_manual" / "operators"
    if not operators_root.is_dir():
        return [
            Issue(
                Severity.ERROR,
                IssueCode.INVALID_JSON,
                operators_root,
                "operators tree not found",
            )
        ]

    issues: list[Issue] = []

    for examples_dir in iter_example_dirs(operators_root):
        json_paths = sorted(examples_dir.glob("*.json"))
        csv_paths = sorted(examples_dir.glob("*.csv"))

        json_by_stem = {path.stem: path for path in json_paths}
        csv_by_stem = {path.stem: path for path in csv_paths}

        for stem, json_path in json_by_stem.items():
            csv_path = csv_by_stem.get(stem)
            if csv_path is None:
                issues.append(
                    Issue(
                        Severity.WARNING if not strict else Severity.ERROR,
                        IssueCode.JSON_WITHOUT_CSV,
                        json_path,
                        f"no paired {stem}.csv",
                    )
                )
                continue

            try:
                data = json.loads(json_path.read_text(encoding="utf-8"))
            except json.JSONDecodeError as exc:
                issues.append(
                    Issue(
                        Severity.ERROR,
                        IssueCode.INVALID_JSON,
                        json_path,
                        str(exc),
                    )
                )
                continue

            parsed = parse_structure(json_path, data)
            if isinstance(parsed, Issue):
                issues.append(parsed)
                continue

            issues.extend(validate_csv_against_structure(csv_path, parsed))

        for stem, csv_path in csv_by_stem.items():
            if stem not in json_by_stem:
                issues.append(
                    Issue(
                        Severity.ERROR,
                        IssueCode.CSV_WITHOUT_JSON,
                        csv_path,
                        f"no paired {stem}.json",
                    )
                )

    return issues


def resolve_version_folder(doc_version: str) -> Path:
    version = doc_version if doc_version.startswith("v") else f"v{doc_version}"
    return Path(__file__).resolve().parent.parent / version


def print_report(issues: list[Issue], version_folder: Path) -> None:
    errors = [issue for issue in issues if issue.severity == Severity.ERROR]
    warnings = [issue for issue in issues if issue.severity == Severity.WARNING]

    if not issues:
        print(f"✅ {version_folder.name}: all example fixtures are consistent.")
        return

    if errors:
        print(f"=== Errors ({len(errors)}) — {version_folder.name} ===")
        for issue in errors:
            print(issue.format(version_folder.parent))
        print()

    if warnings:
        print(f"=== Warnings ({len(warnings)}) — {version_folder.name} ===")
        for issue in warnings:
            print(issue.format(version_folder.parent))
        print()

    print(
        f"Total: {len(errors)} error(s), {len(warnings)} warning(s) "
        f"under {version_folder.name}/docs/reference_manual/operators"
    )


def build_arg_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Validate operator example JSON metadata against CSV fixtures.",
    )
    parser.add_argument(
        "--doc-version",
        default=os.environ.get("DOC_VERSION", "v2.1"),
        help='Doc tree version folder (default: env DOC_VERSION or "v2.1")',
    )
    parser.add_argument(
        "--strict",
        action="store_true",
        help="treat warnings (e.g. JSON without CSV) as errors",
    )
    parser.add_argument(
        "--quiet",
        action="store_true",
        help="only print summary line on success",
    )
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_arg_parser().parse_args(argv)
    version_folder = resolve_version_folder(args.doc_version)

    if not version_folder.is_dir():
        print(
            f"Invalid DOC_VERSION: {args.doc_version!r} — not found: {version_folder}",
            file=sys.stderr,
        )
        return 2

    issues = collect_issues(version_folder, strict=args.strict)
    errors = [issue for issue in issues if issue.severity == Severity.ERROR]
    warnings = [issue for issue in issues if issue.severity == Severity.WARNING]

    if args.quiet and not issues:
        print(f"OK {version_folder.name}")
    else:
        print_report(issues, version_folder)

    if errors:
        return 1
    if args.strict and warnings:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
