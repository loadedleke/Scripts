<#Customize the ExecutionPolicy (absolutely OK for this demo)
Set-ExecutionPolicy -ExecutionPolicy Unrestricted

#Install the Module
Install-Module -Name Microsoft.Graph.Intune -Verbose -Force -AllowClobber

#Install the Module
Install-Module -Name MSGraphFunctions -Verbose -Force -AllowClobber

#Import the Module
Import-Module -Name MSGraphFunctions

#Install the Module
Install-Module -Name AzureAD -Verbose -Force -AllowClobber

#Install IntuneBackupAndRestore from the PowerShell Gallery
Install-Module -Name IntuneBackupAndRestore -Verbose -Force -AllowClobber

#Update the Module
Update-Module -Name IntuneBackupAndRestore -Verbose

#Import the Module
Import-Module IntuneBackupAndRestore
#>

Connect-AzureAD
Connect-MSGraph
Start-IntuneRestoreConfig -Path 'C:\Users\AdelekeOgunbela\OneDrive - Dorilton Capital\Scripts\Backup\ACDC\IntuneBackup'
Start-IntuneRestoreAssignments -Path 'C:\Users\AdelekeOgunbela\OneDrive - Dorilton Capital\Scripts\Backup\ACDC\IntuneBackup'