#Requires AutoHotkey v2.0


; ========================================
; MAIN AUTOHOTKEY SCRIPT
; ========================================

; ========================================
; SCREENSHOT & SYSTEM HOTKEYS
; ========================================

; Screenshot with GUI+Ctrl+Shift+4
#^+4::
{
    Send("#+s")
}

; Run dialog with GUI+Shift+5
#+5::
{
    Send("#+r")
}

; ========================================
; MAC-STYLE HOTKEYS
; ========================================

; Cut (GUI+X → Ctrl+X)
#x::
{
    Send("^x")
}

; Copy (GUI+C → Ctrl+C)
#c::
{
    Send("^c")
}

; Select All (GUI+A → Ctrl+A)
#a::
{
    Send("^a")
}

; Undo (GUI+Z → Ctrl+Z)
#z::
{
    Send("^z")
}

; Redo (GUI+Shift+Z → Ctrl+Y)
#+z::
{
    Send("^y")
}

; New Tab (GUI+T → Ctrl+T)
#t::
{
    Send("^t")
}

; Reopen Closed Tab (GUI+Shift+T → Ctrl+Shift+T)
#+t::
{
    Send("^+t")
}

; Close Tab (GUI+W → Ctrl+W)
#w::
{
    Send("^w")
}

; Quit Application (GUI+Q → Alt+F4)
#q::
{
    Send("!{F4}")
}

; Paste (GUI+V → Ctrl+V)
#v::
{
    Send("^v")
}

; Refresh (GUI+R → F5)
#r::
{
    Send("{F5}")
}

; New Incognito Window (GUI+Shift+N → Ctrl+Shift+N)
#+n::
{
    Send("^+n")
}

; Save (GUI+S → Ctrl+S)
#s::
{
    Send("^s")
}

; Find (GUI+F → Ctrl+F)
#f::
{
    Send("^f")
}

; Move to beginning of line (GUI+Left → Home)
#Left::
{
    Send("{Home}")
}

; Move to end of line (GUI+Right → End)
#Right::
{
    Send("{End}")
}

; Move by word left (Alt+Left → Ctrl+Left)
!Left::
{
    Send("^{Left}")
}

; Move by word right (Alt+Right → Ctrl+Right)
!Right::
{
    Send("^{Right}")
}

; Switch to previous desktop (Ctrl+Left → Win+Ctrl+Left)
^Left::
{
    Send("#^{Left}")
}

; Switch to next desktop (Ctrl+Right → Win+Ctrl+Right)
^Right::
{
    Send("#^{Right}")
}

; Spotlight (GUI+Space → Start Menu)
#Space::
{
    ; Send Windows key to open Start menu (like Spotlight)
    Send("{LWin}")
}

; App Switcher (GUI+Tab → Alt+Tab)
#Tab::
{
    ; Send Alt+Tab and hold Alt for persistent switcher
    Send("{Alt Down}{Tab}")
    ; Set a timer to check for Windows key release
    SetTimer(CheckWindowsKey, 10)
}

; App Switcher backwards (GUI+Shift+Tab → Alt+Shift+Tab)
#+Tab::
{
    ; Send Alt+Shift+Tab for backwards cycling
    Send("{Alt Down}{Shift Down}{Tab}")
    ; Set a timer to check for Windows key release
    SetTimer(CheckWindowsKey, 10)
}

; Function to check if Windows key is still pressed
CheckWindowsKey()
{
    if !GetKeyState("LWin", "P") && !GetKeyState("RWin", "P")
    {
        Send("{Alt Up}{Shift Up}")
        SetTimer(CheckWindowsKey, 0)  ; Stop the timer
    }
}

; ========================================
; WINDOW MANAGEMENT
; ========================================

; Snap to first third (GUI+Alt+1)
#!1::
{
    WinMove(0, 0, A_ScreenWidth//3, A_ScreenHeight, "A")
}

; Snap to second third (GUI+Alt+2)
#!2::
{
    WinMove(A_ScreenWidth//3, 0, A_ScreenWidth//3, A_ScreenHeight, "A")
}

; Snap to third third (GUI+Alt+3)
#!3::
{
    WinMove(2*A_ScreenWidth//3, 0, A_ScreenWidth//3, A_ScreenHeight, "A")
}
