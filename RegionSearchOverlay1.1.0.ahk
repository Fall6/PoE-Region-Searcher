;PoE Atlas Region Searcher
;version 1.1.0 - feb 2020
;demo video https://www.youtube.com/watch?v=Mza6YOhS_TA

;credits
;AHK-just-me for Class_ImageButton https://github.com/AHK-just-me/Class_ImageButton/

#NoEnv
SetWorkingDir %A_ScriptDir%
#WinActivateForce
#SingleInstance force

;buttons
SetBatchLines, -1
#Include Class_ImageButton.ahk
 
tog1:=0
Hide1:=0
ThemeVariable:=0

; ----------------------------------------------------------------------------------------------------------------------
;*** Change to customize
WinName:="Fall`'s Atlas Region Selector"
Menu, Tray, Icon, BraveNewWorlds.ico

InfluenceOption=|Al-Hezmin|Baran|Drox|Veritania ;|Crusader|Hunter|Redeemer|Warlord
StoneOption=0 Stones|1 Stone|2 Stones|3 Stones|4 Stones
SleepTime=200

KeyWidth=100
KeyHeightRegionName=71
KeyHeightDDL=20
 
ColumnsRegionName=8
ColumnsInfluence=8
ColumnsStones=8

; Edit here to change the order, regions appear in the menu
Array1:=[]
Array1[1,1]:="Glennach Cairns"
Array1[2,1]:="Tirn`'s End"
Array1[3,1]:="Lex Proxima"
Array1[4,1]:="Valdo`'s Rest"
Array1[5,1]:="New Vastir"
Array1[6,1]:="Haewark Hamlet"
Array1[7,1]:="Lex Ejoris"
Array1[8,1]:="Lira Arthain"
; ----------------------------------------------------------------------------------------------------------------------

Array1[1,2]:=Array1[1,1] . ".png"
Array1[2,2]:=Array1[2,1] . ".png"
Array1[3,2]:=Array1[3,1] . ".png"
Array1[4,2]:=Array1[4,1] . ".png"
Array1[5,2]:=Array1[5,1] . ".png"
Array1[6,2]:=Array1[6,1] . ".png"
Array1[7,2]:=Array1[7,1] . ".png"
Array1[8,2]:=Array1[8,1] . ".png"

Array1[1,3]:=Array1[1,1] . "2.png"
Array1[2,3]:=Array1[2,1] . "2.png"
Array1[3,3]:=Array1[3,1] . "2.png"
Array1[4,3]:=Array1[4,1] . "2.png"
Array1[5,3]:=Array1[5,1] . "2.png"
Array1[6,3]:=Array1[6,1] . "2.png"
Array1[7,3]:=Array1[7,1] . "2.png"
Array1[8,3]:=Array1[8,1] . "2.png"

;*** Create INI if not exist
ININame=%A_scriptdir%\Config1.1.0.ini
ifnotexist,%ININame%
    {
    IniWrite,F2,%ININame%,Options,ToggleKey
	IniWrite,0,%ININame%,Options,DarkTheme
	IniWrite,0,%ININame%,Position,X
	IniWrite,0,%ININame%,Position,Y
    Loop %ColumnsRegionName%
        {
        Col:=A_Index
        IniWrite,0,%ININame%,Key%A_Index%,Influenced
        IniWrite,0,%ININame%,Key%A_Index%,Stones
        }
    }
   
;*** Load
Loop %ColumnsInfluence% {
    IniRead, LoadInf%A_Index%, %ININame%, Key%A_Index%, Influenced, 0
    }
 
Loop %ColumnsStones% {
    IniRead, LoadS%A_Index%, %ININame%, Key%A_Index%, Stones, 0
    }
	
;*** Custom hotkey
Iniread, HotkeyVariable, %ININame%, Options, ToggleKey
Hotkey, %HotkeyVariable%,CustomHotkeyName,On

;*** Theme
Iniread, ThemeVariable, %ININame%, Options, DarkTheme
if ThemeVariable>1
	ThemeVariable=0
	
;*** Position
IniRead, XWind, %ININame%, Position, X
IniRead, YWind, %ININame%, Position, Y

;*** GUI layout
Gui, +AlwaysOnTop -Caption +Border
Gui, Font, s11
If ThemeVariable=1
	Gui, Color, Black
	
Loop %ColumnsRegionName% {
    Col:=A_Index
	HotButtonVariable:=% Array1[A_Index,3]
	Gui, DummyGUI:Add, Pic, hwndHPIC, % Array1[A_Index,2]
	SendMessage, 0x0173, 0, 0, , ahk_id %HPIC% ; STM_GETIMAGE
	HPIC1 := ErrorLevel
    If Col=1
		Gui, Add, Button, vBT%A_Index% gKeyPressed%A_Index% w100 h71 y+10 hwndHBT%A_Index%
	Else
		Gui, Add, Button, vBT%A_Index% gKeyPressed%A_Index% w100 h71 x+5 yp hwndHBT%A_Index%
	Opt1 := [0, HPIC1]
	Opt2 := {2:HotButtonVariable}
	If !ImageButton.Create(HBT%A_Index%, Opt1, Opt2)
	   MsgBox, 0, ImageButton Error Btn%A_Index%, % ImageButton.LastError
}

Loop %ColumnsInfluence% {
    Col:=A_Index
    If Col=1
        Gui, Add, DropDownList, r5 w200 gInfluenceAction%A_Index% vSelectedInfluence%A_Index% w%KeyWidth% h%KeyHeightDDL% xm y+5,%InfluenceOption%
    Else
        Gui, Add, DropDownList, r5 w200 gInfluenceAction%A_Index% vSelectedInfluence%A_Index% w%KeyWidth% h%KeyHeightDDL% x+5 yp,%InfluenceOption%
}
 
Loop %ColumnsStones% {
    Col:=A_Index
    If Col=1
        Gui, Add, DropDownList, r5 gStoneAction%A_Index% vSelectedItem%A_Index% w%KeyWidth% h%KeyHeightDDL% xm y+5,%StoneOption%
    Else
        Gui, Add, DropDownList, r5 gStoneAction%A_Index% vSelectedItem%A_Index% w%KeyWidth% h%KeyHeightDDL% x+5 yp,%StoneOption%
}
 
;*** Move with -Caption on
;https://autohotkey.com/board/topic/67766-moving-gui-with-caption/
OnMessage(0x0201, "WM_LBUTTONDOWN")
 
WM_LBUTTONDOWN()
{
   If (A_Gui)
      PostMessage, 0xA1, 2
; 0xA1: WM_NCLBUTTONDOWN, refer to http://msdn.microsoft.com/en-us/library/ms645620%28v=vs.85%29.aspx
; 2: HTCAPTION (in a title bar), refer to http://msdn.microsoft.com/en-us/library/ms645618%28v=vs.85%29.aspx
}

;*** Load
Loop %ColumnsInfluence% {
if (LoadInf%A_Index%)
   GuiControl, Choose, SelectedInfluence%A_Index%, % LoadInf%A_Index%
   Gui, Show,, %WinName%
}
 
Loop %ColumnsStones% {
if (LoadS%A_Index%)
   GuiControl, ChooseString, SelectedItem%A_Index%, % LoadS%A_Index%
   Gui, Show,, %WinName%
}

;*** Move window
SetTitleMatchMode, 1
WinMove, %WinName%,, %XWind%, %YWind%

Return ;prevents script auto KeyPressed1 searching when you open it
 
;*** Search
KeyPressed1:
    if WinExist("Path of Exile") {
        WinActivate
        }
    if WinActive("Path of Exile") {
        Sleep, SleepTime
        Send ^f
        Send ^a
        SendInput % Array1[1,1]
        }
Return
 
KeyPressed2:
    if WinExist("Path of Exile") {
        WinActivate
        }
    if WinActive("Path of Exile") {
        Sleep, SleepTime
        Send ^f
        Send ^a
        SendInput % Array1[2,1]
        }
Return
 
KeyPressed3:
    if WinExist("Path of Exile") {
        WinActivate
        }
    if WinActive("Path of Exile") {
        Sleep, SleepTime
        Send ^f
        Send ^a
        SendInput % Array1[3,1]
        }
Return
 
KeyPressed4:
    if WinExist("Path of Exile") {
        WinActivate
        }
    if WinActive("Path of Exile") {
        Sleep, SleepTime
        Send ^f
        Send ^a
        SendInput % Array1[4,1]
        }
Return
 
KeyPressed5:
    if WinExist("Path of Exile") {
        WinActivate
        }
    if WinActive("Path of Exile") {
        Sleep, SleepTime
        Send ^f
        Send ^a
        SendInput % Array1[5,1]
        }
Return
 
KeyPressed6:
    if WinExist("Path of Exile") {
        WinActivate
        }
    if WinActive("Path of Exile") {
        Sleep, SleepTime
        Send ^f
        Send ^a
        SendInput % Array1[6,1]
        }
Return
 
KeyPressed7:
    if WinExist("Path of Exile") {
        WinActivate
        }
    if WinActive("Path of Exile") {
        Sleep, SleepTime
        Send ^f
        Send ^a
        SendInput % Array1[7,1]
        }
Return
 
KeyPressed8:
    if WinExist("Path of Exile") {
        WinActivate
        }
    if WinActive("Path of Exile") {
        Sleep, SleepTime
        Send ^f
        Send ^a
        SendInput % Array1[8,1]
        }
Return
 
;*** Toggle Influenced
InfluenceAction1:
 Gui, Submit, NoHide
 IniWrite, %SelectedInfluence1%, %ININame%, Key1, Influenced
Return
 
InfluenceAction2:
 Gui, Submit, NoHide
 IniWrite, %SelectedInfluence2%, %ININame%, Key2, Influenced
Return
 
InfluenceAction3:
 Gui, Submit, NoHide
 IniWrite, %SelectedInfluence3%, %ININame%, Key3, Influenced
Return
 
InfluenceAction4:
 Gui, Submit, NoHide
 IniWrite, %SelectedInfluence4%, %ININame%, Key4, Influenced
Return
 
InfluenceAction5:
 Gui, Submit, NoHide
 IniWrite, %SelectedInfluence5%, %ININame%, Key5, Influenced
Return
 
InfluenceAction6:
 Gui, Submit, NoHide
 IniWrite, %SelectedInfluence6%, %ININame%, Key6, Influenced
Return
 
InfluenceAction7:
 Gui, Submit, NoHide
 IniWrite, %SelectedInfluence7%, %ININame%, Key7, Influenced
Return
 
InfluenceAction8:
 Gui, Submit, NoHide
 IniWrite, %SelectedInfluence8%, %ININame%, Key8, Influenced
Return
 
;***Stone
StoneAction1:
 Gui, Submit, NoHide
 IniWrite, %SelectedItem1%, %ININame%, Key1, Stones
Return
 
StoneAction2:
 Gui, Submit, NoHide
 IniWrite, %SelectedItem2%, %ININame%, Key2, Stones
Return
 
StoneAction3:
 Gui, Submit, NoHide
 IniWrite, %SelectedItem3%, %ININame%, Key3, Stones
Return
 
StoneAction4:
 Gui, Submit, NoHide
 IniWrite, %SelectedItem4%, %ININame%, Key4, Stones
Return
 
StoneAction5:
 Gui, Submit, NoHide
 IniWrite, %SelectedItem5%, %ININame%, Key5, Stones
Return
 
StoneAction6:
 Gui, Submit, NoHide
 IniWrite, %SelectedItem6%, %ININame%, Key6, Stones
Return
 
StoneAction7:
 Gui, Submit, NoHide
 IniWrite, %SelectedItem7%, %ININame%, Key7, Stones
Return
 
StoneAction8:
 Gui, Submit, NoHide
 IniWrite, %SelectedItem8%, %ININame%, Key8, Stones
Return
 
;*** Toggle GUI on button press
CustomHotkeyName:
    Hide1:=!Hide1
    If (Hide1)=1 {
		WinGetPos , XWind, YWind, WWind, HWind, %WinName%
		IniWrite,%XWind%,%ININame%,Position,X
		IniWrite,%YWind%,%ININame%,Position,Y
		Gui, Hide
    } Else {
        Gui, Show,, %WinName%
        }
Return