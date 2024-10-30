Introduction
============

This document is the Reference Manual of the Validation and
Transformation Language (also known as ‘VTL’) version 2.1.

The VTL 2.1 library of the Operators is described hereinafter.

VTL 2.1 consists of two parts: the VTL Definition Language (VTL-DL) and
the VTL Manipulation Language (VTL-ML).

This manual describes the operators of VTL 2.1 in detail (both VTL-DL
and VTL-ML) and is organized as follows.

First, in the following Chapter “Overview of the language and
conventions”, the general principles of VTL are summarized, the main
conventions used in this manual are presented and the operators of the
VTL-DL and VTL-ML are listed. For the operators of the VTL-ML, a table
that summarizes the “Evaluation Order” (i.e., the precedence rules for
the evaluation of the VTL-ML operators) is also given.

The following two Chapters illustrate the operators of VTL-DL,
specifically for:

-  the definition of rulesets and their rules, which can be invoked with
   appropriate VTL-ML operators (e.g. to check the compatibility of Data
   Point values …);

-  the definition of custom operators/functions of the VTL-ML, meant to
   enrich the capabilities of the VTL-ML standard library of operators.

The illustration of VTL-ML begins with the explanation of the common
behaviour of some classes of relevant VTL-ML operators, towards a good
understanding of general language characteristics, which we factor out
and do not repeat for each operator, for the sake of compactness.

The remainder of the document illustrates each single operator of the
VTL-ML and is structured in chapters, one for each category of Operators
(e.g., general purpose, string, numeric …). For each Operator, there is
a specific section illustrating the syntax, the semantics and giving
some examples.