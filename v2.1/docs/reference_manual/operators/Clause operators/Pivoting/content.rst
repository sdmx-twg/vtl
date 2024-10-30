------
Syntax
------

    op **[ pivot** identifier , measure **]**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - identifier
     - the Identifier Component of *op* to pivot
   * - measure
     - the Measure Component of *op* to pivot

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    DS_1 [ pivot  Id_2,  Me_1 ]

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset

identifier ::

    name<identifier>

measure ::

    name<measure>

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
The Measures created by the operator according to the behaviour described below must be defined on the same
Value Domain as the input Measure.

---------
Behaviour
---------

The operator transposes several Data Points of the operand Data Set into a single Data Point of the resulting Data
Set. The semantics of **pivot** can be procedurally described as follows.

1. It creates a virtual Data Set VDS as a copy of *op*
2. It drops the Identifier Component identifier and all the Measure Components from VDS.
3. It groups VDS by the values of the remaining Identifiers.
4. For each distinct value of *identifier* in *op*, it adds a corresponding measure to VDS, named as the value of 
   *identifier*. These Measures are initialized with the NULL value.
5. For each Data Point of *op*, it finds the Data Point of VDS having the same values as for the common Identifiers and 
   assigns the value of *measure* (taken from the current Data Point of *op*) to the Measure of VDS having the same name
   as the value of *identifier* (taken from the Data Point of *op*).

The result of the last step is the output of the operation.

Note that **pivot** may create Measures whose names are non-regular (i.e. they may contain special characters,
reserved keywords, etc.) according to the rules about the artefact names described in the User Manual (see the
section “The artefact names” in the chapter “VTL Transformations”). As said in the User Manual, those names
must be quoted to be referenced within an expression.
