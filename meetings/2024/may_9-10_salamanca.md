# SDMX VTL TF Minutes
Physical Meeting: 9-10th May 2024

Venue: Universidad Pontificia de Salamanca Calle Serranos 2, Salamanca

## Agenda

### Day 1 Thursday 9th  May
|TIME|TOPIC|PRESENTER
|----|-----|------|
|09:00 - 09:15|Welcome coffee|	
|09:15 - 09:45|Introduction: logistics, location, social program|Antonio
|09:45 - 10:00|Adoption of the agenda|Angelo
|10:00 - 10:30|Introduction to new members|Angelo
|10:30 - 11:00|Release of VTL version 2.1|
||- Open issues|
||- Cutoff date|
||- Publishing of the UM&RM|
||- Update of SDMX VTL page|
|11:00 - 11:15|Coffee break||	
|11:15 - 12:30|Outcome from the Work Streams 	
||WS1: VTL docs|Attilio
||WS2: VTL technical issues|Valentino
||WS3: VTL language|Angelo
|12:30 - 13:00|Open issues about VTL: VTL – DL improvements & other issues|Angelo
|13:00 - 14:15|Lunch|	
|14:15 - 15:30|Open issues about VTL: Dynamic web questionnaires|Romain
|15:30 - 17:00|Presentation of Meaningfuldata tools|Antonio

17:30   Guided tour in Salamanca

21:00	  Social event (dinner)  

### Day 2 Thursday 10th  May
|TIME|TOPIC|PRESENTER
|----|-----|------|
|09:00 - 09:15|Welcome coffee|	
|09:15 - 10:00|Key points for implementing VTL in production environment|Angelo
|10:00 - 11:30|Implementing VTL in production environments|	
||Making Sense & HK consulting|Hadrien
||NBB/Meaningfuldata|Bryan
||ECB (testing activities with VTL)|Noah
|11:30 - 11:45|Coffee break|	
|11:45 - 12:30|Current collaboration activities|
||Shared information about collaboration activities on VTL|All
|12:30 - 13:00|AOB & conclusion|Angelo

## Participants

1.  Angelo Linardi
2.  Antonio Olleros
3.  Arturo	San Feliciano
4.  Attilio Mattiocco
5.  Bryan	Marquette
6.  Daniel Suranyi
7.  Hadrien	Kohl
8.  Javier Heranandez
9.  Jesús	Simón
10.  Nicolas Laval
11.  Noah	Boerger
12.  Romain	Tailhurat
13.  Valentino Pinna
14.  Edgardo	Greising (remote)
15.  Katrin	Heinze (remote)
16.  Laura	Vignola (remote)
17.  Matthew	Nelson (remote)
18.  Sergey	Grebenshchikov (remote)
19.  Stratos	Nikoloutsos (remote)

Other attendees:

Fabio Palatta and Ida Migliaccio (Banca d'italia)
## Day 1 Thursday 9th  May
### Introduction to new members
New members have been introduced:
- Bryan	Marquette (National Bank of Belgium) will participate in Work Stream 3
- Hadrien Kohl (Consultant) will participate in Work Stream 2
- Noah Boerger (Bundesbank) will participate in Work Stream 2

Some new collaborators have been also introduced:
- Arturo	San Feliciano (Banco de Espana)
- Sergey	Grebenshchikov (Bundesbank)

### Release of VTL version 2.1
The User Manual and the Reference Manual will be frozen in the next days. The 2 documents in pdf version will be sent to the Secretariat via Written Procedure and will be published in the SDMX User Forum for final review.

The G4 file (grammar) will be update accordingly and will be available possibly by the end of June, in order to be ready to be published in the SDMX VTL official web page.

The final release of VTL 2.1 will be probably coordinated to the SDMX 3.1 version; the decision will be taken in the next TWG meeting at the beginning of June in Washington.

**Actions**:
- Nicolas to coordinate the activity of producing the G4 file (grammar) possibily by end of June
- Angelo to produce the pdf of the two manuals and send to Secretariat via WP
- Angelo to post on SDMX User Forum the VTL 2.1 manuals for public review
### Current activities - WS1 - VTL docs (Attilio)
**Requirements**
- Docs generation should be automated (CI/CD like) --> **YES**
  - Single source for different outputs
  - Enable versioning
  - Easily manage releases (current + previous easily reachable
  - Envisaged outputs are HTML github pages ) and PDF
- Docs sources should be readable in github to ease changes tracing including diagrams if possible --> **YES**
- Examples in the reference guide (vtl code, input and output datasets and structures) should be easily consumed by VTL engines for testing, to ensure alignment with specs and implementations  --> **YES**
- Current documentation has to be massively migrated to new format (use pandoc for raw starting point  --> **YES**
- Automatic translations --> **NO**

**Work done**
- https://github.com/sdmx-twg/vtl
- https://sdmx-twg.github.io/vtl
- https://ma-bdi.github.io/vtl-twg/ (multi version and pdf)

**Open Issues**
1. Diagrams in PDF
2. Style choices
3. Massive Translation

**Actions**:
- Take as input the current "frozen" VTL 2.1 documentation (User Manual and Reference Manual pdf files), that will be referenced as "specifications"
- Priority given to the operators: Attilio will define an issue for each operator and every VTL TF will take the ones that prefers to produce the new documentation (that includes VTL expressions, csv files and json structures of the input and the output for the examples)
- If discrepancies with the current specifications are found, please contact WS3 (Angelo) to open a discussion and eventually reconcile the two sources
- A good example of documentation is the pandora's one (https://pandas.pydata.org/docs/); at the moment it could be considerate a template for VTL home page


### Current activities - WS2 - VTL technical issues (Valentino)
- Technical notes document drafted on github
- Some enhancements for error handling have been proposed:
  - Define a standard coding 
  - Include severity attribute, in order to distinguish errors from warning
  - Explicit behaviours should be specified for each (class of) errors
  - Some errors could be associated to specific operators
  - Error types could be eventually defined as VTL types 

**Actions**
- WS2 to analyse proposed enhancements and produce a new version of the Technical Notes for the next VTL release
- Current pdf version will be generated and published together the 2 manuals in the official SDMX VTL site

### Current activities - WS3 - VTL language (Angelo)
- These are the main topics for the next release:
  - User Defined Operators (UDO) (issue #51 
  - Viral attributes: complete revision
  -	Explicit casting for integer/number to string and viceversa (issues #381, #383 and #394)
  - Join: revise the entire description of the operator (issue #392) 
**Actions**
- Viral attributes revision to be prioritised
- Antonio to prepare a proposal for the join operator to be analysed and discussed

### Open issues about VTL: UDO and DL operators improvements
Angelo decribed more in detail current issues on User Defined Operators (UDO) and on Define Language (DL): 
- Current issues with User Defined Operators
  - #388: allow UDOs with several transformations (see procedures in VTL
  - #389: allow UDOs with set of components as argument
  - #390: make UDOs more flexible
  - #396: UDO default parameters
- DL operators currently in the “Technical notes” document
  - define structure
  - define variable
  - define value domain

**Actions**
- UDO and DL operators will be significantly enhanced in next release
- Input will be coming from tools’ implementing teams (see Technical notes document) and from new requirements
- WS3 will take care of producing specificationsViral attributes revision to be prioritised

### Open issues about VTL: Dynamic web questionnaires
Romain described how INSEE is using VTL to handle dynamic web questionnaires.

Some new operators could be useful to handle some use cases:
- Besides first_value and last_value a new operator could be defined to get the nth value in a dataset/component
- Introduce vector/list types (and operators to get the individual elements)
- Define a way to get a reference to set of components

Angelo observed that the vector/list types has been introduced in SDMX 3.0 and that VTL adoption of these new types had been put in the "to-do list" last year, but no use cases were reported so this issue had been deprioritized.

**Actions**
- New operator to get the nth value in a dataset/component will be defined in the next release
- Vector/list type definition will be analysed and discussed in the WS3
- A discussion will be initiated about the introduction of the "set of components" concept  
### Presentation of Meaningfuldata tools
Antonio introduced Gustavo Homem from Meaningfuldata who went through the VTL tools offered by the company.

Antonio presented a live demo of the VTL Suite and announced that in some weeks their VTL engine will be released as open source
## Day 2 Friday 10th  May
### Key points for implementing VTL in production environment
Angelo gave a presentation about some key points on an enterprise calculation engine, based on the over 30 years' experience in Banca d'Italia:
- 0 implicit and 0 explicit cubes
- How to interpret missing values and nulls handling
- Calculability: Process cubesets, Status cubes and input vs output synchrony
- Process unit and parameters
- Historical processing and modularisation
### Implementing VTL in production environments: experiences from different organizations
#### Making Sense and HK consulting
Hadrien and Nicolas presented some issues about current version of VTL:
1. Some G4 issues
2. Some operators containing constant values in their definition could be more efficient and flexible if variables are used
3. Language orthogonality: some operations can be expressed in multiple ways using different VTL operators: should this be avoided ?
4. Derived operators: some complex operators can be implemented by means of other core operators
5. Lacking of Technology Compatibility Kit (TCK)
6. Temporal types: too much is left to interpretation
7. Some useful operators can be introduced:
  - getObs(ds, 1 order by id_1)  -- returns the first ds line as key/value object (new type)
  - scalar := getScalar(observation, "Me_2") -- returns the Me_2 scalar value

**Actions**
- Point 1: all the errors found will be fixed in the next release of the grammar related to VTL version 2.1
- Points 3 and 4: The current approach, as Edgardo pointed out, has been adopted after a similar discussion during the preparation of VTL version 1.1. Since VTL is not a programming language and it is more user-oriented, it is preferable to keep it more user-friendly and less error-prone, even if has some redundancies. Anyway the proposal of designing a standard library, agreed by several people, can be discussed and probably implemented in VTL 3.0.
- Point 5: The currently on-going activity of VTL docs (WS1) is aimed at building a first "implicit" version of a TCK; possible ehancements can be discussed at the end of this task
- Point 7: Regarding "getScalar" function, a possible "easy win" could be applying it only to datasets with 1 column and 1 row.
- The other points will be analysed and discussed in ad-hoc WS2 and WS3 meetings

#### NBB/Meaningfuldata
- Bryan briefly described NBB's current activities on VTL; at the moment final users do not have direct "hands on" the language and there is an expert group that implements business requirements using VTL Suite by Meaningfuldata
- In the next months more statistical flow will be added to the current solution and once the expert group has reached a good knowledge of VTL, training programs will be set up involving all the final business users
#### ECB testing activities with VTL
- Noah described the ongoing activities for the Common Data Management project related to the adoption of VTL for validation and transformation services
- Testing has been conductiong on several use cases using Trevas VTL Enginge; hereafter are reported the main outcomes:
  - Some findings have been reported about language coverage of Trevas engine (not implemented operators), on handling of null and zero values, calculation accuracy and other minor ones
  - Trevas engine has been used with AWS Glue, according to the adopted architectural environment of the project
  - Nexts steps: performance tests, handling of invalid syntax errors, enhancement of the implemented interactive user guide

Angelo asked if testing of other engines is planned and eventual requirements for VTL enhancements will be coming from the CDM project.

Sergey replied that currently they are working on assessing VTL coverage of CDM project's requirements and how to complement the residual ones; eventual requests for VTL enhancements will come probably in the next year.

### Current collaboration activities
Angelo reported that the announced collaboration regarding the integration on VTL in the SDMX Fusion Metadata Registry between BSI and Banca d'Italia in the sdmx.io initiative is going on; some legal issues on the Memorandum Of Understanding will be resolved in the next period, but no technical problems have been experienced up to now.

Stratos reported that BSI is currently working with INSEE for including Trevas VTL Engine in the sdmx.io initiative
### AOB
Next VTL TF physical meeting will be held around the end of the year; by that time the VTL docs activities should be ended and an alignment with the current 2.1 specifications could be required.

A big thanks to Antonio and Meaningfuldata for their wonderful hospitality in Salamanca.
