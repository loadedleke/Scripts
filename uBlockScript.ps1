# uBlock Microsoft Edge Origin Config (Registry Add)
$Path01 = "HKLM:\Software\Policies\Microsoft\Edge\3rdparty\Extensions\odfafepnkmbhccpbejgmiehpchacaeak\policy"

If (-Not (Test-Path -Path $Path01)) { New-Item -Force -Path $Path01 }

# adminSettings
$adminSettings = @{
    "Force" = $true
    "Path"  = "$Path01"
    "Type"  = "String"
    "Name"  = "adminSettings"
    "Value" = '{ "userSettings": { "collapseBlocked": true, "tooltipsDisabled": false, "parseAllABPHideFilters": true, "prefetchingDisabled": true, "autoUpdate": true,"contextMenuEnabled": true, "showIconBadge": true, "hyperlinkAuditingDisabled": true }, "selectedFilterLists": [ "user-filters","ublock-filters","ublock-badware","ublock-privacy","ublock-quick-fixes","ublock-abuse","ublock-unbreak","adguard-generic","adguard-mobile","easylist","adguard-spyware-url","block-lan","easyprivacy","urlhaus-1","curben-phishing","curben-pup","adguard-annoyance","adguard-social","fanboy-thirdparty_social","fanboy-cookiemonster","fanboy-annoyance","fanboy-social","ublock-annoyances","dpollock-0","plowe-0"], "whitelist": [ "about-scheme", "chrome-extension-scheme", "chrome-scheme", "edge-scheme", "moz-extension-scheme", "opera-scheme", "vivaldi-scheme", "wyciwyg-scheme", "williamsf1.com", "adobe.com" ], "userFilters": "" }'
}
Set-ItemProperty @adminSettings



# uBlock Google Chrome Origin Config (Registry Add)
$Path01 = "HKLM:\Software\Policies\Microsoft\Edge\3rdparty\Extensions\odfafepnkmbhccpbejgmiehpchacaeak\policy"

If (-Not (Test-Path -Path $Path01)) { New-Item -Force -Path $Path01 }

# adminSettings
$adminSettings = @{
    "Force" = $true
    "Path"  = "$Path01"
    "Type"  = "String"
    "Name"  = "adminSettings"
    "Value" = '{ "userSettings": { "contextMenuEnabled": false, "showIconBadge": false }, "selectedFilterLists": [ "user-filters", "ublock-filters", "ublock-badware", "ublock-privacy", "ublock-abuse", "ublock-unbreak", "easylist", "easyprivacy", "urlhaus-1", "adguard-annoyance", "ublock-annoyances", "plowe-0" ], "whitelist": [ "about-scheme", "chrome-extension-scheme", "chrome-scheme", "edge-scheme", "moz-extension-scheme", "opera-scheme", "vivaldi-scheme", "wyciwyg-scheme", "williamsf1.com", "adobe.com" ], "userFilters": "" }'
}
Set-ItemProperty @adminSettings
