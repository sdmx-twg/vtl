Annex 1 – EBNF
==============

The VTL language is also expressed in EBNF (Extended Backus-Naur Form).

EBNF is a standard [41]_ meta-syntax notation, typically used to
describe a Context-Free grammar and represents an extension to BNF
(Backus-Naur Form) syntax. Indeed, any language described with BNF
notation can also be expressed in EBNF (although expressions are
typically lengthier).

Intuitively, the EBNF consists of `terminal
symbols <http://en.wikipedia.org/wiki/Terminal_symbol>`__ and
non-terminal production rules. Terminal symbols are the alphanumeric
characters (but also punctuation marks, whitespace, etc.) that are
allowed singularly or in a combined fashion. Production rules are the
rules governing how terminal symbols can be combined in order to produce
words of the language (i.e. legal sequences).

More details can be found at
http://en.wikipedia.org/wiki/Extended_Backus–Naur_Form

Properties of VTL grammar
-------------------------

VTL can be described in terms of a Context-Free grammar [42]_, with
productions of the form *V🡪 w*, where *V* is a single non-terminal
symbol and *w* is a string of terminal and non-terminal symbols.

VTL grammar aims at being unambiguous. An ambiguous Context-Free grammar
is such that there exists a string that can be derived with two
different paths of production rules, technically with two different
leftmost derivations.

In theoretical computer science, the problem of understanding if a
grammar is ambiguous is undecidable. In practice, many languages adopt a
number of strategies to cope with ambiguities. This is the approach
followed in VTL as well. Examples are the presence of *associativity*
and *precedence* rules for infix operators (such as addition and
subtraction), and the existence of compulsory *else* branch in
*if-then-else* operator.

These devices are reasonably good to guarantee the absence of ambiguity
in VTL grammar. Indeed, real parser generators (for instance
YACC [43]_), can effectively exploit them, in particular using the
mentioned associativity and precedence constrains as well as the
relative ordering of the productions in the grammar itself, which solves
ambiguity by default.

.. [21]
   This can be achieved in many ways that depend on the data type and on
   the adopted internal and external representations. For example, there
   can exist a default correspondence (e.g., 0 means always False and 1
   means always True for Boolean), or the parts of the external
   representation can be specified through a mask (e.g., for the dates,
   DD-MM-YYYY or YYYYMMDD specify the position of the digits
   representing year, month and day).

.. [22]
   For example, at least one default Value Domain should exists for each
   basic scalar type, the Value Domains needed to represent the results
   of the checks should exist, and so on.

.. [23]
   I.e., an expressions whose result is *boolean*

.. [24]
   “between ( x, y, z)” is the VTL operator which returns TRUE if x is
   comprised between y and z

.. [25]
   “in” is the VTL operator which returns TRUE if an element (in this
   case the value) belongs to a Set; the symbol { … , … , … } denotes a
   set defined as the list of its elements (separated by commas)

.. [26]
   “length” is the VTL Operator that returns the length of a string (in
   the example, the *integer* operand of the length operator is
   automatically cast to a string and its length is determined)

.. [27]
   See the section “Behaviour for Attribute Components”

.. [28]
   I.e., a sub-expressions whose result is *string*

.. [29]
   Therefore each combination of values of the Identifier Components
   except the reference time identifies a Time Series

.. [30]
   In the VTL syntax the symbol ( ) allows to define a tuple in-line by
   enumeration of its elements

.. [31]
   In the VTL syntax, the symbol {…} denotes a set defined as the list
   of its elements (separated by commas).

.. [32]
   In the VTL syntax, the symbol [ ] allows to define a List in-line by
   enumeration of its elements.

.. [33]
   A high-order function is a function which takes one or more other
   functions as arguments and/or provides another function as result.

.. [34]
   This corresponds to the "outer join" form of the join expressions,
   explained in details in the Reference Manual.

.. [35]
   As obvious, the data type depends on the parameter for which the Data
   Set is passed

.. [36]
   to preserve the functional behaviour *keep* and *drop* can be applied
   only on Measures and Attributes, for a deeper description of these
   operators see the corresponding section in the Reference Manual

.. [37]
   The *calc* Operator can be used also to calculate Attributes: for a
   more complete description of this operator see the corresponding
   section in the Reference Manual

.. [38]
   As obvious, the data type depends on the parameters for which the
   Data Set are passed

.. [39]
   In fact according to the IM, a Variable takes values in one Value
   Domain which represents just one basic data type, independently of
   where the Variable or the Value Domain are used (e.g. if they have
   the same type everywhere)

.. [40]
   In particular, the *keep* clause allows the specification of whether
   or not an attribute is kept in the result while the *calc* clause
   makes it possible to define calculation formulas for specific
   attributes. The *calc* can be used both for Measures and for
   Attributes and is a unary Operator, e.g. it may operate on Components
   of just one Data Set to obtain new Measures / Attributes.

.. [41]
   ISO/IEC 14977

.. [42]
   http://en.wikipedia.org/wiki/Context-free_grammar

.. [43]
   http://en.wikipedia.org/wiki/Yacc