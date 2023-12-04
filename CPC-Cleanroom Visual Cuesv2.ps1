#Enable Dark mode for default Windows mode
 Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force
#Turn on Show accent color on Start and taskbar
 Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name ColorPrevalence -Value 1 -Type Dword -Force
#Turn on Show accent color on title bars and windows borders
 Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\DWM -Name ColorPrevalence -Value 1 -Type Dword -Force
#Change AccentColor to Red
 Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\DWM -Name AccentColor -Value 0xff2311e8 -Type Dword -Force
#Change ColorizationAfterglow
 Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\DWM -Name ColorizationAfterglow -Value 0xc4e81123 -Type Dword -Force
#Change ColorizationColor
 Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\DWM -Name ColorizationColor -Value 0xc4e81123 -Type Dword -Force


$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent"

#Accent Color Menu Key
$AccentColorMenuKey = @{
	Key   = 'AccentColorMenu';
	Type  = "DWORD";
	Value = '0xff2311e8'
}

If ($Null -eq (Get-ItemProperty -Path $RegPath -Name $AccentColorMenuKey.Key -ErrorAction SilentlyContinue))
{
	New-ItemProperty -Path $RegPath -Name $AccentColorMenuKey.Key -Value $AccentColorMenuKey.Value -PropertyType $AccentColorMenuKey.Type -Force
}
Else
{
	Set-ItemProperty -Path $RegPath -Name $AccentColorMenuKey.Key -Value $AccentColorMenuKey.Value -Force
}

#Accent Palette Key
$AccentPaletteKey = @{
	Key   = 'AccentPalette';
	Type  = "BINARY";
	Value = 'fb,9d,8b,00,f4,67,62,00,ef,27,33,00,e8,11,23,00,d2,0e,1e,00,9e,09,12,00,6f,03,06,00,69,79,7e,00'
}
$hexified = $AccentPaletteKey.Value.Split(',') | ForEach-Object { "0x$_" }

If ($Null -eq (Get-ItemProperty -Path $RegPath -Name $AccentPaletteKey.Key -ErrorAction SilentlyContinue))
{
	New-ItemProperty -Path $RegPath -Name $AccentPaletteKey.Key -PropertyType Binary -Value ([byte[]]$hexified)
}
Else
{
	Set-ItemProperty -Path $RegPath -Name $AccentPaletteKey.Key -Value ([byte[]]$hexified) -Force
}


<#MotionAccentId_v1.00 Key
$MotionAccentIdKey = @{
	Key   = 'MotionAccentId_v1.00';
	Type  = "DWORD";
	Value = '0x000000db'
}

If ($Null -eq (Get-ItemProperty -Path $RegPath -Name $MotionAccentIdKey.Key -ErrorAction SilentlyContinue))
{
	New-ItemProperty -Path $RegPath -Name $MotionAccentIdKey.Key -Value $MotionAccentIdKey.Value -PropertyType $MotionAccentIdKey.Type -Force
}
Else
{
	Set-ItemProperty -Path $RegPath -Name $MotionAccentIdKey.Key -Value $MotionAccentIdKey.Value -Force
}
#>

#Start Color Menu Key
$StartMenuKey = @{
	Key   = 'StartColorMenu';
	Type  = "DWORD";
	Value = '0xff1e0ed2'
}

If ($Null -eq (Get-ItemProperty -Path $RegPath -Name $StartMenuKey.Key -ErrorAction SilentlyContinue))
{
	New-ItemProperty -Path $RegPath -Name $StartMenuKey.Key -Value $StartMenuKey.Value -PropertyType $StartMenuKey.Type -Force
}
Else
{
	Set-ItemProperty -Path $RegPath -Name $StartMenuKey.Key -Value $StartMenuKey.Value -Force
}

#Stop-Process -ProcessName explorer -Force -ErrorAction SilentlyContinue