import os
from pathlib import Path
import re
import json

# Get DOC_VERSION from environment and validate
DOC_VERSION = os.environ["DOC_VERSION"]
VERSION_FOLDER = Path(__file__).parent.parent / DOC_VERSION
assert VERSION_FOLDER.exists(), f"Invalid DOC_VERSION: {DOC_VERSION} folder not found"

# Define folders
OPERATORS_FOLDER = VERSION_FOLDER / "docs" / "reference_manual" / "operators"
OUTPUT_FOLDER = Path(__file__).parent.parent / "tck" / DOC_VERSION

# Ensure OUTPUT_FOLDER exists
OUTPUT_FOLDER.mkdir(parents=True, exist_ok=True)

def load_dataset(input_paths: list[Path]):
    "Generates datasets files from the input paths"
    result = {"datasets": [], "structures": []}
    for fl in input_paths:
        with open(fl, encoding="utf-8") as file:
            datastructure = json.load(file)
        dataset = {
            "name": datastructure["name"],
            "structure": datastructure["name"],
        }
        result["datasets"].append(dataset)
        result["structures"].append(datastructure)
    return result

def generate_files_from_folder(folder: Path):
    "Generate the engine files from the folder"
    operator_parent_folder = OUTPUT_FOLDER / folder.parent.parent.name
    operator_output_folder = operator_parent_folder / folder.parent.name

    operator_parent_folder.mkdir(exist_ok=True)
    operator_output_folder.mkdir(exist_ok=True)

    for file in folder.glob("*.vtl"):
        dest_folder = operator_output_folder / file.stem
        dest_folder.mkdir(exist_ok=True)

        vtl_script = file.read_text()

        if "<-" in vtl_script:
            output_name, expression = map(str.strip, vtl_script.split("<-", 1))
        else:
            output_name, expression = map(str.strip, vtl_script.split(":=", 1))

        regex = re.compile("DS_[0-9]+")
        used_datasets = re.findall(regex, expression)
        input_paths = [folder / f"{ds.lower()}.json" for ds in used_datasets]
        datasets = load_dataset(input_paths)

        (dest_folder / "input.json").write_text(json.dumps(datasets, indent=4))

        for ds in used_datasets:
            (dest_folder / f"{ds}.csv").write_text((folder / f"{ds.lower()}.csv").read_text())

        datasets = load_dataset([folder / f"{file.stem}.json"])
        (dest_folder / "output.json").write_text(json.dumps(datasets, indent=4))
        (dest_folder / f"{output_name}.csv").write_text((folder / f"{file.stem}.csv").read_text())
        (dest_folder / "transformation.vtl").write_text(vtl_script)

def main():
    "Generate TCK files"
    examples_folders = list(OPERATORS_FOLDER.glob("**/examples"))
    for folder in examples_folders:
        generate_files_from_folder(folder)

if __name__ == "__main__":
    main()