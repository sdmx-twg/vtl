######################################
VTL-ML - Time Operators
######################################

This chapter describes the time operators, which are the operators dealing with time, date and time_period basic scalar types. 
The general aspects of the behaviour of these operators is described in the section “Behaviour of the Time Operators”.
The time data type is the most general type and denotes a generic time interval, having  start and end points in time and therefore 
a duration, which is the time intervening between the start and end points. The date data type denotes a generic time instant (a point 
in time), which is a time interval with zero duration. The time_period data type denotes a regular time interval whose regular duration 
is explicitly represented inside each time_period value and is named period_indicator. In some sense, we say that date and time_period 
are special cases of time, the former with coinciding extremes and zero duration and the latter with regular duration. 
The time data type is overarching in the sense that it comprises date and time_period. Finally, duration data type represents a generic time span, independently of any specific start and end date.

The time, date and time period formats used here are explained in the User Manual in the section “External 
representations and literals used in the VTL Manuals”. 

The period indicator P id of the *duration* type and its possible values are:

| D		Day
| W		Week
| M		Month
| Q		Quarter 
| S		Semester
| A		Year

As already said, these representation are not prescribed by VTL and are not part of the VTL standard, each VTL system can personalize 
the representation of time, date, time_period and duration as desired. The formats shown above are only the ones used in the examples.

For a fully-detailed explanation, please refer to the User Manual.


.. toctree::
   :glob:
   :maxdepth: 1

   Period indicator/index
   Fill time series/index
   Flow to stock/index
   Stock to flow/index
   Time shift/index
   Time aggregation/index
   Actual time/index
   Days between two dates/index
   Add time unit to date/index
   Extract time period/index
   Number days to duration/index
   Duration to number days/index
