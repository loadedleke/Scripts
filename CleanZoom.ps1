<# 
  Create CleanRoom directory in drive C
  Download CleanRoom executable
  Extract the ZIP file
  Run the CleanRoom Executable
  Delete the CleanRoom directory and its content
#>

# URL and Destination
  $folderPath = 'C:\Users\Public\Downloads'
  $url = "https://assets.zoom.us/docs/msi-templates/CleanZoom.zip"
  #New-Item -Path $folderPath -ItemType Directory -Force
  $dest = $folderPath

# Download file
  Start-BitsTransfer -Source $url -Destination $dest

# Extract the downloaded ZIP file.
  Expand-Archive -Path "$folderPath\CleanZoom.zip" -DestinationPath $folderPath -Force

# Change Directory to C:\CleanRoom and run CleanRoom executable silently then sleep
  cd $folderPath
  .\CleanZoom.exe /silent
   Start-Sleep -Seconds 600

# Delete directory and all contents
  Remove-Item $folderPath\CleanZoom.* -force