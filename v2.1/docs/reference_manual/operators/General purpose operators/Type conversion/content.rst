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

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator converts the scalar type of `op` to the scalar type specified by `scalarType`. It returns a copy of `op`
converted to the specified `scalarType`.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset{ measure<scalar> _ }
    | component<scalar>
    | scalar

scalarType ::

    scalar type (see the section: Data type syntax)

mask ::

    string

-----------------------------
Result type
-----------------------------
result ::

    dataset{ measure<scalar> _ }
    | component<scalar>
    | scalar

-----------------------------
Additional Constraints
-----------------------------
* Not all the conversions are possible, the specified casting operation is allowed only according to the
  semantics described below.
* The `mask` must adhere to one of the formats specified below.

---------
Behaviour
---------

**Conversions between basic scalar types**

The VTL assumes that a basic scalar type has a unique internal and more possible external representations (formats).

The external representations are those of the Value Domains which refers to such a basic scalar types (more
Value Domains can refer to the same basic scalar type, see the VTL Data Types in the User Manual). For example,
there can exist a *boolean* Value Domain which uses the values TRUE and FALSE and another *boolean* Value
Domain which uses the values 1 and 0. The external representations are the ones of the Data Point Values and
are obviously known by users.

The unique internal representation of a basic scalar type, instead, is used by the **cast** operator as a technical
expedient to make the conversion between external representations easier: users are not necessarily aware of it. 
In a conversion, the **cast** converts the source external representation into the internal representation (of the
corresponding scalar type), then this last one is converted into the target external representation (of the target
type). As mentioned in the User Manual, VTL does not prescribe any specific internal representation for the
various scalar types, leaving different organisations free of using their preferred or already existing ones.

In some cases, depending on the type of `op`, the output `scalarType` and the invoked operator, an automatic
conversion is made, that is, even without the explicit invocation of the **cast** operator: this kind of conversion is
called **implicit casting**.

In other cases, more than all when the implicit casting is not possible, the type conversion must be specified
explicitly through the invocation of the **cast operator**: this kind of conversion is called **explicit casting**. If an
explicit casting is specified, the (possible) implicit casting is overridden; the explicit conversion requires a formatting 
mask that specifies how the actual casting is performed.

The table below summarises the possible castings between the basic scalar types. In particular, the input type is
specified in the first column (row headings) and the output type in the first row (column headings).

.. csv-table::
   :file: conversionTable.csv
   :header-rows: 1
   :stub-columns: 1

The type of casting can be personalised in specific environments, provided that the personalisation is explicitly
documented with reference to the table above. For example, assuming that an explicit **cast** with `mask` is
required and that in a specific environment a definite `mask` is used for such a kind of conversions, the **cast** can
also become implicit provided that the mask that will be applied is specified.

The **implicit casting** is performed when a value of a certain type is provided when another type is expected. Its
behaviour is described here:

* From **integer** to **number**: an `integer` is provided when a `number` is expected (for example, an `integer`
  and a `number` are passed as inputs of a n-ary numeric operator); it returns a `number` having the integer part equal 
  to the `integer` and the decimal part equal to zero;
* From **integer** to **string**: an `integer` is provided when a `string` is expected (for example, an `integer` is passed
  as an input of a `string` operator); it returns a `string` having the literal value of the `integer`;
* From **number** to **string**: a `number` is provided when a `string` is expected; it returns the `string` having the
  literal value of the `number`; the decimal separator is converted into the character “.” (dot).
* From **boolean** to **string**: a `boolean` is provided when a `string` is expected; the `boolean` value TRUE is
  converted into the `string` “TRUE” and FALSE into the `string` “FALSE”;
* From **date** to **time**: a `date` (point in time) is provided when a `time` is expected (interval of time): the
  conversion results in an interval having the same start and end, both equal to the original `date`;
* From **time_period** to **time**: a *time_period* (a regular interval of *time*, like a month, a quarter, a year...) is
  provided when a *time* (any interval of time) is expected; it returns a *time* value having the same start and
  end as the *time_period* value.
* From **integer** to **boolean**: if the `integer` is different from 0, then TRUE is returned, FALSE otherwise.
* From **number** to **integer**: converts a `number` with no decimal part into an `integer`; 
  if the decimal part is present, a runtime error is raised. 
*	From **number** to **boolean**: if the `number` is different from 0.0, then TRUE is returned, FALSE otherwise.
* From **boolean** to **integer**: TRUE is converted into 1; FALSE into 0.
*	From **boolean** to **number**: TRUE is converted into 1.0; FALSE into 0.0.
*	From **time_period** to **string**:  it is applied the `time_period` formatting mask.
*	From **string** to **integer**: the `integer` having the literal value of the `string` is returned; if the `string` contains a literal that cannot be matched to an `integer`, a runtime error is raised.
  

An implicit cast is also performed from a **value domain type** or a **set type** to a **basic scalar type**: when a *scalar*
value belonging to a Value Domains or a Set is involved in an operation (i.e., provided as input to an operator),
the value is implicitly cast into the basic scalar type which the Value Domain refers to (for this relationship, see
the description of Type System in the User Manual). For example, assuming that the Component `birth_country` is
defined on the Value Domain `country`, which contains the ISO 3166-1 numeric codes and therefore refers to the
basic scalar type `integer`, the (possible) invocation ``length(birth_country)``, which calculates the length of the input
string, automatically casts the values of `birth_countr` into the corresponding string. If the basic scalar type of the
Value Domain is not compatible with the expression where it is used, an error is raised. This VTL feature is
particularly important as it provides a general behaviour for the Value Domains and relevant Sets, preventing
from the need of defining specific behaviours (or methods or operations) for each one of them. In other words,
all the Values inherit the operations that can be performed on them from the basic scalar types of the respective
Value Domains.

The **cast** operator can be invoked explicitly even for the conversions which allow an implicit cast and in this case
the same behaviour as the implicit cast is applied.

When an **explicit casting with mask** is required, the conversion is made by applying the formatting mask which specifies 
the meaning of the characters in the output `string`. The formatting Masks are described in the section “VTL-ML – Typical Behaviour 
of the ML Operators”, sub-section “Type Conversion and Formatting Mask. 

The behaviour of the **cast** operator for such conversions is the following:

* From **time** to **string**: it is applied the `time` formatting mask.
*	From **date** to **time_period**: it converts a `date` into the corresponding daily value of `time_period`.
* From **date** to **string**: it is applied the `time_period` formatting mask.
* From **time_period** to **date**: it is applied a formatting mask which accepts two possible values (“START”,
  “END”). If “START” is specified, then the `date` is set to the beginning of the `time_period`; if `END` is specified,
  then the `date` is set to the end of the `time_period`.
* From **string** to **number**: the `number` having the literal value of the `string` is returned; if the `string` contains a
  literal that cannot be matched to a `number`, a runtime error is raised. The `number` is generated by using a
  `number` formatting mask.
* From **string** to **time**: the `time` having the literal value of the `string` is returned; if the `string` contains a literal
  that cannot be matched to a `date`, a runtime error is raised. The `time` value is generated by using a `time`
  formatting mask.
*	From **string** to **date**: it converts a `string` value to a `date` value.
*	From **string** to **time_period**: it converts a `string value` to a `time_period` value.
* From **string** to **duration**: the `duration` having the literal value of the `string` is returned; if the `string` contains
  a literal that cannot be matched to a `duration`, a runtime error is raised. The `duration` value is generated by
  using a `time` formatting mask.
*	From **duration** to **string**: a `duration` (an absolute time interval) is provided when a `string` is expected; it returns the `string` having the default `string` representation for the `duration`.


**Conversions between basic scalar types and Value Domains or Set types**

A value of a basic `scalar` type can be converted into a value belonging to a Value Domain which refers to such a
`scalar` type. The resulting `scalar` value must be one of the allowed values of the Value Domain or Set; otherwise, a
runtime error is raised. This specific use of **cast** operators does not really correspond to a type conversion; in
more formal terms, we would say that it acts as a constructor, i.e., it builds an instance of the output type. Yet,
towards a homogeneous and possibly simple definition of VTL syntax, we blur the distinction between
constructors and type conversions and opt for a unique formalism. An example is given below.

**Conversions between different Value Domain types**

As a result of the above definitions, conversions between values of different Value Domains are also possible.
Since an element of a Value Domain is implicitly cast into its corresponding basic scalar type, we can build on it
to turn the so obtained scalar type into another Value Domain type. Of course, this latter Value Domain type must
use as a base type this scalar type.
