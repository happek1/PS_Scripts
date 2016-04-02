#Gets pending updates of local machine

Write-Host 'Obtaining Pending Update Information, please wait.'  

 #Get All Assigned updates in $SearchResult  
 $UpdateSession = New-Object -ComObject Microsoft.Update.Session  
 $UpdateSearcher = $UpdateSession.CreateUpdateSearcher()  
 $SearchResult = $UpdateSearcher.Search("IsAssigned=1 and IsHidden=0 and IsInstalled=0") 
   
 #Pending Updates Tally 
 Write-Host "===== Pending Updates ====="
 For($i=0;$i -lt $SearchResult.Updates.Count; $i++)  
 {  Write-Host "KB$($SearchResult.Updates.Item($i).KBArticleIDs)" } 
 Write-Host "Pending $($searchresult.Updates.Count)"