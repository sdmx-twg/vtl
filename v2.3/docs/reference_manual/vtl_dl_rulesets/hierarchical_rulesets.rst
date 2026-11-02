#########################################
define hierarchical ruleset
#########################################

---------
Semantics
---------

This operator defines a persistent Hierarchical Ruleset that contains
Rules to be applied to individual Components of a given Data Set in
order to make validations or calculations according to hierarchical
relationships between the relevant Code Items. These Rulesets are also
called “vertical” taking into account the tabular representation of a
Data Set (considered as a mathematical function), in which each
(vertical) column represents a variable and each (horizontal) row
represents a Data Point: these Rulesets are applied on variables
(columns), i.e., vertically on the tabular representation of a Data Set.

A main purpose of the hierarchical Rules is to express some more
aggregated Code Items (e.g. the continents) in terms of less aggregated
ones (e.g., their countries) by using Code Item Relationships. This kind
of relations can be applied to aggregate data, for example to calculate
an additive measure (e.g., the population) for the aggregated Code Items
(e.g., the continents) as the sum of the corresponding measures of the
less aggregated ones (e.g., their countries). These rules can be used
also for validation, for example to check if the additive measures
relevant to the aggregated Code Items (e.g., the continents) match the
sum of the corresponding measures of their component Code Items (e.g.,
their countries), provided that the input Data Set contains all of them,
i.e. the more and the less aggregated Code Items.

Another purpose of these Rules is to express the relationships in which
a Code Item represents some part of another one, (e.g., “Africa” and
“Five largest countries of Africa”, being the latter a detail of the
former). This kind of relationships can be used only for validation, for
example to check if a positive and additive measure (e.g., the
population) relevant to the more aggregated Code Item (e.g., Africa) is
greater than the corresponding measure of the other more detailed one
(e.g., “5 largest countries of Africa”).

The name “hierarchical” comes from the fact that this kind of Ruleset is
able to express the hierarchical relationships between Code Items at
different levels of detail, in which each (aggregated) Code Item is
expressed as a partition of (disaggregated) ones. These relationships
can be recursive, i.e., the aggregated Code Items can be in their turn
component of even more aggregated ones, without limitations about the
number of recursions.

As a first simple example, the following Hierarchical Ruleset named
“BeneluxCountriesHierarchy” contains a single rule that asserts that, in
the Value Domain “Geo_Area”, the Code Item BENELUX is the aggregation of
the Code Items BELGIUM, LUXEMBOURG and NETHERLANDS:

::

   define hierarchical ruleset BeneluxCountriesHierarchy (valuedomain rule Geo_Area ) is
      BENELUX = BELGIUM + LUXEMBOURG + NETHERLANDS
   end hierarchical ruleset

------
Syntax
------

**define hierarchical ruleset** rulesetName **(** hrRulesetSignature_ **) is**

    hrRule_

   { **;** hrRule_ }\*

**end hierarchical ruleset**

.. _hrRulesetSignature:

hrRulesetSignature ::= vdRulesetSignature_ | varRulesetSignature_

.. _vdRulesetSignature:

vdRulesetSignature ::= **valuedomain** { **condition** vdConditioningSignature_ } **rule** ruleValueDomain

.. _vdConditioningSignature:

vdConditioningSignature ::= condValueDomain { **as** vdAlias } { **,** condValueDomain { **as** vdAlias } }\*

.. _varRulesetSignature:

varRulesetSignature ::= **variable** { **condition** varConditioningSignature_} **rule** ruleVariable

.. _varConditioningSignature:

varConditioningSignature ::= condVariable { **as** vdAlias } { **,** condVariable { **as** vdAlias } }\*

.. _hrRule:

hrRule ::= { ruleName **:**} codeItemRelation_ { **errorcode** errorCode } { **errorlevel** errorLevel }

.. _codeItemRelation:

codeItemRelation ::= { **when** leftCondition **then** }
    | leftCodeItem { **=** | **>** | **<** | **>=** | **<=**}:sup:`1`
    | { **+** \| **-** } rightCodeItem { **[** rightCondition **]** }
    | { { **+** \| **-** }\ :sup:`1` rightCodeItem { **[** rightCondition **]** } }\*

--------------------
Syntax description
--------------------

.. list-table::

    * - rulesetName
      - the name of the Hierarchical Ruleset to be defined.
    * - hrRulesetSignature
      - the signature of the Ruleset. It specifies the Value Domain or Variable on which the Ruleset 
        is defined, and the Conditioning Signature.
    * - vdRulesetSignature
      - the signature of a Ruleset defined on Value Domains
    * - varRulesetSignature
      - the signature of a Ruleset defined on Variables 
    * - *hrRule*
      - a single hierarchical rule, as described below.
    * - *vdConditioningSignature*
      - specifies the Value Domains on which the
        conditions are defined. The Ruleset is meant to be applicable to the
        Data Sets having Components that take values on the Value Domain on
        which the ruleset is defined (i.e., ruleValueDomain) and on the
        conditioning Value Domains (i.e., condValueDomain).
    * - ruleValueDomain
      - the Value Domain on which the Ruleset is defined
    * - condValueDomain
      - a conditioning Value Domain of the Ruleset 
    * - vdAlias 
      - an (optional) alias assigned to a Value Domain and valid only
        within the Ruleset, this can be used for the sake of compactness in
        writing leftCondition and rightCondition. If an alias is not specified
        then the name of the Value Domain (i.e., condValueDomain) must be used.
    * - *varConditioningSignature*
      - the signature of the (possible) conditions of
        the Ruleset defined on Variables. It specifies the Represented Variables
        (see the information model) on which these conditions are defined. The
        Ruleset is meant to be applicable to any Data Set having Components
        which are defined by the Variable on which the Ruleset is expressed
        (i.e., variable) and on the Conditioning Variables.
    * - ruleVariable
      - the variable on which the Ruleset is defined
    * - condVariable
      - a conditioning Variable of the Ruleset
    * - varAlias
      - an (optional) alias assigned to a Variable and valid only
        within the Ruleset, this can be used for the sake of compactness in
        writing leftCondition and rightCondition. If an alias is not specified
        then the name of the Variableomain (parameter condVariable) must be
        used.
    * - ruleName
      - the name assigned to the specific Rule within the Ruleset. If
        the Ruleset is used for validation then the ruleName identifies the
        validation results of the various Rules of the Ruleset. The ruleName is
        optional and, if not specified, is assumed to be the progressive order
        number of the Rule in the Ruleset. However please note that, if ruleName
        is omitted, then the Rule names can change in case the Ruleset is
        modified, e.g., if new Rules are added or existing Rules are deleted,
        and therefore the users that interpret the validation results must be
        aware of these changes. In addition, if the results of more than one
        Ruleset have to be combined in one Data Set, then the user should make
        the relevant rulesetNames different.
    * - *codeItemRelation*
      - specifies a (possibly conditioned) Code Item
        Relation. It expresses a logical relation between Code Items belonging
        to the Value Domain of the hrRulesetSignature, possibly conditioned by
        the Values of the Value Domains or Variables of the Conditioning
        Signature. The relation is expressed by one of the symbols **=**, **>**,
        **>=**, **<**, **<=**, that in this context denote special logical
        relationships typical of Code Items. The first member of the relation is
        a single Code Item. The second member of the relationship is the
        composition of one or more Code Items combined using the symbols **+**
        or **-**, which in turn also denote special logical operators typical of
        Code Items. The meaning of these symbols is better explained below and
        in the User Manual.
    * - errorCode
      - a literal denoting the error code associated to the rule, to
        be assigned to the possible non-valid results in case the Rule is used
        for validation. If omitted then no error code is assigned (**null** value).
        VTL assumes that a Value Domain errorcode_vd of the error codes exists
        in the Information Model and contains all the possible error codes: the
        errorCode literal must be one of the possible Values of such a Value
        Domain. VTL assumes also that a Variable errorcode for describing the
        error codes exists in the IM and is a dependent variable of the Data
        Sets which contain the results of the validation.
    * - errorLevel
      - a literal denoting the error level (severity) associated to
        the rule, to be assigned to the possible non-valid results in case the
        Rule is used for validation. If omitted then no error level is assigned
        (**null** value). VTL assumes that a Value Domain errorlevel_vd of the error
        levels exists in the Information Model and contains all the possible
        error levels: the errorLevel literal must be one of the possible Values
        of such a Value Domain. VTL assumes also that a Variable errorlevel for
        describing the error levels exists in the IM and is a dependent variable
        of the Data Sets which contain the results of the validation.
    * - leftCondition
      - a *boolean* expression which defines the pre-condition for
        evaluating the left member Code Item (i.e., it is evaluated only when
        the leftCondition is **true**); It can contain references to the Value
        domains or the Variables of the conditioningSignature of the Ruleset and
        Constants; all the VTL-ML component level operators are allowed. The
        leftCondition is optional, if missing it is assumed to be **true** and the
        Rule is always evaluated.
    * - leftCodeItem
      - a Code Item of the Value Domain specified in the hrRulesetSignature.
    * - rightCodeItem
      - a Code Item of the Value Domain specified in the hrRulesetSignature.
    * - rightCondition
      - a *boolean* scalar expression which defines the condition
        for a right member Code Item to contribute to the evaluation of the Rule
        (i.e., the right member Code Item is taken into account only when the
        relevant rightCondition is **true**). It can contain references to the Value
        Domains or Variables of the vdConditioningSignature or
        varConditioningSignature of the Ruleset and Constants; all the VTL-ML
        component level operators are allowed. The rightCondition is optional,
        if omitted then it is assumed to be **true** and the right member Code Item
        is always taken into account.

---------------------
Input parameters type
---------------------

rulesetName :: 
    
    name < ruleset >

ruleValueDomain :: 
    
    name <valuedomain >

condValueDomain :: 
    
    name <valuedomain >

vdAlias :: 
    
    name

ruleVariable :: 
    
    name

condVariable :: 
    
    name

varAlias :: 
    
    name

ruleName :: 
    
    name

errorCode :: 
    
    errorcode_vd

errorLevel :: 
    
    errorlevel_vd

leftCondition :: 
    
    boolean

leftCodeItem :: 
    
    name

rightCodeItem :: 
    
    name

rightCondition :: 
    
    boolean

------------
Constraints
------------

*  leftCondition and rightCondition can refer only to Value Domains or
   Variables specified in vdConditioningSignature or
   varConditioningSignature.
*  Either the ruleName is specified for all the Rules of the Ruleset or
   for none.
*  If specified, the ruleName must be unique within the Ruleset\ *.*

----------------------
Semantic specification
----------------------

This operator defines a Hierarchical Ruleset named rulesetName that can
be used both for validation and calculation purposes (see
**check_hierarchy** and **hierarchy**). A Hierarchical Ruleset is a set
of Rules expressing logical relationships between the Values (Code
Items) of a Value Domain or a Represented Variable.

Each rule contains a Code Item Relation, possibly conditioned, which
expresses the **relation between Code Items** to be enforced. In the
relation, the left member Code Item is put in relation to a combination
of one or more right member Code Items. The kinds of relations are
described below.

The left member Code Item can be optionally conditioned through a
leftCondition, a *boolean* expression which defines the cases in which
the Rule has to be applied (if not declared the Rule is applied ever).
The participation of each right member Code Item in the Relation can be
optionally conditioned through a rightCondition, a *boolean* expression
which defines the cases in which the Code Item participates in the
relation (if not declared the Code Item participates to the relation
ever).

As for the mathematical meaning of the relation, please note that each
Value (Code Item) is the representation of an event belonging to a space
of events (i.e., the relevant Value Domain), according to the notions of
“event” and “space of events” of the probability theory (see also the
section on the Generic Models for Variables and Value Domains in the VTL
IM). Therefore the relations between Values (Code Items) express logical
implications between events.

The envisaged types of relations are: “coincides” (**=**), “implies”
(**<**), “implies or coincides” (**<=**), “is implied by” (**>**), “is
implied by or coincides” (**>=**) [2]_. For example:

*UnitedKingdom < Europe*

means that UnitedKingdom implies Europe (if a point belongs to United
Kingdom it also belongs to Europe).

*January2000 < year2000*

means that January of the year 2000 implies the year 2000 (if a time
instant belongs to “January 2000” it also belongs to the “year 2000”)

The first member of a Relation is a single Code Item. The second member
can be either a single Code Item, like in the example above, or a
**logical composition of Code Items** giving another Code Item as
result. The logical composition can be defined by means of Code Item
Operators, whose goal is to compose some Code Items in order to obtain
another Code Item.

Please note that the symbols **+** and **-** do not denote the usual
operations of sum and subtraction, but logical operations between Code
Items which are seen as events of the probability theory. In other
words, two or more Code Items cannot be summed or subtracted to obtain
another Code Item, because they are events and not numbers, however they
can be manipulated through logical operations like “OR” and
“Complement”.

Note also that the **+** also acts as a declaration that all the Code
Items denoted by **+** in the formula are mutually exclusive one another
(i.e., the corresponding events cannot happen at the same time), as well
as the **-** acts as a declaration that all the Code Items denoted by
**-** in the formula are mutually exclusive one another and furthermore
that each one of them is a part of (implies) the result of the
composition of all the Code Items having the **+** sign.

At intuitive level, the symbol **+** means “\ *with”* (Benelux = Belgium
*with* Luxembourg *with* Netherland) while the symbol **-** means
“\ *without”* (EUwithoutUK = EuropeanUnion *without* UnitedKingdom).

When these relationships are applied to additive numeric measures (e.g.,
the population relevant to geographical areas), they allow to obtain the
measure values of the compound Code Items (i.e., the population of
Benelux and EUwithoutUK) by summing or subtracting the measure values
relevant to the component Code Items (i.e., the population of Belgium,
Luxembourg and Netherland). This is why these logical operations are
denoted in VTL through the same symbols as the usual sum and
subtraction. Please note also that this property is valid whichever is
the Data Set and whichever is the additive measure (provided that the
possible other Identifier Components of the Data Set Structure have the
same values), therefore the Rulesets of this kind are potentially
largely reusable.

The Ruleset Signature specifies the space on which the Ruleset is
defined, i.e., the ValueDomain or Variable on which the Code Item
Relations are defined (the Ruleset is meant to be applicable to Data
Sets having a Component which takes values on such a Value Domain or are
defined by such a Variable). The optional vdConditioningSignature
specifies the conditioning Value Domains (the conditions can refer only
to those Value Domains), as well as the optional
varConditioningSignature specifies the conditioning Variables (the
conditions can refer only to those Variables).

The Hierarchical Ruleset may act on one or more Measures of the input
Data Set provided that these measures are additive (for example it
cannot be applied on a measure containing a “mean” because it is not
additive).

Within the Hierarchical Rulesets there can be dependencies between
Rules, because the inputs of some Rules can be the output of other
Rules, so the former can be evaluated only after the latter. For
example, the data relevant to the Continents can be calculated only
after the calculation of the data relevant to the Countries. As a
consequence, the order of calculation of the Rules is determined by
their mutual dependencies and can be different from the order in which
the Rules are written in the Ruleset. The dependencies between the Rules
form a directed acyclic graph.

**The Hierarchical ruleset can be used for calculations** to calculate
the upper levels of the hierarchy if the data relevant to the leaves (or
some other intermediate level) are available in the operand Data Set of
the **hierarchy** operator (for more information see also the
“Hierarchy” operator). For example, having additive Measures broken by
region, it would be possible to calculate these Measures broken by
countries, continents and the world. Besides, having additive Measures
broken by country, it would be possible to calculate the same Measures
broken by continents and the world.

When a Hierarchical Ruleset is used for calculation, only the Relations
expressing coincidence (**=**) are evaluated (provided that the
leftCondition is **true**, and taking into account only right-side Code
Items whose rightCondition is **true**). The result Data Set will contain
the compound Code Items (the left members of those relations) calculated
from the component Code Items (the right member of those Relations),
which are taken from the input Data Set (for more details about the
evaluation options see the **hierarchy** operator). Moreover, the
clauses typical of the validation are ignored (e.g., ErrorCode,
ErrorLevel).

The Hierarchical Ruleset can be also used to filter the input Data
Points. In fact if some Code Items are defined equal to themselves, the
relevant Data Points are brought in the result unchanged. For example,
the following Ruleset will maintain in the result the Data Points of the
input Data Set relevant to Belgium, Luxembourg and Netherland and will
add new Data Points containing the calculated value for Benelux:


::

   define hierarchical ruleset BeneluxRuleset ( valuedomain rule GeoArea) is

        Belgium = Belgium

        ; Luxembourg = Luxembourg

        ; Netherlands = Netherlands

        ; Benelux = Belgium + Luxembourg + Netherlands

   end hierarchical ruleset

**The Hierarchical Rulesets can be used for validation** in case various
levels of detail are contained in the Data Set to be validated (see also
the **check_hierarchy** operator for more details). The Hierarchical
Rulesets express the coherency Rules between the different levels of
detail. Because in the validation the various Rules can be evaluated
independently, their order is not significant.

If a Hierarchical Ruleset is used for validation, all the possible
Relations (**=**, **>**, **>=**, **<**, **<=**) are evaluated (provided
that the leftCondition is **true** and taking into account only right-side
Code Items whose rightCondition is **true**). The Rules are evaluated
independently. Both the Code Items of the left and right members of the
Relations are expected to belong to and taken from the input Data Set
(for more details about the evaluation options see the
**check_hierarchy** operator). The Antecedent Condition is evaluated
and, if **true**, the operations specified in the right member of the
Relation are performed and the result is compared to the first member,
according to the specified type of Relation. The possible relations in
which Code Items are defined as equal to themselves are ignored. Further
details are described in the **check_hierarchy** operator.

If the data to be validated are in different Data Sets, either they can
be joined in advance using the proper VTL operators or the validation
can be done by comparing those Data Sets directly, without using a
Hierarchical Ruleset (see also the **check** operator).

**Through the right and left Conditions, the Hierarchical Rulesets allow
to declare the time validity of Rules and Relations**. In fact
leftCondition and RightCondition can be defined in term of the time
Value Domain, expressing respectively when the left member Code Item has
to be evaluated (i.e., when it is considered valid) and when a right
member Code Item participates in the relation.

The following two simplified examples show possible ways of defining the
European Union in term of participating Countries.

*Example 1* (for simplicity the time literals are written without the
needed “cast” operation)

::

   define hierarchical ruleset EuropeanUnionAreaCountries1 
      ( valuedomain condition ReferenceTime as Time rule GeoArea ) is

        when between (Time, “1.1.1958”, “31.12.1972”)
                then EU = BE + FR + DE + IT + LU + NL

        ; when between (Time, “1.1.1973”, “31.12.1980”)
                then EU = *… same as above …* + DK + IE + GB

        ; when between (Time, “1.1.1981”, “02.10.1985”)
            then EU = *… same as above …* + GR

        ; when between (Time, “1.1.1986”, “31.12.1994”)
            then EU = *… same as above …* + ES + PT

        ; when between (Time, “1.1.1995”, “30.04.2004”)
            then EU = *… same as above …* + AT + FI + SE

        ; when between (Time, “1.5.2004”, “31.12.2006”)
            then EU = *… same as above …* +CY+CZ+EE+HU+LT+LV+MT+PL+SI+SK

        ; when between (Time, “1.1.2007”, “30.06.2013”)
            then EU = *… same as above …* + BG + RO

        ; when >= “1.7.2013”
            then EU = *… same as above …* + HR

   end hierarchical ruleset

*Example 2* (for simplicity the time literals are written without the
needed “cast” operation)

::

   define hierarchical ruleset EuropeanUnionAreaCountries2
      (valuedomain condition ReferenceTime as Time rule GeoArea ) is

   EU = AT [ Time >= “0101.1995” ]
      + BE [ Time >= “01.01.1958” ]
      + BG [ Time >= “01.01.2007” ]
      + …
      + SE [ Time >= “01.01.1995” ]
      + SI [ Time >= “01.05.2004” ]
      + SK [ Time >= “01.05.2004” ]

   end hierarchical ruleset

**The Hierarchical Rulesets allow defining hierarchies** either having
or not having levels (free hierarchies). For example, leaving aside the
time validity for sake of simplicity:

::

   define hierarchical ruleset GeoHierarchy ( valuedomain rule Geo_Area) is

        World = Africa + America + Asia + Europe + Oceania

        ; Africa = Algeria + … + Zimbabwe

        ; America = Argentina + … + Venezuela

        ; Asia = Afghanistan + … + Yemen

        ; Europe = Albania + … + VaticanCity

        ; Oceania = Australia + … + Vanuatu

        ; Afghanistan = AF_reg_01 + … + AF_reg_N

        … … … … … …

        ; Zimbabwe = ZW_reg_01 + … + ZW_reg_M

        ; EuropeanUnion = … + … + … + …

        ; CentralAmericaCommonMarket = … + … + … + …

        ; OECD_Area = … + … + … + …

   end hierarchical ruleset

**The Hierarchical Rulesets allow defining multiple relations for the
same Code Item.**

Multiple relations are often useful for validation. For example, the
Balance of Payments item "Transport" can be broken down both by type of
carrier (Air transport, Sea transport, Land transport) and by type of
objects transported (Passengers and Freights) and both breakdowns must
sum up to the whole "Transport" figure. In the following example a
RuleName is assigned to the different methods of breaking down the
Transport.

:: 

   define hierarchical ruleset TransportBreakdown ( variable rule BoPItem ) is 

        transport_method1 : Transport = AirTransport + SeaTransport +
        LandTransport

        ; transport_method2 : Transport = PassengersTransport +
        FreightsTransport

   end hierarchical ruleset

Multiple relations can be useful even for calculation. For example,
imagine that the input Data Set contains data about resident units
broken down by region and data about non-residents units broken down by
country. In order to calculate a homogeneous level of aggregation (e.g.,
by country), a possible Ruleset is the following:

::

   define hierarchical ruleset CalcCountryLevel ( valuedomain condition
      Residence rule GeoArea) is

        when Residence = “resident” then Country1 = Country1

        ; when Residence = “non-resident” then Country1 = Region11+ … +Region1M
        …

        ; when Residence = “resident” then CountryN = CountryN

        ; when Residence = “non-resident” then CountryN = Region N1+ …+ RegionNM

   end hierarchical ruleset

In the calculation, basically, for each Rule, for all the input Data
Points and provided that the conditions are **true**, the right Code Items
are changed into the corresponding left Code Item, obtaining Data Points
referred only to the left Code Items. Then the outcomes of all the Rules
of the Ruleset are aggregated together to obtain the Data Points of the
result Data Set.

As far as each left Code Item is calculated by means of a single Rule
(i.e., a single calculation method), this process cannot generate
inconsistencies.

Instead if a left Code Item is calculated by means of more Rules (e.g.,
through more than one calculation method), there is the risk of
producing erroneous results (e.g., duplicated data), because the outcome
of the multiple Rules producing the same Code Item are aggregated
together. Proper definition of the left or right conditions can avoid
this risk, ensuring that for each input Data Point just one Rule is
applied.

If the Ruleset is aimed only at validation, there is no risk of
producing erroneous results because in the validation the rules are
applied independently.

--------
Examples
--------

1) The Hierarchical Ruleset is defined on the Value Domain “sex”: Total
is defined as Male + Female. No conditions are defined.

::
    define hierarchical ruleset sex_hr (valuedomain rule sex) is

        TOTAL = MALE + FEMALE

    end hierarchical ruleset

2) BENELUX is the aggregation of the Code Items BELGIUM, LUXEMBOURG and
NETHERLANDS. No conditions are defined.

::

   define hierarchical ruleset BeneluxCountriesHierarchy (valuedomain rule GeoArea) is

        BENELUX = BELGIUM + LUXEMBOURG + NETHERLANDS errorcode “Bad value for
        Benelux”

   end hierarchical ruleset

3) American economic partners. The first rule states that the value for
North America should be greater than the value reported for US. This
type of validation is useful when the data communicated by the data
provider do not cover the whole composition of the aggregate but only
some elements. No conditions are defined.

::

   define hierarchical ruleset american_partners_hr (variable rule PartnerArea) is

        NORTH_AMERICA > US

        ; SOUTH_AMERICA = BR + UY + AR + CL

   end hierarchical ruleset

4) Example of an aggregate Code Item having multiple definitions to be
used for validation only. The Balance of Payments item "Transport" can
be broken down by type of carrier (Air transport, Sea transport, Land
transport) and by type of objects transported (Passengers and Freights)
and both breakdowns must sum up to the total "Transport" figure.

::

   define hierarchical ruleset validationruleset_bop (variable rule BoPItem ) is

        transport_method1 : Transport = AirTransport + SeaTransport +
        LandTransport

        ; transport_method2 : Transport = PassengersTransport +
        FreightsTransport

   end hierarchical ruleset

   
.. [2]
   “Coincides” means “implies and is implied”
