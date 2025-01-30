# SDMX-VTL
VTL is a standard language for defining **validation** and **transformation** rules (set of operators, their syntax and semantics) for any kind of statistical data. 

VTL builds on the Transformation section of the SDMX information model, by taking the common parts of GSIM, SDMX and DDI as for the representation of concepts and data. The assumption is that such a logical formalization of validation and transformation rules will provide a "technology-neutral" expression at business level of the processing taking place, against which various implementations and specific programming languages can be mapped. 

The specifications for exchanging VTL validation rules in SDMX messages, for storing rules and for requesting validation rules from web services will be provided in a specific update to the SDMX Technical Standards on which the SDMX Technical Working Group is working on. 

--- 
# VTL Versions

The current official version of the language is [v2.1](https://github.com/sdmx-twg/vtl/tree/master/v2.1) and it includes:

* [User Manual](https://sdmx-twg.github.io/vtl/2.1/html/user_manual/index.html) highlighting the main characteristics of VTL, its core assumptions and the information model the language is based on;
* [Reference Manual](https://sdmx-twg.github.io/vtl/2.1/html/reference_manual/index.html), describing the full library of operators ordered by category, with examples;
* EBNF notation (Extended Backus-Naur Form) grammar, which is the technical notation to be used as a test bed for all the examples throughout the document: files [Vtl.g4](https://github.com/sdmx-twg/vtl/blob/master/v2.1/src/main/antlr4/org/sdmx/vtl/Vtl.g4) & [VtlTokens.g4](https://github.com/sdmx-twg/vtl/blob/master/v2.1/src/main/antlr4/org/sdmx/vtl/VtlTokens.g4)
* [Technical Notes document](https://github.com/sdmx-twg/vtl/blob/master/v2.1/docs/Technical_Notes.md), to support VTL implementation
