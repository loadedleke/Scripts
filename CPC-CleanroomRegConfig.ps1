
# Create WindowsStore reg key in HKLM\SOFTWARE\Policies\Microsoft then create the DWORD RemoveWindowsStore and set it to 1
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /t REG_DWORD /d 1 /f

# Create OneDrive reg key in HKLM\SOFTWARE\Policies\Microsoft\Windows then create the DWORD DisableFileSyncNGSC and set it to 1
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f

# Start Touch Keyboard and Handwriting Panel Service for Windows Terminal Input (Restart may be required)
    Set-itemproperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\TabletInputService" -Name "Start" -Value "2" -force

<#Script lines below removes the listed apps from computer
  OneDrive
  Cortana
  Feedback Hub
  Microsoft News
  Microsoft ToDo
  Voice Recorder
  Power Automate
  Sticky Notes
  Remote Desktop
  Teams
  Weather
  XBox
#>

#Create an array for apps to be removed
   $appnames = @('Microsoft.todo','Microsoft.BingNews','Microsoft.BingWeather','Microsoft.WindowsSoundRecorder','Microsoft.PowerAutomateDesktop','MicrosoftTeams','Microsoft.MicrosoftStickyNotes','Microsoft.549981C3F5F10','Microsoft.GamingApp','Microsoft.OneDriveSync','Microsoft.WindowsFeedbackHub','Microsoft.XboxGameCallableUI','Microsoft.RemoteDesktop','Microsoft.OneDrive')

    foreach ($appname in $appnames)
     {
        Get-AppxPackage | where-object {$_.name -match $appname} | Remove-AppPackage
     }
