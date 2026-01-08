Introduction
============

The Validation and Transformation Language is aimed at defining
Transformations of the artefacts of the VTL Information Model, as more
extensively explained in the User Manual.

A Transformation consists of a statement which assigns the outcome of
the evaluation of an expression to an Artefact of the IM. The operands
of the expression are IM Artefacts as well. A Transformation is made of
the following components:

*  A left-hand side, which specifies the Artefact which the outcome of
   the expression is assigned to (this is the result of the
   Transformation);
*  An assignment operator, which specifies also the persistency of the
   left hand side. The assignment operators are two, the first one for
   the persistent assignment (**<-**) and the other one for the
   non-persistent assignment (**:=**).
*  A right-hand side, which is the expression to be evaluated, whose
   inputs are the operands of the Transformation. An expression consists
   in the invocation of VTL Operators in a certain order. When an
   Operator is invoked, for each input Parameter, an actual argument
   (operand) is passed to the Operator, which returns an actual argument
   for the output Parameter. In the right hand side (the expression),
   the Operators can be nested (the output of an Operator invocation can
   be input of the invocation of another Operator). All the intermediate
   results in an expression are non-persistent.

Examples of Transformations are:
::

   DS_np := (DS_1 - DS_2 ) * 2;
   DS_p <- if DS_np >= 0 then DS_np else DS_1;

(DS_1 and DS_2 are input Data Sets, DS_np is a non persistent result,
DS_p is a persistent result, the invoked operators (apart the mentioned
assignments) are the subtraction (**-**), the multiplication (**\***), the
choice (**if**\ ...\ **then**\ ...\ **else**), the greater or equal
comparison (**>=**) and the parentheses that control the order of the
operators’ invocations.

Like in the example above, Transformations can interact with one another
through their operands and results; in fact the result of a
Transformation can be operand of one or more other Transformations. The
interacting Transformations form a graph that is oriented and must be
acyclic to ensure the overall consistency, moreover a given Artefact
cannot be result of more than one Transformation (the consistency rules
are better explained in the User Manual, see VTL Information Model /
Generic Model for Transformations / Transformations consistency). In
this regard, VTL Transformations have a strict analogy with the formulas
defined in the cells of the spreadsheets.

A set of more interacting Transformations is usually needed to perform a
meaningful and self-consistent task like for example the validation of
one or more Data Sets. The smaller set of Transformations to be executed
in the same run is called Transformation Scheme and can be considered as
a VTL program.

Transformations do not necessarily need to be written in sequence like a
classical software program. In fact, they are associated to the Artefacts
they calculate, like it happens in the spreadsheets (each spreadsheet’s
formula is associated to the cell it calculates).

Nothing prevents, however, from writing the Transformations in sequence,
taking into account that the Transformations are not necessarily
performed in the same order as they are written, because the order of
execution depends on their input-output relationships (a Transformation
which calculates a result that is operand of other Transformations must
be executed first). For example, if the two Transformations of the
example above were written in the reverse order:
::

   (i) DS_p <- if DS_np >= 0 then DS_np else DS_1;
   (ii) DS_np := (DS_1 - DS_2 ) * 2;


All the same the Transformation (ii) would be executed first, because it
calculates the Data Set DS_np which is an operand of the Transformation
(i).

When Transformations are written in sequence, a semicolon (;) is used to
denote the end of a Transformation and the beginning of the following
one.
