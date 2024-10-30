------
Syntax
------

    **union (** dsList_ **)**

    .. _dsList:

    dsList ::= ds { , ds }*

----------------
Input parameters
----------------
.. list-table::

   * - dsList
     - the list of Data Sets in the union

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  union (ds2, ds3)
  
------------------------------------
Semantics  for scalar operations
------------------------------------
This operator does not perform scalar operations.

-----------------------------
Input parameters type
-----------------------------
ds ::

    dataset

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
All the Data Sets in dsList have the same Identifier, Measure and Attribute Components.

---------
Behaviour
---------

The **union** operator implements the union of functions (i.e., Data Sets). The resulting Data Set has the same
Identifier, Measure and Attribute Components of the operand Data Sets specified in the *dsList*, and contains the
Data Points belonging to any of the operand Data Sets.

The operand Data Sets can contain Data Points having the same values of the Identifiers. To avoid duplications of
Data Points in the resulting Data Set, those Data Points are filtered by choosing the Data Point belonging to the left
most operand Data Set. For instance, let's assume that in **union** ( ds1, ds2 ) the operand *ds1* contains a Data
Point *dp1* and the operand *ds2* contains a Data Point *dp2* such that *dp1* has the same Identifiers values of *dp2*,
then the resulting Data Set contains *dp1* only.

The operator has the typical behaviour of the “Behaviour of the Set operators” (see the section “Typical
behaviours of the ML Operators”).

The automatic Attribute propagation is not applied.
