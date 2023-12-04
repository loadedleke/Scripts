$settings = @(
    @{
        Description = "Disable Multicast Name Resolution (LLMNR)"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient"
        Name        = "EnableMulticast"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Automatically set the time zone based on the computer's detected location"
        Path        = "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate"
        Name        = "Start"
        Value       = 4
        Type        = "DWord"
    }
    @{
        Description = "Allow the computer to automatically detect its location"
        Path        = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
        Name        = "Value"
        Value       = "Allow"
        Type        = "String"
    }
    @{
        Description = "Hide all drives in File Explorer"
        Path        = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
        Name        = "NoDrives"
        Value       = 67108863
        Type        = "DWord"
    }
    @{
        Description = "Disable 'Allow running plugins that are outdated'"
        Path        = "HKLM:\SOFTWARE\Policies\Google\Chrome"
        Name        = "AllowOutdatedPlugins"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Disable 'Continue running background apps when Google Chrome is closed'"
        Path        = "HKLM:\SOFTWARE\Policies\Google\Chrome"
        Name        = "BackgroundModeEnabled"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Block webpages from automatically running Flash plugins"
        Path        = "HKLM:\SOFTWARE\Policies\Google\Chrome"
        Name        = "DefaultPluginsSetting"
        Value       = 3
        Type        = "DWord"
    }
    @{
        Description = "Enable 'Block third party cookies'"
        Path        = "HKLM:\SOFTWARE\Policies\Google\Chrome"
        Name        = "BlockThirdPartyCookies"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Disable Flash on Adobe Reader DC"
        Path        = "HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown"
        Name        = "bEnableFlash"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Disable JavaScript on Adobe Reader DC"
        Path        = "HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown"
        Name        = "bDisableJavaScript"
        Value       = 1
        Type        = "DWord"
    }
    @{
        Description = "Enable 'Local Security Authority (LSA) protection'"
        Path        = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
        Name        = "RunAsPPL"
        Value       = 1
        Type        = "DWord"
    }
    @{
        Description = ""
        Path        = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
        Name        = "FeatureSettingsOverride"
        Value       = 8264
        Type        = "DWord"
    }
    @{
        Description = ""
        Path        = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
        Name        = "FeatureSettingsOverrideMask"
        Value       = 3
        Type        = "DWord"
    }
    @{
        Description = "Disable 'Local Machine Run-Once'"
        Path        = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
        Name        = "DisableLocalMachineRunOnce"
        Value       = 1
        Type        = "DWord"
    }
    @{
        Description = "Disable Microsoft Defender Firewall notifications when programs are blocked for Domain profile"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"
        Name        = "DisableNotifications"
        Value       = 1
        Type        = "DWord"
    }
    @{
        Description = "Disable Microsoft Defender Firewall notifications when programs are blocked for Private profile"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile"
        Name        = "DisableNotifications"
        Value       = 1
        Type        = "DWord"
    }
    @{
        Description = "Disable Microsoft Defender Firewall notifications when programs are blocked for Public profile"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile"
        Name        = "DisableNotifications"
        Value       = 1
        Type        = "DWord"
    }
    @{
        Description = "Disable merging of local Microsoft Defender Firewall rules with group policy firewall rules for the Public profile"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile"
        Name        = "AllowLocalPolicyMerge"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Disable merging of local Microsoft Defender Firewall connection rules with group policy firewall rules for the Public profile"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile"
        Name        = "AllowLocalIPsecPolicyMerge"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Disable 'Installation and configuration of Network Bridge on your DNS domain network'"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
        Name        = "NC_AllowNetBridge_NLA"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Enable 'Require domain users to elevate when setting a network's location'"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
        Name        = "NC_StdDomainUserSetLocation"
        Value       = 1
        Type        = "DWord"
    }
    @{
        Description = "Prohibit use of Internet Connection Sharing on your DNS domain network"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
        Name        = "NC_ShowSharedAccessUI"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Set 'Minimum PIN length for startup' to '6 or more characters'"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"
        Name        = "MinimumPIN"
        Value       = 6
        Type        = "DWord"
    }
    @{
        Description = "Disable 'Configure Offer Remote Assistance'"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
        Name        = "fAllowUnsolicited"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Enable Local Admin password management"
        Path        = "HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd"
        Name        = "AdmPwdEnabled"
        Value       = 1
        Type        = "DWord"
    }
    @{
        Description = "Enable 'Microsoft network client: Digitally sign communications (always)'"
        Path        = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
        Name        = "DisableDomainCreds"
        Value       = 1
        Type        = "DWord"
    }
    @{
        Description = "Enable 'Hide Option to Enable or Disable Updates'"
        Path        = "HKLM:\SOFTWARE\policies\Microsoft\office\16.0\common\officeupdate"
        Name        = "hideenabledisableupdates"
        Value       = 1
        Type        = "DWord"
    }
)

<#
$userSettings = @(
    @{
        Description = "Hide Cortana Button"
        Path        = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        Name        = "ShowCortanaButton"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Disable web search from taskbar"
        Path        = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
        Name        = "BingSearchEnabled"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Disable Cortana"
        Path        = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
        Name        = "CortanaConsent"
        Value       = 0
        Type        = "DWord"
    }
    @{
        Description = "Minimize the taskbar search to an icon"
        Path        = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
        Name        = "SearchboxTaskbarMode"
        Value       = 1
        Type        = "DWord"
    }
)
#>

Function Set-RegistryValue {
    Param(
        $Description,
        [Parameter(Mandatory = $true)]$Path,
        [Parameter(Mandatory = $true)]$Name,
        [Parameter(Mandatory = $true)]$Value,
        [Parameter(Mandatory = $true)][ValidateSet("Binary", "DWord", "ExpandString", "MultiString", "QWord", "String")]$Type
    )
    
    If (-not (Test-Path $path)) {
        Try {
            New-Item -Path $Path -Force | Out-Null
        }
        Catch {
            Write-Host "Could not create $Path"
            Exit 1001
        }      
    }

    $existingValue = (Get-Item -Path $Path).GetValue($Name, $null)

    If ($existingValue -ne $Value) {
        Write-Host "Setting $($Path)\$($Name) to $($Value)"
        Try { Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force | Out-Null }
        Catch { Write-Host "Could not set $($Path)\$($Name) to $($Value)" }
    }
    Else { Write-Host "$($Path)\$($Name) is already set to $($Value)" }
}

ForEach ($setting in $settings) {
    Set-RegistryValue @setting
}
