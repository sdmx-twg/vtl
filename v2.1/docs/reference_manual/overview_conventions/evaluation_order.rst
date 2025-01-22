VTL-ML - Evaluation order of the Operators
===========================================

Within a single expression of the manipulation language, the operators
are applied in sequence, according to the precedence order. Operators
with the same precedence level are applied according to the default
associativity rule. Precedence and associativity orders are reported in
the following table.

+-------------+-----------------+-------------------------+----------------+
| Evaluation  | Operator        | Description             | Default        |
| order       |                 |                         | as             |
|             |                 |                         | sociativity    |
|             |                 |                         | rule           |
+=============+=================+=========================+================+
| I           | ( )             | Parentheses. To alter   | None           |
|             |                 | the default order.      |                |
+-------------+-----------------+-------------------------+----------------+
| II          | VTL operators   | VTL operators with      | Left-to-right  |
|             | with functional | functional syntax       |                |
|             | syntax          |                         |                |
+-------------+-----------------+-------------------------+----------------+
| III         | Clause          | Clause                  | Left-to-right  |
|             |                 |                         |                |
|             | Membership      | Membership              |                |
+-------------+-----------------+-------------------------+----------------+
| IV          | unary plus      | Unary minus             | None           |
|             |                 |                         |                |
|             | unary minus     | Unary plus              |                |
|             |                 |                         |                |
|             | not             | Logical negation        |                |
+-------------+-----------------+-------------------------+----------------+
| V           | \*              | Multiplication          | Left-to-right  |
|             |                 |                         |                |
|             | /               | Division                |                |
+-------------+-----------------+-------------------------+----------------+
| VI          | \+              | Addition                | Left-to-right  |
|             |                 |                         |                |
|             | \-              | Subtraction             |                |
|             |                 |                         |                |
|             | \|\|            | String concatenation    |                |
+-------------+-----------------+-------------------------+----------------+
| VII         | > >=            | Greater than            | Left-to-right  |
|             |                 |                         |                |
|             | < <=            | Less than               |                |
|             |                 |                         |                |
|             | =               | Equal-to                |                |
|             |                 |                         |                |
|             | <>              | Not-equal-to            |                |
|             |                 |                         |                |
|             | in              | In a value list         |                |
|             |                 |                         |                |
|             | not_in          | Not in a value list     |                |
+-------------+-----------------+-------------------------+----------------+
| VIII        | and             | Logical AND             | Left-to-right  |
|             |                 |                         |                |
+-------------+-----------------+-------------------------+----------------+
| IX          | or              | Logical OR              | Left-to-right  |
|             |                 |                         |                |
|             | xor             | Logical XOR             |                |
+-------------+-----------------+-------------------------+----------------+
| X           | if-then-else    | Conditional             | None           |
|             |                 | (if-then-else/case)     |                | 
|             | case            |                         |                |
+-------------+-----------------+-------------------------+----------------+
