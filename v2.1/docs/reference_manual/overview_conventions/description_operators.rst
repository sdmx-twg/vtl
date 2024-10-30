Description of VTL Operators
============================

The structure used for the description of the VTL-DL Operators is made
of the following parts:

*  **Operator name**, which is also used to invoke the operator
*  **Semantics:** a brief description of the purpose of the operator
*  **Syntax:** the syntax of the Operator (this part follows the
   conventions described in the previous section “Conventions for
   describing the operators’ syntax”)
*  **Syntax description:** detailed explanation of the meaning of the
   various parts of the syntax
*  **Parameters:** list of the input parameters and their types
*  **Constraints**: additional constraints that are not specified with
   the meta-syntax and need a textual explanation
*  **Semantic specifications**: detailed description of the semantics of
   the operator
*  **Examples**: examples of invocation of the operator

The structure used for the description of the VTL-ML Operators is made
of the following parts:

*  **Operator name**, followed by the **operator symbol** (keyword)
   which is used to invoke the operator
*  **Syntax:** the syntax of the Operator (this part follows the
   conventions described in the previous section “Conventions for
   describing the operators’ syntax”)
*  **Input parameters:** list of all input parameters and the
   subexpressions with their meaning and the indication if they are
   mandatory or optional
*  **Examples of valid syntaxes:** examples of syntactically valid
   invocations of the Operator
*  **Semantics for scalar operations**: the behaviour of the Operator on
   scalar operands, which is the basic behaviour of the Operator
*  **Input parameters type**: the formal description of the type of the
   input parameters (this part follows the conventions described in the
   previous section “Description of the data types of operands and
   results”)
*  **Result type:** the formal description of the type of the result
   (this part follows the conventions described in the previous section
   “Description of the data types of operands and results”)
*  **Additional constraints**: additional constraints that are not
   specified with the meta-syntax and need a textual explanation,
   including both possible semantic constraints under which the
   operation is possible or impossible, and syntactical constraint for
   the invocation of the Operator
*  **Behaviour**: description of the behaviour of the Operator for
   non-scalar operations (for example operations at Data Set or at
   Component level). When the Operator belongs to a class of Operators
   having a common behaviour, the common behaviour is described once for
   all in a section of the chapter “Typical behaviours of the ML
   Operators” and therefore this part describes only the specific aspect
   of the behaviour and contains a reference to the section where the
   common part of the behaviour is described.
*  **Examples**: a series of examples of invocation and application of
   the operator in case of operations at Data Sets or at Component
   level.