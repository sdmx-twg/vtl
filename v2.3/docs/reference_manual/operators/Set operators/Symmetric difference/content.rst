------
Syntax
------

    **symdiff (** ds1, ds2 **)**

----------------
Input parameters
----------------
.. list-table::

   * - ds1
     - the first Data Set in the difference
   * - ds2
     - the second Data Set in the difference

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

---------
Behaviour
---------

The operator implements the symmetric set difference between functions (i.e. Data Sets), interpreting the Data
Points of the input Data Sets as the elements in the operand Sets. The operator returns one Data Set, with the
same Identifier, Measure and Attribute Components as the operand Data Sets, containing the Data Points that
appear in the first Data Set but not in the second and the Data Points that appear in the second Data Set but not
in the first one.

Data Points are compared to one another by Identifier Components. For **symdiff (ds1, ds2)**, the resulting Data
Set contains all the Data Points *dp1* contained in *ds1* for which there is no Data Point *dp2* in *ds2* with the same
values for homonym Identifier components and all the Data Points *dp2* contained in *ds2* for which there is no
Data Point *dp1* in *ds1* with the same values for homonym Identifier Components.

The operator has the typical behaviour of the “Behaviour of the Set operators” (see the section “Typical
behaviours of the ML Operators”).

The automatic Attribute propagation is not applied.
