#This script requires the AzureAD module
#This script exports devices that has not communicate with Azure in the last 60 day from the date it ran.
Set-ExecutionPolicy -ExecutionPolicy Bypass

#Connect to AzureAd
 Connect-AzureAD

#Get the today's date and subtract 60days
 $Date = Get-Date -Format yyyyMMdd
 $dt = (Get-Date).AddDays(-60)

#Provide directory location for device CSV export
 $Path = Read-Host -Prompt 'Type the path to the directory the CSV that contains the devices should be exported to (e.g C:\temp). '

#Export the device list to provided path in CSV
 Get-AzureADDevice -All:$true | Where {$_.ApproximateLastLogonTimeStamp -le $dt} | select-object -Property AccountEnabled, DeviceId, ObjectId, DeviceOSType, DeviceOSVersion, DisplayName, DeviceTrustType, ApproximateLastLogonTimestamp | export-csv -Path "$Path\devicelist-olderthan-60days-summary$Date.csv" -NoTypeInformation
 Write-Host "devicelist-olderthan-60days-summary$Date.csv has been exported to $Path" -ForegroundColor Green

#Disable objects in the device list
 Write-Host "Disabling objects in the devicelist-olderthan-60days-summary$Date.csv........" -ForegroundColor Yellow 
 Get-AzureADDevice -All:$true | Where {$_.ApproximateLastLogonTimeStamp -le $dt} | Set-AzureADDevice -AccountEnabled $false
 Write-Host "Objects in the devicelist-olderthan-60days-summary$Date.csv are successfully disabled" -ForegroundColor Green