------
Syntax
------

    left { **<** | **<=** }¹ right

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

    DS_1 < DS_2
    DS_1 <= DS_2

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **<** returns TRUE if left is smaller than right, FALSE otherwise.
The operator **<=** returns TRUE if left is smaller than or equal to right, FALSE otherwise.
For example:

| ``5 < 4`` gives ``FALSE``
| ``5 <= 5`` gives ``TRUE``
| ``"hello" < "hi"`` gives ``TRUE``

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
behaviours of the ML Operators”). Some valid examples could be: **DS_1 < DS_2**, **DS_1 <= DS_2**.
