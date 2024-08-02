The operator **time_agg** converts *time*, *date* and *time_period* values from a smaller to a larger duration.

------
Syntax
------

    **time_agg (** periodIndTo { , periodIndFrom } { , op } { , **first** | **last** } **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - | the scalar value, the Component or the Data Set to be converted.
       | If not specified, then **time_agg** is used in combination within an aggregation operator
   * - periodIndFrom
     - the source period indicator
   * - periodIndTo
     - the target period indicator

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator converts a *time*, *date* or *time_period* value from a smaller to a larger duration.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { identifier < time > _ , identifier _* }
    | component<time>
    | time

periodIndFrom, periodIndTo ::

    duration

-----------------------------
Result type
-----------------------------
result ::

    dataset { identifier < time > _ , identifier _* }
    | component<time>
    | time

-----------------------------
Additional Constraints
-----------------------------
If *op* is a Data Set then it has exactly one Identifier of type *time*, *date* or *time_period* and may have other Identifiers.
It is only possible to convert smaller duration values to larger duration values (e.g. it is possible to convert
*monthly* data to *annual* data but the contrary is not allowed).

--------
Behavior
--------

The scalar version of this operator takes as input a *time*, *date* or *time_period* value, converts it to *periodIndTo*
and returns a scalar of the corresponding type.

The Data Set version acts on a single Measure Data Set of type *time*, *date* or *time_period* and returns a Data Set
having the same structure.

Finally, VTL also provides a component version, for use in combination with an aggregation operator, because
the change of frequency requires an aggregation. In this case, the operator converts the period_indicator of the
data points (e.g., convert *monthly* data to *annual* data).

On *time* type, the operator maps the input value into the comprising larger regular interval, whose duration is
the one specified by the *periodIndTo* parameter.

On *date* type, the operator maps the input value into the comprising larger period, whose duration is the one
specified by the *periodIndTo* parameter, which is conventionally represented either by the start or by the end
date, according to the **first/last** parameter.

On *time_period* type, the operator maps the input value into the comprising larger time period specified by the
*periodIndTo* parameter (the original period indicator is converted in the target one and the number of periods is
adjusted correspondingly).

The input duration *periodIndFrom* is optional. In case of *time_period* Data Points, the input duration can be
inferred from the internal representation of the value. In case of *time* or *date* types, it is inferred by the
implementation. Filters on input time series can be obtained with the **filter** clause.

Some valid examples could be: **sum ( DS group all time_agg ( Me, “A” ) )**,
**time_agg ( “A”, cast ( “2012Q1”, time_period , ”YYYY\Qq” ) )**,
**time_agg(“M”, cast (“2012-12-23”, date, “YYYY-MM-DD”) )**,
**time_agg(“M”, DS1)**,
**ds_2 := ds1[calc Me1 := time_agg(“M”,Me1)]**.
