------
Syntax
------

    **round (** op , *numDigit* **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - numDigit
     - the number of positions to round to

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    round ( DS_1 ,  2 )
    round ( DS_2 )
    round ( 3.14159 ,  2 )
    round ( 3.14159 ,  _ )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **round** rounds the operand to a number of positions at the right of the decimal point equal to the
*numDigit* parameter. The decimal point is assumed to be at position 0. If *numDigit* is negative, the rounding
happens at the left of the decimal point. The rounding operation leaves the *numDigit* position unchanged if the
*numDigit*+1 position is between 0 and 4, otherwise it adds 1 to the number that is in the *numDigit* position. All
the positions greater than *numDigit* are set to 0. The basic scalar type of the result is *integer* if *numDigit* is
omitted, *number* otherwise.
For example:

| ``round ( 3.14159, 2 )`` gives ``3.14``
| ``round ( 3.14159, 4 )`` gives ``3.1416``
| ``round ( 12345.6, 0 )`` gives ``12346.0``
| ``round ( 12345.6 )`` gives ``12346``
| ``round ( 12345.6, _ )`` gives ``12346``
| ``round ( 12345.6, -1 )`` gives ``12350.0``

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { measure<number> _+ }
    | component<number>
    | number

numDigit ::

    component<integer>
    | integer

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
