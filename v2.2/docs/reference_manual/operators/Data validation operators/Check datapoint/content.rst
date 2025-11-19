------
Syntax
------

    **check_datapoint (** op , dpr { **components** listComp_ } { output_ } **)**

       .. _listComp: 
        
        listComp ::= comp { , comp }*

        .. _output:
        
        output ::= **invalid | all | all_measures**

----------------
Input parameters
----------------
.. list-table::

   * - op 
     - the Data Set to check
   * - dpr
     - the Data Point Ruleset to be used
   * - listComp
     - | if *dpr* is defined on Value Domains then *listComp* is the list of Components of *op* to be
       | associated (in positional order) to the conditioning Value Domains defined in *dpr*. If *dpr* is
       | defined on Variables then *listComp* is the list of Components of *op* to be associated (in
       | positional order) to the conditioning Variables defined in *dpr* (for documentation purposes).
   * - comp
     - Component of *op*
   * - output
     - specifies the Data Points and the Measures of the resulting Data Set:
       |    · **invalid**: the resulting Data Set contains a Data Point for each Data Point of *op* and
       |    each Rule in *dpr* that evaluates to **false** on that Data Point. The resulting
       |    Data Set has the Measures of *op*.
       |    · **all**: the resulting Data Set contains a data point for each Data Point of *op* and
       |    each Rule in *dpr*. The resulting Data Set has the *boolean* Measure bool_var.
       |    · **all_measures**: the resulting Data Set contains a Data Point for each Data Point of *op*
       |    and each Rule in *dpr*. The resulting dataset has the Measures of *op* and the
       |    *boolean* Measure bool_var.
       | If not specified then *output* is assumed to be *invalid*. See the Behaviour for further details.


------------------------------------
Examples of valid syntaxes
------------------------------------
::

  check_datapoint ( DS1, DPR invalid )
  check_datapoint ( DS1, DPR all_measures )

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset

dpr ::

    name<datapoint>

comp ::

    name<component>

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
If *dpr* is defined on Value Domains then it is mandatory to specify *listComp*. The Components specified in
*listComp* must belong to the operand *op* and be defined on the Value Domains specified in the signature of *dpr*.

If *dpr* is defined on Variables then the Components specified in the signature of *dpr* must belong to the operand *op*.

If *dpr* is defined on Variables and *listComp* is specified then the Components specified in *listComp* are the same,
in the same order, as those specified in *op* (they are provided for documentation purposes).

---------
Behaviour
---------

It returns a Data Set having the following Components:

* the Identifier Components of *op*
* the Identifier Component *ruleid* whose aim is to identify the Rule that has generated the actual Data
  Point (it contains at least the Rule name specified in *dpr* 8)
* if the *output* parameter is **invalid**: the original Measures of *op* (no *boolean* measure)
* if the *output* parameter is **all**: the *boolean* Measure bool_var whose value is the result of the evaluation
  of a rule on a Data Point (**true**, **false** or **null**).
* if the *output* parameter is **all_measures**: the original measures of *op* and the *boolean* Measure bool_var
  whose value is the result of the evaluation of a rule on a Data Point (**true**, **false** or **null**).
* the Measure errorcode that contains the errorcode specified in the rule
* the Measure errorlevel that contains the errorlevel specified in the rule

A Data Point of *op* can produce several Data Points in the resulting Data Set, each of them with a different value
of ruleid. If *output* is **invalid** then the resulting Data Set contains a Data Point for each Data Point of *op* and each
rule of *dpr* that evaluates to **false**. If *output* is **all** or **all_measures** then the resulting Data Set contains a Data
Point for each Data Point of *op* and each rule of *dpr*.
