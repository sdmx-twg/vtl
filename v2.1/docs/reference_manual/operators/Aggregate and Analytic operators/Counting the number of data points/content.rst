------
Syntax
------

    *Aggregate syntax*

        **count (** dataset { groupingClause } **)**            *(in a Data Set expression)*

        **count (** component **)** { groupingClause }          *(in a Component expression within an aggr clause)*

        **count ( )**                                       *(in an having clause)*


    *Analytic syntax*

        **count (** dataset **over (** analyticClause **) )**       *(in a Data Set expression)*

        **count (** component **over (** analyticClause **) )**     *(in a Component expression within a calc clause)*

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

    dataset { measure<integer> int_var }
    | component<integer>

-----------------------------
Additional Constraints
-----------------------------
None.

--------
Behavior
--------

The operator returns the number of the input Data Points. For other details, see Aggregate and Analytic invocations.
