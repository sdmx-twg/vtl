------
Syntax
------

    **period_indicator (** { *op* } **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand

------------------------------------
Examples of valid syntaxes
------------------------------------
::
    period_indicator ( ds_1 )
    period_indicator  // (if used in a clause the operand op can be omitted) 


------------------------------------
Semantics  for scalar operations
------------------------------------
**period_indicator** returns the period indicator of a *time_period* value. The period indicator is the part of the
*time_period* value which denotes the duration of the time period (e.g. day, week, month...).

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { identifier <time_period> _ , identifier _* }
    | component<time_period>
    | time_period

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<duration> duration_var }
    | component<duration>
    | duration

-----------------------------
Additional Constraints
-----------------------------
If *op* is a Data Set then it has exactly one Identifier of type *time_period* and may have other Identifiers.
If the operator is used in a clause and *op* is omitted, then the Data Set to which the clause is applied has exactly one
Identifier of type *time_period* and may have other Identifiers.

---------
Behaviour
---------

The operator extracts the period indicator part of the *time_period* value. The period indicator is computed for
each Data Point. When the operator is used in a clause, it extracts the period indicator from the *time_period*
value the Data Set to which the clause is applied.

The operator returns a Data Set with the same Identifiers of *op* and one Measure of type *duration* named
*duration_var*. As for all the Variables, a proper Value Domain must be defined to contain the possible values of
the period indicator and *duration_var*. The values used in the examples are listed at the beginning of this chapter
"VTL-ML Time operators".
