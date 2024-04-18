# SDMX-VTL
VTL is a standard language for defining **validation** and **transformation** rules (set of operators, their syntax and semantics) for any kind of statistical data. 

VTL builds on the Transformation section of the SDMX information model, by taking the common parts of GSIM, SDMX and DDI as for the representation of concepts and data. The assumption is that such a logical formalization of validation and transformation rules will provide a "technology-neutral" expression at business level of the processing taking place, against which various implementations and specific programming languages can be mapped. 

The specifications for exchanging VTL validation rules in SDMX messages, for storing rules and for requesting validation rules from web services will be provided in a specific update to the SDMX Technical Standards on which the SDMX Technical Working Group is working on. 

--- 
# VTL Versions

The current official version of the language is [v2.0](https://github.com/amattioc/vtl/tree/master/v2.0) and it includes:

* [Part 1](https://sdmx.org/wp-content/uploads/VTL-2.0-User-Manual-20180416-final.pdf), highlighting the main characteristics of VTL, its core assumptions and the information model the language is based on;
* [Part 2](https://sdmx.org/wp-content/uploads/VTL-2.0-Reference-Manual-20180416-final.pdf), describing the full library of operators ordered by category, with examples;
* EBNF notation (Extended Backus-Naur Form) which is the technical notation to be used as a test bed for all the examples throughout the document: files [Vtl.g4](src/main/antlr4/org/sdmx/vtl/Vtl.g4) & [VtlTokens.g4](src/main/antlr4/imports/VtlTokens.g4)

A new version ([v2.1](https://github.com/sdmx-twg/vtl/tree/master/v2.1)) is currently being developed and the documentation is mainly html based and it is hosted in [github pages](https://sdmx-twg.github.io/vtl/) 
