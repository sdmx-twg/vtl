------
Syntax
------

* Aggregate syntax

.. list-table::

   * - in a Data Set expression
     - **count (** dataset { groupingClause } **)** 
   * - in a Component expression within an aggr clause
     - **count (** component **)** { groupingClause } 
   * - in a Data Set expression
     -  **count ( )** 

* Analytic syntax

.. list-table::

    * - in a Data Set expression
      - **count (** dataset **over(** analyticClause **) )**
    * - in a Component expression within a calc clause
      - **count (** component **over(** analyticClause **) )**


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

---------
Behaviour
---------

The operator returns the number of the input Data Points. For other details, see Aggregate and Analytic invocations.
