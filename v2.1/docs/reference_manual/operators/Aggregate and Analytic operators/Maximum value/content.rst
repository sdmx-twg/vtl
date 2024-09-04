------
Syntax
------

    *Aggregate syntax*

        **max (** dataset { groupingClause } **)**            *(in a Data Set expression)*

        **max (** component **)** { groupingClause }        *(in a Component expression within an aggr clause)*


    *Analytic syntax*

        **max (** dataset **over (** analyticClause **) )**       *(in a Data Set expression)*

        **max (** component **over (** analyticClause **) )**     *(in a Component expression within a calc clause)*

----------------
Input parameters
----------------
.. list-table::

   * - dataset
     - the operand Data Set
   * - component
     - the operand Component
   * - groupingClause
     - see Aggregate invocation
   * - analyticClause
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

-----------------------------
Result type
-----------------------------
result ::

    dataset
    | component

-----------------------------
Additional Constraints
-----------------------------
None.

--------
Behavior
--------

The operator returns the maximum of the input values. For other details, see Aggregate and Analytic invocations.
