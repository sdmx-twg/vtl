------
Syntax
------

* Aggregate syntax

.. list-table::

   * - in a Data Set expression
     - **sum (** dataset { groupingClause } **)**
   * - in a Component expression within an aggr clause
     - **sum (** component **)** { groupingClause } 

* Analytic syntax

.. list-table::

    * - in a Data Set expression
      - **sum (** dataset **over (** analyticClause **) )** 
    * - in a Component expression within a calc clause
      - **sum (** component **over (** analyticClause **) )**

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

The result is declared with type **number**. Since **integer** is a subtype of **number**, implementations may
preserve the **integer** type for the resulting measure or component when all operand values are **integer** and
the sum is computed in integer arithmetic. When any operand value is a non-integer **number**, the result is a
**number**. Implementations should document their policy when integer sums overflow the representable range of
**integer** (for example: error, widening to **number**, or wrap-around).

-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The operator returns the sum of the input values. For other details, see Aggregate and Analytic invocations.