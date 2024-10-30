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
The **or** operator returns TRUE if at least one of the operands is TRUE, otherwise FALSE.
The two operands must be of *boolean* type.
For example:
| ``FALSE or FALSE`` gives ``FALSE``
| ``FALSE or TRUE`` gives ``TRUE``
| ``FALSE or NULL`` gives ``NULL``
| ``TRUE or FALSE`` gives ``TRUE``
| ``TRUE or TRUE`` gives ``TRUE``
| ``TRUE or NULL`` gives ``TRUE``
| ``NULL or NULL`` gives ``NULL``

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