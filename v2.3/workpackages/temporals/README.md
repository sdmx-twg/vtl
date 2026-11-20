# Concept Note: Temporal operators
This work package seeks to review current temporal operators, eventually defining and/or changing some of them.

This package's output will be a new set of temporal operators for VTL 2.3 version, together with a report containing principles, motivations and differences with the previous 2.2 release. 

## I. Overview and Purpose

The main goal of this workpackage will be to eliminate discrepancies between the different time operators and to align them as much as possibile to ISO 8601 standard (current version documentation is available at [(https://www.isotc154.org/standards/iso-8601-1-2019/)].

## II. Scope and Approach

Here is a non-exhaustive list of the topics that would be resolved (in parenthesis the current open issue number for reference):

-	Clarify comparison on Time Period (#618)
-	Review time_agg operator (#512)
-	Allow components in timeshift, dateadd, time_agg (#649)
-	Problem with description of Casting with optional mask from string to Time_Period/Duration and Time_Period/Duration to string (#671)
-	Inconsistency in Duration specification (#630)

Furthermore, the definition of new data types for VTL to be used by temporal operators could be explored. 

## Timeline (TBD)

## Members
- Javier (workpackage coordinator)
- Angelo
- Hadrien
