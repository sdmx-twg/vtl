VTL-ML - Typical behaviours of the ML Operators
===============================================

In this section, the common behaviours of some class of VTL-ML operators
are described, both for a better understanding of the characteristics of
such classes and to factor out and not repeat the explanation for each
operator of the class.

Typical behaviour of most ML Operators 
---------------------------------------

Unless differently specified in the Operator description, the Operators
can be applied to Scalar Values, to Data Sets and to Data Set
Components.

The operations on Scalar Values are primitive and are part of the core
of the language. The other kind of operations can be typically be
obtained by means of the scalar operations in conjunction with the Join
operator, which is part of the core too.

In the operations on Data Set, the Operators are meant to be applied by
default only to the values of the Measures of the input Data Sets,
leaving the Identifiers unchanged. The Attributes follow by default
their specific propagation rules, which are described in the User
Manual.

In the operations on Components, the Operators are meant to be applied
on the specified components of one input Data Set, in order to calculate
a new component which becomes part of the resulting Data Set. In this
case, the Attributes can be operated like the Measures.

Operators applicable on one Scalar Value or Data Set or Data Set Component
--------------------------------------------------------------------------

*Operations on Scalar values*

The operator is applied on a scalar value and returns a scalar value.

*Operations on Data Sets*

The operator is applied on a Data Set and returns a Data Set.

For example, using a functional style and denoting the operator with
**f** ( … ), this can written as:

   DS_r **:=** **f (** DS_1 **)**

The same operation, using an infix style and denoting the operator as
**op**, can be also written as

   DS_r **:=** **op** DS_1

This means that the operator is applied to the values of all the
Measures of DS_1 in order to produce homonymous Measures in DS_r.

The application of the operator is allowed only if all the Measures of
the operand Data Set are of a data type compatible with the operator
(for example, a numeric operator is applicable only if all the Measures
of the operand Data Sets are numeric). If the Measures of the operand
Data Set are of different types, not all compatible with the operator to
be applied, the membership or the keep clauses can be used to select
only the proper Measures. No applicability constraints exist on
Identifiers and Attributes, which can be any.

As for the data content, for each Data Point (DP_1) of the operand Data
Set, a result Data Point (DP_r) is returned, having for the Identifiers
the same values as DP_1.

For each Data Point DP_1 and for each Measure, the operator is applied
on the Measure value of DP_1 and returns the corresponding Measure value
of DP_r.

For each Data Point DP_1 and for each viral Attribute, the value of the
Attribute propagates unchanged in DP_r.

As for the data structure, the result Data Set (DS_r) has the
Identifiers and the Measures of the operand Data Set (DS_1), and has the
Attributes resulting from the application of the attribute propagation
rules on the Attributes of the operand Data Set (DS_r maintains the
Attributes declared as “viral” in DS_1; these Attributes are considered
as “viral” also in DS_r, the “non-viral” Attributes of DS_1 are not kept
in DS_r).

*Operations on Data Set Components*

The operator is applied on a Component (COMP_1) of a Data Set (DS_1) and
returns another Component (COMP_r) which alters the structure of DS_1 in
order to produce the result Data Set (DS_r).

For example, using a functional style and denoting the operator with f (
… ), this can be written as:

   DS_r := DS_1 **[** **calc** COMP_r **:=** **f (** COMP_1\ **)** **]**

The same operation, using an infix style and denoting the operator as
**op**, can be written as:

   DS_r := DS_1 **[** **calc** COMP_r **:=** **op** COMP_1 **]**

This means that the operator is applied on COMP_1 in order to calculate
COMP_r.

-  If COMP_r is a new Component which originally did not exist in DS_1,
   it is added to the original Components of DS_1, by default as a
   Measure (unless otherwise specified), in order to produce DS_r.

-  If COMP_r is one of the original Measures or Attributes of DS_1, the
   values obtained from the application of the operator f ( … ) replace
   the DS_1 original values for such a Measure or Attribute in order to
   produce DS_r.

-  If COMP_r is one of the original Identifiers of DS_1, the operation
   is not allowed, because the result can become inconsistent.

In any case, an operation on the Components of a Data Set produces a new
Data Set, as in the example above.

The application of the operator is allowed only if the input Component
belongs to a data type compatible with the operator (for example, a
numeric operator is applicable only on numeric Components). As already
said, COMP_r cannot have the same name of an Identifier of DS_1.

As for the data content, for each Data Point DP_1 of DS_1, the operator
is applied on the values of COMP_1 so returning the value of COMP_r.

As for the data structure, like for the operations on Data Sets above,
the result Data Set (DS_r) has the Identifiers and the Measures of the
operand Data Set (DS_1), and has the Attributes resulting from the
application of the attribute propagation rules on the Attributes of the
operand Data Set (DS_r maintains the Attributes declared as “viral” in
DS_1; these Attributes are considered as “viral” also in DS_r, the
“non-viral” Attributes of DS_1 are not kept in DS_r). If an Attribute is
explicitly calculated, the attribute propagation rule is overridden.

Moreover, in the case of the operations on Data Set Components, the
(possible) new Component DS_r can be added to the original structure,
the role of a (possible) existing DS_1 Component can be altered, the
virality of a (possibly) existing DS_r Attribute can be altered, a
(possible) COMP_r non-viral Attribute can be kept in the result. For the
alteration of role and virality see also the **calc** clause.

Operators applicable on two Scalar Values or Data Sets or Data Set Components 
------------------------------------------------------------------------------

*Operation on Scalar values*

The operator is applied on two Scalar values and returns a Scalar value.

*Operation on Data Sets*

The operator is applied either on two Data Sets or on one Data Set and
one Scalar value and returns a Data Set. The composition of a Data Set
and a Component is not allowed (it makes no sense).

For example, using a functional style and denoting the operator with
**f** ( … ), this can be written as:

   DS_r **:=** **f (** DS_1\ **,** DS_2 **)**

The same kind of operation, using an infix stile and denoting the
operator as **op**, can be also written as

   DS_r **:=** DS_1 **op** DS_2

This means that the operator is applied to the values of all the couples
of Measures of DS_1 and DS_2 having the same names in order to produce
homonymous Measures in DS_r. DS_1 or DS_2 may be replaced by a Scalar
value.

The composition of two Data Sets (DS_1, DS_2) is allowed if the two
operand Data Sets have exactly the same Measures and if all these
Measures belong to a data type compatible with the operator (for
example, a numeric operator is applicable only if all the Measures of
the operand Data Sets are numeric). If the Measures of the operand Data
Sets are different or of different types not all compatible with the
operator to be applied, the membership or the **keep** clauses can be
used to select only the proper Measures. The composition is allowed if
these operand Data Sets have the same Identifiers or if one of them has
at least all the Identifiers of the other one (in other words, the
Identifiers of one of the Data Sets must be a superset of the
Identifiers of the other one). No applicability constraints exist on the
Attributes, which can be any.

As for the data content, the operand Data Sets (DS_1, DS_2) are joined
to find the couples of Data Points (DP_1, DP_2), where DP_1 is from the
first operand (DS_1) and DP_2 from the second operand (DS_2), which have
the same values as for the common Identifiers. Data Points that are not
coupled are left out (the inner join is used). An operand Scalar value
is treated as a Data Point that couples with all the Data Points of the
other operand. For each couple (DP_1, DP_2) a result Data Point (DP_r)
is returned, having for the Identifiers the same values as DP_1 and
DP_2.

For each Measure and for each couple (DP_1, DP_2), the Measure values of
DP_1 and DP_2 are composed through the operator so returning the Measure
value of DP_r. An operand Scalar value is composed with all the Measures
of the other operand.

For each couple (DP_1, DP_2) and for each Attribute that propagates in
DP_r, the Attribute value is calculated by applying the proper Attribute
propagation algorithm on the values of the Attributes of DP_1 and DP_2 .

As for the data structure, the result Data Set (DS_r) has all the
Identifiers (with no repetition of common Identifiers) and the Measures
of both the operand Data Sets, and has the Attributes resulting from the
application of the attribute propagation rules on the Attributes of the
operands (DS_r maintains the Attributes declared as “viral” for the
operand Data Sets; these Attributes are considered as “viral” also in
DS_r, the “non-viral” Attributes of the operand Data Sets are not kept
in DS_r).

*Operation on Data Set Components*

The operator is applied either on two Data Set Components (COMP_1,
COMP_2) belonging to the same Data Set (DS_1) or on a Component and a
Scalar value, and returns another Component (COMP_r) which alters the
structure of DS_1 in order to produce the result Data Set (DS_r). The
composition of a Data Set and a Component is not allowed (it makes no
sense).

For example, using a functional style and denoting the operator with
**f** ( … ), this can be written as:

   DS_r := DS_1 **[** **calc** COMP_r **:=** **f (** COMP_1\ **,**
   COMP_2 **)** **]**

The same operation, using an infix style and denoting the operator as
**op**, can be written as:

   DS_r := DS_1 **[** **calc** COMP_r **:=** COMP_1 **op** COMP_2 **]**

This means that the operator is applied on COMP_1 and COMP_2 in order to
calculate COMP_r.

-  If COMP_r is a new Component which originally did not exist in DS_1,
   it is added to the original Components of DS_1, by default as a
   Measure (unless otherwise specified), in order to produce DS_r.

-  If COMP_r is one of the original Measures or Attributes of DS_1, the
   values obtained from the application of the operator f ( … ) replace
   the DS_1 original values for such a Measure or Attribute in order to
   produce DS_r.

-  If COMP_r is one of the original Identifiers of DS_1, the operation
   is not allowed, because the result can become inconsistent.

In any case, an operation on the Components of a Data Set produces a new
Data Set, like in the example above.

The composition of two Data Set Components is allowed provided that they
belong to the same Data Set [3]_. Moreover, the input Components must
belong to data types compatible with the operator (for example, a
numeric operator is applicable only on numeric Components). As already
said, COMP_r cannot have the same name of an Identifier of DS_1.

As for the data content, for each Data Point of DS_1, the values of
COMP_1 and COMP_2 are composed through the operator so returning the
value of COMP_r.

As for the data structure, the result Data Set (DS_r) has the
Identifiers and the Measures of the operand Data Set (DS_1), and has the
Attributes resulting from the application of the attribute propagation
rules on the Attributes of the operand Data Set (DS_r maintains the
Attributes declared as “viral” in DS_1; these Attributes are considered
as “viral” also in DS_r, the “non-viral” Attributes of DS_1 are not kept
in DS_r). If an Attribute is explicitly calculated, the attribute
propagation rule is overridden.

Moreover, in the case of the operations on Data Set Components, a
(possible) new Component DS_r can be added to the original structure of
DS_1, the role of a (possibly) existing DS_1 Component can be altered,
the virality of a (possibly) existing DS_r Attributes can be altered, a
(possible) COMP_r non-viral Attribute can be kept in the result. For the
alteration of role and virality see also the **calc** clause.

Operators applicable on more than two Scalar Values or Data Set Components 
---------------------------------------------------------------------------

The cases in which an operator can be applied on more than two Data Sets
(like the Join operators) are described in the relevant sections.

*Operation on Scalar values*

The operator is applied on more Scalar values and returns a Scalar value
according to its semantics.

*Operation on Data Set Components*

The operator is applied either on a combination of more than two Data
Set Components (COMP_1, COMP_2) belonging to the same Data Set (DS_1) or
Scalar values, and returns another Component (COMP_r) which alters the
structure of DS_1 in order to produce the result Data Set (DS_r). The
composition of a Data Set and a Component is not allowed (it makes no
sense).

For example, using a functional style and denoting the operator with
**f** ( … ), this can be written as:

   DS_r := DS_1 **[** **substr** COMP_r **:=** **f (** COMP_1\ **,**
   COMP_2, COMP_3 **)** **]**

This means that the operator is applied on COMP_1, COMP_2 and COMP_3 in
order to calculate COMP_r.

-  If COMP_r is a new Component which originally did not exist in DS_1,
   it is added to the original Components of DS_1, by default as a
   Measure (unless otherwise specified), in order to produce DS_r.

-  If COMP_r is one of the original Measures or Attributes of DS_1, the
   values obtained from the application of the operator f ( … ) replace
   the DS_1 original values for such a Measure or Attribute in order to
   produce DS_r.

-  If COMP_r is one of the original Identifiers of DS_1, the operation
   is not allowed, because the result can become inconsistent.

In any case, an operation on the Components of a Data Set produces a new
Data Set, like in the example above.

The composition of more Data Set Components is allowed provided that
they belong to the same Data Set [4]_. Moreover, the input Components
must belong to data types compatible with the operator (for example, a
numeric operator is applicable only on numeric Components). As already
said, COMP_r cannot have the same name of an Identifier of DS_1.

As for the data content, for each Data Point of DS_1, the values of
COMP_1, COMP_2 and COMP_3 are composed through the operator so returning
the value of COMP_r.

As for the data structure, the result Data Set (DS_r) has the
Identifiers and the Measures of the operand Data Set (DS_1), and has the
Attributes resulting from the application of the attribute propagation
rules on the Attributes of the operand Data Set (DS_r maintains the
Attributes declared as “viral” in DS_1; these Attributes are considered
as “viral” also in DS_r, the “non-viral” Attributes of DS_1 are not kept
in DS_r). If an Attribute is explicitly calculated, the attribute
propagation rule is overridden.

Moreover, in the case of the operations on Data Set Components, a
(possible) new Component DS_r can be added to the original structure of
DS_1, the role of a (possibly) existing DS_1 Component can be altered,
the virality of a (possibly) existing DS_r Attributes can be altered, a
(possible) COMP_r non-viral Attribute can be kept in the result. For the
alteration of role and virality see also the **calc** clause.

Behaviour of Boolean operators 
-------------------------------

The Boolean operators are allowed only on operand Data Sets that have a
single measure of type *boolean*. As for the other aspects, the
behaviour is the same as the operators applicable on one or two Data
Sets described above.

Behaviour of Set operators
--------------------------

These operators apply the classical set operations (union, intersection,
difference, symmetric differences) to the Data Sets, considering them as
sets of Data Points. These operations are possible only if the Data Sets
to be operated have the same data structure, and therefore the same
Identifiers, Measures and Attributes [5]_.

Behaviour of Time operators 
----------------------------

The *time* operators are the operators dealing with *time*, *date* and
*time_period* basic scalar types. These types are described in the User
Manual in the sections “Basic Scalar Types” and “External
representations and literals used in the VTL Manuals”.

The time-related formats used for explaining the time operators are the
following (they are described also in the User Manual).

For the *time* values:

   *YYYY-MM-DD/YYYY-MM-DD*

   Where *YYYY* are 4 digits for the year, *MM* two digits for the
   month, *DD* two digits for the day. For example:

   2000-01-01/2000-12-31 the whole year 2000

   2000-01-01/2009-12-31 the first decade of the XXI century

For the *date* values:

   *YYYY-MM-DD*

   The meaning of the symbols is the same as above. For example:

   2000-12-31 the 31\ :sup:`st` December of the year 2000

   2010-01-01 the first of January of the year 2010

For the *time_period* values:

   *YYYY{P}{NNN}*

   Where *YYYY* are 4 digits for the year, *P* is one character for the
   period indicator of the regular period (it refers to the *duration*
   data type and can assume one of the possible values listed below),
   *NNN* are from zero to three digits which contain the progressive
   number of the period in the year. For annual data the A and the three
   digits NNN can be omitted. For example:

   2000M12 the month of December of the year 2000 (duration: M)

   2010Q1 the first quarter of the year 2010 (duration: Q)

   2010A the whole year 2010 (duration: A)

   2010 the whole year 2010 (duration: A)

For the *duration* values, which are the possible values of the period
indicator of the regular periods above, it is used for simplicity just
one character whose possible values are the following:

   *Code Duration*

   D Day

   W Week

   M Month

   Q Quarter

   S Semester

   A Year

As mentioned in the User Manual, these are only examples of possible
time-related representations, each VTL system is free of adopting
different ones. In fact no predefined representations are prescribed,
VTL systems are free to using they preferred or already existing ones.

Several time operators deal with the specific case of Data Sets of time
series, having an Identifier component that acts as the reference time
and can be of one of the scalar types *time*, *date* or *time_period*;
moreover this Identifier must be periodical, i.e. its possible values
are regularly spaced and therefore have constant duration (frequency).

It is worthwhile to recall here that, in the case of Data Sets of time
series, VTL assumes that the information about which is the Identifier
Components that acts as the reference time and which is the period
(frequency) of the time series exists and is available in some way in
the VTL system. The VTL Operators are aware of which is the reference
time and the period (frequency) of the time series and use these
information to perform correct operations. VTL also assumes that a Value
Domain representing the possible periods (e.g. the period indicator
Value Domain shown above) exists and refers to the *duration* scalar
type. For the assumptions above, the users do not need to specify which
is the Identifier Component having the role of reference time.

The operators for time series can be applied only on Data Sets of time
series and returns a Data Set of time series. The result Data Set has
the same Identifier, Measure and Attribute Components as the operand
Data Set and contains the same time series as the operand. The Attribute
propagation rule is not applied.

Operators changing the data type
--------------------------------

These Operators change the Scalar data type of the operands they are
applied to (i.e. the type of the result is different from the type of
the operand). For example, the **length** operator is applied to a value
of *string* type and returns a value of *integer* type. Another example
is the **cast** operator.

*Operation on Scalar values*

The operator is applied on (one or more) Scalar values and returns one
Scalar value of a different data type.

*Operation on Data Sets*

If an Operator change the data type of the Variable it is applied to
(e.g., from *string* to *number*), the result Data Set cannot maintain
this Variable as it happens in the previous cases, because a Variable
cannot have different data types in different Data Sets [6]_.

As a consequence, the converted variable cannot follow the same rules
described in the sections above and must be replaced, in the result Data
Set, by another Variable of the proper data type.

For sake of simplicity, the operators changing the data type are allowed
only on mono-measure operand Data Sets, so that the conversion happens
on just one Measure. A default generic Measure is assigned by default to
the result Data Set, depending on the data type of the result (the
default Measure Variables are reported in the table below).

Therefore, if the operands are originally multi-measure, just one
Measure must be pre-emptively selected (for example through the
membership operator) in order to apply the changing-type operator.
Moreover, if in the result Data Set a different Measure Variable name is
desired than the one assigned by default, it is possible to change the
Variable name (see the **rename** operator).

As for the Identifiers and the Attributes, the behaviour of these
operators is the same as the typical behaviour of the unary or binary
operators.

*Operation on Data Set Components*

For the same reasons above, the result Component cannot be the same as
one of the operand Components and must be of the appropriate Scalar data
type.

*Default Names for Variables and Value Domains used in this manual*

The following table shows the default Variable names and the relevant
default Value Domain. These are only the names used in this manual for
explanatory purposes and can be personalised in the implementations. If
VTL rules are exchanged, the personalised names need to be shared with
the partners of the exchange.

+---------------------+-----------------------+-----------------------+
| **Scalar data       | **Default Variable**  | **Default Value       |
| type**              |                       | Domain**              |
+=====================+=======================+=======================+
| string              | string_var            | string_vd             |
+---------------------+-----------------------+-----------------------+
| number              | num_var               | num_vd                |
+---------------------+-----------------------+-----------------------+
| integer             | int_var               | int_vd                |
+---------------------+-----------------------+-----------------------+
| time                | time_var              | time_vd               |
+---------------------+-----------------------+-----------------------+
| time_period         | time_period_var       | time_period_vd        |
+---------------------+-----------------------+-----------------------+
| date                | date_var              | date_vd               |
+---------------------+-----------------------+-----------------------+
| duration            | duration_var          | duration_vd           |
+---------------------+-----------------------+-----------------------+
| boolean             | bool_var              | bool_vd               |
+---------------------+-----------------------+-----------------------+

Type Conversion and Formatting Mask 
------------------------------------

The conversions between *scalar* types is provided by the operator
**cast**, described in the section of the general purpose operators.
Some particular types of conversion require the specification of a
formatting mask, which specifies which format the source or the
destination of the conversion should assume. The formatting masks for
the various scalar types are explained here.

If needed, the formatting Masks can be personalized in the VTL
implementations. If VTL rules are exchanged, the personalised masks need
to be shared with the partners of the exchange.

The Numbers Formatting Mask
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The **number formatting mask** can be defined as a combination of
characters whose meaning is the following:

-  “D” one numeric digit (for the mantissa of the scientific notation)

-  “E” one numeric digit (for the exponent of the scientific notation)

-  “\*” an arbitrary number of digits

-  “+” at least one digit

-  “.” (dot) can be used as a separator between the integer and the
   decimal parts.

-  “,” (comma) can be used as a separator between the integer and the
   decimal parts.

Examples of valid masks are:

DD.DDDDD, DD.D, D, D.DDDD, D\*.D\*, D+.D+ , DD.DDDEEEE

The Time Formatting Mask
~~~~~~~~~~~~~~~~~~~~~~~~

The format of the values of the types *time*, *date* and *time_period*
can be specified through specific formatting masks. A mask related to
*time*, *date* and *time_period* is formed by a sequence of symbols
which denote:

-  the time units that are used, for example years, months, days

-  the format in which they are represented, for example 4 digits for
   the year (2018), 2 digits for the month within the year (04 for
   April) and 2 digits for the day within the year and the month (05 for
   the 5\ :sup:`th`)

-  the order of these parts; for example, first the 4 digits for the
   year, then the 2 digits for the month and finally the 2 digits for
   the day

-  other (possible) typographical characters used in the representation;
   for example, a line between the year and the month and between the
   month and the day (e.g., 2018-04-05).

..

   The time formatting masks follows the general rules below.

   For a numerical representations of the time units:

-  A digit is denoted through the use of a **special character** which
   depends on the time unit. for example Y is for “year”, M is for
   “month” and D is for “day”

-  The special character is lowercase for the time units shorter than
   the day (for example h for “hour”, m for “minute”, s for “second”)
   and uppercase for time units equal to “day” or longer (for example W
   for “week”, Q for “quarter”, S for “semester”)

-  The number of letters matches the number of digits, for example YYYY
   means that the year is represented with four digits and MM that the
   month is of 2 digits

-  The numerical representation is assumed to be padded by leading 0 by
   default, for example MM means that April is represented as 04 and the
   year 33 AD as 0033

-  If the numerical representation is not padded, the optional digits
   that can be omitted (if equal to zero) are enclosed within braces;
   for example {M}M means that April is represented by 4 and December by
   12, while {YYY}Y means that the 33 AD is represented by 33

..

   For textual representations of the time units:

-  **Special words** denote a textual localized representation of a
   certain unit, for example DAY means a textual representation of the
   day (MONDAY, TUESDAY …)

-  An optional number following the special word denote the maximum
   length, for example DAY3 is a textual representation that uses three
   characters (MON, TUE …)

-  The case of the special word correspond to the case of the value; for
   example day3 (lowercase) denotes the values mon, tue …

-  The case of the initial character of the special word correspond to
   the case of the initial character of the time format; for example
   Day3 denotes the values Mon, Tue …

-  The letter P denotes the period indicator, (i.e., day, week, month …)
   and the letter p denotes the number of periods

..

   Representation of more time units:

-  If more time units are used in the same mask (for example years,
   months, days), it is assumed that the more detailed units (e.g., the
   day) are expressed through the order number that they assume within
   the less detailed ones (e.g., the month and the year). For example,
   if years, weeks and days are used, the weeks are within the year
   (from 1 to 53) and the days are within the year and the week (from 1
   to 7).

-  The position of the digits in the mask denotes the position of the
   corresponding values; for example, YYYMMDD means four digits for the
   year followed by two digits for the month and then two digits for the
   day (e.g., 20180405 means the year 2018, month April, day
   5\ :sup:`th`)

-  Any other character can be used in the mask, meaning simply that it
   appears in the same position; for example, YYYY-MM-DD means that the
   values of year, month and day are separated by a line (e.g.,
   2018-04-05 means the year 2018, month April, day 5\ :sup:`th`) and
   \\PMM denotes the letter “P” followed by two characters for the
   month.

-  The special characters and the special words, if prefixed by the
   reverse slash (\\) in the mask, appear in the same position in the
   time format; for example \\PMM\\M means the letter “P” followed by
   two characters for the month and then the letter “M”; for example,
   P03M means a period of three months (this is an ISO 8601 standard
   representation for a period of MM months). The reverse slash can
   appear in the format if needed by prefixing it with another reverse
   slash; for example YYYY\\\\MM means for digits for the year, a
   reverse slash and two digits for the month.

..

   The **special characters** and the corresponding time units are the
   following:

   C century

   Y year

   S semester

   Q quarter

   M month

   W week

   D day

   h hour digit (by default on 24 hours)

   m minute

   s second

   d decimal of second

   P period indicator (see the “duration” codes below)

   p number of periods

The **special words** for textual representations are the following:

AM/PM indicator of AM / PM (e.g. am/pm for “am” or “pm”)

MONTH textual representation of the month (e.g., JANUARY for January)

DAY textual representation of the day (e.g., MONDAY for Monday)

**Examples of formatting masks for the time scalar type:**

A Scalar Value of type *time* denotes time intervals of any duration and
expressed with any precision, which are the intervening time between two
time points.

These examples are about three possible ISO 8601 formats for expressing
time intervals:

-  Start and end time points, such as
   "2015-03-03T09:30:45Z/2018-04-05T12:30:15Z"

..

   VTL Mask: YYYY-MM-DDThh:mm:ssZ/YYYY-MM-DDThh:mm:ssZ

-  Start and duration, such as "2015-03-03T09:30:45-01/P1Y2M10DT2H30M"

..

   VTL Mask: YYYY-MM-DDThh:mm:ss-01/PY\\YM\\MDD\\DT{h}h\\Hmm\\M

-  Duration and end, such as "P1Y2M10DT2H30M/2018-04-05T12:30:00+02"

..

   VTL Mask: PY\\YM\\MDD\\DT{h}h\\Hmm\\M/YYYY-MM-DDThh:mm:ssZ

Example of other possible ISO formats having accuracy reduced to the day

-  Start and end, such as "20150303/20180405"

..

   VTL Mask: YYYY-MM-DD/YYYY-MM-DD

-  Start and duration, such as "2015-03-03/P1Y2M10D"

..

   VTL Mask: YYYY-MM-DD/PY\\YM\\MDD\\D

-  Duration and end, such as "P1Y2M10D/2018-04-05"

..

   VTL Mask: PY\\YM\\MDD\\DT/YYYY-MM-DD

**Examples of formatting masks for the date scalar type:**

A *date* scalar type is a point in time, equivalent to an interval of
time having coincident start and end duration equal to zero.

These examples about possible ISO 8601 formats for expressing dates:

-  Date and day time with separators: "2015-03-03T09:30:45Z"

..

   VTL Mask: YYYY-MM-DDThh:mm:ssZ

-  Date and day time without separators "20150303T093045-01 "

..

   VTL Mask: YYYYMMDDThhmmss-01

Example of other possible ISO formats having accuracy reduced to the day

-  Date and day-time with separators "2015-03-03/2018-04-05"

..

   VTL Mask: YYYY-MM-DD/YYYY-MM-DD

-  Start and duration, such as "2015-03-03/P1Y2M10D"

..

   VTL Mask: YYYY-MM-DD/PY\\YM\\MDD\\D

**Examples of formatting masks for the time_period scalar type:**

A *time_period* denotes non-overlapping time intervals having a regular
duration (for example the years, the quarters of years, the months, the
weeks and so on). The time_period values include the representation of
the duration of the period.

These examples are about possible formats for expressing time-periods:

-  Generic time period within the year such as: "2015Q4",
   "2015M12""2015D365"

..

   VTL Mask: YYYYP{ppp} where P is the period indicator and ppp three
   digits for the number of periods, in the values, the period indicator
   may assume one of the values of the duration scalar type listed
   below.

-  Monthly period: "2015M03"

..

   VTL Mask: YYYY\\MMM

**Examples of formatting masks for the duration scalar type:**

A Scalar Value of type *duration* denotes the length of a time interval
expressed with any precision and without connection to any particular
time point (for example one year, half month, one hour and fifteen
minutes).

These examples are about possible formats for expressing durations
(period / frequency)

-  Non ISO representation of the *duration* in one character, whose
   possible codes are:

..

   *Code Duration*

   D Day

   W Week

   M Month

   Q Quarter

   S Semester

   A Year

VTL Mask: P (period indicator)

-  ISO 8601 composite duration: "P10Y2M12DT02H30M15S" (P stands for
   “period”)

..

   VTL Mask: \\PYY\\YM\\MDD\\DThh\\Hmm\\Mss\\S

-  ISO 8601 duration in weeks: "P018W" (P stands for “period”)

..

   VTL Mask: \\PWWW\\W

-  ISO 4 characters representation: P10M (ten months), P02Q (two
   quarters) …

..

   VTL Mask: \\PppP

**Examples of fixed characters used in the ISO 8601 standard which can
appear as fixed characters in the relevant masks:**

   P designator of duration

   T designator of time

   Z designator of UTC zone

   “+” designator of offset from UTC zone

   ”-“ designator of offset form UTC zone

   / time interval separator

Attribute propagation 
----------------------

The VTL has different default behaviours for Attributes and for
Measures, to comply as much as possible with the relevant manipulation
needs. At the Data Set level, the VTL Operators manipulate by default
only the Measures and not the Attributes. At the Component level,
instead, Attributes are calculated like Measures, therefore the
algorithms for calculating Attributes, if any, can be specified
explicitly in the invocation of the Operators. This is the behaviour of
clauses like **calc**, **keep**, **drop**, **rename** and so on, either
inside or outside the join (see the detailed description of these
operators in the Reference Manual).

The users which want to automatize the propagation of the Attributes’
Values can optionally enforce a mechanism, called Attribute Propagation
rule, whose behaviour is explained in the User Manual (see the section
“Behaviour for Attribute Components”). The adoption of this mechanism is
optional, users are free to allow the attribute propagation rule or not.
The users that do not want to allow Attribute propagation rules simply
will not implement what follows.

In short, the automatic propagation of an Attribute depends on a Boolean
characteristic, called “virality”, which can be assigned to any
Attribute of a Data Set (a viral Attribute has virality = TRUE, a
non-viral Attribute has virality=FALSE, if the virality is not defined,
the Attribute is considered as non-viral).

By default, an Attribute propagates from the operand Data Sets (DS_i) to
the result Data Set (DS_r) if it is “viral” at least in one of the
operand Data Sets. By default, an Attribute which is viral in one of the
operands DS_i is considered as viral also in the result DS_r.

The Attribute propagation rule does not apply for the time series
operators.

The Attribute propagation rule does not apply if the operations on the
Attributes to be propagated are explicitly specified in the expression
(for example through the **keep** and **calc** operators). This way it
is possible to keep in the result also Attribute which are non-viral in
all the operands, to drop viral Attributes, to override the (possible)
default calculation algorithm of the Attribute, to change the virality
of the resulting Attributes.

.. [3]
   As obvious, the input Data Set can be the result of a previous
   composition of more other Data Sets, even within the same expression

.. [4]
   As obvious, the input Data Set can be the result of a previous
   composition of more other Data Sets, even within the same expression

.. [5]
   According to the VTL IM, the Variables that have the same name have
   also the same data type

.. [6]
   This according both to the mathematical meaning of a Variable and the
   VTL Information Model; in fact a Represented Variable is defined on
   just one Value Domain, which has just one data type, independently of
   the Data Structures and the Data Sets in which the Variable is used.
