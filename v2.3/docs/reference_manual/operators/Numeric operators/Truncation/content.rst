------
Syntax
------

    **trunc (** op , *numDigit* **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - numDigit
     - the number of position from which to trunc

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    trunc ( DS_1 ,  2 )
    trunc ( DS_2 )
    trunc ( 3.14159 ,  2 )
    trunc ( 3.14159 ,  _ )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **trunc** truncates the operand to a number of positions at the right of the decimal point equal to the
*numDigit* parameter. The decimal point is assumed to be at position 0. If *numDigit* is negative, the truncation
happens at the left of the decimal point. The truncation operation leaves the *numDigit* position unchanged. All
the positions greater than *numDigit* are eliminated. The basic scalar type of the result is *integer* if *numDigit* is
omitted, *number* otherwise.
For example:

| ``trunc ( 3.14159, 2 )`` gives ``3.14``
| ``trunc ( 3.14159, 4 )`` gives ``3.1415``
| ``trunc ( 12345.6, 0 )`` gives ``12345.0``
| ``trunc ( 12345.6 )`` gives ``12345``
| ``trunc ( 12345.6, _ )`` gives ``12345``
| ``trunc( 12345.6, -1 )`` gives ``12340.0``

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
Value or Data Set or Data Set Component”, as for the invocations at Component or Scalar level, the operator has
the behaviour of the “Operators applicable on two Scalar Values or Data Sets or Data Set Components”, (see the
section “Typical behaviours of the ML Operators”).
