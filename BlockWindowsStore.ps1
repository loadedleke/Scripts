# Create WindowsStore reg key in HKLM\SOFTWARE\Policies\Microsoft then create the DWORD RemoveWindowsStore and set it to 1
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /t REG_DWORD /d 1 /f

# Create OneDrive reg key in HKLM\SOFTWARE\Policies\Microsoft\Windows then create the DWORD DisableFileSyncNGSC and set it to 1
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f