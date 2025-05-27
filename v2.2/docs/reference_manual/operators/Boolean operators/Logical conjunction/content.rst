------
Syntax
------

    op1 **and** op2

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

    DS_1 and DS_2

------------------------------------
Semantics  for scalar operations
------------------------------------
The **and** operator returns TRUE if both operands are **true**, otherwise **false**. The two operands must be of *boolean* type.
For example:
| ``FALSE and FALSE`` gives ``**false**``
| ``FALSE and TRUE`` gives ``**false**``
| ``FALSE and NULL`` gives ``**false**``
| ``TRUE and FALSE`` gives ``**false**``
| ``TRUE and TRUE`` gives ``**true**``
| ``TRUE and NULL`` gives ``**null**``
| ``NULL and NULL`` gives ``**null**``

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

--------
Behavior
--------

The operator has the typical behaviour of the “Behaviour of Boolean operators” (see the section “Typical
behaviours of the ML Operators”).
