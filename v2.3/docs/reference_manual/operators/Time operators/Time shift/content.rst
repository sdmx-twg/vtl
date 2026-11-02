------
Syntax
------

    **timeshift (** op **,** shiftNumber **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - shiftNumber
     - the number of periods to be shifted

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    timeshift ( DS_1, 2 )

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator does not perform scalar operations.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { identifier < time > _ , identifier _* }

shiftNumber ::

    integer

-----------------------------
Result type
-----------------------------
result ::

    dataset { identifier < time > _ , identifier _* }

-----------------------------
Additional Constraints
-----------------------------
The operand dataset has an Identifier of type *time*, *date* or *time_period* and may have other Identifiers.

--------
Behavior
--------

This operator takes in input a Data Set of time series and, for each time series of the Data Set, shifts the reference
time Identifier of a number of periods (of the time series) equal to the *shiftNumber* parameter. If *shiftNumber*
is negative, the shift is in the past, otherwise it is in the future. For example, if the period of the time series is month
and *shiftNumber* is -1 the reference time Identifier is shifted of two months in the past.

The operator can be applied only on Data Sets of time series and returns a Data Set of time series.

The result Data Set has the same Identifier, Measure and Attribute Components as the operand Data Set and
contains the same time series as the operand, because the time series Identifiers (all the Identifiers except the
reference time Identifier) are not changed.

The Attribute propagation rule is not applied.

As mentioned in the section “Behaviour of the Time Operators”, the operator is assumed to know which is the
time Identifier as well as the period of each data point.
