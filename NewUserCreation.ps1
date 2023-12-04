<#
This script requires Azure AD PowerShell Module to be installed on the computer and perform the following task;
a. Connect to AzureAD (Will require credentials & MFA).
b. Create a password profile for will be assigned to the account created.
c. Create user account(s) in the ALC/DCM Azure AD tenant
d. Assign manager to the user
e. Add user to the appropriate employee security group.
f. Add users to the Intune policy security group
#>

#Configure Date new user(s) were created.
 $Date = Get-Date -Format "yyyyMMddHH:mm"

Function Install-PowerShellGet {
    Install-Module PowershellGet -Force -AllowClobber -Verbose:$false
}
Function Install-AzureAD {
    Set-PSRepository -Name PSGallery -Installation Trusted -Verbose:$false
    Install-Module -Name AzureAD -AllowClobber -Verbose:$false
}

Try {
    Import-Module -Name AzureAD -ErrorAction Stop -Verbose:$false
}
Catch {
    Write-Host "Azure AD PowerShell Module not found..."
    Write-Host "Installing Azure AD PowerShell Module..."
    Install-AzureAD
}

#Collect and sign in with ALC/DCM Admin's Azure AccountId
$AdminCredential = Read-Host -Prompt ( "Input your ALC/DCM admin username e.g (John.Doe)" )
$Credential = $AdminCredential + "@admin.alcority.com"
  
Try {
    Write-Host "Connecting to Azure AD..."
    if ($MFA) {
        Connect-AzureAD -ErrorAction Stop | Out-Null
    }
    Else {
        Connect-AzureAD -AccountId $Credential -ErrorAction Stop | Out-Null
    }
}
Catch {
    Write-Host "Cannot connect to Azure AD. Please check your credentials. Exiting!" -ForegroundColor Red
    Break
}

 
#Create a password profile
 Write-Host "Provide default user password" -ForegroundColor Yellow
 $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile  
 $Password = Read-Host -Prompt ( "Type the standard password" )
 $PasswordProfile.Password = $Password

#Prompt for the path of the Source CSV
 $SourceCSV = Read-Host -Prompt 'Type or (drag and drop) the path of the CSV that contains the new hire here. If you are only doing a single user press enter' 

If ($SourceCSV -ne "") {
	#Get the list of users from the CSV
	$Users = Import-CSV -Path $SourceCSV #an error might occur here if the user doesnt enter an csv 
}

Else {
	#Input the username if no CSV is specified
	 $GivenName = Read-Host -Prompt ( "Input the user's given name (e.g. John)")
     $Surname = Read-Host -Prompt ( "Input the user's surname (e.g. Doe)")
     $Displayname = "$GivenName $Surname"
     $mailNickname = "$GivenName.$Surname"
     $Department = Read-Host -Prompt ( "Input the user's departmnent otherwise hit enter if no entry(e.g Technology)")
      If ($Department -eq ""){
      $Department =$Null
      }
     $JobTitle = Read-Host -Prompt ( "Input the user's job title otherwise hit enter if no entry (e.g. Helpdesk)")
      If ($JobTitle -eq ""){
      $JobTitle =$Null
      }
     $AzureADUserManager = Read-Host -Prompt ( "Input the user's manager UPN (e.g. jane.doe@alcority.com) otherwise hit enter if no entry")
      If ($AzureADUserManager -eq ""){
      $AzureADUserManager =$Null
      }
     $ACSuffix = "@alcority.com"
     $DCSuffix = "@doriltoncapital.com"
     $WCSuffix = "@westlawn.com"
     $UsageLocation = "US"

#Assign the location the user is situated
     $Location = Read-Host -Prompt ("Enter user's office location (e.g. D=Dallas, N=New York, C=Connecticut, H=Houston, U=United Kingdom, WCA=Westlawn Canada or WH=Westlawn Houston then hit Enter ")

     If ($Location -eq "D"){
    #If admin types "D" then hit enter, set location to Dallas Address
     $StreetAddress = "6565 N MacArthur Blvd, 5th Floor"
     $City = "Dallas"
     $State = "Texas"
     $PostalCode = "75039"
     $Country = "United States"
     }
     
     ElseIf ($Location -eq "N"){
    #If admin types "N" then hit enter, add set location to New York Address
     $StreetAddress = "32 Avenue of the Americas, 17th Floor"
     $City = "New York"
     $State = "New York"
     $PostalCode = "10013"
     $Country = "United States"
     }

     ElseIf ($Location -eq "H"){
    #If admin types "N" then hit enter, add set location to Houston Address
     $StreetAddress = "515 Post Oak Blvd, Suite 620"
     $City = "Houston"
     $State = "Texas"
     $PostalCode = "77027"
     $Country = "United States"
     }

     ElseIf ($Location -eq "U"){
    #If admin types "N" then hit enter, add set location to Houston Address
     $StreetAddress = $Null
     $City = $Null
     $State = $Null
     $PostalCode = $Null
     $Country = "United Kingdom"
     }

     ElseIf ($Location -eq "C"){
    #If admin types "N" then hit enter, add set location to Houston Address
     $StreetAddress = "225 High Ridge Road"
     $City = "Stamford"
     $State = "Connecticut"
     $PostalCode = "06905"
     $Country = "United States"
     }

     ElseIf ($Location -eq "WCA"){
    #If admin types "N" then hit enter, add set location to Houston Address
     $StreetAddress = "407 2 St SW, Suite 800"
     $City = "Calgary"
     $State = "Alberta"
     $PostalCode = "T2P 2Y3"
     $Country = "Canada"
     }

     ElseIf ($Location -eq "WH"){
    #If admin types "N" then hit enter, add set location to Houston Address
     $StreetAddress = "4801 Woodway Drive, Ste 455E"
     $City = "Houston"
     $State = "Texas"
     $PostalCode = "77056"
     $Country = "United States"
     }


#Assign the Company name and UserPrincipalName based on the company user is employed
     $DomainSuffix = Read-Host -Prompt ( "Enter 'A' if user is employed in Alcority or 'D' if user is employed at Dorilton Capital or 'W' if user is employed at Westlawn then hit Enter ")
    
    If ($DomainSuffix -eq "A"){
    #If admin types "A" then hit enter, add the '@alcority.com' suffix to the mailNickname as the UserPrincipalName.
     $UserPrincipalName = $mailNickname + $ACSuffix
     $CompanyName = "Alcority"
     }
     
     ElseIf ($DomainSuffix -eq "D"){
    #If admin types "D" then hit enter, add the '@doriltoncapital.com' suffix to the mailNickname as the UserPrincipalName.
     $UserPrincipalName = $mailNickname + $DCSuffix
     $CompanyName = "Dorilton Capital"
     }

      ElseIf ($DomainSuffix -eq "W"){
    #If admin types "W" then hit enter, add the '@westlawn.com' suffix to the mailNickname as the UserPrincipalName.
     $UserPrincipalName = $mailNickname + $WCSuffix
     $CompanyName = "Westlawn"
     }

     
    #Create a new "object" with properties to hold the variables
	$Input = New-Object -TypeName PsObject
	$Input | Add-Member -MemberType NoteProperty -Name GivenName -Value $GivenName
	$Input | Add-Member -MemberType NoteProperty -Name Surname -Value $Surname
	$Input | Add-Member -MemberType NoteProperty -Name Department -Value $Department
	$Input | Add-Member -MemberType NoteProperty -Name JobTitle -Value $JobTitle
	$Input | Add-Member -MemberType NoteProperty -Name AzureADUserManager -Value $AzureADUserManager
	$Input | Add-Member -MemberType NoteProperty -Name DisplayName -Value $DisplayName
	$Input | Add-Member -MemberType NoteProperty -Name mailNickname -Value $mailNickname
	$Input | Add-Member -MemberType NoteProperty -Name UserPrincipalName -Value $UserPrincipalName
	$Input | Add-Member -MemberType NoteProperty -Name Usagelocation -Value $UsageLocation
	$Input | Add-Member -MemberType NoteProperty -Name CompanyName -Value $CompanyName
    $Input | Add-Member -MemberType NoteProperty -Name StreetAddress -Value $StreetAddress
    $Input | Add-Member -MemberType NoteProperty -Name City -Value $City
    $Input | Add-Member -MemberType NoteProperty -Name State -Value $State
    $Input | Add-Member -MemberType NoteProperty -Name PostalCode -Value $PostalCode
    $Input | Add-Member -MemberType NoteProperty -Name Country -Value $Country
	
    #Create an array which will mimick the array created from the import of a CSV
	 $Users= @()
	#Add our single user to the array for processing.
	 $Users += $Input
  }  

#Go through the list of users
  Write-Host `n
  Write-Host "Creating new user account in the ALC/DCM Azure AD Tenant" -ForegroundColor Yellow

#Create the user account in Azure AD with the provided variables.
 ForEach($User in $Users) {
  New-AzureADUser -DisplayName $User.DisplayName -AccountEnabled $True -PasswordProfile $PasswordProfile -UserPrincipalName $User.UserPrincipalName -GivenName $User.GivenName -Surname $User.Surname -mailNickName $User.mailNickname -UsageLocation $User.UsageLocation -CompanyName $User.CompanyName -Department $User.Department -JobTitle $User.JobTitle -StreetAddress $User.StreetAddress -City $User.City -State $User.State -PostalCode $User.PostalCode -Country $User.Country | Out-Null
   
 #Check if the user was successfully created
  $AzureADUser = Get-AzureADUser -ObjectId $User.UserPrincipalName | Select displayname | Out-Null
   If ($AzureADUser -notmatch $User.DisplayName){
    throw "$($User.DisplayName) creation was unsuccessfully!"
    }
   Else{
    Write-Host "$($User.DisplayName) was created in the ALC/DCM AzureAD Tenant successfully!" -ForegroundColor Green
    }

#Set the assigned manager for the user
   If ($AzureADUserManager -ne $Null){
   Set-AzureADUserManager -ObjectId $User.UserPrincipalName -RefObjectId (Get-AzureAdUser -ObjectId $User.AzureAdUserManager).objectid
   Write-Host "$($Manager.DisplayName) was added as $($User.DisplayName)'s manager successfully!" -ForegroundColor Green
   }
   
#Add user to the appropriate employee security group 
   If ($User.companyname -eq "Dorilton Capital"){
   #Add Dorilton Capital employees to the users.dcm.employees security group (Needed for license assignment)
    Add-AzureADGroupMember -ObjectID 7f7bb242-1c3c-4f0f-aaf3-ada624fc379e -RefObjectId (Get-AzureADUser -ObjectID $User.UserPrincipalName).objectId
    Write-Host "$($User.DisplayName) added to **users.dcm.employees** security group successfully!" -ForegroundColor Green
    }  
   ElseIf ($User.companyname -eq "Alcority"){
   #Add Alcority employees to the users.alc.employees security group (Needed for license assignment)
    Add-AzureADGroupMember -ObjectID 23d2bacc-5837-4437-8c40-b48a037c3f40 -RefObjectId (Get-AzureADUser -ObjectID $User.UserPrincipalName).ObjectID
    Write-Host "$($User.DisplayName) added to **users.alc.employees** security group successfully!" -ForegroundColor Green
    }  
     ElseIf ($User.companyname -eq "Westlawn"){
   #Add Westlawn employees to the users.westlawn.employees security group (Needed for license assignment)
    Add-AzureADGroupMember -ObjectID d085b178-0e6d-434c-a010-9f9c79b6b28c -RefObjectId (Get-AzureADUser -ObjectID $User.UserPrincipalName).ObjectID
    Write-Host "$($User.DisplayName) added to **users.westlawn.employees** security group successfully!" -ForegroundColor Green
    }  

#Add users to the Intune policy security group (intune_dcm_user_standard)
   Add-AzureADGroupMember -ObjectID b9e61cba-6750-4bb6-8dbd-171f8fd462a3 -RefObjectId (Get-AzureADUser -ObjectID $User.UserPrincipalName).objectId 
   Write-Host "$($User.DisplayName) added to **intune_dcm_user_standard** security group successfully!" -ForegroundColor Green
 
}

#Disconnect Azure AD sessions
  Disconnect-AzureAD -Confirm:$false
