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
The **not** operator returns **true** if *op* is **false**, otherwise **true**. The input operand must be of *boolean* type.
For example:
| ``not **false**`` gives ``**true**``
| ``not **true**`` gives ``**false**``
| ``not **null**`` gives ``**null**``

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
