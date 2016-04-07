##run the following line once from a powershell window to create the eventlog application to allow the event to be writen
###New-EventLog –LogName Application –Source “Monitor SSH Connection”
function Get-NetStat
{
<#
.SYNOPSIS
    This function will get the output of netstat -n and parse the output 
.DESCRIPTION
    This function will check for a connection between two servers over a specfic port. If the connection is made it will write an event to the Application log
#>
    PROCESS
    {
        # Get the output of netstat
        $data = netstat -n
        
        # Keep only the line with the data (we remove the first lines)
        $data = $data[4..$data.count]
        
        # Each line need to be splitted and get rid of unnecessary spaces
        foreach ($line in $data)
        {
            # Get rid of the first whitespaces, at the beginning of the line
            $line = $line -replace '^\s+', ''
            
            # Split each property on whitespaces block
            $line = $line -split '\s+'
            
            # Define the properties
            $properties = @{
                Protocole = $line[0]
                LocalAddressIP = ($line[1] -split ":")[0]
                LocalAddressPort = ($line[1] -split ":")[1]
                ForeignAddressIP = ($line[2] -split ":")[0]
                ForeignAddressPort = ($line[2] -split ":")[1]
                State = $line[3]
            }
            
            # Output the current line
            New-Object -TypeName PSObject -Property $properties
        }
    }
}
IF (Get-NetStat | Where-Object -Property ForeignAddressPort -eq 445 | Where-Object -Property ForeignAddressIP -eq 192.168.0.0) {Write-EventLog –LogName Application –Source “Monitor SSH Connection” –EntryType Error –EventID 1 –Message “Error! Connection exsist to Server1 over port 443 ”}
