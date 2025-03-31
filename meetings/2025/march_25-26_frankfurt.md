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
Fabio Palatta and Ida Migliaccio (remote - Banca d'italia)

## Day 1 Tuesday 25th  March
### Introduction to new members
New members have been introduced:
- Ugo Di Zenzo (National Bank of Belgium) replaces Bryan Marquette as member in the TF
- Eric Sigaud (INSEE) replaces Florian Vucko as member in the TF
- Josè Maria Fernandez (Banco de Espana) added to the TF as attendee
- Benedikt Huehn and Sebastian Heupts (Bundesbank) added to the TF as attendees

### User Defined Operators (UDO)
Antonio presented the different open issues related to UDOs. Some of them requires just a fix in the grammar (like invoking a UDO using sets), some others (like defining the way of handling parameters and set of components when invoking a UDO) require more analysis before deciding the way forward.

**Actions**:
- Hadrien, Javier and Sebastian to make a proposal for defining input parameters for UDOs (in particular invocation by name, allowing list of components)
- Antonio to prepare a written procedure to define a way for enforcing input types for a UDO (scalars vs components vs datasets)
- Nicolas and Hadrien to define syntax and update the grammar to accept sets as input tu UDOs


### Temporals in VTL
Valentino described the current issues in implementing time operators and presented some proposals to evolve the time data types. Some of them were not coherent with ISO 8601, the standard to which VTL has to stick to for handling time; moreover, in the next future there will be the need of handling hours, minutes and seconds. So it has been decided to define a workstream to extend time precision in VTL and resolving some controversial topics about time operators.

**Actions**:
- Valentino, Antonio/Javier and Hadrien to make a proposal for improving current time data types to include hours, minutes and seconds and evolving time operators accordingly.


### Other issues
Angelo presented a proposal for change of the "cast matrix" to solve some issues:
- Number --> Integer: NOT FEASIBLE (use ceil/floor/trunc)
- Integer --> Number: maintain implicit casting. Since Integer is a subtype of Number and Date and Time_period are subtypes of Time, the casting from subtypes to the correspondent type is always implicit, while the casting from types to the corresponding subtypes are always not feasible
- Number --> String: EXPLICIT WITH OPTIONAL MASK (in order to allow thousand separator)
- Integer --> String: EXPLICIT WITH OPTIONAL MASK (in order to allow thousand separator)
- String --> Integer: EXPLICIT WITH OPTIONAL MASK (like String --> Number)
The proposals have been accepted.
Then the topic of how to get a scalar from a dataset was introduced (e.g. to use the result of the count() of a dataset as a scalar to filter some other dataset). Since the result of a count() is a dataset with 1 row, no identifiers and 1 measure, by default named int_var, there is the possibility of getting the desidered outcome applying a join, but it is considered to be too complex. Various proposals have been made, to be chosen via written procedure.
Finally some bugs to be fixed have been presented; some of them were easy to resolve and already applied to the current version (allowing comments in the last line and updating the title of the manuals from "Python" to "VTL documentation"). The 

**Actions**:
- Angelo to modify the current cast matrix with the accepted proposals.
- Antonio to make a proposal for defining a new operator (or modify the membership one) for getting a scalar from a dataset to be approved by written procedure








Thank you so much to Katrin and Stefano for their very good job in organising the meeting and to the Bundesbank's colleagues for the very good dinner!
