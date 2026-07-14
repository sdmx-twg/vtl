Introduction
============

This document presents the Validation and Transformation Language (also
known as ‘VTL’) version 2.2.

The purpose of VTL is to allow a formal and standard definition of
algorithms to validate statistical data and calculate derived data.

The first development of VTL aims at enabling, as a priority, the
formalisation of data validation algorithms rather than tackling more
complex algorithms for data compilation. In fact, the assessment of
business cases showed that the majority of the institutions ascribes
(prescribes) a higher priority to a standard language for supporting the
validation processes and in particular to the possibility of sharing
validation rules with the respective data providers, in order to specify
the quality requirements and allow validation also before provision.

This document is the outcome of a second iteration of the first phase,
and therefore still presents a version of VTL primarily oriented to
support the data validation. However, as the features needed for
validation also include simple calculations, this version of VTL can
support basic compilation needs as well. In general, validation is
considered as a particular case of transformation; therefore, the term
“Transformation” is meant to be more general, including validation as
well. The actual operators included in this version of VTL are described
in the Reference Manual.

Although VTL is developed under the umbrella of the SDMX governance, DDI
and GSIM users may also be highly interested in adopting a language for
validation and transformation. In particular, organizations involved in
the SDMX, DDI and GSIM communities and in the Modernisation of Official
Statistics (HLG-MOS) expressed their wish of adopting VTL as a unique
language, usable in SDMX, DDI and GSIM.

Accordingly, the task-force working for the VTL development agreed on
the objective of adopting a common language, in the hope of avoiding the
risk of having diverging variants.

Consequently, VTL is designed as a language relatively independent of
the details of SDMX, DDI and GSIM. It is based on an independent
information model (IM), made of the very basic artefacts common to these
standards. Other models can inherit the VTL language by unequivocally
mapping their artefacts to those of the VTL IM.

Structure of the document
~~~~~~~~~~~~~~~~~~~~~~~~~

The following main sections of the document describe the following
topics:

The general characteristics of the VTL, which are also the main
requirements that the VTL is aimed to fulfil.

The changes of VTL 2.x in respect to VTL 1.0 and a section with the list
of changes between two consecutive minor versions.

The Information Model on which the language is based. In particular, it
describes the generic model of the data artefacts for which the language
is aimed to validate and transform the generic model of the variables
and value domains used for defining the data artefacts and the generic
model of the transformations.

The Data Types that the VTL manipulates, i.e. types of artefacts i.e.
types of artefacts that can be passed in input to or are returned in
output from the VTL operators.

The general rules for defining the Transformations, which are the
algorithms that describe how the operands are transformed into the
results.

The characteristics, the invocation and the behaviour of the VTL
Operators, taking into account the perspective of users that need to
learn how to use them.

A final part highlights some issues related to the governance of VTL
developments and to future work, following a number of comments,
suggestions and other requirements that were submitted to the task force
in order to enhance the VTL package.

A short annex gives some background information about the BNF
(Backus-Naur Form) syntax used for providing a context-free
representation of VTL.

The Extended BNF (EBNF) representation of the VTL 2.2 package is
available at https://sdmx.org/?page_id=5096.
