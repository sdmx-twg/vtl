------
Syntax
------

| op **in** collection_
| op **not_in** collection_

.. _collection: 

collection ::= set | valueDomainName

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand to be tested
   * - collection
     - the Set or the Value Domain which contains the values
   * - set
     - the Set which contains the values (it can be a Set name or a Set literal)
   * - valueDomainName
     - the name of the Value Domain which contains the values

------------------------------------
Examples of valid syntaxes
------------------------------------
::

  ds := ds_2 in {1,4,6}
  ds := ds_3 in mySet
  ds := ds_3 in myValueDomain	


------------------------------------
Semantics  for scalar operations
------------------------------------
The **in** operator returns **true** if *op* belongs to the collection, **false** otherwise.
The **not_in** operator returns **false** if *op* belongs to the collection, **true** otherwise.
For example:

| ``1 in { 1, 2, 3 }`` returns ``**true**``
| ``“a” in { “c, “ab”, “bb”, “bc” }`` returns ``**false**``
| ``“b” not_in { “b”, ”hello”, ”c”}`` returns ``**false**``
| ``“b” not_in { “a”, ”hello”, ”c”}`` returns ``**true**``

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset {measure<scalar> _}
    | component<scalar>
    | scalar

collection ::

    set<scalar> | name<value_domain>

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
The operand must be of a basic scalar data type compatible with the basic scalar type of the collection.

--------
Behavior
--------

The **in** operator evaluates to **true** if the operand is an element of the specified collection and **false** otherwise,
the **not_in** the opposite.

The operator has the typical behaviour of the “Operators changing the data type” (see the section “Typical
behaviours of the ML Operators”).

The *collection* can be either a *set* of values defined in line or a name that references an externally defined Value
Domain or Set.
