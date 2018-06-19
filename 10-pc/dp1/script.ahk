^j::
SetTimer, CheckTime, 1 ;check time every minute
Return

CheckTime:
if (A_Hour . A_Min . A_Sec=120400)
 Click, 100, 200, right
return

Esc::ExitApp
