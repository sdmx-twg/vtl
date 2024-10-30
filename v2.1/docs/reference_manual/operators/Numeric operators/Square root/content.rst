------
Syntax
------

    **sqrt (** op **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    sqrt ( DS_1 )
    sqrt ( 5 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **sqrt** calculates the square root of a number.
For example:

| ``sqrt ( 25 )`` gives ``5``

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { measure<number [value >= 0] > _+ }
    | component<number [value >= 0] >
    | number [value >= 0]

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<number [value >= 0] > _+ }
    | component<number [value >= 0] >
    | number [value >= 0]

-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The operator has the behaviour of the “Operators applicable on one Scalar Value or Data Set or Data Set
Component” (see the section “Typical behaviours of the ML Operators”). Some valid examples could be: **sqrt ( DS_1 )**, **sqrt ( 5 )**.
