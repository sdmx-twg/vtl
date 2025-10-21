------
Syntax
------

    **levenshtein (** op1 , op2 **)**

----------------
Input parameters
----------------
.. list-table::

   * - op1, op2
     - the operands


------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block:: 
    
	levenshtein(DS_1, DS_2)
	levenshtein("foo", "bar")

------------------------------------
Semantics for scalar operations
------------------------------------
Levenshtein distance is a string metric for measuring the difference between two sequences.

For example:

| ``levenshtein("foo", "bar")`` gives ``3``
| ``levenshtein("foo", "")`` gives ``3``
| ``levenshtein("foo", "foo")`` gives ``0``
| ``levenshtein("bar", "baz")`` gives ``1``

-----------------------------
Input parameters type
-----------------------------
op1, op2 ::

	dataset { measure<string> _+ }
	| component<string>
	| string

-----------------------------
Result type
-----------------------------
result :: 

	dataset { measure<integer> _+ }
	| component<integer>
	| integer

-----------------------------
Additional Constraints
-----------------------------
Parameters cannot be omitted.

---------
Behaviour
---------

As for the invocations at Data Set level, the operator has the behaviour of the “Operators applicable on one Scalar Value
or Data Set or Data Set Component”. As for the invocations at Component or Scalar level, the operator has the behaviour
of the “Operators applicable on more than two Scalar Values or Data Set Components”
(see the section “Typical behaviours of the ML Operators”).
