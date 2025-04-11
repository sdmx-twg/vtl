VTL Data types 
===============

The possible operations in VTL depend on the data types of the
artefacts. For example, numbers can be multiplied but text strings
cannot.

When an Operator is invoked, for each (formal) input Parameter, an
actual argument (operand) is passed to the Operator, and for the output
Parameter, an actual argument (result) is returned by the Operator. The
data type of the argument must comply with the allowed data types of the
corresponding Parameter (the allowed data types of each Parameter for
each Operator are specified in the Reference Manual).

Every possible argument for a VTL Operator (with special attention to
artefacts of the Information Model, e.g., Values, Sets, Data Sets) must
be typed and such type deterministically inferable.

In other words, VTL Operators are strongly typed and type compliance is
statically checked, i.e., violations result in compile-time errors.

Data types can be related one another, and in particular, a data type
can have sub-types and super-types. For example *integer number* is a
sub-type of the type *number*, and *number* is in turn a super-type of
*integer number*: this means that any integer number is also a number
but not the reverse, because there is no guarantee that a generic number
is also an integer number. More in general, an object of a certain type
is also of the respective super-types, but there is no guarantee that an
object of a super-type is of any of its sub-types.

As a consequence, if a Parameter is required to be of certain type, the
arguments have either this very type or any of its sub-types; arguments
of its super-types are not allowed (e.g. if a Parameter is a *number*,
an argument of type *integer* is accepted; vice versa, if it is an
*integer*, an argument of type *number* will not be accepted).

The data types depend on two main factors: the kind of values adopted
for the representation (e.g. text strings, numbers, dates, Boolean
values) and the kind of structure of the data (e.g. elementary scalar
values or compound values organized in more complex structures like
Sets, Components, Data Sets …).

The data types for scalar values also called “scalar types” (e.g. the
scalar 15 is of the scalar type “\ *number*\ ”, while “hello” is of the
scalar type “\ *string*\ ”). The scalar types are elementary because
they are not defined in term of other data types. All the other data
types are compound.

For the sake of simplicity, hereinafter the term “data type” is
sometimes abbreviated to “type” and the term “scalar type” to “scalar”.

A particular meta-syntax is used to specify the type of the Parameters.
For example, the symbol **::** means “is of the type …” or simply “is a
…” (e.g. “15 :: *number*\ ” means “15 is of the type *number*\ ”).

In the following sections, the classes of the VTL types are illustrated,
as well as some relationships between the types and the artefacts of the
Information Model.

Data Types overview
-------------------

Data Types model diagram
~~~~~~~~~~~~~~~~~~~~~~~~

.. uml::

    @startuml

        skinparam SameClassWidth true
        skinparam ClassBackgroundColor White
        skinparam linetype ortho
        skinparam nodesep 100

        class "Data Type" as DataType
        class "Scalar Type" as ScalarType
        class "Compound\nType" as CompoundType
        class "Basic Scalar\nType" as BasicScalarType
        class "Scalar Value\nDomain" as ScalarValueDomain
        class "Scalar Set" as ScalarSet
        class "Ruleset\nType" as RulesetType
        class "Component\nType" as ComponentType
        class "Operator\nType" as OperatorType
        class "Data Set\nType" as DataSetType
        class "Universal Set\nType" as UniversalSetType
        class "Product\nType" as ProductType
        class "Universal List\nType" as UniversalListType

        DataType "0..N" -left-> "0..N" DataType: "is subtype of"
        ScalarType -right-|> DataType
        CompoundType ----up-|> DataType
        BasicScalarType -up-|> ScalarType
        ScalarValueDomain -up-|> ScalarType
        ScalarSet -up-|> ScalarType

        ScalarValueDomain "0..N" -up-> "1..1" BasicScalarType: "refers to"
        ScalarSet "0..N" -up-> "1..1" ScalarValueDomain: "is subtype of"

        RulesetType --up-|> CompoundType
        ComponentType -up-|> CompoundType
        OperatorType --up-|> CompoundType
        DataSetType -up-|> CompoundType
        UniversalSetType --up-|> CompoundType
        ProductType -up-|> CompoundType
        UniversalListType --up-|> CompoundType

    @enduml

.. _explanation-of-the-diagram-3:

Explanation of the diagram 
~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Data Type**: this is the class of all the data types manipulated by
the VTL. As already said, the actual data type of an object depends on
its kind of representation and structure. As for the structure, a Data
Type may be a Scalar Data Type or a Compound Data Type.

**Scalar Type**: the class of all the scalar types, i.e., the possible
types of scalar Values. The scalar types are elementary because they are
not defined in terms of other types. The Scalar Types can be Basic
Scalar Types, Value Domain Scalar Types and Set Scalar Types.

**Compound Data Type**: the class of the compound types, i.e. the types
that are defined in terms of other types.

**Basic Scalar Type**: the class of the scalar types which exist by
default in VTL (namely, *string*,\ *number*, *integer, time, date,
time_period, duration, boolean)*.

**Value Domain Scalar Type**: the class of the scalar types
corresponding to all the scalar Values belonging to a Value Domain.

**Set Scalar Type**: the class of the scalar types corresponding to all
the scalar Values belonging to a Set (i.e., Value Domain Subset).

**Component Type**: the class of the types that the Components of the
Data Sets belong to, i.e. Represented Variables that assume a certain
Role in the Data Set Structure.

**Data Set Type**: the class of the Data Sets’ types, which are the more
common input types of the VTL operators.

**Operator Type**: the class of the Operators’ types, i.e., the
functions that convert the types of the input operands in the type of
the result.

**Ruleset Type**: the class of the Rulesets’ types, i.e. the set of
Rules defined by users that specify the behaviour of other operators
(like the check and the hierarchy operators).

**Product Type**: the class of the types that contain Cartesian products
of artefacts belonging to other generic types.

**Universal Set Type**: the class of the types that contain unordered
collections of other artefacts that belong to another generic type and
do not have repetitions.

**Universal List Type**: the class of the types that contain ordered
collections of other artefacts that belong to another generic type and
can have repetitions.

General conventions for describing the types
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  The name of the type is written in lower cases and without spaces
   (for example the Data Set type is named “dataset”).

-  The double colon **::** means “\ *is of the type …*\ ” or simply
   “\ *is a …*\ ”; for example the declaration

..

   operand :: string

   means that the operand is a *string*.

-  The vertical bar **\|** indicates mutually exclusive type options,
   for example

..

   operand :: scalar \| component \| dataset

   means that “operand” can be either *scalar*, or *component*, or *dataset.*

-  The angular parenthesis **< type2 >** indicates that type 2 (included
   in the parenthesis) restricts the specification of the preceding
   type, for example:

..

   operand :: component <string>

   means “the operand is a component of *string* basic scalar type”.

   If the angular parenthesis are omitted, it means that the preceding
   type is already completely specified, for example:

   operand :: component

   means “the operand is a component without other specifications” and
   therefore it can be of any *scalar* type, just the same as writing
   operand :: component<scalar> (in fact as already said, “scalar” means
   “any *scalar* type”).

-  The underscore **\_** indicates that the preceding type appears just
   one time, for example:

..

   measure<string> **\_**

   indicates just one Measure having the scalar type *string*; the
   underscore also mean that this is a non-predetermined generic
   element, which therefore can be any (in the example above, the string
   Measure can be any).

-  A specific element_name in place of the underscore denotes a
   predetermined element of the preceding type, for example:

..

   measure<string not null> my_text

   means just one Measure Component, which is a not-null *string* type
   and whose name is “my_text”.

-  The symbol **\_+** means that the preceding type may appear from 1 to
   many times, for example:

..

   measure<string> \_+

   means one or more generic Measures having the scalar type *string*
   (these Measures are not predetermined).

-  The symbol **\_\*** means that the preceding type may appear from 0
   to many times, for example:

..

   measure<string> \_\*

   means zero or more generic Measures having the scalar type *string*
   (these Measures are not predetermined).

Scalar Types
------------

Basic Scalar Types
~~~~~~~~~~~~~~~~~~

The Basic Scalar Types are the scalar types on which VTL is founded.

The VTL has various basic scalar types (namely, *string, number,
integer, time, date, time_period, duration, boolean)*. The super-type of
all the scalar types is the type *scalar*, which means “any scalar
value”. The type *number* has the sub-type *integer* and the type *time*
has two independent sub-types, namely *date* and *time_period.*

The hierarchical tree of the basic scalar types is the following:

.. uml::

    @startmindmap

        * <i>Scalar</i>
        ** <i>String</i>
        ** <i>Number</i>
        *** <i>Integer</i>
        ** <i>Time</i>
        *** <i>Date</i>
        *** <i>Time period</i>
        ** <i>Duration</i>
        ** <i>Boolean</i>

    @endmindmap

A Scalar Value of type **string** is a sequence of alphanumeric
characters of any length. On Scalar Values of type *string*, the string
operations can be allowed, like concatenation of strings, split of
strings, extraction of a part of a string (substring) and so on.

A Scalar Value of type **number** is a rational number of any magnitude
and precision, also used as approximation of a real number. On values of
type *number*, the numeric operations are allowed, such as addition,
subtraction, multiplication, division, power, square root and so on. The
type *integer* (positive and negative integer numbers and zero) is a
subtype of the type *number*.

A Scalar Value of type **time** denotes time intervals of any duration
and expressed with any precision. According to ISO 8601 (ISO standard
for the representation of dates and times), a time interval is the
intervening time between two time points. This type can allow operations
like shift of the time interval, change of the starting/ending times,
split of the interval, concatenation of contiguous intervals and so on
(not necessarily all these operations are allowed in this VTL version).

   The type **date** is a subtype of the type *time* which denotes time
   points expressed at any precision, which are time intervals starting
   and ending in the same time point (i.e. intervals of zero duration).
   A value of type *date* includes all the parts needed to identify a
   time point at the desired precision, like the year, the month, the
   day, the hour, the minute and so on (for example, 2018-04-05 is the
   fifth of April 2018, at the precision of the day).

   The type **time_period** is a subtype of the type *time* as well and
   denotes non- overlapping time intervals having a regular duration
   (for example the years, the quarters of years, the months, the weeks
   and so on). A value of the type *time_period* is composite and must
   include all the parts needed to identify a regular time period at the
   desired precision; in particular, *the time-period type includes the
   explicit indication* *of the kind of regular period* considered
   (e.g., “day”, “week”, “month”, “quarter” …). For example, the value
   2018M04, assuming that “M” stands for “month”, denotes the month n.4
   of the 2018 (April 2018). Moreover, 2018Q2, assuming that “Q” stands
   for “quarter”, denotes the second quarter of 2018. In these examples,
   the letters M and Q are used to denote the kind of period through its
   duration.

A Scalar Value of type **duration** denotes the length of a time
interval expressed with any precision and without connection to any
particular time point (for example one year, half month, one hour and
fifteen minutes). According to ISO 8601, in fact, a duration is the
amount of intervening time in a time interval. The *duration is* the
scalar type of possible Value Domains and Components representing the
period (frequency) of periodical data.

A Scalar Value of type **boolean** denotes a logical binary state,
meaning either “true” or “false”. Boolean Values allow logical
operations, such as: logical conjunction (and), disjunction (or),
negation (not) and so on.

All the scalar types are assumed by default to contain the conventional
value “\ **NULL**\ ”, which means “no value”, or “absence of known
value” or “missing value” (in other words, the scalar types by default
are “nullable”). Note that the “NULL” value, therefore, is the only
value of multiple different types (i.e., all the nullable scalar types).

The scalar types have corresponding non-nullable sub-types, which can be
declared by adding the suffix “\ *not null*\ ” to the name of the type.
For example, **string not null** is a string that cannot be NULL, as
well as **number not null** is a number that cannot be NULL.

The VTL assumes that a basic scalar type has a unique internal
representation and more possible external representations.

The internal representation is the reference representation of a scalar
type in a VTL system, used to process the scalar values. The use of a
unique internal representation allows to operate on values possibly
having different external formats: the values are converted in the
reference representation and then processed. Although the unique
internal representation can be very important for the operation of a VTL
system, not necessarily users need to know it, because it can be hidden
in the VTL implementation. The VTL does not prescribe any predefined
internal representation for the various scalar types, leaving different
VTL systems free to using they preferred or already existing ones.
Therefore, the internal representations to be used for the VTL scalar
types are left to the VTL implementations.

The external representations are the ones provided by the Value Domains
which refer to a certain scalar type (see also the following sections).
These are also the representations used for the Values of the Components
defined on such Value Domains. As obvious, the users have to know the
external representations and formats, because these are used in the Data
Point Values. Obviously, the VTL does not prescribe any predefined
external representation, leaving different VTL systems free to using
they preferred or already existing ones.

Examples of possible different choices for external representations:

-  for the *strings*, various character sets can be used;

-  for the *numbers*, it is possible to use the dot or the comma as
   decimal separator, a fixed or a floating point representation;
   non-decimal or non-positional numeral systems and so on;

-  for the *time, date, time_period, duration* it can be used one of the
   formats suggested by the ISO 8601 standard or other possible
   personalized formats;

-  the “\ *boolean*\ ” type can use the values TRUE and FALSE, or 0 and
   1, or YES and NO or other possible binary options.

It is assumed that a VTL system knows how to convert an external
representation in the internal one and vice-versa, provided that the
format of the external representation is known.

For example, the external representation of dates can be associated to
the internal one provided that the parts that specify year, month and
day are recognizable [20]_.

Value Domain Scalar Types
~~~~~~~~~~~~~~~~~~~~~~~~~

This is the class of the scalar Types corresponding to the scalar Values
belonging to the same Value Domains (see also the section “Generic Model
for Variables and Value Domains”).

The super-type of all the Value Domain Scalar Types is *valuedomain*,
which means any Value Domain Scalar Type. A specific Value Domain Scalar
Type is identified by the name of the Value Domain.

As said in the IM section, a Value Domain is the domain of allowed
Values for one or more represented variables. In other words, a Value
Domain is the space in which the abstractions of a certain category of
the reality (population, age, country, economic sector …) are
represented.

A Value Domain refers to one of the Basic Scalar Types, which is the
basic type of all the Values belonging to the Value Domain. A Value
Domain provides an external representation of the corresponding Basic
Scalar Type and can also restrict the possible (abstract) values of the
latter. Therefore, a Value Domain defines a customized scalar type.

For example, assuming that the “population” is represented by means of
numbers from zero to 100 billion, the (possible) “population” Value
Domain refers to the “\ *integer*\ ” basic scalar type, provides a
representation for it (e.g., the number is expressed in the positional
decimal number system without the decimal point) and allows only the
integer numbers from zero up to 100 billion (and not all the possible
numbers). Numeric operations are allowed on the population Values.

As another example, assuming that the “classes of population” are
represented by means of the characters from A to C (e.g. A for
population between 0 and 1 million, B for population greater that
1million until 1 billion, C for population greater than 1 billion), the
“classes of population” Value Domain refers to the “string” basic scalar
type and allows only the strings “A”, “B” or “C”. String operations are
possible on these values.

As usual, even if many operations are possible from the syntactical
point of view, not necessarily they make sense on the semantical plane:
as usual, the evaluation of the meaningfulness of the operations remains
up to the users. In fact, the same abstractions, in particular if
enumerated and coded, can be represented by using different possible
Value Domains, also using different scalar types. For example, the
*country* can be represented through the ISO 3166-1 numeric codes (type
number), or ISO alpha-2 codes (type string), or ISO alpha-3 codes (type
string), or other coding systems. Even if numeric operations are
possible on ISO 3166-1 country numeric codes, as well as string
operations are possible on ISO 3166-1 alpha-2 or alpha-3 country codes,
not necessarily these operations make sense.

While the Basic Scalar Types are the types on which VTL is founded and
cannot be changed, all the Value Domains are user defined, therefore
their names and their contents can be assigned by the users.

Some VTL Operators assume that a VTL system have certain kinds of Value
Domains which are needed to perform the correspondent operations [21]_.
In the VTL manuals, definite names and representations are assigned to
such Value Domains for explanatory purposes; however, these names and
representations are not mandatory and can be personalised if needed. If
VTL rules are exchanged between different VTL systems, the partners of
the exchange must be aware of the names and representations adopted by
the counterparties.

Set Scalar Types
~~~~~~~~~~~~~~~~

This is the class of the scalar types corresponding to the scalar Values
belonging to the same Sets (see also the section “Generic Model for
Variables and Value Domains”).

The super-type of all the Set Scalar Types is set, which means any Set
Scalar Type. A specific Set Scalar Type is identified by the name of the
Set.

A Set is a (proper or improper) subset of the Values belonging to a
Value Domain (the Set of all the values of the Value Domain is an
improper subset of it). A scalar Set inherits from its Value Domain the
Basic Scalar Type and the representation and can restrict the possible
Values of its Value Domain (as a matter of fact, except the Set which
contains all the values of its Value Domain and can also be assumed to
exist by default, the other Sets are defined just to restrict the Values
of the Value Domain).

External representations and literals used in the VTL Manuals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Values of the scalar types, when written directly in the VTL
definitions or expressions, are called *literals*.

The literals are written according to the external representations
adopted by the specific VTL systems for the VTL basic data types (i.e.,
the representations of their Value Domains). As already said, the VTL
does not prescribe any particular external representation.

In these VTL manuals, anyway, there is the need to write literals of the
various data types in order to explain the behaviour of the VTL
operators and give proper examples. The representation of these literals
are not intended to be mandatory and are not part of the VTL standard
specifications, these are only the representations used in the VTL
manuals for explanatory purposes and many other representations are
possible and legal.

The representations adopted in these manuals are described below.

The string values are written according the Unicode and ISO/IEC 10646
standards.

The **number** values use the positional numeral system in base 10.

-  A fixed-point *number begins* with the integer part, which is a
   sequence of numeric characters from 0 to 9 (at least one digit)
   optionally prefixed by plus or minus for the sign (no symbol means
   plus), a dot is always present in the end of the integer part and
   separates the (possible) fractional part, which is another sequence
   of numeric characters.

-  A floating point *number*, has a mantissa written like a fixed-point
   number, followed by the capital letter E (for “Exponent”) and by the
   exponent, written like a fixed-point integer;

..

   For example:

-  Fixed point *numbers*: 123.4567 +123.45 -8.901 0.123 -0.123

-  Floating point *numbers*: 1.23E2 +123.E-2 -0.89E1 0.123E0

..

   The **integer** values are represented like the *number* values with
   the following differences:

-  A fixed-point *integer* is written like a fixed-point *number* but
   without the dot and the fractional part.

-  A floating point *integer* is written like a floating-point *number*
   but cannot have a negative mantissa.

For example:

-  Fixed point integers: 123 +123 -123

-  Floating point integers: 123E0 1E3

The **time** values are conventionally represented through the initial
and final Gregorian dates of the time interval separated by a slash. The
accuracy is reduced at the level of the day (therefore omitting the time
units shorter than the day like hours, minutes, seconds, decimals of
second). The following format is used (this is one of the possible
options of the ISO 8601 standard):

   *YYYY-MM-DD/YYYY-MM-DD*

where *YYYY* indicates 4 digits for the year, *MM* indicates two digits
for the month, *DD* indicates two digits for the day. For example:

   2000-01-01/2000-12-31 the whole year 2000

   2000-01-01/2009-12-31 the first decade of the XXI century

   The **date** values are conventionally represented through one
   Gregorian date. The accuracy is reduced at the level of the day
   (therefore omitting the time units shorter than the day like hours,
   minutes, seconds, decimals of second). The following format is used
   (this is one of the possible options of the ISO 8601 standard):

   *YYYY-MM-DD*

   The meaning of the symbols is the same as above. For example:

   2000-12-31 the 31st December of the year 2000

   2010-01-01 the first of January of the year 2010

   The **time_period** values are represented for sake of simplicity
   with accuracy equal to the day or less (week, month …) and a
   periodicity not higher than the year. In the VTL manuals, the
   following format is used (this is a personalized format not compliant
   with the ISO 8601 standard):

   *YYYYPppp*

   where *YYYY* are 4 digits for the year, *P* is one character for
   specifying which is the duration of the regular period (e.g. D for
   day, W for week, M for month, Q for quarter, S for semester, Y for
   the whole year, see the codes of the *duration* data type below), ppp
   denotes from zero two three digits which contain the progressive
   number of the period in the year. For example:

   2000M12 the month of December of the year 2000

   2010Q1 the first quarter of the year 2010

   2020Y the whole year 2010

The **duration** values in these manuals are conventionally restricted
to very few predefined durations that are codified through just one
character as follows:

.. list-table::
   :header-rows: 1

   * - *Code*
     - *Duration*
   * - D
     - Day
   * - W
     - Week
   * - M
     - Month
   * - Q
     - Quarter
   * - S
     - Semester   
   * - A
     - Year (Annual) 

This is a very simple format not compliant with the ISO 8601 standard,
which allows representing durations in a much more complete, even if
more complex, way. As mentioned, the real VTL systems may adopt any
other external representation.

The **boolean** values used in the VTL manuals are *TRUE* and *FALSE*
(without quotes).

When a *literal* is written in a VTL expression, its basic scalar type
is not explicitly declared and therefore is unknown.

For ensuring the correctness of the VTL operations, it is important to
assess the scalar type of the literals when the expression is parsed.
For this purpose, there is the need for a mechanism for the
disambiguation of the literals types, because often the same literal
might itself belong to many types, for example:

-  the word “true” may be interpreted as a string or a boolean,

-  the symbol “0“ may be interpreted as a string, a number or a boolean,

-  the word “20171231” may be interpreted as a string, a number or a
   date.

The VTL does not prescribe any predefined mechanism for the
disambiguation of the scalar types of the literals, leaving different
VTL systems free to using they preferred or already existing ones. The
disambiguation mechanism, in fact, may depend also on the conventions
adopted for the external representation of the scalar types in the VTL
systems, which can be various.

In these VTL manuals, anyway, there is the need to use a disambiguation
mechanism in order to explain the behaviour of the VTL operators and
give proper examples. This mechanism, therefore, is not intended to be
mandatory and, strictly speaking, is not part of the VTL standard.

If VTL rules are exchanged between different VTL systems, the partners
of the exchange must be aware of the external representations and the
disambiguation mechanisms adopted by the counterparties.

The disambiguation mechanism adopted in these VTL manuals is the
following:

-  The string literals are written between double quotes, for example
   the literal “123456” is a string, even if its characters are all
   numeric, as well as “I am a string! “.

-  The numeric literals are assumed to have some pre-definite patterns,
   which are the numeric patterns used for the external representation
   of the numbers described above.

..

   A literal having one of these patterns is assumed to be a number.

-  The boolean literals are assumed to be the values TRUE and FALSE
   (capital letters without quotes).

In these manuals, it is also assumed that the types *time*, *date,
time_period* and *duration* do not directly support literals. Literal
values of such types can be anyway built from literals of other types
(for example they can be written as strings) and converted in the
desired type by the cast operator (type conversion). In some cases, the
conversion can be made automatically, (i.e., without the explicit
invocation of the cast operator – see the Reference Manual for more
details).

As mentioned, the VTL implementations may personalize the representation
of the literals and the disambiguation mechanism of the basic scalar
types as desired, provided that the latter work properly and no
ambiguities in understanding the type of the literals arise. For
example, in some cases the type of a literal can also be deduced from
the context in which it appears. As already pointed out, the possible
personalised mechanism should be communicated to the counterparties if
the VTL rules are exchanged.

Conventions for describing the scalar types
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  The keywords which identify the basic scalar types are the following:
   scalar, string, number, integer, time, date, time_period, duration,
   boolean.

-  By default, the basic scalar types are considered as nullable, i.e.,
   allowing NULL values.

-  The keyword **not null** following the type (and the “literal”
   keyword if present), means that the scalar type does not allow the
   NULL value, for example:

   operand :: string literal not null

   means that the operand is a literal of *string* scalar type and
   cannot be NULL; if not null is omitted the NULL value is meant to be
   allowed.

-  An **expression within square brackets** following the previous
   keywords, means that the preceding scalar type is restricted by the
   expression. This is a VTL *boolean* expression [22]_ (whose result
   can be TRUE or FALSE) which specifies a membership criterion, that is
   a condition that discriminates the values which belong to the
   restriction (sub-type) from the others (the value is assumed to
   belong to the sub-type only if the expression evaluates to TRUE). The
   keyword “value” stands for the generic value of the preceding scalar
   type and is used in the expression to formulate the restrictive
   condition. For example:

..

   integer [ value <= 6 ]

   is a sub-type of *integer* which contains only the integers lesser
   than or equal to 6.

   The following examples show some particular cases:

-  The generic expression **[ between ( value, x, y ) ]**\  [23]_
   restricts a scalar type by indicating a closed interval of possible
   values going from the value x to the value y, for example

..

   integer [between ( value, 1, 100 ) ]

   is the sub-type which contains the integers between 1 and 100.

-  The generic expression **[ (value > x ) and (value < y) ]** restricts
   a scalar type by indicating an open interval of possible values going
   from the value x to the value y, for example

..

   integer [ (value > 1 ) and (value < 100) ]

   means integer greater than 1 and lesser than 100 (i.e., between 2 and
   99).

-  By using **>=** or **<=** in the expressions above, the intervals can
   be declared as open on one side and closed on the other side, for
   example

..

   integer [ (value >= 1 ) and (value < 100) ]

   means integer greater than or equal to one and lesser than 100.

-  The generic expressions **[ value >= x ]** or **[ value > x ]** or
   **[ value <= y ]** or **[ value < y ]** restrict a scalar type by
   indicating an interval having one side unbounded, for example

..

   integer [ value >= 1 ]

   means integer equal to or greater than 1, while “integer[ value < 100
   ]” means an integer lesser than 100.

-  The generic expression **[ value in { v1, … , vN } ]**\  [24]_
   restricts a scalar type by specifying explicitly a set of possible
   values, for example

..

   integer { 1, 2, 3, 4, 5, 6 }

   means an integer which can assume only the integer values from 1 to
   6. The same result is obtained by specifying [ value in set_name ],
   where in is the “Element of” VTL operator and set_name is the name of
   an existing Set (Value Domain Subset) of the VTL IM.

-  By using in the expression the operator length [25]_ it is possible
   to restrict a scalar type by specifying the possible number of digits
   that the values can have, for example

..

   integer [ between ( length (value), 1, 10 ) ]

   means an integer having a length from one to 10 digits.

   As obvious, other kinds of conditions are possible by using other VTL
   operators and more conditions can be combined in the restricting
   expression by using the VTL boolean operators (and, or, not …)

-  Like in the general case, a restricted scalar type is considered by
   default as including the NULL value. If the NULL value must be
   excluded, the type specification must be followed by the symbol **not
   null**; for example

..

   integer [ between ( length (value), 1, 10 ) ] not null

   means a not-null integer having from one to 10 digits.

Compound Data Types
-------------------

The Compound data types are the types defined in terms of more
elementary types.

The compound data types are relevant to artefacts like Components, Data
Sets and to other compound structures. For example, the type Component
is defined in terms of the scalar type of its values, besides some
characteristics of the Component itself (for example the role it assumes
in the Data Set, namely Identifier, Measure or Attribute). Similarly,
the type of a Data Set (i.e. of a mathematical function) is defined in
terms of the types of its Components.

The compound Data Types are described in the following sections.

Component Types
~~~~~~~~~~~~~~~

This is the class of the Component types, i.e. of the Components of the
Data Structures (for example the country of residence used as an
Identifier, the resident population used as a Measure …).

A Component is essentially a Variable (i.e. an unknown scalar Value with
a certain meaning, e.g. the resident population) which takes Values in a
Value Domain or a Set and plays a definite role in a data structure
(i.e. Identifier, Measure or Attribute). A Component inherits the scalar
type (e.g. *number*) from the relevant Value Domain.

The main sub-types of the Component Type depend on the role of the
Component in the data structure and are the *identifier*, *measure* and
*attribute* types (if the automatic propagation of the Attributes is
supported, another sub-type is the *viral attribute*). These types
reflect the fact that the VTL behaves differently on Components of
different roles. Their common super- type is *component*, which means “a
Component having any role”.

Moreover, a Component type can be restricted by an associated scalar
type (e.g. *number, string …)*, therefore the complete specification of
a Component type takes the form

   role_type < scalar_type >

where the scalar type included in angular parenthesis, restricts the
specification of the preceding type (the role type); omitted angular
parenthesis mean “any scalar type”, which is the same as writing
<*scalar*>. Examples of Component types are the following:

component (or component<scalar>) any Component

-  component<number> any Component of scalar type *number*

-  identifier (or identifier<scalar>) any Identifier

   -  identifier<time not null> Identifier of scalar type *time not
      null*

-  measure (or measure<scalar>) any Measure

   -  measure<boolean> Measure of scalar type *Boolean*

-  attribute (or attribute<scalar>) any Attribute

   -  attribute<string> Attribute of scalar type *string*

In the list above, the more indented types are sub-types of the less
indented ones.

According to the functional paradigm, the Identifiers cannot contain
NULL values, therefore the scalar type of the Identifiers Components
must be “not null”.

In summary, the following conventions are used for describing Component
types.

-  As already said, the more general type is “\ **component**\ ” which
   indicates any component, for example:

..

   operand :: component

   means that “operand” may be any component.

-  The main sub-types of the *component* type correspond to the roles
   that the Component may assume in the Data Set, i.e., **identifier**,
   **measure**, **attribute**; for example:

..

   operand :: measure

   means that the operand must be a Measure.

   The additional role **viral attribute** exists if the automatic
   propagation of the Attributes is supported [26]_. The type
   *viral_attribute* is a sub-type of *attribute*.

-  By default, a Component can be either specified directly through its
   name or indirectly through a sub-expression that calculates it.

-  The optional keyword **name** following the type keyword means that a
   component name must be specified and that the component cannot be
   obtained through a sub-expression; For example:

..

   operand :: measure name <string>

   means that the name of a *string* Measure must be specified and not a
   string sub-expression [27]_. If the name keyword is omitted the
   sub-expression is allowed.

-  The symbol **<** scalar type **>** means that the preceding type is
   restricted to the scalar type specified within the angular brackets”,
   for example:

..

   operand :: component < string >

   means that the operand is a Component having any role and belonging
   to the *string* scalar type; if the restriction is not specified,
   then the scalar type can be any (for example operand:: attribute
   means that the operand is an Attribute of any scalar type).

-  In turn, the scalar type of a Component can be restricted; for
   example:

..

   operand:: measure < integer [ value between 1 and 100 ] not null >

   means that the operand can be a not-null integer Measure whose values
   are comprised between 1 and 100.

Data Set Types
~~~~~~~~~~~~~~

This is the class of the Data Sets types. The Data Sets are the main
kind of artefacts manipulated by the VTL and their types depend on the
types of their Components.

The super-type of all the Data Set types is *dataset*, which means “any
dataset” (according to the definition of Data Set given in the IM, as
obvious).

A sub-type of dataset is the Data Sets of time series, which fulfils the
following restrictive conditions:

-  The Data Set structure must contain one Identifier Component that
   acts as the reference time, which must belong to one of the basic
   scalar types *time*, *date* or *time_period*.

-  The possible values of the reference time Identifier Component must
   be regularly spaced

  -  For the type *time*, the time intervals must start (or end) at a
     regular periodicity and have the same duration

  -  For the type *date*, the time values must have a regular periodicity

  -  For the type *time_period* there are no additional conditions to
     fulfil, because the *time_period* values comprise by construction the
     indication of the period and therefore are regularly spaced by default

-  It is assumed that it exist the information about which is Identifier
   Components that acts as the reference time and about which is the
   period (frequency) of the time series and that such information is
   represented in some way in the VTL system. The VTL does not prescribe
   any predefined representation, leaving different VTL systems free to
   using they preferred or already existing ones. It is assumed that the
   VTL operators acting on time series know which is the reference time
   Identifier and the period of the time series and use these
   information to perform correct operations.

   Usually, the information about which is the reference time is
   included in the data structure definition of the Data Sets or in the
   definition of the Data Set Components.

   Some commonly used representations of the periodicity are the
   following:

  -  For the types *time* and *date*, the period is often represented
     through an additional Component of the Data Set (of any possible
     role) or an additional metadata relevant to the whole Data Set or
     some parts of it. This Component (or other metadata) is of the
     “duration” type and is often called “frequency”.

  -  For the type *time_period*, the periodicity is embedded in the
     *time_period* values.

..

   In any case, if some periodical data exist in the system, it is
   assumed that a Value Domain representing the possible periods exists
   and refers to the *duration* scalar type.

Within a Data Set of Time Series, a single Time Series is the set of
Data Points that have the same values for all the Identifier Components
except the reference time [28]_. A Data Set of time series can also
contain more time series relevant to the same phenomenon but having
different periodicities, provided that one or more Identifiers (other
than the reference time) distinguish the Time Series having different
periodicity.

The Data Sets of time series are the possible operands of the time
series operators (they are described in the Reference Manual).

More specific Data Set Types can be defined by constraining the
*dataset* type, for example by specifying the number and the type of the
possible Components in the different roles (Identifiers, Measures and
Attributes), and even their names if needed. Therefore the general
syntax is:

   dataset { type_constraint } or dataset_ts { type_constraint }

where the type_constraint may assume many different forms which are
described in detail in the following section. Examples of Data Set types
are the following:

.. list-table::

   * - dataset
     - Any Data Set (according to the IM)
   * - dataset { measure <number> \_\* }
     - A Data Set having one or more Measures of type *number*, without constraints on Identifiers and Attributes
   * - dataset { measure <boolean> \_ , attribute<string> \_\* }
     - A Data Set having one *boolean* Measure, one or more *string* Attributes and no constraints on Identifiers

In summary, the following conventions are used for describing Data Set
types.

-  The more general type is “\ **dataset**\ ” which means any possible
   Data Set of the VTL IM (in other words, a Data Set having any
   possible components allowed by the IM integrity rules)

-  By default, a Data Set can be either specified directly through its
   name or indirectly through a sub-expression which calculates it.

-  The optional keyword **name** following **dataset** means that a Data
   Set name must be specified and that the Data Set cannot be obtained
   through a sub-expression; for example:

..

   operand:: dataset name

   means that a Data Set name must be specified and not a
   sub-expression. If the name keyword is omitted the sub-expression is
   allowed.

-  The symbol **dataset { type_constraint }** indicates that the
   *type_constraint* included in curly parenthesis restricts the
   specification of the preceding *dataset type* without giving a
   complete type specification, but indicating only the constraints in
   respect to the general structure of the artefact of the Information
   Model corresponding to such *type*. For example, given that the
   generic structure of a Data Set in the IM may have any number of
   Identifiers, Measures and Attributes and that these Components may be
   of any scalar type, the declaration:

..

   operand :: dataset { measure<string> \_ }

   means that the operand is of type Data Set having any number of
   Identifiers (like in the IM), just one Measure of string type (as
   declared in the type declaration) and any number of Attributes (like
   in the IM).

-  Some or all the Data Set Components can also be predetermined. For
   example writing:

..

   operand:: dataset { identifier<st_Id1> Id1, …, identifier<st_IdN>
   IdN, measure<st_Me1> Me1, … , measure<st_MeL> MeL, attribute<st_At1>
   At1, … , attribute<st_AtK> AtK }

   means that the operand is of Data Set type and has the identifier,
   measure and attribute types and names specified within the curly
   brackets (in the example, <st_Id1> stands for the scalar type of the
   Component named Id1 and so on). This is the example of an extremely
   specific Data Set type in which all the component types and names are
   fixed in advance.

-  If a certain role (i.e. identifier, measure, attribute) is not
   specified, it means that there are no restrictions on it, for
   example:

..

   operand:: dataset { me<st_Me1 > Me1, … , me<st_MeL > MeL }

   means that the operand is of Data Set type and has the measure types
   and names specified within the curly brackets, while the Identifier
   and Attribute components have no restrictions and therefore can be
   any.

Product Types
~~~~~~~~~~~~~

This is the class of the Cartesian products of other types; a product
type is written in the form t\ :sub:`1` \* t\ :sub:`2` \* … \*
t\ :sub:`n` where *t\ i* (1 < i <= n) is another arbitrary type; the
elements of a Product type are n-tuples whose i\ :sub:`th` element
belongs to the type t\ :sub:`i`. For instance, the product type:

   *string \* integer \* boolean*

includes elements like [30]_ ("PfgTj", 7, true), ("kj-o", 80, false),
("", 4, false) but does not include for example ("qwe", 2017-12-31,
true), ("kj-o", 80, 92).

The superclass is *product*, which means any product type.

Product types can be used in practice for several reasons. They allow:

i.   the natural expression of exclusion or inclusion criteria (i.e.,
     constraints) over values of two or more dataset components;

ii.  the definition of the domain of the Operators in term of types of
     their Parameters

iii. the definition of more complex data types.

Operator Types
~~~~~~~~~~~~~~

This is the class of the Operators’ types, i.e., the higher-levels
functions that allow transformations from the type *t1* (the type of the
input Parameters), to the type *t2* (the type of the output Parameter).
An Operator Type is written in the form ‘\ *t1 -> t2*\ ’, where *t1* and
*t2* are arbitrary types. For example, the type of the following
operator says that it takes as input two integer Parameters and returns
a number:

   Op1 :: *integer* \* *integer* -> *number*

The superclass is *operator*, which means any operator type.

Ruleset Types
~~~~~~~~~~~~~

The class of the Ruleset types, i.e. the set of Rules that are used by
some operators like “check_hierarchy”, “check_datapoint”, “hierarchy”,
“transcode”. The general syntax for specifying a Ruleset type is
main_type_of_ruleset {type_constraint}.

The main Rulesets types are the *datapoint* and the *hierarchical*
Rulesets. Their super-type is *ruleset* that means “any Ruleset”.
Moreover, Rulesets can be defined either on Value domains or on
Variables, therefore the main_type_of_rulesets are:

   *ruleset*

-  *datapoint*

   -  *datapoint_on_value domains*

   -  *datapoint_on_variables*

-  *hierarchical*

   -  *hierarchical_on_value_domains*

   -  *hierarchical_on_variables*

In the list above, the more indented types are sub-types of the less
indented ones.

The type_constraint is optional and may assume many different forms that
depends on the main_type_of_ruleset. If the type_constraint is present,
the main_type_of_ruleset must specify if the ruleset is defined on Value
Domains or Variables (i.e., it must be one of the more indented types
above).

A datapoint Ruleset is defined on a Cartesian product of Value Domains
or Variables, therefore the type_constraint can contain such a list.
Examples of constrained datapoint types are:

   datapoint on value domains {(geo_area \* sector \* time_period \*
   numeric_value)}

   datapoint on variables {(ref_date \* import_currency \*
   import_country)}

   datapoint on value *domains* {date \* \_+}

The last one is the type of the Data Point Rulesets that are defined on
the “date” Value Domain and on one to many other Value Domains (“\_+”
means “one or more”).

A hierarchical Ruleset is defined on one Value Domain or Variable and
can contain conditions referred to other Value Domains or Variables;
therefore, the type_constraint for hierarchical Rulesets can take one of
the following forms:

   {value_domain \* (conditioningValueDomain1 \* … \*
   conditioningValueDomainN)}

   {variable \* (conditioningVariable1 \* … \* conditioningVariableN)}.

Examples of *hierarchical* types are:

   hierarchical on value domains {geo_area \* ( time_period )}
   hierarchical on variables { currency \* ( date \* country ) }
   hierarchical on value domains { \_ }

   hierarchical on value domains { \_ \* ( reference_date )}

The last one is the type of the Data Point Rulesets that are defined on
the “date” Value Domain and on one to many other Value Domains (in the
meta-syntax “\_+” means “one or more”).

The last one is the type of the Hierarchical Rulesets that are defined
on any Value Domain and are not conditioned by other Value Domains.

Universal Set Types
~~~~~~~~~~~~~~~~~~~

The Universal Sets are *unordered* collections of other objects that
belong to the same type *t* and do *not* have repetitions (each object
can belong to a Set just once). The Universal Sets are denoted as
*set*\ <*t*>, where *t* is another arbitrary type. If < t > is not
specified it means any universal set type.

Possible examples are the Sets of product types. For instance the
Universal Set Type:

   *set* < *string* \* *integer* \* *boolean* >

includes the sets [29]_:

   { ("PfgTj", 7, true), ("kj-o", 80, false), ("", 4, false) }

   { ("duo9", 67, true), ("io/p", 540, true) }

But does not includes the sets:

   { ("PfgTj", 7, true), 80, ("", 4, false) } in fact 80 is not a
   *product type*

   { ("duo9", 67, true), (50, true) } in fact (50, true) is not the
   right *product type*

   { ("", 4, false), (“F”, 8, true), ("", 4, false) } in fact ("", 4,
   false) is repeated

Universal List Types
~~~~~~~~~~~~~~~~~~~~

The Universal Lists are *ordered* collections of other objects that
belong to the same type *t* and can have repetitions (an object can
appear in a list more than once). The Universal Lists are denoted as
*list*\ <*t*>, where *t* is an arbitrary type. . If < t > is not
specified it means any universal list type.

For instance the following Universal List type:

   *list* < *component>*

includes elements like [31]_ [reference date, import, export] but does
not include elements like [dataset1, country, sector] and [import,
“text”] because dataset1 and “text” are not Components.

.. [20]
   This can be achieved in many ways that depend on the data type and on
   the adopted internal and external representations. For example, there
   can exist a default correspondence (e.g., 0 means always False and 1
   means always True for Boolean), or the parts of the external
   representation can be specified through a mask (e.g., for the dates,
   DD-MM-YYYY or YYYYMMDD specify the position of the digits
   representing year, month and day).

.. [21]
   For example, at least one default Value Domain should exists for each
   basic scalar type, the Value Domains needed to represent the results
   of the checks should exist, and so on.

.. [22]
   I.e., an expressions whose result is *boolean*

.. [23]
   “between ( x, y, z)” is the VTL operator which returns TRUE if x is
   comprised between y and z

.. [24]
   “in” is the VTL operator which returns TRUE if an element (in this
   case the value) belongs to a Set; the symbol { … , … , … } denotes a
   set defined as the list of its elements (separated by commas)

.. [25]
   “**length**” is the VTL Operator that returns the length of a string (in
   the example, the *integer* operand of the **length** operator is
   automatically cast to a string and its length is determined)

.. [26]
   See the section “Behaviour for Attribute Components”

.. [27]
   I.e., a sub-expressions whose result is *string*

.. [28]
   Therefore each combination of values of the Identifier Components
   except the reference time identifies a Time Series

.. [29]
   In the VTL syntax the symbol ( ) allows to define a tuple in-line by
   enumeration of its elements

.. [30]
   In the VTL syntax, the symbol {…} denotes a set defined as the list
   of its elements (separated by commas).

.. [31]
   In the VTL syntax, the symbol [ ] allows to define a List in-line by
   enumeration of its elements.
