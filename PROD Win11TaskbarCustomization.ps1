# Removes Task View from the Taskbar
    New-itemproperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "0" -PropertyType Dword -force
 
# Removes Widgets from the Taskbar
    New-itemproperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value "0" -PropertyType Dword -force
 
# Removes Chat from the Taskbar
    New-itemproperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value "0" -PropertyType Dword -force
 
# Default StartMenu alignment 0=Left
    New-itemproperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value "0" -PropertyType Dword -force
 
# Removes search from the Taskbar
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
