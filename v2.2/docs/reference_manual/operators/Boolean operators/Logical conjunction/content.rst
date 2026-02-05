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
The **and** operator returns **true** if both operands are **true**, otherwise **false**. The two operands must be of *boolean* type.
For example:
| ``**false** and **false**`` gives ``**false**``
| ``**false** and **true**`` gives ``**false**``
| ``**false** and **null**`` gives ``**false**``
| ``**true** and **false**`` gives ``**false**``
| ``**true** and **true**`` gives ``**true**``
| ``**true** and **null**`` gives ``**null**``
| ``**null** and **null**`` gives ``**null**``

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
