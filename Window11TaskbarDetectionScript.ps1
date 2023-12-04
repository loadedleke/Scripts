<#
.SYNOPSIS
    Manage the 'This PC' shortcut on the desktop in Microsoft Windows.
    This script is used as detection script with Proactive Remediations in Microsoft Endpoint Manager

.DESCRIPTION
    Manage various application settings in Windows, which currently consists of:
    - Enable This PC shortcut on desktop

.NOTES
    Filename: Detect-ThisPCDesktop.ps1
    Version: 1.0
    Author: Wesley van den Heuvel
    Twitter: @wjpvandenheuvel

.LINK
    https://modernmanagement.cloud
        
#>

# Discovery script
$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$Path1 = "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
$AttrName = "TaskbarAl"
$AttrName1 = "TaskbarMn"
$AttrName2 = "ShowTaskViewButton"
$AttrName3 = "TaskbarDa"
$AttrName4 = "SearchboxTaskbarMode"

$AttrValue = "0"

# Check registry value
Try {
    $Registry = Get-ItemProperty -Path $Path -Name $AttrName -ErrorAction Stop | Select-Object -ExpandProperty $AttrName
    If ($Registry -eq $AttrValue){
        Write-Output "Compliant"
        Exit 0
    } Else {
    Write-Warning "Not Compliant"
    #Exit 1
    
    $Registry = Get-ItemProperty -Path $Path -Name $AttrName1 -ErrorAction Stop | Select-Object -ExpandProperty $AttrName1
    If ($Registry -eq $AttrValue){
        Write-Output "Compliant"
        Exit 0
    } Else {
    Write-Warning "Not Compliant"
    Exit 1
 }
 } 
}
Catch {
    Write-Warning "Not Compliant"
    Exit 1
}

<#Try {
    $Registry = Get-ItemProperty -Path $Path -Name $AttrName1 -ErrorAction Stop | Select-Object -ExpandProperty $AttrName1
    If ($Registry -eq $AttrValue){
        Write-Output "Compliant"
        Exit 0
    } Else {
    Write-Warning "Not Compliant"
    #Exit 1
 } 
}
Catch {
    Write-Warning "Not Compliant"
    #Exit 1
}

Try {
    $Registry = Get-ItemProperty -Path $Path -Name $AttrName2 -ErrorAction Stop | Select-Object -ExpandProperty $AttrName2
    If ($Registry -eq $AttrValue){
        Write-Output "Compliant"
        Exit 0
    } Else {
    Write-Warning "Not Compliant"
    Exit 1
 } 
}
Catch {
    Write-Warning "Not Compliant"
    #Exit 1
}

Try {
    $Registry = Get-ItemProperty -Path $Path -Name $AttrName3 -ErrorAction Stop | Select-Object -ExpandProperty $AttrName3
    If ($Registry -eq $AttrValue){
        Write-Output "Compliant"
        Exit 0
    } Else {
    Write-Warning "Not Compliant"
    Exit 1
 } 
}
Catch {
    Write-Warning "Not Compliant"
    #Exit 1
}

Try {
    $Registry = Get-ItemProperty -Path $Path1 -Name $AttrName4 -ErrorAction Stop | Select-Object -ExpandProperty $AttrName4
    If ($Registry -eq $AttrValue){
        Write-Output "Compliant"
        Exit 0
    } Else {
    Write-Warning "Not Compliant"
    Exit 1
 } 
}
Catch {
    Write-Warning "Not Compliant"
    #Exit 1
}
#>