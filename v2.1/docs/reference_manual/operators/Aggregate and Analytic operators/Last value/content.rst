------
Syntax
------

.. list-table::

    * - in a Data Set expression
      - **last_value (** dataset **over (** analyticClause **) )** 
    * - in a Component expression within a calc clause
      - **last_value (** component **over (** analyticClause **) )**

----------------
Input parameters
----------------
.. list-table::

   * - dataset
     - the operand Data Set
   * - component
     - the operand Component
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

    dataset { measure<scalar> _+ }

component ::

    component<scalar>

-----------------------------
Result type
-----------------------------
result ::

    dataset
    | component<scalar>

-----------------------------
Additional Constraints
-----------------------------
The Aggregate invocation is not allowed.

---------
Behaviour
---------

The operator returns the last value (in the value order) of the set of Data Points that belong to the same analytic
window as the current Data Point.

When invoked at Data Set level, it returns the last value for each Measure of the input Data Set. The last value of
different Measures can result from different Data Points.
When invoked at Component level, it returns the last value of the specified Component.

For other details, see Analytic invocation.
