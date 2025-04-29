------
Syntax
------

    **get_scalar(** ds **,** comp **)**

----------------
Input parameters
----------------
.. list-table::

   * - ds
     - the Data Set
   * - comp
     - the Data Set Component

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
	
	scalar

-----------------------------
Additional Constraints
-----------------------------
`ds` must be a Data Set without Identifier Components.
`comp` must be a Data Set Component of the Data Set `ds`. Can be a Measure or an Attribute.

---------
Behaviour
---------

The operator returns a scalar value equal to the value of `comp` in `ds`. Given that `ds` has no Identifier Components, there can be only one value for `comp` in `ds`.
