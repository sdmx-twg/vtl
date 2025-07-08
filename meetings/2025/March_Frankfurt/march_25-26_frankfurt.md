# SDMX VTL TF Minutes
Physical Meeting: 25-26th March 2025

Venue: c/o ECB - Japan Center - Taunustor 2, Frankfurt am Main

## Agenda

### Day 1 Tuesday 25th  March
|TIME|TOPIC|PRESENTER
|----|-----|------|
|09:30 - 09:45|Welcome of new participants and adoption of the agenda|	
|09:45 - 12:30|Session 1: Topics on specific language operators|
||- User defined Operators|Antonio
||- Time operators|Valentino
||- Coffee break|
||- Other issues|Angelo
|12:30 - 14:00|Lunch|	
|14:00 - 15:30|Session 2: Language evolution|Angelo
|15:30 - 15:45|Coffee break|
|15:45 - 17:00|Session 2: Language evolution (cont.)|Angelo

20:00	  Dinner (gently offered by Deutsche Bundesbank) 

### Day 2 Wednesday 26th  March
|TIME|TOPIC|PRESENTER
|----|-----|------|
|09:30 - 11:00|Session 3: Discussion on other topics|Angelo
|11:00 - 11:30|Coffee break|	
|11:30 - 12:15|Session 4: Organizational topics|Franck
|12:15 - 12:30|AOB & closing remarks|
|12:30|Lunch

## Participants

1.  Angelo Linardi
2.  Antonio Olleros
3.  Benedikt Huehn (Bundesbank)
4.  Eric Sigaud (INSEE)
5.  Franck Cotton
6.  Hadrien	Kohl
7.  Javier Hernandez
8.  Josè Maria Fernandez (Banco de Espana)
9.  Katrin Heinze
10. Nicolas Laval
11. Noah	Boerger
12. Sebastian Heupts (Bundesbank)
13. Stefano Pambianco
14. Ugo Di Zenzo (NBB)
15. Valentino Pinna
16. Arturo	San Feliciano (remote)
17. Attilio Mattiocco (remote)
18. Daniel Suranyi (remote)
19. Dario Camol (remote)
20. Laura	Vignola (remote)

Other attendees:
Ida Migliaccio (remote - Banca d'italia)

## Day 1 Tuesday 25th  March
### Introduction to new members
New members have been introduced:
- Ugo Di Zenzo (National Bank of Belgium) replaces Bryan Marquette as member in the TF
- Eric Sigaud (INSEE) replaces Florian Vucko as member in the TF
- Josè Maria Fernandez (Banco de Espana) added to the TF as attendee
- Benedikt Huehn and Sebastian Heupts (Bundesbank) added to the TF as attendees

### Session 1: Topics on specific language operators
#### User Defined Operators (UDO)
Antonio presented the different open issues related to UDOs. Some of them requires just a fix in the grammar (like invoking a UDO using sets), some others (like defining the way of handling parameters and set of components when invoking a UDO) require more analysis before deciding the way forward.

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
Actully the JSON schema does not include (in the header) the version attribute. At the moment it seems that there is no need of implementing versioning for such artefact, so the topic will be reinvestigated in the next future
#### Relaxing constraints in join operator
In some cases, there is the need of performing a join (more precisely inner_join) between two datasets not compliant with the given constraint (“the Identifiers of one of the joined Data Sets must be a superset of the identifiers of all the other ones”); the constraint has the goal not to allow null values for identifiers.
The proposal is to weaken this constraint to allow inner_join with at least one common identifier among all datasets; for all the non-common identifiers the “nlv” clause must be specified.
The proposal has been approved.

**Actions**:
- A new workstream, whose members are currently Valentino, Laura and Angelo, will make a proposal for new DL operators.
- Angelo will propose changes to the manuals to specify that all the operators that could imply data type changes within the same scalar type (e.g. division of two integers) are not “operators which change the basic scalar type” and to provide links to this statement in all the needed points (e.g. behaviour of the operators). He will also pull a request for changing the current constraint of the unpivot operator ("All the measures of op must be defined on the same ValueDomain") to a weaker one ("All the measures of op must be within the same scalar type, including subtypes"). These changes will require specific approval by the implementers' teams.
- Antonio will provide real use cases of transformation schemas with datasets having "same name with different meanings"
- Angelo will propose changes to the manuals to allow inner_join with at least one common identifier among all datasets and all the non-common identifiers with mandatory “nlv” clause. Also this change will require specific approval by the implementers' teams.


### Session 4: Organizational topics
#### Actions for closing VTL 2.1
Franck introduced the session asking for proposals of actions to "close" VTL version 2.1. It has been agreed that the correction of the open  bugs will be part of the 2.1 version, without opening a 3-digits version.
#### Planning next releases and how to contribute
Two milestons will be opened: one for 2.2 version and another for 3.0 version; in the first milestone (2.2) all the approved changes that are back-compatible will be put, while the second one (3.0) will contain the ones that are not back-compatible (e.g. removal of the "group all" clause). 

All the pending issues will be tagged with specific labels to specify in which version they will be applied/resolved.

VTL TF members have been asked if there were some "urgent" topics to be covered in the next releases not cited in any currently open issue. Antonio answered that a revision of the "propagation of attributes" or "viral attributes" has to be done shortly to solve some use cases for NBB.
#### VTL TF organisation
No decision has been taken about "general" TF organisation, so it has been decided to continue defining workstreams for specific purposes. Here are the ones that will be working for VTL 2.2:
- Workstream for UDO; current members: Hadrien, Javier, Sebastian
- Workstream for temporals; current members: Valentino, Antonio/Javier, Hadrien
- Workstream for JSON schema; current members: Antonio, Valentino
- Workstream for defining lists/patterns for set of components; current members: Hadrien, Nicolas, Javier
- Workstream for new DL operators; current members: Valentino, Laura, Angelo

For small changes/issues, written procedures will be launched to be approved/rejected by VTL TF; some of them has already assigned to TF members (see above). 

**Actions**:
- Angelo, Attilio and Valentino to define 2.2 and 3.0 milestone, define valid labels, "tag" all the issues with the target version
- Attilio, Valentino to create 2.2 folder in gitHub; the opening of the new version and the closure of the old one will be decided and announced (roughly) by the end of the month.
- All TF members/attendees are invited to join the above mentioned workstreams
#### Next meetings
A slot for VTL has been reserved within next TWG physical meeting, that will be in Salamanca from 16 to 20 of June 2025; VTL meeting will be held (in hybrid mode) on June 20 in the morning.

A call for presentations about VTL implementations, use cases, technical issues will be shortly launched for hte SDMX Global Conference that will be held in Rome from September 29th to October 1st hosted by Banca d'Italia; in the capacity building part that will follow (OCtober 2-3) a VTL training session will be held.

For the next year a physical VTL workshop will be organised: location and dates will be decided and communicated by the end of the year.

Finally, thank you so much to Katrin and Stefano for their very good job in organising the meeting and to the Bundesbank's colleagues for the very good dinner!
