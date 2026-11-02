------
Syntax
------

.. list-table::

    * - in a Component expression within a calc clause
      - **rank ( over (** { partitionClause } orderClause **) )**

----------------
Input parameters
----------------
.. list-table::

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

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<integer> int_var }
    | component<integer>

-----------------------------
Additional Constraints
-----------------------------
The invocation at Data Set level is not allowed.

The Aggregate invocation is not allowed.

The *windowClause* of the Analytic invocation syntax is not allowed.

---------
Behaviour
---------

The operator returns an order number (rank) for each Data Point, starting from the number 1 and following the order
specified in the *orderClause*. If some Data Points are in the same order according to the specified *orderClause*, the
same order number (rank) is assigned and a gap appears in the sequence of the assigned ranks (for example, if four Data
Points have the same rank 5, the following assigned rank would be 9).

For other details, see Analytic invocation.
