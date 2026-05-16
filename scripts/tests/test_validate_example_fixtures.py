#!/usr/bin/env python3
"""Unit tests for validate_example_fixtures (stdlib only)."""

from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

# Allow importing sibling script module when run as unittest from repo root.
import sys

_SCRIPTS_DIR = Path(__file__).resolve().parent.parent
if str(_SCRIPTS_DIR) not in sys.path:
    sys.path.insert(0, str(_SCRIPTS_DIR))

from validate_example_fixtures import (  # noqa: E402
    IssueCode,
    Severity,
    collect_issues,
    is_whole_number_decimal,
    parse_structure,
    validate_csv_against_structure,
    StructureSpec,
)


class DecimalNotationTest(unittest.TestCase):
    def test_whole_number_decimal(self) -> None:
        self.assertTrue(is_whole_number_decimal("15.0"))
        self.assertTrue(is_whole_number_decimal("-3.0"))

    def test_rejects_non_whole_or_non_decimal(self) -> None:
        self.assertFalse(is_whole_number_decimal("15"))
        self.assertFalse(is_whole_number_decimal("15.5"))
        self.assertFalse(is_whole_number_decimal(""))


class ParseStructureTest(unittest.TestCase):
    def test_dataset_components(self) -> None:
        spec = parse_structure(
            Path("ds_1.json"),
            {
                "name": "DS_1",
                "components": [
                    {"name": "Id_1", "data_type": "String"},
                    {"name": "Me_1", "data_type": "Integer"},
                ],
            },
        )
        self.assertIsInstance(spec, StructureSpec)
        assert isinstance(spec, StructureSpec)
        self.assertEqual(spec.columns, ["Id_1", "Me_1"])
        self.assertEqual(spec.integer_columns, ["Me_1"])

    def test_scalar_shape(self) -> None:
        spec = parse_structure(
            Path("ex_7.json"),
            {"name": "SC_r", "type": "integer"},
        )
        assert isinstance(spec, StructureSpec)
        self.assertEqual(spec.kind, "scalar")
        self.assertEqual(spec.columns, ["SC_r"])


class ValidateCsvTest(unittest.TestCase):
    def test_header_mismatch(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            csv_path = Path(tmp) / "ex.csv"
            csv_path.write_text("Me1,Id_1\n1,A\n", encoding="utf-8")
            spec = StructureSpec(
                name="DS_r",
                columns=["Id_1", "Me_1"],
                integer_columns=[],
                kind="dataset",
            )
            issues = validate_csv_against_structure(csv_path, spec)
            self.assertTrue(any(i.code == IssueCode.HEADER_MISMATCH for i in issues))

    def test_integer_decimal(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            csv_path = Path(tmp) / "ds.csv"
            csv_path.write_text("Me_1\n15.0\n", encoding="utf-8")
            spec = StructureSpec(
                name="DS_1",
                columns=["Me_1"],
                integer_columns=["Me_1"],
                kind="dataset",
            )
            issues = validate_csv_against_structure(csv_path, spec)
            self.assertTrue(any(i.code == IssueCode.INTEGER_DECIMAL for i in issues))

    def test_row_width(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            csv_path = Path(tmp) / "ex.csv"
            csv_path.write_text("Id_1,Id_2,Me_1\nA,B\n", encoding="utf-8")
            spec = StructureSpec(
                name="DS_r",
                columns=["Id_1", "Id_2", "Me_1"],
                integer_columns=[],
                kind="dataset",
            )
            issues = validate_csv_against_structure(csv_path, spec)
            self.assertTrue(any(i.code == IssueCode.ROW_WIDTH for i in issues))

    def test_scalar_header(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            csv_path = Path(tmp) / "ex.csv"
            csv_path.write_text("SC_r\n3\n", encoding="utf-8")
            spec = StructureSpec(
                name="SC_r",
                columns=["SC_r"],
                integer_columns=["SC_r"],
                kind="scalar",
            )
            issues = validate_csv_against_structure(csv_path, spec)
            self.assertEqual(issues, [])


class CollectIssuesIntegrationTest(unittest.TestCase):
    def test_minimal_tree(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            version = root / "v9.9"
            examples = (
                version
                / "docs"
                / "reference_manual"
                / "operators"
                / "Op"
                / "examples"
            )
            examples.mkdir(parents=True)
            (examples / "ds_1.json").write_text(
                json.dumps(
                    {
                        "name": "DS_1",
                        "components": [
                            {
                                "name": "Me_1",
                                "role": "Measure",
                                "data_type": "Integer",
                            }
                        ],
                    }
                ),
                encoding="utf-8",
            )
            (examples / "ds_1.csv").write_text("Me_1\n42\n", encoding="utf-8")

            issues = collect_issues(version, strict=False)
            self.assertEqual(issues, [])


if __name__ == "__main__":
    unittest.main()
