------
Syntax
------

    **string_distance (** method, string1, string2 **)**

----------------
Input parameters
----------------
.. list-table::

   * - method
     - the distance method to apply (levenshtein, damerau–levenshtein, hamming, jaro-winkler)
   * - string1
     - the first string operand
   * - string2
     - the second string operand

------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block:: 
    
	string_distance("levenshtein", "foo", "bar")
	string_distance("levenshtein", DS_1, DS_2)
	string_distance("damerau–levenshtein", "foo", "bar")
	string_distance("hamming", "foo", "bar")
	string_distance("jaro-winkler", "FOO", "BAR")

------------------------------------
Semantics  for scalar operations
------------------------------------
Returns the distance between two strings using the specified distance method.

All distance methods are **symmetric** (commutative), meaning that ``string_distance(method, string1, string2)`` equals ``string_distance(method, string2, string1)``.

* **levenshtein**: Returns the Levenshtein distance, which is the minimum number of single-character edits (insertions, deletions, or substitutions) required to change one string into another.
* **damerau–levenshtein**: Returns the Damerau–Levenshtein distance, which extends Levenshtein distance by including transpositions of adjacent characters as a single operation.
* **hamming**: Returns the Hamming distance, which is the number of positions at which the corresponding characters are different. Both strings must have the same length.
* **jaro-winkler**: Returns the Jaro–Winkler distance, which is a string metric measuring an edit distance between two sequences. It is a variant of the Jaro distance metric and mainly used in the area of record linkage.

For example:

| ``string_distance("levenshtein", "foo", "fo")`` gives ``1``
| ``string_distance("damerau–levenshtein", "bar", "baz")`` gives ``1``
| ``string_distance("hamming", "foo", "fob")`` gives ``1``
| ``string_distance("jaro-winkler", "FOO", "BAR")`` gives a value between ``0`` and ``1``

-----------------------------
Input parameters type
-----------------------------
method ::

	component<string>
	| string

string1, string2 ::

	dataset { measure<string> _+ }
	| component<string>
	| string

-----------------------------
Result type
-----------------------------
result :: 

	dataset { measure<number> _+ }
	| component<number>
	| number

-----------------------------
Additional Constraints
-----------------------------
* The `method` parameter must be one of: "levenshtein", "damerau–levenshtein", "hamming", or "jaro-winkler".
* For Hamming distance, both strings must have the same length.
* For operations at Data Set level, the input Data Sets must have exactly one *string* type Measure each.

---------
Behaviour
---------

The operator has the behaviour of the "Operators applicable on two Scalar Values or Data Sets or Data Set Components"
(see the section "Typical behaviours of the ML Operators").
If *string1* and *string2* are Data Sets then **string_distance** returns a dataset with a single measure of type *number*.
