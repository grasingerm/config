#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^!t::
  Run, C:\MinGW\msys\1.0\msys.bat
Return

^!p::
  Run, powershell
Return

^!c::
  Run, cmd.exe
Return

^!e::
  Run, gvim
Return

^!g::
  Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
Return
