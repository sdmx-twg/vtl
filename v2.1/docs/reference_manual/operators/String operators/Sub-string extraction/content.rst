------
Syntax
------

    **substr (** op, *start, length* **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - start
     - the starting digit (first character) of the string to be extracted
   * - length
     - the length (number of characters) of the string to be extracted

------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block:: 
    
	substr  ( DS_1,  2 ,  3 )
	substr  ( DS_1, 2 ) 
	substr  ( DS_1, _ , 3 )
	substr  ( DS_1 ) 

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator extracts a substring from op, which must be `string type`. The substring starts from the startth character
of the input string and has a number of characters equal to the **length** parameter.

* If `start` is omitted, the substring starts from the 1st position.
* If `length` is omitted or overcomes the length of the input string, the substring ends at the end of the input string.
* If `start` is greater than the length of the input string, an empty string is extracted.

For example:

| ``substr (“abcdefghijklmnopqrstuvwxyz”, 5 , 10 )``  gives: ``“efghijklmn”``
| ``substr (“abcdefghijklmnopqrstuvwxyz”, 25 , 10 )`` gives: ``“yz”``
| ``substr (“abcdefghijklmnopqrstuvwxyz”, 30 , 10 )`` gives: ``“”``

-----------------------------
Input parameters type
-----------------------------
op ::

	dataset { measure<string> _+ }
	| component<string>
	| string

start ::

	component < integer [ value >= 1 ] >
	| integer [ value >= 1 ]

length ::

    component < integer [ value >= 0 ] >
    | integer [ value >= 0 ]

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

As for the invocations at Data Set level, the operator has the behaviour of the “Operators applicable on one Scalar Value
or Data Set or Data Set Component”. As for the invocations at Component or Scalar level, the operator has
the behaviour of the “Operators applicable on more than two Scalar Values or Data Set Components”
(see the section “Typical behaviours of the ML Operators”).
