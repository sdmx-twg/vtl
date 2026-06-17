# SDMX VTL TF Minutes
Workshop: 28-29 May 2026

Venue: CASD 
Polaris 76, avenue Pierre Brossolette 92 240 Malakoff - Paris

## Agenda

### Day 1 Thursday 28th  May
|TIME|TOPIC|PRESENTER
|----|-----|------|
|09:00 - 09:15|Welcome coffee|	
|09:15 - 09:45|CASD presentation, logistics, location, social program|Kamel/Thomas
|09:45 - 10:00|Adoption of the agenda|Angelo
|10:00 - 11:00|Release of VTL version 2.2|Angelo
|11:00 - 11:15|Coffee break|
|11:15 - 12:00|Open topics: TCK & others	
|12:00 - 12:30|Interaction of VTL TF with other statistical working groups|Angelo/Attilio/Javier
|12:30 - 13:00|Current situation and evolution
||Banca d'Italia|Attilio/Valentino
||Makingsense & HK consulting|Franck/Nicolas
||Meaningful Data|Antonio/Javier
|13:00 - 15:00|Lunch|	
|15:00 - 16:00|Workpackages: Temporals and UDO
|16:00 - 16:15|Coffee break|
|16:15 - 17:30|GitHub repository housekeeping

21:00	  Social event (dinner)  

### Day 2 Thursday 29th  May
|TIME|TOPIC|PRESENTER
|----|-----|------|
|09:00 - 09:15|Welcome coffee|	
|09:15 - 10:00|New operators for v. 2.3|Angelo
|10:00 - 11:30|Feedback from VTL users	
||CASD
||ECB/NCBs (CDM project)
||NBB
||Banca d'Italia
|11:30 - 11:45|Coffee break|	
|11:45 - 12:30|Tour-de-table on organisational issues
|12:30 - 13:00|AOB & conclusion|Angelo
|13:00| Lunch

## Participants

1.  Angelo Linardi
2.  Antonio Olleros
3.  Cédric Hansen (CASD)
4.  Franck Cotton
5.  Hadrien Kohl
6.  Javier Hernandez
7.  Kamel Gadouche
8.  Nicolas Laval
9.  Romain Tailhurat
10.  Thomas Dubois 
11. Ugo Di Zenzo  
12. Valentino Pinna
13. Attilio Mattiocco (remote)
14. Dario Camol (remote)
15. Giulia Pennè (remote)
16. Katrin Heinze (remote)
17. Laura Vignola (remote)
18. Noah Boerger (remote)
19. Stefano Pambianco (remote)
20. Tanguy Aubert (remote)

## Welcome of participants
A warm welcome has been given to Cédric Hansen, who joined this meeting, and many thanks were givent to Kamel and CASD for
having hosted this workshop. Kamel introduced himself and CASD and explained what they do and why they are
using VTL in their business processes (his presentation is attached).
Then Thomas gave some information about logistics and organisational topics.

## Release of version 2.2
Angelo went over the topics related to the work done for VTL 2.2 version (see uploaded presentation for details): 
- Bug fixing (as of May 2026)
- Documentation-only changes
- Major changes already merged in 2.2 folder (develop branch):
  - New version of cast matrix
  - Added partiotion except clause (with all option) in the analytic invocation
  - New join operators
  - Scalar extraction from a data set
  - New DL operator for defining viral propagation
  - New string distance operator
  - Use of varId instead of scalar for some operators

Given the number and the value of the changes and new operators introduced, it has been decided that:

**The 2.2 release will be announced to the SDMX Secretariat and a public review will be launched**

**VTL 2.2 version will be frozen at the end of June and will be officially published at the end of September, leaving 3 months for public review**
  
An open discussion followed this presentation and a number of further updates has been approved (Romain will investigate if a different behaviour is applied by other programming languages):
1. To avoid backward incompatibility, in the cast matrix the transformation from number to integer will behave in this way ():
   - The resulting number will be the non-decimal part of the input
   - A warning message will be raised to notify the user that the "default" behaviour has been adopted
2. The result of the stddev_samp operator applied to a dataset with only 1 observation will be *null* and a warning message will be raised
 
### Actions
- Angelo will announce the release of VTL 2.2 during the next SDMX TWG meeting, that will take place in the week 15-18 June
- Romain will notify if behaviours different from the ones before described should be implemented; if not, Angelo will update the documentation accordingly before the end of June
- At the end of September Angelo will merge the develop 2.2 branch into the master branch and update the current release pointer from 2.1 to 2.2  
   
## Open topics: TCK & others
Nicolas (Making Sense) and Javier (Meaningfuldata) presented their proposals to implement a TCK for VTL (see presentations uploaded).
The goal is to publish in the VTL gitHub repository an application able to:

1. Extract, for each operator, the examples from the documentation
2. Generate TCK files and produce a zip file

The structures of the input/output data will be compliant with the JSON schema published in the gitHub repository and the data will be in csv format.

Every VTL engine should be able to load the produced zip file, load and run all the examples and produce the result of the tests.

An open discussion followed these presentations; these are the decisions that have been made:

**A "core" VTL TCK will be implemented with the contribution of Banca d'italia, Making Sense and Meaningfuldata**

**An "add-on" to integrate the core VTL TCK with the SDMX TCK will be implemented by Meaningfuldata**

**A request for funding will be submitted to the SDMX Secretariat to support the initiative**

### Actions
- Angelo and Javier will present the initiative during the next SDMX TWG meeting on 16th June 
- Angelo will submit a funding request to the SDMX Secretariat in the next meeting on the 17th June  

## Interaction of VTL TF with other statistical working groups
Angelo informed that by the end of June there will be a meeting of the Working Group 2 of the ISO Technical Committee 154 of ISO to promote the kick-off of the process for VTL.
If the proposal will be accepted, an ISO number will be assigned for VTL together with an approval for a Preliminary Work Item to be prepared.
The official presentation will then scheduled for the Plenary Meeting at the end of August.

Attilio informed that a "VTL white paper" is being prepared within the Working Group for Statistical Information Management of the SEBC by the end of the year.
The participants are members of 5 National Central Banks: France, Belgium, Croatia, Netherlands, ECB and Banca d'Italia (Angelo and Attilio).
The document will be pretty short (4 chapters, 20-35 pages maximum) and will contain:
1. Introduction to the VTL language - Strategic vision for decision-makers and stakeholders
2. Practical presentation of the VTL language - for Statistical and IT Teams
3. Current projects and implementations
4. Future projects

Drafts of the document will be shared among VTL TF as they will be made available.

Javier informed that the work for aligning VTL with SDMX is in progress; the goal is to update the Section 6 of SDMX (containing the relation vith VTL) by the end of the year, 
when SDMX 3.2 release will be published. 

## Current situation and evolution of VTL engines
Valentino informed that the VTL E&E by Banca d'Italia will be updated to be compliant with VTL 2.2 by the end of the year. Furthermore, Banca d'Italia will actively participate in 
the VTL TCK implementation.

Javier presented the last evolutions of the Meaningful Data vtl engine. In the back-end moved from pandas to duckdb, resulting in better understanding of VTL internal behaviour 
for final users (given the native translation from VTL to SQL), much better performances and enabling to handle big datasets (larger than available memory).
The alignment with VTL version 2.2 will be completed by the end of June. Finally, SDMX compatibility has been improved, using pysdmx. More information is available in the
uploaded presentation.

Nicolas presented the new features of Trevas, first of all the use of Spark 4, resulting in better performances, improved stability and security with reduced infrastructure costs,
enhanced modularity for API; the release of the new version is expected for the end of June. Then the showed the current TCK used internally by Trevas, which can be used
as a common basis to implement VTL TCK. More information is available in the uploaded presentation.

## Workpackages
The current workstreams will be deleted.

Three new workpackages will be created: a concept note containing objectives, planning and deliverables will be available for every workpackage.

These are the 3 groups (in brackets the coordinator):

1. **TEMPORALS**:       **[Javier]**, Angelo, Hadrien
2. **UDOs**:            **[Antonio]**, Laura, Nicolas, Valentino
3. **STANDARD ERRORS**: **[Javier]**, Hadrien, Valentino

Other VTL members are kindly requested to join them on a voluntary basis.

## GitHub repository housekeeping
For the housekeeping of the VTL gitHub repository the following activities will be performed:
- Creation of (3) Teams: Banca d'Italia, Making Sense and Meaningfuldata; all the reviews/approvals will be addressed to Teams and not to singular members
- Automatic merge into the develop branch will be activated once the requested approvals have been collected
- Move the Meetings folder to the Wiki: the current folder in the develop branch will be used just for draft documents
- Define a security role responsible for vulnerability patch management related to the git software; Javier will be delegated for this role
- Add a "Learning material" folder to collect all documents/presentations/apps used by VTL TF members for training

### Actions
- Angelo will remove the workstreams folder and create a workpackages one, adding the corresponding concept notes.
- Angelo, Valentino and Javier will define the Teams and implement the check mechanism to assign reviews only to Teams
- Angelo, Valentino and Javier will implement the automatic merge into the develop branch once the needed approvals have been collected
- Valentino will copy the Meetings folder to Wiki; the current Meeting folder in develop will be used only for drafting documents 
- Angelo, Valentino and Javier will define the Security role and assign the responsability to Javier
- Angelo will define a new folder for Learning/Training material   

## New operators for v. 2.3
A Slido live survey has beeen presented with the list of the requests for evolution of current operators and new ones; this is the outcome of the survey, starting 
from the one that received more preferences:
1. Percentile
2. Set operators
3. Weights
4. Allow components for time operators
5. Group by not-null measures and Measures in group by
6. Add more methods to rank
7. Scientific notation

Besides this list, also the enabling of expressions in lists (#567) will be implemented in version 2.3

## Feedback from VTL users
Kamel and Thomas informed that CASD is actively working on VTL, especially trying to "convince" their users to adopt it for their statistical processes.
They are also working on the transformation of SAS programs to VTL and on the "mapping" betweeen DDI and VTL. 
Angelo asked Thomas and Kamel to share any material on this topics with VTL TF, even in draft, especially about the second one, 
since a paragraph of the cited "white paper" about the relation on VTL with DDI is to be written.

Noah presented the current status of the adoption of VTL within the CDM project. Due to cost reductions, at the beginning validations and transformations rules
will be expressed in SQL, but the adoption of VTL remains a valid option (see upoladed presentation for further details). Angelo replied that Banca d'Italia,
to perform L2 checks betweeen IREF "core" data and the italian "local data" (Country Specific Requirements), will anyway "translate" all IREF validation and 
transformation rules in VTL (see below).

Ugo informed that National Bank of Belgium is currently using VTL in some statistical processes and that more extensive use of it is currently planned.
He thanked VTL TF for the prompt definition of propagation rules for viral attributes in version 2.2, since it is a crucial operator for their needs.

Angelo also informed that Banca d'Italia's statistical platform (INFOSTAT) will be re-engineered, moving from the current Software Oriented Architecture to a cloud-based
infrastructure. Within this big project, current proprietary Expression Language used for validations and transformations will be replaced by VTL.
Another very important project will start in October aimed at renewing the statistical application used by the Supervision Department; also in this case the new application
will use VTL to perform validations and transformations. In both projects it will explored the possibility to use AI to "translate" validations and transformations 
expressed in natural language to VTL statements, in order to support statistical users in using VTL. Any material on this topic, also in draft, will be shared within VTL TF.

## Tour-de-table on organisational issues
At the beginning of the section, a Slido was prepared to understand which are the major issues of the VTL TF regarding the organisation.
The outcome showed that the major issues are related to sponsorship and funding, followed by the need of "attracting" customesrs and institutions and be more visible. 
In the different seminars, workgroups and statistical events all VTL TF members are invited to promote the use of VTL by main international bodies. 
In this sense BIS, UN and Eurostat will be contacted during next SDMX TWG meeting and Expert Workshop.
VTL members are kindly required to explore if any initiative could be adopted for a broader adoption of VTL in the statitical organisations.

## AOB
Antonio presented two use cases about the way they are presenting VTL failed checks to the final users and the documentation of the "eval" operator in order to preserve data lineage.
Angelo will share some information about the "error wrapping" in Banca d'Italia and asked Antonio to draft a proposal for the eval operator.

Javier presented the current version of the document containing the error code structure (to be integrated with the agreed "warnings" to be raised for "casting from number to integer"
and "stdev_samp with 1 observation"). The document will be uploaded in the VTL gitHub repository and a link to it will be inserted in the Technical Notes document.

The next VTL workshop, to be scheduled in May-June 2027, will be probably hosted by the National Bank of Belgium; Ugo will follow-up about this proposal.
