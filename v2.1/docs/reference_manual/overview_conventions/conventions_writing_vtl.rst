
Conventions for writing VTL Transformations
===========================================

When more Transformations are written in a text, the following
conventions apply.

**Transformations:**

*  A Transformation can be written in one or more lines, therefore the
   end of a line does not denote the end of a Transformation.
*  The end of a Transformation is denoted by a semicolon (;).

**Comments:**

Comments can be inserted within VTL Transformations using the following
syntaxes.

-  A multi-line comment is embedded between /\* and \*/ and, obviously,
   can span over several lines:

::

   /\* multi-line
   comment text \*/

-  A single-line comment follows the symbol // up to the next end of
   line:

::

   // text of a comment on a single line

-  A sequence of spaces, tabs, end-of-line characters or comments is
   considered as a single space.

-  The characters **/\*** , **\*/** , **//** and the whitespaces can be
   part of a string literal (within double quotes) but in such a case
   they are part of the string characters and do not have any special
   meaning.

Examples of valid comments:

   *Example 1:* ::

        \* this is a multi-line
        Comment */

   *Example 2:* ::

        // this is single-line comment

   *Example 3:* ::

        DS_r <- /* A is a dataset */ A + /* B is a dataset */ B ;

        (for the VTL this statement is the Transformation DS_r <- A + B ; )

   *Example 4:* ::

        DS_r := DS_1 // my comment
                * DS_2 ;

        (for the VTL this statement is the Transformation DS_r := DS_1 * DS_2 ; )