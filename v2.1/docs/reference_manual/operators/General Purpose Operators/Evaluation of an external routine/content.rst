------
Syntax
------

    **eval (** externalRoutineName **(** { argument } { , argument }* **)** language languageName **returns** outputType **)**

----------------
Input parameters
----------------
.. list-table::

   * - externalRoutineName
     - the name of an external routine
   * - argument
     - the arguments passed to the external routine
   * - language
     - the implementation language of the routine
   * - outputType
     - | the data type of the object returned by eval
       | (see outputParameterType in Data type syntax)

------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block::

  eval(routine1(DS_1) language “PL/SQL” returns string)


------------------------------------
Semantics  for scalar operations
------------------------------------
This is not a scalar operation.

-----------------------------
Input parameters type
-----------------------------
externalRoutineName ::

    name

argument ::

    any data type

language ::

    string

outputType ::

    any data type restricting Data Set or scalar

-----------------------------
Result type
-----------------------------
result :: 

    dataset

-----------------------------
Additional Constraints
-----------------------------

* The **eval** is the only VTL Operator that does not allow nesting and therefore a Transformation can contain just
  one invocation of **eval** and no other invocations. In other words, **eval** cannot be nested as the operand
  of another operation as well as another operator cannot be nested as an operand of **eval**
* The result of an expression containing **eval** must be persistent
* `externalRoutineName` is the conventional name of a non-VTL routine
* The invoked external routine must be consistent with the VTL principles, first of all its behaviour must be functional,
  so having in input and providing in output first-order functions
* argument is an argument passed to the external routine, it can be a name or a value of a VTL artefacts or
  some other parameter required by the routine
* The arguments passed to the routine correspond to the parameters of the invoked external routine in positional order;
  as usual the optional parameters are substituted by the underscore if missing.
  The conversion of the VTL input/output data types from and to the external routine processor is left to the implementation.

---------
Behaviour
---------

The **eval** operator invokes an external, non-VTL routine, and returns its result as a Data Set or a scalar.
The specific data type can be given in the invocation.
The routine specified in the **eval** operator can perform any internal logic.
