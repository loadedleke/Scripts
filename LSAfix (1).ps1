# Create DWORD RunAsPPLBoot and set value to 2
    New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RunAsPPLBoot" -Value "2" -PropertyType DWord -Force;

# Enable Memory Intergrity
    New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -Value "1" -PropertyType DWord -Force;
