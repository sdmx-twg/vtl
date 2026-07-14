------
Syntax
------

    **case when** condition **then** thenOperand  {**when** condition **then** thenOperand}*
         **else**   elseOperand


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

    case when A > B then A when A = B then A else B

------------------------------------
Semantics  for scalar operations
------------------------------------
The **case** operator returns the first *thenOperand* whose corresponding *condition* evaluates to **true**, 
*elseOperand* if none of the **when** conditions evaluates to **true**. 

For example, considering the statement: ::

    case when x1 > x2  then  2 when x1 = x2 then 0 else 5;
    
    for  x1 = 3,  x2 = 0	 it returns  2
    for  x1 = x2 = 3	     it returns  0
    for  x1 = 0,  x2 = 3	 it returns  5


-----------------------------
Input parameters type
-----------------------------
condition  ::

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

The same rules apply as for the if-then-else operator. 

---------
Behaviour
---------

For operations at Component level, the operation is applied for each Data Point of the unique input Data Set, the
**case** operator returns the value from the *thenOperand* Component whose corresponding *condition* evaluates to *true*;
if none of the **when** conditions evaluates to **true**, it returns the value from the *elseOperand* Component. 
If one of the operands *thenOperand* or *elseOperand* is scalar, such a scalar value can be returned depending on the
outcome of the condition.

For operations at Data Set level, the **case** operator returns the Data Point from the *thenOperand* when the first Data Point of 
*condition* having the same Identifiers’ values evaluates to **true**; returns the Data Point from *elseOperand* if none of the 
**when** conditions evaluates to **true**. If one of the operands *thenOperand* or *elseOperand* is scalar, such a scalar value 
can be returned (depending on the outcome of the *condition*) and in this case it feeds the values of all the Measures of 
the result Data Point.

The behaviour for two Data Sets can be procedurally explained as follows. First the *condition* Data Set is evaluated, then its true 
Data Points are inner joined with *thenOperand* and its false Data Points are inner joined with *elseOperand*, finally the union is 
made of these two partial results (the *condition* ensures that there cannot be conflicts in the union). 
