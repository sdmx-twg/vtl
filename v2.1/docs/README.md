# Documentation How-to

VTL 2.1 documentation is published on the web through the content of this directory.

The actual publication is automated via a [GitHub action](https://github.com/sdmx-twg/vtl/blob/master/.github/workflows/build-the-docs.yml).

The rest of this README explain the overall structure and guide you to your next contribution.

## Setup

Since we are using Sphinx for the documentation website, some upfront setup is required:

- install Python (version 3.8+ ???)
- install the dependencies using requirements with `pip install -r requirements.txt`
  - it is better to use a virtual environment for installing a python project, for this do:
    - `python3 -m venv .venv`
    - `source .venv/bin/activate`
    - and then `pip install -r requirements.txt`
  - can do better with poetry or rye?
- `conf.py` is a Sphinx related file
- check Sphinx installation in the virtual env with `sphinx-build --version`
- in order to generate the PlantUML schemas:
  - install Java
  - dowload the required [PlantUML JAR](https://github.com/plantuml/plantuml/releases/tag/v1.2023.13) to the directory configured in `conf.py` - currently `/tmp`

Now you can use Sphinx to build and test locally the website by using:

- `sphinx-build -M html v2.1/docs/ ./build/`

## Structure of the repository

The main directory is `/<vtl>/v2.1/docs` where `<vtl>` is the name of the root directory (the one git create when cloning the repo).

The Python related files are already described in the _Setup_ section.

`index.rst` is the main page file. As all `.rst` files in this repo, it is a [reStructuredText](https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html) markup file.

The `pandocTranslation` folder holds an automated creation of the respective User manual and Reference manual from their 2.1 original document to a `.rst` file. This has to be considered as the raw material for the initial contribution.

## How to actually contribute?

See [ongoing issue](https://github.com/sdmx-twg/vtl/issues/507).
