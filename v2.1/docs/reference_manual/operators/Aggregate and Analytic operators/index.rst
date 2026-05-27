#########################################
VTL-ML - Aggregate and Analytic operators
#########################################

The following table lists the operators that can be invoked in the Aggregate or in the Analytic invocations
described below and their main characteristics.

.. csv-table::
    :file: invocationsTable.csv
    :header-rows: 1

The column *Type of resulting Measure* gives the **declared** super-type of the measure produced by the
invocation. The type **integer** is a subtype of **number** (see the User Manual). For numeric operators, engines
should also document the **nominal** result type when all operand values are **integer**:

* **count**, **rank**: result is **integer**.
* **min**, **max**: result has the **same** numeric type as the operand (**integer** or **number**).
* **sum**: result is declared **number**; when all summed values are **integer**, the nominal result may remain
  **integer** (integer arithmetic, subject to an overflow policy defined by the implementation).
* **avg**, **median**, **var_***, **stddev_***, **ratio_to_report**: result is **number** even when operands are
  **integer**.

If any operand measure is **number** (non-integer), or the operator is not closed on integers, the nominal result
is **number**.

.. toctree::
   :glob:
   :maxdepth: 1

   Aggregate invocation/index
   Analytic invocation/index
   Counting the number of data points/index
   Minimun value/index
   Maximum value/index
   Median value/index
   Sum/index
   Average value/index
   Population standard deviation/index
   Sample standard deviation/index
   Population variance/index
   Sample variance/index
   First value/index
   Last value/index
   Lag/index
   Lead/index
   Rank/index
   Ratio to report/index