------
Syntax
------

**dateadd (** op , shiftNumber, periodInd **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - shiftNumber
     - the number of periods to be shifted
   * - periodInd
     - the period indicator

------------------------------------
Examples of valid syntaxes
------------------------------------
::
  
    dateadd (2022Q1, 5, “M”)
    dateadd (2020-12-14, -3 , “Y”)
    ds2 := ds1[calc Me2 := dateadd(Me1, 3, “W”)]
    DS_r := dateadd(DS_1, 1, “M”)


------------------------------------
Semantics  for scalar operations
------------------------------------
The operator dateadd returns the date resulting from adding (or subtracting) the given time units. The last day of the time period is assumed as the starting date. 
Please note that adding months to a given date returns the date plus integer months, adding years to a given date returns the date plus integer years; for years the “Y” is used.
For example:

|  ``dateadd (2020-02-10, 1, “M”)`` gives ``2020-03-10``
|  ``dateadd (2020-02-10, 30, “D”)`` gives ``2020-03-11``
|  ``dateadd (2020-02-10, 4, “W”)`` gives ``2020-03-09``
| ``dateadd (2020-02-10, 1, “Y”)`` gives ``2021-02-10``
| ``dateadd (2020-02-10, 365, “D”)`` gives ``2021-02-09``

-----------------------------
Input parameters type
-----------------------------
op::

    dataset{ identifier < time > _ , identifier _* }
    | component<time>
    | time

shiftNumber::

    Integer

periodInd::

    Duration

-----------------------------
Result type
-----------------------------
result ::
  
    dataset{ identifier < time > _ , identifier _* }
    | component<time>
    | time


-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The scalar version of this operator takes as input one date or time_period value and returns a 
date adding/substracting the indicated number of time units.

In the component version, that can be used in a calc clause, a new component of type date is added 
to the dataset.

The operator can be applied also Data Sets; the result Data Set has the same Identifier, Measure and 
Attribute Components as the operand Data Set. 
