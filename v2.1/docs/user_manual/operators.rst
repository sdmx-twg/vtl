VTL Operators
=============

As mentioned, the VTL is made of Operators, which are the basic
operations that the language can do. For example, the VTL has
mathematical operators (e.g. sum (+), subtraction (-), multiplication
(\*), division (/)…), string operators (e.g. string concatenation,
substring…), comparison operators (e.g. equal (=), greater than (>),
lesser than (<)…), logical operators (e.g. and, or, not…) and so on.

An Operator has some input and output Parameters, which are its a-priori
unknown operands and result, have a definite role in the operation (e.g.
dividend, divisor or quotient for the division) and correspond to a
certain type of artefact (e.g. a “Data Set”, a “Data Set Component”, a
“scalar Value”…).

The VTL operators are considered as functions (high-order
functions [32]_), which manipulate one or more input first-order
functions (the operands) to produce one output first-order function (the
result).

Assuming that *F* is the function corresponding to an operator, that
*P*:sub:`0` is its output parameter and that *P*:sub:`i (i=1,… n)` are its input
parameters, the mathematical form of an operator can be written as
follows:

   *P*:sub:`0` = *F* (*P*:sub:`1`, … , *P*:sub:`n`)

The function *F* composes the Parameters *P*:sub:`i` to obtain *P*:sub:`0` (as
mentioned, *P*:sub:`i (i=1,…,n)` and *P*:sub:`0` must be first order
functions). In the common case in which the Parameters are Data Sets,
*F* composes the Data Points of the input Data Sets *D*:sub:`i (i=1,…,n)` to
obtain the Data Points of the output Data Set *D*:sub:`0`.

When an Operator is invoked, for each input Parameter an actual argument
(operand) is passed to the Operator, which returns an argument (result)
for the output Parameter.

Each parameter has a type, which is the data type of the possible
arguments that can be passed or returned for it. For example, the
parameters of a multiplication are of type *number*, because only the
numbers can be multiplied (in fact for example the strings cannot). For
a deeper explanation of the data types see the corresponding section.

The categories of VTL operators
-------------------------------

The VTL operators are classified according to the following categories.

1. The **VTL standard library** contains the standard VTL operators:
   they are described in detail in the Reference Manual.

..

   On the technical perspective, the standard VTL operations can be
   divided into the following two sub-categories:

a. The **core set of operations**; these are the primitive ones, so that
   all the other operations can be defined in terms of them. The core
   operations are:

   i.   The operations that accept scalar arguments as operands and
        return a scalar value (for example the sum between numeric
        scalar values, the concatenation between *string* scalar values,
        the logical operation between *boolean* scalar values …).

   ii.  The various kinds of Join operators, which allow to apply the
        scalar operations at the Data Set level, i.e. to compose Data
        Sets with scalar values or with other Data Sets.

   iii. Other special operators which cannot be defined by means of the
        previous two categories (for example the analytical functions).

b. The **non-core standard operations**; they are standard VTL
   operations as well but are not “primitive” and can be derived from
   the core operations. Examples of these operations are the ones that
   allow to compose Data Sets and scalar values or Data Sets and other
   Data Sets (besides the various kinds of Join operators and the
   special operators mentioned above). Examples of non-core operations
   are the sum between numeric Data Sets, the concatenation between
   *string* Data Sets, the logical operations between *boolean* Data
   Sets, the *union* operator, some postfix operators like *calc,
   filter, rename* (see the Reference Manual).

..

   Most VTL Operators of the standard library (for example numerical,
   string, logical operators and others) can operate both on scalar
   Values and on Data Sets, an thus they have two variants: a scalar and
   a data set variant. The scalar variant is part of the VTL core, while
   the Data Set variant usually not.

   Anyway, the VTL users do not need distinguish between core and
   non-core operators, because in the practice the use of both these
   categories of Operators is the same.

2. The **user-defined operators** are non-standard VTL operators that
   can be defined by the users in order to enhance and personalize the
   language if needed. VTL provides a special operator, called
   “\ *define operator*\ ” (see the Reference Manual), for the creation
   of user-defined operators as well as a special syntax to invoke them.

The input parameters
--------------------

The input parameters may have various goals and in particular:

-  identify the model artefacts to be manipulated

-  specify possible options for the operator behaviour

-  specify additional scalar values required to perform the operator’s
   behaviour.

For example, in the “Join” operator, the first N parameters identify the
Data Sets to be joined while the “using” parameter specifies the
components on which the join must operate.

Depending on the number of the input parameters, the Operators can be
classified in:

   **Unary** having just one input parameter

   **Binary** having two input parameters

   **N-ary** having more input parameters

Examples of unary Operators are the change of sign, the minimum, the
maximum, the absolute value. Examples of binary Operators are the common
arithmetical operators ( +, -, \*, /). Examples of N-ary operators are
the substring, the string replacement, the Join. It is also possible the
extreme case of operators having zero input parameters (e.g. an operator
returning the current time).

The invocation of VTL operators
-------------------------------

Operators have different invocation styles:

-  **Prefix**, only for unary operators, in which the operator is
   written before the operand; the general forms of invocation is:

..

   *Operator Operand* (e.g. *-D*:sub:`2` which changes the sign of *D*:sub:`2`)

-  **Infix**, only for binary operators. The operator symbol appears
   between the operands; the general form of invocation is:

..

   *FirstOperand Operator SecondOperand* (e.g. *D*:sub:`1` + *D*:sub:`2`)

-  **Postfix**, only for unary operators. The operator symbol appears
   after the operand in square brackets and follows its operand; the
   general forms of invocation is:

..

   *Operand [Operator]*

   (e.g. *DS*:sub:`2` **[filter** *M*:sub:`1` **>** 0 **]** which
   selects from Data Set *DS*:sub:`2` only the Data Points having values
   greater than zero for measure *M*:sub:`1` and returns such values in
   the result Data Set.)

   Postfix operators are also called “clause operators” or simply
   “clauses”.

-  **Functional**, for N-ary operators. The operator is invoked using a
   functional notation; the general form of invocation is:

..

   *Operator(IO*:sub:`1`, … , *IO*:sub:`N` *)* where *IO*:sub:`1`, … , *IO*:sub:`N` are the input
   operands;

   For example, the syntax for the exponentiation is *power(base,
   exponent)* and a possible invocation to calculate the square of the
   numeric Data Set *D*:sub:`1` is *power(D*:sub:`1`, 2 *)*.

   The comma (“,”) is the separator between the operands. Parameter
   binding is fully positional: in the invocation, actual parameters are
   passed to the Operator in the same positional order as the
   corresponding formal parameters in the Operator syntax. Parameters
   can be mandatory or optional: usually the mandatory ones are in the
   first positions and the optional ones in the last positions. An
   underscore (“\_”) must be used to denote that optional operand is
   omitted in the invocation; for example, this is a possible invocation
   of *Operator1(P*:sub:`1`, P*:sub:`2`, *P*:sub:`3` *)*, where *P*:sub:`2`,
   *P*:sub:`3` are optional and *P*:sub:`2` is omitted:

   **Operator1(** *IO*:sub:`1` , \_ , *IO*:sub:`3` **)**.

   One or more unspecified operands in the last positions can be simply
   omitted (including the relevant commas); for example, if both *P*:sub:`2`,
   *P*:sub:`3` are omitted, the invocation can be simply:

   **Operator1 (** *IO*:sub:`1` **)**.

-  **Functional with keywords** (a functional syntax in which some
   parameters are denoted by special keywords); in this case each
   operator has its own form of invocation, which is described in the
   reference manual. For example, a possible invocation of the Join
   operator is the following:

..

   **inner_join** **(** *D*:sub:`1` , *D*:sub:`2` **using** **[**
   *Id*:sub:`1` **,** *Id*:sub:`2` **])**

   In this example, the Data Sets D\ :sub:`1` and D\ :sub:`2` are joined
   on their Identifiers Id\ :sub:`1` and Id\ :sub:`2`. The first two
   parameters do not have keywords, then the keyword “using” is used to
   specify the list of Components to join (the square brackets denote a
   list). A keyword can be composed of more words, substitutes the comma
   separator and identifies the actual parameter of the Operator. The
   unspecified optional parameters identified by keywords can be simply
   omitted (including the relevant keywords, i.e., the underscore “\_”
   is not required). The actual syntax of this kind of operators and the
   relevant keywords are described in detail in the Reference Manual.

The syntax for the invocation of the user-defined operators is
functional.

Independently of the kind of their syntax, the behaviour of the VTL
operators is always functional, i.e. they behave as high-order
mathematical functions, which manipulate one or more input first-order
functions (the operand Data Sets) to produce one output first-order
function (the result Data Set).

Level of operation
------------------

The VTL Operators can operate at various levels:

-  Scalar level, when all the operands and the result are scalar Values

-  Data Set level, when at least one operand is a Data Set

-  Component level, when the operands and the result are Data Set
   Components

At the **scalar level**, the Operators compose scalar literals to obtain
other scalar Values. The sum, for example, allows summing two scalar
numbers and obtaining another scalar number. The behaviour at the scalar
level depends on the operator, does not need a general explanation and
is described in detail in the Reference Manual. Examples of operations
at the scalar level are:

.. list-table::

    * - *D*:sub:`r` *:= 3 + 7*
      - *3* and *7* are scalar literals of *number* type
    * - *D*:sub:`r` *:= “abcde” \|\| “fghij”*
      - “\ *abcde*\ ” and “\ *fghij*\ ” are scalar literals of *string* type


As already mentioned, the outcome of an operation at the scalar level is
a Data Set without Components that contains only a scalar Value.

At the **Data Set level**, the Operators compose Data Sets and possibly
scalar literals in order to obtain other Data Sets. As mentioned, the
VTL is designed primarily to operate on Data Sets and produce other Data
Sets, therefore almost all VTL operators can act on Data Sets, apart
some few trivial exceptions (e.g. the parenthesis). The behaviour at the
Data Set level deserves a general explanation that is given in the
following sections. Examples of operations at the Data Set level are:

.. list-table::

    * - *D*:sub:`r` *:= D*:sub:`1` *+ 7*
      - *D*:sub:`1` is a Data Set with numeric Measures, *7* is a scalar *number*
    * - *D*:sub:`r` *:= D*:sub:`1` *+ D*:sub:`2`
      - *D*:sub:`1` and *D*:sub:`2` are Data Sets having Measures of *number* type
    * - *D*:sub:`r` *:= D*:sub:`3` *\|\| “fghij”*
      - *D*:sub:`3` is a Data Set with *string* Measures, “\ *fghij*\ ” is a scalar *string*
    * - *D*:sub:`r` *:= D*:sub:`3` *\|\| D*:sub:`4`
      - *D*:sub:`3` and *D*:sub:`4` are Data Sets having Measures of *string* type

At the **Component level**, the Operators compose Data Set Components
and possibly scalar literals in order to obtain other Data Set
Components. A Component level operation may happen only in the context
of a Data Set operation, so that the calculated Component belongs to the
calculated Data Set. The behaviour at the Data Set level deserves a
general explanation that is given in the following sections. Examples of
operations at the Component level are:

.. list-table::

    * - *D*:sub:`r` *:= D*:sub:`1` *[ calc C*:sub:`3` *:= C*:sub:`1` *+ C*:sub:`2` *]*
      - *C*:sub:`1` and *C*:sub:`2` are numeric Components of *C*:sub:`2`
    * - *D*:sub:`r` *:= D*:sub:`1` *[ calc C*:sub:`3` *:= C*:sub:`1` *+ 7 ]*
      - *C*:sub:`1` is a numeric Component of *D*:sub:`1`, *7* is a scalar *number*
    * - *D*:sub:`r` *:= D*:sub:`3` *[ calc C*:sub:`6` *:= C*:sub:`4` *\|\| C*:sub:`5` *]*
      - *C*:sub:`4` and *C*:sub:`5` are string Components of *D*:sub:`3`
    * - *D*:sub:`r` *:= D*:sub:`3` *[ calc C*:sub:`6` *:= C*:sub:`4` *\|\| “fghij” ]*
      - *C*:sub:`4` is a string Component of *D*:sub:`3`, “\ *fghij*\ ” is a scalar *string*

In these examples, the postfix operator *calc* is applied to the input
Data Sets *D*:sub:`1` and *D*:sub:`3`, takes in input some their components and
produces in output the components *C*:sub:`3` and *C*:sub:`6` respectively, which
become part of the result Data Set *D*:sub:`r`.

The operations at a component level are performed row by row and in the
context of one specific Data Set, so that one input Data point results
in no more than one output Data Point.

In these last examples the assignment is used both at the Data Set level
(when the outcome of the expression is assigned to the result Data Set)
and at the Component level (when the outcome of the operations at the
Component level is assigned to the resulting Components). The assignment
at Data Set level can be either persistent or non-persistent, while the
assignment at the Component level can be only non-persistent, because a
Component exists only within a Data Set and cannot be stored on its own.

The Operators’ behaviour
------------------------

As mentioned, the behaviour of the VTL operators is always functional,
i.e., they behave as higher-order mathematical functions, which
manipulate one or more input first-order functions (the operands) to
produce one output first-order function (the result).

The Join operators
~~~~~~~~~~~~~~~~~~

The more general and powerful behaviour is supplied by the Join
operators, which operates at Data Set level and allow to compose one or
more Data Sets in many possible ways.

In particular, the Join operators allow to:

-  match the Data Points of the input Data Sets by means of various
   matching options (inner/left/full/cross join) and by specifying the
   Components to match (“using” clause). For example the sentence:

..

   *inner_join D*:sub:`1`, *D*:sub:`2` *using [ reference_date, geo_area ]*

   matches the Data Points of D*:sub:`1`, *D*:sub:`2 *which have the same values
   for the Identifiers *reference_date* and *geo_area*.

-  filter the result of the match according to a condition, for example
   the sentence

..

   *filter D*:sub:`1` # *M*:sub:`1` *> 0*

   maintains the matched Data Points for which the Measure *M*:sub:`1` of
   *D*:sub:`1` is positive.

-  aggregate according to the values of some Identifier, for example the
   sentence

..

   *group by [ Id*:sub:`1` , *Id*:sub:`2` *]*

   eliminates the Identifiers save than *Id*:sub:`1` and *Id*:sub:`2` and
   aggregate the Data Points having the same values for *Id*:sub:`1` and
   *Id*:sub:`2`

-  combine homonym measures of the matched Data Points according to a
   formula, for example the sentence

..

   *apply D*:sub:`1` *+ D*:sub:`2`

   sums the homonymous measures of the matched Data Points of *D*:sub:`1` and
   *D*:sub:`2`

-  calculate new Components (or new values for existing Components)
   according to the desired formulas, also assigning or changing the
   Component role (Identifier, Measure, Attribute), for example:

..

   *calc measure M*:sub:`3` *:= M*:sub:`1` *+ M*:sub:`2` *, attribute A*:sub:`1` *:= A*:sub:`2` *\|\| A*:sub:`3`

   calculates the measure *M*:sub:`3` and the Attribute *A*:sub:`1` according to
   the formulas above

-  keep or drop the specified Measures or Attributes, for example the
   sentence

..

   *keep [M*:sub:`1` *, M*:sub:`3`, *A*:sub:`1` *]*

maintains only the specified measures and attributes, instead the
sentence

   *drop [M*:sub:`2` *, A*:sub:`2`, *A*:sub:`3` *]*

drops only the specified measures and attributes

-  rename the specified Components, for example:

..

   *rename [M*:sub:`1` *to M*:sub:`10` *, I*:sub:`1` *to I*:sub:`10` *]*

As shown above, the Join operator, together with the other operators
applied at scalar or at Component level, allows to reproduce the
behaviour of the other operators at a Data Set level (save than some
special operator) and also to achieve many other behaviours which are
impossible to achieve otherwise.

Anyway, even if the *join* would cover most of the VTL manipulation
needs, the VTL provides for a number of other Operators that are
designed to support the more common manipulation needs in a simpler way,
in order to make the use of the VTL simpler in the more recurrent
situations. Their features are naturally more limited than the ones of
the *join* and a number of default behaviours are assumed.

The following sections explain the more common default behaviours of the
Operators other than the Join.

Other operators: default behaviour on Identifiers, Measures and Attributes 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The default behaviour of the operators other than the Join, when they
operate at Data Set level, is different for Identifiers, Measures and
Attributes.

In fact, unless differently specified, the Operators at Data Set level
act only on the Values of the Measures. The Values of Identifiers are
usually left unchanged, save for few special operators specifically
aimed at manipulating Identifiers (for example the operators which make
aggregations, either dropping some Identifiers or according the
hierarchical links between the Code Items of an Identifier). The Values
of the Attributes, instead, are manipulated by default through specific
Attribute propagation rules explained in a following section.

For example, considering the Transformation *D*:sub:`r` *:= ln (D*:sub:`1`), the
operation is applied for each Data Point of *D*:sub:`1`, the values of the
Identifiers are left unchanged and the values of all the Measures are
substituted by their natural logarithm (it is assumed that the Measures
of *D*:sub:`1` are all numerical).

Similarly, considering the simple operation *D*:sub:`r` *:= D*:sub:`1` *+ 7*, the
addition is done for each Data Point of *D*:sub:`1`, the values of the
Identifiers are left unchanged and the number 7 is added to the values
of all the Measures (it is assumed that the Measures of *D*:sub:`1` are all
numerical).

As for the structure, like in the examples above, the Identifiers of the
result Data Set D\ :sub:`r` are the same as the Identifiers of the input
Data Set D\ :sub:`1` (save for the special operators specifically aimed
at manipulating Identifiers), and by default also the Measures of
D\ :sub:`r` remain the same as D\ :sub:`1` (save for the operator which
change the basic scalar type of the operand, this case is described in a
following section). The Attribute Components of the result depend
instead on the Attribute propagation rule.

In the previous examples, only one Data Set is passed in input to the
Operator (other possible operands are not Data Sets). The operations on
more Data Sets, like *D*:sub:`r` *:= D*:sub:`1` *+ D*:sub:`2`, behave in the same way than
the operations on one Data Set, save that there is the additional need
of a preliminary matching of the Identifiers of the Data Points of the
input Data Sets: the operation applies on the matched Data Points.

For example, the addition *D*:sub:`1` *+ D*:sub:`2` above happens between each
couple of Data Points, one from *D*:sub:`1` and the other from *D*:sub:`2`, whose
Identifiers match according to a default rule (which is better explained
in a following section). The values of the homonymous Measures of *D*:sub:`1`
and *D*:sub:`2` are added, taken respectively from the *D*:sub:`1` and *D*:sub:`2` Data
Points (the default rule for composing the measure is better explained
in a following section).

The Identifier Components and the Data Points matching 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes the default Data Points matching rules for the
Operators which operate at Data Set level and which do not manipulate
the Identifiers (for example, the behaviour of the Operators which make
aggregations is not the same, and is described in the Reference Manual).

As shown in the examples above, the actual behaviour depends also on the
number of the input Data Sets.

If just one input Data Set is passed to the operator, the operation is
applied for each input Data Point and produces a corresponding output
Data Point. This case happens for all the unary operators, which have
just on input parameter and therefore cannot operate on more than one
Data Set (e.g. *ln (D*:sub:`1` *)* ), and for the invocations of unary operators
in which just one Data Set is passed to the operator (e.g. *D*:sub:`1` *+ 7* ).

If more input Data Sets are passed to the operator (e.g. *D*:sub:`1` *+ D*:sub:`2`
), a preliminary match between the Data Points of the various input Data
Sets is needed, in order to compose their measures (e.g. summing them)
and obtain the Data Points of the result (i.e. *D*:sub:`r`). The default
matching rules envisage that the **Data Points are matched when the
values of their homonymous Identifiers are the same**.

For example, let us assume that *D*:sub:`1` and *D*:sub:`2` contain the population
and the gross product of the United States and the European Union
respectively and that they have the same Structure Components, namely
the Reference Date and the Measure Name as Identifier Components, and
the Measure Value as Measure Component:

   *D*:sub:`1` = United States Data

+----------------------+----------------------+------------------------+
| **Ref.Date**         | **Meas.Name**        | **Meas.Value**         |
+======================+======================+========================+
| 2013                 | Population           | 200                    |
+----------------------+----------------------+------------------------+
| 2013                 | Gross Prod.          | 800                    |
+----------------------+----------------------+------------------------+
| 2014                 | Population           | 250                    |
+----------------------+----------------------+------------------------+
| 2014                 | Gross Prod.          | 1000                   |
+----------------------+----------------------+------------------------+

..

   *D*:sub:`2` = European Union Data

+----------------------+----------------------+------------------------+
| **Ref.Date**         | **Meas.Name**        | **Meas.Value**         |
+======================+======================+========================+
| 2013                 | Population           | 300                    |
+----------------------+----------------------+------------------------+
| 2013                 | Gross Prod.          | 900                    |
+----------------------+----------------------+------------------------+
| 2014                 | Population           | 350                    |
+----------------------+----------------------+------------------------+
| 2014                 | Gross Prod.          | 1000                   |
+----------------------+----------------------+------------------------+

The desired result of the sum is the following:

   *D*:sub:`r` = United States + European Union

+----------------------+----------------------+------------------------+
| **Ref.Date**         | **Meas.Name**        | **Meas.Value**         |
+======================+======================+========================+
| 2013                 | Population           | 500                    |
+----------------------+----------------------+------------------------+
| 2013                 | Gross Prod.          | 1700                   |
+----------------------+----------------------+------------------------+
| 2014                 | Population           | 600                    |
+----------------------+----------------------+------------------------+
| 2014                 | Gross Prod.          | 2000                   |
+----------------------+----------------------+------------------------+

In this operation, the Data Points having the same values for the
Identifier Components are matched, then their Measure Components are
combined according to the semantics of the specific Operator (in the
example the values are summed).

The example above shows what happens under a **strict constraint**: when
the input Data Sets have exactly the same Identifier Components. The
result will also have the same Identifier Components as the operands.

However, various Data Set operations are possible also under a more
**relaxed constraint**, that is when the Identifier Components of one
Data Set are a superset of those of the other Data Set [33]_.

For example, let us assume that *D*:sub:`1` contains the population of the
European countries (by reference date and country) and *D*:sub:`2` contains
the population of the whole Europe (by reference date):

   *D*:sub:`1` = European Countries

+----------------------+----------------------+------------------------+
| **Ref.Date**         | **Country**          | **Population**         |
+======================+======================+========================+
| 2012                 | U.K.                 | 60                     |
+----------------------+----------------------+------------------------+
| 2012                 | Germany              | 80                     |
+----------------------+----------------------+------------------------+
| 2013                 | U.K.                 | 62                     |
+----------------------+----------------------+------------------------+
| 2013                 | Germany              | 81                     |
+----------------------+----------------------+------------------------+

..

   *D*:sub:`2` = Europe

+---------------------------------+------------------------------------+
| **Ref.Date**                    | **Population**                     |
+=================================+====================================+
| 2012                            | 480                                |
+---------------------------------+------------------------------------+
| 2013                            | 500                                |
+---------------------------------+------------------------------------+

In order to calculate the percentage of the population of each single
country on the total of Europe, the Transformation will be:

   *D*:sub:`r` *:= D*:sub:`1` / *D*:sub:`2` \* 100

The Data Points will be matched according to the Identifier
Components common to *D*:sub:`1` and *D*:sub:`2` (in this case only the
*Ref.Date*), then the operation will take place.

The result Data Set will have the Identifier Components of both the
operands:

   *D*:sub:`r` = European Countries / Europe \* 100

+----------------------+----------------------+------------------------+
| **Ref.Date**         | **Country**          | **Population**         |
+======================+======================+========================+
| 2012                 | U.K.                 | 12.5                   |
+----------------------+----------------------+------------------------+
| 2012                 | Germany              | 16.7                   |
+----------------------+----------------------+------------------------+
| 2013                 | U.K.                 | 12.4                   |
+----------------------+----------------------+------------------------+
| 2013                 | Germany              | 16.2                   |
+----------------------+----------------------+------------------------+

When the relaxed constraint is applied, therefore, the Data Points are
matched when the values of their **common** Identifiers are the same.

More formally, let *F* be a generic n-ary VTL Data Set Operator, *D*:sub:`r`
the result Data Set and *D*:sub:`i` *(i=1,… n)* the input Data Sets, so that:

   *D*:sub:`r` *:= F(D*:sub:`1` *, D*:sub:`2` *, … , D*:sub:`n` *)*

The “strict” constraint requires that the Identifier Components of the
*D*:sub:`i` *(i=1,… n)* are the same. The result *D*:sub:`r` will also have the same
Identifier components.

The “relaxed” constraint requires that at least one input Data Set
*D*:sub:`k` exists such that for each *D*:sub:`i` *(i=1,… n)* the Identifier
Components of *D*:sub:`i` are a (possibly improper) subset of those of
*D*:sub:`k`. The output Data Set *D*:sub:`r` will have the same Identifier
Components than *D*:sub:`k`.

The n-ary Operator *F* will produce the Data Points of the result by
matching the Data Points of the operands that share the same values for
the common Identifier Components and by operating on the values of their
Measure Components according to its semantics.

The actual constraint for each operator is specified in the Reference
Manual.

Naturally, it is possible that not all the Data Sets contain the same
combinations of values of the Identifiers to be matched. In the cases
the match does not happen, the operation is not performed and no output
Data Point is produced. In other words, the measures corresponding to of
the missing combinations of Values of the Identifiers are assumed to be
unknown and to have the value NULL, therefore the result of the
operation is NULL as well and the output Data Point is not produced.

This default matching behaviour is the same as the one of the *inner
join* Operator, which therefore is able to perform the same operation.
The join operation equivalent to *D*:sub:`1` *+ D*:sub:`2` is:

   *inner_join ( D*:sub:`1` *, D*:sub:`2` *apply D*:sub:`1` *+ D*:sub:`2` *)*

Different matching behaviours can be obtained using the other *join*
Operators, for example writing:

   *full_join ( D*:sub:`1` *, D*:sub:`2` *apply D*:sub:`1` *+ D*:sub:`2` *)*

the *full join* brings in the output also the combination of Values of
the Identifiers which are only in one Data Set, the operation is applied
considering the missing value of the Measure as the neutral element of
the operation to be done (e.g. 0 for the sum, 1 for the product, empty
string for the string concatenation …) and the output Data Point is
produced.

The operations on the Measure Components 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes the default composition of the Measure Components
for the Operators which operate at Data Set level and which do not
change the basic scalar type of the input Measure (for example, the
behaviour of the Operators which convert one type in another, say for
example a *number* in a *string*, is not the same and is described in a
following section).

As shown in the examples below, the actual behaviour depends also on the
number of the input Data Sets and the number of their Measures.

An **Operator applied to one mono-measure Data Set** is intended to be
applied to the only Measure of the input Data Set. The result Data Set
will have the same Measure Component, whose values are the result of the
operation.

For example, let us assume that *D*:sub:`1` contains the salary of the
employees (the only Identifier is the Employee ID and the only Measure
is the Salary):

   *D*:sub:`1` = Salary of Employees

+---------------------------------+------------------------------------+
| **Employee ID**                 | **Salary**                         |
+=================================+====================================+
| A                               | 1000                               |
+---------------------------------+------------------------------------+
| B                               | 1200                               |
+---------------------------------+------------------------------------+
| C                               | 800                                |
+---------------------------------+------------------------------------+
| D                               | 900                                |
+---------------------------------+------------------------------------+

The Transformation *D*:sub:`r` *:= D*:sub:`r` \* *1.10* applies to the only Measure
(the salary) and calculates a new value increased by 10%, so the result
will be:

   *D*:sub:`r` = Increased Salary of Employees

+---------------------------------+------------------------------------+
| **Employee ID**                 | **Salary**                         |
+=================================+====================================+
| A                               | 1100                               |
+---------------------------------+------------------------------------+
| B                               | 1320                               |
+---------------------------------+------------------------------------+
| C                               | 880                                |
+---------------------------------+------------------------------------+
| D                               | 990                                |
+---------------------------------+------------------------------------+

In case of **Operators applied to one multi-measure Data Set**, by
default the operation is performed on all its Measures. The result Data
Set will have the same Measure Components as the operand Data Set.

For example, given the import, export, and number of operations by
reference date:

   *D*:sub:`1` = Import, Export, Operations

+----------------+----------------+-----------------+-----------------+
| **Ref.Date**   | **Import**     | **Export**      | **Operations**  |
+================+================+=================+=================+
| 2011           | 1000           | 1200            | 5000            |
+----------------+----------------+-----------------+-----------------+
| 2012           | 1300           | 1100            | 6400            |
+----------------+----------------+-----------------+-----------------+
| 2013           | 1200           | 1300            | 4800            |
+----------------+----------------+-----------------+-----------------+

The Transformation *D*:sub:`r` *:= D*:sub:`1` \* 0.80 applies to all the Measures
(e.g. to the Import, the Export and the Balance) and calculates their
80%:

   *D*:sub:`r` = 80% of Import & Export

+-----------------+-----------------+-----------------+-----------------+
| **Ref.Date**    | **Import**      | **Export**      | **Operations**  |
+=================+=================+=================+=================+
| 2011            | 800             | 960             | 4000            |
+-----------------+-----------------+-----------------+-----------------+
| 2012            | 1040            | 880             | 5120            |
+-----------------+-----------------+-----------------+-----------------+
| 2013            | 960             | 1040            | 3840            |
+-----------------+-----------------+-----------------+-----------------+

An Operator can be applied only on Measures of a certain basic data
type, corresponding to its semantics [34]_. For example, *the
multiplication* requires the Measures to be of type *number*, while the
*substring* will require them to be *string*. Expressions that violate
this constraint are considered an error.

In general, all the Measures of the Operand Data Set must be compatible
with the allowed data types of the Operator, otherwise (i.e. if at least
one Measure is incompatible) the operation is not allowed. The possible
input data types of each operator are specified in the Reference Manual.

Therefore, the operation of the previous example *(D*:sub:`r` *:= D*:sub:`1` *\* 0.80)*, 
which is assumed to act on all the Measures of *D*:sub:`1`, would
not be allowed and would return an error if *D*:sub:`1` would contain also a
Measure which is not *number* (e.g. *string*).

In case of inputs having Measures of different types, the operation can
be done either using the *join* operators, which allows to calculate
each measure with a different formula (see the *calc* operator) or, in
two steps, first keeping only the Measures of the desired type and then
applying the desired compliant operator; the explanation, as explained
in the following cases.

If there is the need to **apply an** **Operator only to one specific
Measure**, the membership (#) operator can be used, which allows keeping
just one specific Components of a Data Set. The syntax is:
*dataset_name#component_name* (for a better description see the
corresponding section in the Part 2).

For example, in the Transformation *D*:sub:`r` *:= D*:sub:`1`\ #Import
\* 0.80

the operation keeps only the Import and then calculates its 80%):

   *D*:sub:`r` = 80% of the Import

+-----------------------------------+-----------------------------------+
| **Ref.Date**                      | **Import**                        |
+===================================+===================================+
| 2011                              | 800                               |
+-----------------------------------+-----------------------------------+
| 2012                              | 1040                              |
+-----------------------------------+-----------------------------------+
| 2013                              | 960                               |
+-----------------------------------+-----------------------------------+

If there is the need to **apply an** **Operator only to some specific
Measures**, the *keep* operator (or the drop) [35]_ can be used, which
allows keeping in the result (or dropping) the specified Measures (or
also Attributes) of the input Data Set. Their invocations are:

   *dataset_name [keep component_name , component_name …]*

   *dataset_name [drop component_name, component_name … ]*

For example, in the Transformation *D*:sub:`r` *:= D*:sub:`1` *[keep Import, Export]
\* 0.80*

the operation keeps only the Import and the Export and then calculates
its 80%):

   *D*:sub:`r` = 80% of the Import

+-----------------------+-----------------------+-----------------------+
| **Ref.Date**          | **Import**            | **Export**            |
+=======================+=======================+=======================+
| 2011                  | 800                   | 960                   |
+-----------------------+-----------------------+-----------------------+
| 2012                  | 1040                  | 880                   |
+-----------------------+-----------------------+-----------------------+
| 2013                  | 960                   | 1040                  |
+-----------------------+-----------------------+-----------------------+

If there is the need to **perform some** **operations on some specific
Measures and keep the others measures unchanged**, the *calc* operator
can be used, which allows to calculate each Measure with a dedicated
formula leaving the other Measures as they are. A simple kind of
invocation is [36]_:

   *dataset_name [ calc component_name ::= cmp_expr, component_name ::=
   cmp_expr …]*

The component expressions (*cmp_expr*) can reference only other
components of the input Data Set.

For example, in the Transformation *D*:sub:`r` *:= D*:sub:`1` *[calc
Import \* 0.80, Export \* 0.50]*

the operations apply only to Import and Export (and calculate their 80%
and 50% respectively), while the Operations values remain unchanged:

   *D*:sub:`r` = 80% of the Import, 50% of the Export and Operations

+-----------------+-----------------+-----------------+-----------------+
| **Ref.Date**    | **Import**      | **Export**      | **Operations**  |
+=================+=================+=================+=================+
| 2011            | 800             | 1200            | 5000            |
+-----------------+-----------------+-----------------+-----------------+
| 2012            | 1040            | 1100            | 6400            |
+-----------------+-----------------+-----------------+-----------------+
| 2013            | 960             | 1300            | 4800            |
+-----------------+-----------------+-----------------+-----------------+

In case of **Operators applied on more Data Sets**, by default **the
operation is performed between the Measures having the same names** (in
other words, on the same Measures). To avoid ambiguities and possible
errors, the input Data Sets must have the same Measures and the result
Data Set is assumed to have the same Measures too.

For example, let us assume that D\ :sub:`1` and D\ :sub:`2` contain the
births and the deaths of the United States and the European Union
respectively.

   *D*:sub:`1` = Births & Deaths of the United States

+----------------------+----------------------+------------------------+
| **Ref.Date**         | **Births**           | **Deaths**             |
+======================+======================+========================+
| 2011                 | 1000                 | 1200                   |
+----------------------+----------------------+------------------------+
| 2012                 | 1300                 | 1100                   |
+----------------------+----------------------+------------------------+
| 2013                 | 1200                 | 1300                   |
+----------------------+----------------------+------------------------+

..

   *D*:sub:`2` = Birth & Deaths of the European Union

+----------------------+----------------------+------------------------+
| **Ref.Date**         | **Births**           | **Deaths**             |
+======================+======================+========================+
| 2011                 | 1100                 | 1000                   |
+----------------------+----------------------+------------------------+
| 2012                 | 1200                 | 900                    |
+----------------------+----------------------+------------------------+
| 2013                 | 1050                 | 1100                   |
+----------------------+----------------------+------------------------+

The Transformation *D\ r := D\ 1 + D\ 2* will produce:

   *D*:sub:`r` = Births & Deaths of United States + European Union

+----------------------+----------------------+------------------------+
| **Ref.Date**         | **Births**           | **Deaths**             |
+======================+======================+========================+
| 2011                 | 2100                 | 2200                   |
+----------------------+----------------------+------------------------+
| 2012                 | 2500                 | 2000                   |
+----------------------+----------------------+------------------------+
| 2013                 | 2250                 | 2400                   |
+----------------------+----------------------+------------------------+

The Births of the first Data Set will be summed with the Births of the
second to calculate the Births of the result (and the same for the
Deaths).

If there is the need to **apply an Operator on** **Measures having
different names**, the “rename” operator can be used to make their names
equal (for a complete description of the operator see the corresponding
section in the Part 2).

For example, given these two Data Sets:

   *D*:sub:`1` (Residents in the United States)

+-----------------------------------+-----------------------------------+
| **Ref.Date**                      | **Residents**                     |
+===================================+===================================+
| 2011                              | 1000                              |
+-----------------------------------+-----------------------------------+
| 2012                              | 1300                              |
+-----------------------------------+-----------------------------------+
| 2013                              | 1200                              |
+-----------------------------------+-----------------------------------+

..

   *D*:sub:`2` (Inhabitants of the European Union)

+-----------------------------------+-----------------------------------+
| **Ref.Date**                      | **Inhabitants**                   |
+===================================+===================================+
| 2011                              | 1100                              |
+-----------------------------------+-----------------------------------+
| 2012                              | 1200                              |
+-----------------------------------+-----------------------------------+
| 2013                              | 1050                              |
+-----------------------------------+-----------------------------------+

A Transformation for calculating the population of United States +
European Union is:

   *D*:sub:`r` *:= D*:sub:`2` *[rename Residents to Population] + D*:sub:`2` *[rename
   Inhabitants to Population]*

The result will be:

   *D*:sub:`r` (Population of United States + European Union)

+-----------------------------------+-----------------------------------+
| **Ref.Date**                      | **Population**                    |
+===================================+===================================+
| 2011                              | 2100                              |
+-----------------------------------+-----------------------------------+
| 2012                              | 2500                              |
+-----------------------------------+-----------------------------------+
| 2013                              | 1250                              |
+-----------------------------------+-----------------------------------+

Note again that the number and the names of the Measure Components of
the input Data Sets are assumed to match (following their possible
renaming), otherwise the invocation of the Operator is considered an
error.

To avoid a potentially excessive renaming, and only when just one
component is explicitly specified for each dataset by using the
*membership* notation, the VTL allows the operation even if the names
are different. For instance, this operation is allowed:

   *D*:sub:`r` *:= D*:sub:`1` *#Residents + D*:sub:`2` *#Inhabitants*

The result Data Set would have a single Measure named like the Measure
of the leftmost operand (i.e. *Residents*), which in turn can be
renamed, if convenient:

   *D*:sub:`r` *:= (D*:sub:`1` *#Residents + D*:sub:`2` *#Inhabitants)[rename Residents to
   Population]*

The following options and prescription, already described for the
operations on just one multi-measure Data Sets, are valid also for
operations on two (or more) multi-measure Data Sets and are repeated
here for convenience:

-  If there is the need to **apply an** **Operator only to specific
   Measures**, it is possible first to apply the *membership*, *keep* or
   *drop* operators to the input Data Sets in order to maintain only the
   needed Measures, like explained above for the case of a single input
   Data Set, and then the desired operation can be performed.

-  If there is the need to **apply some Operators to some specific
   Measures and keep the other ones unchanged**, one of the *join*
   operators can be used (the choice depends on the desired matching
   method). The *join* operations, in fact, provides also for a *calc*
   option which can be invoked and behaves exactly like the *calc*
   operator explained above.

-  Even in the case of operations on more than one Data Set, all the
   Measures of the input Data Sets must be compatible with the allowed
   data types of the Operator [37]_, otherwise (i.e. even if only one
   Measure is incompatible) the operation is not allowed.

In conclusion, the operation is allowed if the input Data Sets have the
same Measures and these are all compliant with the input data type of
the parameter that the Data Sets are passed for.

Operators which change the basic scalar type 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Some operators change the basic data type of the input Measure (e.g.
from *number* to *string*, from *string* to *date*, from *number* to
*boolean* …). Some examples are the *cast* operator that converts the
data types, the various *comparison* operators whose output is always
*boolean*, the *length* operator which returns the length of a string.

When the basic data type changes, also the Measure must change, because
a Variable (in this case used with the role of Measure in a Data
Structure) has just one type, which is the same wherever the Variable is
used [38]_.

Therefore, when an operator that changes the basic scalar type is
applied, the output Measure cannot be the same as the input Measure. In
these cases, the VTL systems must provide for a default Measure Variable
for each basic data type to be assigned to the output Data Set, which in
turn can be changed (renamed) by the user if convenient.

The VTL does not prescribe any predefined name or representation for the
default Measure Variable of the various scalar types, leaving different
organisations free to using they preferred or already existing ones.
Therefore, the definition of the default Measure Variables corresponding
to the VTL basic scalar types is left to the VTL implementations.

In the VTL manuals, just for explanatory purposes, the following default
Measures will be used:

.. uml::

    @startmindmap

    title Basic scalar types with default measure variables

        * Scalar
        ** <i>String</i> (string_var)
        ** <i>Number</i> (num_var)
        *** <i>Integer</i> (int_var)
        ** <i>Time</i> (time_var)
        *** <i>Date</i> (date_var)
        *** <i>Time-period</i> (period_var)
        ** <i>Boolean</i> (bool_var)

    @endmindmap

In some cases, in the examples of the Manuals, the default Boolean
variable is also called “condition”.

When the operators that change the basic data type of the input Measure
are applied directly at Data Set level, the VTL do not allow performing
multi-Measure operation. In other words, the input Data Set cannot have
more than one Measure. In case it has more Measures, a single Measure
must be selected, for example by means of the *membership* operator
(e.g. dataset_name#measure_name).

The multi-measure operations remain obviously possible when the
operators that change the basic data type of the input Measure are
applied at Component Level, for example by using the *calc* operator.

For example, taking again the example of import, export and number of
operations by reference date:

   *D*:sub:`1` = Import_Export_Operations

+----------------+----------------+-----------------+-----------------+
| **Ref.Date**   | **Import**     | **Export**      | **Operations**  |
+================+================+=================+=================+
| 2011           | 1000           | 1200            | 5000            |
+----------------+----------------+-----------------+-----------------+
| 2012           | 1300           | 1100            | 6400            |
+----------------+----------------+-----------------+-----------------+
| 2013           | 1200           | 1300            | 4800            |
+----------------+----------------+-----------------+-----------------+

And assuming that the conversion from number to string of all the
Measure Variables is desired, the following statement expressed at Data
Set level *cast (D*:sub:`1` *, string)* *is not allowed* because the Data Set
*D*:sub:`1` is multi-measure, while the following one, which makes the
conversion at the Component level, is allowed:

|  *D*:sub:`1` [ calc
|     import_string := cast (import, string)
|     , export_string := cast (export, string)
|     , operations_string := cast ( operations, string )
|     ]

For completeness, it is worth to say that also the various Join
operators allow the same operation that, for example for the inner join,
would be written as:

|   inner_join ( *D*:sub:`1` calc
|                import_string := cast (import, string)
|                , export_string := cast (export, string)
|                , operations_string := cast ( operations, string )
|                )

The join operators is designed primarily to act on many Data Sets and
allow applying these operations also when more Data Sets are joined.

Boolean operators 
~~~~~~~~~~~~~~~~~~

The Boolean operators (*And*, *Or*, *Not* …) take in input boolean
Measures and return booolean Measures. The VTL Boolean operators behave
like the operators that change the basic scalar type: if applied at the
Data Set level they are allowed only on mono-measure Data Sets, if
applied at the Component level they are allowed on mono and
multi-measure Data Sets.

Set operators 
~~~~~~~~~~~~~~

The Set operators (*union, intersection* …) apply the classical set
operations (union, intersection, difference, symmetric differences) to
the input Data Sets, considering them as mathematical functions (sets of
Data Points).

These operations are possible only if the Data Sets to be operated have
the same data structure, i.e. the same Identifiers, Measures and
Attributes.

For these operators the rules for the Attribute propagation are not
applied and the Attributes are managed like the Measures.

The Data Points common (or not common) to the input Data Sets are
determined by taking into account only the values of the Identifiers:
the common Data Points are the ones, which have the same values for all
the Identifiers.

If for a common Data Point one or more dependent variables (Measures and
Attributes) have different values in different Data Sets, the Data Point
of the leftmost Data Set are returned in the result.

Behaviour for Missing Data 
---------------------------

The awareness of missing data is very important for correct VTL
operations, because the knowledge of the Data Points of the result
depends on the knowledge of the Data Points of the operands. For
example, assume *D*:sub:`r` *:= D*:sub:`1` *+ D*:sub:`2` and suppose that some Data Points
of *D*:sub:`2` are unknown, it follows that the corresponding Data Points of
*D*:sub:`r` cannot be calculated and are unknown too.

Missing data are explicitly represented when some Measures or Attributes
of a Data Point have the value “NULL”, which denotes the absence of a
true value (the “NULL” value is not allowed for the Identifier
Components, in order to ensure that the Data Points are always
identifiable).

Missing data may also show as the absence of some expected Data Point in
the Data Set. For example, given a Data Set containing the reports to an
international organization relevant to different countries and different
dates, and having as Identifier Components the Country and the Reference
Date, this Data Set may lack the Data Points relevant to some dates (for
example the future dates) or some countries (for example the countries
that didn’t send their data) or some combination of dates and countries.

The absence of Data Points, however, does not necessarily denote that
the phenomenon under measure is unknown. In some cases, in fact, it
means that a certain phenomenon did not happen.

The handling of missing Data Points in VTL operations can be handled in
several ways. One way is to require all participating Data Points used
in a computation to be present and known; this is the correct approach
if the absence of a Data Point means that the phenomenon is unknown and
corresponds with the matching method of the *inner join* operator.
Another way is to allow some, but not all, Data Points to be absent,
when the absence does not mean that the phenomenon is unknown; this
corresponds to the behaviour of the left and full join Operator.

On the basic level, most of the scalar operations (arithmetic, logical,
and others) return NULL when any of their arguments is NULL.

The general properties of the NULL are the following ones:

-  **Data type.** The NULL value is the only value of multiple different
   types (i.e., all the nullable scalar types).

-  **Testing**. A built-in Boolean operator **is null** can be used to
   test if a scalar value is NULL.

-  **Comparisons**. Whenever a NULL value is involved in a comparison
   (>, <, >=, <=, in, not in, between) the result of the comparison is
   NULL.

-  **Arithmetic operations**. Whenever a NULL value is involved in a
   mathematical operation (+, -, \*, /, …), the result is NULL.

-  **String operations**. In operations on Strings, NULL is considered
   an empty String (“”).

-  **Boolean operations**. VTL adopts 3VL (three-valued logic).
   Therefore the following deduction rules are applied:

..

   TRUE *or* NULL → TRUE

   FALSE *or* NULL → NULL

   TRUE *and* NULL → NULL

   FALSE *and* NULL → FALSE

-  **Conditional operations**. The NULL is considered equivalent to
   FALSE; for example in the control structures of the type (*if (p)
   -then -else*), the action specified in *–then* is executed if the
   predicate *p* is TRUE, while the action *-else* is executed if the
   *p* is FALSE or NULL.

-  **Filter clauses**. The NULL is considered equivalent to FALSE; for
   example in the filter clause [*filter p*], the Data Points for which
   the predicate *p* is TRUE are selected and returned in the output,
   while the Data Points for which *p* is FALSE or NULL are discarded.

-  **Aggregations**. The aggregations (like *sum*, *avg* and so on)
   return one Data Point in correspondence to a set of Data Points of
   the input. In these operations, the input Data Points having a NULL
   value are in general not considered. In the average, for example,
   they are not considered both in the numerator (the sum) and in the
   denominator (the count). Specific cases for specific operators are
   described in the respective sections.

-  **Implicit zero**. Arithmetic operators assuming implicit zeros
   (+,-,\*,/) may generate NULL values for the Identifier Components in
   particular cases (superset-subset relation between the set of the
   involved Identifier Components). Because NULL values are in general
   forbidden in the Identifiers, the final outcome of an expression must
   not contain Identifiers having NULL values. As a momentary exception
   needed to allow some kinds of calculations, Identifiers having NULL
   values are accepted in the *partial results*. To avoid runtime error,
   possible NULL values of the Identifiers have to be fully eliminated
   in the final outcome of the expression (through a selection, or other
   operators), so that the operation of “assignment” (:=) does not
   encounter them.

If a different behaviour is desired for NULL values, it is possible to
**override** them. This can be achieved with the combination of the
*calc* clauses and *is null* operators.

For example, suppose that in a specific case the NULL values of the
Measure Component *M\ 1* of the Data Set *D\ 1* have to be considered
equivalent to the number 1, the following Transformation can be used to
multiply the Data Sets *D\ 1* and *D\ 2*, preliminarily converting NULL
values of *D\ 1.M\ 1* into the number 1. For detailed explanations of
*calc* and *is null* refer to the specific sections in the Reference
Manual.

   *D*:sub:`r` *:= D*:sub:`1` *[M*:sub:`1` *:= if M*:sub:`1` *is null then 1 else M*:sub:`1`] \* *D*:sub:`2`

Behaviour for Attribute Components
----------------------------------

Given an invocation of one Operator F, which can be written as *D*:sub:`r` *:=
F(D*:sub:`1` *, D*:sub:`2` *, … , D*:sub:`n` *)*, and considering that the input Data Sets
*D*:sub:`i` *(i=1,… n)* may have any number of Attribute Components, there can be the need
of calculating the desired Attribute Components of *D*:sub:`r`. This Section
describes the general VTL assumptions about how Attributes are handled
(the specific behaviours of the various operators are described in the
Reference Manual).

It should be noted that the Attribute Components of a Data Set are
dependent variables of the corresponding mathematical function, just
like the Measures. In fact, the difference between Attribute and Measure
Components lies only in their meaning: it is implicitly intended that
the Measures give information about the real world and the Attributes
about the Data Set itself (or some part of it, for example about one of
its measures), however the real uses of the Attribute Components are
very heterogeneous.

The VTL has different default behaviours for Attributes and for
Measures, to comply as much as possible with the relevant manipulation
needs.

At the Data Set level, the VTL Operators manipulate by default only the
Measures and not the Attributes.

At the Component level, instead, Attributes are calculated like
Measures, therefore the algorithms for calculating Attributes, if any,
can be specified explicitly in the invocation of the Operators. This is
the behaviour of clauses like *calc*, *keep*, *drop*, *rename*, and so
on, either inside or outside the *join* (see the detailed description of
these operators in the Reference Manual).

The Attribute propagation rule 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The users that want also to automatize the propagation of the
Attributes’ Values when no operation is explicitly defined can
optionally enforce a mechanism, called Attribute Propagation rule, whose
behaviour is explained here. The adoption of this mechanism is optional,
users are free to allow the attribute propagation rule or not. The users
that do not want to allow Attribute propagation rules simply will not
implement what follows.

The **Attribute propagation rule** is made of two main components,
namely the “virality” and the “default propagation algorithm”.

The “\ **virality**\ ” is a characteristic to be assigned to the
Attributes Components which determines if the Attribute is propagated
automatically in the result or not: a “\ **viral**\ ” Attribute is
propagated while a “\ **non-viral**\ ” Attribute is not (being a default
behaviour, the virality is applied when no explicit indication about the
keeping of the Attribute is provided in the expression). If the virality
is not defined, the Attribute is considered as non-viral.

The virality is also assigned to the Attribute propagated in the result
Data Set. By default, a viral Attribute in the input generates a
homonymous viral Attribute also in the result. Vice- versa, by default a
non-viral Attribute in the input generates a non-viral Attribute also in
the result (this happens when the Attribute in the result is calculated
through an explicitly expression but without specifying explicitly its
virality). The default assignation of the virality can be overridden by
operations at Component level as mentioned above, for example *keep*
(i.e., to keep a *non-viral* Attribute or not to keep a *viral* one) and
*calc* to alter the virality in the result Data Set, (from *viral* to
*non-viral* or vice-versa) [39]_.

Hence, the **default Attribute propagation rule** behaves as follows:

-  the non-viral Attributes are not kept in the result and their values
   are not considered;

-  the viral Attributes of the operand are kept and are considered viral
   also in the result; in other words, if an operand has a viral
   Attribute V, the result will have V as viral Attribute too;

-  the Attributes, like the Measures, are combined according to their
   names, e.g. the Attributes having the same names in multiple Operands
   are combined, while the Attributes having different names are
   considered as different Attributes;

-  whenever in the application of a VTL operator the input Data Points
   are not combined as for their Measures (i.e., one input Data Point
   can result in no more than one output Data Point), the values of the
   viral Attributes are simply copied from the input Data Point to the
   (possible) output Data Point (obviously, this applies always in the
   case of unary Operators which do not make aggregations);

-  Whenever in the application of a VTL operator two or more Data Points
   (belonging to the same or different Data Sets) are combined as for
   their Measures to give one output Data Point, the default propagation
   algorithm associated to the viral Attribute is applied, producing the
   Attribute value of the output Data Point. This happens for example
   for the unary Operators which aggregate Data Points and for Operators
   which combine the Data Points of more input Data Sets; in the latter
   case, the Attributes having the same names in such Data Sets are
   combined.

Extending an example already given for unary Operators, let us assume
that *D*:sub:`1` contains the salary of the employees of a multinational
enterprise (the only Identifier is the Employee ID, the only Measure is
the Salary, and there are two other Components defined as viral
Attributes, namely the Currency and the Scale of the Salary):

   *D*:sub:`1` = Salary of Employees

+---------------+-----------------+-----------------+-----------------+
| **Employee    | **Salary**      | **Currency**    | **Scale**       |
| ID**          |                 |                 |                 |
+===============+=================+=================+=================+
| A             | 1000            | U.S. $          | Unit            |
+---------------+-----------------+-----------------+-----------------+
| B             | 1200            | €               | Unit            |
+---------------+-----------------+-----------------+-----------------+
| C             | 800             | yen             | Thousands       |
+---------------+-----------------+-----------------+-----------------+
| D             | 900             | U.K. Pound      | Unit            |
+---------------+-----------------+-----------------+-----------------+

The Transformation *D*:sub:`r` *:= D*:sub:`1` *\* 1.10* applies only to the Measure
(the salary) and calculates a new value increased by 10%, the viral
Attributes are kept and left unchanged, so the result will be:

   *D*:sub:`r` = Increased Salary of Employees

+---------------+-----------------+-----------------+-----------------+
| **Employee    | **Salary**      | **Currency**    | **Scale**       |
| ID**          |                 |                 |                 |
+===============+=================+=================+=================+
| A             | 1100            | U.S. $          | Unit            |
+---------------+-----------------+-----------------+-----------------+
| B             | 1320            | €               | Unit            |
+---------------+-----------------+-----------------+-----------------+
| C             | 880             | yen             | Thousands       |
+---------------+-----------------+-----------------+-----------------+
| D             | 990             | U.K. Pound      | Unit            |
+---------------+-----------------+-----------------+-----------------+

The Currency and the Scale of *D*:sub:`r` will be considered viral too and
therefore would be kept also in case *D*:sub:`r` becomes operand of other
Transformations.

Another example can be given for operations involving more input Data
Sets (e.g. *D*:sub:`r` *:= D*:sub:`1` *+ D*:sub:`2`). Let us assume that *D*:sub:`1` and *D*:sub:`2` contain the
births and the deaths of the United States and the Europe respectively,
plus a viral Attribute that qualifies if the Value is estimated or not
(having values *True* or *False*).

   *D*:sub:`1` = Births & Deaths of the United States

+---------------+-----------------+-----------------+-----------------+
| **Ref.Date**  | **Births**      | **Deaths**      | **Estimate**    |
+===============+=================+=================+=================+
| 2011          | 1000            | 1200            | False           |
+---------------+-----------------+-----------------+-----------------+
| 2012          | 1300            | 1100            | False           |
+---------------+-----------------+-----------------+-----------------+
| 2013          | 1200            | 1300            | True            |
+---------------+-----------------+-----------------+-----------------+

..

   *D*:sub:`2` = Births & Deaths of the European Union

+---------------+-----------------+-----------------+-----------------+
| **Ref.Date**  | **Births**      | **Deaths**      | **Estimate**    |
+===============+=================+=================+=================+
| 2011          | 1100            | 1000            | False           |
+---------------+-----------------+-----------------+-----------------+
| 2012          | 1200            | 900             | True            |
+---------------+-----------------+-----------------+-----------------+
| 2013          | 1050            | 1100            | False           |
+---------------+-----------------+-----------------+-----------------+

Suppose that the default propagation algorithm associated to the
“Estimate” variable works as follows:

-  each value of the Attribute is associated to a default weight;

-  the result of the combination is the value having the highest weight;

-  if multiple values have the same weight, the result of the
   combination is the first in lexicographical order.

Assuming the weights 1 for “false” and 2 for “true”, the Transformation
*D*:sub:`r` *:= D*:sub:`1` *+ D*:sub:`2` will produce:

   *D*:sub:`r` = Births & Deaths of United States + European Union

+---------------+-----------------+-----------------+-----------------+
| **Ref.Date**  | **Births**      | **Deaths**      | **Estimate**    |
+===============+=================+=================+=================+
| 2011          | 2100            | 2200            | False           |
+---------------+-----------------+-----------------+-----------------+
| 2012          | 2500            | 2000            | True            |
+---------------+-----------------+-----------------+-----------------+
| 2013          | 2250            | 2400            | True            |
+---------------+-----------------+-----------------+-----------------+

Note also that:

-  if the attribute *Estimate* was non-viral in both the input Data
   Sets, it would not be kept in the result

-  if the attribute *Estimate* was viral only in one Data Set, it would
   be kept in the result with the same values as in the viral Data Set

In an expression, the default propagation of the Attributes is performed
always in the same order of execution of the Operators of the
expression, which is determined by their precedence and associativity
rules, as already explained in the relevant section.

For example, recalling the example already given example:

*D*:sub:`r` *:= D*:sub:`1` *+ D*:sub:`2` */ (D*:sub:`3` *– D*:sub:`4` */ D*:sub:`5` *)*

The evaluation of the Attributes will follow the order of composition of
the Measures:

| I.   *A(D*:sub:`4` */ D*:sub:`5` *)* (default precedence order)
| II.  *A(D*:sub:`3` *- I)* (explicitly defined order)
| III. *A(D*:sub:`2` **/** *II)* (default precedence order)
| IV.  *A(D*:sub:`1` *+ III)* (default precedence order)

Properties of the Attribute propagation algorithm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

An Attribute default propagation algorithm is a user-defined operator
that has a group of Values of an Attribute as operands and returns just
one Value for the same Attribute.

An Attribute default propagation algorithm (here called A) must ensure
the following properties (in respect to the application of a generic
Data Set operator “§” which applies on the measures):

   **Commutative law (1)**

   *A(D*:sub:`1` *§ D*:sub:`2` *) = A(D*:sub:`2` *§ D*:sub:`1` *)*

   The application of *A* produces the same result (in term of
   Attributes) independently of the ordering of the operands. For
   example, *A(D*:sub:`1` *+ D*:sub:`2` *) = A(D*:sub:`2` *+ D*:sub:`1` *)*. This may seem quite
   intuitive for “sum”, but it is important to point out that it holds
   for every operator, also for non-commutative operations like
   difference, division, logarithm and so on; for example *A(D*:sub:`1` */ D*:sub:`2` *) = A(D*:sub:`2` */ D*:sub:`1` *)*

   **Associative law (2)**

   *A(D*:sub:`1` *§ A(D*:sub:`2` *§ D*:sub:`3` *)) = A(A(D*:sub:`1` *§ D*:sub:`2` *) § D*:sub:`3` *)*

   Within one operator, the result of *A* (in term of Attributes) is
   independent of the sequence of processing.

   **Reflexive law (3)**

   *A( §(D*:sub:`1` *)) = A(D*:sub:`1` *)*

   The application of *A* to an Operator having a single operand gives
   the same result (in term of Attributes) that its direct application
   to the operand (in fact the propagation rule keeps the viral
   attributes unchanged).

Having these properties in place, it is always possible to avoid
ambiguities and circular dependencies in the determination of the
Attributes’ values of the result. Moreover, it is sufficient without
loss of generality to consider only the case of binary operators (i.e.
having two Data Sets as operands), as more complex cases can be easily
inferred by applying the VTL Attribute propagation rule recursively
(following the order of execution of the operations in the VTL
expression).

.. [32]
   A high-order function is a function which takes one or more other
   functions as arguments and/or provides another function as result.

.. [33]
   This corresponds to the "outer join" form of the join expressions,
   explained in details in the Reference Manual.

.. [34]
   As obvious, the data type depends on the parameter for which the Data
   Set is passed

.. [35]
   to preserve the functional behaviour *keep* and *drop* can be applied
   only on Measures and Attributes, for a deeper description of these
   operators see the corresponding section in the Reference Manual

.. [36]
   The *calc* Operator can be used also to calculate Attributes: for a
   more complete description of this operator see the corresponding
   section in the Reference Manual

.. [37]
   As obvious, the data type depends on the parameters for which the
   Data Set are passed

.. [38]
   In fact according to the IM, a Variable takes values in one Value
   Domain which represents just one basic data type, independently of
   where the Variable or the Value Domain are used (e.g. if they have
   the same type everywhere)

.. [39]
   In particular, the *keep* clause allows the specification of whether
   or not an attribute is kept in the result while the *calc* clause
   makes it possible to define calculation formulas for specific
   attributes. The *calc* can be used both for Measures and for
   Attributes and is a unary Operator, e.g. it may operate on Components
   of just one Data Set to obtain new Measures / Attributes.
