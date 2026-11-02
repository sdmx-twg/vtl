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

.. [41]
   ISO/IEC 14977

.. [42]
   http://en.wikipedia.org/wiki/Context-free_grammar

.. [43]
   http://en.wikipedia.org/wiki/Yacc