------
Syntax
------

    **between (** op, from, to **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the Data Set to be checked
   * - from
     - the left delimiter
   * - to
     - the right delimiter

------------------------------------
Examples of valid syntaxes
------------------------------------
::
  
  ds2 := between(ds1, 5, 10)
  ds2 := ds1 [ calc m1 := between(me2, 5, 10) ]

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator returns TRUE if *op* is greater than or equal to *from* and lower than or equal to *to*. In other terms,
it is a shortcut for the following:

| ``op >= from and op <= to``

| The types of *op*, *from* and *to* must be compatible scalar types.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset {measure<scalar> _}
    | component<scalar>
    | scalar

from, to ::

    component<scalar>
    | scalar

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
The type of the operand (i.e., the measure of the dataset, the type of the component, the scalar type) must be the
same as that of *from* and *to*.

---------
Behaviour
---------

The operator has the typical behaviour of the “Operators changing the data type” (see the section “Typical
behaviours of the ML Operators”)
