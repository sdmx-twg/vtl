Description of data types of operands and result
================================================

This section contains a brief legenda of the meaning of the symbols used
for describing the possible types of operands and results of the VTL
operators. For a complete description of the VTL data types, see the
chapter “VLT Data Types” in the User Manual.

+-----------------+-------------------+----------------+----------------+
| **Symbol**      | **Meaning**       | **Example**    | **Example      |
|                 |                   |                | meaning**      |
+=================+===================+================+================+
| parameter       | parameter is of   | param1 ::      | param1 is of   |
| **::** type2    | the *type2*       | string         | type *string*  |
+-----------------+-------------------+----------------+----------------+
| type1 **\|**    | alternative       | dataset \|     | either         |
| type2           | *types*           | component      | *dataset* or   |
|                 |                   |                | *component* or |
|                 |                   | \| scalar      | *scalar*       |
+-----------------+-------------------+----------------+----------------+
| type1 **<**     | scalar *type2*    | measure        | Measure of     |
| type2 **>**     | restricts         | <string>       | *string* type  |
|                 | *type1*           |                |                |
+-----------------+-------------------+----------------+----------------+
| type1 **\_**    | *type1* can       | measure        | just one       |
| (underscore)    | appear just       | <string>       | string Measure |
|                 | once              | \_             |                |
+-----------------+-------------------+----------------+----------------+
| type1           | predetermined     | measure        | just one       |
| elementName     | element of        | <string>       | string Measure |
|                 | *type1*           | my_text        | named          |
|                 |                   |                | “my_text”      |
+-----------------+-------------------+----------------+----------------+
| type1 **\_ +**  | *type1* can       | measure        | one or more    |
|                 | appear one or     | <string>\_+    | string         |
|                 | more times        |                | Measures       |
+-----------------+-------------------+----------------+----------------+
| type1 **\_ \*** | *type1* can       | measure        | zero, one or   |
|                 | appear zero,      | <string>\_\*   | more string    |
|                 | one or more       |                | Measures       |
|                 | times             |                |                |
+-----------------+-------------------+----------------+----------------+
| dataset **{**   | *Type_constraint* | dataset {      | Dataset having |
| type_constraint | restricts the     | measure <      | one or more    |
| **}**           | *dataset* type    | string > \_+ } | string         |
|                 |                   |                | Measures       |
+-----------------+-------------------+----------------+----------------+
| t\ :sub:`1`     | Product of the    | string \*      | triple of      |
| **\***          | types             | integer \*     | scalar values  |
| t\ :sub:`2`     |                   | boolean        | made of a      |
| **\*** … **\*** | *t\ 1* , *t\ 2*   |                | string, an     |
| t\ :sub:`n`     | , … , *t\ n*      |                | integer and a  |
|                 |                   |                | boolean value  |
+-----------------+-------------------+----------------+----------------+
| t\ :sub:`1`     | Operator from     | string ->      | Operator       |
| **->**          |                   | number         | having input   |
| t\ :sub:`2`     | t\ :sub:`1` to    |                | string and     |
|                 | t\ :sub:`2`       |                | output number  |
+-----------------+-------------------+----------------+----------------+
| ruleset **{**   | *Type_constraint* | hierarchical { | hierarchical   |
| type_constraint | restricts the     | geo_area }     | ruleset        |
| **}**           | *ruleset* type    |                | defined on     |
|                 |                   |                | geo_area       |
+-----------------+-------------------+----------------+----------------+
| set **<** t     | Set of elements   | set < dataset  | set of         |
| **>**           | of type “t”       | >              | datasets       |
+-----------------+-------------------+----------------+----------------+

Moreover, the word “name” in the data type description denotes the fact
that the argument of the invocation can contain only the name of an
artefact of such a type but not a sub-expression. For example:

   comp :: name < component < string > >

Means that the argument passed for the input parameter comp can be only
the name of a Component of the basic scalar type *string*. The argument
passed for comp cannot be a component expression.

The word “name” added as a suffix to the parameter name means the same
(for example if the parameter above is called comp_name).