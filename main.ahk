#Requires AutoHotkey v2.0

; ========================================
; GLOBAL VARIABLES
; ========================================

; Initialize global variables for volume GUI
global volumeGUI := ""
global volumeTextControl := ""

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
; WINDOW MANAGEMENT (broken)
 ; ========================================

; Snap to first third (GUI+Alt+1)
#!1::
{
    WinMove(0, , 0, 0, A_ScreenWidth//3, A_ScreenHeight)
}

; Snap to second third (GUI+Alt+2)
#!2::
{
    WinMove(0, , A_ScreenWidth//3, 0, A_ScreenWidth//3, A_ScreenHeight)
}

; Snap to third third (GUI+Alt+3)
#!3::
{
    WinMove(0, , 2*A_ScreenWidth//3, 0, A_ScreenWidth//3, A_ScreenHeight)
}

; ========================================
; VOLUME CONTROL WITH 10 STEP INCREMENTS
; ========================================

; Volume Up (10-step curve)
Volume_Up::
{
    ; Get current volume
    currentVolume := SoundGetVolume()
    
    ; Calculate new volume using exponential curve
    newVolume := GetNextExponentialVolume(currentVolume, true)
    
    ; Unmute if going from 0 to higher volume
    if (currentVolume = 0 && newVolume > 0)
    {
        SoundSetMute(false)  ; Unmute the system
    }
    
    ; Fade to new volume smoothly
    FadeVolume(currentVolume, newVolume)
    
    ; Show custom volume indicator
    ShowVolumeIndicator(newVolume)
}

; Volume Down (10-step curve)
Volume_Down::
{
    ; Get current volume
    currentVolume := SoundGetVolume()
    
    ; Calculate new volume using exponential curve
    newVolume := GetNextExponentialVolume(currentVolume, false)
    
    ; Fade to new volume smoothly
    FadeVolume(currentVolume, newVolume)
    
    ; Show custom volume indicator
    ShowVolumeIndicator(newVolume)
}

; Function to calculate next volume level using 10-step curve
GetNextExponentialVolume(currentVolume, increase := true)
{
    ; Define 10 power curve steps from 0 to 100
    powerSteps := [0, 1, 3, 5, 8, 13, 21, 34, 55, 100]
    
    ; Find the closest step to current volume
    closestStep := 1
    closestDistance := 100
    
    Loop powerSteps.Length
    {
        distance := Abs(currentVolume - powerSteps[A_Index])
        if (distance < closestDistance)
        {
            closestDistance := distance
            closestStep := A_Index
        }
    }
    
    ; Calculate next step
    if (increase)
    {
        nextStep := Min(closestStep + 1, powerSteps.Length)
    }
    else
    {
        nextStep := Max(closestStep - 1, 1)
    }
    
    ; Return the volume for the next step
    return powerSteps[nextStep]
}

; Function to fade volume smoothly between two levels
FadeVolume(startVolume, endVolume, duration := 50)
{
    ; Calculate the difference and number of steps
    volumeDiff := endVolume - startVolume
    steps := 10  ; Number of steps for smooth fade
    stepDuration := duration / steps
    stepSize := volumeDiff / steps
    
    ; Start the fade timer
    SetTimer(FadeStep, stepDuration)
    
    ; Store fade data in global variables
    global fadeData := {
        currentStep: 0,
        totalSteps: steps,
        startVolume: startVolume,
        stepSize: stepSize,
        targetVolume: endVolume
    }
}

; Function called by timer to perform each fade step
FadeStep()
{
    global fadeData
    
    ; Increment step
    fadeData.currentStep++
    
    ; Calculate current volume
    currentVolume := fadeData.startVolume + (fadeData.stepSize * fadeData.currentStep)
    
    ; Ensure we don't exceed target volume
    if (fadeData.stepSize > 0)
        currentVolume := Min(currentVolume, fadeData.targetVolume)
    else
        currentVolume := Max(currentVolume, fadeData.targetVolume)
    
    ; Set the volume
    SoundSetVolume(currentVolume)
    
    ; Stop timer if we've reached the target
    if (fadeData.currentStep >= fadeData.totalSteps)
    {
        SetTimer(FadeStep, 0)  ; Stop the timer
        SoundSetVolume(fadeData.targetVolume)  ; Ensure exact target volume
    }
}

; Function to show custom volume indicator
ShowVolumeIndicator(volume)
{
    ; Find which step the current volume corresponds to
    powerSteps := [0, 1, 3, 5, 8, 13, 21, 34, 55, 100]
    currentStep := 0  ; Start at 0 for no bananas
    
    Loop powerSteps.Length
    {
        if (volume <= powerSteps[A_Index])
        {
            currentStep := A_Index - 1  ; Subtract 1 to get correct banana count
            break
        }
    }
    
    ; Create simplified volume indicator showing step number
    volumeText := "Volume: Step " . currentStep . " of 10"
    
    ; Create a visual bar representation with 9 fixed banana positions
    barLength := 9  ; 9 banana positions total
    filledBars := currentStep
    emptyBars := barLength - filledBars
    
    ; Create the visual bar using loops (fixed positions)
    filledPart := ""
    emptyPart := ""
    
    Loop filledBars
        filledPart .= "🍌"
    
    Loop emptyBars
        emptyPart .= " "
    
    visualBar := filledPart . emptyPart
    
    ; Calculate position: center horizontally, 95% down vertically
    xPos := A_ScreenWidth // 2  ; Center horizontally
    yPos := Round(A_ScreenHeight * 0.95)  ; 95% down the screen
    
    ; Show custom GUI instead of tooltip
    ShowVolumeGUI(volumeText, visualBar, xPos, yPos)
}

; Function to show custom volume GUI with colored bananas
ShowVolumeGUI(volumeText, visualBar, xPos, yPos)
{
    global volumeGUI, volumeTextControl
    
    ; Create GUI if it doesn't exist
    if (!volumeGUI)
    {
        volumeGUI := Gui()
        volumeGUI.Opt("+AlwaysOnTop -Caption +ToolWindow +E0x20")  ; E0x20 makes it click-through
        volumeGUI.BackColor := "FF00FF"  ; Background color to be made transparent
                
        ; Add only the banana text control with large font
        volumeTextControl := volumeGUI.Add("Text", "x5 y5 w900 h90 cFFFF00 Left", visualBar)  ; Large yellow bananas
        volumeTextControl.SetFont("s48")  ; Set font size to 48 points
        
        ; Show GUI at calculated position (adjusted for text padding)
        volumeGUI.Show("x" . (xPos - 500) . " y" . (yPos - 50) . " w910 h100 NoActivate")
        
        ; Set transparency after showing the GUI
        WinSetTransColor("FF00FF", volumeGUI)
    }
    else
    {
        ; Update existing GUI text if it still exists
        try
        {
            volumeTextControl.Value := visualBar
        }
        catch
        {
            ; GUI was destroyed, recreate it
            volumeGUI := ""
            ShowVolumeGUI(volumeText, visualBar, xPos, yPos)
        }
    }
    
    ; Reset timer to destroy GUI after 1.5 seconds (restart on each key press)
    SetTimer(DestroyVolumeGUI, 0)  ; Stop any existing timer first
    SetTimer(DestroyVolumeGUI, -1500)  ; Start new timer
}

; Function to destroy volume GUI
DestroyVolumeGUI()
{
    global volumeGUI
    try
        volumeGUI.Destroy()
}

 