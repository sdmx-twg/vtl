------
Syntax
------

**fill_time_series (** op { , limitsMethod_ } **)**

.. _limitsMethod:

limitsMethod ::= **single** | **all**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - limitsMethod
     - method for determining the limits of the time interval to be filled (default: **all**)

------------------------------------
Examples of valid syntaxes
------------------------------------
::
  
  fill_time_series ( ds )
  fill_time_series ( ds, all )

------------------------------------
Semantics  for scalar operations
------------------------------------
The **fill_time_series** operator does not perform scalar operations.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { identifier <time > _ , identifier _* }

-----------------------------
Result type
-----------------------------
result ::

    dataset { identifier <time > _ , identifier _* }

-----------------------------
Additional Constraints
-----------------------------
The operand *op* has an Identifier of type *time*, *date* or *time_period* and may have other Identifiers.

---------
Behaviour
---------

This operator can be applied only on Data Sets of time series and returns a Data Set of time series.

The operator fills the possibly missing Data Points of all the time series belonging to the operand *op* within the
time limits automatically determined by applying the *limit_method*.

If *limitsMethod* is **all**, the time limits are determined with reference to all the time_series of the Data Set: the
limits are the minimum and the maximum values of the reference time Identifier Component of the Data Set.

If *limitsMethod* is **single**, the time limits are determined with reference to each single time_series of the Data
Set: the limits are the minimum and the maximum values of the reference time Identifier Component of the time
series.

The expected Data Points are determined, for each time series, by considering the limits above and the *period*
(*frequency*) of the time series: all the Identifiers are kept unchanged except the reference time Identifier, which is
increased of one *period* at a time (e.g. day, week, month, quarter, year) from the lower to the upper time limit.
For each increase, an expected Data Point is identified.

If this expected Data Points is missing, it is added to the Data Set. For the added Data Points, Measures and
Attributes assume the NULL value.

The output Data Set has the same Identifier, Measure and Attribute Components as the operand Data Set. The
output Data Set contains the same time series as the operand, because the time series Identifiers (all the
Identifiers except the reference time Identifier) are not changed.

As mentioned in the section “Behaviour of the Time Operators”, the operator is assumed to know which is the
reference time Identifier as well as the period of each time series. Some valid examples could be: **fill_time_series ( ds )**, **fill_time_series ( ds, all )**.
