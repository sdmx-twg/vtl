------
Syntax
------

    re **:=** op

----------------
Input parameters
----------------
.. list-table::

   * - re
     - the result
   * - right
     - | the operand. According to the general VTL rule allowing the indentation of the operators,
       | `op` can be obtained through an expression as complex as needed
       | (for example `op` can be the expression ``DS_1 - DS_2``).

------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block::

  DS_r := DS_1
  DS_r := 3
  DS_r := DS_1 - DS_2
  DS_r := 3 + 2

------------------------------------
Semantics  for scalar operations
------------------------------------
Empty

-----------------------------
Input parameters type
-----------------------------
op ::

	dataset
	| scalar

-----------------------------
Result type
-----------------------------
re ::

	dataset

-----------------------------
Additional Constraints
-----------------------------
The assignment cannot be used at Component level because the result of a Transformation cannot be a Data Set Component.
When operations at Component level are invoked, the result is the Data Set which the output Components belongs to.

The same symbol denoting the non-persistent assignment Operator (**:=**) is also used inside other operations at
Component level (for example in **calc** and **aggr**) in order to assign the result of the operation to the output Component:
please note that in these cases the symbol **:=** does not denote the non-persistent assignment (i.e., this Operator),
which cannot operate at Component level, but a special keyword of the syntax of the other Operator in which it is used.

---------
Behaviour
---------

The value of the operand `op` is assigned to the result `re`, which is non-persistent and therefore is not stored.
As mentioned, the operand `op` can be obtained through an expression as complex as needed
(for example op can be the expression ``DS_1 - DS_2``).

The result re is a non-persistent Data Set that has the same data structure as the Operand. For example in ``DS_r := DS_1``
the data structure of ``DS_r`` is the same as the one of ``DS_1``.

If the Operand `op` is a scalar value, the result Data Set has no Components and contains only such a scalar value.
For example, ``income := 3`` assigns the value ``3`` to the non-persistent Data Set named `income`.
