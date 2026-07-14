------
Syntax
------

    **+** op

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

    + DS_1
    + 3

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **+** returns the operand unchanged. For example: 

| ``+3`` gives ``3``
| ``+(-5)`` gives ``-5``

-----------------------------
Input parameters type
-----------------------------
op: :: 

    dataset { measure<number> _+ }
    | component<number>
    | number

-----------------------------
Result type
-----------------------------
result: :: 

    dataset { measure<number> _+ }
    | component<number>
    | number

-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The operator has the behaviour of the "Operators applicable on one Scalar Value or Data Set or Data Set
Component" (see the section "Typical behaviours of the ML Operators").
According to the general rules about data types, the operator can be applied also on sub-types of *number*,
that is the type *integer*. If the type of the operand is *integer* then the result has type *integer*. If the
type of the operand is *number* then the result has type *number*.
