#Connect-ExchangeOnline 
$UPNS = Import-Csv -Path "C:\Users\AdelekeOgunbela\OneDrive - Dorilton Capital\Scripts\CorpiOS_DL.csv" | foreach {
 $UPN = $_.UPN
 Write-Progress -Activity "Adding $UPN to group… " 
 Add-DistributionGroupMember –Identity "corpdevice.ios.users@alcority.com" -Member $UPN  
 If($?)  
 {  
 Write-Host $UPN Successfully added -ForegroundColor Green 
 }  
 Else  
 {  
 Write-Host $UPN - Error occurred –ForegroundColor Red  
 }  
} 