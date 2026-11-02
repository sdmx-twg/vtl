------
Syntax
------

**datediff (** dateFrom , dateTo **)**

----------------
Input parameters
----------------
.. list-table::

   * - dateFrom
     - the starting date/time period
   * - dateTo
     - the ending date/time period

------------------------------------
Examples of valid syntaxes
------------------------------------
::
  
    datediff (2022Q1, 2023Q2)
    datediff (2020-12-14,2021-04-20)
    datediff (2021Q2, 2021-11-04)
    ds2 := ds1[calc Me3 := datediff(Me1, Me2)]

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator datediff returns the number of days between two dates or time periods.
The last day of the time period is assumed as the starting/ending date.

-----------------------------
Input parameters type
-----------------------------
dateFrom, dateTo::

    component<time>
    | time

-----------------------------
Result type
-----------------------------
result ::
  
    component<integer>
    | integer


-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The scalar version of this operator takes as input two date or time_period values and 
returns a scalar integer value.

In the component version, that can be used in a calc clause, a new component of type 
integer is added to the dataset.
