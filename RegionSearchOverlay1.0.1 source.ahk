;Fall's PoE Region Searcher
;version 1.0.1 - 29 Dec 2019
;added custom hotkey, now you can change it in Config.ini
;demo video https://www.youtube.com/watch?v=_9x9TGSVCAA

 
#NoEnv
SetWorkingDir %A_ScriptDir%
#WinActivateForce
#SingleInstance force
 
tog1:=0
Hide1:=0
WinName:="Fall`'s Atlas Region Selector. v1.0.1."
 
SleepTime=200
 
Array1:=[]
Array1[1,1]:="Glennach Cairns"
Array1[2,1]:="Haewark Hamlet"
Array1[3,1]:="Lex Ejoris"
Array1[4,1]:="Lex Proxima"
Array1[5,1]:="Lira Arthain"
Array1[6,1]:="New Vastir"
Array1[7,1]:="Tirn`'s End"
Array1[8,1]:="Valdo`'s Rest"
 
;*** GUI
Gui, 4:+AlwaysOnTop -Caption +Border
 
KeyWidth=90
KeyHeightRegionName=40
KeyHeightInfluence=20
 
ColumnsRegionName=8
ColumnsInfluence=8
ColumnsStones=8
 
;*** Create INI if not exist
ININame=%A_scriptdir%\Config.ini
ifnotexist,%ININame%
    {
    IniWrite,F2,%ININame%,ToggleKey,KEY1
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
Iniread, HotkeyVariable, %ININame%, ToggleKey, KEY1
Hotkey, %HotkeyVariable%,CustomHotkeyName,On

;*** GUI layout
Gui, 4:Add, Text,,%WinName%
Gui, 4:Font, s11
 
Loop %ColumnsRegionName% {
    Col:=A_Index
    If Col=1
        Gui, 4:Add, Button,vBtnId%A_Index% gKeyPressed%A_Index% w%KeyWidth% h%KeyHeightRegionName% y+10, % Array1[A_Index,1]
    Else
        Gui, 4:Add, Button,vBtnId%A_Index% gKeyPressed%A_Index% w%KeyWidth% h%KeyHeightRegionName% x+0 yp, % Array1[A_Index,1]
 
}
 
Loop %ColumnsInfluence% {
    Col:=A_Index
    If Col=1
        Gui, 4:Add, DropDownList, r2 gInfluenceAction%A_Index% vSelectedInfluence%A_Index% w%KeyWidth% h%KeyHeightInfluence% xm y+5,|Influenced
    Else
        Gui, 4:Add, DropDownList, r2 gInfluenceAction%A_Index% vSelectedInfluence%A_Index% w%KeyWidth% h%KeyHeightInfluence% x+0 yp,|Influenced
}
 
Loop %ColumnsStones% {
    Col:=A_Index
    If Col=1
        Gui, 4:Add, DropDownList, r5 gStoneAction%A_Index% vSelectedItem%A_Index% w%KeyWidth% h%KeyHeightInfluence% xm y+5,0 Stones|1 Stone|2 Stones|3 Stones|4 Stones
    Else
        Gui, 4:Add, DropDownList, r5 gStoneAction%A_Index% vSelectedItem%A_Index% w%KeyWidth% h%KeyHeightInfluence% x+0 yp,0 Stones|1 Stone|2 Stones|3 Stones|4 Stones
}
 
Gui, 4:Show, AutoSize Center, %WinName%
 
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
   GuiControl, 4:Choose, SelectedInfluence%A_Index%, % LoadInf%A_Index%
   Gui, 4:Show
}
 
Loop %ColumnsStones% {
if (LoadS%A_Index%)
   GuiControl, 4:ChooseString, SelectedItem%A_Index%, % LoadS%A_Index%
   Gui, 4:Show
}
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
        Gui, 4:Hide
    } Else {
        Gui, 4:Show
        }
Return