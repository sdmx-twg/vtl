# SDMX VTL TF Minutes

Physical Meeting: 14th December 2023 13.00-16.30CET

## Participants

1.  Angelo Linardi
2.  Antonio Olleros
3.  Javier Heranandez
4.  Thomas Dubois
5.  Attilio Mattiocco (remote)
6.  Franck Cotton (remote)
7.  Nicolas Laval (remote)
8.  Valentino Pinna (remote)
    
## Current activities - WS1 (Attilio)
**Goals**
- Docs generation should be automated
- Single source for different outputs: HTML (github pages) and PDF
- Not clear how to handle current version + releases
- Docs sources easily readable and changes traceable
- Examples in Reference Manual (VTL code, input/output datasets) automatically included in test suite
- Current documentation to be migrated to new format

**Work done by Makingsense-INSEE**
- https://making-sense-info.github.io/VTL-Docs/
- Docusaurus used (https://docusaurus.io/)

**Work done by Banca d'Italia**
- https://github.com/vpinna80/test_docs
- Sphinx used (https://www.sphinx-doc.org/en/master/)

**TWG feedback**
- Many issues are common to VTL and SMDX docs
- Some members of TWG could be included in the WS1 activities (Luis Gonzales Morales from UNSD, Carlos Morillo from Banco de España)
- 2024-Q1 to have technical specifications (which tools to use, how to deal with versioning, how to perform the “massive translation” of the current documentation) and project planning

**Actions**:
- Get a pilot for some operators with all the contents (text, VTL scripts, I/O datasets with their structures, schemas and graphics) by the end of January 2024
- Contact TWG people to get them involved (on a voluntary basis)

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

