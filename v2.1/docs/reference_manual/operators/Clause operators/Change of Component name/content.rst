------
Syntax
------

    op **[ rename** comp_from **to** comp_to { , comp_from **to** comp_to}* **]**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand
   * - comp_from
     - the original name of the Component to rename
   * - comp_to
     - the new name of the Component after the renaming

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  DS_1 [ rename Me_2 to Me_3 ]

------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset

comp_from ::

    name<component>

comp_to ::

    name<component>

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
The corresponding pairs of Components before and after the renaming (*dsc_from* and *dsc_to*) must be defined
on the same Value Domain and the same Value Domain Subset.

The components used in *dsc_from* must belong to the input Data Set and the component used in the *dsc_to*
cannot have the same names as other Components of the result Data Set.

---------
Behaviour
---------

The operator assigns new names to one or more Components (Identifier, Measure or Attribute Components).
The resulting Data Set, after renaming the specified Components, must have unique names of all its Components
(otherwise a runtime error is raised). Only the Component name is changed and not the Component Values,
therefore the new Component must be defined on the same Value Domain and Value Domain Subset as the
original Component (see also the IM in the User Manual). If the name of a Component defined on a different
Value Domain or Set is assigned, an error is raised. In other words, **rename** is a transformation of the variable
without any change in its values.
