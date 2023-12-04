$settings = @(
    @{
        Description = "Enable Daylight Savings Time"
        Path        = "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation"
        Name        = "DynamicDaylightTimeDisabled"
        Value       = 0
        Type        = "DWord"
    }
)

Function Set-RegistryValue {
    Param(
        $Description,
        [Parameter(Mandatory = $true)]$Path,
        [Parameter(Mandatory = $true)]$Name,
        [Parameter(Mandatory = $true)]$Value,
        [Parameter(Mandatory = $true)][ValidateSet("Binary", "DWord", "ExpandString", "MultiString", "QWord", "String")]$Type
    )
    
    If (-not (Test-Path $path)) {
        Try {
            New-Item -Path $Path -Force | Out-Null
        }
        Catch {
            Write-Host "Could not create $Path"
            Exit 1001
        }      
    }

    $existingValue = (Get-Item -Path $Path).GetValue($Name, $null)

    If ($existingValue -ne $Value) {
        Write-Host "Setting $($Path)\$($Name) to $($Value)"
        Try { Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force | Out-Null }
        Catch { Write-Host "Could not set $($Path)\$($Name) to $($Value)" }
    }
    Else { Write-Host "$($Path)\$($Name) is already set to $($Value)" }
}

ForEach ($setting in $settings) {
    Set-RegistryValue @setting
}
