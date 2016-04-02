$rs = Get-Content .\drexch.txt | New-PSSession
invoke-Command -Session $rs -ScriptBlock {net stop spooler} -AsJob
Sleep -Seconds 5
invoke-Command -ScriptBlock {gsv spooler} -Session $rs | Format-Table
get-pssession | remove-pssession