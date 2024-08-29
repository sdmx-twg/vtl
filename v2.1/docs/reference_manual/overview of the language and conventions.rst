
Conventions for writing VTL Transformations
-------------------------------------------

When more Transformations are written in a text, the following
conventions apply.

**Transformations:**

-  A Transformation can be written in one or more lines, therefore the
   end of a line does not denote the end of a Transformation.

-  The end of a Transformation is denoted by a semicolon (;).

**Comments:**

Comments can be inserted within VTL Transformations using the following
syntaxes.

-  A multi-line comment is embedded between /\* and \*/ and, obviously,
   can span over several lines:

..

   /\* multi-line
   comment text \*/

-  A single-line comment follows the symbol // up to the next end of
   line:

..

   // text of a comment on a single line

-  A sequence of spaces, tabs, end-of-line characters or comments is
   considered as a single space.

-  The characters **/\*** , **\*/** , **//** and the whitespaces can be
   part of a string literal (within double quotes) but in such a case
   they are part of the string characters and do not have any special
   meaning.

Examples of valid comments:

   *Example 1:* ::

        /\* this is a multi-line
        Comment \*/

   *Example 2:* ::

        // this is single-line comment

   *Example 3:* ::

        DS_r <- /* A is a dataset */ A + /* B is a dataset */ B ;

        (for the VTL this statement is the Transformation DS_r <- A + B ; )

   *Example 4:* ::

        DS_r := DS_1 // my comment
                * DS_2 ;

        (for the VTL this statement is the Transformation DS_r := DS_1 * DS_2 ; )




Typographical conventions
-------------------------

The Reference Manual (this manual) uses the normal font Cambria for the
text and the other following typographical conventions:

+--------------+-------------------------------------------------------+
| *Convention* | *Description*                                         |
+==============+=======================================================+
| *Italics     | *Basic scalar data types (in the text)*               |
| Cambria*     |                                                       |
|              | e.g. “...must have one Identifier of type             |
|              | *time_period*. If the Data Set...”                    |
+--------------+-------------------------------------------------------+
| **Bold       | *Keywords (in the description of the syntax and in    |
| Arial**      | the text)*                                            |
|              |                                                       |
|              | e.g. Rule ::={ ruleName : } { **when**                |
|              | antecedentCondition **then** }                        |
|              |                                                       |
|              | consequentCondition                                   |
|              |                                                       |
|              | { **errorcode** errorCode }                           |
|              |                                                       |
|              | { **errorlevel** errorLevel }                         |
|              |                                                       |
|              | e.g. “...The **rename** operator allows to rename one |
|              | or more Components...”                                |
+--------------+-------------------------------------------------------+
| *Italics     |    *Optional Parameter (in the description of the     |
| Arial*       |    syntax)*                                           |
|              |                                                       |
|              |    e.g. **substr (** op\ **,** *start*\ **,**         |
|              |    *length* **)**                                     |
+--------------+-------------------------------------------------------+
| *Underlined  | *Sub-expressions*                                     |
| Arial*       |                                                       |
+--------------+-------------------------------------------------------+
| Normal font  | -  The operator’s syntax (excluded the keywords, the  |
| Arial        |    optional Parameters and the sub-expressions)       |
|              |                                                       |
|              | ..                                                    |
|              |                                                       |
|              |    e.g. **length (** "Hello, World!" **)**            |
|              |                                                       |
|              | -  The examples of invocation of the operators        |
|              |                                                       |
|              | ..                                                    |
|              |                                                       |
|              |    e.g. length ( "Hello, World!" )                    |
|              |                                                       |
|              | -  Optional and Mandatory Parameters (in the text)    |
|              |                                                       |
|              | e.g. “...If comp is a Measure in op, then in the      |
|              | result ...”                                           |
+--------------+-------------------------------------------------------+



Abbreviations for the names of the artefacts
--------------------------------------------

The names of the artefacts operated by the VTL-ML come from the VTL IM.
In their turn, the names of the VTL IM artefacts are derived as much as
possible from the names of the GSIM IM artefacts, as explained in the
User Manual.

If the complete names are long, the VTL IM suggests also a compact name,
which can be used in place of the complete name in case there is no
ambiguity (for example, “Set” instead than “Value Domain Subset”,
“Component” instead than “Data Set Component” and so on); moreover, to
make the descriptions more compact, a number of abbreviations, usually
composed of the initials (in capital case) or the first letters of the
words of artefact names, are adopted in this manual:

+-------------------------+------------------------+---------------------+
|   **Complete name**     |    **Compact name**    |   **Abbreviation**  |
+=========================+========================+=====================+
|      *Data Set*         |      *Data Set*        |        *DS*         |
+-------------------------+------------------------+---------------------+
|     *Data Point*        |     *Data Point*       |        *DP*         |
+-------------------------+------------------------+---------------------+
| *Identifier Component*  |     *Identifier*       |        *Id*         |
+-------------------------+------------------------+---------------------+
|   *Measure Component*   |       *Measure*        |        *Me*         |
+-------------------------+------------------------+---------------------+
|  *Attribute Component*  |      *Attribute*       |        *At*         |
+-------------------------+------------------------+---------------------+
|  *Data Set Component*   |      *Component*       |        *Comp*       |
+-------------------------+------------------------+---------------------+
|  *Value Domain Subset*  |    *Subset or Set*     |        *Set*        |
+-------------------------+------------------------+---------------------+
|     *Value Domain*      |        *Domain*        |         *VD*        |
+-------------------------+------------------------+---------------------+

A positive integer suffix (with or without an underscore) can be added
in the end to distinguish more than one instance of the same artefact
(e.g., DS_1, DS_2, ..., DS_N, Me1, Me2, ...MeN ). The suffix “r” stands for
the result of a Transformation (e.g., DS_r).



Conventions for describing the operators’ syntax
------------------------------------------------

Each VTL operator has an explanatory name, which recalls the operator
function (e.g., “Greater than”) and a syntactical symbol, which is used
to invoke the operator (e.g., “\ **>**\ ”). The operator symbol may also
be alphabetic, always lowercase (e.g., **round**).

In the VTL-DL, the operator symbol is the keyword **define** followed by
the name of the object to be defined. The complete operator symbol is
therefore a compound lowercase sentence (e.g. **define operator**).

In the VTL-ML, the operator symbol does not contain spaces and may be
either a sequence of special characters (like **+**, **-**, **>=**,
**<=** and so on) or a text keyword (e.g., **and**, **or**, **not**).
The keyword may be compound with underscores as separators (e.g.,
**exists_in**).

Each operator has a syntax, which is a set of formal rules to invoke the
operator correctly. In this document, the syntax of the operators is
formally described by means of a meta-syntax which is not part of the
VTL language, but has only presentation purposes.

The meta-syntax describes the syntax of the operators by means of
*meta-expressions*, which define how the invocations of the operators
must be written. The meta-expressions contain the symbol of the operator
(e.g., “\ **join**\ ”), the possible other keywords to denote special
parameters (e.g., **using**), other symbols to be used (e.g.,
parentheses, commas), the named formal parameters (e.g., multiplicand
and multiplier for the multiplication).

As for the typographic stile, in order to distinguish between the syntax
symbols (which are used in the operator invocations) and meta-syntax
symbols (used just for explanatory purposes, and not actually used in
invocations), the syntax symbols are in **boldface** (i.e., the operator
symbol, the special keywords, the possible parenthesis, commas an so
on). The names of the generic operands (e.g., multiplicand, multiplier)
are in Roman type, even if they are part of the syntax.

The meta-expression can be very simple, for example the meta-expression
for the addition is:

        op1 **+** op2

This means that the addition has two operands (op1, op2) and is invoked
by specifying the name of the first addendum (op1), then the addition
symbol (**+**) followed by the name of the second addendum (op2).

In this example, all the three parts of the meta-expression are fixed.
In other cases, the meta-expression can be more complex and made of
optional, alternative or repeated parts.

In the simple cases, the optional parts are denoted by using the
*italic* face, for example:

        **substr (** op\ **,** *start\ *\ **,** *length* **)**

The expression above implies that in the **substr** operator the start
and length operands are optional. In the invocation, a non-specified
optional operand is substituted by an underscore or, if it is in the end
of the invocation, can be omitted. Hence the following syntaxes are all
formally correct:

        **substr (** op\ **,** start\ **,** length **)**

        **substr (** op\ **,** start **)**

        **substr (** op\ **,** \_ **,** length **)**

        **substr (** op **)**

In more complex cases, a **regular expression style** is used to denote
the parts (sub-expressions) of the meta-expression that are optional,
alternative or repeated. In particular, braces denote a sub-expression;
a vertical bar (or sometimes named “pipe”) within braces denotes
possible alternatives; an optional trailing number, following the
braces, specifies the number of possible repetitions.

-  non-optional : non-optional sub-expression (text without braces)

-  {optional} : optional sub-expression (zero or 1 occurrence)

-  {non-optional}\ :sup:`1` : non-optional sub-expression (just 1
   occurrence)

-  {one-or-more}+ : sub-expression repeatable from 1 to many occurrences

-  {zero-or-more}\* : sub-expression repeatable from 0 to many
   occurrences

-  { part1 \| part2 \| part3 } : optional alternative sub-expressions
   (zero or 1 occurrence)

-  { part1 \| part2 \| part3 }\ :sup:`1` : alternative sub-expressions
   (just 1 occurrence)

-  { part1 \| part2 \| part3 }+: alternative sub-expressions, from 1 to
   many occurrences

-  { part1 \| part2 \| part3 }\* : alternative sub-expressions, from 0
   to many occurrences

Moreover, to improve the readability, some sub-expressions (the
underlined ones) can be referenced by their names and separately
defined, for example a meta-expression can take the following form:

   sub-expr\ :sub:`1`-text *sub-expr\ 2-name* … *sub-expr\ N-1-name*
   sub-expr\ :sub:`N`-text

        *sub-expr\ 2-name* ::= sub-expr\ :sub:`2`-text

        ... possible others ...

        *sub-expr\ N-1-name* ::= sub-expr\ :sub:`N-1`-text

In this representation of a meta-expression:

-  The first line is the text of the meta-expression

-  sub-expr\ :sub:`1`-text, sub-expr\ :sub:`N`-text are sub-expressions
   directly written in the meta-expression

-  *sub-expr\ 2-name*, … *sub-expr\ N-1-name* are identifiers of
   sub-expressions.

-  sub-expr\ :sub:`2`-text, … sub-expr\ :sub:`N-1`-text are
   subexpression written separately from the meta-expression.

-  The symbol **::=** means “is defined as” and denotes the assignment
   of a sub-expression-text to a sub-expression-name.

The following example shows the definition of the syntax of the
operators for removing the leading and/or the trailing whitespaces from
a string:

        Meta-expression ::= { **trim** \| **ltrim** \| **rtrim** }\ :sup:`1`
        **(** op **)**

The meta-expression above synthesizes that:

-  **trim**, **ltrim**, **rtrim** are the operators’ symbols (reserved
   keywords);

-  **(**, **)** are symbols of the operators syntax (reserved keywords);

-  op is the only operand of the three operators;

-  “{ }\ :sup:`1”` and **“**\ \|” are symbols of the meta-syntax; in
   particular “\|” indicates that the three operators are alternative (a
   single invocation can contain only one of them) and “{ }\ :sup:`1”`
   indicates that a single invocation contains just one of the shown
   alternatives;

From this template, it is possible to infer some valid possible
invocations of the operators:

        ltrim ( DS_2 )

        rtrim ( DS_3 )

In these invocations, **ltrim** and **rtrim** are the symbols of the
invoked operator and DS_2 and DS_3 are the names of the specific Data
Sets which are operands respectively of the former and the latter
invocation.



Description of data types of operands and result
------------------------------------------------

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



VTL-ML Operators
----------------

.. csv-table::
   :file: ./operatorstable.csv


VTL-ML - Evaluation order of the Operators
------------------------------------------

Within a single expression of the manipulation language, the operators
are applied in sequence, according to the precedence order. Operators
with the same precedence level are applied according to the default
associativity rule. Precedence and associativity orders are reported in
the following table.

+-------------+-----------------+-------------------------+----------------+
| Evaluation  | Operator        | Description             | Default        |
| order       |                 |                         | as             |
|             |                 |                         | sociativity    |
|             |                 |                         | rule           |
+=============+=================+=========================+================+
| I           | ( )             | Parentheses. To alter   | None           |
|             |                 | the default order.      |                |
+-------------+-----------------+-------------------------+----------------+
| II          | VTL operators   | VTL operators with      | Left-to-right  |
|             | with functional | functional syntax       |                |
|             | syntax          |                         |                |
+-------------+-----------------+-------------------------+----------------+
| III         | Clause          | Clause                  | Left-to-right  |
|             |                 |                         |                |
|             | Membership      | Membership              |                |
+-------------+-----------------+-------------------------+----------------+
| IV          | unary plus      | Unary minus             | None           |
|             |                 |                         |                |
|             | unary minus     | Unary plus              |                |
|             |                 |                         |                |
|             | not             | Logical negation        |                |
+-------------+-----------------+-------------------------+----------------+
| V           | \*              | Multiplication          | Left-to-right  |
|             |                 |                         |                |
|             | /               | Division                |                |
+-------------+-----------------+-------------------------+----------------+
| VI          | \+              | Addition                | Left-to-right  |
|             |                 |                         |                |
|             | \-              | Subtraction             |                |
|             |                 |                         |                |
|             | \|\|            | String concatenation    |                |
+-------------+-----------------+-------------------------+----------------+
| VII         | > >=            | Greater than            | Left-to-right  |
|             |                 |                         |                |
|             | < <=            | Less than               |                |
|             |                 |                         |                |
|             | =               | Equal-to                |                |
|             |                 |                         |                |
|             | <>              | Not-equal-to            |                |
|             |                 |                         |                |
|             | in              | In a value list         |                |
|             |                 |                         |                |
|             | not_in          | Not in a value list     |                |
+-------------+-----------------+-------------------------+----------------+
| VIII        | and             | Logical AND             | Left-to-right  |
|             |                 |                         |                |
+-------------+-----------------+-------------------------+----------------+
| IX          | or              | Logical OR              | Left-to-right  |
|             |                 |                         |                |
|             | xor             | Logical XOR             |                |
+-------------+-----------------+-------------------------+----------------+
| X           | if-then-else    | Conditional             | None           |
|             |                 | (if-then-else)          |                |
+-------------+-----------------+-------------------------+----------------+


Description of VTL Operators
----------------------------

The structure used for the description of the VTL-DL Operators is made
of the following parts:

-  **Operator name**, which is also used to invoke the operator

-  **Semantics:** a brief description of the purpose of the operator

-  **Syntax:** the syntax of the Operator (this part follows the
   conventions described in the previous section “Conventions for
   describing the operators’ syntax”)

-  **Syntax description:** detailed explanation of the meaning of the
   various parts of the syntax

-  **Parameters:** list of the input parameters and their types

-  **Constraints**: additional constraints that are not specified with
   the meta-syntax and need a textual explanation

-  **Semantic specifications**: detailed description of the semantics of
   the operator

-  **Examples**: examples of invocation of the operator

The structure used for the description of the VTL-ML Operators is made
of the following parts:

-  **Operator name**, followed by the **operator symbol** (keyword)
   which is used to invoke the operator

-  **Syntax:** the syntax of the Operator (this part follows the
   conventions described in the previous section “Conventions for
   describing the operators’ syntax”)

-  **Input parameters:** list of all input parameters and the
   subexpressions with their meaning and the indication if they are
   mandatory or optional

-  **Examples of valid syntaxes:** examples of syntactically valid
   invocations of the Operator

-  **Semantics for scalar operations**: the behaviour of the Operator on
   scalar operands, which is the basic behaviour of the Operator

-  **Input parameters type**: the formal description of the type of the
   input parameters (this part follows the conventions described in the
   previous section “Description of the data types of operands and
   results”)

-  **Result type:** the formal description of the type of the result
   (this part follows the conventions described in the previous section
   “Description of the data types of operands and results”)

-  **Additional constraints**: additional constraints that are not
   specified with the meta-syntax and need a textual explanation,
   including both possible semantic constraints under which the
   operation is possible or impossible, and syntactical constraint for
   the invocation of the Operator

-  **Behaviour**: description of the behaviour of the Operator for
   non-scalar operations (for example operations at Data Set or at
   Component level). When the Operator belongs to a class of Operators
   having a common behaviour, the common behaviour is described once for
   all in a section of the chapter “Typical behaviours of the ML
   Operators” and therefore this part describes only the specific aspect
   of the behaviour and contains a reference to the section where the
   common part of the behaviour is described.

-  **Examples**: a series of examples of invocation and application of
   the operator in case of operations at Data Sets or at Component
   level.