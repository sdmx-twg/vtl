------
Syntax
------

    **not** op

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the first operand

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    not DS_1

------------------------------------
Semantics  for scalar operations
------------------------------------
The **not** operator returns TRUE if *op* is FALSE, otherwise TRUE. The input operand must be of *boolean* type.
For example:
| ``not FALSE`` gives ``TRUE``
| ``not TRUE`` gives ``FALSE``
| ``not NULL`` gives ``NULL``

-----------------------------
Input parameters type
-----------------------------
op ::

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
