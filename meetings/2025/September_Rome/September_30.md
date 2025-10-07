# SDMX VTL TF Minutes
Physical Meeting: 30 September 2025

Venue: c/o Pontificia Università Gregoriana

## Agenda

|TIME|TOPIC|PRESENTER
|----|-----|------|
|17:30 - 17:40|Welcome of participants and adoption of the agenda|	
|17:40 - 18:15|Current status of issues for 2.2 Release|Angelo
|18:15 - 18:30|Organizational topics|
|18:30 - 18:45|AOB & closing remarks|

## Participants

1.  Angelo Linardi
2.  Antonio Olleros
3.  Daniel Suranyi
4.  Franck Cotton
5.  Gustavo Homem
6.  Javier Hernandez
7.  Kamel Gadouche
8.  Nicolas Laval
9.  Romain Tailhurat
10.  Stefano Pambianco
11.  Thomas Dubois
12.  Ugo Di Zenzo
13.  Valentino Pinna

## Welcome of participants
A warm welcome has been given to Kamel Gadouche, head of CASD, who joined this VTL TF meeting.

## Actions from previous meeting
Angelo went over the activities following the decisions taken in Salamanca's meeting (see uploaded presentation for details). 
The following topics could require some minor code change, the ones on the documentation have already been committed in version 2.2 folder:
- Information Model
- Bechaviour for numerical operators
- Weakened condition for unpivot operator

For the following ones, the number of the issue and the responsible are indicated:

- String distance (#564-567) --> Nicolas
- Cast operator matrix (#586-591) --> Valentino
- Added partition except, with all option (#520-592) --> Antonio/Javier
- Weakening condition for inner join (#596) --> Antonio/Javier
- get_scalar, using membership # operator (#602) --> Nicolas
- JSON schema (#609) --> JSON work stream
- sub operator (#390) --> Antonio/Javier
- New syntax for group all clause --> Since it is a major change, it will be posponed to the next major release (3.0)
- Calculation of attributes (#598) --> An on-line dedicated meeting will be organized by Ugo
- TCK (#565) --> Hadrien/Javier
- Review the versioning model and architecture --> Javier


**Actions**:
- Antonio and Javier will take care of issues #390 (sub operator), #520 (unpartioned analytic invocation), #592 (partition except clause), #595 (unpivot) and #596 (join)
- Nicolas will take care of issue #564 (string distance)
- Valentino will take care of issue #586 (cast operator)
- Angelo will take care of issue #384 (get scalar), will propose a new syntax for "group all" clause, will update the documentation for numerical operator having number as result and will add an exmple for unpivot operator with the weakened constraint

## VTL Information Model
Angelo introduced the current VTL Information Model (see uploaded presentation), listed the reported issues and explained Antonio's proposed changes to it, aimed at simplyfing the use of VTL for specific use cases. In particular it has been argued the necessity of the "Represented Variable" entity and the cardinality of the relation (1..1) with the Data Structure Component entity.

Angelo explained the reasons for maintaining the "Represented Variable" entity in the IM, essentially related to keep the compatibility with other standards (in particular DDI and DPM; for SDMX a suggestion has been made to the TWG to include the "variable" entity in the SDMX IM). In order to weaken the constraint of having variables with only one domain associated at least in the same transformation scheme, consistently with DDI and DPM IM, the cardinality of the relation between Data Structure Component and Represented Variable will be changed from (1..1) to (0..1).

**Actions**:
- Angelo will update the documentation, making the necessary changes to the Information Model chart and its explanation
- Work stream for JSON schema will be make a proposal based on the new assumption

## Workstreams activities for VTL 2.2
For a smooth and efficient management of the activities for VTL 2.2, a coordinator for each workstream has been selected:

- UDO Workstream: Antonio
- JSON schema Workstream: Attilio/Valentino
- New (DL) operators Workstream: Angelo/Laura
- Set of components Workstream: Nicolas/Thomas/Hadrien
- Temporals Workstream: Angelo/Valentino
- New operators Workstream: Angelo/Laura

A folder for each workstream has been created at https://github.com/sdmx-twg/vtl/tree/master/v2.2/workstreams. All VTL TF members are kindly requested to participate in the WS activities.

## Other issues - AOB
A good number of presentations have been sent for approval by VTL TF members for next SDMX Global Conference that will take place in Rome at the end of September 2025. Angelo and Attilio, that are part of the GC Organizing Committee, will do their best to support their approval.
Next VTL Meeting, previously scheduled on Wednseday October 1, will take place as a side event on Tuesday September 30 from 17.15 to 18.45; location and connection details will be communicated in due course.
For next year physical VTL TF workshop two proposals are currently on the table: one from Hadrien (to be hosted in Oslo) and one from Thomas (to be hosted in Paris); probably a decision (about date and location) will be made in the next meeting.
