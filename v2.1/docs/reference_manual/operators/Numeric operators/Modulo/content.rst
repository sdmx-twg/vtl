------
Syntax
------

    **mod (** op1 , op2 **)**

----------------
Input parameters
----------------
.. list-table::

   * - op1
     - the dividend
   * - op2
     - the divisor

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    mod( DS_1, DS_2 )
    mod ( DS_1, 5 )
    mod ( 5, DS_2 )
    mod ( 5, 2 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **mod** returns the remainder of *op1* divided by *op2*. It returns *op1* if divisor *op2* is 0.
For example: 
| ``mod ( 5, 2 )`` gives ``1``
| ``mod ( 5, -2 )`` gives ``-1``
| ``mod ( 8, 2 )`` gives ``0``
| ``mod ( 9, 0 )`` gives ``9``

-----------------------------
Input parameters type
-----------------------------
op1, op2 :: 

    dataset { measure<number> _+ }
    | component<number>
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

--------
Behavior
--------

The operator has the behaviour of the “Operators applicable on two Scalar Values or Data Sets or Data Set Components”
(see the section “Typical behaviours of the ML Operators”).

According to the general rules about data types, the operator can be applied also on sub-types of *number*, that is the type *integer*.
If the type of both operands is *integer* then the result has type *integer*. If one of the operands is of type *number*,
then the other operand is implicitly cast to *number* and therefore the result has type *number*.
