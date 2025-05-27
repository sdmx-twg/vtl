------
Syntax
------

    **isnull (** op **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  isnull(DS_1)

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator returns **true** if the value of the operand is **null**, **false** otherwise.
For example:

| ``isnull(“Hello”)`` gives ``**false**``
| ``isnull(**null**)`` gives ``**true**``

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset {measure<scalar> _}
    | component<scalar>
    | scalar

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<boolean> bool_var }
    | component<boolean>
    | boolean

-----------------------------
Additional Constraints
-----------------------------
If *op* is a Data Set then it has exactly one measure.

---------
Behaviour
---------

The operator has the typical behaviour of the “Operators changing the data type” (see the section “Typical
behaviours of the ML Operators”).
