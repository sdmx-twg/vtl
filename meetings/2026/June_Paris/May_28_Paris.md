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
A warm welcome has been given to Cédric Hansen, who joined this meeting and many thanks to Kamel and CASD for
having hosted this workshop. Kamel introduced himself and CASD and explained what they do and why thay are
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
 
Then the new requests coming from CDM-IREF project team were listed; given the current status of the project, they have been put aside at the moment.
If there will be an interest from other users, they will be inserted in the 2.2 release, otherwise they will be postponed to the next VTL version.

Finally the current open topics have been analysed:

3. JSON schema for VTL model schema (PR #665)
4. UDO refactoring (several open issues)
5. Enable expression in lists (PR #567)
6. TCK
7. Time operators

**Actions**:
- Javier will take care of updating the grammar for analytic invocation (**point 1**)
- Nicolas will add links for better description of the methods used in the new string distance operator and a new PR will be created for a fix in the grammar (**point 2**)
- The current version of JSON schema has been approved. After a revision the PR #665 will be merged (**point 3**)
- Since workstreams proved to be ineffective, based on the SDMX TWG experience, workpackages will be defined to work on the current open topics. For each work package a concept note
  will be prepared describing:
  - Objectives
  - Scope and Approach
  - Work plan and Deliverables
  - Participants
- Angelo will take care of UDO refactoring (based on the work done by Antonio, **point 4**) and Enable expression in lists (**point 5**) 
- For TCK (**point 6**) Hadrien opened an issue (#661) to track the activities. Based on it, a devoted workpackage will be defined and Angelo will write a concept note to be presented to SDMX TWG.
- The activities on Time operators (**point 7**) are deprioritized and posponed to next release.
   
## Organizational topics
The tentative date for closing version 2.2 id the end of June 2026.

As priviously noted, the new contributing and governance policy has been approved; the default merge folder is now **develop** and all the feat/* and fix/* branches must be merged into the develop folder.
Valentino will take care of updating the github scripts used for checks; when these changes have been completed, the default "entry" branch will change from **master** to **develop**.
For the meetings folder, a proposal would be moving it to the Wiki space, otherwise it will be hosted in the develop branch.

The current **workstreams** are closed. A new folder will be created and the above mentioned **workpackages** will be defined cointaining the related concept notes. VTL members are kindly requested to join them.

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
