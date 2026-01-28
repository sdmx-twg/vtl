------
Syntax
------

    op **[ unpivot** identifier , measure **]**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - identifier
     - the Identifier Component to be created
   * - measure
     - the Measure Component to be created

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    DS_1 [ unpivot   Id_5,  Me_3 ]


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
All the measures of *op* must have the same basic scalar type, including sub-types.

---------
Behaviour
---------

The **unpivot** operator transposes a single Data Point of the operand Data Set into several Data Points of the
result Data set. Its semantics can be procedurally described as follows.

1. It creates a virtual Data Set VDS as a copy of *op*
2. It adds the Identifier Component *identifier* and the Measure Component *measure* to VDS
3. For each Data Point DP and for each Measure M of *op* whose value is not **null**, the operator 
   inserts a Data Point into VDS whose values are assigned as specified in the following points
4. The VDS Identifiers other than *identifier* are assigned the same values as the corresponding 
   Identifiers of the *op* Data Point
5. The VDS *identifier* is assigned a value equal to the **name** of the Measure M of *op*
6. The VDS *measure* is assigned a value equal to the **value** of the Measure M of *op*

The result of the last step is the output of the operation.

When a Measure is **null** then **unpivot** does not create a Data Point for that Measure.
Note that in general pivoting and unpivoting are not exactly symmetric operations, i.e., in some cases the unpivot
operation applied to the pivoted Data Set does not recreate exactly the original Data Set (before pivoting).
