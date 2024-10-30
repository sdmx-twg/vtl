------
Syntax
------

    op **[ sub** identifier **=** value { , identifier = value }* **]**

----------------
Input parameters
----------------
.. list-table::

   * - op
     - dataset
   * - identifier
     - Identifier Component of the input Data Set *op*
   * - value
     - valid value for *identifier*

------------------------------------
Examples of valid syntaxes
------------------------------------
::

    DS_r := DS_1 [sub Id_2 = "A", Id_5 = 1 ]
    
------------------------------------
Semantics  for scalar operations
------------------------------------
This operator cannot be applied to scalar values.

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset

identifier ::

    name<identifier>

value ::

    scalar

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
The specified Identifier Components *identifier* (s) must belong to the input Data Set *op*.

Each Identifier Component can be specified only once.

The specified *value* must be an allowed value for *identifier*.

---------
Behaviour
---------

The operator returns a Data Set in a subspace of the one of the input Dataset. Its behaviour can be procedurally described as follows:

1. It creates a virtual Data Set VDS as a copy of *op*
2. It maintains the Data Points of VDS for which *identifier = value* (for all the specified *identifier*) and eliminates 
   all the Data Points for which *identifier <> value* (even for only one specified *identifier*)
3. It projects out (“drops”, in VTL terms) all the *identifier* (s)

The result of the last step is the output of the operation.

The resulting Data Set has the Identifier Components that are not specified as *identifier* (s) and has the same Measure and Attribute Components of the input Data Set.

The result Data Set does not violate the functional constraint because after the filter of the step 2, all the
remaining *identifier* (s) do not contain the same Values for all the Data Points. In other words, given that the input
Data Set is a 1st order function and therefore does not contain duplicates, the result Data Set is a 1st order
function as well. To show this, let K₁,...,Kₘ,...,Kₙ be the Identifier components for the generic input Data Set *DS*.
Let us suppose that K₁,...,Kₘ are assigned to fixed values by using the subspace operator. A duplicate could arise
only if in the result there are two Data Points DPᵣ₁ and DPᵣ₂ having the same value for Kₘ₊₁,...,Kₙ , but this is
impossible since such Data Points had same K₁,...,Kₘ in the original Data Set *DS*, which did not contain
duplicates.

If we consider the vector space of Data Points individuated by the n-uples of Identifier components of a Data Set
DS(K₁,...,Kₙ,...) (along, e.g., with the operators of sum and multiplication), we have that the subspace operator
actually performs a subsetting of such space into another space with fewer Identifiers. This can be also seen as
the equivalent of a *dice* operation performed on hyper-cubes in multi-dimensional data warehousing.
