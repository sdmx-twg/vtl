------
Syntax
------


    **full_join** **(** ds1 { **as** alias1 }, ds2 { **as** alias2 } { , dsN { **as** aliasN } }* 
      | { **filter** filterCondition }
      | { **apply** applyExpr 
      | |     **calc** calcClause_ 
      | |     **aggr** aggrClause_ { groupingClause_ } }
      | { **keep** comp {, comp }* | **drop** comp {, comp }* }
      | { **rename** compFrom **to** compTo { , compFrom **to** compTo }* } **)**

        .. _calcClause:

        calcClause ::= { calcRole } calcComp **:=** calcExpr { , { calcRole } calcComp **:=** calcExpr }*

        .. _calcRole:

        calcRole ::= { **identifier | measure | attribute | viral attribute** }¹

        .. _aggrClause:

        aggrClause ::= { aggrRole_ } aggrComp **:=** aggrExpr { , { aggrRole_ } aggrComp **:=** aggrExpr }*

        .. _aggrRole:

        aggrRole ::= { **measure | attribute | viral attribute** }¹

        .. _groupingClause:

        groupingClause ::= { **group by** groupingId { , groupingId }* | **group except** groupingId { , groupingId }* | **group all** conversionExpr }¹ { **having** havingCondition }

----------------
Input parameters
----------------
.. list-table::

   * - ds1, ..., dsN
     - a minimum of two data set operands
   * - alias
     - | optional aliases for the input data sets, valid only within the “join” operation
       | to make it easier to refer to them. If omitted, the data set name must be used.
   * - filterCondition
     - | a condition (*boolean* expression) at component level, having only Components
       | of the input data sets as operands, which is evaluated for each joined
       | Data Point and filters them (when **true** the joined Data Point is kept,
       | otherwise it is not kept)
   * - applyExpr
     - | an expression, having the input data sets as operands, which is pairwise applied
       | to all their homonym Measure Components and produces homonym Measure
       | Components in the result; for example if both the data sets *ds1* and *ds2*
       | have the numeric measures *m1* and *m2*, the clause *apply ds1 + ds2* would
       | result in calculating *m1 := ds1#m1 + ds2#m1 and m2 := ds1#m2 + ds2#m2*
   * - calcClause
     - | clause that specifies the Components to be calculated, their roles and their
       | calculation algorithms, to be applied on the joined and filtered Data Points.
   * - calcRole
     - the role of the Component to be calculated
   * - calcComp
     - the name of the Component to be calculated
   * - calcExpr
     - | expression at component level, having only Components of the input
       | data sets as operands, used to calculate a Component
   * - aggrClause
     - | clause that specifies the required aggregations, i.e., the aggregated
       | Components to be calculated, their roles and their calculation algorithm,
       | to be applied on the joined and filtered Data Points
   * - aggrRole
     - | the role of the aggregated Component to be calculated;
       | if omitted, the Measure role is assumed
   * - aggrComp
     - | the name of the aggregated Component to be calculated; this is a dependent
       | Component of the result (Measure or Attribute, not Identifier)
   * - aggrExpr
     - | expression at component level, having only Components of the input
       | data sets as operands, which invokes an aggregate operator
       | (e.g. **avg, count, max**..., see also the corresponding sections)
       | to perform the desired aggregation. Note that the **count**
       | operator is used in an aggrClause without parameters, e.g.:
       |    *DS_1 [ aggr Me_1 := count ( ) group by Id_1 ) ]*
   * - groupingClause
     - | see the section "Aggregate Operators"
   * - groupingId
     - | see the section "Aggregate Operators"
   * - conversionExpr
     - | see the section "Aggregate Operators"
   * - havingCondition
     - | see the section "Aggregate Operators"
   * - comp
     - | dependent Component (Measure or Attribute, not Identifier) to be kept
       | (in the **keep** clause) or dropped (in the **drop** clause)
   * - compFrom
     - the original name of the Component to be renamed
   * - compTo
     - the new name of the Component after the renaming

--------------------------
Examples of valid syntaxes
--------------------------
.. code-block::

  full_join ( ds1 as d1,  ds2 as d2
              filter d1#Me1 + d2#Me1 <10, 
              aggr Me1 := sum(Me1), attribute At20 := avg(Me2)
              group by  Id1, Id2 
              having sum(Me3) > 0 
              )

--------------------------------
Semantics  for scalar operations
--------------------------------
The join operator does not perform scalar operations.

---------------------
Input parameters type
---------------------
ds1, …, dsN  ::

    dataset

alias1, …, aliasN  ::

    name

filterCondition ::

    component<boolean>

applyExpr ::

    dataset

calcComp ::

    name<component>

calcExpr ::

    component<scalar>

aggrComp ::

    name<component>

aggrExpr ::

    component<scalar>

groupingId ::

    name<identifier>

conversionExpr ::

    component<scalar>

havingCondition ::

    component<boolean>

comp ::

    name<component>

compFrom ::

    component<scalar>

compTo ::

    component<scalar>

-----------
Result type
-----------
result ::

    dataset

----------------------
Additional Constraints
----------------------
The aliases must be all distinct, and are mandatory for data sets which appear more than once in the Join (self-join)
and for non-named data set obtained as result of a sub-expression.

Let :math:`I^i := \{\,I^i_j \mid j = 1,\ldots,m^i,\ I^i_j \text{is an identifier}\,\}`, with :math:`\forall i = 1,\ldots,n`
denote the set of identifiers of i-th join operand :math:`DS_i`, in any order. **full_join** requires that 
:math:`\exists\, I^c \mid I^c = I^i = I^j,\ \forall i,j = 1,\ldots,n`, or in other words, all the input data sets
must have exactly the same identifiers. 

The **full_join** operator must fulfil also other constraints:

* **apply**, **calc** and **aggr** clauses are mutually exclusive
* **keep** and **drop** clauses are mutually exclusive
* `comp` can be only dependent Components (Measures and Attributes, not Identifiers)
* An Identifier not included in the **group by** clause (if any) cannot be included in the **rename** clause
* An Identifier included in the **group except** clause (if any) cannot be included in the **rename** clause. 
  If the **aggr** clause is invoked and the grouping clause is omitted, no Identifier can be included in the **rename** clause
* A dependent Component not included in the **keep** clause (if any) cannot be renamed
* A dependent Component included in the **drop** clause (if any) cannot be renamed

---------
Behaviour
---------

First, the join keys are selected implicitly as all the identifiers are common to all the input datasets. Then
a *relational join* of the input operands is performed, by matching the join keys according to SQL full outer join
(**full_join**).

The SQL relational join produces an intermediate result, called **virtual data set** (VDS₁); this virtual data set
VDS₁ has the following components:

* The join keys, which appear once and maintain their names and roles;
* The remaining non-identifier components coming from exactly one input data set, which appear once and maintain
  their original name and role.
* The remaining non-identifier components coming from multiple data sets, which appear as many times as the data
  sets they come from; names of each of these components are prefixed with the alias of the data set they come from,
  separated by the “`#`” symbol; in this context, the symbol “`#`” does not denote the membership operator, but acts
  just as a separator between the data set and the component name. If the aliases are not defined, the names are
  prefixed with the data set name. If the data set name can't be determined (for example the join operand is an 
  expression), an error is raised. For example, if “`population`” appears in two input data sets “`ds1`” and “`ds2`”, 
  that have the aliases “`a`” and “`b`” respectively, both “`a#population`” and “`b#population`” will appear in the
  virtual Data Set; If the aliases were not specified, the names must be used (i.e. “`ds1#population`” and 
  “`ds2#population`”). 

Then, subsequent clauses in the **full_join** are procedurally evaluated on the virtual data set VDS₁ as follows.

#. The **filter** is applied on VDS₁, if present, producing the Virtual data set VDS₂. It operates by filtering the
   data points to match a specified boolean expression; when the expression is **true** the Data Point is kept in 
   the result, otherwise it is discarded.
#. Either one of the **apply**, **calc** or **aggr** expressions, if present, are applied on VDS₂ producing VDS₃:
   
   * **apply** combines the homonym Measures in the source operands whose type is compatible with the
     operators used in `applyExpr`, for each of them generating a single measures. The expression *applyExpr*
     can use as input the names or aliases of the operand data sets. It applies the expression to each of the n-uple
     of homonym Measures in the input data sets producing in the target a single homonym Measure for
     each n-uple. It can be thought of as the multi-measure version of the **calc**. For example, if `d1`, `d2`, 
     and `d3` are data sets with two measures each named `M1` and `M2`, then the expression `d1+d2+d3`, respectively
     sums the values of `M1` and `M2`, so as to obtain in the result: 
     `calc M1 := d1#M1 + d2#M1 + d3#M1, M2 := d1#M2 + d2#M2 + d3#M2`. All the input measures do not appear in VDS₂.
   * **calc** calculates new components by independent sub-expressions evaluated at component level. The role of the 
     new components can be specified, so the original role can be changed if the name is kept the same; if the role
     is not specified, it will be **measure**. Each sub-expression can only reference components in VDS₂, and cannot
     use components generated by other sub-expressions. If a generated component already exists in any of the input
     data sets, all input components homonymous to the former are removed, and only the generated component is kept;
     if any of the removed components were identifiers, an error is raised. Analytic operators can be used in the 
     expressions.
   * **aggr** aggregates values of non-identifier components by indipendent sub-expressions evaluated at component
     level. The role of the components can be specified, so the original role can be changed if the name is kept the
     same; if the role is not specified, it will be **measure**. All non-identifier components are removed, and only
     the components generated by the sub-expressions are kept; if any of the removed components were identifiers,
     an error is raised. The sub-expressions must contain only Aggregate operators, which may specify a grouping 
     clause and/or a filtering expression, as specified in the section for "Aggregation operators". If no grouping
     clause is specified, then all the input Data Points are aggregated in a single group and the clause returns a
     data set that contains a single Data Point and has no Identifier Components.
#. Either a **keep** or **drop** clause, whichever is present, is applied on VDS₃, producing the Virtual data set VDS₄:

   * **keep** will maintain all the identifiers and only the specified non-identifier components of VDS₃; 
   * **drop** will remove all specified non-identifier components of VDS₃.
#. The **rename** clause, if present, is applied on VDS₄, producing the Virtual data set VDS₅ by giving each 
   specified component with a new name. If the chosen name already exists in VDS₄, an error is raised.
#. Finally, all components that originally appeared in multiple input data sets, are renamed by stripping their
   previously determined prefix; if this step determines a structure with homonymous components, an error is raised.

The **contents of full_join** are ideally determined stepwise, using the left-most data set as the initial partial
result, and joining the partial result with each of the other input data sets in turn, starting from the left side
and proceeding towards the right side. In each step, first a data point in VDS₁ is generated for each datapoint in
the partial result; if the corresponding set of key values aren't found in the joined data set of the current step, 
the relevant Measures and Attributes coming from that data set take the null value of their respective domains if
they allow null values; otherwise an error is raised. Then, additional data points are generated for all the data
points in the joined data set of the current step, which have not already been used; if the corresponding set of key
values aren't found in the partial result, the relevant Measures and Attributes coming from it take the null value
of their respective domains if they allow null values; otherwise an error is raised. Finally, the step is repeated
by joining this partial result to the next data set. 

The **Viral Attribute propagation** in the join is the following. The Attributes explicitly calculated through the **calc**
or **aggr** clauses are maintained unchanged. Other viral attributes, present in exactly one input data set, are also kept
unchanged. For all the other viral attributes, which are present in multiple data sets, the Attribute propagation rule is
applied on VDS₂ (see "Attribute Propagation Rule" section in the User Manual).