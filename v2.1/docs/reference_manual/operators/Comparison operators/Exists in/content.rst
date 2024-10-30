------
Syntax
------

**exists_in (** op1, op2 { , retain_ } **)**

.. _retain:

retain ::= **true** | **false** | **all**

----------------
Input parameters
----------------
.. list-table::

   * - op1
     - the operand dataset
   * - op2
     - the operand dataset
   * - retain
     - the optional parameter to specify the Data Points to be returned (default: **all**)

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  exists_in(DS_1, DS_2, true)
  exists_in(DS_1, DS_2)
  exists_in(DS_1, DS_2, all)

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
op1, op2 ::

    dataset

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<boolean> bool_var }

-----------------------------
Additional Constraints
-----------------------------
*op1* has at least all the identifier components of *op2* or *op2* has at least all the identifier components of *op1*.

---------
Behaviour
---------

The operator takes under consideration the common Identifiers of *op1* and *op2* and checks if the combinations
of values of these Identifiers which are in *op1* also exist in *op2*.

The result has the same Identifiers as *op1* and a *boolean* Measure bool_var whose value, for each Data Point of
*op1*, is TRUE if the combination of values of the common Identifier Components in *op1* is found in a Data Point of
*op2*, FALSE otherwise.

If *retain* is **all** then both the Data Points having bool_var = TRUE and bool_var = FALSE are returned.

If *retain* is **true** then only the data points with bool_var = TRUE are returned.

If *retain* is **false** then only the Data Points with bool_var = FALSE are returned.

If the *retain* parameter is omitted, the default is **all**.

The operator has the typical behaviour of the “Operators changing the data type” (see the section “Typical
behaviours of the ML Operators”).
