Given the operand dataset DS_1 and the datapoint ruleset dpr1: ::

    define datapoint ruleset dpr1 ( variable Id_3, Me_1 ) is
        when Id_3 = “CREDIT” then Me_1 >= 0 errorcode “Bad credit”
        ; when Id_3 = “DEBIT” then Me_1 >= 0 errorcode “Bad debit”
    end datapoint ruleset

