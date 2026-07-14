#########################################
VTL-DL – User Defined Operators 
#########################################

---------------
define operator
---------------

Syntax
------

**define operator** operator_name **(** { parameter_ { **,** parameter_ }\* } **)
|    **\ {**returns** outputType } **is** operatorBody
| **end define operator**

.. _parameter:

*parameter*::= parameterName parameterType { **default** parameterDefaultValue }


Syntax description
------------------

.. list-table:: 

   * - operator_name
     - the name of the operator
   * - parameter
     - the names of parameters, their data types and defaultvalues
   * - outputType
     - the data type of the artefact returned by the operator
   * - operatorBody
     - the expression which defines the operation
   * - parameterName
     - the name of the parameter
   * - parameterType
     - the data type of the parameter
   * - parameterDefaultValue
     - the default value for the parameter (optional)

Input parameters type
---------------------

operator_name::
   
   name

outputType::

   a VTL data type (see the Data Type Syntax below)

operatorBody::
   
   a VTL expression having the parameters (i.e., parameterName) as the operands

parameterName::
   
    name

parameterType::
   
   a VTL data type (see the Data Type Syntax below)

parameterDefaultValue::
   
   a Value of the same type as the parameter


Constraints
-----------

*  Each parameterName must be unique within the list of parameters
*  parameterDefaultValue must be of the same data type as the
   corresponding parameter
*  if outputType is specified then the type of operatorBody must be
   compatible with outputType
*  If outputType is omitted then the type returned by the operatorBody
   expression is assumed
*  If parameterDefaultValue is specified then the parameter is optional


Semantic specification
----------------------

This operator defines a user-defined Operator by means of a VTL
expression, specifying also the parameters, their data types, whether
they are mandatory or optional and their (possible) default values.

Examples
--------

*Example 1:*
::

   define operator max1 (x integer, y integer)
      returns boolean is

         if x > y then x else y

   end operator

*Example 2:*

::

   define operator add (x integer default 0, y integer default 0)
      returns number is

         x+y
   end operator

----------------
Data type syntax
----------------

The VTL data types are described in the VTL User Manual. Types are used
throughout this Reference Manual as both meta-syntax and syntax.

They are used as meta-syntax in order to define the types of input and
output parameters in the descriptions of VTL operators; they are used in
the syntax, and thus are proper part of the VTL, in order to allow other
operators to refer to specific data types. For example, when defining a
custom operator (see the **define operator** above), one will need to
declare the type of the input/output parameters.

The syntax of the data types is described below (as for the meaning of
these definitions, see the section VTL Data Types in the User Manual).
See also the section “Conventions for describing the operators’ syntax”
in the chapter “Overview of the language and conventions” above.

dataType ::= scalarType_ | scalarSetType_ | componentType_ | datasetType_ | operatorType_ | rulesetType_

.. _scalarType:

scalarType ::= { basicScalarType_| valueDomainName | setName }\ :sup:`1` { scalarTypeConstraint_ } **{ { not } null }**

.. _basicScalarType:

basicScalarType ::= **scalar** | **number** | **integer** | **string** | **boolean** | **time** | **date** | **time_period** | **duration**

.. _scalarTypeConstraint:

scalarTypeConstraint ::= **[** valueBooleanCondition **]**\| **{** scalarLiteral { , scalarLiteral }\* **}**

.. _scalarSetType:

scalarSetType ::= **set** { **<** scalarType_ **>** }

.. _componentType:

componentType ::= componentRole_ { **<** scalarType_ **>** }

.. _componentRole:

componentRole ::= **component** | **identifier** | **measure** | **attribute** | **viral attribute**

.. _datasetType:

datasetType ::= **dataset** { **{** componentConstraint_ { **,** componentConstraint_  }\ :sup:`\*` **}** }

.. _componentConstraint:

componentConstraint ::= componentType_ { componentName | multiplicityModifier_ }\ :sup:`1`

.. _multiplicityModifier:

multiplicityModifier ::= **\_** { **+** | **\*** }

.. _operatorType:

operatorType ::= inputParameterType_ { \* inputParameterType_ }\* } -> outputParameterType_

.. _inputParameterType:

inputParameterType ::= scalarType_ | scalarSetType_ | componentType_ | datasetType_ | rulesetType_

.. _outputParameterType:

outputParameterType ::= scalarType_ | componentType_ | datasetType_

.. _rulesetType:

rulesetType ::= { **ruleset** | dpRuleset_ | hrRuleset_}\ :sup:`1`

.. _dpRuleset:

dpRuleset ::= **datapoint** |
            | **datapoint_on_valuedomains { (** name { **\*** name }\ :sup:`\*` **) }** |
            | **datapoint_on_variables { (** name { **\*** name }\ :sup:`\*` **) }**

.. _hrRuleset:

hrRuleset ::= **hierarchical** | 
            | **hierarchical_on_valuedomains** **{** valueDomainName **{ (** condValueDomainName { \* condValueDomainName **}\* ) } } }** \|
            | **hierarchical_on_variables {** variableName  **{ (** condValueDomainName { \* condValueDomainName **}\* ) } } }**

Note that the valueBooleanCondition in scalarTypeConstraint is expressed
with reference to the fictitious variable “value” (see also the User
Manual, section “Conventions for describing the Scalar Types”), which
represents the generic value of the scalar type, for example:

integer { 0, 1 } means an integer number whose value is 0 or 1

   number [ value >= 0 ] means a number greater or equal than 0

   string { "A", "B", "C" } means a string whose value is A, B or C

   string [ length (value) <= 6 ] means a string whose length is lower
   or equal than 6

General examples of the syntax for defining types can be found in the
User Manual, section VTL Data Types and in the declaration of the data
types of the VTL operators (sub-sections “input parameters type” and
“result type”).
