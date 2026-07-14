------
Syntax
------

    operatorName **(** { argument { , argument }* } **)**

----------------
Input parameters
----------------
.. list-table::

   * - operatorName
     - the name of an existing user-defined operator
   * - argument
     - argument passed to the operator

------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block::
    
    max1 ( 2, 3 )
        
------------------------------------
Semantics  for scalar operations
------------------------------------
It depends on the specific user-defined operator that is invoked. 

-----------------------------
Input parameters type
-----------------------------
operatorName ::

    name

argument ::

    A data type compatible with the type of the parameter of the user-defined operator
    that is invoked (see also the “Type syntax” section).

-----------------------------
Result type
-----------------------------
result ::

    The data type of the result of the user-defined operator that is invoked
    (see also the “Type syntax” section).

-----------------------------
Additional Constraints
-----------------------------

* *operatorName* must refer to an operator created with the **define operator** statement.
* The type of each argument value must be compliant with the type of the corresponding parameter of
  the user defined operator (the correspondence is in the positional order).

---------
Behaviour
---------

The invoked user-defined operator is evaluated. The arguments passed to the operator in the invocation are associated to
the corresponding parameters in positional order, the first argument as the value of the first parameter,
the second argument as the value of the second parameter, and so on.
An underscore (“_”) can be used to denote that the value for an optional operand is omitted.
One or more optional operands in the last positions can be simply omitted.