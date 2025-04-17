Evolution of VTL 2.0 in respect to VTL 1.0
==========================================

Important contributions gave origin to the work that brought to the
VTL 2.0, then the VTL 2.1 and now to this VTL 2.2 version.

Firstly, it was not possible to acknowledge immediately - in VTL 1.0 -
all of the remarks received during the 1.0 public review. Secondly, the
publication of VTL 1.0 triggered the launch of other reviews and proofs
of concepts, by several institutions and organizations, aimed at
assessing the ability of VTL of supporting properly their real use
cases.

The suggestions coming from these activities had a fundamental role in
designing the new version of the language.

The main improvements are described below.

The Information Model
---------------------

The VTL Information Model describes the artefacts that VTL manipulates
(i.e. it provides generic models for defining Data and their structures,
Variables, Value Domains and so on) and how the VTL is used to define
validations and transformations (i.e. a generic model for
Transformations).

In VTL 2.0, some mistakes of VTL 1.0 have been corrected and new kinds
of artefacts have been introduced in order to make the representation
more complete and to facilitate the mapping with the artefacts of other
standards (e.g. SDMX, DDI …).

As already said, VTL is intended to operate at logical/conceptual level
and independently of the implementation, actually allowing different
implementations. For this reason, VTL-IM provides only for a core
abstract view of data and calculations and leaves out the implementation
aspects.

Some other aspects, even if logically related to the representation of
data and calculations, are intentionally left out because they can
depend on the actual implementation too. Some of them are mentioned
hereinafter (for example the representation of real-world historical
changes that impact model artefacts).

The operational metadata needed for supporting real processing systems
are also out of VTL scope.

The implementation of the VTL-IM abstract model artefacts needs to
take into account the specificities of the standards (like SDMX, DDI …)
and the information systems for which it is used.

Structural artefacts and reusable rules
---------------------------------------

The structural artefacts of the VTL IM (e.g. a set of code items) as
well as the artefacts of other existing standards (like SDMX, DDI, or
others) are intrinsically reusable. These so-called “structural”
artefacts can be referenced as many times as needed.

In order to empower the capability of reusing definitions, a main
requirement for VTL 2.0 has been the introduction of reusable rules (for
example, validation or aggregation rules defined once and applicable to
different cases).

The reusable rules are defined through the VTL definition language and
applied through the VTL manipulation language.

The core language and the standard library
------------------------------------------

VTL 1.0 contains a flat list of operators, in principle not related to
one another. A main suggestion for VTL 2.0 was to identify a core set of
primitive operators able to express all of the other operators present
in the language. This was done in order to specify the semantics of
available operators more formally, avoiding possible ambiguities about
their behaviour and fostering coherent implementations. The distinction
between ‘core’ and ‘standard’ library is not important to the VTL users
but is largely of interest of the VTL technical implementers.

The suggestion above has been acknowledged, so VTL 2.0 manipulation
language consists of a core set of primitive operators and a standard
library of derived operators, definable in term of the primitive ones.
The standard library contains essentially the VTL 1 operators
(possibly enhanced) and the new operators introduced with VTL 2.0 (see
below).

In particular, the VTL core includes an operator called “join” which
allows extending the common scalar operations to the Data Sets. .

The user defined operators
--------------------------

VTL 1.0 does not allow defining new operators from existing ones, and
thus the possible operators are predetermined. Besides, thanks to the
core operators and the standard library, VTL 2.0 allows to define new
operators (also called “user-defined operators”) starting from existing
ones. This is achieved by means of a specific statement of the VTL-DL
(the “define operator” statement, see the Reference Manual).

This a main mechanism to enforce the requirements of having an
extensible and customizable language and to introduce custom operators
(not existing in the standard library) for specific purposes.

As obvious, because the user-defined operators are not part of the
standard library, they are not standard VTL operators and are applicable
only in the context in which they have been defined. In particular, if
there is the need of applying user-defined operators in other contexts,
their definitions need to be pre-emptively shared.

The VTL Definition Language
---------------------------

VTL 1.0 contains only a manipulation language (VTL-ML), which allows
specifying the transformations of the VTL artefacts by means of
expressions.

A VTL Definition Language (VTL-DL) has been introduced in version 2.0.

In fact, VTL 2.0 allows reusable rules and user-defined operators, which
do not exist in VTL 1.0 and need to be defined beforehand in order to be
invoked in the expressions of the VTL manipulation language. The VTL-DL
provides for their definition.

Second, VTL 1.0 was initially intended to work on top of an existing
standard, such as SDMX, DDI or other, and therefore the definition of
the artefacts to be manipulated (Data and their structures, Variables,
Value Domains and so on) was assumed to be made using the implementing
standards and not VTL itself.

During the work for the VTL 1.1 draft version, it was proposed to make
the VTL definition language able to define also those VTL-IM artefacts
that have to be manipulated. A draft version of a possible artefacts
definition language was included in VTL 1.1 public consultation, held
until the beginning of 2017. The comments received and the following
analysis evidenced that the artefact definition language cannot include
the aspects that are left out of the IM (for example the representation
of the historical changes of the real world impacting the model
artefacts) yet are:

i.   needed in the implementations;

ii.  influenced by other implementation-specific aspects;

iii. in real applications, bound to be extended by means of other
     context-related metadata and adapted to the specific environment.

In conclusion, the artefact definition language has been excluded from
this VTL version and the opportunity of introducing it will be further
explored in the near future.

In respect to VTL 1.0, VTL 2.0 definition language (VTL-DL) is
completely new (there is no definition language in VTL 1.0).

The functional paradigm
-----------------------

In the VTL Information Model, the various types of statistical data are
considered as mathematical functions, having independent variables
(Identifiers) and dependent variables (Measures, Attributes), whose
extensions can be thought of as logical tables (Data Sets) made of rows
(Data Points) and columns (Identifiers, Measures, Attributes).
Therefore, the main artefacts to be manipulated using VTL are the
logical Data Sets, i.e. first-order mathematical functions [3]_.

Accordingly, VTL uses a functional programming paradigm, meaning a
paradigm that treats computations as the evaluation of higher-order
mathematical functions [4]_, which manipulate the first-order ones
(i.e., the logical Data Sets), also termed “operators” or “functionals”.
The functional paradigm avoids changing-state and mutable data and makes
use of expressions for defining calculations.

It was observed, however, that the functional paradigm was not
sufficiently achieved in VTL 1.0 because in some particular cases a few
operators could have produced non- functional results. In effects, even
if this regarded only temporary results (not persistent), in specific
cases, this behaviour could have led to unexpected results in the
subsequent calculation chain.

Accordingly, some VTL 1.0 operators have been revised in order to
enforce their functional behaviour.

The operators
-------------

The VTL 2.0 manipulation language (VTL-ML) has been upgraded in respect
to the VTL 1.0. In fact VTL 2.0 introduces a number of new powerful
operators, like the analytical and the aggregate functions, the data
points and hierarchy checks, various clauses and so on, and improve many
existing operators, first of all the “join”, which substitutes the
“merge” of the VTL 1.0. The complete list of the VTL 2.0 operators is in
the reference manual.

Some rationalisations have brought to the elimination of some operators
whose behaviour can be easily reproduced using other operators. Some
examples are the “\ *attrcalc*\ ” operator which is now simply
substituted by the already existing “\ *calc*\ ” and the “query syntax”
that was allowed for accessing a subset of Data Points of a Data Set,
which on one side was not coherent with the rest of the VTL syntax
conventions and on the other side can be easily substituted by the
“filter” operator.

Even in respect to the draft VTL 1.1 many rationalisations have been
applied, also following the very numerous comments received during the
relevant public consultation.

Changes for version 2.2
-----------------------

Changes for version 2.1
-----------------------

The VTL 2.1 version is a minor one and contains the following changes
in respect to 2.0:

i.   typos and errors in the text and/or in the examples have been fixed;

ii.  new operators have been defined: time operators (datediff, dateadd,
     year/month/quarter/dayofmonth/dayofyear, daystoyear, daystomonth,
     durationtodays), case operator (simple extension of if-then-else),
     random operator (generating a random decimal number >= 0 and < 1)

iii. some changes have been introduced: the cast operator will have
     only explicit or implicit mask (no optional mask not allowed),
     some assumptions have been taken in the ordering for some use
     cases, the default window clause for analytic operators has been
     changed to be compliant with the SQL standard behaviour.

A new document (Technical Notes) has been added to the documentation
to support VTL implementation.

.. [3]
   A first-order function is a function that does not take other
   functions as arguments and does not provide another function as
   result.

.. [4]
   A higher-order function is a function that takes one or more other
   functions as arguments and/or provides another function as result.
