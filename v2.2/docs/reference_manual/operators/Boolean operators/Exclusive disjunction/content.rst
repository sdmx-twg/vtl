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
The **xor** operator returns **true** if only one of the operand is **true** (but not both), **false** otherwise.
The two operands must be of *boolean* type.
For example:
| ``FALSE xor FALSE`` gives ``**false**``
| ``FALSE xor TRUE`` gives ``**true**``
| ``FALSE xor NULL`` gives ``**null**``
| ``TRUE xor FALSE`` gives ``**true**``
| ``TRUE xor TRUE`` gives ``**false**``
| ``TRUE xor NULL`` gives ``**null**``
| ``NULL xor NULL`` gives ``**null**``

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
