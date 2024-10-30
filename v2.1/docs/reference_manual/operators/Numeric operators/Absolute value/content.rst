------
Syntax
------

    **abs (** op **)**

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

    abs ( DS_1 )
    abs ( -5 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **abs** calculates the absolute value of a number.
For example: 

| ``abs ( -5.49 )`` gives ``5.49``
| ``abs ( 5.49 )`` gives ``5.49``

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

    dataset { measure<number [ value >= 0 ]> _+ }
    | component<number [ value >= 0 ]>
    | number [ value >= 0 ]

-----------------------------
Additional Constraints
-----------------------------
None.

--------
Behavior
--------

The operator has the behaviour of the “Operators applicable on one Scalar Value or Data Set or Data Set
Component” (see the section “Typical behaviours of the ML Operators”).
