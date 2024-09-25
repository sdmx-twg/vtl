"This script generates the engine files for the documentation"

from pathlib import Path
import re
import json

OPERATORS_FOLDER = Path(__file__).parent / "reference_manual" / "operators"
OUTPUT_FOLDER = Path(__file__).parent / "engine_files"

if not OUTPUT_FOLDER.exists():
    OUTPUT_FOLDER.mkdir()


def load_dataset(input_paths):
    "Generates datasets files from the input paths"

    result = {
        "datasets": [],
        "structures": []
    }

    for fl in input_paths:
        with open(fl, encoding='utf-8') as file:
            datastructure = json.load(file)
        dataset =  {
            "name": datastructure["name"],
            "structure": datastructure["name"],
        }

        result["datasets"].append(dataset)
        result["structures"].append(datastructure)

    return result


def generate_files_from_folder(folder):
    "Generate the engine files from the folder"
    operator_output_folder = OUTPUT_FOLDER / folder.parent.name
    if not operator_output_folder.exists():
        operator_output_folder.mkdir()
    for file in folder.glob('*.vtl'):
        #New folder per example
        dest_folder = operator_output_folder / file.stem
        if not dest_folder.exists():
            dest_folder.mkdir()

        vtl_script = file.read_text()

        if "<-" in vtl_script:
            output_name = vtl_script.split("<-")[0].strip()
            expression = vtl_script.split("<-")[1].strip()
        else:
            output_name = vtl_script.split(":=")[0].strip()
            expression = vtl_script.split(":=", 1)[1].strip()

        #Generate input datasets files
        regex = re.compile('DS_[0-9]+')
        used_datasets = re.findall(regex, expression)

        input_paths = [folder / f"{ds.lower()}.json" for ds in used_datasets]

        datasets = load_dataset(input_paths)

        dest_datasets_file = dest_folder / "input.json"
        dest_datasets_file.write_text(json.dumps(datasets, indent=4))

        for ds in used_datasets:
            source_file = folder / f"{ds.lower()}.csv"
            dest_file = dest_folder / f"{ds}.csv"
            dest_file.write_text(source_file.read_text())

        #Generate output dataset file
        datasets = load_dataset([folder / f"{file.stem}.json"])
        dest_datasets_file = dest_folder / "output.json"
        dest_datasets_file.write_text(json.dumps(datasets, indent=4))

        dest_output_data_file = dest_folder / f"{output_name}.csv"
        source_file = folder / f"{file.stem}.csv"
        dest_output_data_file.write_text(source_file.read_text())

        #Copy VTL file with generic name
        dest_vtl_file = dest_folder / "transformation.vtl"
        dest_vtl_file.write_text(vtl_script)

def main():
    "Generate the engine files"

    examples_folders = list(OPERATORS_FOLDER.glob('**/examples'))

    for folder in examples_folders:
        generate_files_from_folder(folder)


if __name__ == "__main__":
    main()
