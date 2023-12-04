$wshell = New-Object -ComObject Wscript.Shell
$Output = $wshell.Popup("The report generation script is successfully completed! Do you want to display a report on the screen?",0,"The report is ready",4+32)
