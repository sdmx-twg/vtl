# SDMX VTL TF Minutes
Physical Meeting: 30 January 2026

Venue: Food and Agriculture Organization of the United Nations 
Viale delle Terme di Caracalla, 00153 Roma RM

Room: King Faisal Room (second floor, D263)

## Agenda

|TIME|TOPIC|PRESENTER
|----|-----|------|
|9:00 - 9:30|Welcome of participants and adoption of the agenda|	
|9:30 - 10:45|Current status of version 2.2|Angelo
|10:45 - 11:00|Coffee break|
|11:00 - 11:45|Organizational topics|
||- Closure of version 2.2|
||- Governance policy|
||- Current workstreams: still valid or to be changed/reshuffled/closed?|
||- TCK activities (possible funding?)|
||- Pending “dead” issues to be closed|
|11:45 - 12:15|AOB and closing remarks|

## Participants

1.  Angelo Linardi
2.  Antonio Olleros
3.  Attilio Mattiocco
4.  Daniele Mansillo
5.  Dario Camol
6.  Giulia Pennè
7.  Javier Hernandez
8.  Juan Munoz
9.  Valentino Pinna
11.  Katrin Heinze (remote)
12.  Franck Cotton (remote)
13.  Jesus Simon (remote)
14.  Laura Vignola (remote)
15.  Nicolas Laval (remote)
16.  Romain Tailhurat (remote)
17.  Tanguy Aubert (remote)
18.  Thomas Dubois (remote)
19.  Ugo Di Zenzo (remote) 

## Welcome of participants
A warm welcome has been given to Juan Munoz, from INEGI, who joined this VTL TF meeting.

## Current status of version 2.2
Angelo went over the topics related to the VTL 2.2 version (see uploaded presentation for details): 
- Bug fixing
- Major changes already merged in 2.2 folder (master branch):
  - New version of cast matrix 
  - New join operators
  - Scalar extraction from a data set
  - New DL operator for defining viral propagation 
- Documentation-only changes

**Given the newly adopted contributing and governance policy the following changes have been merged into the develop branch 
   and are waiting for grammar changes and/or new pull requests:**

 1. Addition of the partition except (with all option) in the analytic invocation
 2. New string distance operator

Then the new requests coming from CDM-IREF project team were listed; given the current status of the project, they have been put aside at the moment.
If there will be an interest from other users, they will be inserted in the 2.2 release, otherwise they will be postponed to the next VTL version.

Finally the current open topics have been analysed:

3. JSON schema for VTL model schema (PR #665)
4. UDO refactoring (several open issues)
5. Enable expression in lists (PR #567)
6. TCK

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


