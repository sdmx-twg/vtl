------
Syntax
------

* Aggregate syntax

.. list-table::

   * - in a Data Set expression
     - **min (** dataset { groupingClause } **)** 
   * - in a Component expression within an aggr clause
     - **min (** component **)** { groupingClause }  

* Analytic syntax

.. list-table::

    * - in a Data Set expression
      - **min (** dataset **over (** analyticClause **) )**
    * - in a Component expression within a calc clause
      - **min (** component **over (** analyticClause **) )**


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

---------
Behaviour
---------

The operator returns the minimum value of the input values. For other details, see Aggregate and Analytic invocations.
