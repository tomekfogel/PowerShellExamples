
c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\__MACOSX\code listings\._listing21-1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\__MACOSX\code listings\._listing22-6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\__MACOSX\code listings\._listing26-1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\__MACOSX\code listings\._listing26-2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing21-1.ps1
************************************************************************
$computername = 'localhost'                                           
Get-WmiObject -class Win32_LogicalDisk `
 -computername  $computername `
 -filter "drivetype=3" |
 Sort-Object -property DeviceID |
 Format-Table -property DeviceID,
     @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing21-2.ps1
************************************************************************
﻿param (
  $computername = 'localhost'                                      #1
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
 -filter "drivetype=3" |
 Sort-Object -property DeviceID |
 Format-Table -property DeviceID,
     @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing21-3.ps1
************************************************************************
﻿param (
  $computername = 'localhost',
  $drivetype = 3                                                      #A
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
 -filter "drivetype=$drivetype" |                                     #B
 Sort-Object -property DeviceID |
 Format-Table -property DeviceID,
     @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing21-4.ps1
************************************************************************
﻿<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3
#>
param (
  $computername = 'localhost',
  $drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
 -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Format-Table -property DeviceID,
     @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing22-1.ps1
************************************************************************
﻿<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3
#>
param (
  $computername = 'localhost',
  $drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
 -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing22-2.ps1
************************************************************************
﻿<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3
#>
[CmdletBinding()]
param (
  $computername = 'localhost',
  $drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
 -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing22-3.ps1
************************************************************************
﻿<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3
#>
[CmdletBinding()]
param (
  [Parameter(Mandatory=$True)]   
  [string]$computername,

  [int]$drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
 -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing22-4.ps1
************************************************************************
﻿<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3
#>
[CmdletBinding()]
param (
  [Parameter(Mandatory=$True)]   
  [string]$computername,

  [int]$drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
 -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing22-5.ps1
************************************************************************
﻿<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3
#>
[CmdletBinding()]
param (
  [Parameter(Mandatory=$True)]
  [Alias('hostname')]   
  [string]$computername,

  [ValidateSet(2,3)]
  [int]$drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
 -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing22-6.ps1
************************************************************************
<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.
.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.
.PARAMETER computername
The computer name, or names, to query. Default: Localhost.
.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.
.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3
#>
[CmdletBinding()]
param (
  [Parameter(Mandatory=$True)]
  [Alias('hostname')]   
  [string]$computername,

  [ValidateSet(2,3)]
  [int]$drivetype = 3
)
Write-Verbose "Connecting to $computername"
Write-Verbose "Looking for drive type $drivetype"
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
 -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}

Write-Verbose "Finished running command"



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing26-1.ps1
************************************************************************
param(
  [parameter(Mandatory = $true)]
  [string] $Path,
  [parameter(Mandatory = $true)]
  [string] $Name 
  )
$System = [Environment]::GetFolderPath("System")
$script:hostsPath = ([System.IO.Path]::Combine($System, "drivers\etc\"))
[CA]+"hosts"

function New-localWebsite([string] $sitePath, [string] $siteName)
{
 try
 {
  Import-Module WebAdministration
 }
 catch 
 {
  Write-Host "IIS Powershell module is not installed. Please install it first, by adding the feature"
 }
 Write-Host "AppPool is created with name: " $siteName
 New-WebAppPool -Name $siteName 
 Set-ItemProperty IIS:\AppPools\$Name managedRuntimeVersion v4.0
 Write-Host 
 if(-not (Test-Path $sitePath))
 {
  New-Item -ItemType Directory $sitePath
 }
 $header = "www."+$siteName+".local"
 $value = "127.0.0.1 " + $header
 New-Website -ApplicationPool $siteName -Name $siteName -Port 80 -PhysicalPath $sitePath -HostHeader ($header) 
 Start-Website -Name $siteName
 if(-not (HostsFileContainsEntry($header)))
 {
  AddEntryToHosts -hostEntry $value  
 } 
 
}

function AddEntryToHosts([string] $hostEntry)
{
 try
 {
  $writer = New-Object System.IO.StreamWriter($hostsPath, $true)
  $writer.Write([Environment]::NewLine)
  $writer.Write($hostEntry)
  $writer.Dispose()
 }
 catch [System.Exception]
 {
  Write-Error "An Error occured while writing the hosts file"
 }
 
}

function HostsFileContainsEntry([string] $entry)
{ 
 try
 {
  $reader = New-Object System.IO.StreamReader($hostsPath + "hosts")
  while(-not($reader.EndOfStream))
  {
   $line = $reader.Readline()
   if($line.Contains($entry))
   {
    return $true
   }
  }
  return $false
 }
 catch [System.Exception]
 {
  Write-Error "An Error occured while reading the host file"
 }
}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, second edition\code listings\listing26-2.ps1
************************************************************************
function get-LastOn {
<#
.DESCRIPTION
Tell me the most recent event log entries for logon or logoff.
.BUGS
Blank 'computer' column

.EXAMPLE
get-LastOn -computername server1 | Sort-Object time -Descending | 
Sort-Object id -unique | format-table -AutoSize -Wrap
ID              Domain       Computer Time                
--              ------       -------- ----                
LOCAL SERVICE   NT AUTHORITY          4/3/2012 11:16:39 AM
NETWORK SERVICE NT AUTHORITY          4/3/2012 11:16:39 AM
SYSTEM          NT AUTHORITY          4/3/2012 11:16:02 AM

Sorting -unique will ensure only one line per user ID, the most recent.
Needs more testing

.EXAMPLE
PS C:\Users\administrator> get-LastOn -computername server1 -newest 10000
 -maxIDs 10000 | Sort-Object time -Descending |

 Sort-Object id -unique | format-table -AutoSize -Wrap

ID              Domain       Computer Time
--              ------       -------- ----
Administrator   USS                   4/11/2012 10:44:57 PM
ANONYMOUS LOGON NT AUTHORITY          4/3/2012 8:19:07 AM
LOCAL SERVICE   NT AUTHORITY          10/19/2011 10:17:22 AM
NETWORK SERVICE NT AUTHORITY          4/4/2012 8:24:09 AM
student         WIN7                  4/11/2012 4:16:55 PM
SYSTEM          NT AUTHORITY          10/18/2011 7:53:56 PM
USSDC$          USS                   4/11/2012 9:38:05 AM
WIN7$           USS                   10/19/2011 3:25:30 AM


PS C:\Users\administrator>

.EXAMPLE
get-LastOn -newest 1000 -maxIDs 20 
Only examines the last 1000 lines of the event log

.EXAMPLE
get-LastOn -computername server1| Sort-Object time -Descending | 
Sort-Object id -unique | format-table -AutoSize -Wrap
#>

param (
        [string]$ComputerName = 'localhost',
        [int]$Newest = 5000,
        [int]$maxIDs = 5,
        [int]$logonEventNum = 4624,
        [int]$logoffEventNum = 4647
    )

    $eventsAndIDs = Get-EventLog -LogName security -Newest $Newest | 
    Where-Object {$_.instanceid -eq $logonEventNum -or $_.instanceid -eq  $logoffEventNum} | 
    Select-Object -Last $maxIDs -Property TimeGenerated,Message,ComputerName

    foreach ($event in $eventsAndIDs) {
        $id = ($event | 
        parseEventLogMessage | 
        where-Object {$_.fieldName -eq "Account Name"}  | 
        Select-Object -last 1).fieldValue
 
        $domain = ($event | 
        parseEventLogMessage | 
        where-Object {$_.fieldName -eq "Account Domain"}  | 
        Select-Object -last 1).fieldValue
           
        $props = @{'Time'=$event.TimeGenerated;
            'Computer'=$ComputerName;
            'ID'=$id
            'Domain'=$domain}

        $output_obj = New-Object -TypeName PSObject -Property $props
        write-output $output_obj
    }  
}

function parseEventLogMessage()
{
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline=$True,Mandatory=$True)]
        [string]$Message 
    )    

    $eachLineArray = $Message -split "`n"
    
    foreach ($oneLine in $eachLineArray) {
        write-verbose "line:_$oneLine_"
        $fieldName,$fieldValue = $oneLine -split ":", 2
            try {
                $fieldName = $fieldName.trim() 
                $fieldValue = $fieldValue.trim() 
            }
            catch {
                $fieldName = ""
            }
            
            if ($fieldName -ne "" -and $fieldValue -ne "" ) 
            {
            $props = @{'fieldName'="$fieldName";
                    'fieldValue'=$fieldValue}
            
            $output_obj = New-Object -TypeName PSObject -Property $props
            Write-Output $output_obj
            }
    }
}
Get-LastOn


