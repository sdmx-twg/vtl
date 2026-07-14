------
Syntax
------

    **floor (** op **)**

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

    floor ( DS_1 )
    floor ( 3.14159 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **floor** returns the greatest integer which is smaller than or equal to *op*.
For example:

| ``floor( 3.1415 )`` gives ``3``
| ``floor( 15 )`` gives ``15``
| ``floor( -3.1415 )`` gives ``-4``
| ``floor( -0.1415 )`` gives ``-1``

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
