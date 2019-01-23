
c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_01_Code\1.3_Whats_new_in_ps_5.ps1
************************************************************************

######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#$PSVersionTable Variable
$PSVersionTable.PSVersion

#Class & Enum
Get-Help about_Classes -ShowWindow

#Structured Information Stream
$InformationPreference
Write-Information "There you go" 
$InformationPreference="Continue"
Write-Information "There you go"
$InformationPreference="SilentlyContinue"
Get-Process P*; Write-Information "Test the message stream" -InformationAction Continue

#ConvertFrom-String
$strCsv="This,is,a,test,csv,file"
ConvertFrom-String -Delimiter "," -InputObject $strCsv

#Convert-String
"One One", "Two Two", "Three Three", "Four Four" | Convert-String -Example "Firstname Lastname=Lastname, F."
"String_One 1", "String_Two 2", "String_Three 3", "String_Four 4" | Convert-String -Example "String_Zero 0=0 - Zero"
$a = Get-Process | Select-Object processname, id | ConvertTo-Csv -NoTypeInformation | Select-Object -Last 10
$a | Convert-String -Example '"processname", "0"=0, p.'

#Archive Model
Get-Command *Archive*
Compress-Archive -Path C:\Test\T* -DestinationPath C:\Test\Archive\Archive.zip -Force 

#PackageManagement
Get-Command -FullyQualifiedModule PackageManagement
Get-Package -AllVersions | Select -Last 10

#PowerShellGet
Get-Command -FullyQualifiedModule PowerShellGet
Register-PSRepository -

#Hidden Keyword
$psTest = Get-Process | Select -First 1 
$psTest | fl
$psTest |Get-Member PSStandardMembers
$psTest |Get-Member PSStandardMembers -Force

$psTest.PSStandardMembers

#SymbolicLink Folder needs Admin Priveleges
New-Item -ItemType SymbolicLink -Path C:\Temp -Name SymLinkDir -Value C:\Test
#SymbolicLink File
New-Item -ItemType SymbolicLink -Path C:\Temp -Name SymLinkFile -Value C:\Test\Test.txt



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_01_Code\1.4_Whats_new_in_ps_5_Part_2.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Get-ChildItem -Depth
Get-ChildItem -Path C:\Test -Recurse -Depth 2

#Copy-Item -ToSession
$strServer="sophos"
$s=New-PSSession $strServer
Copy-Item -Path C:\Test\Test.txt -ToSession $s -Destination C:\Test

#Cryptographic Message Syntax
Get-Content DocumentEncryption.inf
Certreq -New DocumentEncryption.inf DocumentEncryption.cer
$strProtect="This is a test to encrypt this message"
$strEncrypted=Protect-CmsMessage -To DocumentEncryption.cer -Content $strProtect
$strEncrypted
Unprotect-CmsMessage -Content $strEncrypted

#Runspace
Get-Command *Runspace*

#Format-Hex
"This is a test for converting to hex" | Format-Hex

#Get-Clipboard and Set-Clipboard
"This is a test for Get-Clipboard"
Get-Clipboard
Set-Clipboard -Value "This is a test for Set-Clipboard"
This is a test for Set-Clipboard

#Clear-RecycleBin
Clear-RecycleBin -DriveLetter C:

#New-TemporaryFile
New-TemporaryFile 

#Get-Process -Id $pid -FileVersionInfo | Format-List *version* -Force
Get-Process -Id $pid -FileVersionInfo | fl *versionRaw*

#Get-Command
Get-Command Get-Date | fl Name, Version
Get-Command Get-Date -ShowCommandInfo

#Get-ItemPropertyValue
(Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine -Name ApplicationBase).ApplicationBase
Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine -Name ApplicationBase

#NetworkSwitch Module
Get-Command  *NetworkSwitch*



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_01_Code\1.5_Secure_string.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

$usr="sa"
$key=(1..32)
$saPW = "MyPassword" | ConvertTo-SecureString -asPlainText -Force
$diff1=$saPW | ConvertFrom-SecureString -Key $key

$saPW="MyPassword" | ConvertTo-SecureString -asPlainText -Force
$diff2=$saPW | ConvertFrom-SecureString -Key $key

$diff1 -eq $diff2 
$diff1
$diff2

$cred=New-Object -TypeName PSCredential -ArgumentList ($usr,($diff1 | ConvertTo-SecureString -Key $key ))
$cred.GetNetworkCredential().Password

$cred=New-Object -TypeName PSCredential -ArgumentList ($usr,($diff2 | ConvertTo-SecureString -Key $key ))
$cred.GetNetworkCredential().Password

#Password UI
$saPW=Read-Host -AsSecureString
$cred=New-Object -TypeName PSCredential -ArgumentList ($usr,($saPW))
$cred.GetNetworkCredential().Password

#Cryptographic Message Syntax
$strProtect="MyPassword"
$strEncrypted=Protect-CmsMessage -To DocumentEncryption.cer -Content $strProtect
$strEncrypted



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_01_Code\1.6_Windows_registry.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Get-Item
Get-Item -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | Select-Object -ExpandProperty Property

#Reading registry keys
Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | fl ProductName, CurrentBuild
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | fl ProductName, CurrentBuild
Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName,CurrentBuild

$PSVersionTable.PSVersion
Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine" -Name PowerShellVersion

#Set-Location
Set-Location -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
Get-ItemPropertyValue -Path . -Name ProductName,CurrentBuild
Set-Location -Path "C:\"
Set-Location -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion"

#Creating registry key
Get-ItemProperty -Path ./PowerShellPath -ErrorAction SilentlyContinue
New-ItemProperty -Path . -Name PowerShellPath -PropertyType String -Value $PSHome
Get-ItemPropertyValue -Path . -Name PowerShellPath

#Rename registry key
Rename-ItemProperty -Path . -Name PowerShellPath -NewName PSHome -PassThru
Get-ItemPropertyValue -Path . -Name PSHome

#Deleting registry key
Remove-ItemProperty -Path . -Name PSHome
Get-ItemPropertyValue -Path . -Name PSHome




c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_01_Code\1.7_Creating_objects.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

$arr=@()
For($i=0; $i -le 9; $i++)
{
    $obj=New-Object -TypeName PSObject
    Add-Member -InputObject $obj -MemberType NoteProperty -Name Index -Value "$($i)"
    Add-Member -InputObject $obj -MemberType NoteProperty -Name ID -Value "ID $($i+1)"
    Add-Member -InputObject $obj -MemberType NoteProperty -Name Name -Value "Name $($i+1)"
    $arr+=$obj
}
$arr.Count
$arr

$arr=@()
For($i=0; $i -le 9; $i++)
{
    $hash=@{
                Index=$i
                ID="ID $($i+1)"           
                Name="Name $($i+1)"          
           }                           
    $obj=New-Object -TypeName PSObject -Property $hash
    $arr+=$obj
}
$arr.Count
$arr



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_02_Code\2.1_Error_variable.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Throw a command not found exception error  
Get-ThisDoesNotExist
#View $error variable
$Error
#View Properties and methods of $error variable
$Error.Count
#View DataType of $error variable
$Error.GetType().Name
#Show $error variable exception message
$Error[0].Exception
#Show $error variable exception type
$Error[0].Exception.GetType().Name

#Trow a Parameter Binding Exception error
New-Object -PropertyDoesNotExist
#Show number of errors that have occurred
$Error.Count
#Show $error variable exception type
$Error[0].Exception.GetType().Name

#Trow a Runtime Exception error
$Error[1].Message.GetType().Name
#Show number of errors that have occurred
$Error.Count
#Show $error variable exception type
$Error[0].Exception.GetType().Name

#Call index of error message
$Error[0]
$Error[1]
$Error[2]

#Trow a Parameter Binding Validation Exception
New-Object $objNew
$Error[0].Exception.GetType().Name


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_02_Code\2.2_Error_action.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Error Action Preference
$ErrorActionPreference
$ErrorActionPreference = "Stop"
$ErrorActionPreference = "SilentlyContinue"

$Error.Count
1/0
$Error.Count
$Error[0].Exception

#Error Action Parameter
Get-ChildItem "H:\DoesNotExit" -ErrorAction "Ignore"
$Error.Count

Get-ChildItem "H:\DoesNotExit" -ErrorAction Inquire
Get-ChildItem "H:\DoesNotExit" -ea SilentlyContinue



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_02_Code\2.3_Catch_try_finally.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

Try
{
    new-object $objNew
}
Catch
{
    Write-Host "Caught a system exception"
}
Finally
{
    Write-Host "Clean up"
}

#Multiple Catch
Try
{
    1/0
    New-Object $test
}
Catch [DivideByZeroException]
{
    Write-Host “Caught a divide by zero exception”
}
Catch
{
    Write-Host “Caught an other exception”
}


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_02_Code\2.4_Using_color_for_debug.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

For($i=1; $i -le 10; $i++)
{
    IF($i % 2) 
    {
        Write-Host "$i is odd" -ForegroundColor Yellow
    }
    ELSE
    {
        Write-Host "$i is even" -ForegroundColor Red
    }
}

1..10 | % {IF($_ % 2 -eq 0 ) {Write-Host "$_ is even" -ForegroundColor Yellow} ELSE {Write-Host "$_ is odd" -ForegroundColor Green}}



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_02_Code\2.5_Event_Logging.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#New-EventLog
$strLogName="New Test Event"
$strLogSource=$strLogName
New-EventLog –LogName $strLogName –Source $strLogSource

#Write-EventLog
For($i=0; $i -lt 7; $i++){    
    IF($i % 2){$strType="Error"}ELSE{$strType="Warning"}
    $strMessage="Creating $strType event"
    Write-EventLog -LogName $strLogName -Source $strLogName -Message $strMessage -EventId $i -EntryType $strType    
}
Get-EventLog -List | ?{$_.Log -eq $strLogName}
Get-EventLog -LogName $strLogName -Newest 8 | ft Source,InstanceId,EntryType,Message

#Open Event Viewer
$strType="Infomation"
$strMessage="Creating $strType event"
Write-EventLog -LogName $strLogName -Source $strLogName -Message $strMessage -EventId 7 -EntryType Information
Show-EventLog


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_02_Code\2.6_Email_notification.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Remove before start
$strTo="hhorn@mis-munich.de"
$strServer="mbx1.mis-munich.de"
#Send-MailMessage
$strTo="error@mydomain.com"
$strFrom="script@mydomain.com"
$strSubject="Script Error"
$strBody="The follow error occurred: $($Error[0].Exception)"
$strServer="mail.mydomain.com"
Send-MailMessage -To $strTo -From $strFrom -Subject $strSubject -Body $strBody -SmtpServer $strServer

#ConvertTo-HTML
$arr=@()
For($i=0; $i -le 9; $i++)
{
    $hash=@{
                Index=$i
                ID="ID $($i+1)"           
                Name="Name $($i+1)"          
           }                           
    $obj=New-Object -TypeName PSObject -Property $hash
    $arr+=$obj
}
[string]$htmlBody=$arr | ConvertTo-HTML -CssUri 2.6.css
Send-MailMessage -To $strTo -From $strFrom -Subject $strSubject -BodyAsHtml $htmlBody -SmtpServer $strServer -Attachments 2.6.css



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_03_Code\5606_03_01_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Environment variables
Get-ChildItem -Path Env: | ft Name
$env:USERNAME
$env:COMPUTERNAME
$env:SystemDrive

#Set environment variables
$env:TEAM="it"
Set-Item -path env:TEAM -Value "$($env:TEAM)-admin"
$env:TEAM

#Create folders
$strHomeDir="\\MyServer\Share\home\$env:USERNAME"
$strHomeDir="C:\Test\home\$env:USERNAME"
If(!(Test-Path -Path "filesystem::$($strHomeDir)"))
{
    New-Item –Path "filesystem::$($strHomeDir)" -ItemType Directory
    Write-Host "Home Directory created for $($env:USERNAME): $($strHomeDir)" -ForegroundColor Yellow
}

#Move folders
$strMoved="$($strHomeDir)_old"
Move-Item –Path $strHomeDir -Destination $strMoved -Confirm:$false
Write-Host "Moved folder from $($strHomeDir) to $($strMoved)." -ForegroundColor Yellow

#Rename folders
$strNew="$($strMoved)_new"
Rename-Item –Path $strMoved -NewName $strNew -Confirm:$false
Write-Host "Renamed folder from $($strMoved) to $($strNew)." -ForegroundColor Yellow

#Delete folders
Remove-Item –Path C:\Test\Home -Confirm:$false -Recurse
Write-Host "Folder deleted: C:\Test\Home." -ForegroundColor Yellow

#Create files
$strFolder="C:\Test\3_1"
$strFile="test.txt"
New-Item –Path $strFolder -ItemType File -Name $strFile

#Overwrite File
New-Item -Path "$strFolder" -ItemType File -Name $strFile -Value "We will add some content" -Force

#Move, Rename, Delete files
Move-Item -Path "$strFolder\$strFile" -Destination "$($strFolder)\$($strFile)_old"
Get-ChildItem $strFolder
Rename-Item -Path "$($strFolder)\$($strFile)_old" -NewName "$($strFolder)\$($strFile)"
dir $strFolder
Remove-Item "$strFolder\$strFile"
ls $strFolder



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_03_Code\5606_03_02_Code.ps1
************************************************************************
﻿######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

$strHomeDir="C:\Test\home\$env:USERNAME"
New-Item –Path "filesystem::$($strHomeDir)" -ItemType Directory

#View ACLs 
Get-Acl $strHomeDir | %{$_.Access} | ?{$_.IdentityReference -eq "BUILTIN\Administrators"}
Get-Acl $strHomeDir | %{$_.Access.Count}

#Remove inheritance
$Acl=Get-Acl $strHomeDir
$Acl.SetAccessRuleProtection($true,$false)
Set-Acl -Path $strHomeDir -AclObject $Acl
Get-Acl $strHomeDir | %{$_.Access.Count}

#Create ACE
$Acl=Get-Acl $strHomeDir
$acePerm = "$($env:USERDNSDOMAIN)\Domain Admins","FullControl","ContainerInherit,ObjectInherit","None","Allow"    
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($acePerm)
$Acl.SetAccessRule($AccessRule)
$acePerm = "SYSTEM","FullControl","ContainerInherit,ObjectInherit","None","Allow"    
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($acePerm)
$Acl.SetAccessRule($AccessRule)
$acePerm = "$($env:USERDNSDOMAIN)\$($env:USERNAME)","FullControl","None","None","Allow"    
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($acePerm)
$Acl.SetAccessRule($AccessRule)

#Set ACL
Get-Acl $strHomeDir | %{$_.Access.Count}
Set-Acl -Path $strHomeDir -AclObject $Acl
Get-Acl $strHomeDir | %{$_.Access.Count}
Get-Acl $strHomeDir | %{$_.Access} | ?{$_.IdentityReference -eq "BUILTIN\Administrators"}
Get-Acl $strHomeDir | %{$_.Access} | ?{$_.IdentityReference -eq "NT AUTHORITY\SYSTEM"}

#Check inheritance
New-Item –Path "$($strHomeDir)\Documents" -Type Directory
$Acl=Get-Acl "$($strHomeDir)\Documents"
$Acl | %{$_.Access} | ?{$_.IdentityReference -eq "NT AUTHORITY\SYSTEM"}
$Acl | %{$_.Access.Count}

#Remove all ACEs
$Acl=Get-Acl $strHomeDir
$Acl.Access | %{$Acl.PurgeAccessRules($_.IdentityReference)}
Set-Acl -Path $strHomeDir -AclObject $Acl
Get-Acl $strHomeDir | %{$_.Access.Count}


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_03_Code\5606_03_03_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Reading files
Get-Content -Path C:\Test\Sort.txt
Get-Content C:\Test\Sort.txt | Sort-Object
Get-Content C:\Test\Sort.txt | Sort-Object -Descending
Get-Content C:\Test\Sort.txt | Sort-Object -Unique

#Measure-Object
Get-Content C:\Test\NewsArticle.txt | Measure-Object –Line
Get-Content C:\Test\NewsArticle.txt | Measure-Object -Character
Get-Content C:\Test\NewsArticle.txt | Measure-Object –Word

#Limiting the output
(Get-Content C:\Test\Test1.txt)[0 .. 2]
Get-Content C:\Test\Test1.txt -TotalCount 3
Get-Content C:\Test\Test1.txt -Head 3
Get-Content C:\Test\Test1.txt -First 3

(Get-Content C:\Test\Test1.txt)[-3 .. -1]
Get-Content C:\Test\Test1.txt -Tail 3
Get-Content C:\Test\Test1.txt -Last 3

(Get-Content C:\Test\Test1.txt)[-1 .. -3]
(Get-Content C:\Test\Test1.txt)[3 .. 5]

#Write Files
Set-Content C:\Test\TestHello.txt -Value "Hello, World"
Get-Content C:\Test\TestHello.txt
"Hello, World with bigger than" > C:\Test\TestHello.txt
Get-Content C:\Test\TestHello.txt
"Hello, World with Out-File" | Out-File -FilePath C:\Test\TestHello.txt
Get-Content C:\Test\TestHello.txt

Get-Content C:\Test\Sort.txt -Head 3 | Set-Content C:\Test\Sample.txt
Get-Content C:\Test\Sample.txt

#Add Content
Add-Content C:\Test\TestHello.txt -Value "Hello, World"
Get-Content C:\Test\TestHello.txt

"Hello, World" >> C:\Test\TestHello.txt
Get-Content C:\Test\TestHello.txt

$strTest="We will add the first line`n"
$strTest+="We will add the second line`n"
$strTest+="We will add the last line`n"
$strTest | Set-Content C:\Test\Sample.txt
Get-Content C:\Test\Sample.txt

#Replace Content
(Get-Content C:\Test\TestHello.txt) | %{$_ -replace "Hello", "#"} | Set-Content -Path C:\Test\TestHello.txt
Get-Content C:\Test\TestHello.txt



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_03_Code\5606_03_04_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Export-Csv
$service=Get-Service | ?{$_.Name -eq "Spooler"}
Export-Csv -Path C:\Test\Services.csv

#Export-Csv -NoTypeInformation
Get-Content C:\Test\Services.csv -TotalCount 1
$service | Export-Csv C:\Test\Services.csv -NoTypeInformation
Get-Content C:\Test\Services.csv -TotalCount 1

#Export-Csv -Encoding
$service | Export-Csv C:\Test\Services.csv -Encoding "Unicode" -NoType

#Export-Csv -Delimiter
$service | Export-Csv C:\Test\Services.csv -Delimiter ";" -NoType
Get-Content C:\Test\Services.csv

#Export-Csv -Force
$service | Export-Csv C:\Test\Services.csv -Force -NoType

#Export-Csv -UseCulture
Get-Date | Export-Csv –Path C:\Test\Date.csv -UseCulture -NoType
Get-Content C:\Test\Date.csv -TotalCount 1

#Export-Csv -Append
Get-Date | Select-Object Second,MilliSecond | Export-Csv –Path C:\Test\Append.csv -NoT
For($i=1; $i -lt 8; $i++)
{
    Get-Date | Select-Object Second,MilliSecond | Export-Csv –Path C:\Test\Append.csv -Append 
    Start-Sleep -Milliseconds 10
}
Get-Content C:\Test\Append.csv

#Export-Csv -Append with New-Object
Get-Content C:\Test\Employees.csv -Head 1
$csv=Get-Content C:\Test\Employees.csv
$csv.Count
$obj=New-Object -TypeName PSObject -Property @{"Name"="Heiko Horn";"Department"="IT";"Jobtitle"="PowerShell Admin"}
Export-Csv -InputObject $obj -Path C:\Test\Employees.csv -Append
$csv=Get-Content C:\Test\Employees.csv
$csv.Count
$csv

#Delete last line from $csv
$csv=$csv[0..($csv.count - 2)] | Set-Content –Path C:\Test\Employees.csv
Get-Content C:\Test\Employees.csv

#Import-Csv
Import-Csv -Path C:\Test\Services.csv
Import-Csv C:\Test\Employees.csv | ?{$_.Department -eq "Finance"}

#ConvertTo-Csv
$obj=Get-Process | ?{$_.Name -eq "spoolsv"} | ConvertTo-Csv

#ConvertFrom-Csv with Header
$obj.Count
$obj[0]
$obj[1]
$arrHeader = "MoreData","StatusMessage","Location","Command","State","Finished","InstanceId"
#Delete header from $obj
$obj = $obj[0], $obj[2..($obj.Count - 1)]
$obj | ConvertFrom-Csv -Header $arrHeader



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_03_Code\5606_03_05_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

Get-Content C:\Temp\a.csv

$sr=New-Object System.IO.StreamReader(Get-Item C:\Temp\a.csv)
$dest=New-Object System.IO.StreamWriter -ArgumentList "C:\Temp\b.csv"
$i=0
While (($line=$sr.ReadLine()) -ne $null){
    $dest.WriteLine($line.Substring(0,$line.IndexOf(',')+1)+$i)
    $i++
}
$dest.Close()
$sr.Close()
$sr.Dispose()
$dest.Dispose()

Get-Content C:\Temp\b.csv



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_03_Code\5606_03_06_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

$results=@()
$dirs=Get-ChildItem X:\Documents\WindowsPowerShell -Recurse -Directory
ForEach($dir in $dirs) { 
	$files=Get-ChildItem $dir.PSPath
	$total=0
	ForEach($file in $files) { 
		$total+=$file.Length
	}
	$results+=New-Object PSObject -Property @{Folder=$dir.fullname;Size=$total} 
}
$results | Sort-Object -Property Folder | ft
$results | Sort-Object -Property File | ft
$results.Count

#Display biggest folder
($results | Sort-Object -Property Size -Descending )[0]



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_03_Code\5606_03_07_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

$strPath="C:\Test"
"Started search and delete process" > DeleteLog.txt
$objDelete=Get-ChildItem -Path $strPath -Recurse -File -Attributes Hidden, Normal | ?{$_ -LIKE "~$*"}
"We found $($objDelete.Count) items to delete" >> DeleteLog.txt
ForEach ($item in $objDelete)
{
	"Deleted item: $($item.FullName)" >> DeleteLog.txt
	#Remove-Item $item.FullName -Force
}
"Finished process" >> DeleteLog.txt
Get-Content DeleteLog.txt


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_04_Code\5606_04_01_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Import-Module with PSSession
$strServer="MySQLServer"
Get-Command Invoke-Sqlcmd -ErrorAction SilentlyContinue
$psSession=New-PSSession -Computer $strServer
Import-PSSession -Session $psSession -ErrorAction Continue -Module SQLPS
Get-Command Invoke-Sqlcmd

#Create Dataset
$strDB="MySQLDatabase"
$strUser="MySQLUser"
$strPW="MySQLPassword"
$objDataset=Invoke-Sqlcmd -Query "Select * from staff" -Server $strServer -Database $strDB -Username $strUser -Password $strPW
$objDataset.Count

#Clean up PSSession
$psSession | Remove-PSSession

#DataSet without PSSQL Module
Get-Command Invoke-Sqlcmd -ErrorAction SilentlyContinue
$psSession=New-PSSession -Computer $strServer
$objDataset=Invoke-Command -Session $psSession -ArgumentList @{server=$strServe;database=$strDB;username=$strUser;password=$strPW} -ScriptBlock {Invoke-Sqlcmd -Query "Select * from staff" -Server $args.server -Database $args.database -Username $args.username -Password $args.password}
Remove-PSSession -Session $psSession
$objDataset.Count



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_04_Code\5606_04_02_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Create dataset with Invoke-Sqlcmd
$strServer="MySQLServer"
$strDB="MySQLDatabase"
$strUser="MySQLUser"
$strPW="MySQLPassword"
$strQuery="SELECT * FROM staff"
$objDS=Invoke-Sqlcmd -Query $strQuery -Server $strServer -Database $strDB -Username $strUser -Password $strPW
$objDS.GetType() | fl Name, BaseType
$objDS.Count

#Invoke-Sqlcmd with InputFile
$strFile="c:/TEST/test.sql"
$objDS=Invoke-Sqlcmd -InputFile $strFile -Server $strServer -Database $strDB -Username $strUser -Password $strPW
$objDS.Count

#Foreach Loop
ForEach ($item in $objDataSet)
{
    "User ID: $($item.UserIdent)"
}

#ForEach-Object
$objDS | %{"User ID: $($_.UserIdent)"}

#Creating DataSet
$strCS="Server=$($strServer);Database=$($strDB);User ID=$($strUser);Password=$($strPW);"
$conn=New-Object -TypeName System.Data.SqlClient.SqlConnection
$conn.ConnectionString=$strCS
$conn.Open()

$cmd=New-Object -TypeName System.Data.SqlClient.SqlCommand
$strQuery="SELECT * FROM staff"
$cmd.CommandText=$strQuery
$cmd.Connection=$conn
$da=New-Object -TypeName System.Data.SqlClient.SqlDataAdapter($cmd)
$da.SelectCommand=$cmd
$ds=New-Object -TypeName System.Data.DataSet
$intCount=$da.Fill($ds)
$conn.Close()
$intCount
$ds.GetType().Name
$ds.Tables[0] | %{"User ID: $($_.UserIdent)"}



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_04_Code\5606_04_03_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Create Variables
$strUser="powershell"
$strPW="myPassword"
$strDB="mysql"
$strServer="mysql-test"

#Connecting to MySQL
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$conn=New-Object MySql.Data.MySqlClient.MySqlConnection
$cs="server=$($strServer);port=3306;database=$($strDB);uid=$($strUser);pwd=$($strPW)"
$conn.ConnectionString=$cs
$conn.Open()



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_04_Code\5606_04_04_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Querying MySQL with Data Set
$query="SELECT * FROM mysql.user;"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$da=New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)
$ds=New-Object System.Data.DataSet
$da.Fill($ds)

$ds.Tables.Count
$ds.Tables.Rows.Count
$ds.Tables.Rows.Host
$ds.Tables[0].Rows[12].User

#CREATE DATABASE with ExecuteNonQuery
$query="CREATE DATABASE my_db;"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.ExecuteNonQuery()

#USE with ExecuteNonQuery
$query="USE my_db;"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.ExecuteNonQuery()

#CREATE TABLE with ExecuteNonQuery
$query="CREATE TABLE animals (
    id INT NOT NULL AUTO_INCREMENT,
    name CHAR(30) NOT NULL,
    PRIMARY KEY (id)
    );"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.ExecuteNonQuery()

#INSERT with ExecuteNonQuery
$query="INSERT INTO animals (name) VALUES
    ('dog'),('cat'),('penguin'),
    ('lax'),('whale'),('ostrich');
    ;"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.ExecuteNonQuery()

#UPDATE with ExecuteNonQuery
$query="UPDATE animals SET name='mouse' WHERE name='lax';"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.ExecuteNonQuery()

#DELETE with ExecuteNonQuery
$query="DELETE FROM animals WHERE name='whale';"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.ExecuteNonQuery()

#Parameters with @
$query="SELECT * FROM animals WHERE id=@id"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.Parameters.AddWithValue("@id", 3);
$da=New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)
$ds=New-Object System.Data.DataSet
$da.Fill($ds)
$ds.Tables.Rows

#Parameters with ?
$query="SELECT * FROM animals WHERE id=?id"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.Parameters.AddWithValue("id", 3);
$da=New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)
$ds=New-Object System.Data.DataSet
$da.Fill($ds)
$ds.Tables.Rows

#Aggrigation with ExecuteScalar
$query="SELECT COUNT(*) FROM animals;"
$cmd=New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.ExecuteScalar()

#DROP DATABASE with ExecuteNonQuery
$query = "DROP DATABASE my_db;"
$cmd = New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$cmd.ExecuteNonQuery()

#Close MySQL connection
$conn.Close()


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_04_Code\5606_04_05_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#ConvertTo-XML with InputObject
$strXml="C:\Test\4_5\Test.xml"
$obj=New-Object -TypeName PSObject -Property @{"Jobtitle"="PowerShell Admin";"Department"="IT";"Name"="Heiko Horn"}
$xml=ConvertTo-Xml -InputObject $obj
$xml.Save($strXml)
Get-Content $strXml

#ConvertTo-XML with NoTypeInformation
$xml=ConvertTo-Xml -InputObject $obj -NoTypeInformation
$xml.Save($strXml)
Get-Content $strXml

#Selecting node information with Property
$xml.Objects.Object.Property.Name
$xml.Objects.Object.Property.InnerText

#Selecting node information with XPath
$xml.SelectNodes("Objects/Object/Property")
$xml.SelectNodes("Objects/Object/Property[@Name=""Jobtitle""]")

#ConvertTo-XML with Pipeline
[xml]$xml=ps A* | ConvertTo-Xml -Depth 1

$xml.Objects.Object.Property.Name
$xml.SelectNodes("Objects/Object/Property[@Name=""Description"" and @Type=""System.String""]")

#Export-Clixml
$strXml="C:\Test\4_5\sample.xml"
ps spoolsv | Export-Clixml -Path $strXml
Get-Content $strXml

#Import-Clixml
Import-Clixml $strXml

#Creating XML
$strXml="C:\Test\4_5\config.xml"
$xml=New-Object -TypeName XML
$xmlRoot=$xml.CreateElement("Config")
$xml.appendChild($xmlRoot)

$xmlRoot.SetAttribute("Description","Config file for testing")
$xml.Config.Description

$xmlL1=$xmlRoot.AppendChild($xml.CreateElement("System"))
$xmlL1.SetAttribute("Description","Document Management")

$xmlL2=$xmlL1.AppendChild($xml.CreateElement("Document"))
$xmlL2.SetAttribute("authorFirstName","First1")
$xmlL2.SetAttribute("authorSurname","Author1")
$xmlL2.SetAttribute("date",$(get-date))
$xmlL2.SetAttribute("description","Document 1")
$xmlL2.SetAttribute("index","3")
$xmlL2.InnerText="C:\temp\doc0001.txt"

$xml.Save($strXml)
Get-Content $strXml
$xml.Config.System.Document.description



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_04_Code\5606_04_06_Code.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#ConvertTo-Json
Get-Date "2000-01-01" | Select-Object -Property * | ConvertTo-Json

$objDate=(Get-Date "2000-01-01") | Select-Object -Property *
$jsonDate=ConvertTo-Json -InputObject $objDate
$jsonDate

ConvertTo-Json -InputObject (Get-Date "2000-01-01" | Select-Object -Property *)

#ConvertFrom-Json with Web Request


$jsonRequest=Invoke-WebRequest -Uri http://freegeoip.net/json/1.1.1.1
$jsonRequest.Content

$objJson=$jsonRequest | ConvertFrom-Json
$objJson.GetType().Name

$objJson.country_name
$objJson.time_zone

#ConvertFrom-Json with InputObject
ConvertFrom-Json -InputObject $jsonDate

#ConvertFrom-Json with array
Get-Content C:\test\4_6\Test.JSON
$objJson=Get-Content C:\test\4_6\Test.JSON | ConvertFrom-Json
$objJson
$objJson.phoneNumber[0..1]



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_05_Code\5.1_Remote_AD.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Import-Module ActiveDirectory
$strADServer="ad.mydomain.com"
Get-Command Get-ADUser -ea SilentlyContinue
$psSession=New-Pssession -Computer $strADServer
Import-PSSession -Session $psSession -Module ActiveDirectory
Get-Command Get-ADUser
Remove-PSSession $psSession

#Remote Command
Get-Command Get-ADUser -ea SilentlyContinue
$psSession=New-Pssession -Computer $strADServer
$strAD="hhorn"
$adUser=Invoke-Command -Session $psSession -ArgumentList @{SamAccountName=$strAD} -Script {Get-ADUser $args.SamAccountName}
$adUser.SamAccountName
Remove-PSSession $psSession

#Copy Module
Get-Command Get-ADUser -ea SilentlyContinue
Invoke-Command -Session $psSession -Script {Import-Module ActiveDirectory}
Export-PSSession -Session $psSession -Module ActiveDirectory -OutputModule MyAD -
Get-Command Get-ADUser

Remove-PSSession $psSession
Get-Command Get-ADUser

#Remove Active Direcroty Module
Remove-Module MyAD
rm .\Documents\WindowsPowerShell\Modules\MyAD -Recurse



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_05_Code\5.2_AD_users.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Get-ADUser -Identity
Get-ADUser -Identity hhorn | ft SamAccountName

#Get-ADUser -Filter
Get-ADUser -Filter {sAMAccountName -eq "hhorn"} | ft SamAccountName
Get-ADUser -Filter 'GivenName -eq "Heiko"' | ft SamAccountName
 
(Get-Aduser -Filter "Created -ge ""$((Get-Date).AddDays(-90).ToString("dd/MM/yyyy") )""").Count

#Get-ADUser -LDAPFilter
Get-ADUser -LDAPFilter “(sAMAccountName=hhorn)” | ft SamAccountName

#Properties
(Get-ADUser -Identity hhorn | Get-Member -MemberType Properties).Count
Get-ADUser -Identity hhorn | Get-Member -MemberType Properties
(Get-ADUser -Identity hhorn -Properties accountExpires,extensionAttribute1 | Get-Member -MemberType Properties).Count
(Get-ADUser -Identity hhorn -Properties * | Get-Member -MemberType Properties).Count

#ResultSetSize
(Get-ADUser -Filter * -ResultSetSize 10).Count
(Get-ADUser -Filter * -ResultSetSize $null).Count

#Get-ADObject
(Get-ADObject -Filter {(mail -like "hhorn*") -and (ObjectClass -eq "user")} -Properties sAMAccountName).sAMAccountName

#New-ADUser
New-ADUser -Name 123
Get-ADUser -Identity 123 | fl Enabled

#Set-ADUser
Set-ADUser -Identity 123 -Description "123Test"

#Resetting a password
Set-ADAccountPassword -Identity 123 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Test345!" -Force)

#Enable-ADAccount & Disable-ADAccount
Enable-ADAccount -Identity 123
Get-ADUser -Identity 123 | fl Enabled
Disable-ADAccount -identity 123 -Confirm:$false
Get-ADUser -Identity 123 | fl Enabled

#Remove-ADUser
ForEach($item in (Get-ADUser -Filter 'Description -eq "123Test"'))
{
    Write-Host "Deleting $($item.SamAccountName) from Active Directory"
    Remove-ADUser -Identity $item.SamAccountName -Confirm:$false
}



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_05_Code\5.3_AD_groups.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Set variables
$arrUsers="hhorn","mhorn" 
$arrGroups="test0","test1","test2","test3"

#New-ADGroup
New-ADGroup -Name test0 -SamAccountName test0 -GroupCategory Security -GroupScope Universal -DisplayName test0

#Get-ADGroup
(Get-ADGroup test0 | Get-Member -MemberType Properties).Count
Get-ADGroup it | Get-Member -MemberType Properties | ft Name
(Get-ADGroup test0 -Properties * | Get-Member -MemberType Properties).Count
(Get-ADGroup test0 -Properties ProtectedFromAccidentalDeletion,Members | Get-Member -MemberType Properties).Count
(Get-ADGroup test0 -Properties extensionAttribute1 | Get-Member -MemberType Properties).Count

#Add-ADGroupMember
ForEach($group in $arrGroups)
{
    Try
    {
        IF(Get-ADGroup $group)
        {
            Write-Host "Group exist" -ForegroundColor Yellow
            ForEach($user in $arrUsers)
            {
                Write-Host "Adding Member $($user)" -ForegroundColor White
                Add-ADGroupMember $group -Members $user
            }
        }
    }
    Catch
    {
        Write-Host "Group does not exist" -ForegroundColor Magenta
        New-ADGroup -Name $group -SamAccountName $group -GroupCategory Security -GroupScope Universal -DisplayName $group
        ForEach($user in $arrUsers)
        {
            Write-Host "Adding Member $($user)" -ForegroundColor White
            
            Add-ADGroupMember $group -Members $user
        }
    }
}
Get-ADGroup -Filter 'Name -like "test*"' | fl Name
Get-ADGroupMember test0 | fl SamAccountName

#Set-ADGroup
Set-ADGroup test0 -Description "Test Group"
Get-ADGroup test0 -Properties Description | fl SamAccountName, Description

#Remove-ADGroupMember
ForEach($user in $arrUsers)
{
    Remove-ADGroupMember test0 -Members $user -Confirm:$false
}
Get-ADGroupMember test0

#Remove-ADGroup
ForEach($group in $arrGroups)
{
    Remove-ADGroup $group -Confirm:$false
}
Get-ADGroup -Filter 'Name -like "test*"'


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_05_Code\5.4_AD_computers.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Get-ADComputer
(Get-ADComputer -Filter 'OperatingSystem -like "Windows 10*"').Count

#New-ADComputer
$strComp="TEST-PC"
New-ADComputer -Name $strComp -SamAccountName $strComp
Get-ADComputer $strComp | fl Enabled

#Properties
(Get-ADComputer $strComp | Get-Member -MemberType Properties).Count
(Get-ADComputer $strComp -Properties * | Get-Member -MemberType Properties).Count

#LastLogonDate Property
Get-ADComputer $strComp | ft Name, LastLogonDate

#Created Property
Get-ADComputer $strComp | ?{$_.Created -ge (Get-Date).AddDays(-1)} | ft Name
Get-ADComputer $strComp -Properties * | ?{$_.Created -ge (Get-Date).AddDays(-1)} | ft Name

#Remove-ADComputer
Remove-ADComputer $strComp -Confirm:$false

#Find user logged on to Computer
$strUser="hhorn"
$objComps=Get-ADComputer -Filter 'name -like "*heiko*"'
ForEach($comp in $objComps)
{
	$strComp=$comp.Name
	$ping=New-Object System.Net.NetworkInformation.Ping
  	$Reply=$null
  	$Reply=$ping.send($strComp)
  	IF($Reply.status -like 'Success')
    {
		$proc=gwmi win32_process -ComputerName $strComp -Filter "Name='explorer.exe'"
        ForEach ($p in $proc)
        {
	  	    $strOwner=($p.GetOwner()).User
            IF($strOwner -eq $strUser)
            {
			    Write-Host "$strUser is logged on to $strComp"
            }
        }
    }
}


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_05_Code\5.5_AD_OUs.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#New-ADOrganizationalUnit & Get-ADOrganizationalUnit
$strBaseDN="DC=mydomain,DC=com"
$strOU="OU=TestUserAccounts,$($strBaseDN)"
$strSeeAlso="CN=HumanResourceManagers,$($strBaseDN)"
$strManagedBy="CN=Heiko Horn,CN=Users,$($strBaseDN)"
New-ADOrganizationalUnit -Name TestUserAccounts -Path $strBaseDN -OtherAttributes @{seeAlso=$strSeeAlso;managedBy=$strManagedBy}
Get-ADOrganizationalUnit $strOU -Properties * | ft ProtectedFromAccidentalDeletion

#Set-ADOrganizationalUnit
Set-ADOrganizationalUnit $strOU -ProtectedFromAccidentalDeletion $false

#Remove-ADOrganizationalUnit
Remove-ADOrganizationalUnit $strOU -Confirm:$false

#SearchBase
$strSearchBaseServers="OU=Applicationservers,DC=mydomain,DC=com"
(Get-ADComputer -SearchBase $strSearchBaseServers -Filter *).Count
(Get-ADOrganizationalUnit -SearchBase $strBaseDN -Filter *).Count
(Get-ADObject -Filter 'ObjectClass -eq "organizationalunit"').Count

#SearchScope
$strSearchBaseUsers="OU=UserAccounts,DC=mydomain,DC=com"
(Get-ADUser -SearchBase $strSearchBaseUsers -SearchScope OneLevel -Filter *).Count
(Get-ADUser -SearchBase $strSearchBaseUsers -SearchScope 2 -Filter *).Count

#Create OU from TXT file
$objTXT=Get-Content 5.5.txt
$strBaseDN="DC=mydomain,DC=com"
ForEach($item in $objTXT)
{
    $strOU=""
    IF($item -eq ""){Write-Host "--------------------------------------------------" }
    ELSE
    {
        $arrBaseOU=(Split-Path $item -Parent).Split('\')
        ForEach($ou in $arrBaseOU)
        {
            IF(!$ou.Length -eq 0)
            {
                $strOU=$strOU + 'OU=' + $ou + ','
            }   
        }
        $strOU += $strBaseDN
        $strName=Split-Path $item -Leaf
        Write-Host "-Name: $strName -Path: $strOU" -ForegroundColor Yellow
        New-ADOrganizationalUnit -Name "$strName" -Path $strOU -ProtectedFromAccidentalDeletion $false
    }
}


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_06_Code\6.2_AD_User_import.ps1
************************************************************************
﻿######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Set Variables
### SQL Variables ###
$strSQLserver="mssql.mydomain.com"
$strSQLdb="mydatabase"
$strQuery="SELECT * FROM xxx_ad_userimport"
$strReg="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\PowerShellScripts\Create-Users"
$strSQLusr="powershell"
$objReg=Get-ItemProperty -Path $strReg
$strSQLpw=Unprotect-CmsMessage -Content ([string]$objReg.CertPW)

### EMAIL Variables ###
$strTo="it@mydomain.com"
$strFrom="UserImport@mydomain.com"
$strServer="smtp.mydomain.com"
$strSubject="Active Directory User Creator"
$strHtmlBody="<H2>Users imported into Active Directory</H2>"
$strHtmlError="<<H2 style=""color:red;"">Failed to import into Active Directory users</H2>"
$strHtmlExists="<H2 style=""color:magenta;"">Users already exist in Active Directory</H2>"
$arrNew=@()
$arrError=@()
$arrExists=@()
$strCss="c:\style.css"

### LOG Variables ###
$LogParameter=$args
$strLogName="Active Directory Import"
$strLogSource=$strLogName

#Write to Eventlog
$LogMessage="Import script started (on $(Get-Date) )"
Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Information –EventID 1 –Message $LogMessage

### ACTIVE DIRECTORY Variables ###
$adServer="ad.mydomain.com"
$strHomeDrive="X:"

#Import ActiveDirectory Module
IF(!(Get-Command Get-ADUser -ErrorAction SilentlyContinue)){
    Try {
        Write-Host "Importing Active Directory Module"
        Import-Module ActiveDirectory 
        IF(!(Get-Command Get-ADUser -ErrorAction SilentlyContinue)){
            $psAD=New-PSSession -ComputerName $adServer
            Import-PSSession -Session $psAD -Module ActiveDirectory
        }
    } 
    Catch { 
        $ErrorMessage=$_.Exception.Message
        $strErrorMessage="ActiveDirectory Module couldn't be loaded: $($ErrorMessage)"
        $strhtmlErrorBody="<H3 style='color:red'>[ERROR]`t $($strErrorMessage)</H3>"
        Send-MailMessage -to $strTo -from $strFrom -subject $strSubject -BodyAsHtml $strhtmlErrorBody -SmtpServer $strServer
        Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Warning –EventID 1 –Message $strErrorMessage
        Write-Host "[ERROR]`t $($strErrorMessage) Script will stop!" -ForegroundColor Red
        Exit 1 
    }
}
#Import SQL Module
IF(!(Get-Command Invoke-Sqlcmd -ErrorAction SilentlyContinue)){
    Try {
        Write-Host "Importing SQL Module"
        Import-Module SQLPS
        IF(!(Get-Command Invoke-Sqlcmd -ErrorAction SilentlyContinue)){
            $psSQL=New-PSSession -ComputerName $strSQLServer
            Import-PSSession -Session $psSQL -Module SQLPS
        }
    } 
    Catch { 
        $ErrorMessage=$_.Exception.Message
        $strErrorMessage="SQL Module couldn't be loaded: $($ErrorMessage)"
        $strhtmlErrorBody="<H3 style='color:red'>[ERROR]`t $($strErrorMessage)</H3>"
        Send-MailMessage -to $strTo -from $strFrom -subject $strSubject -BodyAsHtml $strhtmlErrorBody -SmtpServer $strServer
        Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Warning –EventID 1 –Message $strErrorMessage
        Write-Host "[ERROR]`t $($strErrorMessage) Script will stop!" -ForegroundColor Red
        Remove-PSSession $EMSsession
        Exit 1 
    }
}

#Import Data into dataset
Try {
    $objDataSet=Invoke-Sqlcmd -Query $strQuery -ServerInstance $strSQLserver -Database $strSQLdb -Username $strSQLusr -Password $strSQLpw
}
Catch {
    $ErrorMessage=$_.Exception.Message
    $strErrorMessage="Connection to SQL Server has failed: $($ErrorMessage)"
    $strhtmlErrorBody="<H3 style='color:red'>[ERROR]`t $($strErrorMessage)</H3>"
    Send-MailMessage -to $strTo -from $strFrom -subject $strSubject -BodyAsHtml $strhtmlErrorBody -SmtpServer $strServer
    Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Warning –EventID 1 –Message $strErrorMessage
    Write-Host "[ERROR]`t $($strErrorMessage) Script will stop!" -ForegroundColor Red
    Exit 1
}
### Additional AD Variables ###
$strDNSroot=(Get-ADDomain).DNSRoot
$strDNroot=(Get-ADDomain).DistinguishedName
$strUserOU="CN=Users"
### FILESERVER Variables ###
$strFileServer="files.$($strDNSroot)"
$strUsersFolder="filesystem::\\$($strFileServer)\Users"

#Create user variables from Dataset
ForEach($item in $objDataSet){
    $strSamaccountName=$item.sAMAccountName
    $strEmployeeNumber=$item.employeeNumber
    $strGivenName=$item.givenName
    $strSurname=$item.sn
    $strMail="$strSamaccountName@$strDNSroot"
    $strDisplayName="$strGivenName $strSurname"
    $strCN="CN=$strDisplayName"
    $strDN="$strCN,$strUserOU,$strDNroot"
    $strOU=$strDN
    $strHomeDirectory="$strUsersFolder\$strSamaccountName"
    $strHomeDrive=$strHomeDrive
    $arrGroups=@($item.Group1,$item.Group2)
    $strPassword=$item.Password
    
    #Check if users exists
    IF(!(Get-ADUser -LDAPFilter "(employeeNumber=$strEmployeeNumber)")){
        IF(!(Get-ADUser -LDAPFilter "(sAMAccountName=$strsAMAccountName)")){        
            #Create Active Directory User
            Try {                
                New-ADUser -Name $strDisplayName -EmployeeNumber $strEmployeeNumber -SamAccountName $strSamaccountName -GivenName $strGivenName -Surname $strSurname -DisplayName $strDisplayName -EmailAddress $strMail -homeDirectory $strhomeDirectory -homeDrive $strhomeDrive -Path $strOU -AccountPassword $strPassword -Enabled $true
                $hash=@{EmployeeNumber=$strEmployeeNumber;Name=$strDisplayName;sAMAccountName=$strsAMAccountName;EmailAddress=$strMail;OU=$strOU;AccountPassword=$strPassword;homeDirectory=$strhomeDirectory;homeSuccess="";homeDrive=$strhomeDrive;group1="";group1Success="";group2="";group2Success="";Path="";pathSuccess=""}
                $objNew=New-Object -TypeName PSObject -Property $hash
                $arrNew+=$objNew
                $LogMessage="$($strEmployeeNumber) - $($strsAMAccountName): Users created SUCCESSFULLY"
                Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Information –EventID 1 –Message $LogMessage
                Write-Host "[INFO]`t $($LogMessage)" 
            }
            Catch {
                $LogMessage="$($strEmployeeNumber) - $($strsAMAccountName): ERROR created user: $($_.Exception.Message)"
                $hash=@{EmployeeNumber=$strEmployeeNumber;Name=$strDisplayName;sAMAccountName=$strsAMAccountName;EmailAddress=$strMail;OU=$strOU;AccountPassword=$strPassword}                           
                $objError=New-Object -TypeName PSObject -Property $hash
                $arrError+=$objError
                Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Warning –EventID 1 –Message $LogMessage
                Write-Host "[SKIP]`t $($LogMessage)" -ForegroundColor Magenta
                Continue
            }
            #Add user to groups
            $x=1
            ForEach($group in $arrGroups){
                IF($group){
                    #Check if group exists
                    IF(Get-ADGroup $group){
                        Try {                
                            Add-ADGroupMember $group $strsAMAccountName
                            $objNew.("group$($x)")=$group
                            $objNew.("group$($x)Success")="TRUE"
                            $LogMessage="$($strsAMAccountName): Added user to group: $($group)"
                            Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Information –EventID 1 –Message $LogMessage
                            Write-Host "[INFO]`t $($LogMessage)"
                        }
                        Catch
                        {                
                            $ErrorMessage=$_.Exception.Message
                            $LogMessage="$($strsAMAccountName): Unable to add user to group $($group): $($_.Exception.Message)"
                            $objNew.("group$($x)Success")="FALSE"
                            Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Warning –EventID 1 –Message $LogMessage
                            Write-Host "[ERROR]`t $($LogMessage)" -ForegroundColor Magenta
                        }
                    }
                }
            $x++
            }
            #Create HomeFolder On File Server
            IF($strhomeDirectory){
                IF(!(Test-Path "filesystem::$($strhomeDirectory)")){
                    Try {
                        New-Item "filesystem::$($strhomeDirectory)" -Type directory #-Force
                        New-Item "filesystem::$($strhomeDirectory)\Documents" -type directory  #-Force
                        $LogMessage="$($strsAMAccountName): home directory created"
                        $objNew.homeSuccess="TRUE"                       
                        Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Information –EventID 1 –Message $LogMessage
                        Write-Host "[INFO]`t $($LogMessage)"
                    }
                    Catch {
                        $ErrorMessage=$_.Exception.Message
                        $LogMessage="$($strsAMAccountName): ERROR create home directory: $($strhomeDirectory): $($_.Exception.Message)"
                        $objNew.homeSuccess="FALSE"
                        Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Warning –EventID 1 –Message $LogMessage
                        Write-Host "[ERROR]`t $($LogMessage)" -ForegroundColor Magenta
                    }
                }
                #Change ACLs for Homefolder On File Server
                IF(Test-Path "filesystem::$($strhomeDirectory)"){
                    Try {
                        $Acl=Get-Acl "filesystem::$($strhomeDirectory)"
                        $acl.SetAccessRuleProtection($true,$false)
                        $new="$($dnsroot)\Administrator","FullControl","ContainerInherit,ObjectInherit","None","Allow"    
                        $AccessRule=New-Object System.Security.AccessControl.FileSystemAccessRule($new)
                        $Acl.SetAccessRule($AccessRule)
                        $new="Administrators","FullControl","ContainerInherit,ObjectInherit","None","Allow"    
                        $AccessRule=New-Object System.Security.AccessControl.FileSystemAccessRule($new)
                        $Acl.SetAccessRule($AccessRule)
                        $new="SYSTEM","FullControl","ContainerInherit,ObjectInherit","None","Allow"    
                        $AccessRule=New-Object System.Security.AccessControl.FileSystemAccessRule($new)
                        $Acl.SetAccessRule($AccessRule)
                        $new="$($dnsroot)\$($strsAMAccountName)","FullControl","ContainerInherit,ObjectInherit","None","Allow"    
                        $AccessRule=New-Object System.Security.AccessControl.FileSystemAccessRule($new)
                        $Acl.SetAccessRule($AccessRule)
                        Set-Acl "filesystem::$($strhomeDirectory)" $Acl
                        $LogMessage="Home Directory ACLs created for $($dnsroot)\$($strsAMAccountName)."
                        $objNew.Path="$dnsroot\$strsAMAccountName"  
                        $objNew.Success="TRUE"                     
                        Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Information –EventID 1 –Message $LogMessage
                        Write-Host "[INFO]`t $($LogMessage)"
                    }
                    Catch {
                        $ErrorMessage=$_.Exception.Message
                        $LogMessage="Unable to set ACL on home directory for user $($strsAMAccountName): ACL $($new): $($_.Exception.Message)"
                        $objExists.Path="$dnsroot\$strsAMAccountName"  
                        $objExists.pathSuccess="FALSE"                       
                        Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Warning –EventID 1 –Message $LogMessage
                        Write-Host "[ERROR]`t $($LogMessage)" -ForegroundColor Magenta
                    }
                }
            }               
        }
        #User already exists
        Else {
            $LogMessage="$($strEmployeeNumber) - $($strsAMAccountName): Users with this sAMAccountName already exists!"
            $hash=@{EmployeeNumber=$strEmployeeNumber;Name=$strDisplayName;sAMAccountName=$strsAMAccountName;EmailAddress=$strMail;OU=$strOU;AccountPassword=$strPassword}                           
            $objExists=New-Object -TypeName PSObject -Property $hash
            $arrExists+=$objExists
            Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Warning –EventID 1 –Message $LogMessage
            Write-Host "[SKIP]`t $($LogMessage)" -ForegroundColor Magenta
        }
    }
}
#Create html body with created users
$arrProperties=@("EmployeeNumber","sAMAccountName","Name","EmailAddress","OU")
IF($arrNew){
    [string]$htmlNew=$arrNew | ConvertTo-Html -PreContent $strhtmlBody -Property $arrProperties -Fragment
}
IF($arrError){
    [string]$htmlError=$arrError | ConvertTo-Html -PreContent $strHtmlError -Property $arrProperties -Fragment
}
IF($arrExists){
    [string]$htmlExists=$arrExists | ConvertTo-Html -PreContent $strHtmlExists -Property $arrProperties -Fragment
}
$StrStyle="<style>$(Get-Content $strCss)</style>"
$strHtml=$StrStyle+$htmlNew+$htmlError+$htmlExists
#Send email with created users
IF($strHtml){    
    Send-MailMessage -To $strTo -From $strFrom -Subject $strSubject -BodyAsHtml $strHtml -SmtpServer $strServer
}
#Clean up
IF($psSQL){Remove-PSSession $psSQL}
IF($psAD){Remove-PSSession $psSQL}
Clear-Variable strHtml,arrNew,arrError,arrExists -ErrorAction SilentlyContinue

#Write to Eventlog
$LogMessage="Import Script finished (on $(Get-Date) )"
Write-EventLog –LogName $strLogName –Source $strLogSource –EntryType Information –EventID 1 –Message $LogMessage



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_06_Code\6.3_AD_User_sync.ps1
************************************************************************
﻿######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Import ActiveDirectory Module

#Set variables
$strDNroot=(Get-ADDomain).DistinguishedName
$strOU="OU=Staff,$strDNroot"
$strJSON="C:\users.json"

#Get users from Active Directory
Try {
    $objADusers=Get-ADUser -SearchBase $strOU -Filter * -Properties *
}
Catch {
    Write-Host "Could not get users from Active Directory" -ForegroundColor Red
}

#Get users from JSON
Try {
    $objJson=Get-Content $strJSON | ConvertFrom-Json
}
Catch {
    Write-Host "Could not get users from JSON" -ForegroundColor Red
}

#Compare users objects
ForEach($user in $objADusers){
    Try {
        $userJson=$objJson.Users | ?{$_.sAMAccountName -eq $user.sAMAccountName}
    }Catch{}
    IF($userJson){
        ForEach($item in $userJson){
            IF($item.fullName -ne $user.DisplayName){
                Set-ADUser $user.SamAccountName -DisplayName $item.fullName
                Write-Host "$($user.SamAccountName): Changed displayName from $($user.DisplayName) to $($item.fullName)" -ForegroundColor Magenta
            }
            IF($item.jobTitle -ne $user.Title){
                Set-ADUser $user.SamAccountName -Title $item.jobTitle
                Write-Host "$($user.SamAccountName): Changed title from $($user.Title) to $($item.jobTitle)" -ForegroundColor Magenta
            }
            IF($item.telephoneNumber -ne $user.telephoneNumber){
                Set-ADUser $user.SamAccountName -OfficePhone $item.telephoneNumber
                Write-Host "$($user.SamAccountName): Changed officePhone from $($user.telephoneNumber) to $($item.telephoneNumber)" -ForegroundColor Magenta
            }
            ForEach($address in $item.address){
                IF($address.streetAddress -eq $user.StreetAddress){
                    Set-ADUser $user.SamAccountName -StreetAddress $address.streetAddress
                    Write-Host "$($user.SamAccountName): Changed streetAddress from $($user.streetAddress) to $($address.streetAddress)" -ForegroundColor Magenta
                }
                IF($address.country -eq $user.Country){
                    Set-ADUser $user.SamAccountName -Country $address.country
                    Write-Host "$($user.SamAccountName): Changed country from $($user.Country) to $($address.country)" -ForegroundColor Magenta
                }
            }
        }
    }
}


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_06_Code\6.4_AD_user_cleanup.ps1
************************************************************************
﻿######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Import ActiveDirectory Module

#Set variables
$strXml="C:\users.xml"
$intKeep=90

#Get users from XML
Try {
    [xml]$xml=Get-Content $strXml
}
Catch {
    Write-Host "Could not get users from XML" -ForegroundColor Red
}

#Compare user objects
ForEach($user in $xml.Objects.Object){
    $strSamAccountName=$user.Property[0].InnerText
    Try {
        $adUser=Get-ADUser $strSamAccountName
    } Catch {}
    IF($adUser){
        IF($adUser.DistinguishedName -like "*OU=ToBeDeleted*"){
            IF(($adUser.whenChanged -le (Get-Date).AddDays(-$intKeep)) -and ($adUser.Enabled -eq $false)){
                Try {
                    Remove-ADUser $adUser.SamAccountName -Confirm:$false
                    Write-Host "Deleting user $($adUser.SamAccountName)" -ForegroundColor Magenta
                }
                Catch {
                    Write-Host "$($adUser.SamAccountName): Could not delete user object: $($_.Exception.Message)" -ForegroundColor Red
                }
            }
        }
        ELSE {
            Try {
                Disable-ADAccount $adUser.SamAccountName -confirm:$false
                Write-Host "$($adUser.SamAccountName): Disabling user" -ForegroundColor Magenta
            }
            Catch {
                Write-Host "$($adUser.SamAccountName): Could not disable user object: $($_.Exception.Message)" -ForegroundColor Red
            }
            Try {
                Get-ADUser -Identity $adUser.SamAccountName | Move-ADObject -TargetPath "OU=ToBeDeleted,$($adUser.DistinguishedName)"
                Write-Host "$($adUser.SamAccountName): Moving user to OU=ToBeDeleted" -ForegroundColor Magenta
            }
            Catch {
                Write-Host "$($adUser.SamAccountName):Could not move user object: $($_.Exception.Message)" -ForegroundColor Red
            }

        }
    }
}



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_06_Code\6.5_AD_computer_cleanup.ps1
************************************************************************
﻿######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Import ActiveDirectory Module

#Set Variables
$strDNroot=(Get-ADDomain).DistinguishedName
$strSearchBase=@("OU=Servers,$strDNroot","OU=Mac,OU=Clients,$strDNroot","OU=Windows,OU=Clients,$strDNroot")
$intKeep=7
$dateNow=(Get-Date).AddDays(-$intKeep)

ForEach($ou in $strSearchBase){
    Try {
        $arrFilter=@("whenChanged","lastLogon","operatingSystem","operatingSystemServicePack","operatingSystemVersion")
        $objComputers=Get-ADComputer -SearchBase $ou -Filter * -Properties $arrFilter
    }
    Catch {
        Write-Host "Could not get computer objects from Active Directory: $($_.Exception.Message)" -ForegroundColor Red
    }
    ForEach($item in $objComputers)
    {
        ForEach($dc in ((Get-ADDomainController -filter * | Sort Name).Name)){
            $objComputer=Get-ADComputer $item -Properties lastLogon -Server $dc | Select name,lastlogon
            [datetime]$timeStamp=$([datetime]::FromFileTime($objComputer.lastLogon).ToString('yyyy-MM-dd HH:mm:ss'))
            IF($timeStamp -gt $timeStampTemp){
                    [datetime]$timeStampTemp=$timeStamp
            }
        }
        [datetime]$datelastLogon=$timeStampTemp
        Clear-Variable timeStampTemp
        IF(($datelastLogon -le $dateNow) -and (!($item.DistinguishedName -like "*OU=ToBeDeleted*"))) {
            Try {
                Set-ADComputer -Identity $item.DistinguishedName -Enabled $false -Confirm:$false
                Write-Host "$($item.DistinguishedName): Disabled computer object"
            } 
            Catch {
                Write-Host "$($item.DistinguishedName): Could not disable computer object: $($_.Exception.Message)" -ForegroundColor Red
            }
            Try {
                Get-ADComputer -Identity $item.SamAccountName | Move-ADObject -TargetPath "OU=ToBeDeleted,$($ou)"
                Write-Host "$($item.DistinguishedName): Moved computer object to OU=ToBeDeleted"
            }
            Catch {
                Write-Host $($item.DistinguishedName): "Could not move computer object: $($_.Exception.Message)" -ForegroundColor Red
            }
        }
        IF($item.DistinguishedName -like "*OU=ToBeDeleted*")
        {
            IF($item.whenChanged -le (Get-Date).AddDays(-$intKeep) -and ($item.Enabled -eq $false)){
                Try {
                    Remove-ADComputer -Identity $item.SamAccountName -Confirm:$false
                    Write-Host "$($item.DistinguishedName): Deleted computer object"
                }
                Catch {
                    Write-Host "$($item.DistinguishedName): Could not delete computer object: $($_.Exception.Message)" -ForegroundColor Red
                }
                            
            }
            ELSEIF($item.Enabled -eq $true){
                Try {
                    Get-ADComputer -Identity $item.SamAccountName | Move-ADObject -TargetPath $ou
                    Write-Host "$($item.DistinguishedName): Moved computer object to $ou"
                }
                Catch {
                    Write-Host $($item.DistinguishedName): "Could not move computer object: $($_.Exception.Message)" -ForegroundColor Red
                }
            }
        }
    }
}



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_07_Code\7.1_DHCP.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Set variables
$strStart="192.168.10.5"
$strEnd="192.168.10.254"
$strSubnet="255.255.255.0"
$strDHCP1="dhcp1.mydomain.com"
$strDHCP2="dhcp2.mydomain.com"
$strNetwork="192.168.10.0"

#Add-DhcpServerv4Scope
Add-DhcpServerv4Scope -ComputerName $strDHCP1 -StartRange $strStart -EndRange $strEnd -SubnetMask $strSubnet -Name "IPv4 TEST Network" -LeaseDuration 12:00:00 -Description "VLAN 10" -State Active

#IPv4 FailoverScope
Get-DhcpServerv4Failover -ComputerName $strDHCP1 | fl Mode, ServerRole, ReservePercent, MaxClientLeadTime, State
(Get-DhcpServerv4Failover -ComputerName $strDHCP1).ScopeId.Count
Add-DhcpServerv4FailoverScope -ComputerName $strDHCP2 -Name "$strDHCP1-$strDHCP2" -ScopeId $strNetwork

#IPv4 ExclusionRange
Add-DhcpServerv4ExclusionRange -ComputerName $strDHCP1 -ScopeId $strNetwork -StartRange 192.168.10.200 -EndRange 192.168.10.220

#Set-DhcpServerv4Scope
Set-DhcpServerv4Scope -ComputerName $strDHCP1 -ScopeId $strNetwork -LeaseDuration 1:00:00

#IPv4 Server Options
Get-DhcpServerv4OptionDefinition -ComputerName  $strDHCP1 | ft OptionId, Name -AutoSize
Get-DhcpServerv4OptionValue -ComputerName $strDHCP1 | ft name
Set-DhcpServerv4OptionValue -ComputerName $strDHCP1 -ScopeId $strNetwork -OptionId 03 -Value 192.168.10.1
Set-DhcpServerv4OptionValue -ComputerName $strDHCP1 -ScopeId $strNetwork -OptionId 43 -Value 0x01, 0x04, 0x00, 0x00, 0x00, 0x00, 0xFF
Set-DhcpServerv4OptionValue -ComputerName $strDHCP1 -ScopeId $strNetwork -OptionId 60 -Value PXEClient
Set-DhcpServerv4OptionValue -ComputerName $strDHCP1 -ScopeId $strNetwork -OptionId 66 192.168.8.3
Set-DhcpServerv4OptionValue -ComputerName $strDHCP1 -ScopeId $strNetwork -OptionId 67 boot\x64\wdsnbp.com
Get-DhcpServerv4OptionValue -ComputerName $strDHCP1 -ScopeId $strNetwork | ft -AutoSize

#IPv4 Reservation
$strIP="192.168.10.26"
Get-DhcpServerv4Lease -ComputerName $strDHCP1 -IPAddress $strIP_ | Add-DhcpServerv4Reservation -ComputerName $strDHCP1 -Type Both
Set-DhcpServerv4Reservation -ComputerName $strDHCP1 -IPAddress $strIP_ -Name "Test-PC" -Description "Reservation for Test-PC"
Get-DhcpServerv4Lease -ComputerName $strDHCP1 -IPAddress $strIP_ | Remove-DhcpServerv4Reservation -ComputerName $strDHCP1 -ScopeId $strNetwork_  -Confirm:$false

$strMac="af-af-af-af-af-af"
Add-DhcpServerv4Reservation -ComputerName $strDHCP1 -ScopeId $strNetwork -ClientId $strMac -IPAddress 192.168.10.6 -Name "TEST.mydomain.com" -Type Dhcp
Get-DhcpServerv4Reservation -ComputerName $strDHCP1 -ScopeId $strNetwork
Remove-DhcpServerv4Reservation -ComputerName $strDHCP1 -ScopeId $strNetwork -ClientId $strMac -Confirm:$false

#IPv6 Scope
$strIPv6="2001:4898:7020:1020::"
$strIPv6Name="IPv6 TEST Network"
Add-DhcpServerv6Scope -ComputerName $strDHCP1 -Prefix $strIPv6 -Name $strIPv6Name -PreferredLifeTime 4.00:00:00 -ValidLifeTime 6.00:00:00 -State Inactive

#IPv6 Server Options
Get-DhcpServerv6OptionDefinition -ComputerName $strDHCP1 | ft OptionId, Name -AutoSize
$strDefinition="Broadcast and Multicast Service Controller for IPv6 Address"
Add-DhcpServerv6OptionDefinition -ComputerName $strDHCP1 -Name $strDefinition -OptionId 36 -Type IPv6Address
Get-DhcpServerv6OptionDefinition -ComputerName $strDHCP1 | ft OptionId, Name -AutoSize
Remove-DhcpServerv6OptionDefinition -ComputerName $strDHCP1 -OptionId 36 -Confirm:$false

#IPv6 Vendor Class & Options
Get-DhcpServerv6Class -ComputerName $strDHCP1 | ft -AutoSize
$strClass="Vendor Class for IP Phones"
$strClassDescription="User defined Vendor Class for IP Phones"
Add-DhcpServerv6Class -ComputerName $strDHCP1 -Name $strClass -Data "IP Phones" -VendorId 100 –Type Vendor -Description $strClassDescription
Get-DhcpServerv6Class -ComputerName $strDHCP1 | ft -AutoSize

$strName="IP Phone Option"
Add-DhcpServerv6OptionDefinition -ComputerName $strDHCP1 -VendorClass $strClass -Name $strName -OptionId 1 -Description $strName -Type String
Set-DhcpServerv6OptionValue -ComputerName $strDHCP1 -Prefix $strIPv6 -VendorClass $strClass -OptionId 1 -Value "My IP Phone"
Get-DhcpServerv6OptionValue -ComputerName $strDHCP1 -Prefix $strIPv6 -VendorClass $strClass
Remove-DhcpServerv6OptionValue -ComputerName $strDHCP1 -Prefix $strIPv6 -VendorClass $strClass -OptionId 1 -Confirm:$false
Remove-DhcpServerv6OptionDefinition -ComputerName $strDHCP1 -VendorClass $strClass -OptionId 1 -Confirm:$false
Remove-DhcpServerv6Class -ComputerName $strDHCP1 -Name $strClass -Type Vendor -Confirm:$false

#IPv6 Exlusion
$strIPv6Start="2001:4898:7020:1020:0000:0000:0000:0001"
$strIPv6End="2001:4898:7020:1020::20"
Add-DhcpServerv6ExclusionRange -ComputerName $strDHCP1 $strIPv6 $strIPv6Start $strIPv6End
Get-DhcpServerv6ExclusionRange -ComputerName $strDHCP1 $strIPv6
Remove-DhcpServerv6ExclusionRange -ComputerName $strDHCP1 $strIPv6 $strIPv6Start $strIPv6End

#IPv6 Reservation
$strDuid="AF-AF-AF-AF-AF-AF-AF-AF-AF-AF-AF-AF-AF-AF"
$strDescription="Reserved for Computer1" 
Add-DhcpServerv6Reservation -ComputerName $strDHCP1 -Prefix $strIPv6 -IPAddress $strIPv6Start -Name "Computer1" -ClientDuid $strDuid -Iaid 234890455 -Description $strDescription

#IPv6 Revove Scope
Remove-DhcpServerv6Scope -ComputerName $strDHCP1 -Prefix $strIPv6 -Force -Confirm:$false



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_07_Code\7.2_DNS.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Add-DnsServerPrimaryZone
$strDNS="dns.mydomain.com"
$strZone="test-domain.com"
$strNetworkID="192.168.10.0/24"
$strReverseZone="10.168.192.in-addr.arpa"
$strIPv4Host="TEST-IPv4"
Add-DnsServerPrimaryZone -ComputerName $strDNS -Name $strZone -ZoneFile "$strZone.dns"
Add-DnsServerPrimaryZone -ComputerName $strDNS -NetworkId $strNetworkID -ZoneFile "$strReverseZone.dns"

#Create A Record with PTR Record
Add-DnsServerResourceRecordA -ComputerName $strDNS -ZoneName $strZone -Name $strIPv4Host -AllowUpdateAny -IPv4Address "192.168.10.23" -TimeToLive 01:00:00 -CreatePtr 
Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone -RRType A  | fl
Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strReverseZone -RRType Ptr

#Change IP for A Record
$objNew=Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone -Name $strIPv4Host
$objNew.RecordData.Ipv4Address="192.168.10.55"
$objOld=Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone -Name $strIPv4Host
Set-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone -OldInputObject $objOld -NewInputObject $objNew
(Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone -Name $strIPv4Host).RecordData.IPv4Address
Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strReverseZone -RRType Ptr
Add-DnsServerResourceRecordPtr -ComputerName $strDNS -ZoneName $strReverseZone -PtrDomainName "$strIPv4Host.$strZone" -Name 55
Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strReverseZone -RRType Ptr

#Create AAAA Record
$strIPv6Address="2001:4898:7020:1020::20"
Add-DnsServerResourceRecordAAAA -ComputerName $strDNS -ZoneName $strZone -Name "Test-IPv6" -IPv6Address $strIPv6Address

#Create CNAME Record
Add-DnsServerResourceRecordCName -ComputerName $strDNS -ZoneName $strZone -Name "test" -HostNameAlias "TEST-IPv4.test-domain.com"
Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone | ?{($_.RecordType -eq "A") -or ($_.RecordType -eq "AAAA") -or ($_.RecordType -eq "CNAME")}

#Delete a DNS Record
Remove-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone -RRType "A" -Name $strIPv4Host -Confirm:$false -Force
Remove-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone -RRType "AAAA" -Name "TEST-IPv6" -Confirm:$false -Force
Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone -RRType AAAA

#Import Records from csv
$strZone="test-domain.com"
$csv=Import-Csv dns-hosts.csv
ForEach($item in $csv)
{
    IF($item.type -eq "A"){
        $arrIPv4=($item.ip).Split(".")
        $strReverseZonev4="$($arrIPv4[2]).$($arrIPv4[1]).$($arrIPv4[0]).in-addr.arpa"
        $strNetworkIDv4="$($arrIPv4[0]).$($arrIPv4[1]).$($arrIPv4[2]).0/24"
        IF(!(Get-DnsServerZone -ComputerName $strDNS -Name $strReverseZonev4 -ErrorAction SilentlyContinue -WarningAction SilentlyContinue)){
            Write-Host "Creating reverselookup Zone: $strReverseZonev4 for Network: $strNetworkIDv4" -ForegroundColor Green
            Add-DnsServerPrimaryZone -ComputerName $strDNS -NetworkID $strNetworkIDv4 -ZoneFile "$strReverseZonev4.dns"
        }
        Write-Host "Creating A Record for Host: $($item.host) with IP: $($item.ip)" -ForegroundColor Yellow 
        Add-DnsServerResourceRecordA -ComputerName $strDNS -Name $item.host -ZoneName $strZone -IPv4Address $item.ip -CreatePtr
    }
    IF($item.type -eq "AAAA"){
        $strIPv6=$item.ip
        $arrChar=[char[]]$strIPv6.Substring(0,$strIPv6.IndexOf('::')).Replace(":","")
        [array]::Reverse($arrChar)
        $strReverseZonev6=($arrChar -join ".")+".ip6.arpa"
        $strNetworkIDv6=$strIPv6.Substring(0,$strIPv6.IndexOf('::')+2)+"/64"
        IF(!(Get-DnsServerZone -ComputerName $strDNS -Name $strReverseZonev6 -ErrorAction SilentlyContinue -WarningAction SilentlyContinue)){
            Write-Host "Creating reverselookup Zone: $strReverseZonev6 for Network: $strNetworkIDv6" -ForegroundColor Green
            Add-DnsServerPrimaryZone -ComputerName $strDNS -NetworkId $strNetworkIDv6 -ZoneFile "$strReverseZonev6.dns"
        }
        Write-Host "Creating AAAA Record for Host: $($item.host) with IP: $($item.ip)" -ForegroundColor Yellow
        Add-DnsServerResourceRecordAAAA -ComputerName $strDNS -Name $item.host -ZoneName $strZone -IPv6Address $item.ip -CreatePtr
    }
    IF($item.type -eq "CNAME"){
        Write-Host "Creating CNAME Record for Host: $($item.host) with IP: $($item.ip)" -ForegroundColor Yellow
        Add-DnsServerResourceRecordCName -ComputerName $strDNS -Name $item.host -ZoneName $strZone -HostNameAlias $item.ip
    }
}
Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strZone | ?{($_.RecordType -eq "A") -or ($_.RecordType -eq "AAAA") -or ($_.RecordType -eq "CNAME")} | Sort RecordType
Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strReverseZonev4 | ?{($_.RecordType -eq "PTR")}
Get-DnsServerResourceRecord -ComputerName $strDNS -ZoneName $strReverseZonev6 | ?{($_.RecordType -eq "PTR")} | ft -AutoSize

#Clean up
Remove-DnsServerZone -ComputerName $strDNS -Name $strZone -Confirm:$false -Force
Remove-DnsServerZone -ComputerName $strDNS -Name $strReverseZone -Confirm:$false -Force
Remove-DnsServerZone -ComputerName $strDNS -Name $strReverseZonev4 -Confirm:$false -Force
Remove-DnsServerZone -ComputerName $strDNS -Name $strReverseZonev6 -Confirm:$false -Force



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_07_Code\7.3_Printer_creation.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

$ErrorActionPreference="SilentlyContinue"
#Creating printers from CSV
Get-Content �printers.csv�
$printers=Import-Csv �printers.csv�
ForEach($printer in $printers) {
    #$printers.Portname
    IF(!(Get-PrinterPort -Name $printer.Portname)){
        Write-Host "Adding PrinterPort: $($printer.Portname)" -ForegroundColor Yellow
        Add-PrinterPort -Name $printer.Portname -PrinterHostAddress $printer.Portname
    }
    #$printers.Driver
    IF(!(Get-PrinterDriver $printer.Driver)){
        Write-Host "Adding PrinterDriver: $($printer.Driver)" -ForegroundColor Green
        Add-PrinterDriver $printer.Driver
        IF(!(Get-PrinterDriver $printer.Driver)){
            Write-Host "The driver: $($printer.Driver) is not installed on the system!" -ForegroundColor Red
        }
    }
    ELSE {
        Write-Host "Creating printer`nName: $($printer.Name)`nDriverName: $($printer.Driver)`nShared: $($printer.Shared)`n"
        Add-Printer -Name $printer.Name -DriverName $printer.Driver -PortName $printer.Portname -Location $printer.Location -Comment $printer.Comment
        IF($printer.Shared -eq '$true'){
            Write-Host "Sharing printer: $($printer.Name)" -f Blue
            Set-Printer -Name $printer.Name -Shared $true -ShareName $printer.Name
        }
    }
}
Get-Printer | ?{$_.Name -like "*TEST"} 



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_07_Code\7.4_DeleteOldFiles.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Delete files by LastWriteTime
$intDays=7
$strTargetFolder="C:\inetpub\logs\LogFiles\W3SVC2\1"
$strExtension="*.log"
$lastWrite=(Get-Date).AddDays(-$intDays)
$objFiles=Get-Childitem $strTargetFolder -Include $strExtension -Recurse | ?{$_.LastWriteTime -le "$lastWrite"}
ForEach($file in $objFiles){
    Write-host "Deleting File $file" -ForegroundColor Magenta
    Remove-Item $File.FullName | Out-Null
}

#Delete files by max integer
$intKeep=8
$strTargetFolder="C:\inetpub\logs\LogFiles\W3SVC2\2"
$strExtension="*.log"
$objFiles=Get-Childitem $strTargetFolder -Include $strExtension -Recurse
IF(($objFiles.Count) -gt $intKeep){
    $delete=$objFiles | Sort LastWriteTime -Descending | Select -First ($objFiles.Count-$intKeep)
    ForEach($file in $delete){
        Write-host "Deleting File $file" -ForegroundColor Magenta
        Remove-Item $file.FullName | Out-Null
    }
}
(Get-Childitem $strTargetFolder -Include $strExtension -Recurse).Count


c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_07_Code\7.5_Presenting_data.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Out-GridView
ps | Out-GridView
ps | ?{$_.CPU -gt 1} | Sort -Descending CPU | Out-GridView

#Excel
$strName="Windows Processes"
$excel=New-Object -ComObject Excel.Application
$workbook=$excel.Workbooks.Add()
$worksheet=$workbook.Worksheets.Item(1)
$x=1
ForEach($item in ps | ?{$_.CPU -gt 1}){
    $worksheet.Cells.Item($x,1)=$item.Name
    $worksheet.Cells.Item($x,2)=$item.CPU
    $x++
}
$range=$worksheet.UsedRange
$range.EntireColumn.AutoFit()
$workbook.Charts.Add() | Out-Null
$chartType=[Microsoft.Office.Interop.Excel.XlChartType]::xl3DColumn
$workbook.ActiveChart.ChartType=[int16]$chartType.value__
$workbook.ActiveChart.ChartStyle=11
$workbook.ActiveChart.HasTitle=$true
$workbook.ActiveChart.ChartTitle.Text=$strName
$workbook.ActiveChart.ApplyDataLabels()
$workbook.ActiveChart.SetSourceData($range)
$excel.visible=$true
$excel.DisplayFullScreen=$true
$excel.WindowState="xlMinimized"
$excel.WindowState="xlMaximized"



c:\users\rocky\desktop\powershell books examples\mastering windows powershell 5 administration\5606_07_Code\7.6_W32_classes.ps1
************************************************************************
######################################
#   Copyright (c) 2016, Heiko Horn   #
#       All rights reserved.         #
######################################

#Get-WmiObject
(Get-WmiObject -List).Count

#Computer System Hardware Classes - Hardware-related objects.
gwmi -Class Win32_Processor | ft
gwmi Win32_NetworkAdapter | ?{$_.DeviceID -eq 1} | ft AdapterType,Name,Speed

#Installed Applications Classes - Software-related objects.
gwmi Win32_Product | ?{$_.Name -like "*microsoft*"} | Select name,version -First 10

#Operating System Classes - Operating system related objects.
gwmi Win32_OperatingSystem  | fl Caption,Version,BuildNumber,SystemDirectory,MUILanguages

#Performance Counter Classes - Raw and calculated performance data from performance counters.
gwmi Win32_Perf | ft __CLASS -AutoSize
(gwmi Win32_PerfFormattedData_PerfProc_Process).Count
gwmi Win32_PerfRawData_Spooler_PrintQueue | ft name

#WMI Service Management Classes - Management for WMI.
gwmi -List -Class Win32_WMI*

#Available logical disk space
$arrName=@("DeviceId","Size","FreeSpace","MediaType")
gwmi -ComputerName Localhost -Query "Select * from Win32_logicaldisk Where MediaType=12" | ft $arrName
gwmi Win32_LogicalDisk -Filter "MediaType=12" | ft $arrName
gwmi Win32_LogicalDisk | ?{$_.MediaType -eq 12} | ft $arrName

#NetworkAdapterConfiguration
gwmi Win32_NetworkAdapterConfiguration -Filter "IpEnabled=True" | ft DHCPEnabled,ServiceName,Description


