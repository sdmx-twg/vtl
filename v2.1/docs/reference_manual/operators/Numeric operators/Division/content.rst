------
Syntax
------

    op1 **/** op2

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
        
    DS_1 / DS_2
    3 / 5

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator addition divides two numbers.
For example: 
| ``3 / 5``  gives ``0.6``

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

The operator has the behaviour of the "Operators applicable on two Scalar Values or Data Sets or Data Set Components" 
(see the section "Typical behaviours of the ML Operators"). According to the general rules about data types, 
the operator can be applied also on sub-types of *number*, that is the type *integer*. The result has type *number*.

If *op2* is 0 then the operation generates a run-time error.
