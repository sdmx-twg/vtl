As described in the User Manual, the *time* data type is the intervening time between two time points and using the
ISO 8601 standard it can be expressed through a start date and an end date separated by a slash at any precision. In
the examples relevant to the *time* data type the precision is set at the level of month and the time format YYYY-MM/YYYY-MM is used.

Given:

* the operand dataset DS_1, which contains *annual* time series, where *Id_2* is the reference time Identifier of *time* type;
* the operand dataset DS_2, which contains *annual* time series, where *Id_2* is the reference time Identifier of *date* type 
  (conventionally each period is identified by its last day);
* the operand dataset DS_3, which contains *annual* time series, where *Id_2* is the reference time Identifier of *time_period* type;
* and the operand dataset DS_4, which contains both *quarterly* and *annual* time series relevant to the same
  phenomenon “A”, where *Id_2* is the reference time Identifier of *time_period* type:
