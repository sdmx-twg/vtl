Foreword 
=========

The Task force for the Validation and Transformation Language (VTL), created in 2012-2013 under the
initiative of the SDMX Secretariat, is pleased to present the version 2.1 of VTL.

The SDMX Secretariat launched the VTL work at the end of 2012, moving on from the consideration
that SDMX already had a package for transformations and expressions in its information model,
while a specific implementation language was missing.  To make this framework operational,
a standard language for defining validation and transformation rules (operators, their syntax
and semantics) has been adopted.

The VTL task force was set up early in 2013, composed of members of SDMX, DDI and GSIM
communities and the work started in summer 2013. The intention was to provide a language
usable by statisticians to express logical validation rules and transformations on data, 
described as either dimensional tables or unit-record data. The assumption is that this 
logical formalization of validation and transformation rules could be converted into specific 
programming languages for execution (SAS, R, Java, SQL, etc.), and would provide at the same 
time, a “neutral” business-level expression of the processing taking place, against which 
various implementations can be mapped. Experience with existing examples suggests that this 
goal would be attainable.

An important point that emerged is that several standards are interested in such a kind 
of language. However, each standard operates on its model artefacts and produces artefacts 
within the same model (property of closure). To cope with this, VTL has been built upon a 
very basic information model (VTL IM), taking the common parts of GSIM, SDMX and DDI, 
mainly using artefacts from GSIM, somewhat simplified and with some additional detail. 
In this way, existing standards (GSIM, SDMX, DDI, others) would be allowed to adopt VTL 
by mapping their information model against the VTL IM. Therefore, although a work-product of 
SDMX, the VTL language in itself is independent of SDMX and will be usable with other 
standards as well. Thanks to the possibility of being mapped with the basic part of the 
IM of other standards, the VTL IM also makes it possible to collect and manage the basic 
definitions of data represented in different standards.

For the reason described above, the VTL specifications are designed at logical level, 
independently of any other standard, including SDMX. The VTL specifications, therefore, 
are self-standing and can be implemented either on their own or by other standards 
(including SDMX). 

The first public consultation on VTL (version 1.0) was held in 2014. Many comments were 
incorporated in the VTL 1.0 version, published in March 2015.  Other suggestions for 
improving the language, received afterwards, fed the discussion for building the draft 
version 1.1, which contained many new features, was completed in the second half of 2016 
and provided for public consultation until the beginning of 2017.

The high number and wide impact of comments and suggestions induced a high workload 
on the VTL TF, which agreed to proceed in two steps for the publication of the final
documentation. The first step has been dedicated to fixing some high-priority features 
and making them as much stable as possible; given the high number of changes, it was decided 
that the new version should be considered as a major one and thus named VTL 2.0.

The second step, taking also into consideration that some VTL implementation initiatives 
are already in place, is aimed at acknowledging and fixing other features considered 
of minor impact and priority, without affecting the features already published or the 
possible relevant implementations. 

In parallel with the work for designing the new VTL version, the task force has been 
involved in the SDMX implementation of VTL, aiming at defining formats for exchanging 
rules and developing web services to retrieve them; the new features have been included 
in the SDMX 3.0 package.

The VTL 2.1 package contains the general VTL specifications,
independently of the possible implementations of other standards; it includes:

a) The User Manual, highlighting the main
   characteristics of VTL, its core assumptions and the information
   model the language is based on;

b) The Reference Manual, containing the full library of operators ordered 
   by category, including examples;

c) eBNF notation (extended Backus-Naur Form) which is the
   technical notation to be used as a test bed for all the examples.

d) A Technical Notes document, containing some guidelines for VTL implementation.

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