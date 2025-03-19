------
Syntax
------


    joinOperator_ **(** ds1 { **as** alias1 }, ds2 { **as** alias2 } { , dsN { **as** aliasN } }* 
      | { **using** usingComp { , usingComp }* }
      | { **filter** filterCondition }
      | { **apply** applyExpr 
      | |     **calc** calcClause_ 
      | |     **aggr** aggrClause_ { groupingClause_ } }
      | { **keep** comp {, comp }* | **drop** comp {, comp }* }
      | { **rename** compFrom **to** compTo { , compFrom **to** compTo }* } **)**

        .. _joinOperator:
  
        joinOperator: { **inner_join | left_join | full_join | cross_join** }¹

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

   * - joinOperator
     - the Join operator to be applied
   * - ds1, ..., dsN
     - the Data Set operands (at least two must be present) [1]_
   * - alias
     - | optional aliases for the input Data Sets, valid only within the “join” operation
       | to make it easier to refer to them. If omitted, the Data Set name must be used.
   * - usingComp
     - | component of the input Data Sets whose values have to match in the join (the
       | **using** clause is allowed for the **left_join** only under certain constraints
       | described below and is not allowed at all for the **full_join** and **cross_join**)
   * - filterCondition
     - | a condition (*boolean* expression) at component level, having only Components
       | of the input Data Sets as operands, which is evaluated for each joined
       | Data Point and filters them (when TRUE the joined Data Point is kept,
       | otherwise it is not kept)
   * - applyExpr
     - | an expression, having the input Data Sets as operands, which is pairwise applied
       | to all their homonym Measure Components and produces homonym Measure
       | Components in the result; for example if both the Data Sets *ds1* and *ds2*
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
       | Data Sets as operands, used to calculate a Component
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
       | Data Sets as operands, which invokes an aggregate operator
       | (e.g. **avg, count, max**..., see also the corresponding sections)
       | to perform the desired aggregation. Note that the **count**
       | operator is used in an aggrClause without parameters, e.g.:
       |    *DS_1 [ aggr Me_1 := count ( ) group by Id_1 ) ]*
   * - groupingClause
     - | the following alternative grouping options:
       |    · **group by**: the Data Points are grouped by the values of
       |    the specified Identifiers (*groupingId*). The Identifiers not
       |    specified are dropped in the result.
       |    · **group except**: the Data Points are grouped by the values of
       |    the Identifiers not specified as *groupingId*. The specified
       |    Identifiers are dropped in the result.
       |    · **group all**: converts the values of an Identifier Component
       |    using *conversionExpr* and keeps all the resulting Identifiers.
   * - groupingId
     - | Identifier Component to be kept (in the **group by** clause)
       | or dropped (in the **group except** clause).
   * - conversionExpr
     - | specifies a conversion operator (e.g. **time_agg**) to convert an
       | Identifier from finer to coarser granularity. The conversion
       | operator is applied on an Identifier of the operand Data Set.
   * - havingCondition
     - | a condition (*boolean* expression) at component level, having only Components
       | of the input Data Sets as operands (and possibly constants), to be fulfilled
       | by the groups of Data Points: only groups for which *havingCondition* evaluates
       | to TRUE appear in the result. The *havingCondition* refers to the groups specified
       | through the *groupingClause*, therefore it must invoke aggregate operators
       | (e.g. *avg, count, max*..., see also the section Aggregate invocation). A correct
       | example of *havingCondition* is *max(obs_value) < 1000*, while the condition
       | *obs_value < 1000* is not a right *havingCondition*, because it refers to the
       | values of single Data Points and not to the groups. The count operator is used
       | in a *havingCondition* without parameters, e.g.:
       |    *sum ( ds group by id1 having count ( ) >= 10 )*
   * - comp
     - | dependent Component (Measure or Attribute, not Identifier) to be kept
       | (in the **keep** clause) or dropped (in the **drop** clause)
   * - compFrom
     - the original name of the Component to be renamed
   * - compTo
     - the new name of the Component after the renaming


.. [1] In the previous versions for inner_join only one Data Set operand had to be specified; 
       to be more consistent and similarly to SQL syntax, at least to operands are required.

------------------------------------
Examples of valid syntaxes
------------------------------------
.. code-block::

  inner_join  ( ds1 as d1,  ds2 as d2 using Id1, Id2
              filter d1#Me1 + d2#Me1 <10
              apply  d1 / d2
              keep Me1, Me2, Me3 
              rename Id1 to Id10, id2 to id20
              )
  left_join ( ds1 as d1,  ds2 as d2
              filter d1#Me1 + d2#Me1 <10, 
              calc Me1 := d1#Me1 + d2#Me3,
              keep  Me1 
              rename Id1 to Ident1, Me1 to Meas1
              )
  full_join ( ds1 as d1,  ds2 as d2
              filter d1#Me1 + d2#Me1 <10, 
              aggr Me1 := sum(Me1), attribute At20 := avg(Me2)
              group by  Id1, Id2 
              having sum(Me3) > 0 
              )

------------------------------------
Semantics  for scalar operations
------------------------------------
The join operator does not perform scalar operations.

-----------------------------
Input parameters type
-----------------------------
ds1, …, dsN  ::

    dataset

alias1, …, aliasN  ::

    name

usingId ::

    name<component>

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

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
The aliases must be all distinct and different from the Data Set names. Aliases are mandatory for Data Sets which
appear more than once in the Join (self-join) and for non-named Data Set obtained as result of a sub-expression.
The *using* clause is not allowed for the **full_join** and for the **cross_join**, because otherwise a non-functional
result could be obtained.

If the `using` clause is not specified (we will label this case as “Case A”), calling `Id(dsᵢ)` the set of Identifier
Components of operand `dsᵢ`, the following group of constraints must hold:

* For **inner_join**, for each pair `dsᵢ`, `dsⱼ`, either `Id(dsᵢ) ⊆ Id(dsⱼ)` or `Id(dsⱼ) ⊆ Id(dsᵢ)`. In simpler words, the
  Identifiers of one of the joined Data Sets must be a superset of the identifiers of all the other ones.
* For **left_join** and **full_join**, for each pair `dsᵢ`, `dsⱼ`, `Id(dsᵢ) = Id(dsⱼ)`. In simpler words, the joined 
  Data Sets must have the same Identifiers.
* For **cross-join** (Cartesian product), no constraints are needed.

If the `using` clause is specified (we will label this case as “Case B”, allowed only for the **inner_join** and the
**left_join**), all the join keys must appear as Components in all the input Data Sets. Moreover two sub-cases are
allowed:

* Sub-case B1: the constraints of the Case A are respected and the join keys are a subset of the common Identifiers of the joined Data Sets;
* Sub-case B2:

  * In case of **inner_join**, one Data Set acts as the reference Data Set which the others are joined to; in case of **left_join**, this is 
    the left-most Data Set (i.e., ds₁);
  * All the input Data Sets, except the reference Data Set, have the same Identifiers [Id₁,..., Idₙ];
  * The `using` clause specifies all and only the common Identifiers of the non-reference Data Sets[Id₁,..., Idₙ].

The join operators must fulfil also other constraints:

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

The **semantics of the join operators** can be procedurally described as follows.

#. A *relational join* of the input operands is performed, according to SQL inner (**inner_join**), left-outer (**left_join**), full-outer 
   (**full_join**) and Cartesian product (**cross_join**) semantics (these semantics will be explained below), producing an intermediate 
   internal result, that is a Data Set that we will call “virtual” (VDS₁).
#. The `filterCondition`, if present, is applied on VDS₁, producing the Virtual Data Set VDS₂.
#. The specified calculation algorithms (**apply**, **calc** or **aggr**), if present, are applied on VDS₂. For the Attributes that have 
   not been explicitly calculated in these clauses, the Attribute propagation rule is applied (see the User Manual), so producing the 
   Virtual Data Set VDS₃.
#. The **keep** or **drop** clause, if present, is applied on VDS₃, producing the Virtual Data Set VDS₄.
#. The **rename** clause, if present, is applied on VDS₄, producing the Virtual Data Set VDS₅.
#. The final automatic alias removal is performed in order to obtain the output Data Set.

An alias can be optionally declared for each input Data Set. The aliases are valid only within the “join” operation,
in particular to allow joining a dataset with itself (self join). If omitted, the input Data Sets are referenced only
through their Data Set names. If the aliases are ambiguous (for example duplicated or equal to the name of
another Data Set), an error is raised.

The **structure of the virtual Data Set** VDS₁ which is the output of the relational join is the following.

For the **inner_join**, the **left_join** and the **full_join**, the virtual Data Set contains the following Components:

* The Components used as join keys, which appear once and maintain their original names and roles. In
  The cases A and B1, all of them are Identifiers. In the sub-case B2, the result takes the roles from the
  reference Data Set.
* In the sub-case B2: the Identifiers of the reference Data Set, which appear once and maintain their original name and role.
* The other Components coming from exactly one input Data Set, which appear once and maintain their original name
* The other Components coming from more than one input Data Set, which appears as many times as the
  Data Set they come from; to distinguish them, their names are prefixed with the alias (or the name) of 
  the Data Set they come from, separated by the “`#`” symbol (e.g., `dsᵢ#cmpⱼ`). For example, if the
  Component “`population`” appears in two input Data Sets “`ds1`” and “`ds2`” that have the aliases “`a`” and
  “`b`” respectively, the Components “`a#population`” and “`b#population`” will appear in the virtual Data Set.
  If the aliases are not defined, the two Components are prefixed with the Data Set name (i.e.,
  “`ds1#population`” and “`ds2#population`”). In this context, the symbol “`#`” does not denote the
  membership operator but acts just as a separator between the the Data Set and the Component names.
* If the same Data Set appears more times as operand of the join (self-join) and the aliases are not defined,
  an exception is raised because it is not allowed that two or more Components in the virtual Data Set
  have the same name. In the self-join the aliases are mandatory to disambiguate the Component names.
* If a Data Set in the join list is the result of a sub-expression, then an alias is mandatory all the same
  because this Data Set has no name. If the alias is omitted, an exception is raised.


As for the **cross_join**, the virtual Data Set contains all the Components from all the operands, possibly prefixed
with the aliases to avoid ambiguities.

The **semantics of the relational join** is the following.

The join is performed on some join keys, which are the Components of the input Data Sets whose values are used
to match the input Data Points and produce the joined output Data Points.

By default (only for the **full_join** and the **cross_join**), the join is performed on the subset of homonym Identifier
Components of the input Data Sets.

The parameter **using** allows to specify different join keys than the default ones, and can be used only for the
**inner_join** and the **left_join** in order to preserve the functional behaviour of the operations.

The different kinds of relational joins behave as follows.

* **inner_join**: the Data Points of `ds1, ..., dsN` are joined if they have the same values for the common
  Identifier Components or, if the **using** clause is present, for the specified Components. A (joined) virtual
  Data Point is generated in the virtual Data Set VDS₁ when a matching Data Point is found for each one of the
  input Data Sets. In this case, the Values of the Components of a virtual Data Point are taken from the
  corresponding Components of the matching Data Points. If there is no match for one or more input Data Sets,
  no virtual Data Point is generated.
* **left_join**: the join is ideally performed stepwise, between consecutive pairs of input Data Sets, starting from
  the left side and proceeding towards the right side. The Data Points are matched like in the **inner_join**, but a
  virtual Data Point is generated even if no Data Point of the right Data Set matches (in this case, the Measures
  and Attributes coming from the right Data Set take the NULL value in the virtual Data Set). Therefore, for
  each Data Points of the left Data Set a virtual Data Point is always generated. These stepwise operations are
  associative. More formally, consider the generic pair `<dsᵢ, dsᵢ₊₁>`, where `dsᵢ` is the result of the `left_join` of the
  first “i” operands and `dsᵢ₊₁` is the i+1th operand. For each pair `<dsᵢ, dsᵢ₊₁>`, the joined Data Set is fed with all
  the Data Points that match in *dsᵢ* and *dsᵢ₊₁* or are only in *dsᵢ*. The constraints described above guarantee the
  absence of null values for the Identifier Components of the joined Data Set, whose values are always taken
  from the left Data Set. If the join succeeds for a Data Point in `dsᵢ`, the values for the Measures and the
  Attributes are carried from `dsᵢ` and `dsᵢ₊₁` as explained above. Otherwise, i.e., if no Data Point in `dsᵢ₊₁` matches
  the Data Point in `dsᵢ`, null values are given to Measures and Attributes coming only from `dsᵢ₊₁`.
* **full_join**: the join is ideally performed stepwise, between consecutive pairs of input Data Sets, starting from
  the left side and proceeding toward the right side. The Data Points are matched like in the **inner_join** and
  **left_join**, but the **using** clause is not allowed and a virtual Data Point is generated either if no Data Point of
  the right Data Set matches with the left Data Point or if no Data Point of the left Data Set matches with the
  right Data Point (in this case, Measures and Attributes coming from the non matching Data Set take the NULL
  value in the virtual Data Set). Therefore, for each Data Points of the left and the right Data Set, a virtual Data
  Point is always generated. These stepwise operations are associative. More formally, consider the generic
  pair `<dsᵢ, dsᵢ₊₁>`, where `dsᵢ` is the result of the **full_join** of the first “i” operands and `dsᵢ₊₁` is the i+1th operand.
  For each pair `<dsᵢ, dsᵢ₊₁>`, the resulting Data Set is fed with the Data Points that match in `dsᵢ` and `dsᵢ₊₁` or that
  are only in `dsᵢ` or in `dsᵢ₊₁`. If for a Data Point in dsᵢ the join succeeds, the values for the Measures and the
  Attributes are carried from `dsᵢ` and `dsᵢ₊₁` as explained. Otherwise, i.e., if no Data Point in `dsᵢ₊₁` matches the
  Data Point in `dsᵢ`, NULL values are given to Measures and Attributes coming only from `dsᵢ₊₁`. Symmetrically, if
  no Data Point in `dsᵢ` matches the Data Point in `dsᵢ₊₁`, NULL values are given to Measures and Attributes
  coming only from `dsᵢ`. The constraints described above guarantee the absence of NULL values on the
  Identifier Components. As mentioned, the **using** clause is not allowed in this case.
* **cross_join**: the join is performed stepwise, between consecutive pairs of input Data Sets, starting from the
  left side and proceeding toward the right side. No match is performed but the Cartesian product of the input
  Data Points is generated in output. These stepwise operations are associative. More formally, consider the
  ordered pair `<dsᵢ, dsᵢ₊₁>`, where `dsᵢ` is the result of the `cross_join` of the first “i” operands and `dsᵢ₊₁` is the
  i+1-th operand. For each pair `<dsᵢ, dsᵢ₊₁>`, the resulting Data Set is fed with the Data Points obtained as the
  Cartesian product between the Data Points of `dsᵢ` and `dsᵢ₊₁`. The resulting Data Set will have all the
  Components from `dsᵢ` and `dsᵢ₊₁`. For the Data Sets which have at least one Component in common, the alias
  parameter is mandatory. As mentioned, the **using** parameter is not allowed in this case.


The **semantics of the clauses** is the following.

* **filter** takes as input a Boolean Component expression (having type `component<boolean>`). This clause
  filters in or out the input Data Points; when the expression is TRUE the Data Point is kept, otherwise it is
  not kept in the result. Only one **filter** clause is allowed.
* **apply** combines the homonym Measures in the source operands whose type is compatible with the
  operators used in `applyExpr`, generating homonym Measures in the output. The expression *applyExpr*
  can use as input the names or aliases of the operand Data Sets. It applies the expression to all the n-uples
  of homonym Measures in the input Data Sets producing in the target a single homonym Measure for
  each n-uple. It can be thought of as the multi-measure version of the **calc**. For example, if the following
  aliases have been declared: `d1`, `d2`, `d3`, then the following expression `d1+d2+d3`, sums all the homonym
  Measures in the three input Data Sets, say `M1` and `M2`, so as to obtain in the result:
  `M1 := d1#M1 + d2#M1 + d3#M1 and M2 := d1#M2 + d2#M2 + d3#M2`. It is not only a compact version of a multiple
  **calc**, but also essential when the number of Measures in the input operands is not known beforehand.
  Only one **apply** clause is allowed.
* **calc** calculates new Identifier, Measure or Attribute Components on the basis of sub-expressions at
  Component level. Each Component is calculated through an independent sub-expression. It is possible
  to specify the role of the calculated Component among **measure**, **identifier**, **attribute** or
  **viral attribute**, therefore the **calc** clause can be used also to change the role of a Component when possible.
  The keyword **viral** allows controlling the virality of Attributes (for the Attribute propagation rule see the
  User Manual). The following rule is used when the role is omitted: if the component exists in the
  operand Data Set then it maintains that role; if the component does not exist in the operand Data Set
  then the role is **measure**. The `calcExpr` are independent one another, they can only reference
  Components of the input Virtual Data Set and cannot use Components generated, for example, by other
  `calcExpr`. If the calculated Component is a new Component, it is added to the output virtual Data Set. If
  the Calculated component is a Measure or an Attribute that already exists in the input virtual Data Set,
  the calculated values overwrite the original values. If the Calculated component is an Identifier that
  already exists in the input virtual Data Set, an exception is raised because overwriting an Identifier
  Component is forbidden for preserving the functional behaviour. Analytic operators can be used in the **calc** clause.
* **aggr** calculates aggregations of dependent Components (Measures or Attributes) on the basis of sub-
  expressions at Component level. Each Component is calculated through an independent sub-expression.
  It is possible to specify the role of the calculated Component among **measure**, **identifier**, **attribute**, or
  **viral attribute**. The substring **viral** allows to control the virality of Attributes, if the Attribute
  propagation rule is adopted (see the User Manual). The **aggr** sub-expressions are independent of one
  another, they can only reference Components of the input Virtual Data Set and cannot use Components
  generated, for example, by other **aggr** sub-expressions. The **aggr** computed Measures and Attributes
  are the only Measures and Attributes returned in the output virtual Data Set (plus the possible viral
  Attributes, see below **Attribute propagation**). The sub-expressions must contain only Aggregate
  operators, which are able to compute an aggregated Value relevant to a group of Data Points. The groups
  of Data Points to be aggregated are specified through the *groupingClause*, which allows the following
  alternative options.
  | **group by**: the Data Points are grouped by the values of the specified Identifier. The Identifiers not
  specified are dropped in the result.
  | **group except**: the Data Points are grouped by the values of the Identifiers not specified in the clause.
  The specified Identifiers are dropped in the result.
  | **group all**: converts an Identifier Component using *conversionExpr* and keeps all the resulting Identifiers.
  |  The **having** clause is used to filter groups in the result by means of an aggregate condition evaluated on
  the single groups, for example the minimum number of rows in the group.
  If no grouping clause is specified, then all the input Data Points are aggregated in a single group and the
  clause returns a Data Set that contains a single Data Point and has no Identifier Components.
* **keep** maintains in the output only the specified dependent Components (Measures and Attributes) of
  the input virtual Data Set and drops the non-specified ones. It has the role of a projection in the usual
  relational semantics (specifying which columns have to be projected in). Only one **keep** clause is
  allowed. If **keep** is used, **drop** must be omitted.
* **drop** maintains in the output only the non-specified dependent Components (Measures and Attributes)
  of the input virtual Data Set (component<scalar>) and drops the specified ones. It has the role of a
  projection in the usual relational join semantics (specifying which columns will be projected out). Only
  one **drop** clause is allowed. If **drop** is used, **keep** must be omitted.
* **rename** assigns new names to one or more Components (Identifier, Measure or Attribute Components).
  The resulting Data Set, after renaming all the specified Components, must have unique names of all its
  Components (otherwise a runtime error is raised). Only the Component name is changed and not the
  Component Values, therefore the new Component must be defined on the same Value Domain and Value
  Domain Subset as the original Component (see also the IM in the User Manual). If the name of a
  Component defined on a different Value Domain or Set is assigned, an error is raised. In other words,
  rename is a transformation of the variable without any change in its values.

The semantics of the **Attribute propagation** in the join is the following. The Attributes calculated through the
**calc** or **aggr** clauses are maintained unchanged. For all the other Attributes that are defined as **viral**,
the Attribute propagation rule is applied (for the semantics, see the Attribute Propagation Rule section in the User the
Manual). This is done before the application of the **drop**, **keep** and **rename** clauses, which acts also on the
Attributes resulting from the propagation.

The semantics of the **final automatic aliases** removal is the following. After the application of all the clauses, the
structure of the final virtual Data Set is further modified. All the Components of the form
“alias#component_name” (or “dataset_name#component_name”) are implicitly renamed into
“component_name”. This means that the prefixes in the Component names are automatically removed. It is
responsibility of the user to guarantee the absence of duplicated Component names once the prefixes are
removed. In other words, the user must ensure that there are no pairs of Components whose names are of the
form “alias1#c1” and “alias2#c1” in the structure of the virtual Data Point, since the removal of “alias1” and
“alias2” would cause the clash. If, after the aliases removal two Components have the same name, an error is
raised. In particular, name conflicts may derive if the using clause is present and some homonym Identifier
Components do not appear in it; these components should be properly renamed because cannot be removed; the
input Data Set have homonym Measures and there is no apply clause which unifies them; these Measures can be
renamed or removed.
