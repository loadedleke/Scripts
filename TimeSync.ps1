<# This script does the follwing
1. Set the Windows Time Service to Automatic
2. Starts the Windows Time Service
3. Created a scheduled task called TimeSync and sets it to run everyhour.
#>

Set-Service W32time -startuptype automatic
Start-Service W32time
schtasks /Create /F /RU SYSTEM /RL HIGHEST /SC HOURLY /TN Timesync /TR “cmd /c w32tm /resync”
schtasks /run /I /TN timesync