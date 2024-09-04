------
Syntax
------

    **instr (** op, pattern, *start, occurrence* **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - pattern
     - the string-pattern to be searched
   * - start
     - the position in the input string of the character from which the search starts
   * - occurrence
     - the occurrence of the pattern to search

------------------------------------
Examplesof valid syntaxes
------------------------------------

.. code-block:: 

    instr ( DS_1,  “ab”, 2 , 3 )
    instr ( DS_1,  “ab”, 2 )
    instr ( DS_1,  “ab”, _ , 2 )
    instr ( DS_1,  “ab” )


------------------------------------
Semantics  for scalar operations
------------------------------------

The operator returns the position in the input string of a specified string ( *pattern* ).
The search starts from the *start*th character of the input string and finds the nth occurrence of the pattern,
returning the position of its first character.
If *start* is omitted, the search starts from the 1st position.
If nth *occurrence* is omitted, the value is 1.
If the nth *occurrence* of the string-pattern after the *start* th character is not found in the input string, the returned value is 0.
For example:

| ``instr ("abcde", "c" )`` gives ``3``
| ``instr ("abcdecfrxcwsd", "c", _ , 3 )`` gives ``10``
| ``instr ("abcdecfrxcwsd", "c", 5 , 3 )`` gives ``0``

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { measure<string> _+ }
    | component<string>
    | string

pattern ::

    component<string>
    | string

start ::

    component < integer [ value >= 1 ] >
    | integer [ value >= 1 ]

occurrence ::

    component < integer [ value >= 1 ] >
    | integer [ value >= 1 ]

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
The second parameter (pattern) cannot be omitted.
For operations at Data Set level, the input Data Set must have exactly one *string* type Measure.

---------
Behaviour
---------

As for the invocations at Data Set level, the operator has the behaviour of the “Operators applicable on one Scalar Value
or Data Set or Data Set Component”, as for the invocations at Component or Scalar level, the operator has the behaviour
of the “Operators applicable on more than two Scalar Values or Data Set Components”,
(see the section “Typical behaviours of the ML Operators”).
If *op* is a Data Set then **instr** returns a dataset with a single measure *int_var* of type *integer*.
