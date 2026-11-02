Conventions for describing the operators’ syntax
================================================

Each VTL operator has an explanatory name, which recalls the operator
function (e.g., “Greater than”) and a syntactical symbol, which is used
to invoke the operator (e.g., “\ **>**\ ”). The operator symbol may also
be alphabetic, always lowercase (e.g., **round**).

In the VTL-DL, the operator symbol is the keyword **define** followed by
the name of the object to be defined. The complete operator symbol is
therefore a compound lowercase sentence (e.g. **define operator**).

In the VTL-ML, the operator symbol does not contain spaces and may be
either a sequence of special characters (like **+**, **-**, **>=**,
**<=** and so on) or a text keyword (e.g., **and**, **or**, **not**).
The keyword may be compound with underscores as separators (e.g.,
**exists_in**).

Each operator has a syntax, which is a set of formal rules to invoke the
operator correctly. In this document, the syntax of the operators is
formally described by means of a meta-syntax which is not part of the
VTL language, but has only presentation purposes.

The meta-syntax describes the syntax of the operators by means of
*meta-expressions*, which define how the invocations of the operators
must be written. The meta-expressions contain the symbol of the operator
(e.g., “\ **join**\ ”), the possible other keywords to denote special
parameters (e.g., **using**), other symbols to be used (e.g.,
parentheses, commas), the named formal parameters (e.g., multiplicand
and multiplier for the multiplication).

As for the typographic stile, in order to distinguish between the syntax
symbols (which are used in the operator invocations) and meta-syntax
symbols (used just for explanatory purposes, and not actually used in
invocations), the syntax symbols are in **boldface** (i.e., the operator
symbol, the special keywords, the possible parenthesis, commas an so
on). The names of the generic operands (e.g., multiplicand, multiplier)
are in Roman type, even if they are part of the syntax.

The meta-expression can be very simple, for example the meta-expression
for the addition is:

        op1 **+** op2

This means that the addition has two operands (op1, op2) and is invoked
by specifying the name of the first addendum (op1), then the addition
symbol (**+**) followed by the name of the second addendum (op2).

In this example, all the three parts of the meta-expression are fixed.
In other cases, the meta-expression can be more complex and made of
optional, alternative or repeated parts.

In the simple cases, the optional parts are denoted by using the
*italic* face, for example:

        **substr (** op **,** *start* **,** *length* **)**

The expression above implies that in the **substr** operator the start
and length operands are optional. In the invocation, a non-specified
optional operand is substituted by an underscore or, if it is in the end
of the invocation, can be omitted. Hence the following syntaxes are all
formally correct:

        **substr (** op\ **,** start\ **,** length **)**

        **substr (** op\ **,** start **)**

        **substr (** op\ **,** \_ **,** length **)**

        **substr (** op **)**

In more complex cases, a **regular expression style** is used to denote
the parts (sub-expressions) of the meta-expression that are optional,
alternative or repeated. In particular, braces denote a sub-expression;
a vertical bar (or sometimes named “pipe”) within braces denotes
possible alternatives; an optional trailing number, following the
braces, specifies the number of possible repetitions.

*  non-optional : non-optional sub-expression (text without braces)
*  {optional} : optional sub-expression (zero or 1 occurrence)
*  {non-optional}\ :sup:`1` : non-optional sub-expression (just 1
   occurrence)
*  {one-or-more}+ : sub-expression repeatable from 1 to many occurrences
*  {zero-or-more}\* : sub-expression repeatable from 0 to many
   occurrences
*  { part1 \| part2 \| part3 } : optional alternative sub-expressions
   (zero or 1 occurrence)
*  { part1 \| part2 \| part3 }\ :sup:`1` : alternative sub-expressions
   (just 1 occurrence)
*  { part1 \| part2 \| part3 }+: alternative sub-expressions, from 1 to
   many occurrences
*  { part1 \| part2 \| part3 }\* : alternative sub-expressions, from 0
   to many occurrences

Moreover, to improve the readability, some sub-expressions (the
underlined ones) can be referenced by their names and separately
defined, for example a meta-expression can take the following form:

   sub-expr1-text sub-expr2-name_ … sub-exprN-1-name_  sub-exprN-text

        .. _sub-expr2-name:
        
        sub-expr2-name ::= sub-expr2-text

        ... possible others ...

        .. _sub-exprN-1-name:

        sub-exprN-1-name ::= sub-exprN-1-text

In this representation of a meta-expression:

*  The first line is the text of the meta-expression
*  sub-expr\ :sub:`1`-text, sub-expr\ :sub:`N`-text are sub-expressions
   directly written in the meta-expression
*  *sub-expr\ 2-name*, … *sub-expr\ N-1-name* are identifiers of
   sub-expressions.
*  sub-expr\ :sub:`2`-text, … sub-expr\ :sub:`N-1`-text are
   subexpression written separately from the meta-expression.
*  The symbol **::=** means “is defined as” and denotes the assignment
   of a sub-expression-text to a sub-expression-name.

The following example shows the definition of the syntax of the
operators for removing the leading and/or the trailing whitespaces from
a string:

        Meta-expression ::= { **trim** \| **ltrim** \| **rtrim** }\ :sup:`1`
        **(** op **)**

The meta-expression above synthesizes that:

*  **trim**, **ltrim**, **rtrim** are the operators’ symbols (reserved
   keywords);
*  **(**, **)** are symbols of the operators syntax (reserved keywords);
*  op is the only operand of the three operators;
*  “{ }\ :sup:`1”` and **“**\ \|” are symbols of the meta-syntax; in
   particular “\|” indicates that the three operators are alternative (a
   single invocation can contain only one of them) and “{ }\ :sup:`1”`
   indicates that a single invocation contains just one of the shown
   alternatives;

From this template, it is possible to infer some valid possible
invocations of the operators:
::
  
        ltrim ( DS_2 )
        rtrim ( DS_3 )

In these invocations, **ltrim** and **rtrim** are the symbols of the
invoked operator and DS_2 and DS_3 are the names of the specific Data
Sets which are operands respectively of the former and the latter
invocation.