------
Syntax
------

* Aggregate syntax

.. list-table::

   * - in a Data Set expression
     - **var_pop (** dataset { groupingClause } **)**
   * - in a Component expression within an aggr clause
     - **var_pop (** component **)** { groupingClause } 

* Analytic syntax

.. list-table::

    * - in a Data Set expression
      - **var_pop (** dataset **over (** analyticClause **) )** 
    * - in a Component expression within a calc clause
      - **var_pop (** component **over (** analyticClause **) )**


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

---------
Behaviour
---------

The operator returns the “population variance” of the input values. For other details, see Aggregate and Analytic invocations.