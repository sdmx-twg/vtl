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
     - the type of the artefact returned by the operator
   * - operatorBody
     - the expression which defines the operation
   * - parameterName
     - the name of the parameter
   * - parameterType
     - the type of the parameter
   * - parameterDefaultValue
     - the default value for the parameter (optional)

Input parameters type
---------------------

operator_name::
   
   name

outputType::

   A VTL type. The output of a user defined operator may be scalar (represented by its data type) or dataset. 
   If the output is a scalar type, the user defined operator can also be used at component level.

   The set of possible output types is: dataset, string, number, integer, time, date, time_period, duration, boolean.

operatorBody::
   
   a VTL expression having the parameters (i.e., parameterName) as the operands

parameterName::
   
    name

parameterType::
   
   A VTL data type. The input of a user defined operator may be scalar (represented by its data type)or dataset. 
   If the input is a scalar type, the user defined operator can also be used at component level.

   The set of possible input types is: dataset, string, number, integer, time, date, time_period, duration, boolean.

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
   expression is derived
*  If parameterDefaultValue is specified then the parameter is optional
*  For parameters that have a scalar input type, components may be used as input parameters.
*  If the output type is a scalar type, the user defined operator can also be used at component level.


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
