See also the examples in define hierarchical ruleset.

Given the following hierarchical ruleset: ::

    define hierarchical ruleset HR_1 ( valuedomain rule VD_1 ) is
        R010 : A = J + K + L errorlevel 5
        ; R020 : B = M + N + O errorlevel 5
        ; R030 : C = P + Q errorcode XX errorlevel 5
        ; R040 : D = R + S errorlevel 1
        ; R050 : E = T + U + V errorlevel 0
        ; R060 : F = Y + W + Z errorlevel 7
        ; R070 : G = B + C
        ; R080 : H = D + E errorlevel 0
        ; R090 : I = D + G errorcode YY errorlevel 0
        ; R100 : M >= N errorlevel 5
        ; R110 : M <= G errorlevel 5
    end hierarchical ruleset


And given the operand Data Set DS_1 (where *At_1* is viral and the propagation rule says that the alphabetic
order prevails the NULL prevails on the alphabetic characters and the Attribute value for missing Data Points is
assumed as NULL):
