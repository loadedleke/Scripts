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
   $appnames = @('Microsoft.todo','Microsoft.todos','Microsoft.BingNews','Microsoft.BingWeather','Microsoft.WindowsSoundRecorder','Microsoft.PowerAutomateDesktop','MicrosoftTeams','Microsoft.MicrosoftStickyNotes','Microsoft.549981C3F5F10','Microsoft.GamingApp','Microsoft.OneDriveSync','Microsoft.WindowsFeedbackHub','Microsoft.XboxGameCallableUI','Microsoft.RemoteDesktop','Microsoft.OneDrive')

    foreach ($appname in $appnames)
     {
        Get-AppxPackage | where-object {$_.name -match $appname} | Remove-AppPackage -ErrorAction SilentlyContinue
     }
