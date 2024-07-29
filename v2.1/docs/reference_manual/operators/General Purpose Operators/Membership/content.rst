------
Syntax
------

    ds **#** comp

----------------
Input parameters
----------------
.. list-table::

   * - ds
     - | the Data Set
   * - cop
     - | the Data Set Component

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
ds ::

	dataset

comp ::

	name<component>

-----------------------------
Result type
-----------------------------
result :: 
	
	dataset

-----------------------------
Additional Constraints
-----------------------------
comp must be a Data Set Component of the Data Set ds.

--------
Behavior
--------

The membership operator returns a Data Set having the same Identifier Components of ds and a single Measure.
If comp is a Measure in ds, then comp is maintained in the result while all other Measures are dropped.
If comp is an Identifier or an Attribute Component in ds, then all the existing Measures of ds are dropped in the
result and a new Measure is added. The Data Points’ values for the new Measure are the same as the values of comp in ds.
A default conventional name is assigned to the new Measure depending on its type: for example num_var
if the Measure is numeric, string_var if it is string and so on (the default name can be renamed through
the rename operator if needed).