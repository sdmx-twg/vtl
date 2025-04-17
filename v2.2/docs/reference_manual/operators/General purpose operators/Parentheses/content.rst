------
Syntax
------

    **(** op **)**

----------------
Input parameters
----------------
.. list-table::

   * - op 
     - | the operand to be evaluated before performing other operations written outside the parentheses. 
       | According to the general VTL rule, operators can be nested, therefore any Data Set, 
       | Component or scalar op can be obtained through an expression as complex as needed 
       | (for example op can be written as the expression 2 + 3 ).

------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block::

  ( DS_1 + DS_2 )
  ( CMP_1 - CMP_2 )
  ( 2 + DS_1 )
  ( DS_2 - 3 * DS_3 )

------------------------------------
Semantics  for scalar operations
------------------------------------
Parentheses override the default evaluation order of the operators that are described in the section "VTL-ML - Evaluation order of the Operators". 
The operations enclosed in the parentheses are evaluated first. 
For example ``(2+3)*4`` returns ``20``, instead ``2+3*4`` returns ``14`` because the multiplication has higher precedence than the addition.

-----------------------------
Input parameters type
-----------------------------
op :: 

	dataset 
	| component
	| scalar

-----------------------------
Result type
-----------------------------
result :: 
	
	dataset 
	| component
	| scalar

-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

As mentioned, the `op` of the parentheses can be obtained through an expression as complex as needed (for example `op` can be written as ``DS_1 - DS_2``). 
The part of the expression inside the parentheses is evaluated before the part outside of the parentheses.
If more parentheses are nested, the inner parentheses are evaluated first, for example ``( 20 - 10 / (2 + 3) ) * 3`` would give ``54``.
