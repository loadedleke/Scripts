<#
This script modifies registry entries for the Outlook App and removes the option to switch to the New Outlook by doing the following;
1. Hide/Remove the new outlook toggle button
2. Switches Outlook from the New to Classic and keeps it that way
#>

#Creates a new Key to Hide/Remove the new outlook toggle button
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\Options\General' -Name 'HideNewOutlookToggle' -Value "1" -PropertyType DWORD -Force

#Switches Outlook from the New to Classic
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\Preferences' -Name 'UseNewOutlook' -Value "0" -PropertyType DWORD -Force
