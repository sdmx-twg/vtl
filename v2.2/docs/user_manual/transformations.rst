VTL Transformations
===================

This section describes the key concepts, assumptions and characteristics
of the VTL which are needed to a VTL user to define Transformations. As
mentioned in the section about the general characteristics above, the
language is oriented to users without deep information technology (IT)
skills, who should be able to define calculations and validations
independently, without the intervention of IT personnel. Therefore, the
VTL has been designed to make the definition of the Transformations as
intuitive as possible and to reduce the chances of errors.

As already said, a Transformation consists of a statement that assigns
the outcome of the evaluation of an Expression to an Artefact of the
Information Model. Then, Transformations are made of the following
components:

-  A right side, which contains the expression to be evaluated, whose
   inputs are the operands of the Transformation

-  An assignment operator

-  A left side, which specifies the Artefact which the outcome of the
   expression is assigned to (this is the result of the Transformation)

Examples of assignments are (assuming that Di *(i=1…n)* are Data Sets):

-  *D1 := D2*

-  *D3 := D4 + D5*

Assuming that *E* is the expression, *R* is the result and *IO\ i (i=1,…
n)* the input Operands, the mathematical form of a Transformation based
on *E* can be written as follows:

*R := E (IO\ 1, IO\ 2, … , IO\ n)*

The expression uses any number of VTL operators in combination to
specify a compound operation. Because all the VTL operators are
functional, the whole expression is functional too.

Transformations are properly chained for their execution; in fact, the
result *R\ i* of a Transformation *T\ i* can be referenced as operand of
another Transformation *T\ j*. In this case, the former Transformation
is evaluated first in order to provide the input for the latter. To
enforce the consistency of the results, the cycles are not allowed,
therefore in the case above the result *R\ j* of the Transformation
*T\ j* cannot be operand of the Transformation *T\ i* and cannot
contribute to the calculation of any operand of *T\ i*, even indirectly
through a chain of other Transformations.

The order in which the user defines the Transformations may be important
for a better understanding but cannot override the order of execution
determined according their input-output relationships.

For the rules for the Transformation consistency, see also the section
“Generic Model for Transformation” above.

A VTL program is a set of Transformations executed in the same run,
which is defined as a Transformation Scheme.

The Expression
--------------

A VTL expression constitutes the right side of a Transformation. It
takes one or more input operands and returns one output artefact.

An expression is the invocation of one or more operators in combination,
in which the result of an operator is passed as input parameter to
another operator, and so on, in a tree structure. The root of the tree
structure is last operator to be applied and gives the final result.

For example, for the expression *a + b - c* the result of the addition
*a+b* is passed to the following subtraction, which gives the final
result.

An expression is built from the following ingredients:

-  **Operators**, which specify the operation to be performed (e.g. +, -
   and so on). As mentioned, the standard VTL operators are described in
   detail in the Reference Manual, moreover the VTL allows defining and
   then invoking “user defined operators” (see the Reference Manual, the
   VTL-DL for the definition and the VTL-ML for the invocation). Each
   operator envisages a certain number of input parameters of definite
   data types and produces an outcome having a definite data type (the
   types parameter are described in detail in the Reference Manual for
   each operator).

-  **Operands**, which are the actual arguments passed to the invoked
   Operators, for example writing *D\ 1 + D\ 2* the Operator “+” is
   invoked and the Operands *D\ 1* and *D\ 2* are passed to it. The
   Operands can be:

   -  **Named artefacts**, which are VTL artefacts specified through
      their names. Their actual values are obtained either referring to
      an external persistent source (persistent artefacts) or as result
      of previous Transformations (non-persistent artefacts) of the same
      Transformation Scheme; they are identified by means of a symbolic
      name (e.g. in *D\ 1 + D\ 2* the Operands *D\ 1* and *D\ 2* are
      identified by the names *D\ 1* and *D\ 2*). Examples of identified
      artefacts are the Data Sets (like *D\ 1* and *D\ 2* above) and the
      Data Set Components (like *D\ 1\ #C\ 1, D\ 1\ #C\ 2, D\ 1\ #C\ 3*,
      where # means that *C\ j* is a Component of the Data Set *D\ i*).

   -  **Literals**, which are VTL artefacts whose actual values are
      directly written in the expression; for example, in the invocation
      *D\ 1 + 7* the second operand (7) is a literal, in this case a
      scalar literal. Also other kind of artefacts can be written in the
      expressions, for example the curly brackets denote the value of a
      Set (for example *{1, 2, 3, 4, 5, 6}* is the set of the integers
      from 1 to 6) and the square brackets denote a list (for example
      *[7, 5, 3, 6, 3]* is a list of numbers).

-  **Parenthesis**, which specify the order of evaluation of the
   operators; for example in the expression *D\ 1 \* ( D\ 2* *+ D\ 3* )
   first the sum *D\ 2* *+ D\ 3* is evaluated and then their product for
   *D\ 1*. In case the parenthesis are not used, the default order of
   evaluation (described in the Reference Manual) is applied (in the
   example, first the product and then the sum).

An expression implies different steps of calculation, for example the
expression:

   *R := O\ 1 + O\ 2 / (O\ 3 – O\ 4 / O\ 5)*

can be calculated in the following steps:

I.   *(O\ 4 / O\ 5)*

II.  *(O\ 3 - I)*

III. *(O\ 2* **/** *II)*

IV.  *(O\ 1 + III)*

The intermediate and final results (I, II, III, IV) of the expression
are assumed to be non-persistent (temporary). The persistency of the
result Data Set *R* is controlled by the assignment operator, as
described below.

An intermediate result within the expression can be only the input of
other operators in the same expression.

In general, unless differently specified in the Reference Manual, in the
invocation of an operator any operand can be the result of a
sub-expression that calculates it. For example, taking the
exponentiation whose syntax is

   *power(base, exponent)*,

the invocation *power(D\ 1 + D\ 2* *, 2)* is allowed and means that
first *D\ 1 + D\ 2* is calculated and then the result is squared. As
usual, the data type of the calculated operand must comply with the
allowed data types of the corresponding Parameter (in the example above,
*D\ 1 + D\ 2* must have a numeric data type, otherwise it cannot be
squared).

The nesting capabilities allow writing from very simple to very complex
expressions. The complexity of the expressions can be managed by the
users by splitting or merging transformations. For example, taking again
the example above, the following two options would give the same result:

   Option 1:

   *D\ r := power(D\ 1 + D\ 2* *, 2)*

   Option 2:

   *D\ 3 := D\ 1 + D\ 2*

   *D\ r := power( D\ 3* *, 2)*

In both cases, in fact, first *D\ 1 + D\ 2* is evaluated and then the
*power* operator is applied to obtain *D\ r*.

In general, it is possible either to have simpler expressions by
splitting and chaining Transformations or to have a minor number of
Transformations by writing more complex expressions.

The Assignment
--------------

The assignment of an expression to an artefact is done through an
assignment operator. The VTL has two assignment operators, the
persistent and the non-persistent assignment:

   <- persistent assignment

   := non-persistent assignment

The former assigns the outcome of the expression on the left side to a
persistent artefact, the latter to a non-persistent one; therefore, the
choice of the assignment operator allows controlling the persistency of
the artefact that is result of the Transformation.

The only artefact that can be made persistent is the result (the left
side artefact). In fact, as already mentioned, the intermediate and
final results of the right side expression are always considered as
non-persistent.

For example, taking again the example of Transformation above:

   *D\ r := power(D\ 1 + D\ 2* *, 2)*

The result *D\ r* can be declared as persistent by writing:

   *D\ r <- power(D\ 1 + D\ 2* *, 2)*

Instead, to make persistent also the intermediate result of *D\ 1 +
D\ 2* it is necessary to split the Transformation like in the option 2
above:

   *D\ 3 <- D\ 1 + D\ 2*

   *D\ r <- power( D\ 3* *, 2)*

The persistent assignment operator is also called *Put*, because it is
used to specify that a result must be put in a persistent store. The
*Put* has two parameters, the first is the final result of the
expression on the right side that has to be made persistent, the second
is the reference to the persistent Data Set which will contain such a
result.

The Result 
-----------

The left side artefact, i.e. the result of the Transformation, is always
a named Data Set (i.e. a Data Set identified by means of a symbolic name
like explained in the previous section).

The data type and structure of the left side Data Set coincide with the
data type and structure of the outcome of the expression, which must be
a Data Set as well.

Almost all VTL operators act on Data Sets. Many VTL operators can act
also on Data Set Components to produce other Data Set Components,
however even in this case the outcome of the expression is a new Data
Set that contains the calculated Components.

An expression can result also in scalar Value; because many VTL
operators can act on scalar Values to obtain other scalar Values,
furthermore some particular operations on Data Sets can eliminate
Identifiers, Measures and Attributes and obtain scalar Values (see the
Reference Manual). The result of such expressions is considered as a
named Data Set that does not have Components (Identifiers, Measures and
Attributes) and therefore contains just one scalar Value. The Data Sets
without Components can be manipulated and possibly stored like any other
Data Set. Because the VTL notion of Data Set is logical and not
physical, more Data Set without Components can be stored in the same
physical Data Set if appropriate.

The current VTL version does not include operators that produce other
output data types, for example, there are not operators that manipulate
Sets (however this is a possible future development).

In fact, the Data Set at the moment is the only type of Artefact that
can be produced and stored permanently through a command of the
language.

The names
---------

The artefact names
~~~~~~~~~~~~~~~~~~

The names are the labels that identify the “named” artefacts that are
operands or result of the transformations.

For ensuring the correctness of the VTL operations, it is important to
distinguish the names from the scalar literals when the expression is
parsed. For this purpose, the disambiguation mechanism that
distinguishes the types of the scalar literals must also be able of
distinguishing names and scalar literals.

As already mentioned in the section about the scalar literals, the VTL
does not prescribe any predefined disambiguation mechanism, leaving
different VTL systems free to using they preferred or already existing
ones. In these VTL manuals, anyway, there is the need to use some
disambiguation mechanisms in order to explain the behaviour of the VTL
operators and give proper examples. These mechanisms are not intended to
be mandatory and therefore, strictly speaking, they are not part of the
VTL standard specifications. If no drawbacks exist, however, their
adoption is encouraged to foster the convergence between possible
different practices. If VTL rules are exchanged, the disambiguation
mechanisms should be communicated to the counterparties, at least if
they are different from the one suggested hereinafter.

The general rules for the names are given below. As said above, these
rules can be personalized (for example restricted) in some
implementations (e.g. a particular implementation can require that a
name starts with a letter).

The names are strings of characters no more than 128 characters long and
are classified in regular and non-regular names.

The **regular names**:

-  can contain alphabetic and numeric characters and the special
   characters underscore (\_) and dot (.) ,

-  must begin with an alphanumeric character and not with a special
   character

-  must contain at least one alphabetic character

-  cannot be a VTL reserved word

Examples or regular names are *abcdef*, *1ab_cde*, *a.b.c_d_e*,
*1234_5*.

The regular names are:

-  written in the Transformations / Expressions without delimiters

-  case insensitive

The non-regular names:

-  can contain alphanumeric characters and, in addition to the
   underscore and the dot, any other Unicode character

-  can contain blanks

-  can begin with special characters

-  can contain only numeric characters

-  can be equal to the VTL reserved words

The non-regular names are:

-  written in the Transformations / Expressions with single quotes as
   delimiters

-  case sensitive

Examples of non-regular names, which therefore are enclosed in single
quotes, are ’\_\ *abcdef’*, ‘\ *1ab-cde’*, ‘\ *12345’*, ‘\ *power’* (the
first begins with a special character, the second contains the “-“
character that is not allowed, the third contains only numeric
characters, the fourth coincides to a VTL reserved word (the name of the
exponentiation operator). These names would not be recognized by VTL if
not enclosed between single quotes.

The **VTL reserved words** (and symbols) are:

-  the keywords of the VTL-ML and VTL-DL operators and of their
   parameters (e.g. <, := , # , inner_join, as, using, filter, apply,
   rename, to, + , - , power, and, or, not, group by, group except,
   group all, having …)

-  the names of the classes of VTL artefacts of the VTL-IM (e.g., value,
   value domain, value domain subset, set, variable, component, data
   set, data structure, operator, operand parameter, transformation …)

-  additional keywords for possible future use like get, put, join, map,
   mapping, merge, transcode and the names of commonly used mathematical
   and statistical functions.

The environment name
~~~~~~~~~~~~~~~~~~~~

In order to ensure non-ambiguous definitions and operations, the names
of the artefacts must be unique, meaning that an identifier cannot be
assigned to more than one artefact.

In practice, the unicity of the names is ensured in a certain
environment, that can be also called namespace (i.e. the space in which
the names are assigned without ambiguities). For examples, more
Institutions (agencies) which operate independently can assign the same
name to different artefacts, therefore they are cannot be considered as
part of the same environment.

The artefacts input to a Transformation can come also from other
environments than the one in which the Transformation is defined. In
these cases, the artefact identifier must be accompanied by a
**Namespace**, which specifies the Data Set environment, to univocally
identify the artefact to retrieve (for example the Data Set).

Therefore, the reference to an artefact belonging to a different
environment assume the following form:

   *Namespace\\Name*

*Namespace* is the identifier of the environment and *Name* is the
identifier of the artefact within the environment. The separator is the
backslash (*\\*).

When the Namespace is not specified, the artefact is assumed to belong
to the same environment as the Transformation.

The result of a Transformation is always assumed to belong to the same
environment as the Transformation, therefore the specification of the
namespace of the result is not allowed.

Within a given environment, the names of all the VTL artefacts (such as
Value Domains, Sets, Variables, Components, Data Sets) are assigned by
the users.

Some VTL Operators assume that a VTL environment have certain default
names for some kinds of Variables or Value Domains which are needed to
perform the correspondent operations (for example, the operators which
transform the data type of the Measure of the input Data Sets assign a
default name to the resulting Measure, the check operators assign
default names to Components and Value Domains needed to represent the
results of the checks). In the VTL manuals, some definite default names
are adopted for explanatory purposes, however these names are not
mandatory and can be personalised if needed. If VTL rules are exchanged
between different VTL systems, the partners of the exchange must be
aware of the names adopted by the counterparties.

The connection to the persistent storage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As described in the VTL IM, the Data Set is considered as an artefact at
a logical level, equivalent to a mathematical function. A VTL Data Set
contains the set of Data Points that are the occurrences of the
function. Each Data Point is interpreted an association between a
combination of values of the independent variables (the Identifiers) and
the corresponding values of the dependent variables (the Measures and
Attributes).

Therefore, the VTL statements reference the conceptual/logical Data Sets
and not the objects in which they are persistently stored. As already
mentioned, there can be any relationships between the VTL logical Data
Sets and the corresponding persistent objects (one VTL Data Set in one
storage object, more VTL Data Sets in one storage object, one VTL Data
Set in more storage objects, more VTL Data Sets in more storage
objects). The mapping between the VTL Data Sets and the storage objects
is out of the scope of the VTL and is left to the implementations.
