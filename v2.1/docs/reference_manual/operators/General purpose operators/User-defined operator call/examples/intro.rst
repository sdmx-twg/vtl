^^^^^^^^^^^^^^^^
Example 1
^^^^^^^^^^^^^^^^

Definition of the *max1* operator (see also “define operator” in the VTL-DL): ::

        define operator max1 (x integer, y integer)
        returns boolean
        is if x > y then x else y
        end define operator

User-defined operator call of the max1 operator: ::

        max1 ( 2, 3 )

