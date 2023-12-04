$result = systeminfo.exe | findstr KB5019961

if ($result)
 {
    Write-Output "Found KB5019961"
    exit 0
 }
 else
 {
    exit 1
 }