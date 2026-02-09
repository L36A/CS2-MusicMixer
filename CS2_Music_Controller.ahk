; =================================================================
; Script GameMixer V4 - Numpad Specific
; =================================================================
#NoEnv
#SingleInstance Force
#UseHook On
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}
SendMode Input
SetWorkingDir %A_ScriptDir%



; Justificación: Usamos nombres de teclas específicos del Numpad. 
; AHK diferencia '0' de 'Numpad0' por su virtual key code.

; --- CONTROLES DE MÚSICA (Panel Numérico) ---
^Numpad5::Send {Media_Play_Pause}  ; Ctrl + Numpad 5
^Numpad6::Send {Media_Next}        ; Ctrl + Numpad 6
^Numpad4::Send {Media_Prev}        ; Ctrl + Numpad 4
^Numpad9::Send {Volume_Up}         ; Ctrl + Numpad 9
^Numpad3::Send {Volume_Down}       ; Ctrl + Numpad 3

; --- CONTROL CS2 ---
^Numpad0::
    ; Usamos la ruta absoluta que ya validamos que funciona
    Run, "%A_ScriptDir%\nircmd.exe" muteappvolume cs2.exe 2,, Hide
return

