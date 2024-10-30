------
Syntax
------

    **setdiff (** ds1, ds2 **)**

----------------
Input parameters
----------------
.. list-table::

   * - ds1
     - the first Data Set in the difference (the minuend)
   * - ds2
     - the second Data Set in the difference (the subtrahend)

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  setdiff (ds2, ds3)

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
ds1, ds2 ::

    dataset

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
The operand Data Sets have the same Identifier, Measure and Attribute Components.

--------
Behavior
--------

The operator implements the set difference of functions (i.e. Data Sets), interpreting the Data Points of the input
Data Sets as the elements belonging to the operand sets, the minuend and the subtrahend, respectively. The
operator returns one single Data Set, with the same Identifier, Measure and Attribute Components as the
operand Data Sets, containing the Data Points that appear in the first Data Set but not in the second. In other
words, for **setdiff (ds1, ds2)**, the resulting Dataset contains all the data points Data Point *dp1* of the operand *ds1*,
such that there is no Data Point *dp2* of *ds2* having the same values for homonym Identifier Components.

The operator has the typical behaviour of the “Behaviour of the Set operators” (see the section “Typical
behaviours of the ML Operators”).

The automatic Attribute propagation is not applied.
