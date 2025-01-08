^^^^^^^^^^^^^^^^
Example 2
^^^^^^^^^^^^^^^^

``DS_r := time_agg ( "Q", cast ( "2012M01", time_period, "YYYY\\MMM" ) );``

returns “2012Q1”.

^^^^^^^^^^^^^^^^
Example 3
^^^^^^^^^^^^^^^^

The following example maps a *date* to quarter level, 2012 (end of the period):

::

    DS_r := time_agg( “Q”, cast(“20120213”, date, “YYYYMMDD”), last );

and produces a *date* value corresponding to the *string* “20120331”.

^^^^^^^^^^^^^^^^
Example 4
^^^^^^^^^^^^^^^^

The following example maps a *date* to year level, 2012 (beginning of the period):

::

    DS_r := time_agg(cast( “A”, “2012M1”, date, “YYYYMMDD”), first );

and produces a *date* value corresponding to the *string* “20120101”.
