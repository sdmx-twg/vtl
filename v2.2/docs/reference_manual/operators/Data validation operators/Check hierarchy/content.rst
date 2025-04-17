------
Syntax
------

    **check_hierarchy (** op , hr { **condition** condComp { , condComp }* } { **rule** ruleComp } { mode_ } { input_ } { output_ } **)**

        .. _mode:
        
        mode ::= **non_null | non_zero | partial_null | partial_zero | always_null | always_zero**

        .. _input:
        
        input ::= **dataset | dataset_priority**

        .. _output:

        output ::= **invalid | all | all_measures**

----------------
Input parameters
----------------
.. list-table::

   * - op 
     - the Data Set to be checked
   * - hr
     - the hierarchical Ruleset to be used
   * - condComp
     - | *condComp* is a Component of *op* to be associated (in positional order) to the conditioning
       | Value Domains or Variables defined in *hr* (if any).
   * - ruleComp
     - | *ruleComp* is the Identifier Component of *op* to be associated to the rule Value Domain or
       | Variable defined in *hr*.
   * - mode
     - | this parameter specifies how to treat the possible missing Data Points corresponding to
       | the Code Items in the left and right sides of the rules and which Data Points are produced
       | in output. The meaning of the possible values of the parameter is explained below.
   * - input
     - | this parameter specifies the source of the values used as input of the comparisons. The
       | meaning of the possible values of the parameter is explained below.
   * - output
     - | this parameter specifies the structure and the content of the resulting dataset. The
       | meaning of the possible values of the parameter is explained below.

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  check_hierarchy ( DS1, HR_2  non_null  dataset  invalid )   
  check_hierarchy ( DS1, HR_3  non_zero dataset_priority  all )

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
If *hr* is defined on Value Domains then it is mandatory to specify the *condition* (if any in the ruleset *hr*) and the
*rule* parameters. Moreover, the Components specified as *condComp* and *ruleComp* must belong to the operand
*op* and must take values on the Value Domains corresponding, in positional order, to the ones specified in the
condition and rule parameter of *hr*.

If *hr* is defined on Variables, the specification of *condComp* and *ruleComp* is not needed, but they can be
specified all the same if it is desired to show explicitly in the invocation which are the involved Components: in
this case, the *condComp* and *ruleComp* must be the same and in the same order as the Variables specified in
the *condition* and *rule* signatures of *hr*.

---------
Behaviour
---------

The **check_hierarchy** operator applies the Rules of the Ruleset *hr* to check the Code Items Relations between
the Code Items present in *op* (as for the Code Items Relations, see the User Manual - section “Generic Model for
Variables and Value Domains”). The operator checks if the relation between the left and the right member is
fulfilled, giving TRUE in positive case and FALSE in negative case.

The Attribute propagation rule is applied on each group of Data Points which contributes to the same Data Point
of the result.

The behaviours relevant to the different options of the input parameters are the following.

First, the parameter *input* is used to determine the source of the Data Points used as input of the
*check_hierarchy*. The possible options of the parameter *input* and the corresponding behaviours are the following:


.. list-table::

   * - dataset
     - | this option addresses the case where all the input Data Points of all the Rules of the
       | Ruleset are expected to be taken from the input Data Set (the operand *op*).
       | For each Rule of the Ruleset and for each item on the left and right sides of the Rule,
       | the operator takes the input Data Points exclusively from the operand *op*.
   * - dataset_priority
     - | this option addresses the case where the input Data Points of all the Rules of the
       | Ruleset are preferably taken from the input Data Set (the operand *op*). However, if a
       | valid Measure value for an expected Data Point is not found in *op*, the attempt is
       | made to take it from the computed output of a (possible) other Rule.
       | For each Rule of the Ruleset and for each item on the left and right sides of the Rule:
       | · if the item is not defined as the result (left side) of another Rule that applies the
       | Code Item relation “is equal to” (=), the current Rule takes the input Data Points
       | from the operand *op*.
       | · if the item is defined as result of another Rule *R* that applies the Code Item
       | relation “is equal to” (=), then:
       |    > if an expected input Data Point exists in *op* and its Measure is not NULL,
       |    then the current Rule takes such Data Point from *op*;
       |    > if an expected input Data Point does not exist in *op* or its measure is NULL,
       |    then the current Rule takes the Data Point (if any) that has the same
       |    Identifiers’ values from the computed output of the other Rule *R*;

If the parameter *input* is not specified then it is assumed to be *dataset*.

Then the parameter *mode* is considered, to determine the behaviour for missing Data Points and for the Data
Points to be produced in the output. The possible options of the parameter *mode* and the corresponding
behaviours are the following:

.. list-table::

   * - non_null
     - | the result Data Point is produced when all the items involved in the comparison exist
       | and have not NULL Measure value (i.e., when no Data Point corresponding to the Code
       | Items of the left and right sides of the rule is missing or has NULL Measure value);
       | under this option, in evaluating the comparison, the possible missing Data Points
       | corresponding to the Code Items of the left and right sides of the rule are considered
       | existing and having a NULL Measure value;
   * - non_zero
     - | the result Data Point is produced when at least one of the items involved in the
       | comparison exist and have Measure not equal to 0 (zero); the possible missing Data
       | Points corresponding to the Code Items of the left and right sides of the rule
       | are considered existing and having a Measure value equal to 0;
   * - partial_null
     - | the result Data Point is produced if at least one Data Point corresponding to the Code
       | Items of the left and right sides of the rule is found (whichever is its Measure value);
       | the possible missing Data Points corresponding to the Code Items of the left and right
       | sides of the rule are considered existing and having a NULL Measure value;
   * - partial_zero
     - | the result Data Point is produced if at least one Data Point corresponding to the Code
       | Items of the left and right sides of the rule is found (whichever is its Measure value);
       | the possible missing Data Points corresponding to the Code Items of the left and right
       | sides of the rule are considered existing and having a Measure value equal to 0 (zero);
   * - always_null
     - | the result Data Point is produced in any case; the possible missing Data Points
       | corresponding to the Code Items of the left and right sides of the rule are considered
       | existing and having a Measure value equal to NULL;
   * - always_zero
     - | the result Data Point is produced in any case; the possible missing Data Points
       | corresponding to the Code Items of the left and right sides of the rule are considered
       | existing and having a Measure value equal to 0 (zero);

If the parameter *mode* is not specified, then it is assumed to be *non_null*.

The following table summarizes the behaviour of the options of the parameter “mode”:

.. csv-table::
   :file: ./modeTable.csv
   :header-rows: 1

Finally the parameter *output* is considered, to determine the structure and content of the resulting Data Set. The
possible options of the parameter *output* and the corresponding behaviours are the following:

.. list-table::

   * - all
     - | all the Data Points produced by the comparison are returned, both the valid ones (TRUE)
       | and the invalid ones (FALSE) besides the possible NULL ones. The result of the
       | comparison is returned in the *boolean* Measure *bool_var*. The original Measure
       | Component of the Data Set *op* is not returned.
   * - invalid
     - | only the invalid (FALSE) Data Points produced by the comparison are returned. The
       | result of the comparison (*boolean* Measure *bool_var*) is not returned. The original
       | Measure Component of the Data Set *op* is returned and contains the Measure values
       | taken from the Data Points on the left side of the rule.
   * - all_measures
     - | all the Data Points produced by the comparison are returned, both the valid ones
       | (TRUE) and the invalid ones (FALSE) besides the possible NULL ones. The result
       | of the comparison is returned in the *boolean* Measure *bool_var*. The original
       | Measure Component of the Data Set *op* is returned and contains the Measure
       | values taken from the Data Points on the left side of the rule.

If the parameter *output* is not specified then it is assumed to be *invalid*.

In conclusion, the operator returns a Data Set having the following Components:

* all the Identifier Components of *op*
* the additional Identifier Component *ruleid*, whose aim is to identify the Rule that has generated the
  actual Data Point (it contains at least the Rule name specified in *hr* (The content of *ruleid* maybe personalised in the implementation) )
* if the *output* parameter is *all*: the *boolean* Measure *bool_var* whose values are the result of the
  evaluation of the Rules (TRUE, FALSE or NULL).
* if the *output* parameter is *invalid*: the original Measure of *op*, whose values are taken from the Measure
  values of the Data Points of the left side of the Rule
* if the *output* parameter is *all_measures*: the *boolean* Measure *bool_var*, whose value is the result of the
  evaluation of a Rule on a Data Point (TRUE, FALSE or NULL), and the original Measure of *op*, whose
  values are taken from the Measure values of the Data Points of the left side of the Rule
* the Measure *imbalance*, which contains the difference between the Measure values of the Data Points on
  the left side of the Rule and the Measure values of the corresponding calculated Data Points on the right
  side of the Rule
* the Measure *errorcode*, which contains the *errorcode* value specified in the Rule
* the Measure *errorlevel*, which contains the *errorlevel* value specified in the Rule

Note that a generic Data Point of *op* can produce several Data Points in the resulting Data Set, one for each Rule
in which the Data Point appears as the left member of the comparison.
