------
Syntax
------

* In a Data Set expression:

  aggregateOperator_ **(** firstOperand { , additionalOperand }* { groupingClause } **)**


* In a Component expression within an aggr clause:


  aggregateOperator_ **(** firstOperand { , additionalOperand }* **)** { groupingClause }


    .. _aggregateOperator:

    aggregateOperator ::= **avg | count | max | median | min | stddev_pop | stddev_samp | sum | var_pop | var_samp**


    groupingClause ::= 
      |  { **group by** groupingId {, groupingId}* 
      |   | **group except** groupingId {, groupingId}* 
      |   | **group all** conversionExpr }¹ (*)
      | { **having** havingCondition }

(*) This option is deprecated

----------------
Input parameters
----------------
.. list-table::

   * - aggregateOperator
     - the keyword of the aggregate operator to invoke (e.g., avg, count, max...)
   * - firstOperand
     - | the first operand of the invoked aggregate operator (a Data Set for an invocation
       | at Data Set level or a Component of the input Data Set for an invocation at
       | Component level within an **aggr** operator or an **aggr** clause in a join operation)
   * - additionalOperand
     - | an additional operand (if any) of the invoked operator. The various operators
       | can have a different number of parameters. The number of parameters, their
       | types and if they are mandatory or optional depend on the invoked operator
   * - groupingClause
     - | the following alternative grouping options:
       | · **group by**: the Data Points are grouped by the values of the specified Identifiers
       | (*groupingId*). The Identifiers not specified are dropped in the result.
       | · **group except**: the Data Points are grouped by the values of the Identifiers not
       | specified as *groupingId*. The Identifiers specified as *groupingId* are
       | dropped in the result.
       | · **group all**: converts the values of an Identifier Component using *conversionExpr*
       | and keeps all the resulting Identifiers.
   * - groupingId
     - | Identifier Component to be kept (in the **group by** clause) or dropped (in the
       | **group except** clause).
   * - conversionExpr
     - | specifies a conversion operator (e.g., **time_agg**) to convert data from finer to
       | coarser granularity. The conversion operator is applied on an Identifier of the
       | operand Data Set *op*.
   * - havingCondition
     - | a condition (*boolean* expression) at component level, having only Components of
       | the input Data Sets as operands (and possibly constants), to be fulfilled by the
       | groups of Data Points: only groups for which *havingCondition* evaluates to **true**
       | appear in the result. The *havingCondition* refers to the groups specified through
       | the *groupingClause*, therefore it must invoke aggregate operators (e.g. **avg**,
       | **count**, **max**, ..., see also the corresponding sections). A correct example
       | of *havingCondition* is: *max(obs_value) < 1000*, while the condition
       | *obs_value < 1000* is not a right havingCondition, because it refers to the values
       | of single Data Points and not to the groups. The count operator is used in a
       | *havingCondition* without parameters, e.g.:
       | *sum ( ds group by id1 having count () >= 10 )* .


------------------------------------
Examples of valid syntaxes
------------------------------------
::

  avg ( DS_1 )
  avg ( DS_1 group by Id_1, Id_2  )
  avg ( DS_1 group except  Id_1, Id_2  )
  avg ( DS_1 group all time_agg ( "Q" ) )


------------------------------------
Semantics  for scalar operations
------------------------------------
The aggregate operators cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
firstOperand ::

    dataset
    | component

additionalOperand ::

    see the type of the additional parameter (if any) of the invoked
    aggregateOperator. The aggregate operators and their parameters are
    described in the following sections.

groupingId ::

    name < identifier >

conversionExpr ::

    identifier

havingCondition ::

    component < boolean >

-----------------------------
Result type
-----------------------------
result ::

    dataset
    | component

-----------------------------
Additional Constraints
-----------------------------
The Aggregate invocation cannot be nested in other Aggregate or Analytic invocations.

The aggregate operations at component level can be invoked within the **aggr** clause, both as part of a join
operator and the **aggr** operator (see the parameter *aggrExpr* of those operators).

The basic scalar types of *firstOperand* and *additionalOperand* (if any) must be compliant with the specific basic
scalar types required by the invoked operator (the required basic scalar types are described in the table at the
beginning of this chapter and in the sections of the various operators below).

The *conversionExpr* parameter applies just one conversion operator to just one Identifier belonging to the input
Data Set. The basic scalar type of the Identifier must be compatible with the basic scalar type of the conversion
operator.

If the grouping clause is omitted, then all the input Data Points are aggregated in a single group and the clause
returns a Data Set that contains a single Data Point and has no Identifiers.

---------
Behaviour
---------

The *aggregateOperator* is applied as usual to all the measures of the *firstOperand* Data Set (if invoked at Data
Set level) or to the *firstOperand* Component of the input Data Set (if invoked at Component level). In both cases,
the operator calculates the required aggregated values for groups of Data Points of the input Data Set. The
groups of Data Points to be aggregated are specified through the groupingClause, which allows the following
alternative options.

.. list-table::

   * - **group by**
     - | the Data Points are grouped by the values of the specified Identifiers.
       | The Identifiers not specified are dropped in the result.
   * - **group except**
     - | the Data Points are grouped by the values of the Identifiers not specified
       | in the clause. The specified Identifiers are dropped in the result.
   * - **group all**
     - converts an Identifier Component using *conversionExpr* and keeps all the Identifiers.

The **having** clause is used to filter groups in the result by means of an aggregate condition evaluated on the
single groups (for example the minimum number of rows in the group).

If no grouping clause is specified, then all the input Data Points are aggregated in a single group and the operator
returns a Data Set that contains a single Data Point and has no Identifiers.

For the invocation at Data Set level, the resulting Data Set has the same Measures as the operand. For the
invocation at Component level, the resulting Data Set has the Measures explicitly calculated (all the other
Measures are dropped because no aggregation behaviour is specified for them).

For invocation at Data Set level, the Attribute propagation rule is applied. For invocation at Component level,
the Attributes calculated within the *aggr* clause are maintained in the result; for all the other Attributes that are
defined as **viral**, the Attribute propagation rule is applied (for the semantics, see the Attribute Propagation Rule
section in the User Manual).

As mentioned, the Aggregate invocation at component level can be done within the **aggr** clause, both as part of a
Join operator and the **aggr** operator (see the parameter *aggrExpr* of those operators), therefore, for a better
comprehension fo the behaviour at Component level, see also those operators.
