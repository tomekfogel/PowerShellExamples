
c:\users\rocky\desktop\powershell books examples\powershell for sql server essentials\1492EN_Code Samples\1942EN_01 code samples\1492EN_01 code samples.txt
************************************************************************
#-----------------------------------------------------
# Introducing Pipeline in PowerShell
#-----------------------------------------------------
Get-Service |
Select-Object ServiceName, Status |
Sort-Object Status -Descending


#-----------------------------------------------------
# Scripting Basics
#-----------------------------------------------------
$currdate = (Get-Date -Format "yyyyMMdd hhmmtt")
$servers = @("ROGUE", "CEREBRO")

#save each server’s running services into a file
$servers  |
ForEach-Object {

    $computername = $_
    Write-Host "`n`nProcessing $computername"

    $filename = "C:\Temp\$($computername) - $($currdate).csv"
    
    Get-Service -ComputerName $computername |
    Where-Object -Property Status -EQ "Running" |
    Select-Object Name, DisplayName | 
    Export-Csv -Path $filename -NoTypeInformation
    
}


#-----------------------------------------------------
# Getting Help
#-----------------------------------------------------
Get-Help Get-ChildItem
Get-Help Get-ChildItem -Detailed
Get-Help Get-ChildItem -Examples
Get-Help Get-ChildItem -Full
Get-Help Get-ChildItem -ShowWindow
Get-Help Get-ChildItem -Online





c:\users\rocky\desktop\powershell books examples\powershell for sql server essentials\1492EN_Code Samples\1942EN_02 code samples\1492EN_02 code samples.txt
************************************************************************
#-----------------------------------------------------
# Creating SMO Objects
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#default SQL Server 2014 instance, ie server name
$instance = "ROGUE"

#instantiate an SMO Server object
$server   = New-Object `
            -TypeName Microsoft.SqlServer.Management.Smo.Server `
            -ArgumentList $instance

#list some properties
$server | 
Select Name, Version, Status, ConnectionContext, `
       ComputerNamePhysicalNetBIOS



c:\users\rocky\desktop\powershell books examples\powershell for sql server essentials\1492EN_Code Samples\1942EN_03 code samples\1492EN_03 code samples.txt
************************************************************************
#-----------------------------------------------------
# Current Server Resources - CPU
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

Get-WmiObject -Class Win32_ComputerSystem `
              -ComputerName $servername |
Select Name, 
       Domain, 
       NumberOfProcessors, 
       NumberOfLogicalProcessors |
Format-List


#-----------------------------------------------------
# Current Server Resources - CPU Usage
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

Get-WmiObject -Class Win32_Processor -ComputerName $servername |
Measure-Object -Property LoadPercentage –Average


#-----------------------------------------------------
# Current Server Resources - Memory
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

Get-WmiObject -Class Win32_OperatingSystem `
              -ComputerName $servername |
Get-Member -MemberType Property |
Where-Object Name -Like "*Mem*" |
Select Name


#-----------------------------------------------------
# Current Server Resources - Memory
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

Get-WmiObject -Class Win32_OperatingSystem -ComputerName $servername |
Select @{N="TotalVisibleMemorySize (GB)";E={"{0:N1}" -f (($_.TotalVisibleMemorySize)/1024/1024)}},
@{N="FreePhysicalMemory (GB)";E={"{0:N1}" -f (($_.FreePhysicalMemory)/1024/1024)}},
@{N="MemoryUsage %";E={ “{0:N2}” -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize) }} |
Format-List


#-----------------------------------------------------
# Current Server Resources - Disk Space
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

Get-WmiObject -Class Win32_LogicalDisk `
       -ComputerName $servername |
Select @{N="DeviceID";E={$_.DeviceID}},
       @{N="DriveType";
         E={switch ($_.DriveType)
                   {
                      0 {"Unknown"}
                      1 {"No Root Directory"}
                      2 {"Removable Disk"}
                      3 {"Local Disk"}
                      4 {"Network Drive"}
                      5 {"Compact Disc"}
                      6 {"RAM Disk"}
                   }};
         },
        @{N="Size (GB)";E={"{0:N1}" -f($_.Size/1GB)}},
        @{N="Free Space (GB)";E={"{0:N1}" -f($_.FreeSpace/1GB)}},
        @{N="Free Space (%)";
          E={
             if ($_.Size -gt 0)
             {
                "{0:P0}" -f($_.FreeSpace/$_.Size)
             }
             else
             {
                0
             }
            }
          } |
Format-Table -AutoSize


#-----------------------------------------------------
# Current Server Resources - Network
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

Get-WmiObject -Class Win32_NetworkAdapterConfiguration `
        -ComputerName $servername `
        -Filter IPEnabled=True | 
Select Description, DHCPEnabled, 
       IPEnabled, IPAddress, 
       MACAddress


#-----------------------------------------------------
# Hotfixes and Service Packs
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

Get-WmiObject -Class Win32_OperatingSystem `
              -ComputerName $servername |
Select CSName, Caption,
       ServicePackMajorVersion, 
       ServicePackMinorVersion |
Format-List


#-----------------------------------------------------
# Hotfixes and Service Packs
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

Get-WmiObject -Class Win32_QuickFixEngineering `
              -ComputerName $servername |
Sort-Object -Property InstalledOn -Descending |
Format-Table –AutoSize


#-----------------------------------------------------
# Current SQL Server Instances
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$managedComputer = New-Object "Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer" $servername

#list SQL Server instances
$managedComputer.ServerInstances |
Select Name, State, ServerProtocols, Urn |
Format-List



#-----------------------------------------------------
# Services and Service Accounts
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$managedComputer = New-Object "Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer" $servername

$managedComputer.Services |
Select Name, ServiceAccount, DisplayName |
Format-Table -AutoSize


#-----------------------------------------------------
# SQL Server Error Logs
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

#display most recent 5 entries 
$server.ReadErrorLog() |
Select LogDate, ProcessInfo, Text, HasErrors  -Last 5  | 
Format-List


#-----------------------------------------------------
# Current Instance Configurations
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$server |
Get-Member |
Where Name -ne "SystemMessages" |
Where MemberType -eq "Property" |
Select Name,
       @{N="Value";E={$server.($_.Name)}} |
Format-Table -AutoSize


#-----------------------------------------------------
# Changing Configurations - Start or Stop a Service
#-----------------------------------------------------
Get-Command -Name "*Service*" -CommandType "Cmdlet"
$servicename = "SQLAgent`$SQL2014"
Stop-Service -Name $servicename
Start-Service -Name $servicename


#-----------------------------------------------------
# Changing Configurations - Change Service Account
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$managedComputer = New-Object "Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer" $servername

$servicename = "SQLAgent`$SQL2014"

$sqlservice = $managedComputer.Services |
              Where Name -EQ $servicename

#check current service account 
$sqlservice.ServiceAccount

#set new service account
$newserviceaccount = "QUERYWORKS\sqlagentservice"
#$newserviceaccount = "QUERYWORKS\sqlservice"
$credential = Get-Credential -Credential $newserviceaccount
$sqlservice.SetServiceAccount($credential.UserName,$credential.GetNetworkCredential().Password)

#check new service account 
$sqlservice.ServiceAccount


#-----------------------------------------------------
# Changing Configurations - Change Instance Settings
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

#check current backup directory 
$server.BackupDirectory

#change backup directory 
$dir = "C:\Temp"
$server.BackupDirectory = $dir 
$server.Alter()

#check current backup directory 
$server.BackupDirectory

#enable xp_cmdshell
$server.Configuration.XPCmdShellEnabled.ConfigValue = 1
$server.Configuration.Alter()
$server.Configuration.XPCmdShellEnabled

#change AuditLevel
$server.Settings.AuditLevel = [Microsoft.SqlServer.Management.Smo.AuditLevel]::All

#make changes permanent
$server.Settings.Alter()

#display new settings
$server.Settings



c:\users\rocky\desktop\powershell books examples\powershell for sql server essentials\1492EN_Code Samples\1942EN_04 code samples\1492EN_04 code samples.txt
************************************************************************
#-----------------------------------------------------
#List Databases and Tables
#-----------------------------------------------------

Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername
$server.databases.Count

#create empty array
$result = @()
$server.Databases |
Where IsSystemObject -eq $false |
ForEach-Object {
    $db = $_
    $object = [PSCustomObject] @{
       Name          = $db.Name
       CreateDate    = $db.CreateDate
       RecoveryModel = $db.RecoveryModel
       NumTables     = $db.Tables.Count
       NumUsers      = $db.Users.Count
       NumSP         = $db.StoredProcedures.Count
       NumUDF        = $db.UserDefinedFunctions.Count
    }    
}
$result |
Format-Table -AutoSize


#-----------------------------------------------------
# Get properties
#-----------------------------------------------------
$server.Databases | 
Get-Member |
Where MemberType –eq "Property"



#-----------------------------------------------------
# Get Methods
#-----------------------------------------------------
$server.Databases | 
Get-Member |
Where MemberType –eq "Method"
 



#-----------------------------------------------------
# List Database Files and Filegroups
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$result = @()

$server.Databases |
Where IsSystemObject -eq $false |
ForEach-Object {
   $db = $_ 
   $db.FileGroups | 
   ForEach-Object {
      $fg = $_ 
      $fg.Files | 
      ForEach-Object {
         $file = $_

         $object = [PSCustomObject] @{
                Database = $db.Name 
                FileGroup = $fg.Name
                FileName = $file.FileName | Split-Path -Leaf
                "Size(MB)" = "{0:N2}" -f ($file.Size/1024)
                "UsedSpace(MB)" = "{0:N2}" -f ($file.UsedSpace/1MB)
                }
         $result += $object

      }
   }
}
$result |
Format-Table -AutoSize


#-----------------------------------------------------
# Add Files and Filegroups
#-----------------------------------------------------
$dbname = "Registration"
$db = $server.Databases[$dbname]
$fg = New-Object "Microsoft.SqlServer.Management.Smo.Filegroup" $db, "FG1"
$fg.Create()
$datafile = New-Object "Microsoft.SqlServer.Management.Smo.DataFile" $fg, "data4"
$datafile.FileName = "C:\DATA\data4.ndf"
$datafile.Create()


#-----------------------------------------------------
# Change file size
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername
$dbname = "Registration"

$db = $server.Databases[$dbname]
$fg = $db.FileGroups["FG1"]
$file = $fg.Files["data4"]
$file.Size = 2 * 1024 #2MB
$file.Alter()


#-----------------------------------------------------
# List Processes
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$server.EnumProcesses() |
Where IsSystem -eq $false |
Select Spid, Database, 
IsSystem, Login, Status, 
Cpu, MemUsage, Program |
Format-Table -AutoSize


#-----------------------------------------------------
# Check enabled features
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$server | 
Select IsClustered, ClusterName, 
FilestreamLevel,
IsFullTextInstalled,
LinkedServers,
IsHadrEnabled,
AvailabilityGroups




#-----------------------------------------------------
# Script Database Objects
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$dbname = "Chinook"
$db = $server.Databases[$dbname]

$script = New-Object "Microsoft.SqlServer.Management.Smo.Scripter" $server 
$scriptOptions = New-Object "Microsoft.SqlServer.Management.Smo.ScriptingOptions"
$scriptOptions.AllowSystemObjects = $false 
$scriptOptions.DriAll = $true 
$scriptOptions.ToFileOnly = $true 
$script.Options = $scriptOptions 

$smoObjects = @()
$filename = "C:\DATA\$($dbname)_tables_export.txt"
$script.Options.FileName = $filename

$db.Tables |
Where IsSystemObject -eq $false |
Foreach-Object {
   $smoObjects += $_
}
$script.Script($smoObjects)





#-----------------------------------------------------
# Detach a database
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$sourcename = "ROGUE"
$sourceserver = New-Object "Microsoft.SqlServer.Management.Smo.Server" $sourcename

$dbname = "Chinook"
$sourceserver.DetachDatabase($dbname, $true, $true)



#-----------------------------------------------------
# Attach a database
#------------------Import-Module SQLPS -DisableNameChecking

#current server name
$destinationname = "ROGUE\SQL2014"
$destinationserver = New-Object "Microsoft.SqlServer.Management.Smo.Server" $destinationname
$destinationserver.Name

$dbname = "Chinook"
$mdf = "C:\DATA\Chinook.mdf"
$dbowner = "QUERYWORKS\gon"

#this is where we will store all primary, secondary
#and log file information
$files = New-Object System.Collections.Specialized.StringCollection 

#assuming we need the attach process to point to 
#a different path than what’s stored in the mdf
#we can specify a data path, and rebuild all the
#paths before we store in our collection
$datapath = "C:\DATA"

#collect all data file information 
$sourceserver.EnumDetachedDatabaseFiles($mdf) | 
ForEach-Object {
   #update location of file to new path
   $newfile = Join-Path $datapath (Split-Path $_ -Leaf)
   $files.Add($newfile)
}

#collect all log file information
$destinationserver.EnumDetachedLogFiles($mdf) | 
ForEach-Object {
   #update location of file to new path
   $newfile = Join-Path $datapath (Split-Path $_ -Leaf)
   $files.Add($newfile)
}
$destinationserver.AttachDatabase($dbname, $files) 
-----------------------------------



#-----------------------------------------------------
# Backup
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

#$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$dbname = "Chinook"
$currdate = Get-Date -Format yyyyMMddHHmmss
$backupfolder = "C:\BACKUP\"

#generate backup file path and name
$fullbackupfilename = "$($dbname)_Full_$($currdate).bak"
$fullbackupfile = Join-Path $backupfolder $fullbackupfilename

#example filename that gets generated is:
#C:\BACKUP\Chinook_Full_20141023235306.bak

Backup-SqlDatabase -ServerInstance $servername -Database $dbname -BackupFile $fullbackupfile -Checksum -Initialize -BackupSetName "$dbname Full Backup" 

Write-Output "Database has been backed up $fullbackupfile"




#-----------------------------------------------------
# Restore Database
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$backupfile = "C:\BACKUP\Chinook_Full_20141023235841.bak"

$dbname = "Chinook"
$backupfile = "C:\BACKUP\Chinook_Full_20141023235841.bak"
Restore-SqlDatabase -Database $dbname -ReplaceDatabase -ServerInstance $servername -BackupFile $backupfile -NoRecovery



#-----------------------------------------------------
# List indexes and fragmentation
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername
$dbname = "Chinook"

$result = @()

$db = $server.Databases[$dbname]
$db.Tables | 
ForEach-Object {
   $table = $_ 
   $table.Indexes |
   Sort-Object -Property Name |
   ForEach-Object {
      $index = $_ 
      $frag = $index.EnumFragmentation()
       
      $object = [PSCustomObject] @{
         Table = $table.Name 
         Index = $index.Name
         Type = $frag.IndexType 
         Pages = $frag.Pages 
         "AvgFragmentation %" = "{0:N2}" -f ($frag.AverageFragmentation)
         "SpaceUsed(KB)" = $index.SpaceUsed

      }
        $result += $object
   }
}
$result |
Format-Table -AutoSize



#-----------------------------------------------------
# List logins and roles
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$result = @()

$server.Logins |
Where IsSystemObject -EQ $false |
ForEach-Object {
   $login = $_
   $object = [pscustomobject] @{
      Login = $login.Name
      LoginType = $login.LoginType
      CreateDate = $login.CreateDate
      ServerRoles = $login.ListMembers()
   }
   $result += $object
}
$result |
Format-Table -AutoSize



#-----------------------------------------------------
# Check orphaned users
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$result = @()
$server.Databases |
Where IsSystemObject -EQ $false |
ForEach-Object {
    $db = $_ 
    $db.Users |
    Where IsSystemObject -eq $false |
    ForEach-Object {
        $dbuser = $_
        $object = [PSCustomObject] @{
        Database = $db.Name 
        DBUser = $dbuser.Name
        Orphaned = if ($dbUser.UserType -eq "NoLogin") {"Yes"} else {"No"}
        Login = $dbuser.Login
        LoginType = $dbUser.LoginType
        }
  $result += $object
    }
}
$result |
Format-Table -AutoSize



#-----------------------------------------------------
# List permissions
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$result = @()
$server.Databases |
Where IsSystemObject -EQ $false |
Where Name -eq "Chinook" |
ForEach-Object {
    $db = $_ 
    $db.Users |
    Where IsSystemObject -eq $false |
    ForEach-Object {
        $dbuser = $_

        $object = [PSCustomObject] @{
        Database = $db.Name 
        DBUser = $dbuser.Name
        Orphaned = if ($dbUser.UserType -eq "NoLogin") {"Yes"} else {"No"}
        Login = $dbuser.Login
        LoginType = $dbUser.LoginType
        DBRoles = $dbuser.EnumRoles()
        ObjectPermissions  = ($db.EnumObjectPermissions($dbuser.Name) | SELECT @{N="P";E={$_.ObjectName + " " + $_.PermissionState + " " + $_.PermissionType  }} )
        }
  $result += $object
    }
}
$result |
Format-List


#-----------------------------------------------------
# Add Login
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$loginname = "kurapika"

#for this example, we will check if login exists
#and if it does we will drop it
if ($server.Logins.Contains($loginname))
{
   $server.Logins[$loginname].Drop()
}

$login = New-Object "Microsoft.SqlServer.Management.Smo.Login" $server, $loginname 
$login.LoginType = [Microsoft.SqlServer.Management.Smo.LoginType]::SqlLogin
$login.PasswordExpirationEnabled = $false 

#prompt for password
$password = Read-Host "Password: " -AsSecureString
$login.Create($password)

#add to server roles 
$server.Logins[$loginname].AddToRole("dbcreator")


#-----------------------------------------------------
# Add database user
#-----------------------------------------------------
#add database mapping 
$dbname = "Chinook"
$dbusername = "kurapika"
$db = $server.Databases[$dbname]

if ($db.Users.Contains($dbusername))
{
   $db.Users[$dbusername].Drop()
}

$dbuser = New-Object "Microsoft.SqlServer.Management.Smo.User" $db, $dbusername
$dbuser.Login = $loginname
$dbuser.Create()

#add database role
$db.Roles["db_datareader"].AddMember($dbuser.Name)


#initial permission is View Definition
$permissionset = New-Object "Microsoft.SqlServer.Management.Smo.ObjectPermissionSet" ([Microsoft.SqlServer.Management.Smo.ObjectPermission]::ViewDefinition)

#add additional permission: Alter
$permissionset.Add([Microsoft.SqlServer.Management.Smo.ObjectPermission]::Alter)

#add permission set to view vwAlbums
$db.Views["vwAlbums"].Grant($permissionset, $dbuser.Name)


#-----------------------------------------------------
# List job details
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$result = @()

$server.JobServer.Jobs | 
Foreach-Object {
   $job = $_
   $job.JobSteps | 
   ForEach-Object {
      $jobstep = $_
      $object = [PSCustomObject] @{
          Name = $job.Name 
          LastRunDate = $job.LastRunDate
          LastRunOutcome = $job.LastRunOutcome
          Step = $jobstep.Name
          LastStepOutcome = $jobstep.LastRunOutcome
       }
       $result += $object      
   }
}

$result |
Format-Table 



#-----------------------------------------------------
#
#-----------------------------------------------------


#-----------------------------------------------------
#
#-----------------------------------------------------


#-----------------------------------------------------
#
#-----------------------------------------------------



c:\users\rocky\desktop\powershell books examples\powershell for sql server essentials\1492EN_Code Samples\1942EN_05 code samples\1492EN_05 code samples.txt
************************************************************************


#-----------------------------------------------------
# SMO
#-----------------------------------------------------
$instance = "ROGUE"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instance

$dbname = "TestDB"
$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Database($server, $dbname)
$db.Create() 



#-----------------------------------------------------
# ADO.NET
#-----------------------------------------------------
$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = "Server=ROGUE;Database=Chinook;Integrated Security=True"
$cmd = New-Object System.Data.SqlClient.SqlCommand
$cmd.CommandText = "SELECT * FROM Album"
$cmd.Connection = $conn
$adapter = New-Object System.Data.SqlClient.SqlDataAdapter
$adapter.SelectCommand = $cmd
$dataset = New-Object System.Data.DataSet
$adapter.Fill($dataset)
$conn.Close()
$dataset.Tables[0]



#-----------------------------------------------------
# Send simple queries to SQL Server 
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

$servername = "ROGUE"
$database = "Chinook"

#query inside a here-string
$query = @"
SELECT 
    TOP 10 *
FROM
    dbo.Album
"@ 

#if not providing username and password
#then uses current context
Invoke-Sqlcmd -ServerInstance $servername -Database $database -Query $query


#-----------------------------------------------------
# Fix orphaned user
#-----------------------------------------------------
$query = @"
  ALTER USER $($username)
  WITH LOGIN = $($login)
"@
Invoke-Sqlcmd -ServerInstance $server -Database $database -Query $query




#-----------------------------------------------------
# Get Fragmentation Data
#-----------------------------------------------------

Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"
$database = "Chinook"

$query = @"
SELECT 
	OBJECT_NAME(phys_stats.OBJECT_ID) AS [Object], 
	idx.name AS [Index Name], 
	phys_stats.index_type_desc [Index Type], 
	phys_stats.avg_fragmentation_in_percent [Fragmentation %],
	phys_stats.page_count [# Pages]
FROM 
	sys.dm_db_index_physical_stats(DB_ID(),NULL, NULL, NULL , N'LIMITED') AS phys_stats
	INNER JOIN sys.indexes AS idx WITH (NOLOCK)
	ON phys_stats.[object_id] = idx.[object_id] 
	AND phys_stats.index_id = idx.index_id
WHERE 
	phys_stats.database_id = DB_ID()
ORDER BY 
	phys_stats.avg_fragmentation_in_percent DESC;
"@

Invoke-Sqlcmd -ServerInstance $servername -Database $database -Query $query | Format-Table -AutoSize




#-----------------------------------------------------
# Export using bcp
#-----------------------------------------------------
$database = "Chinook"
$schema = "dbo"
$table = "Album"
$filename = "C:\Temp\results.txt"

$bcp = "bcp $($database).$($schema).$($table) out $filename -T -c"
Invoke-Expression $bcp






c:\users\rocky\desktop\powershell books examples\powershell for sql server essentials\1492EN_Code Samples\1942EN_06 code samples\1492EN_06 code samples2.txt
************************************************************************

#-----------------------------------------------------
# Check and email logs
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

#get the last 10 error entries, and convert to HTML
$content = ($server.ReadErrorLog() |
Where {$_.Text -like "*failed*" -or $_.Text -like "*error*" -or $_.HasErrors -eq $true} |
Select LogDate, ProcessInfo, Text, HasErrors  -Last 10   | 
ConvertTo-Html)

#email settings
$currdate = Get-Date -Format "yyyy-MM-dd hmmtt"
$smtp = "mail.rogue.local"
$to = "DBA <administrator@rogue.local>"
$from = "DBMail <dbmail@administrator.local>"
$subject = "Last 10 Errors as of $currdate"

#send the email
Send-MailMessage -SmtpServer $smtp -To $to -from $from  -Subject $subject -Body "$($content)" -BodyAsHtml




#-----------------------------------------------------
# Monitor Failed Jobs
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

#current server name
$servername = "ROGUE"
$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

#get a list of jobs that failed, and convert to HTML
$content = ($server.JobServer.Jobs | 
Where LastRunOutcome -eq "Failed" | 
Select Name, LastRunDate | 
ConvertTo-Html)

#email settings 
$currdate = Get-Date -Format "yyyy-MM-dd hmmtt"
$smtp = "mail.rogue.local"
$to = "DBA <administrator@rogue.local>"
$from = "DBMail <dbmail@administrator.local>"
$subject = "Failed Jobs as of $currdate"

Send-MailMessage -SmtpServer $smtp -To $to -from $from  -Subject $subject -Body "$($content)" -BodyAsHtml



#-----------------------------------------------------
# Alert Disk Space
#-----------------------------------------------------
#current server name
$servername = "ROGUE"
#if free space % falls below this threshold, 
#assign CSS class “critical” which makes font red  
$criticalthreshold = 10

#inline css for styling
$inlinecss = @"
<style>
   table
   {
      margin: 0px;
      border: 1px solid #7e7e7e;
      background-color: #fafafa;
      border-collapse: collapse;
   }

   tr:nth-child(even) /* doesnt work in IE8 */
   {
       background-color: #d5e4f4;
   }

   th, td
   {
       width: 100px;
       text-align: left;
   }

   th
   {
       background-color:#a6bdd6;
       font-weight:bold;
   }

   .critical, .critical td
   {
      color: red;
      font-weight: bold;
   }
</style>
"@

#construct the html content
#use single quotes so we can use double quotes inside
$htmlhead = "<head><title>Disk Space Report </title>$($inlinecss)</head>"
$htmlbody = "<body>"
$htmlbody += "<p>$($subject)</p>"
$htmlbody += "<table><tbody>"
$htmlbody += "<th>Device ID</th>"
$htmlbody += "<th>Size (GB)</th>"
$htmlbody += "<th>Free Space (GB)</th>"
$htmlbody += "<th>Free Space (%)</th>"

#get disk usage 
#to look only at Local Disk, add filter for DriveType -eq 3
Get-WmiObject -Class Win32_LogicalDisk -ComputerName $servername |
ForEach-Object {
   $disk = $_
   $size = "{0:N1}" -f ($disk.Size/1GB)
   $freespace = "{0:N1}" -f ($disk.FreeSpace/1GB)
   if ($disk.Size -gt 0)
   {
      $freespacepercent = "{0:P0}" -f ($disk.FreeSpace/$disk.Size)
   }
   else 
   {
      $freespacepercent = ""
   }
   if ($freespacepercent -ne "" -and $freespacepercent -le $criticalthreshold)
   {
      $htmlbody += "<tr class='critical'>"
   }
   else
   {
      $htmlbody += "<tr>"
   }
   $htmlbody += "<td>$($disk.DeviceID)</td>"
   $htmlbody += "<td>$($size)</td>"
   $htmlbody += "<td>$($freespace)</td>"
   $htmlbody += "<td>$($freespacepercent)</td>"
   $htmlbody += "</tr>"
}
$htmlbody += "</tbody></table></body></html>"
$htmlcontent = $htmlhead + $htmlbody

#email settings
$currdate = Get-Date -Format "yyyy-MM-dd hmmtt"
$smtp = "mail.rogue.local"
$to = "DBA <administrator@rogue.local>"
$from = "DBMail <dbmail@administrator.local>"
$subject = "Disk Space Report for $servername as of $currdate"

Send-MailMessage -SmtpServer $smtp -To $to -from $from  -Subject $subject -Body "$($htmlcontent)" -BodyAsHtml



#-----------------------------------------------------
# Log blocking processes
#-----------------------------------------------------
Import-Module SQLPS -DisableNameChecking

$logname = "Application"
$source = "SQL Server Custom"

#current server name
$servername = "ROGUE"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername

$blockedprocesses = $server.EnumProcesses() |
Where IsSystem -eq $false |
Where BlockingSpid -gt 0 |
Select Spid, Database, BlockingSpid, 
Login, Status 

#check if Event Log source exists, otherwise create
if(!([System.Diagnostics.EventLog]::SourceExists($source)))
{
   Write-Output "Creating a new source"
   New-EventLog -LogName $logname -Source $source
}

#compose message
$message = "Blocked Process Identified `r`n`r`n" + $blockedprocesses

#write to event log with custom source
Write-EventLog -LogName $logname -Source $source -EventId 1  -EntryType Warning -Message $message




#-----------------------------------------------------
# Get performance metrics
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

Get-Counter -ComputerName $servername -ListSet * | 
Sort-Object CounterSetName | 
Select CounterSetName |
Format-Table



#-----------------------------------------------------
# Create Data Collector Set
#-----------------------------------------------------
#current server name
$servername = "ROGUE"

#data collector set name
$dcsname = "SQL Performance Metrics"

$dcs = New-Object -COM Pla.DataCollectorSet
$dcs.DisplayName = $dcsname

#subdirectory format will have year and month
#enum value is plaYearMonth, which is 0x0800
$dcs.SubdirectoryFormat = 0x0800 

#specify path where data collector set will be stored
#typically this will be in the system drive
$dcs.RootPath = "%systemdrive%\PerfLogs\Admin\" + $dcsname 

#now need to set up each file
$datacollector = $dcs.DataCollectors.CreateDataCollector(0)

#file format is binary
#enum is plaBinary = 3
$datacollector.LogFileFormat = 3

$datacollector.FileName = $dcsname + "_"

#filename format will have year, month and day
#enum value is plaYearMonthDay 0x1000
$datacollector.FileNameFormat = 0x1000 
$datacollector.SampleInterval = 15
$datacollector.LogAppend = $true

#these are the counters we want to capture
#you can add more to this, or can pull this from a file
$counters = @(
    "\Memory\Available MBytes", 
    "\Network Interface(*)\Bytes Received/sec",
    "\Network Interface(*)\Bytes Sent/sec",
    "\PhysicalDisk\Avg. Disk Sec/Read",
    "\PhysicalDisk\Avg. Disk Sec/Write",
    "\PhysicalDisk\Avg. Disk Queue Length",
    "\Processor(_Total)\% Processor Time"
) 

#add the counters to the data collector
$datacollector.PerformanceCounters = $counters
$dcs.DataCollectors.Add($datacollector) 
    
#save datacollectorset 
#name, server, commit mode, createnewormodify
$dcs.Commit("$dcsname" , $servername , 0x0003) 



c:\users\rocky\desktop\powershell books examples\powershell for sql server essentials\1492EN_Code Samples\1942EN_Appendix code samples\1492EN_Appendix code samples.txt
************************************************************************
#----------------------------------------
# simple function definition
#----------------------------------------
function Get-Tables
{
   Import-Module SQLPS -DisableNameChecking

   $servername = "ROGUE"
   $databasename = "AdventureWorks2014"

   $server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername


   $server.Databases[$databasename].Tables 
}



#-----------------------------------------------------
# Advanced function definition
#-----------------------------------------------------
function Get-Tables
{
<#
.SYNOPSIS
   Function that retrieves tables from a database
.DESCRIPTION
   Function that retrieves tables from a database
.PARAMETER servername

.PARAMETER databasename
.EXAMPLE
   Get-Tables -servername "Rogue" -databasename "Registration"
.EXAMPLE
   Get-Tables "Rogue" "Registration"
.EXAMPLE
   "Rogue", "Registration" | Get-Tables 
.INPUTS
   System.String,System.String
.OUTPUTS
.NOTES
.LINK
#>
   [CmdletBinding()]
   param
   (
     #parameter 1
     [parameter(
        Mandatory=$true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        HelpMessage='Which server are you using?')]
        [Alias('host')]
        [string]$servername,

     #parameter 2
     [parameter(
        Mandatory=$true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        HelpMessage='Which database are you using?')]
        [Alias('database')]
        [string]$databasename

   )

   begin
   {
      Import-Module SQLPS -DisableNameChecking
      $server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servername
   }

   process
   {
      try
      {
         $server.Databases[$databasename].Tables 
      }
      catch
      {
         Write-Warning $error
      }
      finally
      {
      }
   }

   end
   {
   }
}



