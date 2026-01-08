------
Syntax
------

| **yeartoday (** yearDuration **)**
| **monthtoday (** monthDuration **)**


----------------
Input parameters
----------------
.. list-table::

   * - yearDuration 
     - a duration having the following mask:  `\PY\YDDD\D`
   * - monthDuration  
     - a duration having the following mask:  `\PM\MDD\D`

------------------------------------
Examples of valid syntaxes
------------------------------------
::
  
  yeartoday (P1Y)
  monthtoday (P3M)
  ds2 := ds1[calc Me2 := yeartoday(Me1)]

------------------------------------
Semantics  for scalar operations
------------------------------------
The operators return an integer representing the number of days corresponding
 to the given duration.

-----------------------------
Input parameters type
-----------------------------
op::

    component<duration>
    | duration

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

The scalar version of the **yeartoday** operator takes as input a duration having the 
following mask:  `\PY\YDDD\D`;  returns the corresponding number of years and days
(according to ISO 8601 Y = 365D).

The scalar version of the monthtoday operator takes as input a duration having the
following mask: `\PM\MDD\D`;  returns the corresponding number of months and days; 
according to ISO 8601 M = 30D).

In the component version, that can be used in a calc clause, a new component of type integer is added to the dataset.
