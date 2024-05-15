# SDMX VTL TF Minutes

Physical Meeting: 9-10th May 2024

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

## Introduction to new members
New members have been introduced:
- Bryan	Marquette (National Bank of Belgium) will participate in Work Stream 3
- Hadrien Kohl (Consultant) will participate in Work Stream 2
- Noah Boerger (Bundesbank) will participate in Work Stream 2

Some new collaborators have been also introduced:
- Arturo	San Feliciano (Banco de Espana)
- Sergey	Grebenshchikov (Bundesbank)

## Release of VTL version 2.1
The User Manual and the Reference Manual will be frozen in the next days. The 2 documents in pdf version will be sent to the Secretariat via Written Procedure and will be published in the SDMX User Forum for final review.

The G4 file (grammar) will be update accordingly and will be available possibly by the end of June, in order to be ready to be published in the SDMX VTL official web page.

The final release of VTL 2.1 will be probably coordinated to the SDMX 3.1 version; the decision will be taken in the next TWG meeting at the beginning of June in Washington.

**Actions**:
- Nicolas to coordinate the activity of producing the G4 file (grammar) possibily by end of June
- Angelo to produce the pdf of the two manuals and send to Secretariat via WP
- Angelo to post on SDMX the VTL 2.1 manuals for public review
## Current activities - WS1 - VTL docs (Attilio)
**Requirements**
- Docs generation should be automated (CI/CD like) --> **YES**
  - Single source for different outputs
  - Enable versioning
  - Easily manage releases (current + previous easily reachable
  - Envisaged outputs are HTML github pages ) and PDF
- Docs sources should be readable in github to ease changes tracing --> **YES**
  - … including diagrams if possible
- Examples in the reference guide (vtl code, input and output datasets and structures) should be easily consumed by VTL engines for testing , to ensure alignment with specs and implementations  --> **YES**
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


## Current activities - WS2 - VTL technical issues (Valentino)
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

## Current activities - WS3 - VTL language (Angelo)
- These are the main topics for the next release:
  - User Defined Operators (UDO) (issue #51) 
  - Viral attributes: complete revision
  -	Explicit casting for integer/number to string and viceversa (issues #381, #383 and #394)
  - Join: revise the entire description of the operator (issue #392): Antonio to prepare a proposal to be analysed and discussed

**Actions**
- Viral attributes revision to be prioritised 
## AOB
Next VTL physical meeting will be held before or after TWG. A tentative date will be fixed in May and the location could be in Spain (Salamanca). 

Antonio will try to make arrangements for it.
