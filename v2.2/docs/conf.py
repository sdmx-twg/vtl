import os
import re
from pathlib import Path

from jinja2 import Environment, FileSystemLoader


project = u'VTL Documentation'
VERSION = "2.2"


def name_norm(value):
    return re.sub("[^a-zA-Z0-9]", "", value)


html_theme = "sphinx_rtd_theme"


extensions = [
    "sphinxcontrib.mermaid",
    "sphinxcontrib.plantuml",
    "rst2pdf.pdfbuilder",
    "sphinx_toolbox.collapse"
]


pdf_documents = [
    ("index", f"VTL_{VERSION}_DOCS", f"VTL {VERSION} DOCS", "SDMX-TWG"),
]


exclude_patterns = [
    "*intro.rst",
    "pandocTranslation*",]


html_theme_options = {
    "navigation_depth": 5,
    "collapse_navigation": False,

}


html_context = {
    "display_github": True,  # Integrate GitHub
    "github_user": "sdmx-twg",  # Username
    "github_repo": "vtl",  # Repo name
    "github_version": "master",  # Version
    "conf_py_path": f"/v{VERSION}/docs/",  # Path in the checkout to the docs root
}


# Load templates
jinjaEnv = Environment(loader=FileSystemLoader(searchpath="templates"))
jinjaEnv.filters["name_norm"] = name_norm
templates = {}
for template in next(os.walk("templates"))[2]:
    templates[template] = jinjaEnv.get_template(template)

# Apply templates in each op type folder
for op_type in next(os.walk("reference_manual/operators"))[1]:
    op_type_path = Path("reference_manual/operators").joinpath(op_type)


    # Apply templates in each op folder
    for op_folder in next(os.walk(op_type_path))[1]:
        op_path = op_type_path.joinpath(op_folder)

        # Write the op examples
        examples_folder = op_path.joinpath("examples")
        ds_list = sorted(
            x.with_suffix("").name for x in examples_folder.glob("ds_*.csv")
        )
        inputs = []
        for i in range(len(ds_list)):
            inputs.append(
                {"folder": examples_folder, "i": i + 1, "name": ds_list[i]})

        ex_list = sorted(
            x.with_suffix("").name for x in examples_folder.glob("ex_*.vtl")
        )
        examples = []
        for i in range(len(ex_list)):
            examples.append(
                {"folder": examples_folder, "i": i + 1, "name": ex_list[i]})

        examples_text = templates["examples"].render(
                {
                    "examples": examples,
                    "inputs": inputs,
                    "op_type": op_type,
                    "repourl_ex": f"https://github.com/sdmx-twg/vtl/blob/master/v{VERSION}/docs",
                }
            )
        if examples_folder.joinpath("end_text.rst").exists():
            examples_text += """.. include:: examples/end_text.rst"""

        with open(op_path.joinpath("examples.rst"), "w") as f:
            f.write(examples_text)


plantuml = "java -jar " + os.getenv("PUML_PATH", "/tmp/plantuml.jar")
plantuml_output_format = 'svg'
