# Install IntuneBackupAndRestore from the PowerShell Gallery
  Install-Module -Name IntuneBackupAndRestore

# Update IntuneBackupAndRestore from the PowerShell Gallery
  Update-Module -Name IntuneBackupAndRestore

  Install-Module -Name Microsoft.Graph.Intune
  Connect-MSGraph

  Import-Module IntuneBackupAndRestore

  Start-IntuneBackup -Path C:\Backup\IntuneBackup