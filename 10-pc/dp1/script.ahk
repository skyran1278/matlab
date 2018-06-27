^d::
; SetControlDelay -1
; ControlClick,show table,ETABS 2016 Ultimate 16.2.0 - Project1_HDRB,,,,NA
; ControlClick, "x121 y95", "ETABS 2016 Ultimate 16.2.0 - Project1_HDRB"
Click, 131, 117
Click, 143, 137
Sleep, 100
Click, 744, 351
; Sleep, 2000
; Click, 1378, 1049
; Sleep, 100
; Click, 17, 594
Return
; ETABS 2016 Ultimate 16.2.0 - Project1_HDRB
; ahk_class WindowsForms10.Window.8.app.0.13965fa_r6_ad1
; ahk_exe ETABS.exe
; ClassNN:	WindowsForms10.Window.8.app.0.13965fa_r6_ad179
; Text:
; 	x: 352	y: 139	w: 626	h: 548
; Client:	x: 344	y: 108	w: 626	h: 548
; ClassNN:	%WindowsForms10.Window.8.app.0.13965fa_r6_ad179%
^e::
; ControlClick, "x132 y90", "ETABS 2016 Ultimate 16.2.0 - Project1_HDRB"
WinClose, 活頁簿1 - Excel
Click, 不要儲存, ahk_class NUIDialog
WinClose, Time History Plot
Return

^j::
; ControlClick, ClassNN:	NetUIHWND1, ahk_class NUIDialog
; WinClose, 活頁簿1 - Excel
; WinClose, Time History Plot
Return

; CheckTime:
; if (A_Hour . A_Min . A_Sec=120400)
;  Click, 100, 200, right
; return

Esc::ExitApp
