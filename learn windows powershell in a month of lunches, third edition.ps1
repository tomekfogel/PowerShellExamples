
c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing21-1.txt
************************************************************************
$computername = 'localhost'                              
Get-WmiObject -class Win32_LogicalDisk -computername  $computername -filter "drivetype=3" |
 Sort-Object -property DeviceID |
 Format-Table -property DeviceID,
     @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
     @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing21-2.txt
************************************************************************
param (
  $computername = 'localhost'                                          
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername  -filter "drivetype=3" |
 Sort-Object -property DeviceID |
 Format-Table -property DeviceID,
     @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing21-3.txt
************************************************************************
param (
  $computername = 'localhost',
  $drivetype = 3                                                       
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername -filter "drivetype=$drivetype" |                                       
 Sort-Object -property DeviceID |
 Format-Table -property DeviceID,
     @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing21-4.txt
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
param (
  $computername = 'localhost',
  $drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Format-Table -property DeviceID,
     @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{label='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing22-1.txt
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
param (
  $computername = 'localhost',
  $drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing22-2.txt
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
  $computername = 'localhost',
  $drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing22-3.txt
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
  [string]$computername,
  [int]$drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing22-4.txt
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
  [int]$drivetype = 3
)
Get-WmiObject -class Win32_LogicalDisk -computername $computername -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing22-5.txt
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
Get-WmiObject -class Win32_LogicalDisk -computername $computername -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing22-6.txt
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
Get-WmiObject -class Win32_LogicalDisk -computername $computername -filter "drivetype=$drivetype" |
 Sort-Object -property DeviceID |
 Select-Object -property DeviceID,
     @{name='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
     @{name='Size(GB';expression={$_.Size / 1GB -as [int]}},
     @{name='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
Write-Verbose "Finished running command"



c:\users\rocky\desktop\powershell books examples\learn windows powershell in a month of lunches, third edition\Listing26-1.txt
************************************************************************
param(
  [parameter(Mandatory = $true)]
  [string] $Path,
  [parameter(Mandatory = $true)]
  [string] $Name 
  )
$System = [Environment]::GetFolderPath("System")
$script:hostsPath = ([System.IO.Path]::Combine($System, "drivers\etc\"))+"hosts"
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
 New-Website -ApplicationPool $siteName -Name $siteName -Port 80
[CA] -PhysicalPath $sitePath -HostHeader ($header) 
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


