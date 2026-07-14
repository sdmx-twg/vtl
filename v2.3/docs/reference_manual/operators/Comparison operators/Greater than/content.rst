------
Syntax
------

    left { **>** | **>=** }¹ right

----------------
Input parameters
----------------
.. list-table::

   * - left
     - the left operand part of the comparison
   * - right
     - the right operand part of the comparison

------------------------------------
Examples of valid syntaxes
------------------------------------
::
    DS_1 > DS_2
    DS_1 >= DS_2

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **>** returns **true** if *left* is greater than *right*, **false** otherwise.
The operator **>=** returns **true** if *left* is greater than or equal to *right*, **false** otherwise.
For example:

| ``5 > 9`` gives ``**false**``
| ``5 >= 5`` gives ``**true**``
| ``"hello" > "hi"`` gives ``**false**``

-----------------------------
Input parameters type
-----------------------------
left, right ::

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
Operands *left* and *right* must be of the same scalar type.

---------
Behaviour
---------

The operator has the typical behaviour of the “Operators changing the data type” (see the section “Typical
behaviours of the ML Operators”).
