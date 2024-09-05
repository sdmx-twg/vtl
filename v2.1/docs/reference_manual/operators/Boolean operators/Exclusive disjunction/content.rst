------
Syntax
------

    op1 **xor** op2

----------------
Input parameters
----------------
.. list-table::

   * - op1
     - the first operand
   * - op2
     - the second operand

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    DS_1 xor DS_2

------------------------------------
Semantics  for scalar operations
------------------------------------
The **xor** operator returns TRUE if only one of the operand is TRUE (but not both), FALSE otherwise.
The two operands must be of *boolean* type.
For example:
| ``FALSE xor FALSE`` gives ``FALSE``
| ``FALSE xor TRUE`` gives ``TRUE``
| ``FALSE xor NULL`` gives ``NULL``
| ``TRUE xor FALSE`` gives ``TRUE``
| ``TRUE xor TRUE`` gives ``FALSE``
| ``TRUE xor NULL`` gives ``NULL``
| ``NULL xor NULL`` gives ``NULL``

-----------------------------
Input parameters type
-----------------------------
op1, op2 ::

    dataset {measure<boolean> _ }
    | component<boolean>
    | boolean

-----------------------------
Result type
-----------------------------
result ::

    dataset {measure<boolean> _ }
    | component<boolean>
    | boolean

-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The operator has the typical behaviour of the “Behaviour of Boolean operators” (see the section “Typical
behaviours of the ML Operators”).
