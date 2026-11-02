------
Syntax
------

    { **trim** | **ltrim** | **rtrim** }¹ **(** op **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand

------------------------------------
Semantics  for scalar operations
------------------------------------
Removes trailing or/and leading whitespace from a string.
For example, ``trim("Hello ")`` gives ``"Hello"``.

-----------------------------
Input parameters type
-----------------------------
op1 ::

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
