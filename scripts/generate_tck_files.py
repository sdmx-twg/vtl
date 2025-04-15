import os
import re
import json
import zipfile
from pathlib import Path

# Get DOC_VERSION from environment and validate
DOC_VERSION = os.environ["DOC_VERSION"]
VERSION_FOLDER = Path(__file__).parent.parent / DOC_VERSION
assert VERSION_FOLDER.exists(), f"Invalid DOC_VERSION: {DOC_VERSION} folder not found"

OPERATORS_FOLDER = VERSION_FOLDER / "docs" / "reference_manual" / "operators"
ZIP_OUTPUT = Path(__file__).parent.parent / "tck" / f"{DOC_VERSION}.zip"

# Ensure tck folder exists
ZIP_OUTPUT.parent.mkdir(parents=True, exist_ok=True)

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

def write_to_zip(zipf: zipfile.ZipFile, folder: Path):
    "Generate files and write them directly into zip"
    operator_parent_folder = folder.parent.parent.name
    operator_folder = folder.parent.name

    for file in folder.glob("*.vtl"):
        example_name = file.stem
        base_path = f"{operator_parent_folder}/{operator_folder}/{example_name}"

        vtl_script = file.read_text()

        if "<-" in vtl_script:
            output_name, expression = map(str.strip, vtl_script.split("<-", 1))
        else:
            output_name, expression = map(str.strip, vtl_script.split(":=", 1))

        regex = re.compile("DS_[0-9]+")
        used_datasets = re.findall(regex, expression)
        input_paths = [folder / f"{ds.lower()}.json" for ds in used_datasets]
        datasets = load_dataset(input_paths)
        zipf.writestr(f"{base_path}/input.json", json.dumps(datasets, indent=4))

        for ds in used_datasets:
            ds_csv = folder / f"{ds.lower()}.csv"
            if ds_csv.exists():
                zipf.write(ds_csv, f"{base_path}/{ds}.csv")

        output_json = load_dataset([folder / f"{example_name}.json"])
        zipf.writestr(f"{base_path}/output.json", json.dumps(output_json, indent=4))
        zipf.write(folder / f"{example_name}.csv", f"{base_path}/{output_name}.csv")
        zipf.writestr(f"{base_path}/transformation.vtl", vtl_script)

def main():
    examples_folders = list(OPERATORS_FOLDER.glob("**/examples"))
    with zipfile.ZipFile(ZIP_OUTPUT, "w", zipfile.ZIP_DEFLATED) as zipf:
        for folder in examples_folders:
            write_to_zip(zipf, folder)
    print(f"✅ Zip generated: {ZIP_OUTPUT}")

if __name__ == "__main__":
    main()