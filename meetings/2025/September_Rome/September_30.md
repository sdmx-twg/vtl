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
- A tentative due date will be added for the pull requests by each responsible; the close date for version 2.2 could be the end of 2025
- Angelo will add an example for inner join with weakened constraints
- Angelo will add the (main) attributes for each entity of the Information Model
- Javier and Angelo will circulate a proposal for evolving UDO and upload the document in the current folder; the UDO workstream will take care of defining new pull request(s) for this topic 

## Organizational topics
The next TWG meeting is scheduled in Rome (FAO premises) from 19 to 23 of January 2026; on Friday 23rd (morning) there will be a VTL TF meeting.

The next VTL workshop will be in Paris and will be gently hosted by CASD (thanks to Kamel and Thomas for their courtesy).
