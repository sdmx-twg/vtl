------
Syntax
------

    **nvl (** op1 , op2 **)**

----------------
Input parameters
----------------
.. list-table::

   * - op1
     - the first operand
   * - op2
     - the second operand

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    nvl ( ds1#m1, 0 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator *nvl* returns *op2* when *op1* is **null**, otherwise *op1*.

For example: ::

    nvl ( 5, 0 ) returns 5
    nvl ( null, 0 ) returns 0

-----------------------------
Input parameters type
-----------------------------
op1 ::

    dataset
    | component
    | scalar

op2 ::

    dataset
    | component
    | scalar

-----------------------------
Result type
-----------------------------
result ::

    dataset
    | component
    | scalar

-----------------------------
Additional Constraints
-----------------------------
If *op1* and *op2* are scalar values then they must be of the same type.

If *op1* and *op2* are Components then they must be of the same type.

If *op1* and *op2* are Data Sets then they must have the same Components.

---------
Behaviour
---------

The operator **nvl** returns the value from *op2* when the value from *op1* is null, otherwise it returns the value from *op1*.

The operator has the typical behaviour of the operators applicable on two scalar values or Data Sets or Data Set Components.

Also the following statement gives the same result: *if isnull ( op1 ) then op2 else op1*.

