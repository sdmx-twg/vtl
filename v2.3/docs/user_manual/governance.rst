Governance, other requirements and future work
==============================================

The SDMX Technical Working Group, as mandated by the SDMX Secretariat,
is responsible for ensuring the technical maintenance of the Validation
and Transformation Language through a dedicated VTL task force. The VTL
task force is open to the participation of experts from other
standardisation communities, such as DDI and GSIM, as the language is
designed to be usable within different standards.

The governance of the extensions
--------------------------------

According to the requirements, it is envisaged that the language can be
enriched and made more powerful in future versions according to the
evolution of the business needs. For example, new operators and clauses
can be added, and the language syntax can be upgraded.

The VTL governance body will take care of the evolution process,
collecting and prioritising the requirements, planning and designing the
improvements, releasing future VTL versions.

The release of new VTL versions is considered as the preferred method of
fulfilling the requirements of the user communities. In this way, the
possibility of exchanging standard validation and transformation rules
would be preserved to the maximum extent possible.

In order to fulfil specific calculation features not yet supported, the
VTL provides for an operator which allows to define new custom operators
by means of the existing ones and another operator (Evaluate) whose
purpose is to invoke an external calculation function (routine),
provided that this is compatible with the VTL IM, basic principles and
data types.

As already mentioned, because the user-defined operators does not belong
to the standard library, they are not standard VTL operators and are
applicable only in the context in which they have been defined. In
particular, if there is the need of applying user-defined operators in
other contexts, their definitions need to be pre-emptively shared.

The operator “Evaluate” (also “Eval”) allows defining and making
customized calculations (also reusing existing routines) without
upgrading or extending the language, because the external calculation
function is not considered as an additional operator. The expressions
containing Eval are standard VTL expressions and can be parsed through a
standard parser. For this reason, when it is not possible or convenient
to use other VTL operators, Eval is the recommended method of
customizing the language operations.

However, as explained in the section “Extensibility and Customizability”
of the “General Characteristics of VTL” above, calling external
functions has some drawbacks in respect to the use of the proper VTL
operators. The transformation rules would be not understandable unless
such external functions are properly documented and shared and could
become dependent on the IT implementation, less abstract and less user
oriented. Moreover, the external functions cannot be parsed (as if they
were built through VTL operators) and this could make the expressions
more error-prone. External routines should be used only for specific
needs and in limited cases, whereas widespread and generic needs should
be fulfilled through the operators of the language.

While the “Eval” operator is part of VTL, the invoked external
calculation functions are not. Therefore, they are considered as
customized parts under the governance, and are responsibility and charge
of the organizations that use it.

Organizations possibly extending VTL through non-standard
operators/clauses would operate on their own total risk and
responsibility for any possible maintenance activity deriving from VTL
modifications.

As mentioned, whilst an Organisation adopting VTL can extend its own
library by defining customized parts and by implementing external
routines, on its own total responsibility, in order to improve the
standard language for specific purposes (e.g. for supporting possible
algorithms not permitted by the standard part), it is important that the
customized parts remain compliant with the VTL IM and the VTL
fundamentals. Adopting Organizations are totally in charge of any
activity for maintaining and sharing their customized parts. Adopting
Organizations are also totally in charge of any possible maintenance
activity to maintain the compliance between their customized parts and
the possible standard VTL future evolution.

Relations with the GSIM Information Model 
------------------------------------------

As already said, GSIM artefacts are used as much as possible for the
VTL IM. Some differences between this model and GSIM are due to the
fact that, in the VTL IM, both unit and dimensional data are considered
as first-order mathematical functions having independent and dependent
variables and are treated in the same way.

As explained later, VTL is inspired by GSIM as much as possible, in order
to provide a formal model at business level against which other information
models can be mapped, and to facilitate the implementation of VTL with
standards like SDMX, DDI and possibly others.

GSIM faces many aspects that are out of the VTL scope; the latter uses
only those GSIM artefacts that are strictly related to the
representation of validations and transformations. The referenced GSIM
artefacts have been assessed against the requirements for VTL and, in
some cases, adapted or improved as necessary, as explained earlier. No
assessment was made about those GSIM artefacts that are out of the VTL
scope.

In respect to GSIM, VTL considers both unit and dimensional data as
mathematical functions having a certain structure in term of independent
and dependent variables. This leads to a simplification, as unit and
dimensional data can be managed in the same way, but it also introduces
some slight differences in data representation. The aim of the VTL Task
Force is to propose the adoption of this adjustment for the next GSIM
versions.


Data Sets and Data Structures 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The VTL Data Set and Data Structure artefacts are similar to the
corresponding GSIM artefact. VTL, however, does not make a distinction
between Unit and Dimensional Data Sets and Data Structures.

In order to explain the relationships between VTL and GSIM, the
distinction between Unit and Dimensional Data Sets can be introduced
virtually even in the VTL artefacts. In particular, the GSIM Data Set
may be a GSIM Dimensional Data Set or a GSIM Unit Data Set, while a VTL
Data Set may (virtually) be:

   either a (virtual) **VTL Dimensional Data Set**: a kind of (Logical)
   Data Set describing groups of units of a population that may be
   composed of many units. This (virtual) artefact would be the same as
   the GSIM Dimensional Data Set;

   or a (virtual) **VTL Unit Data Set**: a kind of (Logical) Data Set
   describing single units of a population. This (virtual) artefact
   would be the same as the Unit Data Record in GSIM, which has its own
   structure and can be thought of as a mathematical function. The
   difference is that the VTL Unit Data Set would not correspond to the
   GSIM Unit Data Set, because the latter cannot be considered as a
   mathematical function: in fact, it can have many GSIM Unit Data
   Records with different structures.

A similar relationship exists between VTL and GSIM Data Structures. In
particular, introducing in VTL the virtual distinction between Unit and
Dimensional Data Structures, while a GSIM Data Structure may be a GSIM
Dimensional Data Structure or a GSIM Unit Data Structure, a VTL Data
Structure may (virtually) be:

   either a (virtual) **VTL Dimensional Data Structure**: the structure
   of (0...n) Dimensional Data Sets. This artefact would be the same as
   in GSIM;

   or a (virtual) **VTL Unit Data Structure**: the structure of (0...n)
   Unit Data Sets. This artefact would be the same as the Logical Record
   in GSIM, which corresponds to a single structure and can be thought
   as the structure of a mathematical function. The difference is that
   the VTL Unit Data Structure would not correspond to the GSIM Unit
   Data Structure, because the latter cannot be considered as the
   structure of a mathematical function: in fact, it can have many
   Logical Records with different structures.

The following diagram summarizes the relationships between the GSIM and
the VTL Data Sets and Data Structures, according to the explanation
given above.

Please take into account that the distinction between Dimensional and
Unit Data Set and Data Structure is not used by the VTL language and is
not part of the VTL IM. This virtual distinction is highlighted here and
in the diagram below just for clarifying the mapping of the VTL IM with
GSIM and DDI.

GSIM – VTL mapping diagram about data structures:

.. uml::

    @startuml

        skinparam SameClassWidth true
        skinparam ClassBackgroundColor White
        skinparam linetype ortho
        skinparam nodesep 100

        class "GSIM Unit\nData Record" as GSIMUnitDataRecord
        class "GSIM Dimens.\nData Set" as GSIMDimensDataSet
        class "GSIM\nLogical Record" as GSIMLogicalRecord
        class "GSIM Dimens.\nData Structure" as GSIMDimensDataStructure
        class "VTL\nData Set" as VTLDataSet #F8F8F8
        class "VTL\nData Structure" as VTLDataStructure #F8F8F8

        package "Virtual VTL artefacts" as vtl #line.dashed {
            class "VTL Unit Data\nSet" as VTLUnitDataSet
            class "VTL Dimens.\nData Set" as VTLDimensDataSet
            class "VTL Unit Data\nStructure" as VTLUnitDataStructure
            class "VTL Dimens.\nData Structure" as VTLDimensDataStructure
            'Draw hidden links to control package layout
            VTLUnitDataSet -down[hidden]- VTLDimensDataSet
            VTLUnitDataSet -down[hidden]- VTLDimensDataSet
            VTLDimensDataSet -down[hidden]- VTLUnitDataStructure
            VTLUnitDataStructure -down[hidden]- VTLDimensDataStructure
        }

        vtl.VTLUnitDataSet <-left-> GSIMUnitDataRecord: "mappings  "
        vtl.VTLDimensDataSet <-left-> GSIMDimensDataSet
        vtl.VTLUnitDataStructure <-left-> GSIMLogicalRecord
        vtl.VTLDimensDataStructure <-left-> GSIMDimensDataStructure

        vtl.VTLUnitDataSet -right-|> VTLDataSet
        vtl.VTLDimensDataSet -right-|> VTLDataSet
        vtl.VTLUnitDataStructure -right-|> VTLDataStructure
        vtl.VTLDimensDataStructure -right-|> VTLDataStructure

        VTLDataSet "0..N" -down-> "1..1" VTLDataStructure: "structured by"

    @enduml

Value Domains 
~~~~~~~~~~~~~~

The VTL IM allows defining the Value Domains (as in GSIM) and their
subsets (not explicitly envisaged in GSIM), needed for validation
purposes. In order to be compliant, the GSIM artefacts are used for
modelling the Value Domains and a similar structure is used for
modelling their subsets. Even in this case, the VTL task force will
propose the explicit introduction of the Value Domain Subsets in future
GSIM versions.

Transformation model and Business Process Model 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

VTL is based on a model for defining mathematical expressions that is
called "Transformation model". GSIM does not have a Transformation
model, which is however available in the SDMX IM. The VTL IM has been
built on the SDMX Transformation model, with the intention of suggesting
its introduction in future GSIM versions.

Some misunderstanding may arise from the fact that GSIM, DDI, SDMX and
other standards also have a Business Process model. The connection
between the Transformation model and the Business Process model has been
neither analysed nor modelled in VTL 1.0. One reason is that the
business process models available in GSIM, DDI and SDMX are not yet
fully compatible and univocally mapped.

It is worth nothing that the Transformation and the Business Process
models address different matters. In fact, the former allows defining
validation and calculation rules in the form of mathematical expressions
(like in a spreadsheet) while the latter allows defining a business
process, made of tasks to be executed in a certain order. The two models
may coexist and be used together as complementary. For example, a
certain task of a business process (say the validation of a data set)
may require the execution of a certain set of validation rules,
expressed through the Transformation model used in VTL. Further progress
in this reconciliation can be part of the future work on VTL.

