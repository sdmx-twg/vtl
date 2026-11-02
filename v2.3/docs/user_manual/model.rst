VTL Information Model
=====================

.. _introduction-1:

Introduction
------------

The VTL Information Model (IM) is a generic model able to describe the
artefacts that VTL can manipulate, i.e. to give the definition of the
artefact structure and relationships with other artefacts.

The knowledge of the artefacts definition is essential for parsing VTL
expressions and performing VTL operations correctly. Therefore, it is
assumed that the referenced artefacts are defined before or at the same
time the VTL expressions are defined.

The results of VTL expressions must be defined as well, because it must
always be possible to take these results as operands of further
expressions to build a chain of transformations as complex as needed. In
other words, VTL is meant to be “closed”, meaning that operands and
results of the VTL expressions are always artefacts of the VTL IM. As
already mentioned, the VTL is designed to make it possible to deduce the
data structure of the result from the calculation algorithm and the data
structure of the operands.

VTL can manage persistent or temporary artefacts, the former stored
persistently in the information system, the latter only used
temporarily. The definition of the persistent artefact must be
persistent as well, while the definition of temporary artefacts can be
temporary [5]_.

The VTL IM provides a formal description at business level of the
artefacts that VTL can manipulate, which is the same purpose as the
Generic Statistical Information Model (GSIM) with a broader scope. In
fact, the VTL Information Model uses GSIM artefacts as much as possible
(GSIM 2.0 version) [6]_. Note that the description of the GSIM 2.0
classes and relevant definitions can be consulted in the “Clickable
GSIM” of the UNECE site [7]_. However, the detailed mapping between
the VTL IM and the IMs of the other standards is out of the scope of
this document and is left to the competent bodies of the other
standards [8]_.

The VTL IM provides for a model at a logical/conceptual level, which
is independent of the implementation and allows different possible
implementations.

The VTL IM provides for an abstract view of the core artefacts used in
the VTL calculations and intentionally leaves out implementation
aspects. Some other aspects, even if logically related to the
representation of data and calculations, are also left out because they
can depend on the actual implementation too (for example, the textual
descriptions of the VTL artefacts, the representation of the historical
changes of the real world).

The operational metadata needed for supporting real processing systems
are also left out from the VTL scope (for example the specification of
the way data are managed, i.e. collected, stored, validated,
calculated/estimated, disseminated ...).

Therefore, the VTL IM cannot autonomously support real processing
systems, and for this purpose needs to be properly integrated and
adapted, also adding more metadata (e.g., other classes of artefacts,
properties of the artefacts, relationships among artefacts …).

Even the possible VTL implementations in other standards (like SDMX and
DDI) would require proper adjustments and improvements of the IM
described here.

The VTL IM is inspired to the modelling approach that consists in using
more modelling levels, in which a model of a certain level models the
level below and is an instance of a model of the level above.

For example, assuming conventionally that the level 0 is the level of
the real world to be modelled and ignoring possible levels higher than
the one of the VTL IM, the VTL modelling levels could be described as
follows:

   Level 0 – the real world

   Level 1 – the extensions of the data that model some aspect of the
   real world. For example, the content of the data set *“population
   from United Nations”*:

.. list-table::
   :widths: 25 25 50
   :header-rows: 1

   * - *Year*
     - *Country*
     - *Population*
   * - *2016*
     - *China*
     - *1,403,500,365*
   * - *2016*
     - *India*
     - *1,324,171,354*
   * - *2016*
     - *USA*
     - *322,179,605*
   * - *...*
     -
     -
   * - *2017*
     - *China*
     - *1,409,517,397*
   * - *2017*
     - *India*
     - *1,339,180.127*
   * - *2017*
     - *USA*
     - *324,459,463*
   * - *...*
     -
     -

..

   Level 2 – the definitions of specific data structures (and relevant
   transformations) which are the model of the level 1. An example: *the
   data structure of the data set “population from United Nations” has
   one measure component called “population” and two identifier
   components called Year and Country*.

   Level 3 – the VTL Information Model, i.e. the generic model to which
   the specific data structures (and relevant transformations) must
   conform. An example of IM rule about the data structure: *a Data Set
   may be structured by just one Data Structure, a Data Structure may
   structure any number of Data Sets*.

A similar approach is very largely used, in particular in the
information technology and for example by the Object Management
Group [9]_, even if the terminology and the enumeration of the levels
is different. The main correspondences are:

   VTL Level 1 (extensions) – OMG M0 (instances)

   VTL Level 2 (definitions) – OMG M1 (models)

   VTL Level 3 (information model) – OMG M2 (metamodels)

Often the level 1 is seen as the level of the data, the level 2 of the
metadata and the level 3 of the meta-metadata, even if the term metadata
is too generic and somewhat ambiguous. In fact, “metadata” is any data
describing another data, while “definition” is a particular metadata
which is the model of another data. For example, referring to the
example above, a possible other data set which describes how the
population figures are obtained is certainly a metadata, because it
gives information about another data (the population data set), but it
is not at all its definition, because it does not describe the
information structure of the population data set.

The VTL IM is illustrated in the following sections.

The first section describes the generic model for defining the
statistical data and their structures, which are the fundamental
artefacts to be transformed. In fact, the ultimate goal of the VTL is to
act on statistical data to produce other statistical data.

In turn, data items are characterized in terms of variables, value
domains, code items and similar artefacts. These are the basic bricks
that compose the data structures, fundamental to understand the meaning
of the data, ensuring harmonization of different data when needed,
validating and processing them. The second section presents the generic
model for these kinds of artefacts.

Finally, the VTL transformations, written in the form of mathematical
expressions, apply the operators of the language to proper operands in
order to obtain the needed results. The third section depicts the
generic model of the transformations.

Generic Model for Data and their structures
-------------------------------------------

This Section provides a formal model for the structure of data as
operated on by the Validation and Transformation Language (VTL).

For each Unit (e.g. a person) or Group of Units of a Population (e.g.
groups of persons of a certain age and civil status), identified by
means of the values of the independent variables (e.g. either the
“person id” or the age and the civil status), a mathematical function
provides for the values of the dependent variables, which are the
properties to be known (e.g. the revenue, the expenses …).

A mathematical function can be seen as a **logical table made of rows
and columns**. Each column holds the values of a variable (either
independent or dependent); each row holds the association between the
values of the independent variables and the values of the dependent
variables (in other words, each row is a single “point” of the
function).

In this way, the manipulation of any kind of data (unit and dimensional)
is brought back to the manipulation of very simple and well-known
objects, which can be easily understood and managed by users. According
to these assumptions, there would no longer be the need of
distinguishing between unit and dimensional data, and in fact VTL does
not introduces such a distinction at all. Nevertheless, even if such a
distinction is not part of the VTL IM, this aspect is illustrated below
in this document in order to make it easier to map the VTL IM to the
GSIM IM and the DDI IM, which have such a distinction.

Starting from this assumption, each mathematical function (logical
table) may be defined having Identifier, Measure and Attribute
Components. The Identifier components are the independent variables
of the function, the Measures and Attribute Components are the dependent
variables. Obviously, the GSIM artefacts “Data Set” and “Data Set
Structure” have to be strictly interpreted as **logical artefacts**
on a mathematical level, not necessarily corresponding to physical
data sets and physical data structures.

In order to avoid any possible misunderstanding with respect to SDMX,
also take note that the VTL Data Set in general does not correspond to
the SDMX Dataset. In fact, a SDMX dataset is a physical set of data (the
data exchanged in a single interaction), while the VTL Data Set is a
logical set of data, in principle independent of its possible physical
representation and handling (like the exchange of part of it). The right
mapping is between the VTL Data Set and the SDMX Dataflow.

Data model diagram 
~~~~~~~~~~~~~~~~~~~

.. uml::

    @startuml
        skinparam linetype ortho
        skinparam ClassBackgroundColor White

        class "Data Structure" as DataStructure #F8F8F8
        class "Data Set" as DataSet #F8F8F8
        class "Data Point" as DataPoint
        abstract class "Data Structure Component" as DataStructureComponent

        DataSet "0..N" --> "1..1" DataStructure: "structured by"
        DataSet "1..1" -up-> "0..N" DataPoint: "has"
        DataStructure *-right- "0..N" DataStructureComponent
        Identifier -up-|> DataStructureComponent
        Measure -up-|> DataStructureComponent
        Attribute -up-|> DataStructureComponent
    @enduml

White box: same artefact as in GSIM 2.0

Light grey box: similar to GSIM 2.0

Explanation of the Diagram 
~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Data Set**: a mathematical function (logical table) that describes
some properties of some groups of units of a population. In general, the
groups of units may be composed of one or more units. For unit data,
each group is composed of a single unit. For dimensional data, each
group may be composed of any number of units. A VTL Data Set is
considered as a logical set of observations (Data Points) having the
same logical structure and the same general meaning, independently of
the possible physical representation or storage. Between the VTL Data
Sets and the physical datasets there can be relationships of any
cardinality: for example, a VTL Data Set may be stored either in one or
in many physical data sets, as well as many VTL Data Sets may be stored
in the same physical datasets (or database tables). The mapping between
the VTL logical artefacts and the physical artefacts is left to the VTL
implementations and is out of scope of this document.

**Data Point**: a single value of the function, i.e. a single
association between the values of the independent variables and the
values of the dependent variables. A Data Point corresponds to a row of
the logical table that describes the function; therefore, the extension
of the function (Data Set) is a set of Data Points. Some Data Points of
the function can be unknown (i.e. missing or null), for example, the
possible ones relevant to future dates. The single Data Points do not
need to be individually defined, because their definition is the
definition of the function (i.e. the Data Set definition).

**Data Structure:** the structure of a mathematical function, having
independent and dependent variables. The independent variables are
called “Identifier components”, the dependent variables are called
either “Measure Components” or “Attribute Components”. The distinction
between Measure and Attribute components is conventional and essentially
based on their meaning: the Measure Components give information about
the real world, while the Attribute components give information about
the function itself.

**Data Structure Component**: any component of the data structure, which
can be either an Identifier, or a Measure, or an Attribute Component.

   **Identifier Component** (or simply Identifier): a component of the
   data structure that is an independent variable of the function.

   **Measure Component** (or simply Measure): a component of the data
   structure that is a dependent variable of the function and gives
   information about the real world.

   **Attribute Component** (or simply Attribute): a component of the
   data structure that is a dependent variable of the function and gives
   information about the function itself. In case the automatic
   propagation of the Attributes is Attributes can be further classified
   in normal Attributes (not automatically propagated) and Viral
   Attributes (automatically propagated).

There can be from 0 to N Identifiers in a Data Structure. A Data Set
having no identifiers can contain just one Data Point, whose independent
variables are not explicitly represented.

There can be from 0 to N Measures in a Data Structure. A Data Set
without Measures is allowed because the Identifiers can be considered as
functional dependent from themselves (so having also the role of
Measure). In an equivalent way, the combinations of values of the
Identifiers can be considered as “true” (i.e. existing), therefore it
can be thought that there is an implicit Boolean measure having value
“**true**” for all the Data Points [10]_.

The extreme case of a Data Set having no Identifiers, Measures and
Attributes is allowed. A Data Set of this kind contains just one scalar
Value whose meaning is specified only through the Data Set name. As for
the VTL operations, these Data Sets are managed like the scalar Values.

Note that the VTL may manage Measure and Attribute Components in
different ways, as explained in the section “The general behaviour of
operations on datasets” below, therefore the distinction between
Measures and Attributes may be significant for the VTL.

**Represented Variable**: a characteristic of a statistical population
(e.g. the country of birth) represented in a specific way (e.g. through
the ISO numeric country code). A represented variable may contribute
to define any number of Data Structure Components.

Functional Integrity
~~~~~~~~~~~~~~~~~~~~

The VTL data model requires a functional dependency between the
Identifier Components and all the other Components of a Data Set. It
follows that a Data Set can also be seen as a tabular structure with a
finite number of columns (which correspond to its Components) and rows
(which correspond to its individual Data Points), in fact for each
combination of values of the Identifier Components’ columns (which
identify an individual Data Point), there is just one value for each
Measure and Attribute (contained in the corresponding columns).

The functional dependency translates into the following *functional
integrity* requirements:

-  Each Component has a distinct name in the Data Structure of the Data
   Set and contains one scalar value for each Data Point.

-  All the Identifier Components of the Data Set must contain a
   significant value for all the Data Points (i.e. such value cannot be
   unknown (“**null**”)).

-  In a Data Set there cannot exist two or more Data Points having the
   same values for all the Identifier Components (i.e. the same Data
   Point key).

-  When a Measure or Attribute Component has no significant value (i.e.
   “**null**”) for a Data Point, it is considered unknown for that Data
   Point.

-  When a Data Point is missing (i.e. a possible combination of values
   of the independent variables is missing), all its Measure and
   Attribute Components are by default considered unknown (unless
   otherwise specified).

The VTL expects the input Data Sets to be functionally integral and is
designed to ensure that the resulting Data Set are functionally integral
too.

Examples 
~~~~~~~~~

As a first simple example of Data Sets seen as mathematical functions,
let us consider the following table:

   *Production of the American Countries*

+--------------+-------------+---------------+----------------+-------------+
| **Ref.Date** | **Country** | **Meas.Name** | **Meas.Value** | **Status**  |
+==============+=============+===============+================+=============+
| 2013         | Canada      | Population    | 50             | Final       |
+--------------+-------------+---------------+----------------+-------------+
| 2013         | Canada      | GNP           | 600            | Final       |
+--------------+-------------+---------------+----------------+-------------+
| 2013         | USA         | Population    | 250            | Temporary   |
+--------------+-------------+---------------+----------------+-------------+
| 2013         | USA         | GNP           | 2400           | Final       |
+--------------+-------------+---------------+----------------+-------------+
| …            | …           | …             | …              | …           |
+--------------+-------------+---------------+----------------+-------------+
| 2014         | Canada      | Population    | 51             | Unavailable |
+--------------+-------------+---------------+----------------+-------------+
| 2014         | Canada      | GNP           | 620            | Temporary   |
+--------------+-------------+---------------+----------------+-------------+
| …            | …           | …             | …              | …           |
+--------------+-------------+---------------+----------------+-------------+

This table is equivalent to a proper mathematical function: in fact, it
fulfils the functional integrity requirements above. The Table can be
defined as a Data Set, whose name can be “Production of the American
Countries”. Each row of the table is a Data Point belonging to the Data
Set. The Data Structure of this Data Set has five Data Structure
Components:

-  Reference Date (Identifier Component)

-  Country (Identifier Component)

-  Measure Name (Identifier Component - Measure Identifier)

-  Measure Value (Measure Component)

-  Status (Attribute Component)

As a second example, let us consider the following physical table, in
which the symbol “###” denotes cells that are not allowed to contain a
value or contain the “**null**” value.

   *Institutional Unit Data*

+--------+--------+--------+--------+----------+------------+-----------------+
| **Row  | **I.U. | **Ref. | **I.U. | **I.U.   | **Assets** | **Liabilities** |
| Type** | ID**   | Date** | Name** | Sector** |            |                 |
+========+========+========+========+==========+============+=================+
| I      | A      | ###    | AAAAA  | Private  | ###        | ###             |
+--------+--------+--------+--------+----------+------------+-----------------+
| II     | A      | 2013   | ###    | ###      | 1000       | 800             |
+--------+--------+--------+--------+----------+------------+-----------------+
| II     | A      | 2014   | ###    | ###      | 1050       | 750             |
+--------+--------+--------+--------+----------+------------+-----------------+
| I      | B      | ###    | BBBBB  | Public   | ###        | ###             |
+--------+--------+--------+--------+----------+------------+-----------------+
| II     | B      | 2013   | ###    | ###      | 1200       | 900             |
+--------+--------+--------+--------+----------+------------+-----------------+
| II     | B      | 2014   | ###    | ###      | 1300       | 950             |
+--------+--------+--------+--------+----------+------------+-----------------+
| I      | C      | ###    | CCCCC  | Private  | ###        | ###             |
+--------+--------+--------+--------+----------+------------+-----------------+
| II     | C      | 2013   | ###    | ###      | 750        | 900             |
+--------+--------+--------+--------+----------+------------+-----------------+
| II     | C      | 2014   | ###    | ###      | 800        | 850             |
+--------+--------+--------+--------+----------+------------+-----------------+
| …      | …      | …      | …      | …        | …          | …               |
+--------+--------+--------+--------+----------+------------+-----------------+

This table does not fulfil the functional integrity requirements above
because its rows (i.e. the Data Points) either have different structures
(in term of allowed columns) or have null values in the Identifiers.
However, it is easy to recognize that there exist two possible
functional structures (corresponding to the Row Types I and II), so that
the original table can be split in the following ones:

   *Row Type I - Institutional Unit register*

+---------------------+-----------------------+-----------------------+
| **I.U. ID**         | **I.U. Name**         | **I.U. Sector**       |
+=====================+=======================+=======================+
| A                   | AAAAA                 | Private               |
+---------------------+-----------------------+-----------------------+
| B                   | BBBBB                 | Public                |
+---------------------+-----------------------+-----------------------+
| C                   | CCCCC                 | Private               |
+---------------------+-----------------------+-----------------------+
| …                   | …                     | …                     |
+---------------------+-----------------------+-----------------------+

..

   *Row Type II - Institutional Unit Assets and Liabilities*

+---------------+-----------------+-----------------+-----------------+
| **I.U. ID**   | **Ref.Date**    | **Assets**      | **Liabilities** |
+===============+=================+=================+=================+
| A             | 2013            | 1000            | 800             |
+---------------+-----------------+-----------------+-----------------+
| A             | 2014            | 1050            | 750             |
+---------------+-----------------+-----------------+-----------------+
| B             | 2013            | 1200            | 900             |
+---------------+-----------------+-----------------+-----------------+
| B             | 2014            | 1300            | 950             |
+---------------+-----------------+-----------------+-----------------+
| C             | 2013            | 750             | 900             |
+---------------+-----------------+-----------------+-----------------+
| C             | 2014            | 800             | 850             |
+---------------+-----------------+-----------------+-----------------+
| …             | …               | …               | …               |
+---------------+-----------------+-----------------+-----------------+

Each one of these two tables corresponds to a mathematical function and
can be represented like in the first example above. Therefore, these
would be two distinct logical Data Sets according to the VTL IM, even if
stored in the same physical table.

In correspondence to one physical table (the former), there are two
logical tables (the latter), so that the definitions will be the
following ones:

**VTL Data Set 1**: *Record type I - Institutional Units register*

Data Structure 1:

-  I.U. ID (Identifier Component)

-  I.U. Name (Measure Component)

-  I.U. Sector (Measure Component)

**VTL Data Set 2**: *Record type II - Institutional Units Assets and
Liabilities*

Data Structure 2:

-  I.U. ID (Identifier Component)

-  Reference Date (Identifier Component)

-  Assets (Measure Component)

-  Liabilities (Measure Component)

These examples clarify the meaning of “logical” table or Data Set in
VTL, that is a set of data which can be considered as the extensional
form of a mathematical function, whichever technical format is used,
regardless it is stored or not and, in case, wherever it is stored.

In the example above, one physical data set corresponds to more than one
logical VTL Data Sets, with a 1 to many correspondence. In the general
case, between physical and logical data sets there can be any
correspondence (1 to 1, 1 to many, many to 1, many to many).

The data artefacts 
~~~~~~~~~~~~~~~~~~~

The list of the VTL artefacts related to the manipulation of the data is
given here, together with the information that the VTL may need to know
about them [11]_.

For the sake of simplicity, the names of the artefacts can be
abbreviated in the VTL manuals (in particular the parts of the names
shown between parentheses can be omitted).

As already mentioned, this list provides an abstract view of the core
metadata needed for the manipulation of the data structures but leaves
out implementation and operational aspects. For example, textual
descriptions of the artefacts are left out, as well as any specification
of temporal validity of the artefacts, procedural metadata
(specification of the way data are processed, i.e., collected, stored,
validated, calculated/estimated, disseminated ...) and so on. In order
to support real systems, the implementers can conveniently adjust this
model to their environments and integrate it by adding additional
metadata (e.g. other properties of the artefacts, other classes of
artefacts, other relationships among artefacts …).

**Data Set**

.. list-table::

    * - *Data Set name*
      - *name of the Data Set*
    * - *Data Structure name*
      - *reference to the data structure of the Data Set*


**Data Structure**

.. list-table::

    * - *Data Structure name*
      - *name of the Data Structure (the Structure Components are specified in the following artefact)*


**(Data) Structure Component**

.. list-table::

    * - *Data Structure name*
      - *the data structure, which the Data Structure Component belongs to*
    * - *Component name*
      - *the name of the Component*
    * - *Component Role*
      - *IDENTIFIER or MEASURE or ATTRIBUTE (or also VIRAL ATTRIBUTE if the automatic propagation is supported)*
    * - *Represented Variable*
      - *the Represented Variable associated with the Component (see also below)*


The Data Points have the same information structure of the Data Sets
they belong to; in fact they form the extensions of the relevant Data
Sets; VTL does not require defining them explicitly.

Generic Model for Variables and Value Domains
---------------------------------------------

This Section provides a formal model for the Variables, the Value
Domains, their Values and the possible (Sub)Sets of Values. These
artefacts can be referenced in the definition of the VTL Data Structures
and as parameters of some VTL Operators.

Variable and Value Domain model diagram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. uml::

    @startuml

            skinparam ClassBackgroundColor White
            skinparam linetype ortho
            skinparam nodesep 100

            class "Data Set" as DataSet #F8F8F8
            class "Data Set\nComponent" as DataSetComponent #D3D3D3
            class "Data Structure\nComponent" as DataStructureComponent
            class "Represented\nVariable" as RepresentedVariable
            class "Value Domain\nSubset (Set)" as ValueDomainSubset #D3D3D3
            class "Value Domain" as ValueDomain
            class "Enumerated\nValue Domain" as EnumeratedValueDomain
            class "Described\nValue Domain" as DescribedValueDomain
            class "Enumerated\nSet" as EnumeratedSet
            class "Described\nSet" as DescribedSet
            class "Code List" as CodeList
            class "Code Item" as CodeItem
            class "Set List" as SetList
            class "Set Item" as SetItem

            DataSet "has" *-down- "1..N" DataSetComponent
            DataSetComponent "0..N" -left-> "1..1" DataStructureComponent: "match to"
            RepresentedVariable "0..1" <-right-  "0..N" DataStructureComponent: "defined by"
            DataSetComponent "0..N" -down-> "1..1" ValueDomainSubset: "takes value in"
            ValueDomain "1..1" -right-> "0..N" ValueDomainSubset: "includes"
            ValueDomain "1..1" -up-> "0..N" RepresentedVariable: "measures"

            DescribedValueDomain -up-|> ValueDomain
            EnumeratedValueDomain -up-|> ValueDomain
            EnumeratedSet -up-|> ValueDomainSubset
            DescribedSet -up-|> ValueDomainSubset

            EnumeratedValueDomain "1..1" -down-> "1..1" CodeList: "has"
            DescribedValueDomain "1..1" -down-> "1..N" Value: "has"
            DescribedSet "1..1" -down-> "1..N" Value: "has"
            EnumeratedSet "1..1" -down-> "1..1" SetList: "has"

            SetItem "0..N" -up- "1..1" Value
            SetList "1..1" *-down- "1..N" SetItem: "contains"
            CodeItem -up-|> Value
            CodeList "1..1" *-down- "1..N" CodeItem: "contains"

    @enduml
	
White box: same as in GSIM 1.1

Light grey: similar to GSIM 1.1

Dark grey additional detail (in respect to GSIM 1.1)

.. _explanation-of-the-diagram-1:

Explanation of the Diagram 
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The VTL IM distinguishes explicitly between Value Domains and their
(Sub)Sets in order to allow different Data Set Components relevant to
the same aspect of the reality (e.g. the geographic area) to share
the same Value Domain and, at the same time, to take values in different
Subsets of it. This is essential for VTL for several operations and in
particular for validation purposes. For example, it may happen that the
same Represented Variable, say the “place of birth”, in a Data Set takes
values in the Set of the European Countries, in another one takes values
in the set of the African countries, and so on, even at different levels
of details (e.g. the regions, the cities). The definition of the exact
Set of Values that a Data Set Component can take may be very important
for VTL, in particular for validation purposes. The specification of the
Set of Values that the Data Set Components may assume is equivalent, on
the mathematical plane, to the specification of the domain and the
co-domain of the mathematical function corresponding to the Data Set.

**Data Set**: see the explanation given in the previous section (Generic
Model for Data and their structures).

**Data Set Component**: a component of the Data Set, which matches with
just one Data Structure Component of the Data Structure of such a Data
Set and takes values in a (sub)set of the corresponding Value
Domain [12]_; this (sub)set of allowed values may either coincide with
the set of all the values belonging to the Value Domain or be a proper
subset of it. In respect to a Data Structure Component, a Data Set
Component bears the important additional information of the set of
allowed values of the Component, which can be different Data Set by Data
Set even if their data structure is the same.

**Data Structure**: a Data Structure; see the explanation already given
in the previous section (Generic Model for Data and their structures)

**Data Structure Component**: a component of a Data Structure; see the
explanation already given in the previous section (Generic Model for
Data and their structures). A Data Structure Component can be associated 
to a Represented Variable.

**Represented Variable**: a characteristic of a statistical population
(e.g. the country of birth) represented in a specific way (e.g. through
the ISO code). A represented variable may take value in (or may be
measured by) just one Value Domain.

**Value Domain**: the domain of allowed values for one or more
represented variables. Because of the distinction between Value
Domain and its Value Domain Subsets, a Value Domain is the wider set of
values that can be of interest for representing a certain aspect of the
reality like the time, the geographical area, the economic sector and so
on. As for the mathematical meaning, a Value Domain is meant to be the
representation of a “space of events” with the meaning of the
probability theory [13]_. Therefore, a single Value of a Value Domain is
a representation of a single “event” belonging to this space of events.

   **Described Value Domain**: a Value Domain defined by a criterion
   (e.g. the domain of the positive integers).

   **Enumerated Value Domain**: a Value Domain defined by enumeration of
   the allowed values (e.g. domain of ISO codes of the countries).

   **Code List**: the list of all the Code Items belonging to an
   enumerated Value Domain, each one representing a single “event” with
   the meaning of the probability theory. As for its mathematical
   meaning, this list is unique for a Value Domain, cannot contain
   repetitions (each Code Item can be present just once) and cannot
   contain ambiguities (each Code Item must have a univocal meaning,
   i.e., must represent a single event of the space of the events).
   The multiplicity of the relationship with the Enumerated Value Domain
   which is 1:1 because, as it happens for the Data Set, the VTL
   considers the Code List as an artefact at a logical level, corresponding
   to its mathematical meaning. A logical VTL Code List, however, may be
   obtained as the composition of more physical lists of codes if needed:
   the mapping between the logical and the physical lists is out of scope
   of this document and is left to the implementations, provided that the
   basic conceptual properties of the VTL Code List are ensured (unicity,
   no repetitions, no ambiguities). In practice, as for the VTL IM, the
   Code List artefact matches 1:1 with the Enumerated Value Domain
   artefact, therefore they can be considered as the same artefact.

**Code Item**: an allowed Value of an enumerated Value Domain. A Code
Item is the association of a Value with the relevant meaning. An example
of Code Item is a single country ISO code (the Value) associated to the
country it represents (the category). As for the mathematical meaning,
a Code Item is the representation of an “event” of a space of events
(i.e. the relevant Value Domain), according to the notions of “event”
and “space of events” of the probability theory (see the note above).

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
Countries).

**Value Domain** **Subset** (or simply **Set**): a subset of Values of a
Value Domain. Hereinafter a Value Domain Subset is simply called **Set**,
because it can be any set of Values belonging to the Value Domain
(even the set of all the values of the Value Domain).

   **Described Value Domain Subset** (or simply **Described Set**): a
   described (defined by a criterion) subset of Values of a Value Domain
   (e.g. the countries having more than 100 million inhabitants, the
   integers between 1 and 100).

   **Enumerated Value Domain** **Subset** (or simply **Enumerated
   Set**): an enumerated subset of a Value Domain (e.g. the enumeration
   of the European countries).

   **Set List**: the list of all the Values belonging to an Enumerated
   Set (e.g. the list of the ISO codes of the European countries),
   without repetitions (each Value is present just once). As obvious,
   these Values must belong to the Value Domain of which the Set is a
   subset. The Set List enumerates the Values contained in the Set (e.g.
   the European country codes), without the associated categories (e.g.
   the names of the countries), because the latter are already maintained
   in the Code List / Code Items of the relevant Value Domain (which
   enumerates all the possible Values with the associated categories).
   In practice, as for the VTL IM, the Set List artefact coincides 1:1
   with the Enumerated Set artefact, therefore they can be considered as
   the same artefact.

**Set Item**: an allowed Value of an enumerated Set. The Value must
belong to the same Value Domain the Set belongs to. Each Set Item refers
to just one Value and just one Set. A Value can belong to any number of
Sets. A Set can contain any number of Values.

Relations and operations between Code Items
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The VTL allows the representation of logical relations between Code
Items, considered as events of the probability theory and belonging to
the same enumerated Value Domain (space of events). The VTL artefact
that allows expressing the Code Item Relations is the Hierarchical
Ruleset, which is described in the reference manual.

As already explained, each Code Item is the representation of an event,
according to the notions of “event” and “space of events” of the
probability theory. The relations between Code Items aim at expressing
the logical implications between the events of a space of events (i.e.
in a Value Domain). The occurrence of an event, in fact, may imply the
occurrence or the non-occurrence of other events. For example:

-  The event UnitedKingdom implies the event Europe (e.g. if a person
   lives in UK he/she also lives in Europe), meaning that the occurrence
   of the former implies the occurrence of the latter. In other words,
   the geo-area of UK is included in the geo-area of the Europe.

-  The events Belgium, Luxembourg, Netherlands are mutually exclusive
   (e.g. if a person lives in one of these countries he/she does not
   live in the other ones), meaning that the occurrence of one of them
   implies the non-occurrence of the other ones (Belgium AND Luxembourg
   = impossible event; Belgium AND Netherlands = impossible event;
   Luxembourg and Netherlands = impossible event). In other words, these
   three geo-areas do not overlap.

-  The occurrence of one of the events Belgium, Netherlands or
   Luxembourg (i.e. Belgium OR Netherlands OR Luxembourg) implies the
   occurrence of the event Benelux (e.g. if a person lives in one of
   these countries he/she also lives in Benelux) and vice-versa (e.g. if
   a person lives in Benelux, he/she lives in one of these countries).
   In other words, the union of these three geo-areas coincides with the
   geo-area of the Benelux.

The logical relationships between Code Items are very useful for
validation and transformation purposes. Considering for example some
positive and additive data, like for example the population, from the
relationships above it can be deduced that:

-  The population of United Kingdom should be lower than the population
   of Europe.

-  There is no overlapping between the populations of Belgium,
   Netherlands and Luxembourg, so that these populations can be added in
   order to obtain aggregates.

-  The sum of the populations of Belgium, Netherlands and Luxembourg
   gives the population of Benelux.

A **Code Item Relation** is composed by two members, a 1\ :sup:`st`
(left) and a 2\ :sup:`nd` (right) member. The envisaged types of
relations are: “is equal to” (=), “implies” (<), “implies or is equal
to” (<=), “is implied by” (>), and “is implied by or is equal to” (>=).
“Is equal to” means also “implies and is implied”. For example:

   UnitedKingdom < Europe means (UnitedKingdom implies Europe)

   In other words, this means that if a point of space belongs to United
   Kingdom it also belongs to Europe.

The left members of a Relation is a single Code Item. The right member
can be either a single Code Item, like in the example above, or a
logical composition of Code Items: these are the **Code Item Relation
Operands**. The logical composition can be defined by means of
Operators, whose goal is to compose some Code Items (events) in order to
obtain another Code Item (event) as a result. In this simple algebra,
two operators are envisaged:

-  the logical OR of mutually exclusive Code Items, denoted “+”, for
   example:

..

   Benelux = Belgium + Luxembourg + Netherlands

   This means that if a point of space belongs to Belgium OR Luxembourg
   OR Netherlands then it also belongs to Benelux and that if a point of
   space belongs to Benelux then it also belongs either to Belgium OR to
   Luxembourg OR to Netherlands (disjunction). In other words, the
   statement above says that territories of Belgium, Netherland and
   Luxembourg are non-overlapping and their union is the territory of
   Benelux. Consequently, as for the additive measures (and being equal
   the other possible Identifiers), the sum of the measure values
   referred to Belgium, Luxembourg and Netherlands is equal to the
   measure value of Benelux.

-  the logical complement of an implying Code Item in respect to another
   Code Item implied by it, denoted “-“, for example:

..

   EUwithoutUK = EuropeanUnion - UnitedKingdom

   In simple words, this means that if a point of space belongs to the
   European Union and does not belong to the United Kingdom, then it
   belongs to EUwithoutUK and that if a point of space belongs to
   EUwithoutUK then it belongs to the European Union and not to the
   United Kingdom. In other words, the statement above says that
   territory of the United Kingdom is contained in the territory of the
   European Union and its complement is the territory of EUwithoutUK.
   Consequently, considering a positive and additive measure (and being
   equal the other possible Identifiers), the difference of the measure
   values referred to EuropeanUnion and UnitedKingdom is equal to the
   measure value of EUwithoutUK.

Please note that the symbols “+” and “-“ do not denote the usual
operations of sum and subtraction, but logical operations between Code
Items seen as events of the probability theory. In other words, two or
more Code Items cannot be summed or subtracted to obtain another Code
Item, because they are events (and not numbers), and therefore they can
be manipulated only through logical operations like “OR” and
“Complement”.

Note also that the “+” also acts as a declaration that all the Code
Items denoted by “+” are mutually exclusive (i.e. the corresponding
events cannot happen at the same time), as well as the “-“ acts as a
declaration that all the Code Items denoted by “-” are mutually
exclusive. Furthermore, the “-“ acts also as a declaration that the
relevant Code item implies the result of the composition of all the Code
Items denoted by the “+”.

At intuitive level, the symbol “+” means “\ *with”* (Benelux = Belgium
*with* Luxembourg *with* Netherland) while the symbol “-“ means
“\ *without”* (EUwithoutUK = EuropeanUnion *without* UnitedKingdom).

When these relations are applied to additive numeric Measures (e.g. the
population relevant to geographical areas), they allow to obtain the
Measure Values of the left member Code Items (i.e. the population of
Benelux and EUwithoutUK) by summing or subtracting the Measure Values
relevant to the component Code Items (i.e. the population of Belgium,
Luxembourg and Netherland in the former case, EuropeanUnion and
UnitedKingdom in the latter). This is why these logical operations are
denoted in VTL through the same symbols as the usual sum and
subtraction. Please note also that this is valid whichever the Data Set
and the additive Measure are (provided that the possible other
Identifiers of the Data Set Structure have the same Values).

These relations occur between Code Items (events) belonging to the same
Value Domain (space of events). They are typically aimed at defining
aggregation hierarchies, either structured in levels (classifications),
or without levels (chains of free aggregations) or a combination of
these options. These hierarchies can be recursive, i.e. the aggregated
Code Items can in their turn be the components of more aggregated ones,
without limitations to the number of recursions.

For example, the following relations are aimed at defining the
continents and the whole world in terms of individual countries:

-  World = Africa + America + Asia + Europe + Oceania

-  Africa = Algeria + … + Zimbabwe

-  America = Argentina + … + Venezuela

-  Asia = Afghanistan + … + Yemen

-  Europe = Albania + … + Vatican City

-  Oceania = Australia + … + Vanuatu

A simple model diagram for the Code Item Relations and Code Item
Relation Operands is the following:

.. uml::

    @startuml

        skinparam SameClassWidth true
        skinparam ClassBackgroundColor White
        skinparam nodesep 100

        class "Code Item\nRelation" as CodeItemRelation
        class "Code Item Rel.\nOperand" as CodeItemRelOperand
        class "Code Item" as CodeItem

        CodeItemRelation "1..1" -right-> "1..N" CodeItemRelOperand: "Contains in\n2nd member"
        CodeItemRelation "0..N" --> "1..1" CodeItem: "Refers as the\n1st member"
        CodeItemRelOperand "0..N" --> "1..1" CodeItem: "Refers"

    @enduml

This diagram tells that a Code Item Relation has a first and a second
member. The first member (the left one) refers to just one Code Item,
the second member (the right one) may refer to one or more Code Item
Relation Operands; each Code Item Relation Operand refers to just one
Code Item.

Conditioned Code Item Relations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Code Items (coded events) of a Code Item Relation can be conditioned
by the Values (events) of other Value Domains (spaces of events). Both
the Code Items belonging to the first and the second member of the
Relation can be conditioned.

A common case is the conditioning relevant to the reference time, which
allows expressing the historical validity of a Relation (see also the
section about the historical changes below). For example, the European
Union (EU) changed its composition in terms of countries many times,
therefore the Code Item Relationship between EU and its component
countries depends on the reference time, i.e. is conditioned by the
Values of the “reference time” Value Domain.

The VTL allows to express the conditionings by means of Boolean
expressions which refer to the Values of the conditioning Value Domains
(for more details, see the Hierarchical Rulesets in the Reference
Manual).

The historical changes 
~~~~~~~~~~~~~~~~~~~~~~~

The changes in the real world may induce changes in the artefacts of the
VTL-IM and in the relationships between them, so that some definitions
may be considered valid only with reference to certain time values. For
example, the birth of a new country as well as the split or the merge of
existing countries in the real world would induce changes in the Code
Items belonging to the Geo Area Value Domain, in the composition of the
relevant Sets, in the relationships between the Code Items and so on.
The same may obviously happen for other Value Domains.

A correct representation of the historical changes of the artefacts is
essential for VTL, because the VTL operations are meant to be consistent
with these historical changes, in order to ensure a proper behaviour in
relation to each time. With regard to this aspect, VTL must face a
complex environment, because it is intended to work also on top of other
standards, whose assumptions for representing historical changes may be
heterogeneous. Moreover, different institutions may use different
conventions in different systems.

Naturally, adopting a common convention for representing the historical
changes of the artefacts would be a good practice, because the
definitions made by different bodies would be given through the same
methodology and therefore would be easily comparable one another. In
practice, however, different conventions are already in place and have
to be taken into account, because there can also be strong motivations
to maintain them. For this reason, the VTL does not impose any definite
representation for the historical changes and leaves users free of
maintaining their own conventions, which are considered as part of the
data content to be processed rather than of the language.

Actually, the VTL-IM intentionally does not include any mechanism for
representing historical changes and needs to be properly integrated to
this purpose. This aspect is left to the standards and the institutions
adopting VTL and the implementers of VTL systems, which can adapt and
enrich the VTL-IM as needed.

Even if presented here for association of ideas with the relations
between Code Items whose temporal dependency is intuitive, these
considerations about the temporal validity of the definitions are valid
in general.

Moreover, as already mentioned, the possibility of integrating the
VTL-IM with additional metadata is needed also for other purposes, and
not only for dealing with the temporal validity.

It is appropriate here to highlight some relationships between the VTL
artefacts and some possible temporal conventions, because this can guide
VTL implementers in extending the VTL-IM according to their needs.

First, we want to distinguish between two main temporal aspects: the
so-called validity time and operational time. Validity time is the time
during which a definition is assumed to be true as an abstraction of the
real world (for example, Estonia belongs to EU “from 1st May 2004 to
current date”). Operational time is the time period during which a
definition is available in the processing system and may produce
operational effects. The following considerations refers only to the
former.

The **assignment of identifiers to the abstractions of the real world**
is strictly related to the possible basic temporal assumptions. Two main
options can be considered:

a) The same identifier is assigned to the abstraction even if some
   aspects of such an abstraction change in time. For example, the
   identifier EU is assigned to the European Union even if the
   participant countries change. Under this option, a single identifier
   (e.g. EU) is used to represent the whole history of an abstraction,
   following the intuitive conceptualization in which abstractions are
   identified independently of time and maintain the same identity even
   if they change with time. The variable aspects of an abstraction are
   therefore described by specifying their validity periods (for
   example, the participation of Estonia in the EU can be specified
   through the relevant start and end dates).

b) Different Identifiers are assigned to the abstraction when some
   aspects of the abstraction change in time. For example, more
   Identifiers (e.g. EU1, … EU9) represent the European Union, one for
   each period during which its participant countries remain stable.
   This option is based on the conceptualization in which the
   abstractions are identified in connection with the time period in
   which they do not change, so that an Code Item (e.g. EU1) corresponds
   to an abstraction (e.g. the European Union) only for the time period
   in which the abstraction remain stable (e.g. EU1 represents the
   European Union from when it was created by the founder countries, to
   the first time it changed composition). An example of adoption of
   this option b) is the common practice of giving versions to Code
   Lists or Code Items for representing time changes (e.g.
   EUv\ :sub:`1`, … , EUv\ :sub:`9` where v=version), being each version
   assumed as invariable.

Therefore, the general assumptions of VTL for the representation of the
historical changes are the following:

-  The choice of adopting the options described above is left to the
   implementations.

-  The VTL Identifiers are different depending on the two options above;
   for example in the option a) there would exist one Identifier for the
   European Union (e.g. EU) while in the option b) there would exist
   many different Identifiers, corresponding to the different versions
   of the European Union (e.g. EU1, … EU9).

-  If the Code Items are versioned for managing temporal changes (option
   b), the version is considered part of the VTL univocal identifier of
   the Code Item, and therefore different versions are equivalent to
   different Code Items. As explained above, in fact, the European Union
   would be represented by many Code Items (e.g. EUv1, … EUv9). The same
   applies if the Code Items are versioned by means of dates (e.g.
   start/end dates …) or other conventions instead than version numbers.
   As obvious, the temporal validity of EUv1 … EUv9, if represented,
   should not overlap.

The implementers of VTL systems can add the temporal validity (through
validity dates or versions) to any class of artefacts or relations of
the VTL-IM (as well as any other additional characteristic useful for
the implementation, like the textual descriptions of the artefacts or
others). If the temporal validity is not added, the occurrences of the
class are assumed valid “ever”.

The Variables and Value Domains artefacts 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The list of the VTL artefacts related to Variables and Value Domains is
given here, together with the information that the VTL need to know
about them. For the sake of simplicity, the names of some artefacts are
often abbreviated in the VTL manuals (in particular the parts of the
names shown between parentheses can be omitted).

As already mentioned, this model provides an abstract view of the core
metadata supporting the definition of the data structures but leaves out
implementation and operational aspects. For example, the textual
descriptions of the artefacts are left out, as well as the specification
of the temporal validity of the artefacts, the procedural metadata (the
specification of the way data are processed i.e. collected, stored,
validated, calculated/estimated, disseminated ...) and so on. In order
to support real systems, the implementers can conveniently adjust this
model and integrate it by adding other metadata (e.g. other properties
of the artefacts, other classes of artefacts, other relationships among
artefacts …).

**(Represented) Variable**

.. list-table::

    * - *Variable name*
      - *name of the Represented Variable*
    * - *Value Domain name*
      - *reference to the Value Domain that measures the Variable, i.e. in which the Variable takes values*

*(Data Set)* **Component**

.. list-table::

    * - *Data Set name*
      - *the Data set which the Component belongs to*
    * - *Component name*
      - *the name of the Component*
    * - *(Sub) Set name*
      - *reference to the (sub)Set containing the allowed values for the Component*

**Value Domain**

.. list-table::

    * - *Value Domain name*
      - *name of the Value Domain*
    * - *Value Domain sub-class*
      - *if it is an Enumerated or Described Value Domain*
    * - *Basic Scalar Type*
      - *the basic scalar type of the Values of the Value Domain, for example string, number … and so on (see also the section “VTL data types”)*
    * - *Value Domain Criterion*
      - *a criterion for restricting the Values of a basic scalar type, for example by specifying a max length of the representation, an upper or/and a lower value, and so on*

**Code List** *this artefact is comprised in the previous one, in fact
it corresponds one to one to the enumerated Value Domain (see above)*

**Value** *this artefact has no explicit representation, because the
Values of described Value Domains are not represented by definition,
while the Values of the enumerated Value Domains are represented through
the Code Item artefact (see below)*

**Code Item** *this artefact defines the Code Items of the Enumerated
Value Domains*

.. list-table::

    * - *Value Domain name*
      - *the Value Domain, which the Value belongs to*
    * - *Value*
      - *the univocal name of the Value within the Value Domain it belongs to*

*(Value Domain Sub)* **Set**

.. list-table::

    * - *Value Domain name*
      - *the Value Domain, which the Value belongs to*
    * - *Set name*
      - *the name of the Set, which must be univocal within the Value Domain*
    * - *Set sub-class*
      - *if it is an Enumerated or Described Set*
    * - *Set Criterion*
      - *a criterion for identifying the Values belonging to the Set*

**Set List** *this artefact is comprised in the previous one, in fact it
corresponds one to one to the enumerated Set*

**Set Item** *this artefact specifies the Code Items of the Enumerated Sets*

.. list-table::

    * - *Value Domain name*
      - *reference to the Value Domain which the Set and the Value belongs to*
    * - *Set name*
      - *the Set that contains the Value*
    * - *Value*
      - *Value element of the Set*

**Code Item Relation**

.. list-table::

    * - *1stMember Domain name*
      - *Value Domain of the first member of the Relation; e.g. Geo_Area*
    * - *1stMemberValue*
      - *the first member of the Relation; e.g. Benelux*
    * - *1stMemberComposition*
      - *conventional name of the composition method, which distinguishes possible different compositions methods related to the same first member Value. It must be univocal within the 1stMember. Not necessarily, it has to be meaningful; it can be simply a progressive number, e.g. “1”*
    * - *Relation Type*
      - *type of relation between the first and the second member, having as possible values =, <, <=, >, >=*

**Code Item Relation Operand**

.. list-table::

    * - *1stMember Domain name*
      - *Value Domain of the first member of the Relation; e.g. Geo_Area*
    * - *1stMemberValue*
      - *the first member of the Relation; e.g. Benelux*
    * - *1stMemberComposition*
      - *see the description already given above*
    * - *2ndMember Value*
      - *an operand of the Relation; e.g. Belgium*
    * - *Operator*
      - *the operator applied on the 2ndMember Value, it can be “+” or ”- “; the default is “+”*

Generic Model for Transformations
---------------------------------

The purpose of this section is to provide a formal model for describing
the validation and transformation of the data.

A Transformation is assumed to be an algorithm to produce a new model
artefact (typically a Data Set) starting from existing ones. It is also
assumed that the data validation is a particular case of transformation;
therefore, the term “transformation” is meant to be more general and to
include the validation case as well.

This model is essentially derived from the SDMX IM [14]_, as DDI and
GSIM do not have an explicit transformation model at the present
time [15]_. In its turn, the SDMX model for Transformations is similar
in scope and content to the Expression metamodel that is part of the
Common Warehouse Metamodel (CWM)  [16]_ developed by the Object
Management Group (OMG).

The model represents the user logical view of the definition of
algorithms by means of expressions. In comparison to the SDMX and CWM
models, some technical details are omitted for the sake of simplicity,
including the way expressions can be decomposed in a tree of nodes in
order to be executed (if needed, this detail can be found in the SDMX
and CWM specifications).

The basic brick of this model is the notion of Transformation.

A Transformation specifies the algorithm to obtain a certain artefact of
the VTL information model, which is the result of the Transformation,
starting from other existing artefacts, which are its operands.

Normally the artefact produced through a Transformation is a Data Set
(as usual considered at a logical level as a mathematical function).
Therefore, a Transformation is mainly an algorithm for obtaining derived
Data Sets starting from already existing ones.

The general form of a Transformation is the following:

   *result assignment_operator expression*

meaning that the outcome of the evaluation of *expression* in the
right-hand side is assigned to the *result of the Transformation* in the
left-hand side (typically a Data Set). The assignment operators are two,
”:=” and “<-“ (for the assignment to a persistent or a non-persistent
result, respectively). A very simple example of Transformation is:

   *D\ r <- D\ 1* (*D\ r , D\ 1* are assumed to be Data Sets)

In this Transformation the Data Set *D\ 1* is assigned without changes
(i.e. is copied) to *D\ r*, which is persistently stored.

In turn, the *expression* in the right-hand side composes some operands
(e.g., some input Data Sets, but also Sets or other artefacts) by means
of some operators (e.g. sum, product …) to produce the desired results
(e.g. the validation outcome, the calculated data).

For example:   *D\ r := D\ 1 + D\ 2* (*D\ r , D\ 1 , D\ 2* are assumed to
be Data Sets)

In this example, the measure values of the Data Set *D\ r* are
calculated as the sum of the measure values of the Data Sets *D\ 1* and
*D\ 2*, by composing the Data Points having the same Values for the
Identifiers. In this case, *D\ r* is not persistently stored.

A validation is intended to be a kind of Transformation. For example,
the simple validation that *D\ 1* = *D\ 2* can be made through an “If”
operator, with an expression of the type:

   *D\ r* := If (*D\ 1* = *D\ 2* , then **true**, else **false**)

In this case, the Data Set *D\ r* would have a Boolean measure
containing the value **true** if the validation is successful and **false** if
it is unsuccessful.

These are only fictitious examples for explanation purposes. The general
rules for the composition of Data Sets (e.g. rules for matching their
Data Points, for composing their measures …) are described in the
sections below, while the actual Operators of the VTL and their
behaviours are described in the VTL reference manual.

The *expression* in the right-hand side of a Transformation must be
written according to a formal language, which specifies the list of
allowed operators (e.g. sum, product …), their syntax and semantics, and
the rules for composing the expression (e.g. the default order of
execution of the operators, the use of parenthesis to enforce a certain
order …). The Operators of the language have Parameters [17]_, which are
the a-priori unknown inputs and output of the operation, characterized
by a given role (e.g. dividend, divisor or quotient in a division).

Note that this generic model does not specify the formal language to be
used. In fact, not only the VTL but also other languages might be
compliant with this specification, provided that they manipulate and
produce artefacts of the information model described above. This is a
generic and formal model for defining Transformations of data through
mathematical expressions, which in this case is applied to the VTL,
agreed as the standard language to define and exchange validation and
transformation rules among different organizations

Also, note that this generic model does not actually specify the
operators to be used in the language. Therefore, the VTL may evolve and
may be enriched and extended without impact on this generic model.

In the practical use of the language, Transformations can be composed
one with another to obtain the desired outcomes. In particular, the
result of a Transformation can be an operand of other Transformations,
in order to define a sequence of calculations as complex as needed.

Moreover, the Transformations can be grouped into Transformations
Schemes, which are sets of Transformations meaningful to the users. For
example, a Transformation Scheme can be the set of Transformations
needed to obtain some specific meaningful results, like the validations
of one or more Data Sets. A Transformation Scheme is meant to be the
smaller set of Transformations to be executed in the same run.

A set of Transformations takes the structure of a graph, whose nodes are
the model artefacts (usually Data Sets) and whose arcs are the links
between the operands and the results of the single Transformations. This
graph is directed because the links are directed from the operands to
the results and is acyclic because it should not contain cycles (like in
the spreadsheets), otherwise the result of the Transformations might
become unpredictable.

The ability of generating this graph is a main feature of the VTL,
because the graph documents the operations performed on the data, just
like a spreadsheet documents the operations among its cells.

Transformations model diagram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. uml::

    @startuml

        skinparam SameClassWidth true
        skinparam ClassBackgroundColor #D3D3D3
        skinparam linetype ortho
        skinparam nodesep 100

        class "Transformation\nScheme" as TransformationScheme
        class "Non Persistent\nOperand" as NonPersistentOperand
        class "Persistent\nOperand" as PersistentOperand
        class "Non Persistent\nResult" as NonPersistentResult
        class "Persistent\nResult" as PersistentResult
        class "Identifiable\nArtefact" as IdentifiableArtefact

        Operator "1..N" <-right- "0..N" Transformation: "uses"
        TransformationScheme o-left- "0..N" Transformation
        Operator *-- "0..N" Parameter: "input"
        Operator *-- "1..1" Parameter: "output"
        Transformation -down-> "0..N" Operand: "acts on"
        Transformation --> "1..1" Result: "produces"

        NonPersistentOperand -up-|> Operand
        PersistentOperand -up-|> Operand
        NonPersistentResult -up-|> Result
        PersistentResult -up-|> Result
        PersistentOperand "0..N" --> "1..1" IdentifiableArtefact: "references"
        PersistentResult "0..1" --> "1..1" IdentifiableArtefact: "references"

    @enduml

White box: same as in GSIM 1.1

Dark grey box: additional detail (in respect to GSIM 1.1)

.. _explanation-of-the-diagram-2:

Explanation of the diagram 
~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Transformation**: the basic element of the calculations, which
consists of a statement that assigns the outcome of the evaluation of an
Expression to an Artefact of the Information Model;

**Expression**: a finite combination of symbols that is well formed
according to the syntactical rules of the language. The goal of an
Expression is to compose some Operands in a certain order by means of
the Operators of the language, in order to obtain the desired result.
Therefore, the symbols of the Expression designate Operators, Operands
and the order of application of the Operators (e.g. the parenthesis); an
expression is defined as a text string and is a property of a
Transformation;

**Transformation Scheme**: a set of Transformations aimed at obtaining
some meaningful results for the user (like the validation of one or more
Data Sets); the Transformation Scheme is meant to be the smaller set of
Transformation to be executed in the same run and therefore may also be
considered as a VTL program;

**Operator**: the specification of a type of operation to be performed
on some Operands (e.g. sum (+), subtraction (-), multiplication (\*),
division (/));

**Parameter**: a-priori unknown input or output of an Operator, having a
definite role in the operation (e.g. dividend, divisor or quotient for
the division) and corresponding to a certain type of artefact (e.g. a
“Data Set”, a “Data Structure Component” …), for a deeper explanation
see also the Data Type section below. When an Operator is invoked, the
actual input passed in correspondence to a certain input Parameter, or
the actual output returned by the Operator, is called Argument.

**Operand**: a specific Artefact referenced in the expression as an
input (e.g. a specific input Data Set); a Persistent Operand references
a persistent artefact, i.e. an artefact maintained in a persistent
storage, while a Non Persistent Operand references a temporary artefact,
which is produced by another Transformation and not stored.

**Result**: a specific Artefact to which the result of the expression is
assigned (e.g. the calculated Data Set); a Persistent Result is put away
in a persistent storage while a Non Persistent Result is not stored.

**Identifiable Artefact**: a persistent Identifiable Artefact of the VTL
information model (e.g. a persistent Data Set); a persistent artefact
can be operand of any number of Transformation but can be the result of
no more than one Transformation.

.. _examples-1:

Examples
~~~~~~~~

Imagine that *D\ 1, D\ 2* and *D\ 3* are Data Sets containing
information on some goods, specifically: *D\ 1* the stocks of the
previous date, *D\ 2* the flows in the last period, *D\ 3* the current
stocks. Assume that it is desired to check the consistency of the Data
Sets using the following statement:

   *D\ r* := If ((*D\ 1* + *D\ 2*) = *D\ 3* , then “true”, else “false”)

In this case:

The Transformation may be called “basic consistency check between stocks
and flows” and is formally defined through the statement above.

-  *D\ r* is the Result

-  *D\ 1*, *D\ 2* *and D\ 3* are the Operands

-  If ((*D\ 1* + *D\ 2*) = *D\ 3* , then **true**, else **false**) is the
   Expression

-  “:=”, “If”, “+” , “=” are Operators

Each operator has some predefined parameters, for example in this case:

-  input parameters of “+”: two numeric Data Sets (to be summed)

-  output parameters of “+”: a numeric Data Sets (resulting from the
   sum)

-  input parameters of “=”: two Data Sets (to be compared)

-  output parameter of “=”: a Boolean Data Set (resulting from the
   comparison)

-  input parameters of “If”: an Expression defining a condition, i.e.
   (*D\ 1*\ +\ *D\ 2*)=\ *D\ 3*

-  output parameter of “If”: a Data Set (as resulting from the “then”,
   “else” clauses)

Functional paradigm
~~~~~~~~~~~~~~~~~~~

As mentioned, the VTL follows a functional programming paradigm, which
treats computations as the evaluation of mathematical functions, so
avoiding changing-state and mutable data in the specification of the
calculation algorithm. On one side the statistical data are considered
as mathematical functions (first order functions), on the other side the
VTL operators are considered as functions as well (second order
functions), applicable to some data in order to obtain other data.

According to the functional paradigm, the output value of a (second
order) function depends only on the input arguments of the function, is
calculated in its entirety and once for all by applying the function,
and cannot be altered or modified once calculated (immutable) unless the
input arguments change.

In fact, the VTL operators, and the expressions built using these
operators, specify the algorithm for calculating the results in their
entirety, once for all, and never for updating them. When some change in
the operands occurs (e.g. the input data change), the VTL assumes that
the results are recalculated in their entirety according to the
correspondent expressions [18]_.

Coherently, a VTL artefact can be result of just one Transformation and
cannot be updated by other Transformations, a Transformation cannot
update either its own operands or the result of other Transformations
and the result of a new Transformation is always a new artefact.

Transformation Consistency
~~~~~~~~~~~~~~~~~~~~~~~~~~

The Transformation model requires that the Transformations follow some
consistency rules, similar to the ones typical of the spreadsheets; in
fact, there is a strict analogy between the generic models of
Transformations and spreadsheets.

In this analogy, a VTL artefact corresponds to a non-empty cell of a
spreadsheet, a Transformation to the formula defined in a cell (which
references other cells as operands), a Result to the content of the cell
in which the formula is defined [19]_.

The model artefacts involved in Transformations can be divided into
“collected / primary” or “calculated / derived” ones. The former are
original artefacts of the information system, *not* result of any
Transformation, fed from some external source or by the users (they are
analogous to the spreadsheet cells that are not calculated). The latter
are produced as results of some Transformations (they are analogous to
the spreadsheet cells calculated through a formula).

As already said, a Transformation calculates *just one* result
(“derived” model artefact) and a result is calculated by *just one*
Transformation. Both “primary” and “derived” model artefacts can be
operands of any number of Transformations. An artefact cannot be operand
and result of the same Transformation.

A Transformation belongs to just one Transformation Scheme, which is
analogous to a whole spreadsheet; in fact, it is a set of
Transformations executed in the same run and may contain any number of
Transformations, in order to produce any number of results.

Because a “derived” model artefact is produced by just one
Transformation and a Transformation belongs to just one Transformation
Scheme, it follows also that a “derived” model artefact is produced in
the context of just one Transformation Scheme.

The operands of a Transformation may come either from the same
Transformation Scheme which the Transformation belongs to or from other
ones.

Within a Transformation Scheme, it can be built a graph of the
Transformations by assuming that each model artefact is a node and each
Transformation is a set of arcs, starting from the Operand nodes and
ending in the Result node.

This graph must be a directed acyclic graph (DAG): in particular, each
arc is oriented from the operand to the result; the absence of cycles
makes it possible to calculate unambiguously the “derived” nodes by
applying the Transformations by following the topological order of the
graph.

Therefore, like in the spreadsheet, not necessarily, the Transformations
are performed in the same order as they are written, because the order
of execution depends on their input-output relationships (a
Transformation that calculates a result, which is operand of other
Transformations must be executed first).

In the analogy between VTL and a spreadsheet, the correspondences would
be the following:

-  VTL model artefact 🡨🡪 non-empty cell of a spreadsheet;

-  VTL “collected / primary” model artefact 🡨🡪 non-empty cell of a
   spreadsheet whose value is fed from an external source or by the
   user;

-  A “calculated / derived” model artefact 🡨🡪 a non-empty cell of a
   spreadsheet whose value is calculated by a formula;

-  A VTL Transformation 🡨🡪 A spreadsheet formula assigned to a cell

-  a VTL Transformation Scheme 🡨🡪 A whole spreadsheet

.. [5]
   The definition of a temporary artefact can be also persistent, if
   needed.

.. [6]
   See also the section “Relations with the GSIM Information model”

.. [7]
   Hyperlink
   “\ \ `https://unece.org/statistics/modernstats/gsim” <https://unece.org/statistics/modernstats/gsim>`__

.. [8]
   Some initiatives have been started by UNECE High-Level Group for the
   Modernisation of Official Statistics (HLG-MOS); see for example https://unece.org/statistics/documents/2023/11/working-documents/hlg2023-ssg-sdmxvtlddi-implement-gsim.

.. [9]
   For example in the Common Warehouse Metamodel and Meta-Object
   Facility specifications

.. [10]
   For example, this is the case of a relationship that does not have
   properties: imagine a Data Set containing the relationship between
   the students and the courses that they have followed, without any
   other information: the corresponding Data Set would have StudentId
   and CourseId as Identifiers and would not have any explicit measure

.. [11]
   For example, for ensuring correct operations, the knowledge of the
   Data Structure of the input Data Sets is essential at parsing time,
   in order to check the correctness of the VTL expression and determine
   the Data Structure of the result, and at execution time to perform
   the calculations

.. [12]
   This is the Value Domain which measures the Represented Variable,
   which defines the Data Structure Component, which the Data Set
   Component matches to

.. [13]
   According to the probability theory, a random experiment is a
   procedure that returns a result belonging a predefined set of
   possible results (for example, the determination of the “geographic
   location” may be considered as a random experiment that returns a
   point of the Earth surface as a result). The “space of results” is
   the space of all the possible results. Instead an “event” is a set of
   results (going back to the example of the geographic location, the
   event “Europe” is the set of points of the European territory and
   more in general an “event” corresponds to a “geographical area”). The
   “space of events” is the space of all the possible “events” (in the
   example, the space of the geographical areas).

.. [14]
   The SDMX specification can be found at https://sdmx.org/?page_id=5008
   (see Section 2 - Information Model, package 13 - “Transformations and
   Expressions”).

.. [15]
   The Transformation model described here is not a model of the
   processes, like the ones that both SDMX and GSIM have, and has a
   different scope. The mapping between the VTL Transformation and the
   Process models is not covered by the present document.

.. [16]
   This specification can be found at http://www.omg.org/cwm.

.. [17]
   The term is used with the same meaning of “argument”, as usual in
   computer science.

.. [18]
   At the implementation level, which is out of the scope of this
   document, the update operations are obviously possible

.. [19]
   The main difference between the two cases is the fact that a cell of
   a spreadsheet may contain only a scalar value while a VTL artefact
   may have also a more complex data structure, being typically a Data
   Set

