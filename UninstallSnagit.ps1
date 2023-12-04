<# 
  Test-Path C:\Program Files\TechSmith
  Create Snagit directory in drive C:\Users\Public\Downloads
  Download Snagit UninstalTool executable
  Extract the ZIP file
  Run the UninstalTool Executable
  Delete the UninstalTool directory and its content
#>

if (Test-Path -Path 'C:\Program Files\TechSmith') {
# URL and Destination
  $folderPath = 'C:\Users\Public\Downloads'
  $url = "https://support.techsmith.com/hc/en-us/article_attachments/4412496384013/UninstallerTool_1_1_0_178.zip"
  #New-Item -Path $folderPath -ItemType Directory -Force
  $dest = $folderPath

# Download file
  Start-BitsTransfer -Source $url -Destination $dest

# Extract the downloaded ZIP file.
  Expand-Archive -Path "$folderPath\UninstallerTool_1_1_0_178.zip" -DestinationPath $folderPath -Force

# Change Directory to $folderpath and run CleanRoom executable silently then sleep
  cd $folderPath
  .\UninstallerTool.exe -product snagit -keep 22
   Start-Sleep -Seconds 600

# Delete directory and all contents
  Remove-Item $folderPath\Uninstaller*.* -force
  }