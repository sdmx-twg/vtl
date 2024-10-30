^^^^^^^^^^^^^^^^
Example 1
^^^^^^^^^^^^^^^^

From string to number: ::

    ds2 := ds1[calc m2 := cast(m1, number, “DD.DDD”) + 2 ];

In this case we use explicit cast from *string* to *numbers*. The mask is used to specify how the *string* must be
interpreted in the conversion.

^^^^^^^^^^^^^^^^
Example 2
^^^^^^^^^^^^^^^^

From string to date: ::

    ds2 := ds1[calc m2 := cast(m1, date, “YYYY-MM-DD”) ];

In this case we use explicit cast from *string* to *date*. The mask is used to specify how the *string* must be interpreted in the conversion.

^^^^^^^^^^^^^^^^
Example 3
^^^^^^^^^^^^^^^^

From number to integer: ::

    ds2 := ds1[calc m2 := cast(m1, integer) + 3 ];

In this case we cast a *number* into an *integer*, no mask is required.

^^^^^^^^^^^^^^^^
Example 4
^^^^^^^^^^^^^^^^

From number to string: ::

    ds2 := ds1[calc m2 := length(cast(m1, string)) ];

In this case we cast a *number* into a *string*, no mask is required.

^^^^^^^^^^^^^^^^
Example 5
^^^^^^^^^^^^^^^^

From date to string: ::

    ds2 := ds1[calc m2 := cast(m1, string, “YY-MON-DAY hh:mm:ss”) ];

In this example a *date* instant is turned into a *string*. The mask is used to specify the *string* layout.

^^^^^^^^^^^^^^^^
Example 6
^^^^^^^^^^^^^^^^

From string to GEO_AREA: ::

    ds2 := ds1[calc m2 := cast(GEO_STRING, GEO_AREA)];

In this example we suppose we have elements of Value Domain Subset for GEO_AREA. Let GEO_STRING be a
string Component of Data Set *ds1* with string values compatible with the GEO_AREA Value Domain Subset.
Thus, the following expression moves *ds1* data into *ds2*, explicitly casting strings to geographical areas.

^^^^^^^^^^^^^^^^
Example 7
^^^^^^^^^^^^^^^^

From GEO_AREA to string: ::

    ds2 := ds1[calc m2 := length(GEO_AREA)];

In this example we use a Component GEO_AREA in a *string* expression, which calculates the length of the
corresponding *string*; this triggers the automatic cast.

^^^^^^^^^^^^^^^^
Example 8
^^^^^^^^^^^^^^^^

From GEO_AREA2 to GEO_AREA1: ::

    ds2 := ds1 [ calc m2 := cast (GEO, GEO_AREA1) ];

In this example we suppose we have to compare elements two Value Domain Subsets. They are both defined on
top of Strings. The following cast expressions performs the conversion.

Now, Component GEO is of type GEO_AREA2, then we specify it has to be cast into GEO_AREA1. As both
work on *strings* (and the values are compatible), the conversion is feasible. In other words, the cast of an
operand into GEO_AREA1 would expect a *string*. Then, as GEO is of type GEO_AREA2, defined on top of
*strings*, it is implicitly cast to the respective *string*; this is compatible with what cast expects and it is then able to
build a value of type GEO_AREA1.

^^^^^^^^^^^^^^^^
Example 9
^^^^^^^^^^^^^^^^

From string to time_period:

In the following examples we convert from strings to time_periods, by using appropriate masks.

The first quarter of year 2000 can be expressed as follows (other examples are possible): ::

    cast ( “2000Q1”, time_period, “YYYY\QQ” )
    cast ( “2000-Q1”, time_period, “YYYY-\QQ” )
    cast ( “2000-1”, time_period, “YYYY-Q” )
    cast ( “Q1-2000”, time_period, “\QQ-YYYY” )
    cast ( “2000Q01”, time_period, “YYYY\QQQ” )

Examples of daily data: ::

    cast ( “2000M01D01”, time_period, “YYYY\MMM\DDD” )
    cast ( “2000.01.01”, time_period, “YYYY\.MM\.DD” )

