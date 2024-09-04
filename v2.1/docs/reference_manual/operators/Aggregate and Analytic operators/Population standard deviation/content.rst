------
Syntax
------

    *Aggregate syntax*

        **stddev_pop (** dataset { groupingClause } **)**            *(in a Data Set expression)*

        **stddev_pop (** component **)** { groupingClause }        *(in a Component expression within an aggr clause)*


    *Analytic syntax*

        **stddev_pop (** dataset **over (** analyticClause **) )**       *(in a Data Set expression)*

        **stddev_pop (** component **over (** analyticClause **) )**     *(in a Component expression within a calc clause)*

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

    dataset { measure<number> _+ }

component ::

    component<number>

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<number> _+ }
    | component<number>

-----------------------------
Additional Constraints
-----------------------------
None.

--------
Behavior
--------

The operator returns the “population standard deviation” of the input values. For other details, see Aggregate and Analytic invocations.