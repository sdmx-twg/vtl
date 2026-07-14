------
Syntax
------

    **if** condition **then** thenOperand **else** elseOperand

----------------
Input parameters
----------------
.. list-table::

   * - condition
     - a Boolean condition (dataset, component or scalar)
   * - thenOperand
     - the operand returned when *condition* evaluates to **true**
   * - elseOperand
     - the operand returned when *condition* evaluates to **false**

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    if A > B then A else B 

------------------------------------
Semantics  for scalar operations
------------------------------------
The **if** operator returns *thenOperand* if *condition* evaluates to **true**, *elseOperand* otherwise. For example,
considering the statement: ::

    if x1 > x2 then 2 else 5,
        for x1 = 3, x2 =0 it returns 2
        for x1 = 0, x2 =3 it returns 5


-----------------------------
Input parameters type
-----------------------------
condition ::

    dataset { measure <boolean> _ }
    | component<Boolean>
    | boolean

thenOperand ::

    dataset
    | component
    | scalar

elseOperand ::

    dataset
    | component
    | scalar


-----------------------------
Result type
-----------------------------
result ::

    dataset
    | component
    | scalar


-----------------------------
Additional Constraints
-----------------------------

* The operands *thenOperand* and *elseOperand* must be of the same scalar type.
* If the operation is at scalar level, *thenOperand* and *elseOperand* are scalar then *condition* must be
  scalar too (a *boolean* scalar).
* If the operation is at Component level, *condition* must be a boolean expression.  
  Any Components referenced in *condition*, *thenOperand* and *elseOperand* must belong to the same Data Set.
* If the operation is at Data Set level, at least one of *thenOperand* and *elseOperand* is a Data Set (the
  other one can be scalar) and *condition* must be a Data Set too (having a unique *boolean* Measure)
  and must have the same Identifiers as *thenOperand* or/and *ElseOperand*

  * If *thenOperand* and *elseOperand* are both Data Sets then they must have the same Components in the same roles
  * If one of *thenOperand* and *elseOperand* is a Data Set and the other one is a scalar, the Measures of the operand Data 
    Set must be all of the same scalar type as the scalar operand.

---------
Behaviour
---------

For operations at Component level, the operation is applied for each Data Point of the unique input Data Set, the
**if-then-else** operator returns the value from the *thenOperand* Component when *condition* evaluates to **true**,
otherwise it returns the value from the *elseOperand* Component. If one of the operands *thenOperand* or
*elseOperand* is scalar, such a scalar value can be returned depending on the outcome of the *condition*.

For operations at Data Set level, the **if-then-else** operator returns the Data Point from *thenOperand* when the
Data Point of *condition* having the same Identifiers’ values evaluates to **true**, and returns the Data Point from
*elseOperand* otherwise. If one of the operands *thenOperand* or *elseOperand* is scalar, such a scalar value can
be returned (depending on the outcome of the *condition*) and in this case it feeds the values of all the Measures
of the result Data Point.

The behaviour for two Data Sets can be procedurally explained as follows. First the *condition* Data Set is
evaluated, then its true Data Points are inner joined with *thenOperand* and its false Data Points are inner
joined with *elseOperand*, finally the union is made of these two partial results (the *condition* ensures that there
cannot be conflicts in the union).
