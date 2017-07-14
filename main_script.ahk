; #Include, pixel_getcolor.ahk
#Include, region_getcolor.ahk

^!+q::Reload
Return

^!+s::
    SetTitleMatchMode, 2
    If WinExist("main_script.ahk")
        WinActivate ; use the window found above
    else
        MsgBox Window not found{!}
Return

;Text change
:*:=d::
:*:=в::
    Send, =D
Return

;Current date
:R*?:ddd::
:R*?:ввв::
FormatTime, CurrentDateTime,, dd/MM/yy HH:mm
SendInput %CurrentDateTime%
return

;Goto #Hotstrings
:?*:пыл::
:?*:gsk::
    SetTitleMatchMode, 2
    If WinExist("Skype -")
    {
        WinActivate ; use the window found above
    }
    else
    {
        Run, https://web.skype.com
        WinWaitActive, "Skype -", , 2
        Send, W
        Sleep, 1000
        Send, {F11}
    }
Return

:?*:gcr::
:?*:пск::
    SetTitleMatchMode, RegEx
    If WinExist("(?<!Skype) - Google Chrome")
        WinActivate ; use the window found above
    else
        MsgBox Window not found{!}

Return

:?*:gtt::
:?*:пее::
    SetTitleMatchMode, 2
    If WinExist("Total Commander (x64)")
        WinActivate ; use the window found above
    else
        MsgBox Window not found{!}
Return

:?*:gtl::
:?*:пед::
    SetTitleMatchMode, 2
    If WinExist("Outlook")
        WinActivate ; use the window found above
    else
        MsgBox Window not found{!}
Return

^!z::  ; Control+Alt+Z hotkey.
    SetTitleMatchMode, 2
    id := WinExist("main_script")

    ; value := PixelColor(10,10,id)
    value := regionGetColor(10,10,50,50,id)
    MsgBox % value

Return

^!+w::
    WinGet windows, List
        Loop %windows%
        {
            id := windows%A_Index%
            WinGetTitle wt, ahk_id %id%
            r .= wt . "`n"
        }
        MsgBox %r%
Return

^!b::
    oldClip := clipboard
    ClipSaved := ClipboardAll
    Send, ^c
    Sleep, 200
    ClipWait
    if DllCall("IsClipboardFormatAvailable", "uint", 1)
    {
        file := FileOpen("c:\Users\SBT-chebotarev-sd\Documents\FileSender\Send\fileToSend.txt", "w")
        file.Write(Clipboard)
        file.Close()
    }
    else if DllCall("IsClipboardFormatAvailable", "uint", 15)
    {
        SplitPath, Clipboard, name
        ;oFile2 := FileOpen("c:\Users\SBT-chebotarev-sd\Documents\FileSender\Send\"name, "w") ; Instead of writing straight to the file using FileAppend, create a new file calling FileOpen again.
        ;oFile2 := FileOpen("c:\Users\SBT-chebotarev-sd\Documents\FileSender\Temp\"name, "w") ; Instead of writing straight to the file using FileAppend, create a new file calling FileOpen again.        
        ;oFile2.RawWrite(ClipboardAll, ClipboardAll.Lenght)
        FileCopy, %ClipBoardAll%, c:\Users\SBT-chebotarev-sd\Documents\FileSender\Temp\%name%
    }
    else
    {
        MsgBox Clipboard does not contain files or text.
    }
    
    Clipboard := ClipSaved
Return

^!x::
    SetTitleMatchMode, 2
    If WinExist("Send\fileToSend.txt")
    {
        WinActivate
        Send ^a
        ControlSend, , ^a, Send\fileToSend.txt
    }
Return