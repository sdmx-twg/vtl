------
Syntax
------

    op **[ calc** { calcRole } calcComp := calcExpr { , { calcRole_ } calcComp := calcExpr }* **]**

        .. _calcRole:
        
        calcRole ::= **identifier | measure | attribute | viral attribute**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - calcRole
     - the role to ba assigned to a Component to be calculated
   * - calcComp
     - the name of a Component to be calculated
   * - calcExpr
     - | expression at component level, having only Components of the
       | input Data Sets as operands, used to calculate a Component

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  DS_1 [ calc Me_3 := Me_1 + Me_2 ]

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset

calcComp ::

    name<component>

calcExpr ::

    component<scalar>

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
The *calcComp* parameter cannot be the name of an Identifier component.

All the components used in *calcComp* must belong to the operand Data Set *op*.

--------
Behavior
--------

The operator calculates new Identifier, Measure or Attribute Components on the basis of sub-expressions at
Component level. Each Component is calculated through an independent sub-expression. It is possible to specify
the role of the calculated Component among **measure**, **identifier**, **attribute**, or **viral attribute**, therefore the calc
clause can be used also to change the role of a Component when possible. The keyword **viral** allows controlling
the virality of the calculated Attributes (for the attribute propagation rule see the User Manual). When the role is
omitted, the following rule is applied: if the component exists in the operand Data Set then it maintains its role; if
the component does not exist in the operand Data Set then its role is Measure.

The *calcExpr* sub-expressions are independent one another, they can only reference Components of the input
Data Set and cannot use Components generated, for example, by other *calcExpr*. If the calculated Component is a
new Component, it is added to the output Data Set. If the Calculated component is a Measure or an Attribute that
already exists in the input Data Set, the calculated values overwrite the original values. If the calculated
Component is an Identifier that already exists in the input Data Set, an exception is raised because overwriting
an Identifier Component is forbidden for preserving the functional behaviour. Analytic invocations can be used
in the **calc** clause.

