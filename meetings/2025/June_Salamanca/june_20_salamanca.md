# SDMX VTL TF Minutes
Physical Meeting: 20 June 2025

Venue: c/o Pontificia Universitad Salamanca

## Agenda

|TIME|TOPIC|PRESENTER
|----|-----|------|
|09:30 - 09:45|Welcome of participants and adoption of the agenda|	
|09:45 - 10:15|Actions from previous meeting|Angelo
|10:15 - 11:00|VTL Information Model|Angelo
|11:00 - 11:15|Activities from Workstreams from VTL 2.2|	
|11:15 - 11:30|Coffee break|
|11:30 - 12:30|Other issues - AOB|
|12:30|Lunch - End of meeting|

## Participants

1.  Angelo Linardi
2.  Antonio Olleros
3.  Attilio Mattiocco
4.  Daniele Mansillo
5.  Denis Grofils
6.  Javier Hernandez
7.  Juan Lopez Munoz
8.  Arturo San Feliciano (remote)
9.  Dario Camol (remote)
10. Franck Cotton (remote)
11. Frederik Van Hecke (remote)
12. Giulia Pennè (remote)
13. Gustavo Homem (remote)
14. Jesús Miguel Simón Martín (remote)
15. Josè Maria Fernandez (remote)
16. Katrin Heinze (remote)
17. Laura	Vignola (remote)
18. Nicolas Laval (remote)
19. Oeyen Hilde (remote)
20. Sergey Grebenshchikov (remote)
21. Thomas Dubois (remote)
22. Ugo Di Zenzo (remote)
23. Valentino Pinna (remote)

Deodoro, Jose

## Welcome of participants
A warm welcome has been given to Juan Lopez from INEGI, to Daniels Grofils from Pacific Community and to Daniele Mansillo from FAO who joined this VTL TF meeting; Oeyen Hilde from National Bank of Belgium breifly introduced himself as new member of VTL TF.

## Actions from previous meeting
Angelo went over the activities following the decisions taken in Frankfurt's meeting (see uploaded presentation for details):
- Bug fixes
- Changes to cast operator: documentation has been updated; grammar changes to be applied (issue #586)
- Null string: changed documentation to differentiate null string from empty string
- Literals NULL, TRUE, FALSE have been changed to null, true, false according to grammar
- group all clause has been deprecated; a new syntax has to be defined for this clause of aggregate invocation
- partition except clause has been added for analytical invocation; grammar changes to be applied (issue #592)
- string_distance operator: syntax has to be defined and grammar changes have to be applied (issue #564)
- get_scalar operator: current proposal for operator will be changed; member operator definition (#) will be suitably modified to get a scalar from a measure or attribute of a data set without identifier components
- Data type change within the same (basic) scalar type: documentation has been updated. It is envisaged that for every numeric operator 
eventually involved (es. division, logarithm) a specific behaviour will be added in order to state that the result of such operators will be always a number
- unpivot operator: the actual constraint has been weakened; in addition to grammar changes (issue #595), a specific example will be added in the documentation with the new (weakened) constraint
- Allowing inner join with one common identifier; grammar changes to be applied (issue #596)

**Actions**:
- Antonio and Javier will take care of issues #390 (sub operator), #520 (unpartioned analytic invocation), #592 (partition except clause), #595 (unpivot) and #596 (join)
- Nicolas will take care of issue #564 (string distance)
- Valentino wil take care of issue #586
- Angelo will take care of issue #384 (get scalar), will propose a new syntax for "group all" clause, will update the documentation for numerical operator having number as result and will add an exmple for unpivot operator with the weakened constraint

## VTL Information Model
Angelo introduced the current VTL Information Model (see uploaded presentation), listed the reported issues and explained Antonio's proposed changes to it, aimed at simplyfing the use of VTL for specific use cases. In particular it has been argued the necessity of the "Represented Variable" entity and the cardinality of the relation (1..1) with the Data Structure Component entity.

Angelo explained the reasons for maintaining the "Represented Variable" entity in the IM, essentially related to keep the compatibility with other standards (in particular DDI and DPM; for SDMX a suggestion has been made to the TWG to include the "variable" entity in the SDMX IM). In order to weaken the constraint of having variables with only one domain associated at least in the same transformation scheme, consistently with DDI and DPM IM, the cardinality of the relation between Data Structure Component and Represented Variable will be changed from (1..1) to (0..1).

**Actions**:
- Angelo will update the documentation, making the necessary changes to the Information Model chart and its explanation
- Work stream for JSON schema will be make a proposal based on the new assumption
