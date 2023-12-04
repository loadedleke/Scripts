$appName = "Zoom*"

$uninstallRegistryPaths = @("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZoomUMX")
$appInstall = Get-ChildItem -Path $uninstallRegistryPaths | Get-ItemProperty | Where-Object { $_.DisplayName -like $appName } | Select-Object -Property DisplayName, UninstallString

If (-not $appInstall) { Write-Host "$appName not found" }
ForEach ($install in $appInstall) {

    If ($install.UninstallString) {
        Write-Host "Uninstalling $($install.DisplayName)"
        $uninst = $install.UninstallString -replace "/I", "/x "
        Start-Process cmd -ArgumentList "/c $uninst /quiet /norestart" -NoNewWindow
    }
}
