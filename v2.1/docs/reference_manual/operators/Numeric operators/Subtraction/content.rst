------
Syntax
------

    op1 **-** op2

----------------
Input parameters
----------------
.. list-table::

   * - op1
     - the minuend
   * - op2
     - the subtrahend

------------------------------------
Examples of valid syntaxes
------------------------------------
::
    
    DS_1 - DS_2
    3 - 5

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator subtraction returns the difference of two numbers. 
For example:

| ``3 - 5`` gives ``-2``

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

---------
Behaviour
---------
The operator has the behaviour of the "Operators applicable on two Scalar Values or Data Sets or Data Set Components" 
(see the section "Typical behaviours of the ML Operators"). 
According to the general rules about data types, the operator can be applied also on sub-types of *number*,
that is the type *integer*. If the type of both operands is *integer* then the result has type *integer*.
If one of the operands is of type *number*, then the other operand is implicitly cast to *number* and therefore
the result has type *number*.
