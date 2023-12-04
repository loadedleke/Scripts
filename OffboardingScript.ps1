#########User info######
$userToOffboard =  Read-host "ENTER LEAVERS FULL EMAIL ADDRESS: (e.g. firstname.lastname@alcority.com)"
$adminaccount = Get-Credential
$CustomerDefaultDomainname =  Read-host "ENTER TENANT DOMAIN (e.g. alcority.com): "
###

#
Write-Host "Logging into Azure AD." -ForegroundColor Green
If (Get-Module -ListAvailable -Name AzureAD){
Write-Host "Module exist"
}
Else{ 
Write-Host "AzureAD Module does not exist" -ForegroundColor Yellow
Write-Host "Installing AzureAD Module..."
Install-Module AzureAD
}
Connect-AzureAD -Credential $adminaccount

Write-Host "Connecting to Exchange Online" -ForegroundColor Green
If (Get-Module -ListAvailable -Name ExchangeOnlineManagement){
Write-Host "Module exist"
}
Else{ 
Write-Host "ExchangeOnlineManagement Module does not exist" -ForegroundColor Yellow
Write-Host "Installing ExchangeOnlineManagement Module..."
Install-Module ExchangeOnlineManagement
}
Connect-ExchangeOnline -Credential $adminaccount

<#
Write-Host "Connecting to Microsoft.Graph.Identity.Signins" -ForegroundColor Green
If (Get-Module -ListAvailable -Name Microsoft.Graph.Identity.Signins){
Write-Host "Module exist"
}
else{ 
Write-Host "Microsoft Graph Identity Signins module does not exist" -ForegroundColor Yellow
Write-Host "Installing Microsoft Graph Identity Signins Module..."
Install-Module Microsoft.Graph.Identity.Signins
}
Connect-MgGraph -Scopes UserAuthenticationMethod.ReadWrite.All
Select-MgProfile -Name beta
#>

Write-Host "Connecting to MSOnline" -ForegroundColor Green
If (Get-Module -ListAvailable -Name MSOnline){
Write-Host "Module exist"
}
else{ 
Write-Host "MSOnline module does not exist" -ForegroundColor Yellow
Write-Host "Installing MSOnline Module..."
Install-Module MSOnline
}
Connect-MsolService -Credential $adminaccount

#Refresh User Session Token
 Revoke-AzureADUserAllRefreshToken -ObjectId $userToOffboard

#Reset Password
$TokenSet = @{
        U = [Char[]]'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        L = [Char[]]'abcdefghijklmnopqrstuvwxyz'
        N = [Char[]]'0123456789'
        S = [Char[]]'!"#$%&''()*+,-./:;<=>?@[\]^_`{|}~'
    }

$Upper = Get-Random -Count 5 -InputObject $TokenSet.U
$Lower = Get-Random -Count 5 -InputObject $TokenSet.L
$Number = Get-Random -Count 5 -InputObject $TokenSet.N
$Special = Get-Random -Count 5 -InputObject $TokenSet.S

$StringSet = $Upper + $Lower + $Number + $Special
$newPassword = (Get-Random -Count 16 -InputObject $StringSet) -join ''
$secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
Set-AzureADUserPassword -ObjectId $userToOffboard -Password $secPassword -ForceChangePasswordNextLogin $true

#Block Sign-in
 Set-AzureADUser -ObjectID $userToOffboard -AccountEnabled $false

#Require re-register of MFA
$p=@()
Set-MsolUser -UserPrincipalName $userToOffboard -StrongAuthenticationMethods $p

#Append [Inactive] to Display Name
 Get-AzureADUser -ObjectId $userToOffboard
 $newDisplayName = $userToOffboard.DisplayName +'[Inactive]'

#Disable All user's devices
 Get-AzureADUserRegisteredDevice -ObjectId $userToOffboard | Set-AzureADDevice -AccountEnabled $false



Write-Host "Removing users from Distribution Groups" -ForegroundColor Green
Get-Recipient -Filter "Members -eq '$OffboardingDN'" | foreach-object {
    write-host "    Removing using from $($_.name)" -ForegroundColor green
    Remove-DistributionGroupMember -Identity $_.ExternalDirectoryObjectId -Member $OffboardingDN -BypassSecurityGroupManagerCheck -Confirm:$false }

<#
write-host "Removing users from Azure AD Groups" -ForegroundColor Green
$MemberID = (Get-AzureADUser -ObjectId $userToOffboard).objectId
Get-AzureADUserMembership -ObjectId $MemberID -All $true | Where-Object { $_.ObjectType -eq "Group" -and $_.SecurityEnabled -eq $true -and $_.MailEnabled -eq $false } | ForEach-Object {
    write-host "    Removing using from $($_.displayname)" -ForegroundColor green
    Remove-AzureADGroupMember -ObjectId $_.ObjectID -MemberId $MemberID
}
write-host "Removing users from Unified Groups and Teams" -ForegroundColor Green
$OffboardingDN = (get-mailbox -Identity $userToOffboard -IncludeInactiveMailbox).DistinguishedName
Get-Recipient -Filter "Members -eq '$OffboardingDN'" -RecipientTypeDetails 'GroupMailbox' | foreach-object {
    write-host "    Removing using from $($_.name)" -ForegroundColor green
    Remove-UnifiedGroupLinks -Identity $_.ExternalDirectoryObjectId -Links $userToOffboard -LinkType Member -Confirm:$false }

write-host "Setting mailbox to Shared Mailbox" -ForegroundColor Green
Set-Mailbox $userToOffboard -Type Shared
write-host "Hiding user from GAL" -ForegroundColor Green
Set-Mailbox $userToOffboard -HiddenFromAddressListsEnabled $true

write-host "Removing License from user." -ForegroundColor Green
$AssignedLicensesTable = Get-AzureADUser -ObjectId $userToOffboard | Get-AzureADUserLicenseDetail | Select-Object @{n = "License"; e = { $_.SkuPartNumber } }, skuid
if ($AssignedLicensesTable) {
    $body = @{
        addLicenses    = @()
        removeLicenses = @($AssignedLicensesTable.skuid)
    }
    Set-AzureADUserLicense -ObjectId $userToOffboard -AssignedLicenses $body
}

write-host "Removed licenses:"
$AssignedLicensesTable
Remove-PSSession $session
#>