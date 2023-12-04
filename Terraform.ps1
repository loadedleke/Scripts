<# 
  Create Terraform directory in drive C:\Windows\System32
  Download Terraform ZIP
  Extract the ZIP file
  Delete the ZIP file
  Add persistent path to Environment Variables
#>

# URL and Destination
  mkdir C:\Windows\System32\Terraform
  $folderPath = 'C:\Windows\System32\Terraform'
  #New-Item -Path $folderPath -ItemType Directory -Force
  $Url = "https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_windows_amd64.zip"
  $dest = $folderPath

# Download file
  Start-BitsTransfer -Source $url -Destination $dest

# Extract the downloaded ZIP file.
  Expand-Archive -Path "$folderPath\terraform_1.3.9_windows_amd64.zip" -DestinationPath $folderPath -Force

# Delete downloaded ZIP File
  Remove-Item "$folderPath\terraform_1.3.9_windows_amd64.zip"

# Add persistent path to Environment Variables
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value  (((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path) + ";C:\Windows\System32\Terraform" )