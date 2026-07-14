------
Syntax
------

    op1 **or** op2

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

    DS_1 or DS_2

------------------------------------
Semantics  for scalar operations
------------------------------------
The **or** operator returns **true** if at least one of the operands is **true**, otherwise **false**.
The two operands must be of *boolean* type.
For example:
| ``**false** or **false**`` gives ``**false**``
| `**false** or **true**`` gives ``**true**``
| ``**false** or **null**`` gives ``**null**``
| ``**true** or **false**`` gives ``**true**``
| ``**true** or **true**`` gives ``**true**``
| ``**true** or **null**`` gives ``**true**``
| ``**null** or **null**`` gives ``**null**``

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
