------
Syntax
------

    **check (** op { **errorcode** errorcode } { **errorlevel** errorlevel } { **imbalance** imbalance } { output_ } )

        .. _output:
        
        output ::= **invalid | all**

----------------
Input parameters
----------------
.. list-table::

   * - op 
     - a *boolean* Data Set (a *boolean* condition expressed on one or more Data Sets)
   * - errorcode
     - | the error code to be produced when the condition evaluates to **false**. It must be a
       | valid value of the *errorcode_vd* Value Domain (or *string* if the *errorcode_vd*
       | Value Domain is not found). It can be a Data Set or a *scalar*. If not specified
       | then *errorcode* is **null**.
   * - errorlevel
     - | the error level to be produced when the condition evaluates to **false**. It must be a 
       | valid value of the *errorlevel_vd* Value Domain (or *integer* if the errorcode_vd Value Domain is not found). 
       | It can be a Data Set or a *scalar*. If not specified then *errorlevel* is **null**.
   * - imbalance
     - | the imbalance to be computed. *imbalance* is a *numeric* mono-measure Data Set
       | with the same Identifiers of *op*. If not specified then *imbalance* is **null**.
   * - output
     - | specifies which Data Points are returned in the resulting Data Set:
       |    · **invalid** returns the Data Points of op for which the condition evaluates to **false**
       |    · **all** returns all Data Points of *op*
       | If not specified then *output* is **all**.


-----------------------------
Examples of valid syntaxes
-----------------------------
::

  check ( DS1 > DS2 errorcode myerrorcode errorlevel myerrorlevel imbalance DS1 - DS2  invalid )

-----------------------------
Input parameters type
-----------------------------
op ::

    dataset

errorcode ::

    errorcode_vd

errorlevel ::

    errorlevel_vd

imbalance ::

    number

-----------------------------
Result type
-----------------------------
result ::

    dataset

-----------------------------
Additional Constraints
-----------------------------
*op* has exactly a *boolean* Measure Component.

---------
Behaviour
---------

It returns a Data Set having the following components:

* the Identifier Components of *op*
* a *boolean* Measure named *bool_var* that contains the result of the evaluation of the boolean dataset *op*
* the Measure *imbalance* that contains the specified imbalance
* the Measure *errorcode* that contains the specified *errorcode*
* the Measure *errorlevel* that contains the specified *errorlevel*

If *output* is **all** then all data points are returned. If *output* is **invalid** then only the Data Points where *bool_var* is
**false** are returned.
