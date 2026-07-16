# Concept Note: Temporal operators
This work package seeks to review current temporal operators, eventually defining and/or changing some of them.

This package's output will be a new set of temporal operators for VTL 2.3 version, together with a report containing principles, motivations and differences with the previous 2.2 release. 

## I. Overview and Purpose

The main goal of this workpackage will be to eliminate discrepancies between the different time operators and to align them as much as possibile to ISO 8601 standard (current version documentation is available at https://www.isotc154.org/standards/iso-8601-1-2019/).


## I. Overview and Purpose

The presupposition for this activity is that we cannot know how exactly a user will want to work with the data for integration purposes. Consequently, rather than providing a very prescriptive framework, we will address a number of useful topics where two key standards in the official statistics domain, SDMX and DDI, might be combined in different ways for data integration. In the process, we will attempt to relate these to real-world use cases, but coverage will not be comprehensive.

While other standards may be needed (because of real-world use cases) the idea here is to explore first the two main ones. The core assumption is that users will tend to be working in one world or the other, namely SDMX- or DDI-centered data description.

Overall steps:
1.	Describing the data to make it integration ready.
2.	Describing the mappings.
3.	Describing the process step (e.g. select, join, recode, aggregate, etc.).

## II. Scope and Approach

Here is a non-exhaustive list of the topics we would like to cover to support data integration across standards:

### Developing model transformations for aggregate data: 
This case consists of having two data sets with their respective data structures integrated into a single dataset with a different data structure.
-	SDMX -> DDI-CDI
-	DDI-CDI -> SDMX

### Expressing mappings for data integration
- SDMX-to-SKOS
- DDI-CDI-to-SKOS
- Using SDMX to map codelists
- Applying SSSOM in general and in particular to map SKOS concepts
- Crosswalks between SSSOM and SDMX (using SDMX mappings in SSSOM)

### Developing model transformations for microdata: 
-	DDI -> SDMX (reformatting model-to-model, not recodes, etc.)

### Process flows and processing steps for data integration: 
The assumption for this case is that input data are in the same standard as the processing language. Some of the languages model to be considered are:
- VTL
-	SDTL/SDTH
-	DDI-CDI Process Flow
-	SDMX Process

### DDI Microdata - to - SDMX Aggregates

### Clarifying potentially confusing terminology: 
DDI and SDMX tend to use similar terms for notions that are not exactly the same, e.g. Concepts, Categories, Codes, Components, etc. whereas some other notions are explicitly defined in one standards but not in the other, e.g. Variable. 

## Timeline (TBD)

## Members
