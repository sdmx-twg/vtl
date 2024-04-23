# SDMX VTL TF Minutes

Physical Meeting: 26th May 2023 09.00-17.00CET

## Participants

1.  Angelo Linardi
2.  Antonio Olleros
3.  Carlos Morillo Gálvaz
4.  Daniel Suranyi
5.  Daniele Olivotti
6.  Edoardo Greising
7.  Franck Cotton
8.  Jens Dossé 
9.  Juan Muñoz López
10. Nicolas Laval
11. Pedro Carranza
12. Stratos Nikoloutsos
13. Valentino Pinna
14. Angela Gattulli (remote) 
15. Attilio Mattiocco (remote)
16. Bianca Ligani (remote)
17. Dario Camol (remote)
18. Laura Vignola (remote)
19. Matthew Nelson (remote)
20. Thomas Dubois (remote)

## Introduction and adoption of the agenda (Angelo)
Try to find and solve the reasons for current general hesitation to use VTL. Target audiences to convince: 
-	Users: good doc, training, get started guides
-	Managers: SDMX sponsors to communicate on task force relaunch, spread in other communities 
Having and knowing about available user tools is very important. Better advertise VTL tools: self-declaring and integrated with SDMX tools
Clarify VTL business case (video?)

Current initiatives:
-	INSEE: implemented TREVAS engine for distributed environments 
-	Meaningful data: Implemented VTL engine 
-	Banca d’Italia: implemented open-source VTL engine & editor, prove of concept, Matrix model and Expression Language (EXL)
-	ISTAT: Developed ‘VTL ISTAT Framework’ to parse VTL into SQL (supported dialects: Oracle SQL, T-SQL, MySQL and Postgresql): VTL Framework, instance: VLT Framework Light App

Note: Other VTL implementations: 
-	BIRD: Banking Integrated Reporting Dictionary 
-	Statistics Finland : Editing and imputat.service – (SAS engine)
-	Statistics Poland : VTL - SQL translation
-	Statistics Norway : Java-VTL
-	Eurostat: VTL CONVAL VRM
-	European Central Bank : Balance Sheet Items Pilot, VALICE

User/Reference Manual corrections
-	Several corrections of mistakes were made
-	Relaxed condition type on ‘if-then-else’ operator (lines 6664/6666)

Document and community management
-	SDMX secretariat: Make VTL as open as possible, but don’t abandon VTL outside SDMX, give sufficient support to VTL
-	Official Documentation should be moved into SDMX-TWG GitHub repo and converted into md (easier consultation, issue mgmt., revisions), It should be clear that VTL does not have functional dependencies on SDMX
-	To many open issues still waiting in the old site (not being answered) – issues should be answered
-	VTL community site is still useful for exchanging on practical usage and experiences with links
-	INSEE will look into the translation from doc to md

Actions: 
-	TWG to create a new SDMX-TWG GitHub repo for official VTL documentation
-	INSEE to translate current doc into (if possible multi-page) markdown

## VTL & SDMX 3.0: multi-measure and attribute calculation (Antonio)
Note: VTL already supports multiple measures
1)	Adding/changing data types/operators for multi-values
- Operation for ordered lists of different lengths
- Operation of different data types
- Operation for union and for distinct union
Action: Antonio to go through all operators and propose a behaviour for multi-valued values
2)	Geospatial types and operators
- Need for new VTL types/operators?

**Action**: Ask question to community if this is necessary and would become a priority.
3)	Relaxing constraints for some multi-measure operators
- Some prefer not allowing check operation on multi-measure datasets. No conclusion.
4)	‘Viral‘ attribute calculations/propagation
- Recognise that this is an issue to be addressed.
- How to specify the virality rules.

## VTL 2.x: new operators, evolution demand (Antonio)
The list of currently known issues and needs was presented by MeaningfulData:
-	Get the difference between 2 dates
-	Add an amount of time to a date
-	Get year, month, day, … from a date/datetime
-	Create a date/datetime from year, month, day, …
-	Bring back definition language or use other standard format (e.g., JavaScript or csv) to ensure that everything required for VTL execution is portable between applications, features: importing, listing masking, proposal ready by Antonio
-	Operator to retrieve scalar from mono-measure, non-dimensional dataset or retrieve sets (set of distinct values) from mono-measure dataset. Needs to review ‘in’ and ‘set’ operators
-	Nullability as property of non-key components, in addition intentionally missing values and switched-off dimensions for higher-level attributes 
-	Case/switch
-	Add class (e.g., ‘Module’) between TransformationScheme and Transformation for maintainability of large VTL TransformationSchemes
-	Role changing from measure to identifier when the measure is not nullable
-	Document in Calc how to define the type of an empty (nulled) component, by using cast(null, <type>)
-	Clarify applicability of time operators (e.g., time aggregation) depending on data types
-	Clarify that there are different variable naming scopes (user-defined operators, value-domains, datasets, sets, components, hierarchical rulesets,  …)
-	Clarify if references inside UDOs to non-declared VTL objects are allowed
-	Mask for casts
-	Order for Boolean
-	Escape reserved words – should be part of the specification
-	For identifiers of type string, are null values considered being empty strings? 
-	Comparison of overlapping time periods – to be checked with ISO
-	Relaxing join constraints when using NVL operator – add possibility to use different default value for resulting NULLs in identifier columns
-	Pivot function implementation not possible - because the resulting data structure is undefined at compile time
-	Facilitate measure aggregation with ‘group by’ operations
-	Remove optional implementation approaches

**Action**: The TF to go through list and propose solutions

## VTL TF: call for participants
The following participation was proposed:
-	Banca d’Italia: Angelo, Attilio, Valentino
-	ECB: Stefano, Daniel, Katrin Heinze
-	OECD: to be confirmed
-	INSEE: Franck, Nicolas, Thomas (others to be confirmed)
-	Meaningful data: Antonio
-	ISTAT: Laura, Dario
-	ILO: Edgardo, Shutong Ding
-	Eurostat: to be confirmed

**Action**: Call could be extended to other NSIs.

## Wrap-up and closing
Identify at least 3 work streams:
1)	General topics: documentation
	
**Lead by**: Attilio, Stefano

Help for GitHub by Stratos and Franck

Participants: Daniel, Franck, Laura, Antonio, Thomas, Romain
2)	Virality and nullability, new data types, …

**Lead by**: Valentino

Participants: Jesùs Simon, Nicolas, Florian (INSEE, Vucko) 
3)	Others (other new operators, changes listed above, …)

**Lead by**: Angelo

Participants: Javier, Nicolas, Laura, Dario, Katrin

Work streams work autonomously and meet regularly. Will report on progress in regular TWG meetings.

**Goal**: VTL 2.1 or 3.0 draft version by end of the year. Patches can be done progressively while progressing.
