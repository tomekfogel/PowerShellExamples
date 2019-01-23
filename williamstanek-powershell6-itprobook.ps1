
c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\checkit.ps1
************************************************************************
function scheck {param ($status)
 Begin {
  Write-Warning "############### Services on $env:computername"
 }
 Process {
  get-service | where { $_.status -eq $status} 
 }
 End {
  Write-Warning "########################################"
 }
}
if ($args[0] = "scheck") {scheck $args[1]}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\checkit2.ps1
************************************************************************
function scheck {param ($status = $args[0])
 Begin {
  Write-Warning "############### Services on $env:computername"
 }
 Process {
  get-service | where { $_.status -eq $status} 
 }
 End {
  Write-Warning "########################################"
 }
}
scheck



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\eventlogs.ps1
************************************************************************
$share = "\\FileServer85\logs"
$logs = "system","application","security"

foreach ($log in $logs) {
  $filename = "$env:computername".ToUpper() + "$log" + "log" + `
(get-date -format yyyyMMdd) + ".log"
  Get-EventLog $log | set-content $share\$filename
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\eventlogs2.ps1
************************************************************************
$share = "\\FileServer85\logs"
$logs = "system","application","security"

foreach ($log in $logs) {
  $filename = "$env:computername".ToUpper() + "$log" + "log" + `
(get-date -format yyyyMMdd) + ".log"
  Get-EventLog $log | set-content $share\$filename
}


