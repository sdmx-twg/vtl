------
Syntax
------

    **ratio_to_report (** dataset **over (** partitionClause **) )** *(in a Data Set expression)*

    **ratio_to_report (** component **over (** partitionClause **) )** *(in a Component expr. within a calc clause)*

----------------
Input parameters
----------------
.. list-table::

   * - dataset
     - the operand Data Set
   * - component
     - the operand Component
   * - partitionClause
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
The Aggregate invocation is not allowed.

The *orderClause* and *windowClause* of the Analytic invocation syntax are not allowed.

--------
Behavior
--------

The operator returns the ratio between the value of the current Data Point and the sum of the values of the
partition which the current Data Point belongs to.

For other details, see Analytic invocation.
