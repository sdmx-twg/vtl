------
Syntax
------

{**daytoyear**  | **daytomonth** }¹ **(** op **)**


----------------
Input parameters
----------------
.. list-table::

   * - op
     - an integer representing the number of days to transform


------------------------------------
Examples of valid syntaxes
------------------------------------
::
  
  daytoyear (422)
  daytomonth (146)
  ds2 := ds1[calc Me2 := daytomonth(Me1)]



------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **daytoyear** returns a duration having the following mask:  \PY\YDDD\D. 
The operator **daytomonth** returns a duration having the following mask:  \PM\MDD\D. 


-----------------------------
Input parameters type
-----------------------------
op::

    component<integer>
    | integer

-----------------------------
Result type
-----------------------------
result ::
  
    component<duration>
    | duration


-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The scalar version of the **daytoyear** operator takes as input an integer representing t
he number of days and returns the corresponding number of years and days; 
according to ISO 8601 Y = 365D.

The scalar version of the **daytomonth** operator takes as input an integer representing 
the numberoof days and returns the corresponding number of months and days; according 
to ISO 8601 M = 30D.

In the component version, that can be used in a calc clause, a new component of type 
duration is added to the dataset.
