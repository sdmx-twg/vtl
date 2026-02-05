------
Syntax
------

    **match_characters (** op , pattern **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the dataset to be checked
   * - pattern
     - the regular expression to check the Data Set or the Component against

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  match_characters(ds1, "[abc]+\d\d")
  ds1 [ calc m1 := match_characters(ds1, "[abc]+\d\d") ]

------------------------------------
Semantics  for scalar operations
------------------------------------
**match_characters** returns **true** if *op* matches the regular expression *regexp*, **false** otherwise.

The string *regexp* is an Extended Regular Expression as described in the POSIX standard[^1]. Different
implementations of VTL may implement different versions of the POSIX standard therefore it is
possible that **match_characters** may behave in slightly different ways.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset {measure<string> _}
    | component<string>
    | string

pattern ::

    component<string>
    | string

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<boolean> bool_var }
    | component<boolean>
    | boolean

-----------------------------
Additional Constraints
-----------------------------
If *op* is a Data Set then it has exactly one measure.

*pattern* is a POSIX regular expression.

---------
Behaviour
---------

The operator has the typical behaviour of the “Operators changing the data type” (see the section “Typical
behaviours of the ML Operators”).

[^1]: Please note that only POSIX Extended Regular Expressions (not ERE classes) are currently supported by VTL
