## Instructions for building documents with LaTeX

### Installing TeX/LaTeX and necessary files

To compile the LaTeX documentation in `src`, you need to have a LaTeX
system installed.  Most popular distributions include:

* Windows: MikTeX https://miktex.org/
* Mac: MacTeX http://www.tug.org/mactex/
* Linux/*nix: TeX Live https://www.tug.org/texlive/

On many Linux systems, TeX Live is available through package
manager. On Mac, TeX Live is available through `brew`.

Next, you have to add files from `texmf` to your user-local `texmf`
tree directory, whose location may depend on the TeX distribution.
Normally it is a directory named `texash` in your home directory.
You may need to run `texhash ~/texmf` to make sure these files are
indexed.

### Compiling documents to PDF

This is normally done with `pdflatex FILE-NAME.tex` from command line *twice*,
or using an adequate option from a text editor of your choice.  See
e.g. these slides for orientation:

http://www.rpi.edu/dept/arc/training/latex/class-slides-pc.pdf



