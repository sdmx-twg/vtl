------
Syntax
------

    op **[ keep** comp {, comp }* **]**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - comp
     - a Component to keep

------------------------------------
Examples of valid syntaxes
------------------------------------
::
    DS_1 [ keep Me_2, Me_3 ]

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset

comp ::

    name<component>

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
All the Components *comp* must belong to the input Data Set *op*.

The Components *comp* cannot be Identifiers in *op*.

---------
Behaviour
---------

The operator takes as input a Data Set (*op*) and some Component names of such a Data Set (*comp*). These
Components can be Measures or Attributes of *op* but not Identifiers. The operator maintains the specified
Components, drops all the other dependent Components of the Data Set (Measures and Attributes) and
maintains the independent Components (Identifiers) unchanged. This operation corresponds to a projection in
the usual relational join semantics (specifying which columns will be projected in among Measures and Attributes).
