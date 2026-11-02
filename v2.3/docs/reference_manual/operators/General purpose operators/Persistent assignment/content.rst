------
Syntax
------
 
    re **<-** op

----------------
Input parameters
----------------
.. list-table::

   * - re
     - the result
   * - right
     - | the operand. According to the general VTL rule allowing the indentation of the operators,
       | op can be obtained through an expression as complex as needed
       | (for example op can be the expression DS_1 - DS_2).

------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block::

  DS_r <- DS_1
  DS_r <- DS_1 - DS_2

------------------------------------
Semantics  for scalar operations
------------------------------------
Empty

-----------------------------
Input parameters type
-----------------------------

op ::

	dataset

-----------------------------
Result type
-----------------------------
result ::
      
    dataset

-----------------------------
Additional Constraints
-----------------------------
The assignment cannot be used at Component level because the result of a Transformation cannot be a Data Set Component.
When operations at Component level are invoked, the result is the Data Set which the output Components belongs to.

---------
Behaviour
---------

The input operand `op` is assigned to the **persistent** result `re`, which assumes the same value as `op`.
As mentioned, the operand `op` can be obtained through an expression as complex as needed
(for example `op` can be the expression ``DS_1 - DS_2``).

The result `re` is a persistent Data Set that has the same data structure as the Operand.
For example in ``DS_r <- DS_1`` the data structure of ``DS_r`` is the same as the one of ``DS_1``.

If the Operand `op` is a scalar value, the result Data Set has no Components and contains only such a scalar value.
For example, ``income <- 3`` assigns the value ``3`` to the persistent Data Set named income.
