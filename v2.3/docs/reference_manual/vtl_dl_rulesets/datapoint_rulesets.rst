#########################################
define datapoint ruleset
#########################################

---------
Semantics
---------

The Data Point Ruleset contains Rules to be applied to each individual
Data Point of a Data Set for validation purposes. These rulesets are
also called “horizontal” taking into account the tabular representation
of a Data Set (considered as a mathematical function), in which each
(vertical) column represents a variable and each (horizontal) row
represents a Data Point: these rulesets are applied on individual Data
Points (rows), i.e., horizontally on the tabular representation.

------
Syntax
------

**define datapoint ruleset** rulesetName **(** dpRulesetSignature_ **)
is** dpRule_ { **;** dpRule_ }\*
**end** **datapoint ruleset**

.. _dpRulesetSignature:

*dpRulesetSignature* ::= **valuedomain** listValueDomains_ | **variable** listVariables_

.. _listValueDomains:

*listValueDomains* ::= valueDomain { **as** vdAlias } { **,**
valueDomain { **as** vdAlias } }\*

.. _listVariables:

*listVariables* ::= variable { **as** varAlias } { **,** variable {
**as** varAlias } }\*

.. _dpRule:

*dpRule* ::= { ruleName **:** } { **when** antecedentCondition **then**
} consequentCondition
| { **errorcode** errorCode }
| { **errorlevel** errorLevel }

------------------
Syntax description
------------------

.. list-table::

   * - rulesetName
     - the name of the Data Point Ruleset to be defined.
   * - *dpRulesetSignature*
     -  the Cartesian space of the Ruleset (signature of
        the Ruleset), which specifies either the Value Domains or the Represented Variables (see
        the information model) on which the Ruleset is defined. If
        **valuedomain** is specified then the Ruleset is applicable to the
        Data Sets having Components that take values on the specified Value
        Domains. If **variable** is specified then the Ruleset is applicable
        to Data Sets having the specified Variables as Components.
   * - valueDomain 
     - a Value Domain on which the Ruleset is defined.
   * - vdAlias 
     - an (optional) alias assigned to a Value Domain and valid only
       within the Ruleset, this can be used for the sake of compactness in
       writing the Rules. If an alias is not specified then the name of the
       Value Domain (parameter valueDomain) is used in the body of the rules.
   * - variable 
     - a Represented Variable on which the Ruleset is defined.
   * - varAlias 
     - an (optional) alias assigned to a Variable and valid only
       within the Ruleset, this can be used for the sake of compactness in
       writing the Rules. If an alias is not specified then the name of the
       Variable (parameter valueDomain) is used in the body of the Rules.
   * - *dpRule*
     - a Data Point Rule, as defined in the following parameters.
   * - ruleName
     - the name assigned to the specific Rule within the Ruleset. If
       the Ruleset is used for validation then the ruleName identifies the
       validation results of the various Rules of the Ruleset. The ruleName is
       optional and, if not specified, is assumed to be the progressive order
       number of the Rule in the Ruleset. However please note that, if ruleName
       is omitted, then the Rule names can change in case the Ruleset is
       modified, e.g., if new Rules are added or existing Rules are deleted,
       and therefore the users that interpret the validation results must be
       aware of these changes.
   * - antecedentCondition 
     - a *boolean* expression to be evaluated for each
       single Data Point of the input Data Set. It can contain Values of the
       Value Domains or Variables specified in the Ruleset signature and
       constants; all the VTL-ML component level operators are allowed. If
       omitted then antecedentCondition is assumed to be **true**.
   * - consequentCondition
     - a *boolean* expression to be evaluated for each
       single Data Point of the input Data Set when the antecedentCondition evaluates 
       to **true** (as mentioned, missing antecedent conditions are assumed to be **true**). It
       contains Values of the Value Domains or Variables specified in the
       Ruleset signature and constants; all the VTL-ML component level
       operators are allowed. A consequent condition equal to **false** is
       considered as a non-valid result.
   * - errorCode
     - a literal denoting the error code associated to the rule, to
       be assigned to the possible non-valid results in case the Rule is used
       for validation. If omitted then no error code is assigned (**null** value).
       VTL assumes that a Value Domain errorcode_vd of error codes exists in
       the Information Model and contains all possible error codes: the
       errorCode literal must be one of the possible Values of such a Value
       Domain. VTL assumes also that a Variable errorcode for describing the
       error codes exists in the IM and is a dependent variable of the Data
       Sets which contain the results of the validation.
   * - errorLevel
     - a literal denoting the error level (severity) associated to
       the rule, to be assigned to the possible non-valid results in case the
       Rule is used for validation. If omitted then no error level is assigned
       (**null** value). VTL assumes that a Value Domain errorlevel_vd of error
       levels exists in the Information Model and contains all possible error
       levels: the errorLevel literal must be one of the possible Values of
       such a Value Domain. VTL assumes also that a Variable errorlevel for
       describing the error levels exists in the IM and is a dependent variable
       of the Data Sets which contain the results of the validation.

----------
Parameters
----------

rulesetName::

   name <ruleset >

valueDomain:: 

   name < valuedomain >

vdAlias:: 
   
   name

variable:: 

   name

varAlias:: 

   name

ruleName:: 

   name

antecedentCondition:: 

   boolean

consequentCondition:: 

   boolean

errorCode:: 

   errorcode_vd

errorLevel:: 

   errorlevel_vd

-----------
Constraints
-----------

*  antecedentCondition and consequentCondition can refer only to the
   Value Domains or Variables specified in the dpRulesetSignature.
*  Either ruleName is specified for all the Rules of the Ruleset or for
   none.
*  If specified, then ruleName must be unique within the Ruleset\ *.*

----------------------
Semantic specification
----------------------

This operator defines a persistent Data Point Ruleset named rulesetName
that can be used for validation purposes.

A Data Point Ruleset is a persistent object that contains Rules to be
applied to the Data Points of a Data Set [1]_. The Data Point Rulesets
can be invoked by the **check_datapoint** operator. The Rules are aimed
at checking the combinations of values of the Data Set Components,
assessing if these values fulfil the logical conditions expressed by the
Rules themselves. The Rules are evaluated independently for each Data
Point, returning a Boolean scalar value (i.e., **true** for valid results
and **false** for non-valid results).

Each Rule contains an (optional) antecedentCondition *boolean*
expression followed by a consequentCondition *boolean* expression and
expresses a logical implication. Each Rule states that when the
antecedentCondition evaluates to **true** for a given Data Point, then the
consequentCondition is expected to be **true** as well. If this implication
is fulfilled, the result is considered as valid (**true**), otherwise as
non-valid (**false**). On the other side, if the antecedentCondition
evaluates to **false**, the consequentCondition does not applies and is not
evaluated at all, and the result is considered as valid (**true**). In case
the antecedentCondition is absent then it is assumed to be always **true**,
therefore the consequentCondition is expected to evaluate to **true** for
all the Data Points. See an example below:

+-------------------------------------+--------------------------------+
| *Rule*                              | *Meaning*                      |
+=====================================+================================+
| **On Value Domains:**               | When the Component of the Data |
|                                     | Set which is defined on the    |
| **when** flow_type **=** "CREDIT"   | Value Domain named flow_type   |
| or flow_type **=** "DEBIT" **then** | takes the value “CREDIT” or    |
| numeric_value **>=** 0              | the value “DEBIT”, then the    |
|                                     | other Component defined on the |
|                                     | Value Domain named             |
|                                     | numeric_value is expected to   |
|                                     | have a zero or positive value. |
+-------------------------------------+--------------------------------+
| **On Variables:**                   | When the Component of the Data |
|                                     | Set named flow has the value   |
| **when** flow **=** "CREDIT" or     | “CREDIT” or “DEBIT” then the   |
| flow = "DEBIT" **then** obs_value   | Component named obs_value is   |
| **>= 0**                            | expected to have a value       |
|                                     | greater than zero.             |
+-------------------------------------+--------------------------------+

The definition of a Ruleset comprises a **signature**
(dpRulesetSignature), which specifies the Value Domains or Variables on
which the Ruleset is defined and a set of Rules, that are the Boolean
expressions to be applied to each Data Point. The antecedentCondition
and consequentCondition of the Rules can refer only to the Value Domains
or Variables of the Ruleset signature.

The Value Domains or the Variables of the Ruleset signature identify the
space in which the rules are defined while each Rule provides for a
criterion that demarcates the Set of valid combinations of Values inside
this space.

The Data Point Rulesets can be defined in terms of Value Domains in
order to maximize their reusability, in fact this way a Ruleset can be
applied on any Data Set which has Components which take values on the
Value Domains of the Ruleset signature. The association between the
Components of the Data Set and the Value Domains of the Ruleset
signature is provided by the **check_datapoint** operator at the
invocation of the Ruleset.

When the Ruleset is defined on Variables, their reusability is
intentionally limited to the Data Sets which contains such Variables
(and not to other possible Variables which take values from the same
Value Domain). If at a later stage the Ruleset would need to be applied
also to other Variables defined on the same Value Domain, a similar
Ruleset should be defined also for the other Variable.

Rules are uniquely identified by ruleName. If omitted then ruleName is
implicitly assumed to be the progressive order number of the Rule in the
Ruleset. Please note however that, using this default mechanism, the
Rule Name can change if the Ruleset is modified, e.g., if new Rules are
added or existing Rules are deleted, and therefore the users that
interpret the validation results must be aware of these changes. In
addition, if the results of more than one Ruleset have to be combined in
one Data Set, then the user should make the relevant rulesetNames
different.

As said, each Rule is applied in a row-wise fashion to each individual
Data Point of a Data Set. The references to the Value Domains defined in
the antecedentCondition and consequentCondition are replaced with the
values of the respective Components of the Data Point under evaluation.

--------
Examples
--------

::

   define datapoint ruleset DPR_1 ( valuedomain flow_type A, numeric_value B ) is
      when A = “CREDIT” or A = “DEBIT” then B >= 0 errorcode “Bad value” errorlevel 10
   end datapoint ruleset;

::
   
   define datapoint ruleset DPR_2 ( variable flow F, obs_value O) is
     when F = “CREDIT” or F = “DEBIT” then O >= 0 errorcode “Bad value”
    end datapoint ruleset;


.. [1]
   In order to apply the Ruleset to more Data Sets, these Data Sets must
   be composed together using the appropriate VTL operators in order to
   obtain a single Data Set.
