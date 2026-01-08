------
Syntax
------

    **replace (** op , pattern1, *pattern2* **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - pattern1
     - the pattern to be replaced
   * - pattern2
     - the replacing pattern


------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block:: 
    
	replace(DS_1, "Hello", "Hi")
	replace(DS_1, "Hello")

------------------------------------
Semantics  for scalar operations
------------------------------------
Replaces all the occurrences of a specified string-pattern (*pattern1*) with another one (*pattern2*).
If `pattern2` is omitted then all occurrences of `pattern1` are removed.
For example:

| ``replace("Hello world", "Hello", "Hi")`` gives ``"Hi world"``
| ``replace("Hello world", "Hello")`` gives ``" world"``
| ``replace ("Hello", "ello", "i")`` gives ``"Hi"``

-----------------------------
Input parameters type
-----------------------------
op ::

	dataset { measure<string> _+ }
	| component<string>
	| string

pattern1, pattern2 ::

	component<string>
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
The second parameter (`pattern1`) cannot be omitted.

---------
Behaviour
---------

As for the invocations at Data Set level, the operator has the behaviour of the “Operators applicable on one Scalar Value
or Data Set or Data Set Component”. As for the invocations at Component or Scalar level, the operator has the behaviour
of the “Operators applicable on more than two Scalar Values or Data Set Components”
(see the section “Typical behaviours of the ML Operators”).
