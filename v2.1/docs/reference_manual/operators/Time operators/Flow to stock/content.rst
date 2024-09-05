------
Syntax
------

    **flow_to_stock (** op **)**

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
    
    flow_to_stock ( ds_1 )

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator does not perform scalar operations.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { identifier < time > _ , identifier _* , measure<number> _+ }

-----------------------------
Result type
-----------------------------
result ::

    dataset { identifier < time > _ , identifier _* , measure<number> _+ }

-----------------------------
Additional Constraints
-----------------------------
The operand dataset has an Identifier of type *time*, *date* or *time_period* and may have other Identifiers.

--------
Behavior
--------

The statistical data that describe the “state” of a phenomenon on a given moment (e.g. resident population on a
given moment) are often referred to as “stock data”.

On the contrary, the statistical data that describe “events” which can happen continuously (e.g. changes in the
resident population, such as births, deaths, immigration, emigration), are often referred to as “flow data”.

This operator takes in input a Data Set which are interpreted as flows and calculates the change of the
corresponding stock since the beginning of each time series by summing the relevant flows. In other words, the
operator perform the cumulative sum from the first Data Point of each time series to each other following Data
Point of the same time series.

The *flow_to_stock* operator can be applied only on Data Sets of time series and returns a Data Set of time series.

The result Data Set has the same Identifier, Measure and Attribute Components as the operand Data Set and
contains the same time series as the operand, because the time series Identifiers (all the Identifiers except the
reference time Identifier) are not changed.

As mentioned in the section “Behaviour of the Time Operators”, the operator is assumed to know which is the
*time* Identifier as well as the *period* of each time series.

