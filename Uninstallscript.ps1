
function Get-ApplicationGUID {
    param([string]$appName)

    $appGUID = Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" |
               Where-Object { $_.DisplayName -like "*$appName*" } |
               Select-Object -ExpandProperty PSChildName

    return $appGUID
}

# Usage example:
$appName = "7-Zip 22.01 (x64 edition)"
$appGUID = Get-ApplicationGUID -appName $appName

if ($appGUID) {
    Write-Host "GUID of $appName $appGUID"
}
else {
    Write-Host "Application $appName not found."
}

$msiGUID = $appGUID

# Function to search for the application with the specified MSI GUID
function Get-InstalledAppByGUID {
    param([string]$guid)
    $key = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
    Get-ItemProperty "$key\*" | Where-Object { $_.PSChildName -match $guid }
}

# Get the application using the MSI GUID
$app = Get-InstalledAppByGUID $msiGUID

# Uninstall the application if found
if ($app -ne $null) {
    $uninstallString = $app.UninstallString
    Write-Host "Uninstalling application with MSI GUID: $msiGUID"
    #Start-Process -FilePath "msiexec.exe" -ArgumentList "/x $uninstallString /quiet" -Wait
    msiexec.exe /x $msiGUID /qn
    Write-Host "Application successfully uninstalled."
}
else {
    Write-Host "Application with MSI GUID: $msiGUID not found."
}
