#This script uninstall versions of Microsoft 365 Apps and Microsoft Onenote that is like ex-mx, fr-ca, es-es & fr-fr

$OfficeUninstallStrings = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.PSChildName -like "*es-mx*" -or $_.PSChildName -like "*fr-ca*" -or $_.PSChildName -like "*fr-fr*" -or $_.PSChildName -like "*es-es*" -or $_.PSChildName -like "*pt-br*"} | Select UninstallString).UninstallString
    ForEach ($UninstallString in $OfficeUninstallStrings) {
        $UninstallEXE = ($UninstallString -split '"')[1]
        $UninstallArg = ($UninstallString -split '"')[2] + " DisplayLevel=False"
        Start-Process -FilePath $UninstallEXE -ArgumentList $UninstallArg -Wait
    }  