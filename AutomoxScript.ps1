#Set the name of the application you want to affect
$process = "Chrome"

#Check if $process is running. If it’s running, ask the user to close it, if it isn’t running then >exit quietly.
$process_running = Get-Process $process -ErrorAction SilentlyContinue
do{
if ( !$process_running ) {
    #If the process is not running then there’s nothing to do. Exit quietly.
     Write-Host "$process isnt't running on this device: Nothing to close." }
     
	else {
    #Play a sound with the pop-up message
    [system.media.systemsounds]::Hand.play()
    Write-Output "$Process is running."


Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonType = [System.Windows.MessageBoxButton]::YesNo
$MessageboxTitle = “ALCORITY: UPDATE REQUIRED FOR $Process!”
$Messageboxbody = “Alcority requires $Process to be updated. Please save your work and click YES to apply the update. Once closed, you can start Chrome again”
$MessageIcon = [System.Windows.MessageBoxImage]::Warning
$UserResponse = [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)

#If user clicked YES, try to close the app gracefully
     if ( $UserResponse -eq "yes" ) {
	    Stop-process -Name $process -ErrorAction SilentlyContinue 
}
     else { ($UserResponse -eq "no" )
        Add-Type -AssemblyName PresentationCore,PresentationFramework
        $MessageboxTitle = “ALCORITY: UPDATE REQUIRED FOR $Process”
        $Messageboxbody = “Update for $Process will retry in 5 mins!”
        $MessageIcon = [System.Windows.MessageBoxImage]::Warning
        $UserResponse = [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle)

 Start-Sleep -Seconds 5

  }
 }
} until ($UserResponse -eq "yes")