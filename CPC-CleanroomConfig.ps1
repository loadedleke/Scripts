
# Create WindowsStore reg key in HKLM\SOFTWARE\Policies\Microsoft then create the DWORD RemoveWindowsStore and set it to 1
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /t REG_DWORD /d 1 /f

# Create OneDrive reg key in HKLM\SOFTWARE\Policies\Microsoft\Windows then create the DWORD DisableFileSyncNGSC and set it to 1
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f

# Start Touch Keyboard and Handwriting Panel Service for Windows Terminal Input (Restart may be required)
    Set-itemproperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\TabletInputService" -Name "Start" -Value "2" -force


