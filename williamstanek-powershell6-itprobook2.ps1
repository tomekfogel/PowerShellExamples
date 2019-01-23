
c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\args-count-example.txt
************************************************************************
$argCount = $args.Count
$firstArg = $args[0]
$secondArg = $args[1]
$lastArg = $args[$args.Count -1]



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\array-collectionexamples.txt
************************************************************************
$myFirstNumber = 10
$mySecondNumber = 500
$myFirstArray = 0,1,2,3,4,8,13,21
$mySecondArray = 1..9
$myString = "Hello!"
$myObjectCollection1 = get-service
$myObjectCollection2 = get-process –name svchost



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\basic-operator-examples.txt
************************************************************************
$Remainder = 12 % 4
$Remainder = 10 % 3

$Answer = -5 * 3

$a = {Get-Process –id 0}
&$a

$a = (5 + 4) * 2; $a


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\basic-operator-examples2.txt
************************************************************************
$($p= "win*"; get-process $p)

@(get-date;$env:computername;$env:logonserver)

5 + 4 * 2 outputs 13

10 / 10 + 6 outputs 7




c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\cimclass.txt
************************************************************************
$dd = get-cimclass win32_logicaldisk
$dd.cimclassmethods
$dd.cimclassproperties



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\ciminstance.txt
************************************************************************
$dd = get-ciminstance -class win32_logicaldisk
$dd | fl



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\ciminstance2.txt
************************************************************************
$dd = get-ciminstance -class win32_logicaldisk -filter 'deviceid = "c:"'



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\ciminstance3.txt
************************************************************************
$dd = get-ciminstance -query 'Select * from Win32_OperatingSystem where Version like "%10.0%"'


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\com-excel-example.txt
************************************************************************
$a = New-Object -comobject "Excel.Application"
$a.Visible = $True
$wb = $a.workbooks.add()
$ws = $wb.worksheets.item(1)

$ws.cells.item(1,1) = "Computer Name"
$ws.cells.item(1,2) = "Location"
$ws.cells.item(1,3) = "OS Type"
$ws.cells.item(2,1) = "TechPC84"
$ws.cells.item(2,2) = "5th Floor"
$ws.cells.item(2,3) = "Windows 8.1"

$a.activeworkbook.saveas("c:\data\myws.xls")



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comobject-example.txt
************************************************************************
$shell = new-object -comobject shell.application
$shell.windows() | select-object locationname


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comobject-example2.txt
************************************************************************
$shell = new-object -comobject shell.application
$shell.windows() | select-object



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comobject-example3.txt
************************************************************************
$iexp = new-object –comobject "InternetExplorer.Application"
$iexp.navigate("https://www.facebook.com/William.Stanek.Author/")
$iexp.visible = $true



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comparison-operator.txt
************************************************************************
$a = 5; $b = 6
$a –eq $b



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comparison-operator2.txt
************************************************************************
$a = 5; $b = 6
$a –ne $b



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comparison-operator3.txt
************************************************************************
$a = 5; $b = 6
$a –lt $b



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comparison-operator4.txt
************************************************************************
$a = "svchost", "iexplorer", "powershell"; $b = "iexplorer"
$a –ne $b



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comparison-operator5.txt
************************************************************************
$a = "svchost", "iexplorer", "powershell"; $b = "iexplorer"
$a –ne $b



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comparison-operator6.txt
************************************************************************
$a = "svchost", "iexplorer", "powershell"
$a –contains "winlogon"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comparison-operator7.txt
************************************************************************
$a = "svchost"
$a –like "*host"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\comparison-operator8.txt
************************************************************************
$a = "svchost"
$a –match "[stu]"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\com-reflection-assembly-examples.txt
************************************************************************
[Reflection.Assembly]::LoadWithPartialName("ClassName")

[Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

[Reflection.Assembly]::LoadWithPartialName ("System.Windows.Forms") | format-list




c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\concat-string.txt
************************************************************************
$streetAdd = "123 Main St."
$cityState = "Anywhere, NY"
$zipCode = "12345"
$custAddress = $streetAdd + " " + $cityState + " " + $zipCode
$custAddress



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\connect-session.txt
************************************************************************
Get-PSSession –ComputerName Server74, Server38, Server45 –Credential Imaginedl\WilliamS | Connect-PSSession



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\connect-session2.txt
************************************************************************
$s = Get-PSSession –ComputerName Server74, Server38, Server45 –Credential Imaginedl\WilliamS | Connect-PSSession



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\data-string.txt
************************************************************************
DATA StringName {
   StringText
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\data-string2.txt
************************************************************************
DATA MyValues {
  "This is a data string."
  "You can use data strings in many different ways."
}

Write-Host $MyValues


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\data-string3.txt
************************************************************************
DATA StringName [-supportedCommand CmdletNames] { PermittedContent }



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\data-string4.txt
************************************************************************
DATA DisplayNotes {
  ConvertFrom-StringData -stringdata @'
  Note1 = This appears to be the wrong syntax.
  Note2 = There is a value missing.
  Note3 = Cannot connect at this time.
  '@ }



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\disconnect-session.txt
************************************************************************
$s = new-pssession –computername corpserver74
invoke-command -session $s { get-process }

. . .

disconnect-pssession –session $s



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\escape-codes-example.txt
************************************************************************
$s = "Please specify the computer name `t []"
$c = read-host $s
write-host "You entered: `t $c"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\eventlog-example.txt
************************************************************************
$log = new-object -type system.diagnostics.eventlog -argumentlist application



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\for-each-input-example.txt
************************************************************************
foreach($element in $input) { "The input was: `t $element" }


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-get-service.txt
************************************************************************
function ss {param ($status) get-service | where { $_.status -eq $status} }


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-getwinrm.txt
************************************************************************
function getwinrm {get-service -name winrm | format-list}


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-numservices.txt
************************************************************************
function numservices {$serv = get-service}
numservices
write-host "The number of services is: `t" $serv.count



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-numservices2.txt
************************************************************************
function numservices {$Global:serv = get-service}
numservices
write-host "The number of services is: `t" $serv.count



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-numservices3.txt
************************************************************************
function numservices {$Script:serv1 = get-service}
numservices
write-host "The number of services is: `t" $serv1.count



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-numservices4.txt
************************************************************************
function numservices {$Private:serv = get-service

write-host "The number of services is: `t" $serv.count

 &{write-host "Again, the number of services is: `t" $serv.count}

}
numservices



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-prompt1.txt
************************************************************************
function prompt {"PS [$env:computername]> "}


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-prompt2.txt
************************************************************************
function prompt {
$(if (test-path variable:/PSDebugContext) { '[DBG]: ' }
else { '' }) + 'PS ' + $(Get-Location)
+ $(if ($nestedpromptlevel -ge 1) { '>>' }) + '> '
}


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-prompt3.txt
************************************************************************
function prompt {
$(if (test-path variable:/PSDebugContext) { '[DBG]: ' }
else { '' }) + "$(get-date)> "
+ $(if ($nestedpromptlevel -ge 1) { '>>' }) + '> '
}


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-prompt4.txt
************************************************************************
function prompt {
$(if (test-path variable:/PSDebugContext) { '[DBG]: ' }
else { '' }) + "PS [$env:computername]> "
+ $(if ($nestedpromptlevel -ge 1) { '>>' }) + '> '
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-scheck.txt
************************************************************************
function scheck {
param ($status)
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



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\function-set-windowsize.txt
************************************************************************
function set-windowsize {
param([int]$width=$host.ui.rawui.windowsize.width, 
[int]$height=$host.ui.rawui.windowsize.height)

$size=New-Object System.Management.Automation.Host.Size($width,$height);

$host.ui.rawui.WindowSize=$size
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\get-item-kb-example.txt
************************************************************************
get-item c:\data\* | where-object {$_.length -gt 100kb}


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\get-process-powershell.txt
************************************************************************
$proc = get-process powershell;

$proc | add-member -Type scriptproperty "UpTime" {return ((date)  - ($this.starttime))};

$proc | select Name, @{name='Uptime'; Expression={"{0:n0}" -f $_.UpTime.TotalMinutes}};



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\get-process-remote-computer.txt
************************************************************************
$procs = {get-process -computername Server56, Server42, Server27 | sort-object -property Name}

&$procs | format-table Name, Handles, WS, CPU, MachineName –auto



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\get-psdrive-example.txt
************************************************************************
$myDrive = get-psdrive C

$myDrive | add-member -membertype scriptmethod -name Remove -value { $force = [bool] $args[0];
 if ($force) {$this | Remove-PSDrive }
 else {$this | Remove-PSDrive -Confirm}
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\get-win32process.txt
************************************************************************
$pr = Get-WmiObject Win32_Process | where-object { $_.ProcessName -eq "winlogon.exe" }


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\get-wmiobject-examples.txt
************************************************************************
Get-WmiObject -Class Win32_OperatingSystem -Namespace root/cimv2  -ComputerName . | Format-List * 

Get-WmiObject -Class Win32_OperatingSystem -Namespace root/cimv2 -ComputerName . | Format-List * > os_save.txt

Get-WmiObject -Class Win32_ComputerSystem -Namespace root/cimv2 -ComputerName . | Format-List *



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\host-ui-example.txt
************************************************************************
$host.ui.rawui | format-list –property *


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\if-get-psprovider.txt
************************************************************************
If (get-psprovider -psprovider wsman -erroraction silentlycontinue)
 { Code to execute if the provider is available.

 } else { Code to execute if the provider is not available. }



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\invoke-command.txt
************************************************************************
invoke-command -computername Server43, Server27, Server82 -scriptblock {get-process}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\invoke-command2.txt
************************************************************************
$procs = invoke-command -script {get-process | sort-object -property Name} -computername Server56, Server42, Server27

&$procs | format-table Name, Handles, WS, CPU, PSComputerName –auto



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\invoke-command-start-job.txt
************************************************************************
$s = new-pssession -computername fileserver34, dataserver18

$j = invoke-command –session $s {start-job –filepath c:\scripts\elogs.ps1}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\joined-array.txt
************************************************************************
$array1 = "PC85", "PC25", "PC92"
$array2 = "SERVER41", "SERVER32", "SERVER87"

$joinedArray = $array1 + $array2
$joinedArray



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\listing6-1.txt
************************************************************************
function prompt {"PS $(get-location) [$env:computername]> "}

new-alias gr getwinrm 
new-alias gs gets 
new-alias inv inventory
function getwinrm {
   get-service -name winrm | format-list
}

function gets {param ($status) 
   get-service | where { $_.status -eq $status} 
}

function inventory {param ($name = ".")
   get-wmiobject -class win32_operatingsystem -namespace root/cimv2 -computername $name | format-list *
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\listing6-2.txt
************************************************************************
function global:prompt {"PS $(get-location) [$env:computername]> "}

new-alias gr getwinrm -scope global
new-alias gs gets -scope global
new-alias inv inventory -scope global

function global:getwinrm {
   get-service -name winrm | format-list
}

function global:gets {param ($status) 
   get-service | where { $_.status -eq $status} 
}

function global:inventory {param ($name = ".")
   get-wmiobject -class win32_operatingsystem -namespace root/cimv2 -computername $name | format-list *
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\multilinestring.txt
************************************************************************
$myString = @"
=========================
$env:computername
=========================
"@
write-host $myString



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\mydriveinfo-examples.txt
************************************************************************
$myDriveInfo | add-member -membertype aliasproperty -name Free -value AvailableFreeSpace

$myDriveInfo | add-member -membertype aliasproperty -name Format -value DriveFormat

$myDriveInfo.AvailableFreeSpace

$myDriveInfo.Free

$myDriveInfo | format-table –property Name, Free, Format



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\myhostwin-examples.txt
************************************************************************
$myHostWin.ForegroundColor = "White"
 
$myHostWin.BackgroundColor = "DarkGray"

$myHostWin.WindowTitle = "PowerShell on $env.computername"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\mynumber-example.txt
************************************************************************
$myNumber = 52

$myNumber += "William"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\mynumber-example2.txt
************************************************************************
$myNumber = 505
$myString = $myNumber.ToString()
$myString.GetType()



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\mystring-examples.txt
************************************************************************
$myString = "String 1"
$myVar = "String 2"
$myObjects = "String 3"
$s = "String 4"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\myvarstring-examples.txt
************************************************************************
${my.var} = "String 1"
${my-var} = "String 2"
${my:var} = "String 3"
${my(var)} = "String 4"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-job-schedule-option.txt
************************************************************************
$opts = New-ScheduledJobOption -MultipleInstancePolicy Parallel -StartIfOnBattery -ContinueIfGoingOnBattery



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-job-schedule-option2.txt
************************************************************************
$joptions = New-ScheduledJobOption –StartIfIdle –StopIfGoingOffIdle -RestartOnIdleResume



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-job-trigger.txt
************************************************************************
$etwt = New-JobTrigger –Weekly –WeeksInterval 1 –DaysOfWeek Monday, Thursday –At "June 25, 2018 1:00:00 AM"


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-job-trigger2.txt
************************************************************************
$eodt = New-JobTrigger –Daily –DaysInterval 2 –At "July 2, 2018 5:00:00 AM"


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-job-trigger3.txt
************************************************************************
$rt = New-JobTrigger –Once –RepeatIndefinitely –RepetitionInterval 00:03:00 –At "December 21, 2018 6:30:00 AM"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-job-trigger4.txt
************************************************************************
$rt = New-JobTrigger –Once –RepetitionDuration 5.00:00:00 –RepetitionInterval 00:03:00 –At "December 21, 2018 6:30:00 AM"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-pssession.txt
************************************************************************
$t = New-PSSession –ComputerName Server24, Server45, Server36 –Credential imaginedl\WilliamS



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-pssession2.txt
************************************************************************
$ses = get-content c:\test\servers.txt | new-pssession –credential imaginedl\williams



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-pssession3.txt
************************************************************************
$comp = get-content c:\computers.txt
$s = new-pssession -computername $comp
invoke-command -session $s { powercfg.exe –energy }



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-pssession4.txt
************************************************************************
$comp = get-content c:\computers.txt
$s = new-pssession -computername $comp
invoke-command -session $s { powercfg.exe –energy –output "\\fileserver72\reports\$env:computername.html"}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-pssession5.txt
************************************************************************
invoke-command –session $s -scriptblock {get-process moddr | stop-process -force } -AsJob



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-pssession-authentication.txt
************************************************************************
$Cred = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://server17.imaginedlands.com/PowerShell/ -AllowRedirection -Authentication Negotiate -Credential $Cred 


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-pssession-kerberos.txt
************************************************************************
$Session = New-PSSession -ConfigurationName Windows.PowerShell -ConnectionUri http://Server24.imaginedlands.com/PowerShell/ -AllowRedirection -Authentication Kerberos



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-pssession-redirection.txt
************************************************************************
$Cred = Get-Credential

$Session = New-PSSession -ConfigurationName Windows.PowerShell -ConnectionUri http://Server24.imaginedlands.com/PowerShell/ -AllowRedirection -Authentication Kerberos -Credential $Cred



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-selfsignedcertificate.txt
************************************************************************
New-SelfSignedCertificate -CertStoreLocation cert:\currentuser\my -Subject "CN=Code Signing Cert" -Type CodeSigningCert -KeyLength 4096 -KeyAlgorithm RSA -KeyExportPolicy Exportable -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" -KeyUsage DigitalSignature


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\new-wsmaninstance.txt
************************************************************************
$thumbprint = "XXX-XXXX-XX-XXXX-XX"
New-WSManInstance -ResourceURI winrm/config/Listener -SelectorSet @{Transport='HTTPS', Address="IP:192.168.10.34"} -ValueSet @{Hostname="Server12.Imaginedlands.com",CertificateThumbprint=$thumprint}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\number-array.txt
************************************************************************
$myArray = @(3, 6, 9, 12, 15, 18, 21)


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\receive-job.txt
************************************************************************
receive-job –name Job1 >> c:\logs\mylog.txt
receive-job –name Job2 >> c:\logs\mylog.txt
receive-job –name Job3 >> c:\logs\mylog.txt



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\receive-job-view-file.txt
************************************************************************
$ms = new-pssession -computername fileserver84

invoke-command -session $ms -scriptblock {get-content c:\logs\mylog.txt}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\regex.txt
************************************************************************
[regex]$regex="^([a-zA-Z]*)$"


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\regex2.txt
************************************************************************
$a = "Tuesday"

[regex]$regex="^([a-zA-Z]*)$"

$regex.ismatch($a)



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\regex3.txt
************************************************************************
$days ="Monday Tuesday"

[regex]$regex="^([a-zA-Z]*)$"

$regex.ismatch($days)



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\regex4.txt
************************************************************************
$a = "svchost", "iexplorer", "loghost"

$a –replace "host", "console"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\register-scheduled-job.txt
************************************************************************
$tr = New-JobTrigger –Weekly –WeeksInterval 4 –DaysOfWeek Tuesday, Thursday –At "December 5, 2017 5:00:00 AM"

$opts = New-ScheduledJobOption –StartIfOnBattery -ContinueIfGoingOnBattery -RunElevated

Register-ScheduledJob -Name SysChecks -ScriptBlock { get-process > ./processes.txt; get-eventlog system > ./events.txt} -ScheduledJobOption $opts –Trigger $tr



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\register-scheduled-job2.txt
************************************************************************
Register-ScheduledJob -Name SysChecks –FilePath D:\Scripts\SysChecks.ps1 –ScheduledJobOption $opts –Trigger $tr



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\register-scheduled-job3.txt
************************************************************************
Register-ScheduledJob -Name SysChecks –FilePath \\Server48\Scripts\SysChecks.ps1 –ScheduledJobOption $opts –Trigger $tr




c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\register-scheduled-job4.txt
************************************************************************
$cred = Get-Credential

$ses = New-PSSession -ComputerName (Get-Content .\Computers.txt) -Credential $cred

invoke-command -session $s { $tr = New-JobTrigger –Daily –DaysInterval 2 –At "October 31, 2018 5:00:00 AM"; $opt = New-ScheduledJobOption –StopIfGoingOffIdle –StartIfIdle -RestartOnIdleResume; Register-ScheduledJob -Name SysChecks -FilePath "\\Server33\Scripts\CheckSys.ps1" -ScheduledJobOption $opts –Trigger $tr}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\register-scheduled-job5.txt
************************************************************************
$cred = Get-Credential

$ses = New-PSSession -ComputerName (Get-Content .\Computers.txt) -Credential $cred

Import-PSSession –Session $ses -AllowClobber

$tr = New-JobTrigger –Daily –DaysInterval 2 –At "November 1, 2018 4:30:00 AM"

$opt = New-ScheduledJobOption –StopIfGoingOffIdle –StartIfIdle -RestartOnIdleResume

Register-ScheduledJob -Name SysChecks –FilePath "\\Server33\Scripts\CheckSys.ps1" –ScheduledJobOption $opts –Trigger $tr



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\run-job-interactive.txt
************************************************************************
$s = new-pssession -computername fileserver34, dataserver18

Invoke-command –session $s -asjob -scriptblock {$share = "\\FileServer85\logs"; $logs = "system","application","security"; foreach ($log in $logs) { $filename = "$env:computername".ToUpper() + "$log" + "log" + (get-date -format yyyyMMdd) + ".log"; Get-EventLog $log | set-content $share\$filename; }
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\run-job-interactive2.txt
************************************************************************
$s = new-pssession -computername fileserver34, dataserver18 `

Invoke-command –session $s `
-asjob -scriptblock {$share = "\\FileServer85\logs"; `
$logs = "system","application","security"; `
foreach ($log in $logs) { `
$filename = "$env:computername".ToUpper() + "$log" + "log" + `
(get-date -format yyyyMMdd) + ".log"; `
Get-EventLog $log | set-content $share\$filename; } `
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\speech-api-example.txt
************************************************************************
$v = new-object -comobject "SAPI.SPVoice"
$v.speak("Well, hello there. How are you?")



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\starting-jobs.txt
************************************************************************
$job = start-job -scriptblock {$share = "\\FileServer85\logs";
$logs = "system","application","security";

foreach ($log in $logs) { $filename = "$env:computername".ToUpper() + "$log" + "log" + (get-date -format yyyyMMdd) + ".log"; Get-EventLog $log | set-content $share\$filename; }
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\starting-jobs2.txt
************************************************************************
$job = start-job -scriptblock {$share = "\\FileServer85\logs"; `
$logs = "system","application","security"; `

foreach ($log in $logs) { `
$filename = "$env:computername".ToUpper() + "$log" + "log" + `
(get-date -format yyyyMMdd) + ".log"; `
Get-EventLog $log | set-content $share\$filename; } `
}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\store-result-evaluate.txt
************************************************************************
$theFirstResult = 10 + 10 + 10

$theSecondResult = $(if($theFirstResult –gt 25) {$true} else {$false})

write-host "$theFirstResult is greater than 25? `t $theSecondResult"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\store-session-object.txt
************************************************************************
$session = get-pssession –id 2, 3, 12

invoke-command -session $session { get-eventlog system | where {$_.entrytype -eq "Error"} }



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\str-array.txt
************************************************************************
$string = @'
  Note1 = This appears to be the wrong syntax.
  Note2 = There is a value missing.
  Note3 = Cannot connect at this time.
  '@

$strArray = $string | convertfrom-stringdata



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\string-array.txt
************************************************************************
$myStringArray = "This", "That", "Why", "When", "How", "Where"


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\string-formatting-instructions.txt
************************************************************************
'{2} {1} {0}' -f "Monday", "Tuesday", "Wednesday"


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\string-join.txt
************************************************************************
$a = "abc", "def", "ghi" –join ":"
$a



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\string-multiplication.txt
************************************************************************
$separator = "+"
$sepLine = $separator * 60
$sepLine



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\string-split.txt
************************************************************************
$a = "jkl:mno:pqr"
$a -Split ":"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\where-object.txt
************************************************************************
get-process | where-object {$_.Name –match "svchost"}


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\where-object2.txt
************************************************************************
get-process | where-object {$_.Name –match "^s.*"}


c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\wmi-get-wmiobject-examples.txt
************************************************************************
Get-WmiObject –list -Namespace root/cimv2 -ComputerName . | Format-List name

Get-WmiObject –list -Namespace root/cimv2 -ComputerName . |  Format-List name > FullWMIObjectList.txt

Get-WmiObject -list | where {$_.name -like "*Win32_*"}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\wmi-win32-logical-disk.txt
************************************************************************
get-wmiobject -query 'Select * from Win32_LogicalDisk where (Name = "C:" OR Name = "D:"  OR Name = "G:" ) AND DriveType = 3 AND FreeSpace > 104857600 AND FileSystem = "NTFS"'



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\wmi-win32-logical-disk2.txt
************************************************************************
Get-WmiObject -Class Win32_LogicalDisk -Namespace root/cimv2 -ComputerName . | Format-List * 



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\wmi-win32-physical-memory.txt
************************************************************************
if (get-wmiobject -query "Select * from Win32_PhysicalMemoryArray where MaxCapacity > 262000") {write-host $env:computername}



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\write-host.txt
************************************************************************
$varA = 200
Write-Host 'The value of $varA is $varA.'



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\write-host2.txt
************************************************************************
$varA = 200
Write-Host "The value of $varA is $varA."



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\write-string.txt
************************************************************************
$company = "XYZ Company"
Write-Host "The company is: $company"



c:\users\rocky\desktop\powershell books examples\williamstanek-powershell6-itprobook\wsh-example.txt
************************************************************************
$spath = "$Home\Desktop\PowerShellHome.lnk"
$WshShell = New-Object -ComObject WScript.Shell
$scut = $WshShell.CreateShortcut($spath)
$scut.TargetPath = $PSHome
$scut.Save()


