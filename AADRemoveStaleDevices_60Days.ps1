#This script requires the AzureAD module
#This script imports device objects from a CSV and removes them from Azure AD

#Connect to AzureAD 
 Connect-AzureAD
#Prompts user to the path to the already exportd device list and import the list
$SourceCSV = Read-Host -Prompt 'Type or (drag and drop) the path of the CSV that contains the devices to the deleted here.'
$Staledevices = Import-CSV -Path $SourceCSV

$ConfirmDeletion = Read-Host "Delete all Azure AD devices which haven't contacted your tenant since $deletionThresholdDays days (Y/N)"

#Remove devices from AzureAD
If ($confirmDeletion -eq "y"){ 
   ForEach($Staledevice in $Staledevices) {
   Write-Output "Removing device $($Staledevice.Displayname) from Azure"
   Remove-AzureADDevice -ObjectID $Staledevice.ObjectID
   
   sleep 2
   $ErrorActionPreference = 'SilentlyContinue'
   $Device = Get-AzureADDevice -ObjectID $Staledevice.ObjectID 
    If( $Device -eq $Null){
      Write-Output "$($Staledevice.DisplayName) successfully removed"
    }
    Else {
    Write-Host "$($Staledevice.Displayname) not found"
    }
    }
}

Else{
   
     Write-Output "Exiting..."
}