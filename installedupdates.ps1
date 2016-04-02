##Scripts prompt for computer name and runs scan on patches installed on selected date##
Do {
##SUB VB Object to prompt for computer name##
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$Server = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a Server name", "Server", "$env:servername") 
##SUB WMI Object to prompt for Sdate window##
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form 

$form.Text = "Select a Start Date" 
$form.Size = New-Object Drawing.Size @(268,235) 
$form.StartPosition = "CenterScreen"

$calendar = New-Object System.Windows.Forms.MonthCalendar 
$calendar.ShowTodayCircle = $False
$calendar.MaxSelectionCount = 1
$form.Controls.Add($calendar) 

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(38,165)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(113,165)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$form.Topmost = $True

$result = $form.ShowDialog() 

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $sdate = $calendar.SelectionStart
    }
##SUB WMI Object to prompt for edate window##
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form 

$form.Text = "Select an End Date" 
$form.Size = New-Object Drawing.Size @(268,235) 
$form.StartPosition = "CenterScreen"

$ecalendar = New-Object System.Windows.Forms.MonthCalendar 
$ecalendar.ShowTodayCircle = $False
$ecalendar.MaxSelectionCount = 1
$form.Controls.Add($ecalendar) 

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(38,165)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(113,165)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$form.Topmost = $True

$result = $form.ShowDialog() 

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $edate = $ecalendar.SelectionStart
    }
#scanning server on date field 
Write-Host "Scanning for Hotfixes on $Server installed between $($sdate.ToShortDateString()) and $($edate.ToShortDateString())"
Get-HotFix -computername $Server | where { $_.installedon -ge "$sDate"} | Where { $_.installedon -le "$eDate"} | select hotfixid
#Write-Host EDate = $sdate
#Write-Host SDate = $edate
$Response = read-host "Repeat Y or N?"
}
while ($response -eq "Y")
Stop-process $pid
