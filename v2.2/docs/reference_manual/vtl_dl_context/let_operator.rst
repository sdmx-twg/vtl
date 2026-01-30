#############
Let statement
#############

---------
Semantics
---------

The `let` statement allows the inline definition of an execution context for a given transformation scheme
by directly specifying simple constants or contant expressions that compose such context for a single execution. 
Implementations may provide an alternative way of creating such a context, such as loading constants from a file
or asking the users to input it on the keyboard, providing that this context is immutable for the entire 
duration of the transformation scheme execution and across transformation schemes that are linked together in a
single execution.

The context must be composed entirely of scalars; "context datasets" are not allowed. Constants are referenced
throughout the transformation scheme by the use of a particular prefix (a single ampersand). Note that the prefix
must never be put inside single or double quotes, even if the referenced constant name is quoted itself.

------
Syntax
------

**let** { valueDomain } name **:=** constantExpression

----------------
Input Parameters
----------------

.. list-table::

   * - name
     - The name of the constant or constant expression being defined.
   * - valueDomain 
     - an optional Value Domain name on which the constant is defined.
       If the value domain name is not specified, it is inferenced from
       the constant expression.
   * - constantExpression 
     - a simple constant value or a **constant** expression to be referenced with
       the specified name. If the Value Domain name is specified, the implementation
       must check that the value or tjhe result of the expression specified can be
       cast to that value domain. 

----------------------
Additional Constraints
----------------------

While evaluating constants, no VTL dataset or scalar should be accessible.

Implementations are free to optimize the evaluation of constant expressions.

When constants are not defined with the `let` statement, no restriction is
posed on which mechanism should be used to recall a constant value or the value of a
constant expression, only that the value remains the same throughout the entire
transformation scheme computation.

When constants are defined inline with the `let` statement, it is recommended that
the inlined value have precedence over a value loaded from an external source by the 
implementation. 

--------
Examples
--------

::

   let integer current_year := getyear(current_date());

   current_year_evaluation := yearly_evaluations[sub YEAR = &current_year];
   
