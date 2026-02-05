------
Syntax
------

    op **[ aggr** aggrClause_ { groupingClause } **]**

        .. _aggrClause:
        
        aggrClause ::= { aggrRole_ } aggrComp := aggrExpr { , { aggrRole_ } aggrComp:= aggrExpr }*

                
        groupingClause ::= { **group by** groupingId {, groupingId }* 
                          | | **group except** groupingId {, groupingId }* 
                          | | **group all** conversionExpr }¹ 
                          | { **having** havingCondition }

        .. _aggrRole:
        
        aggrRole ::= **measure | attribute | viral attribute**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - aggrClause
     - | clause that specifies the required aggregations, i.e., the aggregated
       | Components to be calculated, their roles and their calculation algorithm,
       | to be applied on the joined and filtered Data Points
   * - aggrRole
     - the role of the aggregated Component to be calculated
   * - aggrComp
     - | the name of the aggregated Component to be calculated; this is a dependent
       | Component of the result (Measure or Attribute, not Identifier)
   * - aggrExpr
     - | expression at component level, having only Components of the input Data Sets
       | as operands, which invokes an aggregate operator (e.g. **avg, count, max**...,
       | see also the corresponding sections) to perform the desired aggregation.
       | Note that the **count** operator is used in an *aggrClause* without parameters, e.g.:
       |    *DS_1 [ aggr Me_1 := count ( ) group by Id_1 ) ]*
   * - groupingClause
     - | the following alternative grouping options:
       |    · **group by**: the Data Points are grouped by the values of the specified
       |    Identifiers (*groupingId*). The Identifiers not specified are dropped in the result.
       |    · **group except**: the Data Points are grouped by the values of the Identifiers
       |    not specified as *groupingId*. The Identifiers specified as *groupingId* are
       |    dropped in the result.
       |    · **group all**: converts the values of an Identifier Component using *conversionExpr*
       |    and keeps all the resulting Identifiers.
   * - groupingId
     - | Identifier Component to be kept (in the **group by** clause) or dropped 
       | (in the **group except** clause).
   * - conversionExpr
     - | specifies a conversion operator (e.g., **time_agg**) to convert an Identifier
       | from finer to coarser granularity. The conversion operator is applied on an
       | Identifier of the operand Data Set *op*.
   * - havingCondition
     - | a condition (*boolean* expression) at component level, having only Components
       | of the input Data Sets as operands (and possibly constants), to be fulfilled
       | by the groups of Data Points: only groups for which *havingCondition* evaluates
       | to **true** appear in the result. The *havingCondition* refers to the groups
       | specified through the *groupingClause*, therefore it must invoke aggregate operators
       | (e.g. **avg, count, max**..., see also the section Aggregate invocation).
       | A correct example of *havingCondition* is:
       |    *max(obs_value) < 1000*
       | instead the condition *obs_value < 1000* is not a right *havingCondition*, because it
       | refers to the values of the single Data Points and not to the groups.
       | The **count** operator is used in a *havingCondition* without parameters, e.g.:
       |    *sum (DS_1 group by id1 having count ( ) >= 10 )*


------------------------------------
Examples of valid syntaxes
------------------------------------
::

  DS_1 [ aggr M1 := min ( Me_1 ) group by  Id_1, Id_2  ]
  DS_1 [ aggr M1 := min ( Me_1 ) group except  Id_1, Id_2 ]


------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset

aggrComp ::

    name<component>

aggrExpr ::

    component<scalar>

groupingId ::

    name<identifier>

conversionExpr ::

    identifier<scalar>

havingCondition ::

    component<boolean>

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
The *aggrComp* parameter cannot be the name of an Identifier component.

All the components used in *aggrExpr* must belong to the operand Data Set *op*.

The *conversionExpr* parameter applies just one conversion operator to just one Identifier belonging to the input
Data Set. The basic scalar type of the Identifier must be compatible with the basic scalar type of the conversion operator.

---------
Behaviour
---------

The operator **aggr** calculates aggregations of dependent Components (Measures or Attributes) on the basis of
sub-expressions at Component level. Each Component is calculated through an independent sub-expression. It is
possible to specify the role of the calculated Component among **measure**, **attribute**, or **viral attribute**. The
substring **viral** allows to control the virality of Attributes, if the Attribute propagation rule is adopted (see the
User Manual). When the role is omitted, the following rule is applied: if the component exists in the operand Data
Set then it maintains its role; if the component does not exist in the operand Data Set then its role is Measure.

The *aggrExpr* sub-expressions are independent of one another, they can only reference Components of the input
Data Set and cannot use Components generated, for example, by other *aggrExpr* sub-expressions. The **aggr**
computed Measures and Attributes are the only Measures and Attributes returned in the output Data Set (plus
the possible viral Attributes). The sub-expressions must contain only Aggregate operators, which are able to
compute an aggregated Value relevant to a group of Data Points. The groups of Data Points to be aggregated are
specified through the *groupingClause*, which allows the following alternative options.

.. list-table::

   * - group by
     - | by the Data Points are grouped by the values of the specified Identifiers.
       | The Identifiers not specified are dropped in the result.
   * - group except
     - | the Data Points are grouped by the values of the Identifiers not specified in
       | the clause. The specified Identifiers are dropped in the result.
   * - group all
     - | converts an Identifier Component using *conversionExpr* and keeps all the
       |  other Identifiers.

The **having** clause is used to filter groups in the result by means of an aggregate condition evaluated on the
single groups (for example the minimum number of Data Points in the group).

If no grouping clause is specified, then all the input Data Points are aggregated in a single group and the clause
returns a Data Set that contains a single Data Point and has no Identifiers.

The Attributes calculated through the **aggr** clauses are maintained in the result. For all the other Attributes that
are defined as **viral**, the Attribute propagation rule is applied (for the semantics, see the Attribute Propagation
Rule section in the User Manual).
