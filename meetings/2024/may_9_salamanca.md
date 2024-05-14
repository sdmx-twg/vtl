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


## Current activities - WS2 (Valentino)
**Work done**
- Proposals for some topics have been produced, but they have been put on hold waiting for use cases: geospatial operators, virality of the attributes, null values behaviours
- JSON artifacts have been proposed in order to define valued domains and structures

**Null values**

Having taken a look at JSON artifacts, Angelo reminded that in the User Manual there is a very clear statement about null values: all measures and attributes (not dimensions) can contain null values by default; so the proposals made should be modified in order to be compliant to the standard 

Antonio replied that perhaps a major change to the Information Model should be envisaged in order to know “at first glance” if a measure/attribute is “nullable” or not

Franck reminded that current IM has been defined according to GSIM and that VTL users not following SDMX (e.g. DDI) could be heavily impacted by a major change of the IM

**Actions**
- Antonio/Javier to write a proposal about how to handle null values/sets in VTL
- WS2 to modify current JSON artifacts in order to be strictly compliant to current standard

## Current activities - WS3 (Angelo)
**Work done**
- New operators have been defined; the Reference Manual has been update accordingly
- Some changes to existing operators and to default behaviours have been agreed; Reference Manual has been update accordingly

**New operator for calculating OBS_STATUS attribute**

In last VTL meetings a proposal had been made to define a new operator for OBS_STATUS; it has been noted that the new case operator will allow to easily define expressions to implement the related “algebra”, given also the fact that several codelists are commonly used by different organisations. So no such operator will be defined

**Actions**
- Version 2.1 can be considered “frozen”
- The new version of the documentation will be distributed among participants, with the new/changed parts highlighted in order to facilitate the revision

## Current collaboration activities
Currently some collaborations are active:
- SDMX.io (VTL adoption/integration in FMR): BIS and Banca d'Italia
- UN Pilot: UN and Banca d'Italia
- ECB adoption for IREF/ CDM Programme: ECB and Banca d'Italia
 - OECD PoC: OECD and Banca d'Italia (just started)

**Actions**
- Every organisation is invited to share information about collaborations on VTL
- Angelo will contact the Secretariat to see if a new section can be added in the VTL web home page to add the links to the documentation of the VTL engines currently available

## VTL 2.1 release planning

**Actions**
- A new document will be added with VTL 2.1 version. The title will be Technical Notes and WS2 will be in charge of writing; it will contain the following topics:
- 	JSON (and XML?) format for valued domains and structures
- 	API invocation parameters and other technical information for calling VTL engine from external environments
- 	Run-time common error codes and messages occurring during importing data/metadata not compliant with VTL IM
- 	 Version 2.1 can be considered “frozen”
- The new version of the documentation will be distributed among participants, with the new/changed parts highlighted in order to facilitate the revision
- The new format of documentation will not be related to version 2.1; so VTL version 2.1 will be released independently from the availability of the new formatted documents

## AOB
Next VTL physical meeting will be held before or after TWG. A tentative date will be fixed in May and the location could be in Spain (Salamanca). 

Antonio will try to make arrangements for it.
