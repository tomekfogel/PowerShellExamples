
c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter02\B06457_02_code.ps1
************************************************************************
﻿###################################################################
# Chapter 2 - Code File
###################################################################


###################################################################
# Example On How To Create a Sample Comment Block
###################################################################

<#
.SYNOPSIS
This is a server discovery script which will scan different server components to determine
the current configuration.

.DESCRIPTION
This script will scan processes, Windows services, scheduled tasks, server features, disk information,
registry, and files for pertinent server information.

Author: Brenton J.W. Blawat / Packt Publishing / Author / email@email.com
Revision: 2.1a - Initial Release of Script / 6-22-2018
Revision: 2.5 - Paul Brandes / Company XYZ / Consultant / email@company.com / 11-21-2018
R2.5 details: Updated script to support systems still running PowerShell 2.0.

.PARAMETER SDD
This script requires a server side decryptor as a parameter to the script.

.EXAMPLE
powershellscript.ps1 /SDD "ServerSideDecryptor"

.NOTES
You must have administrative rights to the server you are scanning. Certain functions will not work properly
without running the script as system or administrator.
#>

###################################################################
# Example On How To Create a LOG File
###################################################################
$date = (Get-Date -format "yyyyMMddmmss")
$compname = $env:COMPUTERNAME
$logname = $compname + "_" + $date + "_ServerScanScript.log"
$scanlog = "c:\temp\logs\" + $logname 
new-item -path $scanlog -ItemType File -Force

###################################################################
# Example On How To Create a CSV File
###################################################################
$date = (Get-Date -format "yyyyMMddmmss")
$compname = $env:COMPUTERNAME
$logname = $compname + "_" + $date + "_ScanResults.csv"
$scanresults = "c:\temp\logs\" + $logname
new-item -path $scanresults -ItemType File -Force

# Add Content Headers to the CSV File
$csvheader = "ServerName, Classification, Other Data"
Add-Content -path $scanresults -Value $csvheader

###################################################################
# Example On How To Register the Event Source for an Event Log
###################################################################
New-EventLog –LogName Application –Source "WindowsServerScanningScript" -ErrorAction SilentlyContinue
 

#########################################################################
### This logging mechanism will log items to an error log or add items into the CSV File
#########################################################################
function log { param($string, $scnlg, $evntlg)
    # If Y is populated in the second position, add to log file.
    if ($scnlg -like "Y") { 
        Add-content -path $scanlog -Value $string
    }
    # If Y is populated in the third position, Log Item to Event Log As well
    if ($evntlg -like "Y") {
        write-eventlog -logname Application -source "WindowsServerScanningScript" -eventID 1000 -entrytype Information -message "$string"
    }
    # If there are no parameters specified, write to the data collection file (CSV)
    if (!$scnlg) {
       $content = "$env:COMPUTERNAME,$string"
       Add-Content -path $scanresults -Value $content
    }
    # Verbose Logging
    write-host $string
}

$date = Get-Date
log "Starting WindowsServerScanningScript at $date ..." "Y" "Y"
log "Writing a message to the Event Log Only." "N" "Y"
log "ScriptStart,$date"





c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter03\B06457_03_code.ps1
************************************************************************
﻿###################################################################
# Chapter 3 - Code File
###################################################################

###################################################################
# Example On How To Get the Contents in an XML file
###################################################################

[xml] $xml = get-content "C:\temp\POSHScript\Answers.xml"
$xml

###################################################################
# Example On How To Get the Contents of an XML file and Read Tags
###################################################################
[xml] $xml = get-content "C:\temp\POSHScript\Answers.xml"
$ports = $xml.GetElementsByTagName("ports")
$ports | Select Name, Port

###################################################################
# Example On How To Use Dot Notation with the previous code
###################################################################
$ports.Name
$xml.ScriptAnswers.Ports.Name

###################################################################
# Example On How To Read from and XML File
###################################################################
# Answer File Location
$xmlfile = "c:\temp\POSHScript\Scan_Answers.xml"
Function read-xmltag { param($xmlanswers, $xmlextract)
    # Validate that the XML file still exists
    $test = test-path $xmlanswers
    if (!$test) { 
        Write-Error "$xmlanswers not found on the system. Select any key to exit!"
        # Stop the Script for reading the Error Message
        PAUSE
        # Exit the Script
        exit
    }
    # Read XML Data
    [xml] $xml = (get-content $xmlanswers)
    return $xml.GetElementsByTagName("$xmlextract")
}
# Determine Features of Script
$logging = (read-xmltag $xmlfile "verboselog").id
$scanDisks = (read-xmltag $xmlfile "scndisks").id
$scanSchTasks = (read-xmltag $xmlfile "scnschtsks").id
$scanProcess = (read-xmltag $xmlfile "scnproc").id
$scanServices = (read-xmltag $xmlfile "scnsvcs").id
$scanSoftware = (read-xmltag $xmlfile "scnsoft").id
$scanProfiles = (read-xmltag $xmlfile "scnuprof").id
$scanFeatures = (read-xmltag $xmlfile "scnwfeat").id
$scanFiles = (read-xmltag $xmlfile "scnfls").id
$scanWinUpdates = (read-xmltag $xmlfile "scnwupd").id
#Display Features
Write-host "Script Scanning Settings: Verbose Logging: $logging | Scan Disks: $scanDisks | Scan Scheduled Tasks: $scanSchTasks | Scan Processes: $scanProcess | Scan Services: $scanServices | Scan Software: $scanSoftware | Scan Profiles: $scanProfiles | Scan Features: $scanFeatures | Scan Files: $scanFiles | Scan Windows Updates: $scanWinUpdates"

# Intentional Wrong Answer File Path to Display Error
read-xmltag "C:\Temp\POSHScript\DOES_NOT_EXIST.xml" "scndisks"



c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter04\B06457_04_code.ps1
************************************************************************
﻿###################################################################
# Chapter 4 - Code File
###################################################################

###################################################################
# Example On How To Create passwords
###################################################################

Function create-password {
    
    # Declare password variable outside of loop.
    $password = ""

    # For numbers between 33 and 126
    For ($a=33;$a –le 126;$a++) {
        # Add the Ascii text for the ascii number referenced. 
        $ascii += ,[char][byte]$a
    }
    # Generate a random character form the $ascii character set.
    # Repeat 30 times, or create 30 random characters.
    1..30 | ForEach { $password += $ascii | get-random }
    
    # Return the password
    return $password
}
# Create four 30 character passwords
create-password
create-password
create-password
create-password


###################################################################
# Example On How To Load the .NET Assemblies
###################################################################

Write-host "Loading the .NET System.Security Assembly For Encryption"
Add-Type -AssemblyName System.Security -ErrorAction SilentlyContinue -ErrorVariable err
if ($err) {
    Write-host "Error Importing the .NET System.Security Assembly."
    PAUSE
    EXIT
}
# if err is not set, it was successful.
if (!$err) {
    Write-host "Succesfully loaded the .NET System.Security Assembly For Encryption"
}

###################################################################
# Example On How To Encrypt a String using RijndaelManaged Encryption
###################################################################
# Import the System.Security Assembly
Add-Type -AssemblyName System.Security
function Encrypt-String { param($String, $Pass, $salt="CreateAUniqueSalt", $init="CreateAUniqueInit")
    try{
        $r = new-Object System.Security.Cryptography.RijndaelManaged
        $pass = [Text.Encoding]::UTF8.GetBytes($pass)
        $salt = [Text.Encoding]::UTF8.GetBytes($salt)
        $init = [Text.Encoding]::UTF8.GetBytes($init) 

        $r.Key = (new-Object Security.Cryptography.PasswordDeriveBytes $pass, $salt, "SHA1", 50000).GetBytes(32)
        $r.IV = (new-Object Security.Cryptography.SHA1Managed).ComputeHash($init)[0..15]

        $c = $r.CreateEncryptor()
        $ms = new-Object IO.MemoryStream
        $cs = new-Object Security.Cryptography.CryptoStream $ms,$c,"Write"
        $sw = new-Object IO.StreamWriter $cs
        $sw.Write($String)
        $sw.Close()
        $cs.Close()
        $ms.Close()
        $r.Clear()
        [byte[]]$result = $ms.ToArray()
    }
    catch { 
        $err = "Error Occurred Encrypting String: $_"   
    }
    if($err) {
        # Report Back Error
        return $err
    } 
    else {
        return [Convert]::ToBase64String($result)
    }
}
Encrypt-String "Encrypt This String" "A_Complex_Password_With_A_Lot_Of_Characters"

###################################################################
# Example On How To Decrypt a String
###################################################################

Add-Type -AssemblyName System.Security
function Decrypt-String { param($Encrypted, $pass, $salt="CreateAUniqueSalt", $init="CreateAUniqueInit")
   
   if($Encrypted -is [string]){
      $Encrypted = [Convert]::FromBase64String($Encrypted)
   }

   $r = new-Object System.Security.Cryptography.RijndaelManaged
   $pass = [System.Text.Encoding]::UTF8.GetBytes($pass)
   $salt = [System.Text.Encoding]::UTF8.GetBytes($salt)
   $init = [Text.Encoding]::UTF8.GetBytes($init) 
   
   $r.Key = (new-Object Security.Cryptography.PasswordDeriveBytes $pass, $salt, "SHA1", 50000).GetBytes(32)
   $r.IV = (new-Object Security.Cryptography.SHA1Managed).ComputeHash($init)[0..15]

   $d = $r.CreateDecryptor()
   $ms = new-Object IO.MemoryStream @(,$Encrypted)
   $cs = new-Object Security.Cryptography.CryptoStream $ms,$d,"Read"
   $sr = new-Object IO.StreamReader $cs

   try {
       $result = $sr.ReadToEnd()
       $sr.Close()
       $cs.Close()
       $ms.Close()
       $r.Clear()
       Return $result
   }
   Catch {
       Write-host "Error Occurred Decrypting String: Wrong String Used In Script."
   }
}
Decrypt-String "hK7GHaDD1FxknHu03TYAPxbFAAZeJ6KTSHlnSCPpJ7c=" "A_Complex_Password_With_A_Lot_Of_Characters"


###################################################################
# Example On How To Encode a Password
###################################################################
$pass = "A_Complex_Password_With_A_Lot_Of_Characters"
$encodedpass = [System.Text.Encoding]::Unicode.GetBytes($pass)
$encodedvalue = [Convert]::ToBase64String($encodedpass)
$encodedvalue

###################################################################
# Example On How To decode a Password
###################################################################
$encvalue = "QQBfAEMAbwBtAHAAbABlAHgAXwBQAGEAcwBzAHcAbwByAGQAXwBXAGkAdABoAF8AQQBfAEwAbwB0AF8ATwBmAF8AQwBoAGEAcgBhAGMAdABlAHIAcwA="
$encbytes = [System.Convert]::FromBase64String($encvalue)
$decodedvalue = [System.Text.Encoding]::Unicode.GetString($encbytes)
$decodedvalue

############################################################################
# Full example on how to properly decode a string for use in decrypting data
############################################################################
# Cheat Sheet for Script example.
$xmlfile = "c:\temp\Example.xml"
$RTD = "mAF8AQwBoAGEAcgBhAGMAdABlAHIAcwA="

# The script is invoked with the command line of:
# powershell.exe -file "c:\temp\Example.ps1" "c:\temp\Example.xml" "mAF8AQwBoAGEAcgBhAGMAdABlAHIAcwA=" 
param($xmlfile, $RTD)

# Read the XML file for the Answer File Decryptor
[xml] $xml = (get-content $xmlfile)
$AFD = $xml.GetElementsByTagName("AFD").Name

# Define the Script Side Decryptor
$SSD = "QQBfAEMAbwBtAHAAbABlAHgAXwBQAGEAc"

# Combine the Decryptors
$encvalue = $SSD + $AFD + $RTD 
# Decode the values
$encbytes = [System.Convert]::FromBase64String($encvalue)
$decrypt = [System.Text.Encoding]::Unicode.GetString($encbytes)

# Decrypt the string.
Decrypt-String "hK7GHaDD1FxknHu03TYAPxbFAAZeJ6KTSHlnSCPpJ7c=" $decrypt

PAUSE




c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter04\Example.ps1
************************************************************************
﻿# The script is invoked with the command line of:
# powershell.exe -file "c:\temp\Example.ps1" "c:\temp\Example.xml" "mAF8AQwBoAGEAcgBhAGMAdABlAHIAcwA=" 
param($xmlfile, $RTD)

###################################################################
# Example On How To Decrypt a String
###################################################################

Add-Type -AssemblyName System.Security
function Decrypt-String { param($Encrypted, $pass, $salt="CreateAUniqueSalt", $init="CreateAUniqueInit")
   
   if($Encrypted -is [string]){
      $Encrypted = [Convert]::FromBase64String($Encrypted)
   }

   $r = new-Object System.Security.Cryptography.RijndaelManaged
   $pass = [System.Text.Encoding]::UTF8.GetBytes($pass)
   $salt = [System.Text.Encoding]::UTF8.GetBytes($salt)
   $init = [Text.Encoding]::UTF8.GetBytes($init) 
   
   $r.Key = (new-Object Security.Cryptography.PasswordDeriveBytes $pass, $salt, "SHA1", 50000).GetBytes(32)
   $r.IV = (new-Object Security.Cryptography.SHA1Managed).ComputeHash($init)[0..15]

   $d = $r.CreateDecryptor()
   $ms = new-Object IO.MemoryStream @(,$Encrypted)
   $cs = new-Object Security.Cryptography.CryptoStream $ms,$d,"Read"
   $sr = new-Object IO.StreamReader $cs

   try {
       $result = $sr.ReadToEnd()
       $sr.Close()
       $cs.Close()
       $ms.Close()
       $r.Clear()
       Return $result
   }
   Catch {
       Write-host "Error Occurred Decrypting String: Wrong String Used In Script."
   }
}

# Read the XML file for the Answer File Decryptor
[xml] $xml = (get-content $xmlfile)
$AFD = $xml.GetElementsByTagName("AFD").Name

# Define the Script Side Decryptor
$SSD = "QQBfAEMAbwBtAHAAbABlAHgAXwBQAGEAc"

# Combine the Decryptors
$encvalue = $SSD + $AFD + $RTD 
# Decode the values
$encbytes = [System.Convert]::FromBase64String($encvalue)
$decrypt = [System.Text.Encoding]::Unicode.GetString($encbytes)

# Decrypt the string.
Decrypt-String "hK7GHaDD1FxknHu03TYAPxbFAAZeJ6KTSHlnSCPpJ7c=" $decrypt

PAUSE



c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter05\B06457_5_code.ps1
************************************************************************
﻿###################################################################
# Chapter 5 - Code File
###################################################################

###################################################################
# Example On How To Get Service Information
###################################################################
Get-service –DisplayName "Windows Audio"
Get-service –DisplayName "Windows Audio" –RequiredServices
(Get-service –DisplayName "Windows Audio").Status 


###################################################################
# Example On How To Stop and Start Services
###################################################################
stop-service –DisplayName "Windows Audio"
(Get-service –DisplayName "Windows Audio").Status
start-service –DisplayName "Windows Audio"
(Get-service –DisplayName "Windows Audio").Status


###################################################################
# Example On How To Change the Starup Type of a Windows service
###################################################################
(get-wmiobject win32_service –filter "DisplayName='Windows Audio'").StartMode
stop-service –name "Audiosrv"
set-service –name "Audiosrv" –startup "Manual"
(get-wmiobject win32_service –filter "DisplayName='Windows Audio'").StartMode
set-service –name "Audiosrv" –startup "Automatic"
(get-wmiobject win32_service –filter "DisplayName='Windows Audio'" ).StartMode
Start-service –name "Audiosrv"


###################################################################
# Example On How To Change the Description of a Windows Service
###################################################################
$olddesc = (get-wmiobject win32_service –filter "DisplayName='Windows Audio'").description
$olddesc
stop-service –DisplayName "Windows Audio"
Set-service –name "Audiosrv" –Description "My New Windows Audio Description."
(get-wmiobject win32_service –filter "DisplayName='Windows Audio'").description
Set-service –name "Audiosrv" –Description $olddesc
(get-wmiobject win32_service –filter "DisplayName='Windows Audio'").description
start-service –DisplayName "Windows Audio"

###################################################################
# Example On How To Query a Windows Service for the Startup User
###################################################################
$service = get-wmiobject win32_service | where {$_.DisplayName -like "Windows Audio"}
$servicedisplay = $service.DisplayName
$serviceAuthUser = $service.StartName
write-host "Service with $servicedisplay name is running with $serviceAuthUser account."


###################################################################
# Example On How To Search for A Process
###################################################################
$process = get-process powersh*
$process
get-process -id $process.id


###################################################################
# Example On How To View the File Versions of A Process
###################################################################
$process = get-process powersh*
get-process -id $process.id –FileVersionInfo | format-table -AutoSize


###################################################################
# Example On How To View the Modules of a Process
###################################################################
$processes = Get-WmiObject -class win32_process | where {$_.Name -like "powersh*"}
foreach ($process in $processes) {
    $procname = $process.Name
    $procdom = $process.GetOwner().Domain
    $procuser = $process.GetOwner().User
    Write-host "$procname is running with the $procdom\$procuser account."
}


###################################################################
# Example On How To Start a Notepad Process
###################################################################
start-process -FilePath notepad.exe
$process = get-process notepad*


###################################################################
# Example On How To Start and stop a Notepad Process
###################################################################
start-process -FilePath notepad.exe
$process = get-process notepad*
stop-process -ID $process.id


###################################################################
# Example On How To Scan Logged on Users on a system
###################################################################
$users = @()
$processes = Get-WmiObject win32_process
foreach ($process in $processes) {
    $procuser = $process.GetOwner().User
    switch ($process.GetOwner().User) {
        "NETWORK SERVICE" { $continue = "Skip User" }
        "LOCAL SERVICE" { $continue = "Skip User" }
        "SYSTEM" { $continue = "Skip User"}
        "$null" { $continue = "Skip User" }
        default { $continue = "Report User" }
    }
    if ($continue -eq "Report User") {  
    
        $users += $procuser
    }
}
$users | Get-Unique

###################################################################
# Example On How To Convert a SID to Usernames
###################################################################
$sid = "S-1-5-18"
$usersid = New-Object System.Security.Principal.SecurityIdentifier("$SID")
$usersid.Translate( [System.Security.Principal.NTAccount]).Value

###################################################################
# Example On How To Convert a LastUseTime to User-Friendly Formats
###################################################################
$profile = get-wmiobject Win32_UserProfile | Where {$_.SID -eq "S-1-5-18"}
$lastusetime = $profile.LastUseTime
$lastusetime
[Management.ManagementDateTimeConverter]::ToDateTime($lastusetime)

###################################################################
# Example On How To Scan Profiles on a System
###################################################################
$profiles = get-wmiobject Win32_UserProfile
foreach ($profile in $profiles) {

    $currentdate = Get-Date
    $lastusetime = $profile.LastUseTime
    $lastusetime = [Management.ManagementDateTimeConverter]::ToDateTime($lastusetime)
    $age = [math]::Round(($currentdate - $lastusetime).TotalDays)
    
    $sid = $profile.SID 
    Try {
        $usersid = New-Object System.Security.Principal.SecurityIdentifier("$SID")
        $username = $usersid.Translate( [System.Security.Principal.NTAccount]).Value
    }
    Catch {
        Write-Host "There was an error translating SID value $sid to a username. Account may not exist."
        $username = "(Deleted Account)"
    }
    Write-host "User with name $username and SID $sid last logged in $lastusetime. ($age Days Old)"

}




c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter06\EN_6_code.ps1
************************************************************************
﻿###################################################################
# Chapter 6 - Code File
###################################################################

###################################################################
# Example On How To Get the Scheduled Tasks
###################################################################
get-scheduledtask 
(get-scheduledtask).count

###################################################################
# Example On How To create a Scheduled Task Trigger
###################################################################
$schTrigger = New-ScheduledTaskTrigger -Daily -DaysInterval 1 -At "23:00"
$schTrigger


###################################################################
# Example On How To create a Scheduled Task Action
###################################################################
$schAction = New-ScheduledTaskAction -Execute "Calc.exe"
$schAction

###################################################################
# Example On How To Create a Scheduled Task Setting Set
###################################################################
$schSettingSet = New-ScheduledTaskSettingsSet -DisallowDemandStart -Hidden -DisallowHardTerminate
$schSettingSet

###################################################################
# Example On How To Create a Scheduled Task
###################################################################
$schAction = New-ScheduledTaskAction -Execute "Calc.exe"
$schTrigger = New-ScheduledTaskTrigger -Daily -DaysInterval 1 -At "23:00"
$schSettingSet = New-ScheduledTaskSettingsSet -DisallowDemandStart -Hidden -DisallowHardTerminate
$schTask = New-ScheduledTask -Action $schAction -Trigger $schTrigger -Settings $schSettingSet
$schTask
$schTask.Triggers

###################################################################
# Example On How To Create Scheduled Tasks
###################################################################
$schAction = New-ScheduledTaskAction -Execute "Calc.exe"
$schTrigger = New-ScheduledTaskTrigger -Daily -DaysInterval 1 -At "23:00"
$schTask = New-ScheduledTask -Action $schAction -Trigger $schTrigger
Register-ScheduledTask -TaskName "Start Calc Daily at 11PM" -InputObject $schTask
Register-ScheduledTask -TaskName "Start Calc Daily at 11PM_DeleteMe" -InputObject $schTask
Unregister-ScheduledTask -TaskName "Start Calc Daily at 11PM_DeleteMe" -Confirm:$false
Get-ScheduledTask | where {$_.TaskName -like "Start Calc Daily at 11PM*"}

###################################################################
# Example On How To Change an Existing Scheduled Task
###################################################################
$schAction1 = New-ScheduledTaskAction -Execute "Calc.exe"
$schAction2 = New-ScheduledTaskAction -Execute "Notepad.exe"
Set-ScheduledTask -TaskName "Start Calc Daily at 11PM" -Action $schAction1,$schAction2

###################################################################
# Example On How To Retrieve Run As Values
###################################################################
$users = @()
$schtasks = Get-ScheduledTask
foreach ($Task in $schtasks) {
    $tskUser = $Task.Principal.UserId 
    switch ($Task.Principal.UserId) {
        "NETWORK SERVICE" { $continue = "Skip User" }
        "LOCAL SERVICE" { $continue = "Skip User" }
        "SYSTEM" { $continue = "Skip User"}
        "$null" { $continue = "Skip User" }
        default { $continue = "Report User" }
    }
    if ($continue -eq "Report User") {  
    
        $users += $tskUser
    }
}
$users | Get-Unique


c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter07\EN_7_code.ps1
************************************************************************
﻿###################################################################
# Chapter 7 - Code File
###################################################################

###################################################################
# Example On How To Query the local Disks
###################################################################
get-disk

###################################################################
# Example On How To Query the local Disks using WMI
###################################################################
Get-WmiObject -class win32_logicaldisk

###################################################################
# Example On How To Determine Disk Type
###################################################################
$disks = get-wmiobject win32_logicaldisk
Foreach ($disk in $disks) {
    $driveletter = $disk.DeviceID
    switch ($disk.DriveType) {
        0 { $type = "Type Unknown." }
        1 { $type = "Doesn't have a Root Directory." } 
        2 { $type = "Removable Disk (e.g. USB Key)" } 
        3 { $type = "Local Disk (e.g. Hard Drive / USB hard drive / Virtual drive mount)" } 
        4 { $type = "Network Drive (e.g. Mapped Drive)" } 
        5 { $type = "Compact Disk (e.g. CD/DVD Drive)" } 
        6 { $type = "RAM Disk (e.g. Memory Mapped Drive / PE OS Drive)" } 
        default { $type = "Unable To Determine Drive Type!" }
    }
    Write-host "Drive: $driveletter | Disk Type: $type"
}

###################################################################
# Example On How To Convert Disk Size to Megabytes and Gigabytes
###################################################################
$disks = get-wmiobject win32_logicaldisk
Foreach ($disk in $disks) {
  $driveletter = $disk.DeviceID
  $sizeMB = [System.Math]::Round(($disk.size / 1MB),2)
  $sizeGB = [System.Math]::Round(($disk.size / 1GB),2)
  Write-host "$driveletter | Size (in MB): $sizeMB | Size (in GB): $sizeGB"
}


###################################################################
# Example On How To Convert Disk Units / Values 
###################################################################
function measure-diskunit { param($diskspace)
    switch ($diskspace) {
      {$_ -gt 1PB} { return [System.Math]::Round(($_ / 1PB),2),"PB" }
      {$_ -gt 1TB} { return [System.Math]::Round(($_ / 1TB),2),"TB" }
      {$_ -gt 1GB} { return [System.Math]::Round(($_ / 1GB),2),"GB" }
      {$_ -gt 1MB} { return [System.Math]::Round(($_ / 1MB),2),"MB" }
      {$_ -gt 1KB} { return [System.Math]::Round(($_ / 1KB),2),"KB" }
      default { return [System.Math]::Round(($_ / 1MB),2),"MB" }
    }
}
measure-diskunit 868739194880123456
measure-diskunit 868739194880123
measure-diskunit 868739194880
measure-diskunit 868739194
measure-diskunit 868739

###################################################################
# Example On How To Evaluate Disk Information
###################################################################
function measure-diskunit { param($diskspace)
    switch ($diskspace) {
      {$_ -gt 1PB} { return [System.Math]::Round(($_ / 1PB),2),"PB" }
      {$_ -gt 1TB} { return [System.Math]::Round(($_ / 1TB),2),"TB" }
      {$_ -gt 1GB} { return [System.Math]::Round(($_ / 1GB),2),"GB" }
      {$_ -gt 1MB} { return [System.Math]::Round(($_ / 1MB),2),"MB" }
      {$_ -gt 1KB} { return [System.Math]::Round(($_ / 1KB),2),"KB" }
      default { return [System.Math]::Round(($_ / 1MB),2),"MB" }
    }
}

$disks = get-wmiobject win32_logicaldisk
Foreach ($disk in $disks) {
    $driveletter = $disk.DeviceID
    $freespace = $disk.FreeSpace
    $size = $disk.Size
  
    if ($freespace -lt 1) { $freespace = "0" }
    if ($size -lt 1) { $size = "0" }
  
    $freetype = measure-diskunit $freespace
    $convFreeSpc = $freetype[0]
    $funit = $freetype[1]
  
    $sizetype = measure-diskunit $size
    $convsize = $sizetype[0]
    $sunit = $sizetype[1]

    switch ($disk.DriveType) {
        0 { $type = "Type Unknown." }
        1 { $type = "Doesn't have a Root Directory." } 
        2 { $type = "Removable Disk" } 
        3 { $type = "Local Disk" } 
        4 { $type = "Network Drive" } 
        5 { $type = "Compact Disk" } 
        6 { $type = "RAM Disk" } 
        default { $type = "Unable To Determine Drive Type!" }
    }

    write-host "Drive $driveletter | Drive Type: $type | Size: $convsize $sunit  | Freespace: $convFreeSpc $funit"

}




c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter08\EN_8_code.ps1
************************************************************************
﻿###################################################################
# Chapter 8 - Code File
###################################################################

###################################################################
# Example On How To Query Installed Windows Features (2008 R2 and Up)
###################################################################
get-WindowsFeature | where {$_.Installed -eq $true} | Select DisplayName, InstallState, Parent

###################################################################
# Example On How To Query Installed Windows Features (2008 R2 and Under; PowerShell 2.0)
###################################################################
get-wmiobject win32_serverfeature | select ID, Name, ParentID

###################################################################
# Example On How To Coorelate Feature IDs to Names
###################################################################
[xml] $frxml = Get-Content ".\ServerFeatureIDs.xml"
$featRoleTable = $frxml.GetElementsByTagName("feature")
$crntFeatures = Get-wmiobject win32_serverfeature
foreach ($feature in $crntFeatures) {
    $featurename = $feature.Name
    $featureparentID = $feature.ParentID
    if ($featureparentID) {
        $featureparentName = ($featRoleTable | where {$_.ID -eq $featureparentID}).Name
        Write-host "The $featurename feature has the parentID of $featureparentID. Parent Name: $featureparentName."
    }
}


###################################################################
# Example On How To Scan for Registry for Application Names
###################################################################
$RegLocations = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
foreach ($reg in $RegLocations) {
    $softwareKeys = get-ItemProperty $Reg | Select DisplayName | Sort DisplayName
    foreach ($software in $softwareKeys) {
        if ($software.DisplayName -ne $null) { Write-host "Software Found: " $software.DisplayName }
    }
}

###################################################################
# Example On How To Scan for Program Files on each disk
###################################################################
$progpaths = "\Program Files\","\Program Files (x86)\"
$disks = (Get-WmiObject win32_logicaldisk | where {$_.DriveType -eq "3"}).DeviceID
foreach ($disk in $disks) {

    foreach ($progpath in $progpaths) {
        $progfile = $disk + $progpath
        $test = test-path $progfile

        if ($test) {
            $files = Get-ChildItem -file $progfile -Recurse | where {$_.FullName -like "*.exe"} | Select Fullname

            foreach ($file in $files) {
                $productName = (get-itemproperty $file.FullName).VersionInfo.ProductName
                if (!$productName) { $productName = "Product Name n/a" }
                
                $productVersion = (get-itemproperty $file.FullName).VersionInfo.ProductVersion
                if (!$productVersion) { $productVersion = "Product Version n/a"}

                Write-host $file.Fullname " | Name: $productName | Version: $productVersion"
            }
        }
    }
}


c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter09\EN_9_code.ps1
************************************************************************
﻿###################################################################
# Chapter 9 - Code File
###################################################################

###################################################################
# Example On How To Get .log and .txt files from a directory
###################################################################
Get-ChildItem "c:\Program Files\" -Include *.log,*.txt -recurse

###################################################################
# Example On How To Scan .log and .txt for simple strings
###################################################################

$matches = Get-ChildItem "c:\Program Files\" -Include *.log,*.txt -recurse | select-string -pattern "Complete" -SimpleMatch
foreach ($match in $matches) {
    Write-Host "Filename: " $match.FileName
    Write-Host "Line Number: " $match.LineNumber
    Write-Host "Line Contents: " $match.Line
}

###################################################################
# Example On How To Handle File Path Exceptions
###################################################################
# Create Folder Structure to Scan
$userdrive = "c:\Temp\POSHScript\Chapter9Examples\CompanyXYZ\Milwaukee\InformationTechnologyDepartment\UserHomeDrives\UserLoginID\"
new-item $userdrive -ItemType Directory -Force
$domainuser = "$env:computername\Brenton"
New-SmbShare -name "UserData" -Path $userdrive -FullAccess $domainuser
New-PSDrive -Name H -root "\\$env:computername\Userdata" -Persist -PSProvider FileSystem
cd H:
$userFolder = "Information Technology Department\All Company Software\ISO\Microsoft\Microsoft SQL Server 2012 R2\SQL Server Update Patches\Service Pack 3\Cumulative Update 7\AutomatedWindowsInstaller\"
new-item $userFolder -ItemType Directory -Force

#Scan Folder Struture
$directory = "c:\Temp\POSHScript\Chapter9Examples\CompanyXYZ\"
$errors = @()
get-childitem $directory -recurse -ErrorAction SilentlyContinue -ErrorVariable +errors
if ($errors) {
    foreach ($err in $errors) {
        if ($err.Exception -like "*Could not find a part of the path*") {
            $filepath = ($err.Exception).ToString().split("'")[1]
            Write-Host "Error Accessing Path: `"$filepath`" may be over 248 Characters."
        }
        if ($err.Exception -like "*is denied.*") {
            $filepath = ($err.Exception).ToString().split("'")[1]
            Write-Host "Error Accessing Path: `"$filepath`" Access Is Denied."
        }
    }
}
# Remove Mapped Drive and Share
cd c:
Remove-PSDrive -Name H -Force
Remove-SmbShare -name "UserData" -Force


##################################################################
# Example On How To Create a Scan Function Leveraging Search Exclusions
###################################################################

function scan-directory { param($directory)
    $errors = @()
    $content = get-childitem $directory -Include $include -Exclude $exclude -recurse -ErrorAction SilentlyContinue -ErrorVariable +errors | select-string -Pattern $findword -SimpleMatch -ErrorAction SilentlyContinue

    if ($errors) {
        foreach ($err in $errors) {
            if ($err.Exception -like "*Could not find a part of the path*") {
                $filepath = ($err.Exception).ToString().split("'")[1]
                Write-Host "Error Accessing Path: `"$filepath`" may be over 248 Characters."
            }
            if ($err.Exception -like "*is denied.*") {
                $filepath = ($err.Exception).ToString().split("'")[1]
                Write-Host "Error Accessing Path: `"$filepath`" Access Is Denied."
            }
        }
    }
    foreach ($match in $content) {
        Write-Host "Filename: " ($match.FileName).Trim()
        Write-Host "Line Number: " $match.LineNumber
        Write-Host "Line Contents: " ($match.Line).Trim()
    }
}

$include = "*.xml","*.txt"
$exclude = ""
$findword = "Complete"
scan-directory "c:\Windows\System32\"

$include = "*.xml","*.txt"
$exclude = "*hppcl3-pipelineconfig.xml*","Cleanup.xml"
$findword = "Complete"
scan-directory "c:\Windows\System32\"





c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter10\EN_10_code.ps1
************************************************************************
﻿###################################################################
# Chapter 10 - Code File
###################################################################

###################################################################
# Example On Measure the Ping Command
###################################################################

measure-command { ping localhost }

###################################################################
# Example On Measuring Windows Speed
###################################################################
$time1 = measure-command {
    1..10000 | % { 
                write-host "Number $_" 
                # Get the contents of C:\Windows\
                $contents = Get-ChildItem c:\windows\
                }
}

$time2 = measure-command {
    1..10000 | % { 
                # Get the contents of C:\Windows\system32\
                $contents = Get-ChildItem c:\windows\
                }
}
$time1
$time2
$timediff = ($time1 - $time2).TotalSeconds
Write-host "Total Difference in Speed: $timediff Total Seconds"

###################################################################
# Example On Measuring Windows Speed
###################################################################
$verbose = $true
function log { if ($verbose) { write-host $_ } }

$time1 = measure-command {
    1..10000 | % { 
                log "Number $_" 
                # Get the contents of C:\Windows\
                $contents = Get-ChildItem c:\windows\
                }
}

$time2 = measure-command {
    1..5000 | % { 
                log "Log $_" 
                # Get the contents of C:\Windows\
                $contents = Get-ChildItem c:\windows\
                }
                $verbose = $false
                Write-host "Running Folder Scanning Operation..."

    1..5000 | % { 
                log "Number $_" 
                # Get the contents of C:\Windows\
                $contents = Get-ChildItem c:\windows\
                }
                Write-host "Folder Scanning Operation Complete."
}

$time1
$time2
$timediff = ($time1 - $time2).TotalSeconds
Write-host "Total Difference in Speed: $timediff Total Seconds"

###################################################################
# Example On Measuring Write-Progress Speed
###################################################################

$time1 = measure-command {
    1..10000 | % {
                $attempt = $_
                $perComplete = [math]::truncate(($attempt/10000)*100)
                write-progress -Activity "Looping Retrieval of Contents of c:\Windows" -Status "$attempt of 10000." -PercentComplete $perComplete
                # Get the contents of C:\Windows\
                $contents = Get-ChildItem c:\windows\
                }
}

$time2 = measure-command {
    1..10000 | % { 
                # Get the contents of C:\Windows\
                $contents = Get-ChildItem c:\windows\
                }
}
$time1
$time2
$timediff = ($time1 - $time2).TotalSeconds
Write-host "Total Difference in Speed: $timediff Total Seconds"


###################################################################
# Example On How to Setup a Data Set for a Switch Statement
###################################################################
$dlls = 0
$exes = 0
$xmls = 0
$extensions = @()
$contents += ((Get-ChildItem "c:\windows\System32\" -include "*.xml","*.dll","*.exe" -Recurse -ErrorAction SilentlyContinue) | Select Name)
foreach ($item in ($contents.Name)) { 
    $sline = $item.split(".").length
    $extensions += '.' + $item.split(".")[$sline-1]
}
1..13 | % { $extensions += $extensions }
Write-host "Total number of Extensions: " $extensions.count


###################################################################
# Example On How to Setup a Data Set for a Switch Statement
###################################################################
$time1 = measure-command {
    foreach ($extension in $extensions) {
        # Determine the file types
        if ($extension -like "*.xml") { $xmls += 1 }
        if ($extension -like "*.exe") { $exes += 1 }
        if ($extension -like "*.dll") { $dlls += 1 }
    }
}
# Reset Count
$dlls = 0
$exes = 0
$xmls = 0
$time2 = measure-command {
    foreach ($extension in $extensions) {
        # Determine the file types
        switch($extension) {
            ".dll" { $dlls += 1 }
            ".exe" { $exes += 1 }
            ".xml" { $xmls += 1 }
            default { } #do nothing
        }
    }                
}


$time1
$time2
$timediff = ($time1 - $time2).TotalSeconds
Write-Host "Total Number of Counted DLL files $dlls"
Write-host "Total Number of Counted EXE files $exes"
Write-host "Total Number of Counted XML files $xmls"
Write-host "Total Difference in Speed: $timediff Total Seconds"




c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter11\B06457_11_code.ps1
************************************************************************
﻿###################################################################
# Chapter 11 - Code File
###################################################################

###################################################################
# Example On how to match different patterns
###################################################################
"192.168.12.24" -match "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
"00:A0:F8:12:34:56" -match "^([0-9a-f]{2}:){5}[0-9a-f]{2}$"
"brent@testingdomain.com" -match "^.+@[^\.].*\.[a-z]{2,}$"
"4000-4000-4000-4000" -match "^\d{4}-\d{4}-\d{4}-\d{4}$"
"123-45-6789" -match "^\d{3}-\d{2}-\d{4}$"

###################################################################
# Example On How Dynamically Build a Regular expression
###################################################################
$myarray = “administrator”,“password”,“username”
$searchRegex = '(?i)^.*(' + (($myarray| % {[regex]::escape($_)}) –join "|") + ').*$'
"This String has Administrators in it." -match $searchRegex
"This PASSWORD is not secure." -match $searchRegex
"TheUsernames are not written." -match $searchRegex
$searchRegex.tostring()

###################################################################
# Example On How Regular Expressions are faster than Multiple Arrays
###################################################################

$files = (Get-ChildItem c:\Windows\System32 -Recurse -ErrorAction SilentlyContinue).Name
1..8 | % { $files += $files }
Write-host "Total Number of Files to Analyze: " $files.count

###################################################################
# Example On How Regular Expressions are faster than Multiple Arrays
###################################################################

$types = ".xml",".exe",".dll"
$filefound = 0 
$time1 = Measure-Command {
    foreach ($type in $types) {
        foreach ($file in $files) {
            if ($file -like "*$type") { $filefound += 1 }
        }
    }
}
Write-host "Total Number of Found Files $filefound"
$filefound = 0 
$searchRegex = '(?i)^.*(' + (($types | foreach {[regex]::escape($_)}) –join "|") + ')$'
$time2 = Measure-Command {
        foreach ($file in $files) {
            if ($file -match $searchRegex) { $filefound += 1 }
        }
}
Write-host "Total Number of Found Files $filefound"
$time1
$time2
$timediff = ($time1 - $time2).TotalSeconds
Write-host "Total Difference in Speed: $timediff Total Seconds"



c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter12\B06457_12_code.ps1
************************************************************************
﻿###################################################################
# Chapter 12 - Code File
###################################################################

###################################################################
# How to Create a termination file.
###################################################################
# Locally 
new-item -path "c:\temp\KILL_SERVER_SCAN.NOW" -ItemType File

# Remotely
Enter-PSSession -ComputerName POSHDEMO-SQL01
new-item -path "c:\temp\KILL_SERVER_SCAN.NOW" -ItemType File
Exit-PSSession

###################################################################
# How to Remove a termination file.
###################################################################
# Locally
Remove-Item -Path "c:\temp\KILL_SERVER_SCAN.NOW" -Force

# Remotely
Enter-PSSession -ComputerName POSHDEMO-SQL01
Remove-Item -Path "c:\temp\KILL_SERVER_SCAN.NOW" -Force
Exit-PSSession


###################################################################
# Create Several CSV Files
###################################################################
$logloc = "C:\temp\POSHScript\CSVDEMO\"
$date = (Get-Date -format "yyyyMMddmmss")
Function create-testcsv { param($servername)
    $csvfile = "$logloc\$servername" + "_" + $date + "_ScanResults.csv"
    new-item $csvfile -ItemType File -Force | Out-Null

    $csvheader = "ServerName, Classification, Other Data"
    Add-content $csvfile -Value $csvheader

    $csvcontent = "$servername, CSVTestData, This is CSV Test Data for $servername."
    Add-content $csvfile -Value $csvcontent
}
create-testcsv POSHDEMO-Server1
create-testcsv POSHDEMO-Server2
create-testcsv POSHDEMO-Server3
create-testcsv POSHDEMO-Server4
create-testcsv POSHDEMO-Server5
get-childitem $logloc

###################################################################
# How to Merging Data Results
###################################################################

$logloc = "C:\temp\POSHScript\CSVDEMO\"
$date = (Get-Date -format "yyyyMMddmmss")
$mergefile = "$logloc" + "Merged_$date.csv"
New-Item $mergefile -ItemType File | Out-Null
(get-childitem $logloc -filter "*.csv").FullName | Import-csv | Export-csv $mergefile -NoTypeInformation





c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter12\B06457_12_Encoding.ps1
************************************************************************
﻿###################################################################
# Chapter 12 - Code File - Encoding
###################################################################


###################################################################
# Example On Create a Random Passphrase
###################################################################
Function create-password {
    $password = ""
    For ($a=33;$a –le 126;$a++) {
        $ascii += ,[char][byte]$a
    }
    1..30 | % { $password += $ascii | get-random }    
    return $password
}
$pass = create-password
$salt = create-password
$init = create-password

###################################################################
# Example On How To Prompt for Encoding a Passphrase
###################################################################
$encodedpass = [System.Text.Encoding]::Unicode.GetBytes($pass)
$encodedvalue = [Convert]::ToBase64String($encodedpass)
# Since the returned encoding is 80 characters in length, you split into 27, 27, 26
$SSD = $encodedvalue.substring(0,27)
$AFD = $encodedvalue.substring(27,27)
$RTD = $encodedvalue.substring(54,26)

$encSalt = [System.Text.Encoding]::Unicode.GetBytes($salt)
$encSalt = [Convert]::ToBase64String($encSalt)

$encInit = [System.Text.Encoding]::Unicode.GetBytes($init)
$encInit = [Convert]::ToBase64String($encInit)

Write-host "The SSD is: $SSD"
Write-host "The AFD is: $AFD"
Write-host "The RTD is: $RTD"
Write-host "The Salt is: $encSalt"
Write-host "The Init is: $encInit"





c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter12\B06457_12_Encryption.ps1
************************************************************************
﻿###################################################################
# Chapter 12 - Code File - Encryption Script
###################################################################
# Function for String Encryption
Add-Type -AssemblyName System.Security
function Encrypt-String { param($String)
    try{
        $r = new-Object System.Security.Cryptography.RijndaelManaged
        $pass = [Text.Encoding]::UTF8.GetBytes($pass)
        $salt = [Text.Encoding]::UTF8.GetBytes($salt)
        $init = [Text.Encoding]::UTF8.GetBytes($init) 

        $r.Key = (new-Object Security.Cryptography.PasswordDeriveBytes $pass, $salt, "SHA1", 50000).GetBytes(32)
        $r.IV = (new-Object Security.Cryptography.SHA1Managed).ComputeHash($init)[0..15]

        $c = $r.CreateEncryptor()
        $ms = new-Object IO.MemoryStream
        $cs = new-Object Security.Cryptography.CryptoStream $ms,$c,"Write"
        $sw = new-Object IO.StreamWriter $cs
        $sw.Write($String)
        $sw.Close()
        $cs.Close()
        $ms.Close()
        $r.Clear()
        [byte[]]$result = $ms.ToArray()
    }
    catch { 
        $err = "Error Occurred Encrypting String: $_"   
    }
    if($err) {
        # Report Back Error
        return $err
    } 
    else {
        return [Convert]::ToBase64String($result)
    }
}
# All of the encoded values from YOUR execution of Script 1.
$rtd = "AAZwAmAE4AMgAoAFEAVAAhAFAA"
$ssd = "LAAyAGwAdQBRAG8AZABMAEwAJgA"
$afd = "5AFIAQgBYACYAXgBRAC4AUgA5AF"
$encSalt = "NABFAEIASgAzADsAOgBnAHEAagBxAGgAJgBcAH4AZgBRAD0ARAAzACEAZwAiACYATQBuAGwAWABzAHkA"
$encInit ="ZgA/ADoAbQBGAFMAewAjAHcAMgBYAGQALwBYACEAVgB4AHEARABVAHAANwBgACQAeAAqAD0AbgBnADEA"

# Decode the Password
$encpass = $ssd + $afd + $rtd
$encbytes = [System.Convert]::FromBase64String($encpass)
$pass = [System.Text.Encoding]::Unicode.GetString($encbytes)

# Decode the Salt
$encbytes = [System.Convert]::FromBase64String($encSalt)
$salt = [System.Text.Encoding]::Unicode.GetString($encbytes)

# Decode the Init
$encbytes = [System.Convert]::FromBase64String($encInit)
$Init = [System.Text.Encoding]::Unicode.GetString($encbytes)

cls
write-host "To End This Application, Close the Window"	
Write-host ""

do
    {	
	$string = read-host "Please Enter a String to Encrypt"
	$encrypted = Encrypt-String $string
	write-host "Encrypted String is: $encrypted"
    }
While ($good -ne "True")


c:\users\rocky\desktop\powershell books examples\enterprise-powershell-scripting-bootcamp-master\Chapter13\B06457_13_code.ps1
************************************************************************
﻿###################################################################
# Chapter 13 - Code File
###################################################################

<#
.SYNOPSIS
This is a server discovery script which will scan different server components to determine
the current configuration.

.DESCRIPTION
This script will scan processes, Windows services, scheduled tasks, server features, disk information,
registry, and files for pertinent server information.

Author: Brenton J.W. Blawat / Packt Publishing / Author / email@email.com

.PARAMETER RTD
This script requires a run time decryptor as a parameter to the script.

.EXAMPLE
powershellscript.ps1 /RTD "Run Time Decryptor"

.NOTES
You must have administrative rights to the server you are scanning. Certain functions will not work properly
without running the script as system or administrator.#>
param($RTD)

if (!$RTD) { exit }

####################
# Answer File Logic
####################
Function read-xmltag { param($xmlextract)
    return $xml.GetElementsByTagName("$xmlextract")
}

$xmlfile = "$PSScriptRoot\Scan_Answers.xml"
$test = test-path $xmlfile
if (!$test) { 
    Write-Error "$xmlfile not found on the system. Select any key to exit!"
    PAUSE
    exit
}
[xml] $xml = get-content $xmlfile
#Remove-Item $xmlfile -force


####################
# Decryption Logic
####################
Add-Type -AssemblyName System.Security
function Decrypt-String { param($Encrypted)
   
   if($Encrypted -is [string]){
      $Encrypted = [Convert]::FromBase64String($Encrypted)
   }

   $r = new-Object System.Security.Cryptography.RijndaelManaged
   $pass = [System.Text.Encoding]::UTF8.GetBytes($pass)
   $salt = [System.Text.Encoding]::UTF8.GetBytes($salt)
   $init = [Text.Encoding]::UTF8.GetBytes($init) 
   
   $r.Key = (new-Object Security.Cryptography.PasswordDeriveBytes $pass, $salt, "SHA1", 50000).GetBytes(32)
   $r.IV = (new-Object Security.Cryptography.SHA1Managed).ComputeHash($init)[0..15]

   $d = $r.CreateDecryptor()
   $ms = new-Object IO.MemoryStream @(,$Encrypted)
   $cs = new-Object Security.Cryptography.CryptoStream $ms,$d,"Read"
   $sr = new-Object IO.StreamReader $cs

   try {
       $result = $sr.ReadToEnd()
       $sr.Close()
       $cs.Close()
       $ms.Close()
       $r.Clear()
       Return $result
   }
   Catch {
       Write-host "Error Occurred Decrypting String: Wrong String Used In Script."
   }
}

####################
# Function to Create RegEx
####################
function create-SearchRegEx { param($list)
    if (!$list) { $list = "No_Input_Provided_For_List_Item" }
    $RegEx = '(?i)^.*(' + (($list | % {[regex]::escape($_)}) –join "|") + ').*$'
    return $regex
}

####################
# Function to Decode Strings
####################
function decode-string { param($string)
    $encbytes = [System.Convert]::FromBase64String($string)
    $string = [System.Text.Encoding]::Unicode.GetString($encbytes)
    return $string
}

####################
# Populate Script Variables
####################

# System Configuration
$ssd = "LAAyAGwAdQBRAG8AZABMAEwAJgA"
$afd = (read-xmltag "afd") | Select id
$encpass = $ssd + $afd.id + $rtd
$pass = decode-string $encpass
$salt = (read-xmltag "salt") | % { decode-string $_.id }
$init = (read-xmltag "init") | % { decode-string $_.id }

# Logging Settings
$logloc = (read-xmltag "logloc") | Select id
$verboselog = (read-xmltag "verboselog") | Select id
$filelog = (read-xmltag "filelog") | Select id
$evntlog = (read-xmltag "evntlog") | Select id
$csvunc = (read-xmltag "csvunc") | Select id

# Enable / Disable Features
$scanDisks = (read-xmltag "scndisks") | Select id
$scanSchTasks = (read-xmltag "scnschtsks") | Select id
$scanProcess = (read-xmltag "scnproc") | Select id
$scanServices = (read-xmltag "scnsvcs") | Select id
$scanSoftware = (read-xmltag "scnsoft") | Select id
$scanProfiles = (read-xmltag "scnuprof") | Select id
$scanFeatures = (read-xmltag "scnwfeat") | Select id
$scanFiles = (read-xmltag "scnfls") | Select id

# Search Locations
$scnloc = (read-xmltag "scnloc") | Select id

# Kill File Location
$killfile = (read-xmltag "killfile") | Select id

# Search Extensions
$srextlist = @()
$srext = (read-xmltag "srext") | % { $srextlist += "*" + $_.id }

# File Search Data
$srterms = read-xmltag "srterm" | % { decrypt-string $_.id }
$srtermsRegEx = create-SearchRegEx $srterms

# File Ignore list
$flign = (read-xmltag "flign") | Select id
$flignRegEx = create-SearchRegEx $flign.id

# Search Ignore List
$srign = (read-xmltag "srign") | Select id
$sringRegEx = create-SearchRegEx $srign.id

# Built-in User List
$blst = (read-xmltag "blst") | Select id
$blstRegEx = create-SearchRegEx $blst.id



####################
# Create the Log Files
####################
$date = (Get-Date -format "yyyyMMddmmss")
$compname = $env:COMPUTERNAME
$logloc = $logloc.id
$scanlog = "$logloc\$compname" + "_" + $date + "_ServerScanScript.log"
new-item $scanlog -ItemType File -Force | Out-Null

# Create the CSV File
$scnresults = "$logloc\$compname" + "_" + $date + "_ScanResults.csv"
$csvheader = "ServerName, Classification, Other Data"
new-item $scnresults -ItemType File -Force | Out-Null
Add-content $scnresults -Value $csvheader

####################
# Create the Event Log
####################
if ($evntlog -eq "True") { New-EventLog –LogName Application –Source "WindowsServerScanningScript" -ErrorAction SilentlyContinue }
 
####################
# Create the Logging Function
####################
function log { param($string, $scnlg, $evntlg)
    if ($filelog.id -eq "True") {
          if ($scnlg -like "Y") { Add-content $scanlog -Value $string }
    }
    if ($evntlog.id -eq "True") {
         if ($evntlg -like "Y") { write-eventlog -logname Application -source "WindowsServerScanningScript" -eventID 1000 -entrytype Information -message "$string" }
    }
    if (!$scnlg) {
       $content = "$env:COMPUTERNAME,$string"
       Add-Content $scnresults -Value $content
    }
    if ($verboselog.id -eq "True") { write-host $string }
}

####################
# Start of the Script
####################
$date = (Get-Date -format "yyyyMMddmmss")
log "Starting Windows Server Scanning Script at $date ..." "Y" "Y"
log "ScriptStart,$date"

####################
# Check for Kill File
####################
function check-kill {
    if (test-path $killfile.id) {
        $date = (Get-Date -format "yyyyMMddmmss")
        log "Kill File Detected at $date. Terminating Script." "Y" "Y"
        log "KillFile, Kill File Detected at $date.. Terminating Script"
        copy-item -Path $scnresults -Destination $csvunc.id -Force
        copy-Item -Path $scanlog -Destination $csvunc.id -Force
        exit
    }
}

####################
# Disk Scanning
####################
function measure-diskunit { param($diskspace)
    switch ($diskspace) {
      {$_ -gt 1PB} { return [System.Math]::Round(($_ / 1PB),2),"PB" }
      {$_ -gt 1TB} { return [System.Math]::Round(($_ / 1TB),2),"TB" }
      {$_ -gt 1GB} { return [System.Math]::Round(($_ / 1GB),2),"GB" }
      {$_ -gt 1MB} { return [System.Math]::Round(($_ / 1MB),2),"MB" }
      {$_ -gt 1KB} { return [System.Math]::Round(($_ / 1KB),2),"KB" }
      default { return [System.Math]::Round(($_ / 1MB),2),"MB" }
    }
}
function scan-disks {
    check-kill
    $disks = get-wmiobject win32_logicaldisk
    Foreach ($disk in $disks) {
        $driveletter = $disk.DeviceID
        $freespace = $disk.FreeSpace
        $size = $disk.Size
  
        if ($freespace -lt 1) { $freespace = "0" }
        if ($size -lt 1) { $size = "0" }
  
        $freetype = measure-diskunit $freespace
        $convFreeSpc = $freetype[0]
        $funit = $freetype[1]
  
        $sizetype = measure-diskunit $size
        $convsize = $sizetype[0]
        $sunit = $sizetype[1]

        switch ($disk.DriveType) {
            0 { $type = "Type Unknown." }
            1 { $type = "Doesn't have a Root Directory." } 
            2 { $type = "Removable Disk" } 
            3 { $type = "Local Disk" } 
            4 { $type = "Network Drive" } 
            5 { $type = "Compact Disk" } 
            6 { $type = "RAM Disk" } 
            default { $type = "Unable To Determine Drive Type!" }
        }
        log "DiskConfiguration, Drive $driveletter | Drive Type: $type | Size: $convsize $sunit  | Freespace: $convFreeSpc $funit"
    }
}

####################
# Scheduled Task Scanning
####################
function scan-schtasks {
    check-kill
    $schtasks = Get-ScheduledTask
    foreach ($Task in $schtasks) {
        $tskUser = $Task.Principal.UserId
        if($tskUser -eq $null) { $tskuser = "SYSTEM" }
        if (!($tskUser -match $blstRegEx)) {
             $tskname = ($task.TaskName).replace(","," ")
             $tskpath = $task.TaskPath
             log "ScheduledTsksData, Scheduled task with the name of $tskname in the location of $tskpath is running as $tskuser"
        }
    }
}

####################
# Process Scanning
####################
function scan-process {
    check-kill
    $processes = Get-WmiObject win32_process
    foreach ($process in $processes) {
        $procuser = $process.GetOwner().User
        if (!($procuser -match $blstRegEx)) {
            $procname = $process.Name
            $procdom = $process.GetOwner().Domain
            $procuser = $process.GetOwner().User
            log "WindowsProcessData, $procname is running with the $procdom\$procuser account."
        }
    }
}

####################
# Windows Services Scanning
####################
function scan-services {
    check-kill
    $service = get-wmiobject win32_service
    foreach ($service in $services) {
        $svcAuthUser = $service.StartName
        if (!($svcAuthUser -match $blstRegEx)) {
            $svcdisplay = $service.DisplayName
            log "WindowsServicedata, Service with $svcdisplay name is running with $svcAuthUser account."
        }
    }
}

####################
# Software Scanning
####################
function scan-software {
    check-kill
    $RegLocations = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    foreach ($reg in $RegLocations) {
        $softwareKeys = get-ItemProperty $Reg | Select DisplayName | Sort DisplayName
        foreach ($software in $softwareKeys) {
            if ($software.DisplayName -ne $null) { 
                $value = "InstalledSoftware," + $software.DisplayName 
                log $value
            }
        }
    }
    $progpaths = "\Program Files\","\Program Files (x86)\"
    $disks = (Get-WmiObject win32_logicaldisk | where {$_.DriveType -eq "3"}).DeviceID
    foreach ($disk in $disks) {
        foreach ($progpath in $progpaths) {
            check-kill
            $progfile = $disk + $progpath
            $test = test-path $progfile
            if ($test) {
                $files = Get-ChildItem -file $progfile -Recurse | where {$_.FullName -like "*.exe"} | Select Fullname
                foreach ($file in $files) {
                    $productName = (get-itemproperty $file.FullName).VersionInfo.ProductName
                    if (!$productName) { $productName = "Product Name n/a" }
                
                    $productVersion = (get-itemproperty $file.FullName).VersionInfo.ProductVersion
                    if (!$productVersion) { $productVersion = "Product Version n/a"}
                    $value = "InstalledSoftware," + $file.Fullname + " | Name: $productName | Version: $productVersion"
                    log $value
                }
            }
        }
    }
}

####################
# Profile Scanning Function
####################
function scan-profiles {
    check-kill
    $profiles = get-wmiobject Win32_UserProfile
    foreach ($profile in $profiles) {
        $currentdate = Get-Date
        $lastusetime = $profile.LastUseTime
        $lastusetime = [Management.ManagementDateTimeConverter]::ToDateTime($lastusetime)
        $age = [math]::Round(($currentdate - $lastusetime).TotalDays)
    
        $sid = $profile.SID 
        Try {
            $usersid = New-Object System.Security.Principal.SecurityIdentifier("$SID")
            $username = $usersid.Translate( [System.Security.Principal.NTAccount]).Value
        }
        Catch {
            log "There was an error translating SID value $sid to a username. Account may not exist." "Y"
            $username = "(Deleted Account)"
        }
        log "UserProfileData, User with name $username and SID $sid last logged in $lastusetime. ($age Days Old)"
    } 
}

####################
# Windows Features Scanning
####################
function scan-features {
    check-kill
    $crntFeatures = Get-wmiobject win32_serverfeature -ErrorAction SilentlyContinue -ErrorVariable err
    if ($err) { log "ServerFeatureInfo, Cannot get server feature information from WMI. System may not be a server or access is denied to WMI." }
    foreach ($feature in $crntFeatures) {
        $featurename = $feature.Name
        log "ServerFeatureInfo, $featurename feature is installed on the system."
    }
}

####################
# File Scanning 
####################
function scan-directory {
    $errors = @()
    foreach ($directory in $scnloc) {
        check-kill
        $content = get-childitem $directory.id -Include $srextlist -recurse -ErrorAction SilentlyContinue -ErrorVariable +errors | select-string -Pattern $srtermsRegEx -ErrorAction SilentlyContinue
        if ($errors) {
            foreach ($err in $errors) {
                if ($err.Exception -like "*Could not find a part of the path*") {
                    $filepath = ($err.Exception).ToString().split("'")[1]
                    log "FileScanData, Error Accessing Path: `"$filepath`" may be over 248 Characters."
                }
                if ($err.Exception -like "*is denied.*") {
                    $filepath = ($err.Exception).ToString().split("'")[1]
                    log "FileScanData, Error Accessing Path: `"$filepath`" Access Is Denied."
                }
            }
        }
        foreach ($match in $content) {
            $filename = ($match.Path).Trim()
            if (!($filename -match $flignRegEx)) {
                $lineno = $match.LineNumber
                $linecontents = (($match.Line).Trim()).Replace(",","")
                log "FileScanData, String match found in file named $filename with the line number of $lineno and the line contents of $linecontents."
            }
        }
    }
}

if ($scanDisks.id -eq "True") { scan-disks }
if ($scanSchTasks.id -eq "True") { scan-schtasks }
if ($scanProcess.id -eq "True") { scan-process }
if ($scanServices.id -eq "True") { scan-services }
if ($scanSoftware.id -eq "True") { scan-software }
if ($scanProfiles.id -eq "True") { scan-profiles }
if ($scanFeatures.id -eq "True") { scan-features }
if ($scanFiles.id -eq "True") { scan-directory }

$date = (Get-Date -format "yyyyMMddmmss")
log "Windows Server Scanning Script completed execution at $date" "Y" "Y"
log "Scriptend,$date"
copy-item -Path $scnresults -Destination $csvunc.id -Force
copy-Item -Path $scanlog -Destination $csvunc.id -Force


# Starting the Scanning Script from Command Line
# Commented out to avoid script looping.
# powershell.exe -executionPolicy bypass -noexit -file "c:\temp\ScanningScript.ps1" "AAZwAmAE4AMgAoAFEAVAAhAFAA"

