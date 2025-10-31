------
Syntax
------

    **cast (** op , scalarType { , mask} **)**

----------------
Input parameters
----------------
.. list-table::

   * - op 
     - the operand to be cast
   * - scalarType
     - the name of the scalar type into which *op* has to be converted
   * - mask
     - a character literal that specifies the format of *op*

--------------------------------
Semantics  for scalar operations
--------------------------------
This operator converts the scalar type of `op` to the scalar type specified by `scalarType`. It returns a copy of `op`
converted to the specified `scalarType`.

---------------------
Input parameters type
---------------------
op ::

    dataset{ measure<scalar> _ }
    | component<scalar>
    | scalar

scalarType ::

    scalar type (see the section: Data type syntax)

mask ::

    string

-----------
Result type
-----------
result ::

    dataset{ measure<scalar> _ }
    | component<scalar>
    | scalar

----------------------
Additional Constraints
----------------------
* Not all the conversions are possible, the specified casting operation is allowed only according to the
  semantics described below.
* The `mask` must adhere to one of the formats specified below.

---------
Behaviour
---------

The VTL assumes that a basic scalar type has a unique internal and more possible external representations, which are
those of any value domain, defined on that basic scalar type, or any subset of that domain (see the section VTL Data
Types in the User Manual). For example, there can exist a *boolean* value domain which uses the representation "true"
and "false" and another *boolean* value domain which uses the representation "1" and "0". The value domains must
be obviously known by users in order to understand each scalar value external representation.

The unique internal representation of a basic scalar type, instead, is used by the **cast** operator as a technical
expedient to make the conversion between external representations easier: users are not necessarily aware of it. 
In a conversion, first the **cast** operator converts the source internal representation, which solely depends on the
source basic scalar type, into the internal representation of the destination basic scalar type. The external
representation of the destination value domain then determines if the converted value is valid or not; when it isn't,
an error is raised.

VTL allows for some kinds of conversions to happpen automatically, without the need to use the cast operator; those
conversions are called **implicit casts**. For all conversions where the implicit cast is not available, the **cast
operator** must be invoked explictly: this kind of conversion is called an **explicit cast**. If an explicit cast
involves a cast from or to the string basic scalar type, it may be provided with a mask; the mask overrides the 
default behavior of the cast operator and specifies how the actual casting is performed.

**Conversions between a basic scalar type and value domains defined on that scalar type**

From the above definition, it is clear that any value belonging to a value domain or value domain subset can be
implicitly converted into a value of the basic `scalar` type on which that domain or subset was defined (upcast).
Also, VTL allows any value of a basic scalar type to be implicitly converted into a value belonging to a value 
domain or value domain subset based on that basic scalar type (downcast); obviously, the resulting value must be
one of the allowed values of that particular domain or subset; otherwise, an error is raised.

**Conversions between two value domains based on the same basic scalar type**

As a result of the above definitions, implicit conversions between two value domains (or any of their subsets) based 
on the same basic scalar types are also possible. Since an element of a value domain is implicitly upcast into its
corresponding basic scalar type, and in turn that value can be implictly downcast into another value domain based on 
that scalar type (or one of its subsets), an implicit conversion between those two domains is straightforward.
Of course, if the the resulting value is not one of the allowed values of that particular domain or subset, 
an error is raised.

**Conversions between two value domains based on different basic scalar types**

Also, VTL allows, in some cases, to convert values between two value domains, or any of their subsets, based on
different basic scalar types. The behavior is as follows: first, the value of the source value domain is upcast to
the basic scalar type on which that domain or subset is based. Then the internal representation is converted into 
the basic scalar type on which the destination domain or subset is defined. Finally the obtained basic scalar value
is downcast into the destination value domain (or subset); again, if the the resulting value is not one of the 
allowed values of that particular domain or subset, an error is raised.

**Conversions between basic scalar types**

In order to perform conversion between value domains defined on different basic scalar types, a direct conversion
mechanism between two different basic scalar types (and thus their internal representation) must be defined; in some 
cases, depending on the basic scalar types involved, even these conversions are performed implicitly without needing
to write a case operator. 

The implicit or explicit nature of the cast required to perform a given conversion can be personalized in specific
environments, provided that the personalization is explicitly documented with reference to the table above. For 
example, assuming that an explicit cast is required for a conversion, in a specific environment the conversion can
also be performed implicitly, provided that this behavior is documented.

The VTL allows for these **implicit casts**:

* From **integer** to **number**: a `number` value is returned having the integer part equal to the `integer` value,
  and the decimal part equal to zero.
* From **number** to **integer**: an `integer` value is returned, representing the sign and the integer part of 
  the input `number` value; implementations may raise an error if the magnitude of the integer part is too big
  to be represented internally, provided that they document such a limit.
* From **boolean** to **string**: Either one of the string values `"true"` and `"false"` is returned, depending on
  the input.
* From **date** to **time**: a `time` value is returned having its start equal to its end, and both equal to the input
  `date` value.
* From **time_period** to **time**: a `time` value is returned having the stame start and end of the input `time_period`
  value.

An **explicit cast without mask** can also be used to make an implicit cast more clear, and in this case its
behavior remains the same. It can also be used for some specific conversions between basic scalar types (other
than `string`) that, for their potentially ambiguous or error-prone nature, may be misinterpreted if they were 
to be made implicit.

The behavior of these casts is described here:

* From **integer** to **boolean**: if the `integer` value is not equal to zero, then the boolean `true` literal is
  returned, in every other case the boolean `false` literal is returned.
* From **boolean** to **integer**: the integer `0` is returned if the `boolean` value is false, `1` if its true.
* From **number** to **boolean**: if the `number` absolute value is not equal to zero, then the boolean `true`
  literal is returned, in every other case the boolean `false` literal is returned.
* From **boolean** to **number**: the number `0.0` is returned if the `boolean` value is false, `1.0` if its true.
* From **string** to **boolean**: The `boolean` value representing true is returned if the input string, with
  any leading or trailing blanks removed, is equal to `"true"` not considering the case. The `boolean` value 
  representing false is returned in any other case.
* From **date** to **time_period**: A `time_period` value with a daily duration is returned, starting and
  ending at the specified `date` value.
* From **time_period** to **date**: A `date` value is returned if the input `time_period` has a duration of a 
  single day, representing that day; otherwise an error is raised.
* From **time** to **time_period**: A `time_period` value is returned if the time value has a regular duration
  (see above for its meaning) otherwise an error is raised.
* From **time** to **date**: A `date` value is returned if the `time` value start and ends at the same date,
  otherwise an error is raised.

An **explicit cast with optional mask** can be used to perform conversion between the `string` type and
any other basic scalar type, even those available as implicit conversions. In this case, the specified
mask may override the default (implicit) behavior.

When the `string` value is the output of the conversion, the mask provides a way to format the input 
value into a human-readable string, for example to be later output into a report file. When the
`string` value is the input of the conversion, the mask provides a way to parse each character in
the input string to determine the output value in the desired value domain, for example to parse the 
string "01jan2025" into a `date` value representing 2025 January, 1st.

The valid characters that can be used in a mask for a specific conversion are described in the section
“VTL-ML – Typical Behaviour of the ML Operators”, sub-section “Type Conversion and Formatting Mask”.
The mask is optional in all cases; the behavior defines how the conversion occurs when the mask is
not provided in the cast operator.

When performing a conversion from a `string` value, all leading and trailing blanks are removed from
the input string value before performing the conversion. Then, if the input string or a part of it cannot be 
matched to the specified or default mask, an error is raised. An empty string generally causes an error
to be raised when instead a `null` input string is converted to the corresponding `null` value of
the desired value domain. Also, if some characters are not consumed and remain in the input string after
the conversion is complete, an error is raised.

The default behavior of conversions **from the `string` type**, when the mask is not provided, is described here:

* To **integer**: First a `+` or `-` is possibly consumed to determine the sign of the integer; if it's not
  present, the sign is assumed to be positive. Finally, a sequence of digits is consumed to determine its 
  absolute value; leading zeroes are skipped.
* To **number**: First a `+` or `-` is possibly consumed to determine the sign of the number; if it's not
  present, the sign is assumed to be positive. Then a sequence of digits is consumed to determine the absolute
  value of the integer part of the number; leading zeroes are skipped. Then a `.` is possibly consumed; if it's 
  not present, the parsing ends and the number is returned without a decimal part. Otherwise, a sequence of 
  digits is consumed to determine its decimal part. Then `E` is possibly consumed to determine if a base-ten
  exponent is present; if its not present, the number is returned as it had an exponent of 0. Otherwise, a
  `+` or `-` is possibly consumed to determine the sign of the exponent; if it's not present, the sign is
  assumed to be positive. Finally a sequence of digits is consumed to determine the exponent, then the number
  is returned multiplied by the corresponding power of 10. Implementations may round the parsed number to
  the nearest representable decimal.
* To **date**: First, exactly four digits are consumed to determine the year in the gregorian calendar. Then a `-`
  is consumed. Then, exactly two digits are consumed to determine the month in the range 01-12. Then a `-` is 
  consumed again. Finally, exactly two digits are consumed to determine the day of the month in the range 
  determined by the month and the year, starting from 01. A `date` value is returned by combining the year, month
  and day of month determined this way.
* To **time**: the input string is parsed, according to the ISO-8601 standard for time intervals, up to a precision
  of days, and the corresponding `time` value is returned.
* To **time_period**: First, the input string is scanned to find a `/`; if one is found, the input string is parsed, 
  according to the ISO-8601 standard for time intervals up to a precision of days, and the corresponding `time_period`
  value is returned if its duration is an entire year, a half of a year, a quarter of a year or a month; if it's not,
  an error is raised. Otherwise, exactly four digits are consumed to determine the year in the gregorian calendar.
  Then, a `-` is consumed if present. Then one of either `H`, `Q`, `M` or `D` is possibly consumed to determine the
  duration of the period; if neither of these are present, a `time_period` representing the entire determined year
  is returned. If `H` is found, either `1` or `2` is consumed to determine which half year is covered, and a 
  `time_period` value representing that half of the determined year is returned. If `Q` is found, a digit from 1 to 
  4 is consumed to determine which quarter is covered, and a `time_period` value representing that quarter of the 
  determined year is returned. If `M` is found, `0` or `1` is possibly consumed, then another digit is consumed to
  determine which month is covered, and a `time_period` value representing that month of the determined year is 
  returned. Finally, if `D` is found, up to three digits are consumed to determine which day of year is covered, 
  and a `time_period` value representing that particular day of the determined year is returned.
* To **duration**: If the input string starts with `P`, the entire string is consumed and parsed, according to the
  ISO-8601 standard for durations up to a precision of days, and the corresponding `duration` value is returned.
  Otherwise, one of `A`, `S`, `Q`, `M`, `W` or `D` is consumed, and a `duration` value is returned representing the 
  duration respectively of a year, a half of a year, a quarter of a year, a month, a week and a day.

The default behavior of conversions **to the `string`** type, when the mask is not provided, is described here:

* From **integer**: the `integer` value is printed as a sequence of digits, without any leading zeroes
  or thousands separators, possibly preceded by a `-`.
* From **number**: the `number` value may be printed either in the scientific notation, or as a sequence of
  digits, possibly preceded by a `-`, with `.` as the decimal separator, without any leading zeroes
  or thousands separators.
* From **time**: the `time` value is printed using the ISO-8601 representation for generic time intervals,
  up to a maximum of day precision, in the form start/end.
* From **date**: the `date` value is printed using the ISO-8601 representation for dates, with the year,
  month and day of month fields always present.
* From **time_period**: the `time_period` value is printed using the ISO-8601 representation for generic time
  intervals, up to a precision of days, in the form start/end.
* From **duration**: the `duration` value is printed using the ISO-8601 representation for durations.

The table below summarises all the possible castings between the basic scalar types. In particular, the input type is
specified in the first column (row headings) and the output type in the first row (column headings).

.. csv-table::
   :file: conversionTable.csv
   :header-rows: 1
   :stub-columns: 1

