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

**An "add-on" to integrate the core VTL TCK with the SDMX TCK one will be implemented by Meaningfuldata**

**A request for funding will be submitted to the SDMX Secretariat to support the initiative**

### Actions
- Angelo and Javier will present the initiative during the next SDMX TWG meeting on 16th June 
- Angelo will submit a funding request to the SDMX Secretariat in the next meeting on the 17th June  

## Workpackages and housekeeping
The current workstreams will be deleted.
Three new workpackages will be created: a concept note containing objectives, planning and deliverables will be available for every workpackage.
These are the 3 groups (in bold the coordinator):

1. **TEMPORALS**:       **Javier**, Angelo, Hadrien
2. **UDOs**:            **Antonio**, Laura, Nicolas, Valentino
3. **STANDARD ERRORS**: **Javier**, Hadrien, Valentino

Other VTL members are kindly requested to join them on a voluntary basis.

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

The next VTL workshop will take place in Paris from Thursday May 28th morning to Friday 29th early afternoon (after lunch), gently hosted by CASD.

## AOB
Javier showed the versioning model and architecture of the Meaningful data gitHub repository. The TF members appreciated it and decided to adopt the presented approach.
Valentino and Javier will take care of introducing the new scripts and architecture in the VTL gitHub environment.

Javier presented a document containing the error code structure and content of Meaningful data tool. The TF members agreed to take it as the initial version for the VTL error codes.
Javier will clean it, deleting the contents specific for their tool, upload it in the VTL gitHub repository and insert a link in the Technical Notes document.

The SDMX TWG asked VTL TF to review the changes in SDMX-IM for VTL objects in order to be aligned to the last version of SDMX. Javier, who is the TWG responsabile for this task, will
track the needed activities to be completed by the end of March 2026.

Dario outlined the need to promote the use of VTL within the National Statistical Institutions; VTL members are kindly required to explore if any initiative could be adopted for a 
broader adoption of VTL in the statitical organisations.
