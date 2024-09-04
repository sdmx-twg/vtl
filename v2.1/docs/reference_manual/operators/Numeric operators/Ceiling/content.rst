------
Syntax
------

    **ceil (** op **)**

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

    ceil ( DS_1 )
    ceil ( 3.14159 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **ceil** returns the smallest integer greater than or equal to *op*.
For example:

| ``ceil( 3.14159 )`` gives ``4``
| ``ceil( 15 )`` gives ``15``
| ``ceil( -3.1415 )`` gives ``-3``
| ``ceil( -0.1415 )`` gives ``0``

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { measure<number> _+ }
    | component<number>
    | number

-----------------------------
Result type
-----------------------------
result :: 

    dataset { measure<integer> _+ }
    | component<integer>
    | integer

-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The operator has the behaviour of the “Operators applicable on one Scalar Value or Data Set or Data Set
Component” (see the section “Typical behaviours of the ML Operators”).
