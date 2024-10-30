------
Syntax
------

    **length (** op **)**

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

    length("Hello, World!") 	
    length(DS_1)

------------------------------------
Semantics  for scalar operations
------------------------------------
Returns the length of a string.
For example:

| ``length("Hello, World!")`` gives ``13``
| ``length("")`` gives ``0``

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

    dataset { measure<integer[value >= 0]> int_var }
    | component<integer[value >= 0]>
    | integer[value >= 0]

-----------------------------
Additional Constraints
-----------------------------
For operations at Data Set level, the input Data Set must have exactly one *string* type Measure.

---------
Behaviour
---------

The operator has the behaviour of the “Operators changing the data type” (see the section “Typical behaviours of the ML Operators”).
If *op* is a Data Set then **length** returns a dataset with a single measure int_var of type *integer*.
