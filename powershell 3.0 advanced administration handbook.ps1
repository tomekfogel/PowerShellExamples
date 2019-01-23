
c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\AddPswaAuthorizationRule.ps1
************************************************************************
﻿Add-PswaAuthorizationRule -UserName PSWA\Administrator -ComputerName PSWA -ConfigurationName Microsoft.PowerShell


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\foreach-statement.ps1
************************************************************************
﻿$handleSum = 0;
foreach($process in Get-Process |
Where-Object {$_.Handles -gt 600})
{
$handleSum += $process.Handles
}
$handleSum


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\for-statement.ps1
************************************************************************
﻿for($counter = 0; $counter -lt 10; $counter++)
{
Write-Host "Processing item $counter"
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\Generate-TempFiles.ps1
************************************************************************
"File1.tmp"
"File2.tmp"
"File3.tmp"



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\Get-HelloArgs.ps1
************************************************************************
$firstName = $args[0]
$lastName = $args[1]
Write-Host "Hello, $firstName $lastName"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\Get-HelloParam.ps1
************************************************************************
param ($firstName, $lastName)
Write-Host "Hello, $firstName $lastName"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\GetWMICimObject.ps1
************************************************************************
﻿Get-WMIObject -Class Win32_Process -Namespace root/cimv2 -ComputerName . | Format-Wide


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\hello-world.ps1
************************************************************************
Write-Host "Hello, world!"



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\If-else.ps1
************************************************************************
﻿$textForMatch = Read-Host "Input some text"
$matchType = Read-Host "Supply Simple or Regex matching?"
$pattern = Read-Host "Match pattern"
if ($matchType -eq "Simple")
{
$textForMatch -like $pattern
}
elseif($matchType -eq "Regex")
{
$textForMatch -match $pattern
}
else
{
Write-Host "Match type must be Simple or Regex"
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\InstallPswaWebApplication.ps1
************************************************************************
﻿Install-PswaWebApplication -WebSiteName "Default Web Site" -WebApplicationName "PSWA" -UseTestCertificate


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\InstallWindowsPowerShellWebAccess .ps1
************************************************************************
﻿Install-WindowsFeature WindowsPowerShellWebAccess -IncludeAllSubFeature -IncludeManagementTools


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\InvokeWMICIMMethod.ps1
************************************************************************
﻿Invoke-WMIMethod -class Win32_Process -Name create -ArgumentList 'mspaint.exe'
Invoke-CimMethod Win32_Process -MethodName create -Agruments @{CommandLine='mspaint.exe'}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\NestedLoops.ps1
************************************************************************
﻿foreach($wmiclass in "Win32_Service","Win32_UserAccout","Win32_Process")
{
	foreach($instance in Get-WmiObject $wmiclass){
	 if(!(($instance.nname.toLower()).StartWith("a"))){continue}
	 "{0}:{1}" -f $instance.__CLASS,$instance.name
	}
}


:WMIClasses foreach($wmiclass in "Win32_Service","Win32_UserAccout","Win32_Process"){
	:ExamineClasses foreach($instance in Get-WmiObject $wmiclass){
	  if(($instance.nname.toLower()).StartWith("a")){
	     "{0}:{1}" -f $instance.__CLASS,$instance.name
	     continue WMIClasses
	     }
	  }
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\NewIseSnippet.ps1
************************************************************************
﻿New-IseSnippet -Title RestartSQLServerServices -Description "Restart all SQL Server Services" -Text "Restart-Service -Name *SQL*"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\NewJobTriggerRegisterScheduledJob.ps1
************************************************************************
﻿$trigger = New-JobTrigger -Daily -At 2am
Register-ScheduledJob -Name ClearEventLogDaily -Trigger $trigger -ScriptBlock {Clear-EventLog -LogName Application,Security,System


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_01_Codes\SortObject.ps1
************************************************************************
﻿Get-Process | Sort-Object -Descending CPU | Select ProcessName


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_02_Codes\MySnapIn\MySnapIn\bin\Debug\Install.ps1
************************************************************************
﻿#Run mode PS> .\Install.ps1 -force
#following configuration
#dll name
$FileName="MySnapIn.dll"
#snap-in name
$PSSnapinName="MySnapIn"
#following do not modify

if($PSVersionTable) {
   Write-Host "You're running PowerShell $($PSVersionTable.PSVersion), 
   so you don't need to Install this as a PSSnapin, you can use Import-Module (or Add-Module in CTP2) to load it.
   If you still want to install it as a PSSnapin, re-run this script with -Force"
   if($args -notcontains "-Force") {
      return
   }
}

$rtd=[System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()
set-alias installutil (resolve-path (join-path $rtd installutil.exe))

# cd C:\Users\Administrator\Projects\PowerShell\MySnapIn\bin\Debug
installutil (Join-Path (Split-Path $MyInvocation.MyCommand.Path) $FileName)

if($?) {
# Get-PSSnapin -registered
Add-PSSnapin $PSSnapinName

#Get-PSSnapin -registered

# get-help *-Window
Get-Command -PSSnapin $PSSnapinName

Write-Host "To load the Snapin in the future, you need to run:"
Write-Host "Add-PSSnapin $PSSnapinName" -fore Red
Write-Host 
Write-Host "You can also add that line to your Profile script to load it automatically."
} else {

Write-Warning @"
`nInstallation Failed. You're probably just not running as administrator.
If you see a System.UnauthorizedAccessException in the log output above, with an HKEY_LOCAL_MACHINE path,
 that's deffinitely what happened, just start an administrative console and try again.
"@
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_02_Codes\MySnapIn\MySnapIn\bin\Debug\UnInstall.ps1
************************************************************************
﻿#Run mode PS> .\UnInstall.ps1
#following configuration
#dll name
$FileName="MySnapIn.dll"
#snap-in name
$PSSnapinName="MySnapIn"
#following do not modify

Remove-PSSnapin $PSSnapinName


$rtd = [System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()
set-alias installutil (resolve-path (join-path $rtd installutil.exe))

installutil /u (Join-Path (Split-Path $MyInvocation.MyCommand.Path) $FileName)




c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Add-TrustedHosts.ps1
************************************************************************
﻿Set-item wsman:localhost\client\trustedhosts -value *
Set-item wsman:localhost\client\trustedhosts -value "Computer1,Computer2"
Set-item wsman:localhost\client\trustedhosts -value "*.domain.com"
Set-item wsman:localhost\client\trustedhosts -value "192.168.10.11"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Enter-PSSession.ps1
************************************************************************
﻿Enter-PSSession -ComputerName win-8


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Export-RemoteSessiontoModuleonDisk .ps1
************************************************************************
﻿$session = New-PSSession -ComputerName win-8
Invoke-Command -Session $session –ScriptBlock {Import-Module NetTCPIP}
Export-PSSession -Session $session -OutputModule RemoteCommands -AllowClobber -Module NetTCPIP -Force


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\get-PSsessionconfigurations .ps1
************************************************************************
﻿Get-WSManInstance winrm/config/plugin -Enumerate -ComputerName win-8 | Where ` { $_.FileName -like '*pwrshplugin.dll'} | Select Name


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Invok_custom_session_configuration.ps1
************************************************************************
﻿$s = New-PSSession -ComputerName win-8 -ConfigurationName NetTCPIP
Enter-PSSession -ComputerName win-8 -ConfigurationName NetTCPIP
Invoke-Command -ComputerName win-8 -ConfigurationName NetTCPIP -ScriptBlock {Get-Process}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Invoke-RemotingCommandinSession.ps1
************************************************************************
﻿Invoke-Command -Session $session -ScriptBlock {Get-Service}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Remove-RemotingListener.ps1
************************************************************************
﻿Set-Service winrm -StartupType Manual
Stop-Service winrm
Get-ChildItem WSMan:\localhost\Listener -Recurse | Foreach-Object { $_.PSPath } | Where-Object { (Get-Item "$_\Port").Value -eq 5985 } | Remove-Item


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Runn-RemoteCommandsasJob.ps1
************************************************************************
﻿$session=New-PSSession -ComputerName Win-8
Invoke-Command -Session $session -ScriptBlock { (Get-ChildItem C:\ -Recurse).Count} -asjob


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Set_network_location_to_Private.ps1
************************************************************************
﻿# Skip  network location setting for pre-Vista operating systems 
if([environment]::OSVersion.version.Major -lt 6) { return } 
# Skip network location setting if local machine is joined to a domain. 
if(1,3,4,5 -contains (Get-WmiObject win32_computersystem).DomainRole) { return } 
# Get network connections 
$networkListManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}")) 
$connections = $networkListManager.GetNetworkConnections() 
# Set network location to Private for all networks 
$connections | % {$_.GetNetwork().SetCategory(1)}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Set-PSSessionConfiguration.ps1
************************************************************************
﻿Set-PSSessionConfiguration -Name NetTCPIP -ShowSecurityDescriptorUI


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Specify-credentialsforRemoting.ps1
************************************************************************
﻿$cred=Get-Credential
Invoke-Command -ComputerName win-8 -ScriptBlock {Get-Service} -Credential $cred


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_03_Codes\Using-PersistentSessionInInteractiveSession.ps1
************************************************************************
﻿$session= New-PSSession -ComputerName win-8
Enter-PSSession -Session $session


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_04_Codes\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
************************************************************************
Import-Module PSNet


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_04_Codes\WindowsPowerShell\Modules\MyModule\Say-Hello.ps1
************************************************************************
function Say-Hello{
Write-Host 'Hello World!'
}
# SIG # Begin signature block
# MIIEbwYJKoZIhvcNAQcCoIIEYDCCBFwCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUwZ2Gxia1deNWAk3Q1Wm42m+z
# 9lCgggJqMIICZjCCAdOgAwIBAgIQZ9xUemK7Pq9PBH6N9yirLzAJBgUrDgMCHQUA
# MDsxOTA3BgNVBAMTMFdpbmRvd3MgUG93ZXJTaGVsbCBMb2NhbCBDZXJ0aWZpY2F0
# aW9uIEF1dGhvcml0eTAeFw0xMzAyMjUxMzAyMDVaFw0zOTEyMzEyMzU5NTlaMCcx
# JTAjBgNVBAMTHFBvd2VyU2hlbGwgU2NyaXB0cyBQdWJsaXNoZXIwgZ8wDQYJKoZI
# hvcNAQEBBQADgY0AMIGJAoGBAL3tUPe4+cKWeZHTaeWc/hpru6xXZuVh5qtU4d3S
# lLaMhEOFsWAtOgYuLy/iivQ1jNxtngcr1o7OuE3IesU9pzpOk5YDtW7aKJgiSIG1
# j+wajtlOft3vN+oGDIJLKvUg8Qvy5zUE0394gr6vqX8K5cz01pVDBee/N0eK6ch2
# ZWxRAgMBAAGjgYYwgYMwEwYDVR0lBAwwCgYIKwYBBQUHAwMwbAYDVR0BBGUwY4AQ
# /tGoMEp/dtW+hCabjqC4caE9MDsxOTA3BgNVBAMTMFdpbmRvd3MgUG93ZXJTaGVs
# bCBMb2NhbCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eYIQ5TxMCcpMy5pOCdUs+AD3
# 9TAJBgUrDgMCHQUAA4GBABpYGEQvlaxFRsqqAsFCvPQCugfAo7K8UHq9AJI+uk0o
# Xd+lhMJCPpDJFxI6kKFpGj9TLoa3SviDqFzTG9o6G9JpGLEf1P5zODgEY6BKuXRP
# aj5StpXSG0D2KKNWkPhKVfx2Y+J+2LDSWK3M2ZY/UXyHEmaDEzrPw7rfez2p6vI/
# MYIBbzCCAWsCAQEwTzA7MTkwNwYDVQQDEzBXaW5kb3dzIFBvd2VyU2hlbGwgTG9j
# YWwgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkCEGfcVHpiuz6vTwR+jfcoqy8wCQYF
# Kw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkD
# MQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJ
# KoZIhvcNAQkEMRYEFIV04i7yp/tGQYsz12+sf0aljupFMA0GCSqGSIb3DQEBAQUA
# BIGAueAv282sJ7uImXYXbnbHZT0MGG4XI3K2NJ446GxxL81FE0cfjGXbzSCOa2OH
# cy7EUpRdzc6qY42h2thbN5tDyEzDNxLGL4B2fNaXsPcN74I7SBk2d4xt0Ab/i1Kj
# yjp+fNJh0ClbHuzLyNsiEL95MAkeunXtUEGCNifFq8jj7Hg=
# SIG # End signature block



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_04_Codes\WindowsPowerShell\Modules\PSNet\TCPOp\Receive-TCPMessage.ps1
************************************************************************
Function Receive-TCPMessage
{
	param ( [ValidateNotNullOrEmpty()]
	[int] $Port )

	try
	{
		$EndPoint = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Loopback,$Port)
		$Socket = New-Object System.Net.Sockets.TCPListener($EndPoint)
		$Socket.Start()
		$Socket = $Socket.AcceptTCPClient()
		$EncodedText = New-Object System.Text.ASCIIEncoding
		$Stream = $Socket.GetStream()
		$Buffer = New-Object System.Byte[] $Socket.ReceiveBufferSize		
		while( $Bytes = $Stream.Read($Buffer,0,$Buffer.Length) )
		{
		    $Stream.Write($Buffer,0,$Bytes)
		    Write-Output $EncodedText.GetString($Buffer,0,$Bytes)
		}
		$Socket.Close()
		$Socket.Stop()
	}
	catch{}
}



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_04_Codes\WindowsPowerShell\Modules\PSNet\TCPOp\Send-TCPMessage.ps1
************************************************************************
Function Send-TCPMessage
{
	param ( [ValidateNotNullOrEmpty()]
	[string] $EndPoint,
	[int] $Port,
	[string] $Message )
	
	$IP = [System.Net.Dns]::GetHostAddresses($EndPoint)
	$Address = [System.Net.IPAddress]::Parse($IP)
	$Socket = New-Object System.Net.Sockets.TCPClient($Address,$Port)
	$Stream = $Socket.GetStream()
	$Writer = New-Object System.IO.StreamWriter($Stream)
	$Writer.AutoFlush = $true
	$Writer.NewLine = $true
	$Writer.Write($Message)
	$Socket.Close()
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_04_Codes\WindowsPowerShell\Modules\PSNet1.3\TCPOp\Receive-TCPMessage.ps1
************************************************************************
Function Receive-TCPMessage
{
	param ( [ValidateNotNullOrEmpty()]
	[int] $Port )

	try
	{
		$EndPoint = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Loopback,$Port)
		$Socket = New-Object System.Net.Sockets.TCPListener($EndPoint)
		$Socket.Start()
		$Socket = $Socket.AcceptTCPClient()
		$EncodedText = New-Object System.Text.ASCIIEncoding
		$Stream = $Socket.GetStream()
		$Buffer = New-Object System.Byte[] $Socket.ReceiveBufferSize		
		while( $Bytes = $Stream.Read($Buffer,0,$Buffer.Length) )
		{
		    $Stream.Write($Buffer,0,$Bytes)
		    Write-Output $EncodedText.GetString($Buffer,0,$Bytes)
		}
		$Socket.Close()
		$Socket.Stop()
	}
	catch{}
}



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_04_Codes\WindowsPowerShell\Modules\PSNet1.3\TCPOp\Send-TCPMessage.ps1
************************************************************************
Function Send-TCPMessage
{
	param ( [ValidateNotNullOrEmpty()]
	[string] $EndPoint,
	[int] $Port,
	[string] $Message )
	
	$IP = [System.Net.Dns]::GetHostAddresses($EndPoint)
	$Address = [System.Net.IPAddress]::Parse($IP)
	$Socket = New-Object System.Net.Sockets.TCPClient($Address,$Port)
	$Stream = $Socket.GetStream()
	$Writer = New-Object System.IO.StreamWriter($Stream)
	$Writer.AutoFlush = $true
	$Writer.NewLine = $true
	$Writer.Write($Message)
	$Socket.Close()
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Add DHCP IP Address Reservation.ps1
************************************************************************
﻿#Add DHCP IP Address Reservation
Add‑DhcpServerv4Reservation ‑ScopeId 192.168.0.0 ‑IPAddress 192.168.0.10 ‑ClientId F4-DA-F1-78-00-6D ‑Description "Multi-Function Network Printer in 3rd floor"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Change default Shell to PowerShell.ps1
************************************************************************
﻿#Change default shell from cmd.exe to PowerShell
Set‑ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\winlogon" Shell PowerShell.exe


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Configuring DHCP scope exclusion.ps1
************************************************************************
﻿#Configuring DHCP scope exclusion
Add‑DhcpServerv4ExclusionRange ‑ScopeId 192.168.0.0 ‑StartRange 192.168.0.100 -EndRange 192.168.0.130


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Configuring DHCP Scope options.ps1
************************************************************************
﻿#Configuring DHCP Scope options (e.g. DNS Server and Router)
Set‑DhcpServerv4OptionValue ‑DnsDomain contoso.local ‑DnsServer 192.168.0.2 ‑Router 192.168.0.1


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Configuring DNS server resource records.ps1
************************************************************************
﻿#Add DNS Server 'A' Resource Record
Add-DnsServerResourceRecordA ‑Name FileServer ‑Ipv4Address 192.168.1.20 ‑ZoneName Contoso.local

#Add DNS Server 'CName' Resource Record
Add-DnsServerResourceRecordCName ‑Name OWA ‑HostNameAlias EXCH‑MBXCAS‑02.Contoso.local ‑ZoneName Contoso.local

#Add DNS Server 'MX' Resource Record
Add-DnsServerResourceRecordMX ‑Name Mail ‑MailExchange EXCH‑HUB‑01.Contoso.local ‑ZoneName Contoso.local –Preference 10


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Creating Firewall Rule for Application or Program.ps1
************************************************************************
﻿#Creating Firewall Rule for Application or Program
New‑NetFirewallRule ‑Name "Skype" ‑DisplayName "Skype" ‑Direction Inbound ‑Action Allow ‑Program "C:\Program Files (x86)\Skype\Phone\Skype.exe"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Creating Firewall Rule for Port or Protocol.ps1
************************************************************************
﻿#Creating Firewall Rule for Port or Protocol
New-NetFirewallRule -Name "Block FTP" ‑DisplayName "Block FTP" ‑Direction Outbound ‑Action Block ‑Protocol TCP ‑LocalPort FTP


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Exporting DNS Server Zones.ps1
************************************************************************
﻿ForEach($Zone in (Get-DnsServerZone | Where IsAutoCreated -eq$false))
{
    Export-DnsServerZone -Name $Zone.ZoneName -FileName $Zone.ZoneName
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Installing a new Active Directory Forest.ps1
************************************************************************
﻿Install‑ADDSForest ‑DomainName contoso.local ‑SafeModeAdministratorPassword (ConvertTo‑SecureString P@ssw0rd ‑AsPlainText ‑Force) -DomainMode Win2012 ‑DomainNetbiosname Contoso ‑ForestMode Win2012 ‑InstallDNS


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Installing a new domain Controller in an existing domain.ps1
************************************************************************
﻿Install-ADDSDomainController -NoGlobalCatalog:$false ‑CreateDnsDelegation:$false -Credential (Get-Credential) -DomainName "contoso.local" -InstallDns:$true -ReplicationSourceDC "DC01.contoso.local" -SiteName "Default-First-Site-Name" -SafeModeAdministratorPassword (ConvertTo-SecureString P@ssw0rd -AsPlainText -Force)


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Installing a new domain in an existing Forest.ps1
************************************************************************
﻿Install‑ADDSDomain ‑NewDomainName corp ‑ParentDomainName contoso.local ‑SafeModeAdministratorPassword (ConvertTo‑SecureString P@ssw0rd ‑AsPlainText ‑Force) ‑CreateDnsDelegation ‑Credential (Get‑Credential Contoso\Administrator) ‑DomainMode Win2012 ‑DomainType ChildDomain


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Setting the Network Interface Card (NIC) configuration part 2.ps1
************************************************************************
﻿#Remove static IP Address Setting
Remove‑NetIPAddress ‑InterfaceAlias Ethernet

#Remove network route
Remove‑NetRoute ‑InterfaceAlias Ethernet

#Reset Client DNS Settings
Set‑DnsClientServerAddress ‑ResetServerAddresses

#Enable the DHCP option on the interface
Set‑NetIPInterface ‑InterfaceAlias Ethernet ‑Dhcp Enabled


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Setting the Network Interface Card (NIC) configuration.ps1
************************************************************************
﻿#Setting static IP Address Configuration
New‑NetIPAddress ‑IPAddress 192.168.0.2 ‑InterfaceAlias Ethernet ‑DefaultGateway 192.168.0.1 ‑AddressFamily IPv4 ‑PrefixLength 24

#Setting Client DNS Settings
Set‑DnsClientServerAddress ‑InterfaceAlias Ethernet ‑ServerAddresses 192.168.0.1,192.168.0.2


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_05_Codes\Setting up the DHCP Server Scope.ps1
************************************************************************
﻿#Adding DHCP server IPv4 scope
Add‑DhcpServerv4Scope ‑Name "Contoso" ‑StartRange 192.168.0.1 ‑EndRange 192.168.0.254 ‑SubnetMask 255.255.255.0 ‑State Active


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\AddGroupMember.ps1
************************************************************************
Add-ADGroupMember -Identity ProductAdmins -Member fuhj


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\ComputerJoinDomain.ps1
************************************************************************
Add-Computer -DomainOrWorkgroupName fuhaijun


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\ComputerJoinDomainSpecifiedOU.ps1
************************************************************************
Add-Computer -DomainOrWorkgroupName fuhaijun -OUPath OU=testOU,DC=fuhaijun,DC=com


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\ComputerJoinDomainWithDC.ps1
************************************************************************
Add-Computer Win8Client -DN fuhaijun -Server Win2012-ad


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\CreateADUser.ps1
************************************************************************
New-ADUser -SamAccountName TestUser -Name "A Test User�� -AccountPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force) -Enabled $true -Path 'OU=Test,DC=FUHAIJUN,DC=COM'


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\CreateaOU.ps1
************************************************************************
New-ADOrganizationalUnit -Name UserAccounts -Path "DC=FUHAIJUN,DC=COM"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\CreateaOUfromTemplate.ps1
************************************************************************
$ouTemplate = Get-ADOrganizationalUnit "OU=UserAccounts,DC=FUHAIJUN,DC=com" -properties seeAlso,managedBy;
New-ADOrganizationalUnit -name UserReports -instance $ouTemplate



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\CreateGroup.ps1
************************************************************************
New-ADGroup -Name "Product Admins" -SamAccountName ProductAdmins -GroupCategory Security -GroupScope Global -DisplayName "Product Administrators" -Path "CN=Users,DC=fuhaijun,DC=Com"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\DeleteOU.ps1
************************************************************************
Remove-ADOrganizationalUnit -Identity "OU=TestOU,DC=FUHAIJUN,DC=COM" -Recursive


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\FindDC.ps1
************************************************************************
Get-ADDomainController -Discover -DomainName fuhaijun.com


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\FindDCSite.ps1
************************************************************************
Get-ADDomainController -Identity Win2012-AD | FT Name,Site


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\FindGlobalCatalogServerinForest.ps1
************************************************************************
Get-ADForest Fuhaijun.com | FL GlobalCatalogs


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\ListOU.ps1
************************************************************************
Get-ADOrganizationalUnit -Filter 'Name -like "*"' | ft -AutoSize


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\MandatoryUserChangePass.ps1
************************************************************************
Set-ADUser -Identity TestUser -ChangePasswordAtNextLogon $true


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\ModifyOU.ps1
************************************************************************
Set-ADOrganizationalUnit -Identity "OU=TestOU,DC=Fuhaijun,DC=COM" -Description "This Organizational Unit is a test OU of Fuhaijun.COM"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\ModifyOUProperties.ps1
************************************************************************
$AsianSalesOU = Get-ADOrganizationalUnit "OU=Asia,OU=Sales,OU=UserAccounts,DC=Fuhaijun,DC=COM"
$AsianSalesOU.StreetAddress = "No. 20 Chang An Avenue"
$AsianSalesOU.City = "Beijing"
$AsianSalesOU.PostalCode = "100000"
$AsianSalesOU.Country = "China"
Set-ADOrganizationalUnit -Instance $AsianSalesOU



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\MoveOU.ps1
************************************************************************
Move-ADObject "OU=ManagedGroups,DC=Fuhaijun,DC=Com" -TargetPath "OU=Managed,DC=Fuhaijun,DC=Com"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\PreventChangePassword.ps1
************************************************************************
Set-ADAccountControl -Identity TestUser -CannotChangePassword $true


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\RemoveADGroup.ps1
************************************************************************
Get-ADGroup -filter 'Name -like "Product*' | Remove-ADGroup


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\RemoveOU.ps1
************************************************************************
Remove-ADOrganizationalUnit -Identity "OU=TestOU,DC=FUHAIJUN,DC=COM" -Recursive


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\RemoveOUwithGUID.ps1
************************************************************************
Remove-ADOrganizationalUnit -Identity ��d465ddc9-a5e6-4998-91aa-09e33fe22369�� -confirm:$false �C ProtectedFromDeletion $false


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\RenameComputer.ps1
************************************************************************
Rename-Computer -NewName win8client2 -DomainCredential fuhaijun\administrator �CRestart


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\RenameOU.ps1
************************************************************************
Rename-ADObject "OU=TestOU, DC=Fuhaijun,DC=Com" -NewName Groups


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\RenameOUwithGUID.ps1
************************************************************************
Rename-ADObject -Identity "d465ddc9-a5e6-4998-91aa-09e33fe22369" -NewName Groups


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\SetUserExpire.ps1
************************************************************************
Set-ADUser TestUser -AccountExpirationDate 11/27/2014


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_06Codes\ViewGroupPermission.ps1
************************************************************************
Get-ACL (Get-ADGroup UserGroup) | fl * -f


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\AddDnsServerResourceRecordA.ps1
************************************************************************
Add-DnsServerResourceRecordA -IPv4Address 192.168.10.1 -Name gateway -ZoneName fuhaijun.com


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\AddVMDvdDrive.ps1
************************************************************************
Add-VMDvdDrive -VMName MyVM -Path D:\CentOS6.3_KS1-x86_64.iso


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\AddVMHardDiskDrive.ps1
************************************************************************
Add-VMHardDiskDrive -VMName MyVM -Path D:\vm\vhd\disk1.vhdx


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\AddVMNetworkAdapter.ps1
************************************************************************
Add-VMNetworkAdapter -VMName MyVM -SwitchName MyVMSwitch


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\BackupWebConfiguration.ps1
************************************************************************
Backup-WebConfiguration -Name MyIISConfigBackup


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\CheckpointVM.ps1
************************************************************************
Checkpoint-VM -Name MyVM -SnapshotName BeforeInstall


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\DisableNetAdapter.ps1
************************************************************************
Disable-NetAdapter -Name "Ethernet 2" -Confirm:$false


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\DisableNetAdapterBinding.ps1
************************************************************************
Disable-NetAdapterBinding -Name "Ethernet 2" -ComponentID ms_lltdio


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\GeneratingRulesforGroup.ps1
************************************************************************
Get-ChildItem C:\Windows\System32\*.exe | Get-AppLockerFileInformation | New-AppLockerPolicy -RuleType Publisher,Hash -User Everyone -RuleNamePrefix System32


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\GetAppLockerFileInformation.ps1
************************************************************************
Get-AppLockerFileInformation -Directory C:\Windows\System32 -Recurse -FileType exe


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\GetAppLockerPolicy.ps1
************************************************************************
Get-AppLockerPolicy �CLocal �CXml -XMLPolicy C:\Policy.xml


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\GetDnsServerZone.ps1
************************************************************************
Get-DnsServerZone



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\GetGPO.ps1
************************************************************************
Get-GPO -All -Domain fuhaijun.com


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\GetNetIPAddress.ps1
************************************************************************
Get-NetIPAddress -InterfaceAlias Ethernet


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\GetWindowsFeature.ps1
************************************************************************
Get-WindowsFeature web-*


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\ImportModule.ps1
************************************************************************
Import-Module WebAdministration


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\InstallWindowsFeature.ps1
************************************************************************
Install-WindowsFeature Telnet-Client


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\NewGPO.ps1
************************************************************************
New-GPO -Name TestGPO -Comment "This is a GPO for test"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\NewNetIPAddress.ps1
************************************************************************
New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress  192.168.10.20 ` -AddressFamily IPv4 -PrefixLength 24


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\NewVHD.ps1
************************************************************************
New-VHD -Path D:\vm\vhd\MyVMvhd.vhdx -SizeBytes 20GB -ParentPath D:\vhd\webserver.vhdx -Differencing


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\NewVM.ps1
************************************************************************
New-VM -Name MyVM -Path D:\vm -VHDPath D:\vm\vhd\MyVMvhd.vhdx -MemoryStartupBytes 2GB


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\NewWebAppPool.ps1
************************************************************************
New-WebAppPool MyAppPool


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\NewWebFtpSite.ps1
************************************************************************
New-WebFtpSite -Name testFtpSite -Port 21 -PhysicalPath c:\test -HostHeader mySite -IPAddress 127.0.0.1


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\NewWebsite.ps1
************************************************************************
New-Website -Name testsite -Port 80 -HostHeader testsite -PhysicalPath c:\temp


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\NewWebVirtualDirectory.ps1
************************************************************************
New-WebVirtualDirectory -Site "Default Web Site" -Name TestVDir -PhysicalPath c:\inetpub\virtualdir


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\OperateWebConfiguration.ps1
************************************************************************
Backup-WebConfiguration -Name MyIISConfigBackup
Get-WebConfigurationBackup
Restore-WebConfiguration -Name MyIISConfigBackup
Remove-WebConfiguration -Name MyIISConfigBackup


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\RemoveVMSnapshot.ps1
************************************************************************
Remove-VMSnapshot �CName BeforeInstall �CVMName MyVM


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\RemoveWebConfiguration.ps1
************************************************************************
Remove-WebConfiguration -Name MyIISConfigBackup


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\RestoreWebConfiguration.ps1
************************************************************************
Restore-WebConfiguration -Name MyIISConfigBackup


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\SetAppLockerPolicy.ps1
************************************************************************
Set-AppLockerPolicy -XMLPolicy C:\Policy.xml -LDAP "LDAP://Win2012AD.fuhaijun.com/CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=fuhaijun,DC=com"


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\SetWebBinding.ps1
************************************************************************
Set-WebBinding -Name 'Default Web Site' -BindingInformation "*:80:" -PropertyName Port -Value 1234


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\TestAppLockerPolicy.ps1
************************************************************************
Test-AppLockerPolicy C:\Policy.xml -Path C:\WINDOWS\system32\mspaint.exe C:\WINDOWS\system32\taskmgr.exe -User Everyone


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_07_Code\TestDnsServer.ps1
************************************************************************
Test-DnsServer 8.8.8.8
Test-DnsServer 192.168.10.9
Test-DnsServer 192.168.10.10


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Bulk assignments of client PIN.ps1
************************************************************************
﻿#Get list of users with no PIN
$Users = Get-CsAdUser -Filter {(Enabled -eq $true)} | Get-CsClientPinInfo | Where IsPinSet -eq $false

#define the initial start for PIN value
$PINinit = 50000

#iterating of users list 
Foreach($User in $Users)
{
	#setting the user PIN info
    Set-CsClientPin -Identity $User.Identity -Pin $PINinit
	#increase the PIN by 1 each
    $PINinit++
}



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Connect to Exchange Online.ps1
************************************************************************
﻿#Create new implicit remoting session
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://ps.Outlook.com/PowerShell" -Credential (Get-Credential) -Authentication Basic -AllowRedirection

#Import the PowerShell remoting Session
Import-PSSession –Session $Session



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Connect to Office 365.ps1
************************************************************************
﻿#Import MSOnline Modules
Get-Module –ListAvailable *MSOnline* | Import-Module

#Connect to Office 365 account
Connect-MsolService -Credential (Get-Credential username@domain.onmicrosoft.com)



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Create Distribution Group MailTip.ps1
************************************************************************
﻿#Enter the Distribution Group Name/Alias
$Alias = Read-Host -Prompt "Enter the Distribution Group Name/Alias..."

#Enter the MailTip Text
$TipText = Read-Host -Prompt "Enter the MailTip Test..."

#Update the DG with the MailTip
Set-DistributionGroup -Identity $Alias -MailTip $TipText 



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Create Distribution Groups.ps1
************************************************************************
﻿#Import a file named “UsersList.CSV”, select and group the department, save it in variable called “$DepartmentsList”
$UsersInfo = Import-Csv C:\UsersList.csv
$DepartmentsList = $UsersInfo | Select Department | Group Department | Select Name

#Iterating over the $DepartmentsList to create a distribbution group for each department. 
ForEach($Department in $DepartmentsList)
{
    New-DistributionGroup -Type Distribution -Name $Department.Name -SamAccountName $Department.Name.Trim() -DisplayName $Department.Name -MemberJoinRestriction Open -OrganizationalUnit "DGs"
}

#Iterating over the $UsersInfo to add each user to the related a distribbution group according to department. 
ForEach($User in $UsersInfo)
{
    Update-DistributionGroupMember -Identity $User.Department -Members $User.Alias -Confirm:$false
}




c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Create Multiple Mailbox Databases.ps1
************************************************************************
﻿#Import a file named “UsersList.CSV”, select and group the department, save it in variable called “$DepartmentsList”
$DepartmentsList = Import-Csv C:\UsersList.csv | Select Department | Group Department | Select Name

#Iterating over the $DepartmentsList to create a database for each department, and then mount it. 
ForEach($Department in $DepartmentsList)
{
    New-MailboxDatabase -Name $Department.Name -Server "EXCH-MB-01" -EdbFilePath `
     ("c:\Mailbox\" + "$Department.Name" + "\" + $Department.Name  + ".edb") | Mount-Database 
}



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Create Multiple Mailboxes.ps1
************************************************************************
﻿#Import a file named “UsersList.CSV” and save it in variable called “$UsersList”
$UsersList = Import-Csv C:\UsersList.csv

#Prompt the user to enter the name of the OU that will store the new user accounts (e.g. IT)
$OU = Read-Host -Prompt "Enter the name of the OU..."

#Prompt the user to enter the Domain Suffix (e.g. Contoso.local) 
$Domain = Read-Host -Prompt "Enter the domain suffix..."

#Iterating over the $UsersList to create an account for each user 
ForEach($User in $UsersList)
{
    New-Mailbox -FirstName $User.Firstname `
    -LastName $User.Lastname `
    -DisplayName ($User.Firstname + " " + $User.Lastname) `
    -Name ($User.Firstname + " " + $User.Lastname) `
    -Alias $User.Alias `
    -SamAccountName $User.Alias `
    -UserPrincipalName "$User.Alias@$Domain" `
    -Password (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force ) `
    -OrganizationalUnit $OU `
    -ResetPasswordOnNextLogon $true
}



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Create Resource Mailbox.ps1
************************************************************************
﻿#Enter the name of the resource mailbox
$Mailbox = Read-Host -Prompt "Enter the name of the resource mailbox..."

#Enter the type of required resource
do{$type = Read-Host -Prompt "Enter the type of the resource (1 for Room, 2 for Equipment)"}
while(($type -ne 1) -and ($type -ne 2))

#Create resource mailbox with a selected type
if($type -eq 1)
{New-Mailbox -Name $Mailbox -Room}
elseif($type -eq 2)
{New-Mailbox -Name $Mailbox -Equipment}

#Define resource reservation
Set-CalendarProcessing -Identity $Mailbox -AutomateProcessing AutoAccept -MaximumDurationInMinutes 120 -AddOrganizerToSubject $true ` 
-EnableResponseDetails $true -ProcessExternalMeetingMessages $false 


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Create Shared Mailbox.ps1
************************************************************************
﻿#Enter the alias of Shared Mailbox to be created
$MBalias = Read-Host -Prompt "Enter Shared Mailbox name..."

#Enter the alias of Distribution Group to be access to Shared mailbox
$DGalias = Read-Host -Prompt "Enter Distribution Group name..."

#Create a new shared mailbox
New-Mailbox -Name $MBalias -Shared

#Create a new security distribution group 
New-DistributionGroup -Type Security -Name $DGalias -SamAccountName $DGalias

#Assign FullAccess rights on the shared mailbox to the distribution group
Add-MailboxPermission -Identity $MBalias -User $DGalias -AccessRights FullAccess -InheritanceType All -AutoMapping

#Assign SendAs rights to disribution groupn on the shared mailbox
Add-RecipientPermission $MBalias -Trustee $DGalias -AccessRights "SendAs" 


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Enable Lync Users.ps1
************************************************************************
﻿#Get list of users who are not enabled for lync
$Users = Get-CsAdUser -Filter { (Enabled -ne $true) -and (WindowsEmailAddress -ne $null) }

Foreach($User in $Users)
{    
    $sip = "sip:" + $User.WindowsEmailAddress
    
    #Enable users for LYNC
    Enable-CsUser -Identity $User.SamAccountName -RegistrarPool (Get-CSPool).Identity -SipAddressType EmailAddress -SipAddress $sip
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Exchange Server Remoting.ps1
************************************************************************
﻿#Create new implicit remoting session
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "http://Exch.Contoso.local/PowerShell" -Credential (Get-Credential) -Authentication Kerberos

#Import the PowerShell remoting Session
Import-PSSession –Session $Session



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Exporting mailboxes to PST files.ps1
************************************************************************
﻿#Load Exchange PowerShell Snap-in
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010

#Iterating over the mailboxes database 
ForEach ($DB in Get-MailboxDatabase)
{ 
	#check the existence of database backup folder
    if( !(Test-Path "\\EXCH\Backup\$DB") )
    {
        #Create backup folder for database if not exist
        New-Item -ItemType Directory -Name $DB.Name -Path "\\EXCH\Backup\"
    }
	
    #Iterating over the mailboxes for in each database 	
     ForEach ($Mailbox in (Get-Mailbox -Database $DB.Name) ) 
    {
		#Export each mailbox into releated database folder
        New-MailboxExportRequest -Mailbox $Mailbox.Alias -FilePath ("\\EXCH\Backup\" + $DB.Name + "\" + $Mailbox.Alias + ".pst")
    }

}




c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\Importing mailboxes from PST files.ps1
************************************************************************
﻿#Load Exchange PowerShell Snap-in
Add-PSSnapin  Microsoft.Exchange.Management.PowerShell.E2010

#Iterating over the backup file to get the list of *.pst files 
ForEach ($file in (Get-ChildItem "\\EXCH\Backup\" -Recurse -Include *.pst))
{ 
    #parse file name and remove the extension to get the user alias
    $Alias = $file.Name.Replace(".pst","")

    #Import the PST file to the user inbox
    New-MailboxImportRequest -Mailbox $Alias -FilePath $file.Name
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_08_Codes\OCS-Lync Users Report.ps1
************************************************************************
﻿#Write the number of users on OCS
Write-Host "Office Communication Server Users:" (Get-csUser -OnOfficeCommunicationServer).Count -ForegroundColor Green
#Showing the list of OCS Users
Get-csUser -OnOfficeCommunicationServer | Select DisplayName, SamAccountName, sipAddress, LineURI, EnterpriseVoiceEnabled | ft

#Write the number of users on LYNC
Write-Host "Lync Server Users:" (Get-csUser -OnLyncServer).Count -ForegroundColor Green
#Showing the list of Lync Users
Get-csUser -OnLyncServer | Select DisplayName, SamAccountName, sipAddress, LineURI, EnterpriseVoiceEnabled | ft


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_09_Code\Backup SharePoint Environment.ps1
************************************************************************
﻿$BackupFolder = "C:\SharePointBackup"

#Backup SharePoint Configuration Database
Backup-SPConfigurationDatabase -Directory $BackupFolder

#Backup SharePoint Farm
Backup-SPFarm -Directory $BackupFolder -BackupMethod Full 

#Backup SharePoint Sites
ForEach($Site in Get-SPSite)
{
    Backup-SPSite -Identity $Site.Url -Path (Join-Path $BackupFolder ($Site.Url.Remove(0,$Site.Url.LastIndexOf("/")+1) + ".bak"))
}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_09_Code\Create SharePoint Quota Template.ps1
************************************************************************
﻿#Create Object of SharePoint Quota Template
$Template = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
#Define template name
$Template.Name = "Blogs Quota Template"
#Assign Storage Maximum Level
$Template.StorageMaximumLevel = 100MB
#Assign Storage Warning Level
$Template.StorageWarningLevel = 80MB

#Create object of SharePoint Content Service
$Service = [Microsoft.SharePoint.Administration.SPWebService]::ContentService
#Add the template to the content service
$Service.QuotaTemplates.Add($Template)
#Update Content Service to create the template
$Service.Update()



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_09_Code\Generate SQL Scripts.ps1
************************************************************************
﻿$ErrorActionPreference = "SilentlyContinue"

$ServerInstance = "SharePoint\PowerPivot"
$ExportFolder = "C:\SqlScripts"

#Load SQL SMO assembly
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO')
#Create SMO object of SQL Server Instance
$Server = new-object ('Microsoft.SqlServer.Management.Smo.Server') $ServerInstance 

Write-Host "Number of Databases: " $Server.Databases.Count -ForegroundColor Yellow

#Iterate over the list of the databases under the Server Instance
ForEach($Database in $Server.Databases)
{
    #Create Folder for each Database
    New-Item -ItemType Directory -Path ("$ExportFolder\" +  $Database.Name + "\") | Out-Null
    #Create folder for tables under each database folder
    New-Item -ItemType Directory -Path ("$ExportFolder\" +  $Database.Name + "\Tables\") | Out-Null
    #Create folder for stored procedures under each database folder
    New-Item -ItemType Directory -Path ("$ExportFolder\" +  $Database.Name + "\StoredProcedures\") | Out-Null
    
    #Generate and Export Database Script
    $Database.Script() | Out-File ("$ExportFolder\" +  $Database.Name + "\" + $Database.Name + ".sql")
    
    "`r"
    Write-Host "Database: " $Database.Name -ForegroundColor Yellow
    Write-Host "Number of Tables: " $Database.Tables.Count -ForegroundColor Yellow

    #Iterate over the list of the tables under each database
    ForEach($table in $Database.Tables)
    {
        #Generate and Export Tables Scripts
        $table.Script() | Out-File ("$ExportFolder\" +  $Database.Name + "\Tables\" + $table.Name + ".sql")
    }

    Write-Host "Number of Stored Procedures: " $Database.StoredProcedures.Count -ForegroundColor Yellow

    #Iterate over the list of the stored procedures under each database
    ForEach($SP in $Database.StoredProcedures)
    {
        #Generate and Export Stored Procedures Scripts
        $SP.Script() | Out-File ("$ExportFolder\" +  $Database.Name + "\StoredProcedures\" + $SP.Name + ".sql")
    }

}




c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_09_Code\Get Server Instance and Databases Properties.ps1
************************************************************************
﻿#Server Instance name
$ServerInstance = "SharePoint\PowerPivot"

#Load SQL SMO assembly
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO')
#Create SMO object of SQL Server Instance
$Server = new-object ('Microsoft.SqlServer.Management.Smo.Server') $ServerInstance 

Write-Host "$ServerInstance Server Instance Properties" -ForegroundColor Red 
Write-Host "=============================================== `r" -ForegroundColor DarkRed

#Get the Server Instance Properties 
$Server.Properties | Select Name, Value 

Write-Host "====================================" -ForegroundColor Red

#Iterate over the list of the databases under the Server Instance
ForEach($Database in $Server.Databases)
{
    Write-Host $Database.Name " Database Properties" -ForegroundColor Green 
    Write-Host "===============================================" -ForegroundColor DarkGreen
    
    #Get the Database Properties
    $Database.Properties | Select Name, Value
    Write-Host "===============================================" -ForegroundColor DarkGreen
    "`r"
} 


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Adding and Configuring RD Gateway.ps1
************************************************************************
﻿$RDCB = 'RDCB-01.Contoso.local'
$RDG = 'RDG01.contoso.local'

#Adding RD Gateway Server
Add-RDServer -Server $RDG -ConnectionBroker $RDCB -Role RDS-GATEWAY -GatewayExternalFqdn RDG.Contoso.com

#Configuring RD Gateway
Set-RDDeploymentGatewayConfiguration -ConnectionBroker $RDCB -BypassLocal $true -LogonMethod AllowUserToSelectDuringConnection -GatewayMode Custom -UseCachedCredentials $true -GatewayExternalFqdn RDG.Contoso.com



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Adding and Configuring RD Licensing Server.ps1
************************************************************************
﻿$RDCB = 'RDCB-01.Contoso.local'
$RDL = 'RDL01.contoso.local'

#Adding RD Licensing Server
Add-RDServer -Server $RDL -Role RDS-LICENSING -ConnectionBroker $RDCB

#Configuring RD Licensing
Set-RDLicenseConfiguration -Mode PerUser -LicenseServer $RDL -ConnectionBroker $RDCB



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Adding Remote Desktop Server to existing deployment.ps1
************************************************************************
﻿$RDCB = 'RDCB-01.Contoso.local'

#Adding Virtualization Host to Session-based deployment
#-CreateVirtualSwitch can be user only with Role RDS-Virtualization
Add-RDServer -Server 'RDVH-01.Contoso.local' -ConnectionBroker $RDCB -Role RDS-Virtualization -CreateVirtualSwitch $true

#Adding Session Host to VM-based deployment
Add-RDServer -Server 'RDSH-01.Contoso.local' -ConnectionBroker $RDCB -Role RDS-RD-Server


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Assigning Profile Disks to Collections.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RCCB-01.Contoso.local'

#Enable and Assign Profile Disk to Session-based Collection
Set-RDSessionCollectionConfiguration -CollectionName “mySessions” -EnableUserProfileDisk -DiskPath '\\FileServer-01\ProfileDisks' -MaxUserProfileDiskSizeGB 20 -IncludeFolderPath 'C:\myReports'  -ConnectionBroker $RDCB


#Enable and Assign Profile Disk to VM-based Collection
Set-RDVirtualDesktopCollectionConfiguration -CollectionName “Win 7 SP1” -EnableUserProfileDisk -DiskPath '\\FileServer-01\ProfileDisks' -MaxUserProfileDiskSizeGB 20 -ExcludeFolderPath 'C:\Users\Sherif\Desktop\myVideos' -ConnectionBroker $RDCB



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Configuring Remote Desktop Connection Broker High-Availability.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RDCB-01.Contoso.local'

#SQL Server Instance
$SQLinstance 'SQL-01.Contoso.local'

#RD Connection Broker Database name
$RDCBDB = 'RDCB'

$ConStr = "DRIVER=SQL Server Native Client 10.0;SERVER=$SQLinstance;Trusted_Connection=Yes;APP=Remote Desktop Services Connection Broker;Database=$RDCBDB"

#Configuring RDCB HA settings
Set-RDConnectionBrokerHighAvailability -ConnectionBroker $RDCB -DatabaseConnectionString $ConStr -ClientAccessName RDCB.Contoso.Local -DatabaseFilePath ("C:\$RDCBDB" + '.mdf')

#Adding the second RDCB the HA Array
Add-RDServer -ConnectionBroker $RDCB -Server RDSH-02.Contoso.local -Role RDS-CONNECTION-BROKER


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Creating new Session-based Collection.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RDCB-01.Contoso.local'

#Remote Desktop Session Host(s)
$RDSH = @('RDSH-01.Contoso.local','RDSH-02.Contoso.local')

#Creating new Session-based Collection
New-RDSessionCollection -CollectionName "mySessions" -CollectionDescription "Remote Desktop Services - Session Virtualization Collection" -ConnectionBroker $RDCB -SessionHost $RDSH 


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Creating new Session-based deployment.ps1
************************************************************************
﻿#Remote Desktop Session Host
$RDSH  = 'RDSH-01.Contoso.local'

#Remote Desktop Connection Broker
$RDCB  = 'RDCB-01.Contoso.local'

#Remote Desktop Web Access
$RDWeb = 'RDWeb-01.Contoso.local'

#Creating new Session-based deployment
New-SessionDeployment -SessionHost $RDSH -ConnectionBroker $RDCB -WebAccessServer $RDWeb


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Creating new Virtual Machine-based deployment.ps1
************************************************************************
﻿#Remote Desktop Virtualization Host
$RDVH  = 'RDVH-01.Contoso.local'

#Remote Desktop Connection Broker
$RDCB  = 'RDCB-01.Contoso.local'

#Remote Desktop Web Access
$RDWeb = 'RDWeb-01.Contoso.local'

#Creating new Virtual Machine-based deployment
New-RDVirtualDesktopDeployment -ConnectionBroker $RDCB -WebAccessServer $RDWeb -VirtualizationHost $RDVH -CreateVirtualSwitch


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Creating new VM-based Collection - Managed Pool.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RDCB-01.Contoso.local'

#Virtual Server hosting the Virtual Desktop Template
$RDtemplateHost = 'RDVH-01.Contoso.local'

#Domain name
$DomainName = 'Contoso.local'

#AD OU  will contain the VDI computer accounts
$OU = 'VDI'

#Grant RDS a permission on the selected OU to create/remove computer accounts for Virtual Desktops
Grant-RDOUAccess -Domain $DomainName -OU $OU -ConnectionBroker $RDCB

#Creating new VM-based Collection
New-VirtualDesktopCollection -CollectionName 'Win 7 SP1' -Description 'RDS - Virtual Desktop Collection' -PooledManaged -UserGroups "Contoso\Domain Users" `
-Domain "Contoso.local" -VirtualDesktopTemplateHostServer $RDtemplateHost -VirtualDesktopTemplateName 'Win7SP1-Temp' -ConnectionBroker $RDCB -OU $OU `
-VirtualDesktopNamePrefix "VD-W7-" -VirtualDesktopTemplateStoragePath "C:\VDs" -StorageType LocalStorage -VirtualDesktopAllocation @{"RDVH-01.Contoso.local"=5;"RDVH-02.Contoso.local"=5}


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Creating new VM-based Collection - Unmanaged Personal.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RDCB-01.Contoso.local'

#Remote Desktop Virtualization Host(s)
$RDSH = @('RDSH-01.Contoso.local','RDSH-02.Contoso.local')

#Domain name
$DomainName = 'Contoso.local'

#AD OU  will contain the VDI computer accounts
$OU = 'VDI'

#Grant RDS a permission on the selected OU to create/remove computer accounts for Virtual Desktops
Grant-RDOUAccess -Domain $DomainName -OU $OU -ConnectionBroker $RDCB

#Creating new VM-based Collection
New-RDVirtualDesktopCollection -CollectionName 'Win 7 SP1' -Description 'RDS - Virtual Desktop Collection' -PersonalUnmanaged -UserGroups "Contoso\Domain Admins" `
-ConnectionBroker $RDCB -VirtualDesktopName "XYZ" -AutoAssignPersonalVirtualDesktopToUser $false -GrantAdministrativePrivilege $true 

#Assign Virtual Desktop to a User
Set-RDPersonalVirtualDesktopAssignment -CollectionName 'Win 7 SP1' -User 'Contoso\Sherif' -VirtualDesktopName 'XYZ' -ConnectionBroker $RDCB 


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Creating new VM-based Collection.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RDCB-01.Contoso.local'

#Remote Desktop Virtualization Host(s)
$RDSH = @('RDSH-01.Contoso.local','RDSH-02.Contoso.local')


Grant-RDOUAccess -Domain CoEx.local -OU VDI -ConnectionBroker RDSH.CoEx.local

Test-RDOUAccess -Domain CoEx.local -OU VDI -ConnectionBroker RDSH.CoEx.local

#Creating new VM-based Collection

New-VirtualDesktopCollection -CollectionName 'Win 7 SP1' -Description 'Remote Desktop Services - Virtual Desktop Collection' -PooledManaged -UserGroups "CoEx\Domain Users" `
-Domain "CoEx.local" -VirtualDesktopTemplateHostServer RDVH.CoEx.local -VirtualDesktopTemplateName 'Win7SP1-Temp' -ConnectionBroker 'RDSH.CoEx.local' -OU VDI `
-VirtualDesktopNamePrefix "VD-W7-" -VirtualDesktopTemplateStoragePath "C:\VDs" -StorageType LocalStorage -VirtualDesktopAllocation @{"RDVH.CoEx.local"=1}

New-VirtualDesktopCollection -CollectionName 'Win 7 SP1' -Description 'Remote Desktop Services - Virtual Desktop Collection' -PersonalManaged -UserGroups "CoEx\Domain Users" `
-Domain "CoEx.local" -OU VDI -ConnectionBroker RDSH.CoEx.local -StorageType LocalStorage -AutoAssignPersonalVirtualDesktopToUser $true -GrantAdministrativePrivilege $true 1
-VirtualDesktopTemplateHostServer RDVH.CoEx.local -VirtualDesktopTemplateName 'Win7SP1-Temp' 

New-RDVirtualDesktopCollection -CollectionName 'Win 7 SP1' -Description 'Remote Desktop Services - Virtual Desktop Collection' -PooledUnmanaged -UserGroups "CoEx\Domain Users" `
-ConnectionBroker "RDSH.CoEx.local" -VirtualDesktopName "xyz" 

New-RDVirtualDesktopCollection -CollectionName 'Win 7 SP1' -Description 'Remote Desktop Services - Virtual Desktop Collection' -PersonalUnmanaged -UserGroups "CoEx\Domain Users" `
-ConnectionBroker "RDSH.CoEx.local" -VirtualDesktopName "xyz" -AutoAssignPersonalVirtualDesktopToUser $false -GrantAdministrativePrivilege $true 



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Publish Remote Desktop RemoteApp to Collection.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RDCB-01.Contoso.local'

#Publish Remote Desktop RemoteApp to Collection
New-RDRemoteApp -CollectionName "mySessions" -ShowInWebAccess $true -UserGroups "Contoso\CallCenter Users" -ConnectionBroker $RDCB  -DisplayName Skype -FilePath "C:\Program Files (x86)\Skype\Phone\Skype.exe" 


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Setting Session-based Collection Configuration.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RDCB-01.Contoso.local'

#Setting Session-based Collection Configuration
Set-RDSessionCollectionConfiguration -CollectionName mySessions -UserGroup "Contoso\Domain Users" -ClientDeviceRedirectionOptions Drive -ClientPrinterRedirected $true `
-BrokenConnectionAction Disconnect -AutomaticReconnectionEnabled $true -MaxRedirectedMonitors 4 -IdleSessionLimitMin 60 -TemporaryFoldersPerSession $true `
-MaxRedirectedMonitors 4 -ConnectionBroker $RDCB



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Setting VM-based Collection Configuration.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RDCB-01.Contoso.local'

#Setting VM-based Collection Configuration
Set-RDVirtualDesktopCollectionConfiguration "Call-Center Pool" -UserGroups "Contoso\CallCenter Users" -RedirectAllMonitors $false -ClientDeviceRedirectionOptions AudioVideoPlayBack,PlugAndPlayDevice -GrantAdministrativePrivilege $true -AutoAssignPersonalVirtualDesktopToUser $false -ConnectionBroker $RDCB 


c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_10_Code\Updating VM-based Collection.ps1
************************************************************************
﻿#Remote Desktop Connection Broker
$RDCB = 'RDCB-01.Contoso.local'

#Virual Desktop Template Host Server
$VDtemplateHost = 'RDVH-01.Contoso.local'

#Virtual Desktop Template
$VDtemplate = 'Win 7 SP1 Jan 2013 Update'

#Updating VM-based Collection
Update-RDVirtualDesktopCollection -CollectionName "Win 7 SP1" -ConnectionBroker $RDCB -VirtualDesktopTemplateHostServer $VDtemplateHost -VirtualDesktopTemplateName $VDtemplate `
-DisableVirtualDesktopRollback $false -StartTime (Get-Date) -ForceLogoffTime (Get-Date).AddHours(8)



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\1- Create New Azure Affinity Group.ps1
************************************************************************
﻿#Create New Azure Affinity Group
New-AzureAffinityGroup –Name “ContosoAffinityGroup” –Location “West US”



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\10- Provision new Windows Azure VM (Advanced Mode).ps1
************************************************************************
﻿#Create Azure VM configuration
$VM = New-AzureVMConfig -Name myWeb01 -InstanceSize Medium -ImageName "a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-Datacenter-201212.01-en.us-30GB.vhd" | Add-AzureProvisioningConfig -Windows –Password "P@ssw0rd" –WindowsDomain –Domain “Contoso” –JoinDomain “Contoso.com” –DomainUserName “Administrator” –DomainPassword “P@ssw0rd” –MachineObjectOU “OU=Azure,DC=Contoso,DC=com” –DisableAutomaticUpdates –ResetPasswordOnFirstLogon –TimeZone “Pacific Standard Time”

#Create Azure VM using the previously created VM
New-AzureVM -ServiceName “ContosoWeb” -VMs $VM



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\11- Add new EndPoint to Windows Azure VM (NoLB).ps1
************************************************************************
﻿#Add NoLB EndPoint to Windows Azure virtual machine
Get-AzureVM -ServiceName “CorpWebsite” -Name “WebSrv01” | Add-AzureEndpoint -Name "HTTPs" -Protocol tcp -LocalPort 443 -PublicPort 443 | Update-AzureVM



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\12- Configure Windows Azure Virtual Machines Load Balancing.ps1
************************************************************************
﻿#Add Load-Balanced EndPoint to Windows Azure virtual machine
Get-AzureVM -ServiceName CorpWebsite  | Add-AzureEndpoint -Name "LB-Http" -Protocol tcp -PublicPort 80 -LocalPort 80 -LBSetName "LB-WebFarm" -ProbePort 80 -ProbeProtocol "http" -ProbePath "/" | Update-AzureVM



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\13- Create and Assign a Data Disk to Windows Azure Virtual Machine.ps1
************************************************************************
﻿#Create and Assign a new data disk to Windows Azure VM
Get-AzureVM -ServiceName “myWebFarm” -Name WebSrv01 | Add-AzureDataDisk -CreateNew -DiskSizeInGB 30 –DiskLabel "UserDataDisk" -LUN 0 | Update-AzureVM



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\14- Move Local VHD to Windows Azure.ps1
************************************************************************
﻿#Get the Azure Storage Account for the default Azure Subscription
$StorageAccountName = (Get-AzureSubscription).CurrentStorageAccount

#Define DiskName
$DiskName = "AppVServerDisk"

#Define Local VHD file path
$LocalVHD = 'D:\Hyper-V\Virtual Hard Disks\AppVServer.vhd'

#Define the URI for the Windows Azure Container
$Destination = 'http://' + $StorageAccountName + '.blob.core.windows.net/vhds/AppVServerDisk.vhd' 

#Move VHD file from local server to Windows Azure Storage
Add-AzureVhd -LocalFilePath $LocalVHD -Destination $Destination

#Convert the VHD file to Windows Azure Disk
Add-AzureDisk -OS Windows -DiskName $DiskName -MediaLocation $Destination



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\15- Provision new Windows Azure Virtual Machine from a Disk.ps1
************************************************************************
﻿#Create Azure VM Configuration object
$VM = New-AzureVMConfig -Name AppVServer -InstanceSize Medium -DiskName "AppVServerDisk" 

#Create new VM from Azure VM Configuration
New-AzureVM -ServiceName “ContosoWeb” -VMs $VM



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\16- Create Windows Azure Image from Virtual Machine.ps1
************************************************************************
﻿#Create Azure VM Image
Save-AzureVMImage -ServiceName "CorpWebsite" -Name "myWeb01" -NewImageName "Corp Website Core Image, Update Jan 2013"



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\17- Export and Import Windows Azure Virtual Machine.ps1
************************************************************************
﻿#Export Azure VM configuration
Export-AzureVM -ServiceName CorpWebsite -Name myWeb01 -Path $home\desktop\myWeb01.xml

#Remove Azure VM
Remove-AzureVM -ServiceName CorpWebsite -Name myWeb01

#Import Azure VM configuration file, and create new VM using the import file
Import-AzureVM -Path $home\desktop\myWeb01.xml | New-AzureVM -ServiceName CorpPortal



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\18- Start, Stop, Restart Windows Azure Virtual Machine.ps1
************************************************************************
﻿#Start Azure VM 
Start-AzureVM -ServiceName CorpWebsite -Name myWeb01 

#Restart Azure VM
Restart-AzureVM -ServiceName CorpWebsite -Name myWeb01

#Shutdown Azure VM 
Stop-AzureVM -ServiceName CorpWebsite -Name myWeb01



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\19- Upload Certificate to Windows Azure.ps1
************************************************************************
﻿#Upload certificate to Windows Azure service
Add-AzureCertificate -ServiceName “myDevEnv” –CertToDeploy <myCertificate.pfx> -Password abc123



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\2- Create New Azure Storage Account.ps1
************************************************************************
﻿#Create New Azure Storage Account
New-AzureStorageAccount -StorageAccountName "contoso" -AffinityGroup “ContosoAffinityGroup”



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\20- Generate Azure Virtual Machine RDP File.ps1
************************************************************************
﻿#Generate Remote Desktop File for Windows Azure VM
Get-AzureRemoteDesktopFile -ServiceName “myDevEnv” –Name “DevTools” -LocalPath $home\Desktop\DevTools.rdp –Launch



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\3- Assign Azure storage account to a specific azure subscription.ps1
************************************************************************
﻿#Assign Azure storage account to a specific azure subscription
Set-AzureSubscription -SubscriptionName "Windows Azure MSDN - Visual Studio Ultimate" -CurrentStorageAccount “Contoso”



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\4- Create new Azure Cloud Service.ps1
************************************************************************
﻿#Create new Azure Cloud Service
New-AzureService -ServiceName "myCloudService" -AffinityGroup “ContosoAffinityGroup”



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\5- Create new SQL Azure Database Server instance.ps1
************************************************************************
﻿#Create new SQL Azure Database Server instance
New-AzureSqlDatabaseServer -AdministratorLogin "SherifT" -AdministratorLoginPassword "P@ssw0rd" -Location "West US"



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\6- Create new SQL Azure Database.ps1
************************************************************************
﻿#Create Sql Azure Database Server Context
$context = New-AzureSqlDatabaseServerContext -ServerName <server_Name>

#Create new Sql Azure Database
New-AzureSqlDatabase –Context $context -DatabaseName "myDatabase" –Collation SQL_Latin1_General_CP1_CI_AS -Edition "Web" -MaxSizeGB 1



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\7- Create SQL Azure Database Server Firewall Rule.ps1
************************************************************************
﻿#Create SQL Azure Database Server Firewall Rule
New-AzureSqlDatabaseServerFirewallRule –ServerName <Server_Name> -RuleName "myIntranet" -StartIpAddress 192.168.1.1 -EndIpAddress 192.168.1.254



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\8- Provision new Azure VM - Windows (Quick Mode) .ps1
************************************************************************
﻿#Create new Windows Azure VM – Windows using Quick Mode
New-AzureQuickVM –Windows -ServiceName "DatabaseService" -Name "CAI-DC-03" -ImageName "MSFT__Windows-Server-2012-Datacenter-201210.01-en.us-30GB.vhd" -Password P@ssw0rd -AffinityGroup "ContosoAffinityGroup" -AffinityGroup "CoontosoAffinityGroup"



c:\users\rocky\desktop\powershell books examples\powershell 3.0 advanced administration handbook\6426EN_11_Codes\9- Provision new Azure VM - Linux (Quick Mode).ps1
************************************************************************
﻿#Create new Windows Azure VM – Linux using Quick Mode
New-AzureQuickVM -Linux –ServiceName “myLinuxEnv” -Name "SUSE-02" –ImageName "b4590d9e3ed742e4a1d46e5424aa335e__SUSE-Linux-Enterprise-Server-11-SP2-New" -LinuxUser "root"  -Password P@ssw0rd -AffinityGroup "CoontosoAffinityGroup"


