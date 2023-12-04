[reflection.assembly]::loadwithpartialname('System.Windows.Forms')
[reflection.assembly]::loadwithpartialname('System.Drawing')
$notify = new-object system.windows.forms.notifyicon
$notify.icon = [System.Drawing.SystemIcons]::Information
$notify.visible = $true
$notify.showballoontip(10,'WARNING','Automatically logoff after 1 hour of inactivity',[system.windows.forms.tooltipicon]::None)

powershell -WindowStyle hidden -Command "[reflection.assembly]::loadwithpartialname('System.Windows.Forms');[reflection.assembly]::loadwithpartialname('System.Drawing');$notify = new-object system.windows.forms.notifyicon;$notify.icon = [System.Drawing.SystemIcons]::Information;$notify.visible = $true;$notify.showballoontip(10,'WARNING','Automatically logoff after 1 hour of inactivity',[system.windows.forms.tooltipicon]::None)"