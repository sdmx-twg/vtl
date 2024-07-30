#####################
User Manual
#####################

Foreword
=========

The Task force for the Validation and Transformation Language (VTL),
created in 2012-2013 under the initiative of the SDMX Secretariat, is
pleased to present the draft version of VTL 2.0.

The SDMX Secretariat launched the VTL work at the end of 2012, moving on
from the consideration that SDMX already had a package for
transformations and expressions in its information model, while a
specific implementation language was missing. To make this framework
operational, a standard language for defining validation and
transformation rules (operators, their syntax and semantics) had to be
adopted, while appropriate SDMX formats for storing and exchanging
rules, and web services to retrieve them, had to be designed. The
present VTL 2.0 package is only concerned with the first element, i.e.,
a formal definition of each operator, together with a general
description of VTL, its core assumptions and the information model it is
based on.

The VTL task force was set up early in 2013, composed of members of
SDMX, DDI and GSIM communities and the work started in summer 2013. The
intention was to provide a language usable by statisticians to express
logical validation rules and transformations on data, described as
either dimensional tables or unit-record data. The assumption is that
this logical formalization of validation and transformation rules could
be converted into specific programming languages for execution (SAS, R,
Java, SQL, etc.), and would provide at the same time, a “neutral”
business-level expression of the processing taking place, against which
various implementations can be mapped. Experience with existing examples
suggests that this goal would be attainable.

An important point that emerged is that several standards are interested
in such a kind of language. However, each standard operates on its model
artefacts and produces artefacts within the same model (property of
closure). To cope with this, VTL has been built upon a very basic
information model (VTL IM), taking the common parts of GSIM, SDMX and
DDI, mainly using artefacts from GSIM 1.1, somewhat simplified and with
some additional detail. In this way, existing standards (GSIM, SDMX,
DDI, others) would be allowed to adopt VTL by mapping their information
model against the VTL IM. Therefore, although a work-product of SDMX,
the VTL language in itself is independent of SDMX and will be usable
with other standards as well. Thanks to the possibility of being mapped
with the basic part of the IM of other standards, the VTL IM also makes
it possible to collect and manage the basic definitions of data
represented in different standards.

For the reason described above, the VTL specifications are designed at
logical level, independently of any other standard, including SDMX. The
VTL specifications, therefore, are self-standing and can be implemented
either on their own or by other standards (including SDMX). In
particular, the work for the SDMX implementation of VTL is going in
parallel with the work for designing this VTL version, and will entail a
future update of the SDMX documentation.

The first public consultation on VTL (version 1.0) was held in 2014.
Many comments were incorporated in the VTL 1.0 version, published in
March 2015. Other suggestions for improving the language, received
afterwards, fed the discussion for building the draft version 1.1, which
contained many new features, was completed in the second half of 2016
and provided for public consultation until the beginning of 2017.

The high number and wide impact of comments and suggestions induced a
high workload on the VTL TF, which agreed to proceed in two steps for
the publication of the final documentation, taking also into
consideration that some first VTL implementation initiatives had already
been launched. The first step, the current one, is dedicated to fixing
some high-priority features and making them as much stable as possible.
A second step, scheduled for the next period, is aimed at acknowledging
and fixing other features considered of minor impact and priority, which
will be added hopefully without affecting either the features already
published in this documentation, or the possible relevant
implementations. Moreover, taking into account the number of very
important new features that have been introduced in this version in
respect to the VTL 1.0, it was agreed that the current VTL version
should be considered as a major one and thus named VTL 2.0.

The VTL 2.0 package contains the general VTL specifications,
independently of the possible implementations of other standards; in its
final release, it will include:

a) Part 1 – the user manual, highlighting the main
   characteristics of VTL, its core assumptions and the information
   model the language is based on;

b) Part 2 – the reference manual, containing the full library of
   operators ordered by category, including examples; this version will
   support more validation and compilation needs compared to VTL 1.0.

c) eBNF notation (extended Backus-Naur Form) which is the
   technical notation to be used as a test bed for all the examples.

The present document is the part 1.

The latest version of VTL is freely available online at
https://sdmx.org/?page_id=5096

**Acknowledgements**

The VTL specifications have been prepared thanks to the collective input
of experts from Bank of Italy, Bank for International Settlements (BIS),
European Central Bank (ECB), Eurostat, ILO, INEGI-Mexico, INSEE-France,
ISTAT-Italy, OECD, Statistics Netherlands, and UNESCO. Other experts
from the SDMX Technical Working Group, the SDMX Statistical Working
Group and the DDI initiative were consulted and participated in
reviewing the documentation.

The list of contributors and reviewers includes the following experts:
Sami Airo, Foteini Andrikopoulou, David Barraclough, Luigi Bellomarini,
Marc Bouffard, Maurizio Capaccioli, Franck Cotton, Vincenzo Del Vecchio,
Fabio Di Giovanni, Jens Dossé, Heinrich Ehrmann, Bryan Fitzpatrick,
Tjalling Gelsema, Luca Gramaglia, Arofan Gregory, Gyorgy Gyomai, Edgardo
Greising, Dragan Ivanovic, Angelo Linardi, Juan Munoz, Chris Nelson,
Stratos Nikoloutsos, Antonio Olleros, Stefano Pambianco, Marco
Pellegrino, Michele Romanelli, Juan Alberto Sanchez, Roberto Sannino,
Angel Simon Delgado, Daniel Suranyi, Olav ten Bosch, Laura Vignola,
Fernando Wagener and Nikolaos Zisimos.

Feedback and suggestions for improvement are encouraged and should be
sent to the SDMX Technical Working Group (twg@sdmx.org).

Example (row 919)
===========================
As a first simple example of Data Sets seen as mathematical functions, let us consider the following table:

   *Production of the American Countries*

+--------------+-------------+---------------+----------------+--------------+
| **Ref.Date** | **Country** | **Meas.Name** | **Meas.Value** | **Status**   |
|              |             |               |                |              |
+==============+=============+===============+================+==============+
| 2013         | Canada      | Population    | 50             | Final        |
+--------------+-------------+---------------+----------------+--------------+
| 2013         | Canada      | GNP           | 600            | Final        |
+--------------+-------------+---------------+----------------+--------------+
| 2013         | USA         | Population    | 250            | Temporary    |
+--------------+-------------+---------------+----------------+--------------+
| 2013         | USA         | GNP           | 2400           | Final        |
+--------------+-------------+---------------+----------------+--------------+
| …            | …           | …             | …              | …            |
+--------------+-------------+---------------+----------------+--------------+
| 2014         | Canada      | Population    | 51             | Unavailable  |
+--------------+-------------+---------------+----------------+--------------+
| 2014         | Canada      | GNP           | 620            | Temporary    |
+--------------+-------------+---------------+----------------+--------------+
| …            | …           | …             | …              | …            |
+--------------+-------------+---------------+----------------+--------------+

Generic Model for Variables and Value Domains (row 1042)
===========================================================
This Section provides a formal model for the Variables, the Value Domains, their Values and the possible (Sub)Sets of Values.
These artefacts can be referenced in the definition of the VTL Data Structures and as parameters of some VTL Operators.


Variable and Value Domain model diagram (with styled PlantUML)
----------------------------------------------------------------

.. uml::

    @startuml
            skinparam SameClassWidth true
            skinparam linetype ortho

            SetItem "0..N" -u- "1..1" Value
            SetItem "1..N" -u-* "1..1" SetList
            SetList "1..1" -u- "1..1" EnumeratedSet

            CodeItem -u-|> Value
            CodeItem "1..N" -u-* "1..1" CodeList
            CodeList "1..1" -u- "1..1" EnumeratedValueDomain

            Value "1..N" -u- "1..1" DescribedValueDomain
            Value "1..N" -u- "1..1" DescribedSet

            DescribedValueDomain -u-|> ValueDomain
            EnumeratedValueDomain -u-|>  ValueDomain

            EnumeratedSet -u-|> ValueDomainSubset
            DescribedSet -u-|> ValueDomainSubset
            ValueDomain "1..1" -r- "0..N" ValueDomainSubset
            ValueDomain "1..1" -u- "0..N" RepresentedVariable

            DataStructure "1..1" -r- "0..N" DataSet
            DataStructure *-- "1..N" DataStructureComponent
            DataSet *-d- "1..N" DataSetComponent
            DataSetComponent "0..N" -l- "1..1" DataStructureComponent
            ValueDomainSubset "1..1" -u- "0..N" DataSetComponent
            RepresentedVariable "1..1" -r- "0..N" DataStructureComponent
    @enduml


Explanation of the Diagram
--------------------------------------------------------
Even in the case of Variables and Value Domains, the GSIM artefacts are used as much as possible. The differences are mainly due
to the fact that GSIM does not distinguish explicitly between Value Domains and their (Sub)Sets, while in the VTL IM this is made more explicit in
order to allow different Data Set Components relevant to the same aspect of the reality (e.g. the geographic area) to share the same Value Domain and,
at the same time, to take values in different Subsets of it. This is essential for VTL for several operations and in particular for validation purposes.

For example, it may happen that the same Represented Variable, say the “place of birth”, in a Data Set takes values in the Set of the European Counties,
in another one takes values in the set of the African countries, and so on, even at different levels of details (e.g. the regions, the cities).
The definition of the exact Set of Values that a Data Set Component can take may be very important for VTL, in particular for validation purposes.
The specification of the Set of Values that the Data Set Components may assume is equivalent, on the mathematical plane,
to the specification of the domain and the co-domain of the mathematical function corresponding to the Data Set.

**Data Set:** see the explanation given in the previous section (Generic Model for Data and their structures).

**Data Set Component:** a component of the Data Set, which matches with just one Data Structure Component of the Data Structure
of such a Data Set and takes values in a (sub)set of the corresponding Value Domain13; this (sub)set of allowed values may either coincide with
the set of all the values belonging to the Value Domain or be a proper subset of it. In respect to a Data Structure Component,
a Data Set Component bears the important additional information of the set of allowed values of the Component, which can be different Data Set by
Data Set even if their data structure is the same.

**Data Structure**: a Data Structure; see the explanation already given
in the previous section (Generic Model for Data and their structures)

**Data Structure Component**: a component of a Data Structure; see the
explanation already given in the previous section (Generic Model for
Data and their structures). A Data Structure Component is defined by a
Represented Variable.

**Represented Variable**: a characteristic of a statistical population
(e.g. the country of birth) represented in a specific way (e.g. through
the ISO code). This artefact is the same as in GSIM. A represented
variable may take value in (or may be measured by) just one Value
Domain.

**Value Domain**: the domain of allowed values for one or more
represented variables. This artefact is very similar to the
corresponding artefact in GSIM. Because of the distinction between Value
Domain and its Value Domain Subsets, a Value Domain is the wider set of
values that can be of interest for representing a certain aspect of the
reality like the time, the geographical area, the economic sector and so
on. As for the mathematical meaning, a Value Domain is meant to be the
representation of a “space of events” with the meaning of the
probability theory [14]_. Therefore, a single Value of a Value Domain is
a representation of a single “event” belonging to this space of events.

**Described Value Domain**: a Value Domain defined by a criterion
(e.g. the domain of the positive integers). This artefact is the same
as in GSIM.

    **Enumerated Value Domain**: a Value Domain defined by enumeration of
    the allowed values (e.g. domain of ISO codes of the countries). This
    artefact is the same as in GSIM.

    **Code List**: the list of all the Code Items belonging to an
    enumerated Value Domain, each one representing a single “event” with
    the meaning of the probability theory. As for its mathematical
    meaning, this list is unique for a Value Domain, cannot contain
    repetitions (each Code Item can be present just once) and cannot
    contain ambiguities (each Code Item must have a univocal meaning,
    i.e., must represent a single event of the space of the events). This
    artefact is the same as in GSIM except for the multiplicity of the
    relationship with the Enumerated Value Domain which is 1:1. In fact,
    as it happens for the Data Set, the VTL considers the Code List as an
    artefact at a logical level, corresponding to its mathematical
    meaning. A logical VTL Code List, however, may be obtained as the
    composition of more physical lists of codes if needed: the mapping
    between the logical and the physical lists is out of scope of this
    document and is left to the implementations, provided that the basic
    conceptual properties of the VTL Code List are ensured (unicity, no
    repetitions, no ambiguities). In practice, as for the VTL IM, the
    Code List artefact matches 1:1 with the Enumerated Value Domain
    artefact, therefore they can be considered as the same artefact.

    **Code Item**: an allowed Value of an enumerated Value Domain. A Code
    Item is the association of a Value with the relevant meaning (called
    “category” in GSIM). An example of Code Item is a single country ISO
    code (the Value) associated to the country it represents (the category).
    As for the mathematical meaning, a Code Item is the representation of an
    “event” of a space of events (i.e. the relevant Value Domain), according
    to the notions of “event” and “space of events” of the probability
    theory (see the note above).

**Value**: an allowed value of a Value Domain. Please note that on a
logical / mathematical level, both the Described and the Enumerated
Value Domains contain Values, the only difference is that the Values of
the Enumerated Value Domains are explicitly represented by enumeration,
while the Values of the Described Value Domains are implicitly
represented through a criterion.

The following artefacts are aimed at representing possible subsets of
the Value Domains. This is needed for validation purposes, because very
often not all the values of the Value Domain are allowed in a Data
Structure Component, but only a subset of them (e.g. not all the
countries but only the European countries). This is needed also for
transformation purposes, for example to filter the Data Points according
to a subset of Values of a certain Data Structure Component (e.g.
extract only the European Countries from some data relevant to the World
Countries). Although this detail does not exist in GSIM, these artefacts
are compliant with the GSIM artefacts described above, aimed at
representing the Value Domains:

**Value Domain Subset** (or simply **Set**): a subset of Values of a
Value Domain. This artefact does not exist in GSIM; however, it is
compliant with the GSIM Value Domain. Hereinafter a Value Domain Subset
is simply called **Set**, because it can be any set of Values belonging
to the Value Domain (even the set of all the values of the Value
Domain).

    **Described Value Domain Subset** (or simply **Described Set**): a
    described (defined by a criterion) subset of Values of a Value Domain
    (e.g. the countries having more than 100 million inhabitants, the
    integers between 1 and 100). This artefact does not exist in GSIM;
    however, it is compliant with the GSIM Described Value Domain.

    **Enumerated Value Domain** **Subset** (or simply **Enumerated
    Set**): an enumerated subset of a Value Domain (e.g. the enumeration
    of the European countries). This artefact does not exist in GSIM;
    however, it is compliant with the GSIM Enumerated Value Domain.

    **Set List**: the list of all the Values belonging to an Enumerated
    Set (e.g. the list of the ISO codes of the European countries),
    without repetitions (each Value is present just once). As obvious,
    these Values must belong to the Value Domain of which the Set is a
    subset. This artefact does not exist in GSIM; however, it is
    compliant with the Code List in GSIM, which has a similar role. The
    Set List enumerates the Values contained in the Set (e.g. the
    European country codes), without the associated categories (e.g. the
    names of the countries), because the latter are already maintained in
    the Code List / Code Items of the relevant Value Domain (which
    enumerates all the possible Values with the associated categories).
    In practice, as for the VTL IM, the Set List artefact coincides 1:1
    with the Enumerated Set artefact, therefore they can be considered as
    the same artefact.

**Set Item**: an allowed Value of an enumerated Set. The Value must
belong to the same Value Domain the Set belongs to. Each Set Item refers
to just one Value and just one Set. A Value can belong to any number of
Sets. A Set can contain any number of Values.
