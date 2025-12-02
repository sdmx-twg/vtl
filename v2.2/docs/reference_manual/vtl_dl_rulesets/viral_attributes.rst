#########################################
define viral propagation
#########################################

---------
Semantics
---------

The **define viral propagation** construct registers the algorithm that
must be applied whenever an operator propagates the value of a viral
Attribute. The propagation can be attached either to a Represented
Variable (i.e., to the Attribute itself) or to the Value Domain used by
the Attribute and is automatically reused by every operator that states
that viral Attributes must be propagated. When a propagation rule is
declared on a Value Domain it acts as the default for all Attributes
using that Value Domain, unless a more specific rule is defined directly
on the Attribute’s Represented Variable. It is a semantic error to
define more than one propagation rule for the same Value Domain or for
the same Variable.

The input of a propagation rule is a **pair** of values from the viral
Attribute. The propagation algorithm is a binary operation that is
associative, commutative, and reflexive. When an operator involves more
than two operands (e.g., an aggregate function or an N-ary arithmetic
operation), the propagation rule is applied recursively to the values
pair by pair. The final result is independent of the order in which the
pairs are evaluated.

Two modelling families are supported:

* **Enumerated rules.** These rules are intended for Attributes that are
  based on enumerated Value Domains. They are expressed through ordered
  **when** … **then** clauses. Each clause describes a combination of
  input values and the resulting value that shall be produced. The
  clauses are evaluated in order, but **binary clauses** (specifying a
  pair of values) always take precedence over **unary clauses**
  (specifying a single value).

  * A **binary clause** (e.g., ``when "A" and "B" then "C"``) matches
    if the input pair consists of exactly those two values.
  * A **unary clause** (e.g., ``when "A" then "A"``) matches if the
    specified value is present in the input pair (regardless of what the
    other value is).

  The first matching clause determines the result. To guarantee
  determinism and associativity, the rule must be defined such that the
  result is consistent regardless of grouping.

  Optionally, an **else** clause can provide the default result for any
  combination that is not explicitly listed; when it is absent, missing
  combinations yield NULL. Every combination of values can be described
  only once. The use of the **or** operator is not allowed; every
  combination must be listed explicitly.

* **Aggregate rules.** These rules are meant for Attributes that use
  non-enumerated Value Domains (for example dates or numbers). The rule
  simply names the aggregate function that must collapse the set of
  operand values to a single result. Only a dedicated list of aggregate
  keywords (**min**, **max**, **sum**, **avg**) can be used so that the
  propagation stays deterministic and implementation-independent.

Operators do not accept propagation instructions directly: once the
propagation is defined (either on the Value Domain or on the Variable),
every operator that propagates viral Attributes must apply that
definition (e.g., the typical behaviour rules for binary, aggregate,
analytic, or join operators).

------
Syntax
------

**define viral propagation** propagationName **(** vpSignature_ **) is**

    vpClause_

   { **;** vpClause_ }\*

**end viral propagation**

.. _vpSignature:

vpSignature ::= **valuedomain** valueDomain | **variable** variable

.. _vpClause:

vpClause ::= enumeratedClause_ | aggregationClause_ | defaultClause_

.. _enumeratedClause:

enumeratedClause ::= { ruleName **:** } **when** enumerationCondition_ **then** vpResult

.. _aggregationClause:

aggregationClause ::= **aggregate** aggregateFunction

.. _defaultClause:

defaultClause ::= **else** vpResult

.. _enumerationCondition:

enumerationCondition ::= enumerationTerm [ **and** enumerationTerm ]

.. _enumerationTerm:

enumerationTerm ::= scalarLiteral

.. _aggregateFunction:

aggregateFunction ::= **min** | **max** | **sum** | **avg**

--------------------
Syntax description
--------------------

.. list-table::

   * - propagationName
     - the name assigned to the propagation definition. It can be used
       to reference the rule in documentation or metadata repositories.
   * - *vpSignature*
     - the signature of the propagation definition. It can target either
       a Value Domain or a Represented Variable. When a Value Domain is
       specified, every Attribute using that Value Domain inherits the
       propagation unless it defines its own Variable-level rule.
   * - valueDomain
     - the Value Domain for which the propagation is defined. Only one
       propagation definition can exist for the same Value Domain.
   * - variable
     - the Represented Variable owning the viral Attribute. If more than
       one propagation definition is declared for the same Variable, a
       semantic error is raised. Variable-level definitions override any
       Value Domain rule that might exist for the Attribute.
   * - *vpClause*
     - a clause that participates in the definition. Clauses are
       evaluated in the order in which they are written. Aggregation
       clauses cannot be mixed with enumerated clauses: a propagation
       uses either a single aggregation clause or a sequence of
       enumerated clauses (plus an optional default clause).
   * - *enumeratedClause*
     - describes a combination of input values (a pair or a single value).
       The clause is triggered when the input pair matches the condition.
       Binary clauses (two values) are checked before unary clauses
       (one value).
   * - *enumerationCondition*
     - specifies the values to match. It can be a single value (unary)
       or two values separated by **and** (binary).
   * - vpResult
     - the literal value that must be propagated when the clause is
       satisfied. It must belong to the same Value Domain as the viral
       Attribute unless NULL is explicitly desired.
   * - *defaultClause*
     - an optional fallback clause triggered after all other
       enumerated clauses when none of them matches. If omitted and no
       enumerated clause matches, NULL is propagated.
   * - *aggregationClause*
     - specifies that the viral Attribute uses a non-enumerated Value
       Domain and that the input set must be reduced by applying the
       indicated aggregate function. Only one aggregation clause is
       allowed inside a propagation definition.
   * - aggregateFunction
     - the keyword naming the allowed aggregate to be applied on the
       input set: **min**, **max**, **sum**, or **avg**. The semantics of
       these aggregates follow the standard VTL definitions.

--------
Examples
--------

Enumerated Attribute with strict priority (the CL_CONF list with
``C > N > F``):

::

   define viral propagation CONF_priority (variable CONF) is
      when "C" then "C";
      when "N" then "N";
      else "F"
   end viral propagation

Enumerated Attribute defined once for the Value Domain so that every
Attribute using *CL_OBS_STATUS* inherits it. Note that all combinations
are listed explicitly:

::

   define viral propagation OBS_STATUS_default (valuedomain CL_OBS_STATUS) is
      when "M" then "M";
      when "L" then "L";
      when "F" then "F";
      when "E" then "F";
      when "Q" and "P" then "Q";
      else "A"
   end viral propagation

Enumerated Attribute where the combination of input values produces a
new code (computed missing status). The binary rule ``"C" and "M"``
takes precedence over the unary rule ``"M"``:

::

   define viral propagation COMPUTED_missing (variable COMPUTED) is
      when "C" and "M" then "N";
      when "M" then "M";
      else " "
   end viral propagation

Non-enumerated Attribute where the most restrictive embargo time has to
prevail across operations:

::

   define viral propagation EMBARGO_time (variable EMBARGO_TIME) is
      aggregate max
   end viral propagation
