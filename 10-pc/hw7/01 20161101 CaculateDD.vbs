


Sub caculate_DD()

    '--------------------------------------------------基本資料
    T0D = Range("G6")
    SDS = Range("G7")
    SD1 = Range("G8")
    SaD = Range("G9")
    W = Range("G10")

    small_dleta = 0.001
    '--------------------------------------------------隔震墊性質
    'Kd = 558 / 9.81 * Number
    'Ku = Number * Kd
    'Qd = 93.46 / 9.81 * Number
    Ku = Range("G17")
    Kd = Range("G18")
    Qd = Range("G19")


    '--------------------------------------------------開始迭代
    For i = 0.001 To 5 Step 0.001
        D = i
        KeD = (Kd * D + Qd) / D
        TeD = 2 * 3.14 * Sqr(W / KeD / 9.81)


        '--------------------------------------------------阻尼比
        'Damping == 阻尼比
        ' FIXME: 我覺得這裡可能有錯
        ' Qd / (Ku - Kd)
        ATD = 4 * (D - Qd / Ku) * Qd
        Damping = 1 / 2 / 3.14 * (ATD / KeD / (D * D)) + 0.02
        ' 也可以這樣寫
        ' Damping = ATD / (2 * 3.14 * (KeD * D ^ 2)) + 0.02

        If Damping <= 0.02 Then
            BS = 0.8
            B1 = 0.8
        ElseIf 0.02 < Damping And Damping <= 0.05 Then
            BS = (Damping - 0.02) / 0.03 * (1 - 0.8) + 0.8
            B1 = (Damping - 0.02) / 0.03 * (1 - 0.8) + 0.8
        ElseIf 0.05 < Damping And Damping <= 0.1 Then
            BS = (Damping - 0.05) / 0.05 * (1.33 - 1) + 1
            B1 = (Damping - 0.05) / 0.05 * (1.25 - 1) + 1
        ElseIf 0.1 < Damping And Damping <= 0.2 Then
            BS = (Damping - 0.1) / 0.1 * (1.6 - 1.33) + 1.33
            B1 = (Damping - 0.1) / 0.1 * (1.5 - 1.25) + 1.25
        ElseIf 0.2 < Damping And Damping <= 0.3 Then
            BS = (Damping - 0.2) / 0.1 * (1.79 - 1.6) + 1.6
            B1 = (Damping - 0.2) / 0.1 * (1.63 - 1.5) + 1.5
        ElseIf 0.3 < Damping And Damping <= 0.4 Then
            BS = (Damping - 0.3) / 0.1 * (1.87 - 1.79) + 1.79
            B1 = (Damping - 0.3) / 0.1 * (1.7 - 1.63) + 1.63
        ElseIf 0.4 < Damping And Damping <= 0.5 Then
            BS = (Damping - 0.4) / 0.1 * (1.93 - 1.87) + 1.87
            B1 = (Damping - 0.4) / 0.1 * (1.75 - 1.7) + 1.7
        ElseIf 0.5 < Damping Then
            BS = 1.93
            B1 = 1.75
        End If
        '--------------------------------------------------T0修正
        T0 = T0D * BS / B1
        '--------------------------------------------------B
        If TeD < T0 Then
            B = BS
        Else
            B = B1
        End If
        '--------------------------------------------------SaD修正
        If T0 < TeD And TeD <= 2.5 * T0 Then
            SaD = SD1 / B1 / TeD
        ElseIf 2.5 * T0 < TeD Then
            SaD = 0.4 * SDS / BS
        End If
        '--------------------------------------------------計算DD
        TeD_AND_OtherCoefficient = W / KeD
        DD = TeD_AND_OtherCoefficient * SaD / B

        '--------------------------------------------------判斷跌代差值是不是夠小
        If DD - D < small_dleta Then Exit For

    Next i

    '--------------------------------------------------顯示
    a = D * 2 * 3.14 / TeD * 2 * 3.14 / TeD
    MsgBox ("DD        " & Math.Round(DD, 3) & vbCrLf & "D           " & Math.Round(D, 3) & vbCrLf & "加速度  " & Math.Round(a, 3) & vbCrLf & "阻尼比  " & Math.Round(Damping * 100, 2) & "%")

    Range("G23") = KeD
    Range("G24") = TeD
    Range("G25") = B
    Range("G26") = DD

End Sub


