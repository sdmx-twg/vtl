------
Syntax
------

    **hierarchy (** op , hr { **condition** condComp { , condComp }* } 
    { **rule** ruleComp } { mode_ } { input_ } { output_ } )

    .. _mode:
    
    mode ::= **non_null | non_zero | partial_null | partial_zero | always_null | always_zero**

    .. _input:
    
    input ::= **dataset | rule | rule_priority**

    .. _output:

    output ::= **computed | all**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand Data Set
   * - hr
     - the hierarchical ruleset to be applied
   * - condComp
     - | *condComp* is a Component of *op* to be associated (in positional order) to the
       | conditioning Value Domains or Variables defined in *hr* (if any)
   * - ruleComp
     - | *ruleComp* is the Identifier of *op* to be associated to the rule Value Domain or Variable
       | defined in *hr*
   * - mode
     - | this parameter specifies how to treat the possible missing Data Points corresponding to
       | the Code Items in the right side of a rule and which Data Points are produced in output.
       | The meaning of the possible values of the parameter is explained below.
   * - input
     - | this parameter specifies the source of the values used as input of the hierarchical rules.
       | The meaning of the possible values of the parameter is explained below.
   * - output
     - | this parameter specifies the content of the resulting Data Set.
       | The meaning of the possible values of the parameter is explained below.

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  hierarchy ( DS1, HR1 rule Id_1 non_null all )
  hierarchy ( DS2, HR2 condition Comp_1, Comp_2 rule Id_3 non_zero rule computed )


------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { measure<number> _ }

hr ::

    name<hierarchical>

condComp ::

    name<component>

ruleComp ::

    name<identifier>

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<number> _ }

-----------------------------
Additional Constraints
-----------------------------
If *hr* is defined on Value Domains then it is mandatory to specify the *condition* (if any) and the *rule* parameters.
Moreover, the Components specified as *condComp* and *ruleComp* must belong to the operand *op* and must take
values on the Value Domains corresponding, in positional order, to the ones specified in the *condition* and *rule*
parameter of *hr*.

If *hr* is defined on Variables, the specification of *condComp* and *ruleComp* is not needed, but they can be
specified all the same if it is desired to show explicitly in the invocation which are the involved Components: in
this case, the *condComp* and *ruleComp* must be the same and in the same order as the Variables specified in in
the *condition* and *rule* signatures of *hr*.

---------
Behaviour
---------

The **hierarchy** operator applies the rules of *hr* to *op* as specified in the parameters. The operator returns a Data
Set with the same Identifiers and the same Measure as *op*. The Attribute propagation rule is applied on the
groups of Data Points which contribute to the same Data Points of the result.

The behaviours relevant to the different options of the input parameters are the following.

First, the parameter **input** is considered to determine the source of the Data Points used as input of the
Hierarchy. The possible options of the parameter *input* and the corresponding behaviours are the following:

.. list-table::

   * - dataset
     - | For each Rule of the Ruleset and for each item on the right hand side of the Rule, the
       | operator takes the input Data Points exclusively from the operand *op*.
   * - rule
     - | For each Rule of the Ruleset and for each item on the right-hand side of the Rule:
       | · if the item is not defined as the result (left-hand side) of another Rule, the current Rule
       | takes the input Data Points from the operand *op*
       | · if the item is defined as the result of another Rule, the current Rule takes the input
       | Data Points from the computed output of such other Rule
   * - rule_priority
     - | For each Rule of the Ruleset and for each item on the right-hand side of the Rule:
       | · if the item is not defined as the result (left-hand side) of another rule, the current Rule
       | takes the input Data Points from the operand *op*
       | · if the item is defined as the result of another Rule, then:
       |    > if an expected input Data Point exists in the computed output of such other Rule
       |    and its Measure is not NULL, then the current Rule takes such Data Point;
       |    > if an expected input Data Point does not exist in the computed output of such
       |    other Rule or its measure is NULL, then the current Rule takes the Data Point
       |    from op (if any) having the same values of the Identifiers;

if the parameter *input* is not specified then it is assumed to be *rule*.

Then the parameter *mode* is considered, to determine the behaviour for missing Data Points and for the Data
Points to be produced in the output. The possible options of the parameter *mode* and the corresponding
behaviours are the following:

.. list-table::

   * - non_null
     - | the result Data Point is produced when its computed Measure value is not NULL (i.e.,
       | when no Data Point corresponding to the Code Items of the right side of the rule is
       | missing or has NULL Measure value); in the calculation, the possible missing Data
       | Points corresponding to the Code Items of the right side of the rule are considered
       | existing and having a Measure value equal to NULL;
   * - non_zero
     - | the result Data Point is produced when its computed Measure value is not equal to
       | 0 (zero); the possible missing Data Points corresponding to the Code Items of the
       | right side of the rule are considered existing and having a Measure value equal to 0;
   * - partial_null
     - | the result Data Point is produced if at least one Data Point corresponding to the
       | Code Items of the right side of the rule is found (whichever is its Measure value);
       | the possible missing Data Points corresponding to the Code Items of the right side
       | of the rule are considered existing and having a NULL Measure value;
   * - partial_zero
     - | the result Data Point is produced if at least one Data Point corresponding to the
       | Code Items of the right side of the rule is found (whichever is its Measure value);
       | the possible missing Data Points corresponding to the Code Items of the right side
       | of the rule are considered existing and having a Measure value equal to 0 (zero);
   * - always_null
     - | the result Data Point is produced in any case; the possible missing Data Points
       | corresponding to the Code Items of the right side of the rule are considered existing
       | and having a Measure value equal to NULL;
   * - always_zero
     - | the result Data Point is produced in any case; the possible missing Data Points
       | corresponding to the Code Items of the right side of the rule are considered existing
       | and having a Measure value equal to 0 (zero);

If the parameter *mode* is not specified, then it is assumed to be *non_null*.

The following table summarizes the behaviour of the options of the parameter “*mode*”:

.. csv-table::
    :file: examples/modeTable.csv
    :header-rows: 1

Finally the parameter *output* is considered, to determine the content of the resulting Data Set. The possible
options of the parameter *output* and the corresponding behaviours are the following:

.. list-table::

   * - computed
     - | the resulting Data Set contains only the set of Data Points computed according to
       | the Ruleset
   * - all
     - | the resulting Data Set contains the union between the set of Data Points “R” computed
       | according to the Ruleset and the set of Data Points of op that have different
       | combinations of values for the Identifiers. In other words, the result is the outcome
       | of the following (virtual)expression: **union ( setdiff (op , R) , R )**

If the parameter *output* is not specified then it is assumed to be *computed*.
