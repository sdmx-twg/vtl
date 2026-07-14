------
Syntax
------

.. list-table::

    * - in a Data Set expression
      - **lead (** dataset {, offset {, defaultValue } } **over (** { partitionClause } orderClause **) )**
    * - in a Component expression within a calc clause
      - **lead (** component {, offset {, defaultValue } } **over (** { partitionClause } orderClause **) )**

----------------
Input parameters
----------------
.. list-table::

   * - dataset
     - the operand Data Set
   * - component
     - the operand Component
   * - offset
     - the relative position beyond the current Data Point
   * - defaultValue
     - the value returned when the *offset* goes outside of the partition
   * - partitionClause
     - see Analytic invocation
   * - orderClause
     - see Analytic invocation

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
dataset ::

    dataset

component ::

    component

offset ::

    integer [ value > 0 ]

default value ::

    scalar

-----------------------------
Result type
-----------------------------
result ::

    dataset
    | component

-----------------------------
Additional Constraints
-----------------------------
The Aggregate invocation is not allowed.

The *windowClause* of the Analytic invocation syntax is not allowed.

---------
Behaviour
---------

In the ordered set of Data Points of the current partition, the operator returns the value(s) taken from the Data
Point at the specified physical *offset* beyond the current Data Point.

If *defaultValue* is not specified, then the value returned when the offset goes outside the partition is **null**.

For other details, see Analytic invocation.
