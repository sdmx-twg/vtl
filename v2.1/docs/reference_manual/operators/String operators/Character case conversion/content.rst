------
Syntax
------

    { **upper** | **lower** }¹ **(** op **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand

------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block:: 
    
    upper("Hello")
    lower(ds_1)

------------------------------------
Semantics  for scalar operations
------------------------------------
Converts the character case of a string in upper or lower case.
For example, ``upper("Hello")`` gives ``"HELLO"``.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { measure<string> _+ }
    | component<string>
    | string

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<string> _+ }
    | component<string>
    | string

-----------------------------
Additional Constraints
-----------------------------
None.

--------
Behavior
--------

The operator has the behaviour of the “Operators applicable on one Scalar Value or Data Set or Data Set Component”
(see the section “Typical behaviours of the ML Operators”).