General characteristics of the VTL
==================================

This section lists and briefly illustrates some general high-level
characteristics of the validation and transformation language. They have
been discussed and shared as requirements for the language in the VTL
working group since the beginning of the work and have been taken into
consideration for the design of the language.

User orientation
----------------

-  The language is designed for users without information technology
   (IT) skills, who should be able to define calculations and
   validations independently, without the intervention of IT personnel;

   -  The language is based on a “user” perspective and a “user”
      information model (IM) and not on possible IT perspectives (and
      IMs)

   -  As much as possible, the language is able to manipulate
      statistical data at an abstract/conceptual level, independently of
      the IT representation used to store or exchange the data
      observations (e.g. files, tables, xml tags), so operating on
      abstract (from IT) model artefacts to produce other abstract (from
      IT) model artefacts

   -  It references IM objects and does not use direct references to IT
      objects

-  The language is intuitive and friendly (users should be able to
   define and understand validations and transformations as easily as
   possible), so the syntax is:

   -  Designed according to mathematics, which is a universal knowledge;

   -  Expressed in English to be shareable in all countries;

   -  As simple, intuitive and self-explanatory as possible;

   -  Based on common mathematical expressions, which involve “operands”
      operated on by “operators” to obtain a certain result;

   -  Designed with minimal redundancies (e.g. possibly avoiding
      operators specifying the same operation in different ways without
      concrete reasons).

-  The language is oriented to statistics, and therefore it is capable
   of operating on statistical objects and envisages the operators
   needed in the statistical processes and in particular in the data
   validation phases, for example:

   -  Operators for data validations and edit;

   -  Operators for aggregation, even according to hierarchies;

   -  Operators for dimensional processing (e.g. projection, filter);

   -  Operators for statistics (e.g. aggregation, mean, median, variance
      …).

Integrated approach
-------------------

-  The language is independent of the statistical domain of the data to
   be processed;

   -  VTL has no dependencies on the subject matter (the data content);

   -  VTL is able to manipulate statistical data in relation to their
      structure.

-  The language is suitable for the various typologies of data of a
   statistical environment (for example dimensional data, survey data,
   registers data, micro and macro, quantitative and qualitative) and is
   supported by an information model (IM) which covers these typologies;

   -  The IM allows the representation of the various typologies of data
      of a statistical environment at a conceptual/logical level (in a
      way abstract from IT and from the physical storage);

   -  The various typologies of data are described as much as possible
      in an integrated way, by means of common IM artefacts for their
      common aspects;

   -  The principle of the Occam’s razor is applied as an heuristic
      principle in designing the conceptual IM, so keeping everything as
      simple as possible or, in other words, unifying the model of
      apparently different things as much as possible.

-  The language (and its IM) is independent of the phases of the
   statistical process and usable in any one of them;

   -  Operators are designed to be independent of the phases of the
      process, their syntax does not change in different phases and is
      not bound to some characteristic restricted to a specific phase
      (operators’ syntax is not aware of the phase of the process);

   -  In principle, all operators are allowed in any phase of the
      process (e.g. it is possible to use the operators for data
      validation not only in the data collection but also, for example,
      in data compilation for validating the result of a compilation
      process; similarly it is possible to use the operators for data
      calculation, like the aggregation, not only in data compilation
      but also in data validation processes);

   -  Both collected and calculated data are equally permitted as inputs
      of a calculation, without changes in the syntax of the
      operators/expression;

   -  Collected and calculated data are represented (in the IM) in a
      homogeneous way with regard to the metadata needed for
      calculations.

-  The language is designed to be applied not only to SDMX but also to
   other standards;

   -  VTL, like any consistent language, relies on a specific
      information model, as it operates on the VTL IM artefacts to
      produce other VTL IM artefacts. In principle, a language cannot be
      applied as-is to another information model (e.g. SDMX, DDI, GSIM);
      this possibility exists only if there is an unambiguous
      correspondence between the artefacts of those information models
      and the VTL IM (that is if their artefacts correspond to the same
      mathematical notion);

   -  The goal of applying the language to more models/standards is
      achieved by using a very simple, generic and conceptual
      Information Model (the VTL IM), and mapping this IM to the models
      of the different standards (SDMX, DDI, GSIM, …); to the extent
      that the mapping is straightforward and unambiguous, the language
      can be inherited by other standards (with the proper adjustments);

   -  To achieve an unambiguous mapping, the VTL IM is deeply inspired
      by the GSIM IM and uses the same artefacts when possible [1]_; in
      fact, GSIM is designed to provide a formal description of data at
      business level against which other information models can be
      mapped; a very small subset of the GSIM artefacts is used in the
      VTL IM in order to keep the model and the language as simple as
      possible (Occam’s razor principle); these are the artefacts
      strictly needed for describing the data involved in Transformations,
      their structure and the variables and value domains;

   -  GSIM artefacts are supplemented, when needed, with other artefacts
      that are necessary for describing calculations; in particular, the
      SDMX model for Transformations is used;

   -  As mentioned above, the definition of the VTL IM artefacts is
      based on mathematics and is expressed at an abstract user level.

Active role for processing
--------------------------

-  The language is designed to make it possible to drive in an active
   way the execution of the calculations (in addition to documenting
   them)

-  For the purpose above, it is possible either to implement a
   calculation engine that interprets the VTL and operates on the data
   or to rely on already existing IT tools (this second option requires
   a translation from the VTL to the language of the IT tool to be used
   for the calculations)

-  The VTL grammar is being described formally using the universally
   known Backus Naur Form notation (BNF), because this allows the VTL
   expressions to be easily defined and processed; the formal
   description allow the expressions:

   -  To be parsed against the rules of the formal grammar; on the IT
      level, this requires the implementation of a parser that compiles
      the expressions and checks their correctness;

   -  To be translated from the VTL to the language of the IT tool to be
      used for the calculation; on the IT level, this requires the
      implementation of a proper translator;

   -  To be translated from/to other languages if needed (through the
      implementation of a proper translator).

-  The inputs and the outputs of the calculations and the calculations
   themselves are artefacts of the IM

   -  This is a basic property of any robust language because it allows
      calculated data to be operands of further calculations;

   -  If the artefacts are persistently stored, their definition is
      persistent as well; if the artefacts are non-persistently stored
      (used only during the calculation process like input from other
      systems, intermediate results, external outputs) their definition
      can be non-persistent;

   -  Because the definition of the algorithms of the calculations is
      based on the definition of their input artefacts (in particular on
      the data structure of the input data), the latter must be
      available when the calculation is defined;

   -  The VTL is designed to make the data structure of the output of a
      calculation deducible from the calculation algorithm and from the
      data structure of the operands (this feature ensures that the
      calculated data can be defined according to the IM and can be used
      as operands of further calculations);

   -  In the IT implementation, it is advisable to automate (as much as
      possible) the structural definition of the output of a
      calculation, in order to enforce the consistency of the
      definitions and avoid unnecessary overheads for the definers.

-  The VTL and its information model make it possible to check
   automatically the overall consistency of the definitions of the
   calculations, including with respect to the artefact of the IM, and
   in particular to check:

   -  the correctness of the expressions with respect to the syntax of
      the language

   -  the integrity of the expressions with respect to their input and
      output artefacts and the corresponding structures and properties
      (for example, the input artefacts must exist, their structure
      components referenced in the expression must exist, qualitative
      data cannot be manipulated through quantitative operators, and so
      on)

   -  the consistency of the overall graph of the calculations (for
      example, in order to avoid that the result of a calculation goes
      as input to the same calculation, there should not be cycles in
      the sequence of calculations, thus eliminating the risk of
      producing unpredictable and erroneous results).

Independence of IT implementation 
----------------------------------

-  According to the “user orientation” above, the language is designed
   so that users are not required to be aware of the IT solution;

   -  To use the language, the users need to know only the abstract view
      of the data and calculations and do not need to know the aspects
      of the IT implementation, like the storage structures, the
      calculation tools and so on.

-  The language is not oriented to a specific IT implementation and
   permits many possible different implementations (this property is
   particularly important in order to allow different institutions to
   rely on different IT environments and solutions);

   -  The VTL provides only for a logical/conceptual layer for defining
      the data transformations, which applies on a logical/conceptual
      layer of data definitions

   -  The VTL does not prescribe any technical/physical tool or
      solution, so that it is possible to implement the VTL by using
      many different IT tools

   -  The link between the logical/conceptual layer of the VTL
      definitions and the IT implementation layer is out of the scope of
      the VTL;

-  The language does not require to the users the awareness of the
   storage data structure; the operations on the data are specified
   according to the conceptual/logical structure, and so are independent
   of the storage structure; this ensures that the storage structure may
   change without necessarily affecting the conceptual structure and the
   user expressions;

   -  Data having the same conceptual/logical structure may be accessed
      using the same statements, even if they have different IT
      structures;

   -  The VTL provides commands for data storage and retrieval at a
      conceptual/logical level; the mapping and the conversion between
      the conceptual and the storage structures of the data is left to
      the IT implementation (and users need not be aware of it);

   -  By mapping the logical and the storage data structures, the IT
      implementations can make it possible to store/retrieve data
      in/from different IT data stores (e.g. relational databases,
      dimensional databases, xml files, spread-sheets, traditional
      files);

-  The language is not strictly connected with some specific IT tool to
   perform the calculations (e.g. SQL, statistical packages, other languages,
   XML tools...);

   -  The syntax of the VTL is independent of existing IT calculation
      tools;

   -  On the IT level, this may require a translation from the VTL to
      the language of the IT tool to be used for the calculation;

   -  By implementing the proper translations at the IT level, different
      institutions can use different IT tools to execute the same
      algorithms; moreover, it is possible for the same institution to
      use different IT tools within an integrated solution (e.g. to
      exploit different abilities of different tools);

   -  VTL instructions do not change if the IT solution changes (for
      example following the adoption of another IT tool), so avoiding
      impacts on users as much as possible.

Extensibility, customizability
------------------------------

-  The language is made of few “core” constructs, which are the
   fundamental building blocks into which any operation can be
   decomposed, and a “standard library”, which contains a number of
   standard operators built from the core constructs; these are the
   standard parts of the language, which can be extended gradually by
   the VTL maintenance body, enriching the available operators according
   to the evolution of the business needs, so progressively making the
   language more powerful;

-  Other organizations can define additional operators having a
   customized behaviour and a functional syntax, so extending their own
   library by means of custom-designed operators. As obvious, these
   additional operators are not part of the standard VTL library. To
   exchange VTL definitions with other institutions, the possible custom
   libraries need to be pre-emptively shared.

-  In addition, it is possible to call external routines of other
   languages/tools, provided that they are compatible with the IM; this
   requisite is aimed to fulfil specific calculation needs without
   modifying the operators of the language, so exploiting the power of
   the other languages/tools if necessary for specific purposes. In this
   case:

   -  The external routines should be compatible with, and relate back
      to, the conceptual IM of the calculations as for its inputs and
      outputs, so that the integrity of the definitions is ensured

   -  The external routines are not part of the language, so their use
      is subject to some limitations (e.g. it is impossible to parse
      them as if they were operators of the language)

   -  The use of external routines compromises the IT implementation
      independence, the abstraction and the user orientation. Therefore
      external routines should be used only for specific needs and in
      limited cases, whereas widespread and generic needs should be
      fulfilled through the operators of the language;

-  Whilst an Organisation adopting VTL can extend it by defining
   customized parts, on its own total responsibility, in order to
   improve the standard language for specific purposes (e.g. for
   supporting possible algorithms not permitted by the standard part),
   it is important that the customized parts remain compliant with the
   VTL IM and the VTL fundamentals. Adopting Organizations are totally
   in charge of any activity for maintaining and sharing their
   customized parts. Adopting Organizations are also totally in charge
   of any possible maintenance activity to maintain the compliance
   between their customized parts and the possible VTL future versions.

Language effectiveness
----------------------

-  The language is oriented to give full support to the various
   typologies of data of a statistical environment (for example
   dimensional data, survey data, registers data, micro and macro,
   quantitative and qualitative, …) described as much as possible in a
   coherent way, by means of common IM artefacts for their common
   aspects, and relying on mathematical notions, as mentioned above. The
   various types of statistical data are considered as mathematical
   functions, having independent variables (Identifiers) and dependent
   variables (Measures, Attributes [2]_), whose extensions can be
   thought as logical tables (DataSets) made of rows (Data Points) and
   columns (Identifiers, Measures, Attributes).

-  The language supports operations on the Data Sets (i.e. mathematical
   functions) in order to calculate new Data Sets from the existing
   ones, on their structure components (Identifiers, Measures,
   Attributes), on their Data Points.

-  The algorithms are specified by means of mathematical expressions
   which compose the operands (Data Sets, Components …) by means of
   operators (e.g. +,-,\*,/,>,<) to obtain a certain result (Data Sets,
   Components …);

-  The validation is considered as a kind of calculation having as an
   operand the Data Sets to be validated and producing a Data Set
   containing information about the result of the validation;

-  Calculations on multiple measures are supported by most operators, as
   well as calculations on the attributes of the Data Sets and
   calculations involving missing values;

-  The operations are intended to be consistent with the real world
   historical changes which induce changes of the artefacts (e.g. of the
   code lists, of the hierarchies …); however, because different
   standards may represent historical changes in different ways, the
   implementation of this aspect is left to the standards (e.g. SDMX,
   DDI …), to the institutions and to the implementers adopting the VTL
   and therefore the VTL specifications does not prescribe any
   particular methodology for representing the historical changes of the
   artefacts (e.g. versioning, qualification of time validity);

-  Almost all the VTL operators can be nested, meaning that in the
   invocation of an operator any operand can be the result of the
   invocation of other operators which calculate it;

-  The results of the calculations can be permanently stored or not,
   according to the needs.

.. [1]
   See the section “Relationships between VTL and GSIM”

.. [2]
   The Measures bear information about the real world and the Attributes
   about the Data Set or some part of it.
