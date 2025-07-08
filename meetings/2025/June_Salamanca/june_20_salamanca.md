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
- Changes to cast operator: documentation has been updated; missing grammar changes (issue #586)
- Null string: changed documentation to differentiate null string from empty string
- Literals NULL, TRUE, FALSE have been changed to null, true, false according to grammar
- group all clause has been deprecated; a new syntax has to be defined for this clause of aggregate invocation
- partition except clause has been added for analytical invocation; missing grammar changes (issue #592)
- string_distance operator: syntax has to be defined and grammar has to be updated (issue #564)
- get_scalar operator: current proposal for operator will be changed; member operator definition (#) will be suitably modified to get a scalar from a measure or attribute of a data set without identifier components
- 
 

**Actions**:
- Hadrien, Javier and Sebastian to make a proposal for defining input parameters for UDOs (in particular invocation by name, allowing list of components)
- Antonio to prepare a written procedure to define a way for enforcing input types for a UDO (scalars vs components vs datasets)
- Nicolas and Hadrien to define syntax and update the grammar to accept sets as input tu UDOs


#### Temporals in VTL
Valentino described the current issues in implementing time operators and presented some proposals to evolve the time data types. Some of them were not coherent with ISO 8601, the standard to which VTL has to stick to for handling time; moreover, in the next future there will be the need of handling hours, minutes and seconds. So it has been decided to define a workstream to extend time precision in VTL and resolving some controversial topics about time operators.

**Actions**:
- Valentino, Antonio/Javier and Hadrien to make a proposal for improving current time data types to include hours, minutes and seconds and evolving time operators accordingly.


#### Other issues
Angelo presented a proposal for change of the "cast matrix" to solve some issues:
- Number --> Integer: NOT FEASIBLE (use ceil/floor/trunc)
- Integer --> Number: maintain implicit casting. Since Integer is a subtype of Number and Date and Time_period are subtypes of Time, the casting from subtypes to the correspondent type is always implicit, while the casting from types to the corresponding subtypes are always not feasible
- Number --> String: EXPLICIT WITH OPTIONAL MASK (in order to allow thousand separator)
- Integer --> String: EXPLICIT WITH OPTIONAL MASK (in order to allow thousand separator)
- String --> Integer: EXPLICIT WITH OPTIONAL MASK (like String --> Number)

The proposals have been accepted.

Then the topic of how to get a scalar from a dataset was introduced (e.g. to use the result of the count() of a dataset as a scalar to filter some other dataset). Since the result of a count() is a dataset with 1 row, no identifiers and 1 measure, by default named int_var, there is the possibility of getting the desidered outcome applying a join, but it is considered to be too complex. Various proposals have been made, to be chosen via written procedure.

Finally some bugs to be fixed have been presented; some of them were easy to resolve and already applied to the current version (allowing comments in the last line and updating the title of the manuals from "Python" to "VTL documentation"). The bug on allowing valueDomains values starting with "_" (#405) is considered urgent, since some default values in SDMX rely on this naming convention (e.g. "_Z"), while the one regarding string escaping (#395) has been included in the "regex" topic (see session 2). 

**Actions**:
- Angelo to modify the current cast matrix with the accepted proposals
- Antonio to make a proposal for defining a new operator (or modify the membership one) for getting a scalar from a dataset to be approved by written procedure
- All to fix bug #405 as soon as possible (there is a proposal by Valentino to be evaluated)


### Session 2: Language evolution
#### Json metadata descriptor
The current json schema contained in the Technical_note document is not compliant with the VTL Information Model. To align its definition, a devoted workstream has been defined, composed by Antonio, Valentino and whoever wants to contribute.
#### Empty strings in VTL
The way VTL handles empty string is not coherently defined in the documentation. It has been clarified that an empty string is not equivalent to a null string. The current documentation will be accordingly corrected. 
By the way, it has been ascertained that the "null", "true" and "false" reserved words are in lowercase in the grammar, while are written in capital letters in the manuals: the documentation will be corrected according to the grammar.
#### Analytical invocation: partition by
Two issues related to the partition by clause in the analytical invocation are currently open: one to introduce the "partition except" as in the "group except" clause for the aggregation invocation and one to allow partioning without any identifier. 
It has been decided to solve both issues by introducing "partition except" and "partition except all" syntax in the partition by clause. 
#### Add string distance operator - Levenshtein
A proposal for introducing a new string distance operator (Levenshtein at least) has been made. The proposal has been accepted; a written procedure will be launched containing the syntax of the new operator with the specification of which metrics will be accepted.
#### Regex handling
In the current documentation "regexp" is defined in the match_character operator as defined in the POSIX standard. A short survey among VTL engines implementers groups has clarified that only Extended Regular Expressions (not ERE classes) are currently supported.
Since there is an open issue to use patterns to specify lists of components to be used in different clauses (e.g. keep, drop, group by, partition by), a proposal about how to implement this use cases will be made by Hadrien, Nicolas and Javier.
#### Grouping clause with expressions
An open issue (#456) to change the syntax of the groupingClause allowing also expressions (e.g. c1+c2) was discussed. 
The resulting expression should have renamed and the change in the groupingClause would be very complex; the decision was not to introduce this change, since the workaround (using two expression) is much simpler. 
By the way, a proposal to drop the "group all" option has been made; since the change would be not back-compatible, for now it will be deprecated and dropped in the next major release.

**Actions**:
- A new workstream, whose members are currently Antonio and Valentino, will work on a new version of the JSON schema to align it to the VTL Information Model. Any other member/attendee can join and contribute.
- Angelo will make corrections in the current documentation to find and fix parts in which an empty string is considedred equivalent to a null string. He will also convert to lowercase the reserved words "FALSE", "TRUE" and "NULL" wherever they are written in capital letters in the manuals.
- A new "partition except" clause will be introduced for the analytic invocation, together with the possibility to specify "all" to allow no partition (or partition by no identifiers).
- A new operator for evaluating the distance between two strings will be defined; Hadrien and Nicolas to make a proposal for its syntax, that will allow to specify which metric to use (Levenshtein in primis) that will be approved via written procedure.
- Angelo to specify in the documentation that only POSIX Extended Regular Expressions (not ERE classes) are currently supported by VTL.
- A new workstream, whose members are at the moment Hadrien, Nicolas and Javier, will define how to specify lists of components to be used in different clauses (e.g. keep, drop, group by, partition by).
- Angelo to add a note in the documentation to deprecate the "group all" option for group by clause.


## Day 2 Wednesday 26th  March
### Session 3: Discussion on other topics
#### New Definition Language operators
Angelo introduced the topic, reminding that in the past versions several attempts have been made to introduce new DL operators to the two actually defined (define datapoint and define hieararchical ruleset).
Since in the Technical_Notes document some "hints" have been produced, it could be worth defining new DL operators to define structures, valueDomains and variables; Valentino, Laura and Angelo are volunteering for making a proposal.
#### Pivot and unpivot operators
According to the current version, for unpivot operator "All the measures of op must be defined on the same ValueDomain". Since this could not be the case for measures with different types when implicit casting is allowed, based on the previous discussion about cast operator, this restriction could be weakened and changed in "All the measures of op must be within the same scalar type, including subtypes".
More broadly speaking, all the operators that could imply data type changes within the same scalar type (e.g. division of two integers) are not “operators which change the basic scalar type” (see User Manual – VTL Operators). This statement (proposed wording: type generalisation) should be explicitly inserted in the User Manual and recalled (linked) whenever needed.
#### Components, variables and domains
Antonio introduced the topic, outlining pratical problems that may arise with the entity Data Structure Components stricly linked (relationship 1:1) with the entity Represented Variable in the Information Model:
- In the Transformation Schemas there could be hundreds of tranformations with many non-persistent datasets which do not need any represented variables to be associated with
- If input dataset are coming from different agencies, diffenent datasets can have the same name for data structure components with different meanings (and valueDomains); this frequently happens for SMDX datasets with OBS_VALUE, since the entity (Represented) Variable is not in SDMX Information Model and the relationship between Concept and Representation has cardinality 0:1.
So his proposal would be (in order of preference):
- Removing the entity Represented Variable from VTL Information Model
- Keep the entity Represented Variable, but only as "conceptual link" to data dictionaries
- Change the cardinality in the relationship between Data Structure Component and Represented Variable from 1:1 to 0:1.

Angelo observed that:
- VTL IM is more "general" than the SDMX one, being derived from GSIM and since VTL is used also with other standards (DDI and in the next future DPM), it does not seem viable to change it
- In the case of using "same name with different meanings" as OBS_VALUE, it would be much better to guarantee name uniqueness (at least) in the same Transformation Schema
- It is true that the problem of having diffenent datasets with the same name for data structure components with different meanings is "hidden" in non-persistent datasets, but with persisent assignments the problem arises (e.g. having two columns in a DBMS with the same name and different meanings and possibly different data types would result in a inconsistent data model).

A very heated discussion followed on this topic with differing opinions. Due to time constraints the topic will be brought up again at other meetings. In the meantime Antonio will provide real use cases (i.e. transformation schemas with this issue) and VTL TF will try to analyse them and propose solutions. The topic will be also brought by Angelo and Franck to the attention of working groups within SDMX TWG and UNECE that are discussing about interoperability between SMDX and other standars (in particulare DDI and BPM) to collect some "external" opinions about it. 
The related "JSON metadata descriptor" workstream will take the current VTL Information Model as the reference version.
#### Versioning JSON schema
