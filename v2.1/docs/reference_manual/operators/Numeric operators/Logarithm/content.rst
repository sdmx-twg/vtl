------
Syntax
------

    **log (** op **,** num **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the base of the logarithm
   * - num
     - the number to which the logarithm is applied

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    log ( DS_1, 2 )
    log ( 1024, 2 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **log** calculates the logarithm of *num* base *op*.
For example:

| ``log ( 1024, 2 )`` gives ``10``
| ``log ( 1024, 10 )`` gives ``3.01``

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { measure<number [value > 1] > _+ }
    | component<number [value > 1] >
    | number [value > 1]

num ::

    component<integer [value > 0]>
    | integer [value > 0]

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<number> _+ }
    | component<number>
    | number

-----------------------------
Additional Constraints
-----------------------------
None.

--------
Behavior
--------

As for the invocations at Data Set level, the operator has the behaviour of the “Operators applicable on one Scalar
Value or Data Set or Data Set Component”. As for the invocations at Component or Scalar level, the operator has
the behaviour of the “Operators applicable on two Scalar Values or Data Sets or Data Set Components”, (see the
section “Typical behaviours of the ML Operators”).
