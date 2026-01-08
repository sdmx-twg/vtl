Given the following hierarchical ruleset: ::

    define hierarchical ruleset HR_1 ( valuedomain rule VD_1 ) is
        A = J + K + L
        ; B = M + N + O
        ; C = P + Q
        ; D = R + S
        ; E = T + U + V
        ; F = Y + W + Z
        ; G = B + C
        ; H = D + E
        ; I = D + G
    end hierarchical ruleset;

And given the operand dataset DS_1 (where *At_1* is viral and the propagation rule says that the alphabetic
order prevails the **null** prevails on the alphabetic characters and the Attribute value for missing Data Points
is assumed as **null**):
