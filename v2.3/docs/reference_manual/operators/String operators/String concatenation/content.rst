------
Syntax
------

    op1 **||** op2

----------------
Input parameters
----------------
.. list-table::

   * - op1, op2
     - the operands

------------------------------------
Semantics  for scalar operations
------------------------------------
Concatenates two strings.
For example, ``"Hello" || ", World"``  gives ``"Hello, World"``.

-----------------------------
Input parameters type
-----------------------------
op1, op2 ::

    dataset { measure<string> _+ }
    | component<string>
    | string

-----------------------------
Result type
-----------------------------
result :: 

    dataset { measure<string> _+ }
    | component<string>
    | string

-----------------------------
Additional Constraints
-----------------------------
None.

--------
Behavior
--------

The operator has the behaviour of the "Operators applicable on two Scalar Values or Data Sets or Data Set Components"
(see the section "Typical behaviours of the ML Operators").