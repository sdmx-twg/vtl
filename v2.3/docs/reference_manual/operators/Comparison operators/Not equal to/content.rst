------
Syntax
------

    left **<>** right

----------------
Input parameters
----------------
.. list-table::

   * - left
     - the left operand
   * - right
     - the right operand

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  DS_1 <> DS_2


------------------------------------
Semantics  for scalar operations
------------------------------------
The operator returns **false** if the left is equal to right, **true** otherwise.
For example:

| ``5 <> 9`` gives ``**true**``
| ``5 <> 5`` gives ``**false**``
| ``“hello” <> “hi”`` gives ``**true**``

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
