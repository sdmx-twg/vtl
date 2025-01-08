------
Syntax
------

    **exp (** op **)**

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

    exp ( DS_1 )
    exp ( 5 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **exp** returns *e* (base of the natural logarithm) raised to the *op*-th power.
For example:

| ``exp ( 5 )`` gives ``148.41315...``
| ``exp ( 1 )`` gives ``2.71828...`` (the number *e*)
| ``exp ( 0 )`` gives ``1.0``
| ``exp ( -1 )`` gives ``0.36787...`` (the number *1/e*)

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

    dataset { measure<number[value > 0]> _+ }
    | component<number [value > 0]>
    | number[value > 0]

-----------------------------
Additional Constraints
-----------------------------
None.

--------
Behavior
--------

The operator has the behaviour of the “Operators applicable on one Scalar Value or Data Set or Data Set
Component” (see the section “Typical behaviours of the ML Operators”).
