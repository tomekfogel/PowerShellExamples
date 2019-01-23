
c:\users\rocky\desktop\powershell books examples\powershell and wmi\Appendix\ListingD.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter01\CIM\CodeSnippet1.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter01\CIM\Listing1.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter01\CIM\listing1.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter01\CIM\Listing1.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter01\CodeSnippet1.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter01\Listing1.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter01\listing1.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter01\Listing1.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter01\Listing1.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\CIM\Get-DiskInfo.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\CIM\Listing2.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\CIM\Listing2.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\CIM\Listing2.3a.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\CIM\Listing2.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\Get-DiskInfo.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\Listing2.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\Listing2.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\Listing2.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\Listing2.3a.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter02\Listing2.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\CIM\get-cimkey.ps1
************************************************************************
﻿## Replaces Listing 3.4
## Assumes that remote machine is running PowerShell v3
##
# Requires -Version 3
function get-cimkey {
param (
 [string]$namespace = "root\cimv2",
 [string]$class = "Win32_Service"
)
    Get-CimClass -Namespace $namespace -ClassName $class | 
    select -ExpandProperty properties | 
    foreach { 
     $name = $_.Name
     $_ | select -ExpandProperty Qualifiers |
     foreach { 
       if ($_.Name -eq "Key") {
         Write-Host "Key property of $namespace\$class is $name"
       }
     }
    }
}


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\CIM\Listing3.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\CIM\Listing3.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\CIM\Listing3.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\CIM\Listing3.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\CIM\Listing3.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\get-wmiclass.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\Listing3.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\Listing3.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\Listing3.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\Listing3.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\Listing3.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter03\Listing3.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\chapt4_ping_status.ps1xml
************************************************************************
<?xml version="1.0" encoding="utf-8"?><Configuration><ViewDefinitions><View><Name>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</Name><ViewSelectedBy><TypeName>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</TypeName></ViewSelectedBy><TableControl><TableHeaders><TableColumnHeader><Label>Source</Label><Width>13</Width></TableColumnHeader><TableColumnHeader><Label>Destination</Label><Width>15</Width></TableColumnHeader><TableColumnHeader><Label>IPV4Address</Label><Width>16</Width></TableColumnHeader><TableColumnHeader><Label>IPV6Address</Label><Width>40</Width></TableColumnHeader><TableColumnHeader><Label>Bytes</Label><Width>8</Width></TableColumnHeader><TableColumnHeader><Label>Time(ms)</Label><Width>9</Width></TableColumnHeader></TableHeaders><TableRowEntries><TableRowEntry><TableColumnItems><TableColumnItem><PropertyName>__Server</PropertyName></TableColumnItem><TableColumnItem><PropertyName>Address</PropertyName></TableColumnItem><TableColumnItem><PropertyName>IPV4Address</PropertyName></TableColumnItem><TableColumnItem><PropertyName>IPV6Address</PropertyName></TableColumnItem><TableColumnItem><PropertyName>BufferSize</PropertyName></TableColumnItem><TableColumnItem><PropertyName>ResponseTime</PropertyName></TableColumnItem></TableColumnItems></TableRowEntry></TableRowEntries></TableControl></View></ViewDefinitions></Configuration>


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\chapt4_ping_status.ps1xml
************************************************************************
<?xml version="1.0" encoding="utf-8"?><Configuration><ViewDefinitions><View><Name>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</Name><ViewSelectedBy><TypeName>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</TypeName></ViewSelectedBy><TableControl><TableHeaders><TableColumnHeader><Label>Source</Label><Width>13</Width></TableColumnHeader><TableColumnHeader><Label>Destination</Label><Width>15</Width></TableColumnHeader><TableColumnHeader><Label>IPV4Address</Label><Width>16</Width></TableColumnHeader><TableColumnHeader><Label>IPV6Address</Label><Width>40</Width></TableColumnHeader><TableColumnHeader><Label>Bytes</Label><Width>8</Width></TableColumnHeader><TableColumnHeader><Label>Time(ms)</Label><Width>9</Width></TableColumnHeader></TableHeaders><TableRowEntries><TableRowEntry><TableColumnItems><TableColumnItem><PropertyName>__Server</PropertyName></TableColumnItem><TableColumnItem><PropertyName>Address</PropertyName></TableColumnItem><TableColumnItem><PropertyName>IPV4Address</PropertyName></TableColumnItem><TableColumnItem><PropertyName>IPV6Address</PropertyName></TableColumnItem><TableColumnItem><PropertyName>BufferSize</PropertyName></TableColumnItem><TableColumnItem><PropertyName>ResponseTime</PropertyName></TableColumnItem></TableColumnItems></TableRowEntry></TableRowEntries></TableControl></View></ViewDefinitions></Configuration>


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\Code_Snippet_Section4.3.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\Listing4.1.ps1
************************************************************************
##
## Assumes that remote machine is running PowerShell v3
##
# Requires -Version 3
function get-ram {
[CmdletBinding()]
param ( 
 [parameter(Mandatory=$true)]
 [string]$computername
) 
 Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computername | 
 Select Name, @{Name="RAM"; Expression={$_.TotalPhysicalMemory / 1GB}} 
}



c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\Listing4.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\Listing4.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\Listing4.4.ps1xml
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\Listing4.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\Listing4.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\Pretty_chapt4_ping_status.ps1xml
************************************************************************
<?xml version="1.0" encoding="utf-8"?>
<Configuration><ViewDefinitions>
  <View>
    <Name>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</Name>
    <ViewSelectedBy>
      <TypeName>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</TypeName>
    </ViewSelectedBy>
    <TableControl>
      <TableHeaders>
        <TableColumnHeader>
          <Label>Source</Label>
          <Width>13</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Destination</Label>
          <Width>15</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>IPV4Address</Label>
          <Width>16</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>IPV6Address</Label>
          <Width>40</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Bytes</Label>
          <Width>8</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Time(ms)</Label>
          <Width>9</Width>
        </TableColumnHeader>
      </TableHeaders>
      <TableRowEntries>
        <TableRowEntry>
          <TableColumnItems>
            <TableColumnItem>
              <PropertyName>__Server</PropertyName>
            </TableColumnItem><TableColumnItem>
              <PropertyName>Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>IPV4Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>IPV6Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>BufferSize</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>ResponseTime</PropertyName>
            </TableColumnItem>
          </TableColumnItems>
        </TableRowEntry>
      </TableRowEntries>
    </TableControl>
  </View>
</ViewDefinitions>
</Configuration>


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\CIM\Win32_pingstatus.format.ps1xml
************************************************************************
<?xml version="1.0" encoding="utf-8"?>
<Configuration><ViewDefinitions>
  <View>
    <Name>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</Name>
    <ViewSelectedBy>
      <TypeName>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</TypeName>
    </ViewSelectedBy>
    <TableControl>
      <TableHeaders>
        <TableColumnHeader>
          <Label>Source</Label>
          <Width>13</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Destination</Label>
          <Width>15</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>IPV4Address</Label>
          <Width>16</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Bytes</Label>
          <Width>8</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Time(ms)</Label>
          <Width>9</Width>
        </TableColumnHeader>
      </TableHeaders>
      <TableRowEntries>
        <TableRowEntry>
          <TableColumnItems>
            <TableColumnItem>
              <PropertyName>__Server</PropertyName>
            </TableColumnItem><TableColumnItem>
              <PropertyName>Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>IPV4Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>BufferSize</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>ResponseTime</PropertyName>
            </TableColumnItem>
          </TableColumnItems>
        </TableRowEntry>
      </TableRowEntries>
    </TableControl>
  </View>
</ViewDefinitions>
</Configuration>


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Code_Snippet_Section4.3.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Listing4.1.ps1
************************************************************************
function get-ram {
[CmdletBinding()]
param ( 
 [parameter(Mandatory=$true)]
 [string]$computername
) 
 Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computername | 
 Select Name, @{Name="RAM"; Expression={$_.TotalPhysicalMemory / 1GB}} 
}



c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Listing4.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Listing4.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Listing4.4.ps1xml
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Listing4.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Listing4.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Listing4.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Pretty_chapt4_ping_status.ps1xml
************************************************************************
<?xml version="1.0" encoding="utf-8"?>
<Configuration><ViewDefinitions>
  <View>
    <Name>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</Name>
    <ViewSelectedBy>
      <TypeName>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</TypeName>
    </ViewSelectedBy>
    <TableControl>
      <TableHeaders>
        <TableColumnHeader>
          <Label>Source</Label>
          <Width>13</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Destination</Label>
          <Width>15</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>IPV4Address</Label>
          <Width>16</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>IPV6Address</Label>
          <Width>40</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Bytes</Label>
          <Width>8</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Time(ms)</Label>
          <Width>9</Width>
        </TableColumnHeader>
      </TableHeaders>
      <TableRowEntries>
        <TableRowEntry>
          <TableColumnItems>
            <TableColumnItem>
              <PropertyName>__Server</PropertyName>
            </TableColumnItem><TableColumnItem>
              <PropertyName>Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>IPV4Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>IPV6Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>BufferSize</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>ResponseTime</PropertyName>
            </TableColumnItem>
          </TableColumnItems>
        </TableRowEntry>
      </TableRowEntries>
    </TableControl>
  </View>
</ViewDefinitions>
</Configuration>


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter04\Win32_pingstatus.format.ps1xml
************************************************************************
<?xml version="1.0" encoding="utf-8"?>
<Configuration><ViewDefinitions>
  <View>
    <Name>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</Name>
    <ViewSelectedBy>
      <TypeName>System.Management.ManagementObject#root\cimv2\Win32_PingStatus</TypeName>
    </ViewSelectedBy>
    <TableControl>
      <TableHeaders>
        <TableColumnHeader>
          <Label>Source</Label>
          <Width>13</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Destination</Label>
          <Width>15</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>IPV4Address</Label>
          <Width>16</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Bytes</Label>
          <Width>8</Width>
        </TableColumnHeader>
        <TableColumnHeader>
          <Label>Time(ms)</Label>
          <Width>9</Width>
        </TableColumnHeader>
      </TableHeaders>
      <TableRowEntries>
        <TableRowEntry>
          <TableColumnItems>
            <TableColumnItem>
              <PropertyName>__Server</PropertyName>
            </TableColumnItem><TableColumnItem>
              <PropertyName>Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>IPV4Address</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>BufferSize</PropertyName>
            </TableColumnItem>
            <TableColumnItem>
              <PropertyName>ResponseTime</PropertyName>
            </TableColumnItem>
          </TableColumnItems>
        </TableRowEntry>
      </TableRowEntries>
    </TableControl>
  </View>
</ViewDefinitions>
</Configuration>


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Alternative Non-Report Style\Listing5.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Alternative Non-Report Style\Listing5.13.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Alternative Non-Report Style\Listing5.19.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Alternative Non-Report Style\Listing5.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Alternative Non-Report Style\Listing5.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Alternative Non-Report Style\Listing5.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Alternative Non-Report Style\Listing5.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Alternative Non-Report Style\Listing5.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.12.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.13.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.14.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.15.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.16.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.17.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.18.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.19.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\CIM\Listing5.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\get-systemdriver.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.12.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.13.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.14.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.15.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.16.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.17.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.18.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.19.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter05\Listing5.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Alternative Non-Report Style\Listing6.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Alternative Non-Report Style\Listing6.13.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Alternative Non-Report Style\Listing6.14.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Alternative Non-Report Style\Listing6.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Alternative Non-Report Style\Listing6.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Alternative Non-Report Style\Listing6.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.12.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.13.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.14.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\CIM\Listing6.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Extras\Listing6.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.12.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.13.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.14.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter06\Listing6.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\CIM\Listing7.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\CIM\Listing7.12.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.11a.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.12.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter07\Listing7.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\CIM\Listing8.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\CIM\Listing8.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\CIM\Listing8.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\CIM\Listing8.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\CIM\Listing8.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\CIM\Listing8.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\CIM\Listing8.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\CIM\test-event.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.8a.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\Listing8.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter08\test-event.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\CIM\Listing9.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\CIM\Listing9.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\CIM\Listing9.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\CIM\Listing9.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\CIM\Listing9.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\CIM\Listing9.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\CIM\Listing9.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\CIM\Listing9.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\Listing9.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\Listing9.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\Listing9.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\Listing9.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\Listing9.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\Listing9.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\Listing9.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\Listing9.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter09\Listing9.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Alternative Non-Report Style\Listing10.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Get-PrinterSecurity.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\CIM\Listing10.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Get-PrinterSecurity.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter10\Listing10.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\get-ipconfig.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.12.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.13.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.14.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.15.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\CIM\Listing11.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\get-ipconfig.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.12.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.13.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.14.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.15.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter11\Listing11.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\expand-property.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\Listing12.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\Listing12.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\Listing12.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\Listing12.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\Listing12.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\Listing12.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\Listing12.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\Listing12.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\Listing12.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter12\new-site.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\CIM\Listing13.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\CIM\Listing13.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\CIM\Listing13.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\CIM\Listing13.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\CIM\Listing13.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\CIM\Listing13.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\CIM\Listing13.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\CIM\Listing13.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter13\Listing13.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\CIM\Listing14.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter14\Listing14.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\CIM\Listing15.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\CIM\Listing15.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\CIM\Listing15.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\CIM\Listing15.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\CIM\Listing15.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\CIM\Listing15.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\CIM\Listing15.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\CIM\Listing15.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\Listing15.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\Listing15.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\Listing15.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\Listing15.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\Listing15.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\Listing15.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\Listing15.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\Listing15.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\newday.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter15\newmonthday.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\get-nextdriveletter.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\get-nextpartition.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.10.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.11.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.5.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.6.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.7.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.8.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\Listing16.9.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter16\remove-pawiso.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter17\Listing17.1.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter17\Listing17.2.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter17\Listing17.3.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter17\Listing17.4.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\Listing18.5\Win32OperatingSystem.format.ps1xml
************************************************************************
﻿<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
<ViewDefinitions>  
<View>
 <Name>Formatting For Win32_OperatingSystem (Table View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <TableControl>
     <TableHeaders>
       <TableColumnHeader>
         <Label>OS</Label>
         <Width>30</Width>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>SP</Label>
         <Width>2</Width>
         <Alignment>right</Alignment>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>Arch</Label>
         <Width>6</Width>
       </TableColumnHeader>
       <TableColumnHeader>
         <Width>19</Width>
       </TableColumnHeader>
     </TableHeaders>
     <TableRowEntries>
       <TableRowEntry>
         <TableColumnItems>
           <TableColumnItem>
              <PropertyName>SKU</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>ServicePackMajorVersion</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>OSArchitecture</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>LastBootUpTime</PropertyName>
           </TableColumnItem>
         </TableColumnItems>
       </TableRowEntry>
     </TableRowEntries>
   </TableControl>
</View>    
<View>
 <Name>Formatting For Win32_OperatingSystem  (List View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <ListControl>
     <ListEntries>
       <ListEntry>
         <ListItems>
           <ListItem>
             <PropertyName>Caption</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>ServicePackMajorVersion</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>OSArchitecture</PropertyName>
           </ListItem>				
           <ListItem>
             <PropertyName>LastBootUpTime</PropertyName>
           </ListItem>				
         </ListItems>
       </ListEntry>
     </ListEntries>
   </ListControl>
</View>        
</ViewDefinitions>
</Configuration>



c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\Listing18.6\Win32OperatingSystem.format.ps1xml
************************************************************************
﻿<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
<ViewDefinitions>  
<View>
 <Name>Formatting For Win32_OperatingSystem (Table View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <TableControl>
     <TableHeaders>
       <TableColumnHeader>
         <Label>OS</Label>
         <Width>30</Width>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>SP</Label>
         <Width>2</Width>
         <Alignment>right</Alignment>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>Arch</Label>
         <Width>6</Width>
       </TableColumnHeader>
       <TableColumnHeader>
         <Width>19</Width>
       </TableColumnHeader>
     </TableHeaders>
     <TableRowEntries>
       <TableRowEntry>
         <TableColumnItems>
           <TableColumnItem>
              <PropertyName>SKU</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>ServicePackMajorVersion</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>OSArchitecture</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>LastBootUpTime</PropertyName>
           </TableColumnItem>
         </TableColumnItems>
       </TableRowEntry>
     </TableRowEntries>
   </TableControl>
</View>    
<View>
 <Name>Formatting For Win32_OperatingSystem  (List View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <ListControl>
     <ListEntries>
       <ListEntry>
         <ListItems>
           <ListItem>
             <PropertyName>Caption</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>ServicePackMajorVersion</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>OSArchitecture</PropertyName>
           </ListItem>				
           <ListItem>
             <PropertyName>LastBootUpTime</PropertyName>
           </ListItem>				
         </ListItems>
       </ListEntry>
     </ListEntries>
   </ListControl>
</View>        
</ViewDefinitions>
</Configuration>



c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\Listing18.6\Win32OperatingSystem.types.ps1xml
************************************************************************
﻿<Types>
 <Type>
   <Name>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</Name>
   <Members>
     <ScriptProperty>
        <Name>SKU</Name>
          <GetScriptBlock>
           [Microsoft.PowerShell.Cmdletization.GeneratedTypes.OperatingSystem.OperatingSystemSKU][System.uint32]$this.OperatingSystemSKU
          </GetScriptBlock>
     </ScriptProperty>
   </Members>
 </Type>
</Types>


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\Listing19.1\Win32OperatingSystem.format.ps1xml
************************************************************************
﻿<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
<ViewDefinitions>  
<View>
 <Name>Formatting For Win32_OperatingSystem (Table View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <TableControl>
     <TableHeaders>
       <TableColumnHeader>
         <Label>OS</Label>
         <Width>30</Width>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>SP</Label>
         <Width>2</Width>
         <Alignment>right</Alignment>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>Arch</Label>
         <Width>6</Width>
       </TableColumnHeader>
       <TableColumnHeader>
         <Width>19</Width>
       </TableColumnHeader>
     </TableHeaders>
     <TableRowEntries>
       <TableRowEntry>
         <TableColumnItems>
           <TableColumnItem>
              <PropertyName>SKU</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>ServicePackMajorVersion</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>OSArchitecture</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>LastBootUpTime</PropertyName>
           </TableColumnItem>
         </TableColumnItems>
       </TableRowEntry>
     </TableRowEntries>
   </TableControl>
</View>    
<View>
 <Name>Formatting For Win32_OperatingSystem  (List View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <ListControl>
     <ListEntries>
       <ListEntry>
         <ListItems>
           <ListItem>
             <PropertyName>Caption</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>ServicePackMajorVersion</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>OSArchitecture</PropertyName>
           </ListItem>				
           <ListItem>
             <PropertyName>LastBootUpTime</PropertyName>
           </ListItem>				
         </ListItems>
       </ListEntry>
     </ListEntries>
   </ListControl>
</View>        
</ViewDefinitions>
</Configuration>



c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\Listing19.1\Win32OperatingSystem.types.ps1xml
************************************************************************
﻿<Types>
 <Type>
   <Name>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</Name>
   <Members>
     <ScriptProperty>
        <Name>SKU</Name>
          <GetScriptBlock>
           [Microsoft.PowerShell.Cmdletization.GeneratedTypes.OperatingSystem.OperatingSystemSKU][System.uint32]$this.OperatingSystemSKU
          </GetScriptBlock>
     </ScriptProperty>
   </Members>
 </Type>
</Types>


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\Listing19.2\Win32OperatingSystem.format.ps1xml
************************************************************************
﻿<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
<ViewDefinitions>  
<View>
 <Name>Formatting For Win32_OperatingSystem (Table View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <TableControl>
     <TableHeaders>
       <TableColumnHeader>
         <Label>OS</Label>
         <Width>30</Width>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>SP</Label>
         <Width>2</Width>
         <Alignment>right</Alignment>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>Arch</Label>
         <Width>6</Width>
       </TableColumnHeader>
       <TableColumnHeader>
         <Width>19</Width>
       </TableColumnHeader>
     </TableHeaders>
     <TableRowEntries>
       <TableRowEntry>
         <TableColumnItems>
           <TableColumnItem>
              <PropertyName>SKU</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>ServicePackMajorVersion</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>OSArchitecture</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>LastBootUpTime</PropertyName>
           </TableColumnItem>
         </TableColumnItems>
       </TableRowEntry>
     </TableRowEntries>
   </TableControl>
</View>    
<View>
 <Name>Formatting For Win32_OperatingSystem  (List View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <ListControl>
     <ListEntries>
       <ListEntry>
         <ListItems>
           <ListItem>
             <PropertyName>Caption</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>ServicePackMajorVersion</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>OSArchitecture</PropertyName>
           </ListItem>				
           <ListItem>
             <PropertyName>LastBootUpTime</PropertyName>
           </ListItem>				
         </ListItems>
       </ListEntry>
     </ListEntries>
   </ListControl>
</View>        
</ViewDefinitions>
</Configuration>



c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\Listing19.2\Win32OperatingSystem.types.ps1xml
************************************************************************
﻿<Types>
 <Type>
   <Name>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</Name>
   <Members>
     <ScriptProperty>
        <Name>SKU</Name>
          <GetScriptBlock>
           [Microsoft.PowerShell.Cmdletization.GeneratedTypes.OperatingSystem.OperatingSystemSKU][System.uint32]$this.OperatingSystemSKU
          </GetScriptBlock>
     </ScriptProperty>
   </Members>
 </Type>
</Types>


c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\Listing19.3\set-cimsession.ps1
************************************************************************
﻿function set-cimsession {
[CmdletBinding()]
param (
 [string]$computername="$env:COMPUTERNAME"   
 )
BEGIN {
 $opt = New-CimSessionOption -Protocol DCOM  
}

PROCESS {
switch ($computername){
 "."         {$computername="$env:COMPUTERNAME" }
 "localhost" {$computername="$env:COMPUTERNAME" }
}

if (-not (Test-Connection -ComputerName $computername -Quiet -Count 1)){
  Throw "Computer: $($computername) could not be contacted"   
}

$twsman = Test-WSMan -ComputerName $computername -Authentication Default  
$pva = $twsman.ProductVersion -split ": "
$stack = $pva[-1]
Write-Debug $stack                        

switch ($stack){ 
 "2.0" {$ncs = New-CimSession -ComputerName $computername -SessionOption $opt }
 "3.0" {$ncs = New-CimSession -ComputerName $computername }
 default {Throw "Error - could not recognise WSMAN stack for $computer"}
}
$ncs 
} # end process
}



c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\Listing19.4\get-systeminfo.ps1
************************************************************************
﻿function get-systeminfo {
[CmdletBinding()]
param (
 [string]$computername="$env:COMPUTERNAME"
 )
BEGIN {
 Import-Module systeminfo –Force 
}

PROCESS {
switch ($computername){
 "."         {$computername="$env:COMPUTERNAME" }
 "localhost" {$computername="$env:COMPUTERNAME" }
}
if (-not (Test-Connection -ComputerName $computername -Quiet -Count 1)){
  Throw "Computer: $($computername) could not be contacted" 
}

if (-not(Test-Path -Path variable:\"cs_$computername")){ 
  New-Variable -Name "cs_$computername" `
  -Value (set-cimsession -computer $computername)
}

Get-Win32OperatingSystem `
-CimSession (Get-Variable -Name "cs_$computername").Value | 
Out-Default

Get-CimInstance -ClassName Win32_ComputerSystem `
-CimSession (Get-Variable -Name "cs_$computername").Value | 
Out-Default
} # end process
}



c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\SystemInfo\Win32OperatingSystem.format.ps1xml
************************************************************************
﻿<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
<ViewDefinitions>  
<View>
 <Name>Formatting For Win32_OperatingSystem (Table View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <TableControl>
     <TableHeaders>
       <TableColumnHeader>
         <Label>OS</Label>
         <Width>30</Width>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>SP</Label>
         <Width>2</Width>
         <Alignment>right</Alignment>
       </TableColumnHeader>
	   <TableColumnHeader>
         <Label>Arch</Label>
         <Width>6</Width>
       </TableColumnHeader>
       <TableColumnHeader>
         <Width>19</Width>
       </TableColumnHeader>
     </TableHeaders>
     <TableRowEntries>
       <TableRowEntry>
         <TableColumnItems>
           <TableColumnItem>
              <PropertyName>SKU</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>ServicePackMajorVersion</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>OSArchitecture</PropertyName>
           </TableColumnItem>
           <TableColumnItem>
              <PropertyName>LastBootUpTime</PropertyName>
           </TableColumnItem>
         </TableColumnItems>
       </TableRowEntry>
     </TableRowEntries>
   </TableControl>
</View>    
<View>
 <Name>Formatting For Win32_OperatingSystem  (List View)</Name>
   <ViewSelectedBy>
     <TypeName>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</TypeName>
   </ViewSelectedBy>
   <ListControl>
     <ListEntries>
       <ListEntry>
         <ListItems>
           <ListItem>
             <PropertyName>Caption</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>ServicePackMajorVersion</PropertyName>
           </ListItem>
           <ListItem>
             <PropertyName>OSArchitecture</PropertyName>
           </ListItem>				
           <ListItem>
             <PropertyName>LastBootUpTime</PropertyName>
           </ListItem>				
         </ListItems>
       </ListEntry>
     </ListEntries>
   </ListControl>
</View>        
</ViewDefinitions>
</Configuration>



c:\users\rocky\desktop\powershell books examples\powershell and wmi\Chapter18-19\SystemInfo\Win32OperatingSystem.types.ps1xml
************************************************************************
﻿<Types>
 <Type>
   <Name>Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_OperatingSystem</Name>
   <Members>
     <ScriptProperty>
        <Name>SKU</Name>
          <GetScriptBlock>
           [Microsoft.PowerShell.Cmdletization.GeneratedTypes.OperatingSystem.OperatingSystemSKU][System.uint32]$this.OperatingSystemSKU
          </GetScriptBlock>
     </ScriptProperty>
   </Members>
 </Type>
</Types>

