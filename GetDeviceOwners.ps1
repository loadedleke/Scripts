#Connect-AzureAD
#Prompt for the path to the CSV file.
$SourceCSV = Read-Host -Prompt 'Type or (drag and drop) the path of the CSV that contains the devices here. If youa re only dling a single device press enter.'

If ($SourceCSV -ne "") {
    #Get the list of devices from the CSV
    $devices = Import-Csv -Path $SourceCSV #an error might occur here if the user doesn't enter a CSV
}
Else {
    #Input the device if no CSV is specified
    $devices = Read-Host -Prompt 'Type the device name here.'
}

ForEach ($device in $devices) {
    $deviceObject = Get-AzureADDevice -Filter "Displayname eq '$($device.name)'"
    $deviceid = $deviceObject.ObjectId

    $assignedUser = Get-AzureADDeviceRegisteredOwner -ObjectID $deviceId 
    Write-Output "$($assignedUser.DisplayName)"
}
