------
Syntax
------

    **ln (** op **)**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - the operand

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    ln ( DS_1 )
    ln ( 148 )

------------------------------------
Semantics  for scalar operations
------------------------------------
The operator **ln** calculates the natural logarithm of a number.
For example:

| ``ln ( 148 )`` gives ``4.997...``
| ``ln ( e )`` gives ``1.0``
| ``ln ( 1 )`` gives ``0.0``
| ``ln ( 0.5 )`` gives ``-0.693...``

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset { measure<number [value > 0] > _+ }
    | component<number [value > 0] >
    | number [value > 0]

-----------------------------
Result type
-----------------------------
result ::

    dataset { measure<number> _+ }
    | component<number>
    | number

-----------------------------
Additional Constraints
-----------------------------
None.

---------
Behaviour
---------

The operator has the behaviour of the “Operators applicable on one Scalar Value or Data Set or Data Set
Component” (see the section “Typical behaviours of the ML Operators”).
