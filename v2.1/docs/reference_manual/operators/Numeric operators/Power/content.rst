------
Syntax
------

    **power (** base **,** exponent **)**

----------------
Input parameters
----------------
.. list-table::

   * - base
     - the operand
   * - exponent
     - the exponent of the power

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    power ( DS_1, 2 )
    power ( 5, 2 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **power** raises a number (the *base*) to another one (the *exponent*).
For example:

| ``power ( 5, 2 )`` gives ``25``
| ``power ( 5, 1 )`` gives ``5``
| ``power ( 5, 0 )`` gives ``1``
| ``power ( 5, -1 )`` gives ``0.2``
| ``power ( -5, 3 )`` gives ``-125``

-----------------------------
Input parameters type
-----------------------------
base ::

    dataset { measure<number> _+ }
    | component<number>
    | number

exponent ::

    component<number>
    | number

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

---------
Behaviour
---------

As for the invocations at Data Set level, the operator has the behaviour of the “Operators applicable on one Scalar
Value or Data Set or Data Set Component”. As for the invocations at Component or Scalar level, the operator has
the behaviour of the “Operators applicable on two Scalar Values or Data Sets or Data Set Components”, (see the
section “Typical behaviours of the ML Operators”).
