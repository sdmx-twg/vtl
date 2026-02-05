------
Syntax
------

{**getyear** | **getmonth** | **dayofmonth** | **dayofyear**}¹ **(** op **)**


----------------
Input parameters
----------------
.. list-table::

   * - op
     - the input date/time period


------------------------------------
Examples of valid syntaxes
------------------------------------
::
  
  getyear (2022Q1)
  dayofyear (2020-12-14)
  ds2 := ds1[calc Me2 := dayofmonth(Me1)]


------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **getyear** returns the year of the given date/time period.
The operator **getmonth** returns the month of the given date/time period (between 1 and 12).
The operator **dayofmonth** returns the ordinal day within the month (between 1 and 31).
The operator **dayofyear** returns the ordinal day within the year (between 1 and 366).

-----------------------------
Input parameters type
-----------------------------
op::

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

The scalar version of this operators takes as input one date or time_period value and 
returns a integer value corresponding to the specified time period.

In the component version, that can be used in a calc clause, a new component of type 
integer is added to the dataset.
