------
Syntax
------

    **random (** seed **,** index **)**

----------------
Input parameters
----------------
.. list-table::

   * - seed
     - the seed
   * - index
     - the index

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    random(15,12)
    ds [calc r := random(col_1, 12)]
    random(ds, 12);


------------------------------------
Semantics  for scalar operations
------------------------------------
The operator generates a sequence number >= 0 and <1, based on seed parameter and returns
 the number value corresponding to index.

-----------------------------
Input parameters type
-----------------------------
seed ::

    dataset { measure<number> _+ }
    | component<number>
    | number

index ::

    integer

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<number> _+ }
    | component<number[0-1] >
    | number[0-1]


-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The operator returns a random decimal number >= 0 and <1.
