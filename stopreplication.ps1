<#
.SYNOPSIS
    Stop services on multiple servers
.DESCRIPTION
    Creates sessions to servers specificed in a text file and start a service, then checks and outputs the status
#>
﻿$rs = Get-Content .\drexch.txt | New-PSSession
invoke-Command -Session $rs -ScriptBlock {net stop spooler} -AsJob
Sleep -Seconds 5
invoke-Command -ScriptBlock {gsv spooler} -Session $rs | Format-Table
get-pssession | remove-pssession
