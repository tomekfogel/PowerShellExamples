
c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 06\datefolder.ps1
************************************************************************
﻿cd (new-item -ItemType Directory -Path c:\temp\$(get-date -format yyyyMMdd) )



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 06\ForEach.ps1
************************************************************************
﻿ForEach($file in (dir c:\temp -file)){
    write-output $file.Extension
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 06\IfElse.ps1
************************************************************************
﻿Param($number)
if($number -eq 5){
    write-Output 'You guessed the magic number'
} else 
{
  write-output 'You did not guess it, you lose'
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 06\IfElseIf.ps1
************************************************************************
﻿$weekDay=Get-Date | select-Object -ExpandProperty DayOfWeek
if($weekDay -eq 'Saturday'){
    write-host '2 days of weekend left'
} elseif ($weekday -eq 'Sunday'){
    write-host '1 day of weekend left'
} else {
    write-host 'Have to go to work today!'
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 06\IfStatement.ps1
************************************************************************
﻿Param($number)
if($number -eq 5){
    write-Output 'You guessed the magic number'
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 06\mdAndGo.ps1
************************************************************************
﻿Param($path)
new-item -ItemType Directory -Name $path
cd $path


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 06\SetName.ps1
************************************************************************
﻿$name='Mike'
write-host "Your name is $name"


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 07\get-average.ps1
************************************************************************
﻿function get-average{
param([int]$a,[int]$b)
   return ($a+$b)/2
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 07\GetGreetingFunction.ps1
************************************************************************
﻿function get-greeting{
Param($subject='World')
   write-host "Hello $subject"
} 


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 07\MdAndGo.ps1
************************************************************************
﻿function MdAndGo{
    Param($path)
    new-item -ItemType Directory -path $path
    cd $path
}



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 07\MdAndGo_2.ps1
************************************************************************
﻿<#
.Synopsis
   Creates a folder and sets the location to it
.DESCRIPTION
   This function takes the path of a folder to create as a parameter,
   creates it and then sets the location to the new folder.
.EXAMPLE
   Set-NewFolderLocation c:\temp\test1
.EXAMPLE
   Set-NewFolderLocation E:\example2
.INPUTS
   Does not accept pipeline input
.OUTPUTS
   Outputs the folder that was created
#>
function Set-NewFolderLocation{
    Param($path)
    new-item -ItemType Directory -path $path
    cd $path
}



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 07\MultipleOutput.ps1
************************************************************************
﻿function get-twovalues{
100
"Hello World"
}
function get-four{
100
"Hello world"
(get-date)
dir c:\temp | select-object -first 1 -Property FullName
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 07\OutputFunctions.ps1
************************************************************************
﻿function test-output1{
return 100
}

function test-output2{
100
return
}

function test-output3{
100
}

function test-output4{
Write-Output 100
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 07\testPathsFunction.ps1
************************************************************************
﻿function test-paths{
Param([string]$path1,[string]$path2)

    return (test-path $path1) -and (test-path $path2)
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 07\TestSwichFunction.ps1
************************************************************************
﻿function test-switch{
param([switch]$MySwitch)
    if ($MySwitch){
        write-host 'You used the switch'
    } else {
        write-host 'You didn''t use the switch'
    }
 }


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 08\AreaFunctions.ps1
************************************************************************
﻿function Get-Pi{
  return [Math]::PI
}

function Get-SquareArea{
param([float]$side)
  return $side*$side
}

function Get-CircleArea{
param([float]$radius)
  return $pi*$radius*$radius
}

$pi=get-Pi


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 09\ExportCSVExample.ps1
************************************************************************
﻿dir c:\temp | select-object -Property Name,Length |
   Export-csv C:\temp\FileList.csv


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 09\GetContentExample.ps1
************************************************************************
﻿$servers=get-content servers.txt
foreach($server in $servers){
    get-service -Name MSSQLSERVER -ComputerName $server
}



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 1\Chapter 11\Code\GetWebAppPool.ps1
************************************************************************
﻿function Get-WebAppPool{
param([string]$name)
    if($name){
        dir IIS:\AppPools | where Name -like $name
    } else {
        dir IIS:\AppPools
    }
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 01\Code1.ps1
************************************************************************
﻿#Windows PowerShell Script to Retrieve Windows Services

Write-Host "Hello, World!" -ForegroundColor Green


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 01\Code2.PS1
************************************************************************
﻿
$UserName = (Get-Item  env:\username).Value 
$ComputerName = (Get-Item env:\Computername).Value
$filepath = (Get-ChildItem env:\userprofile).value


Add-Content  "$Filepath\style.CSS"  -Value " body {
font-family:Calibri;
 font-size:10pt;
}
th { 
background-color:black;

color:white;
}
td {
 background-color:#19fff0;
color:black;
}"

Write-Host "CSS File Created Successfully... Executing Inventory Report!!! Please Wait !!!" -ForegroundColor Yellow 
#ReportDate
$ReportDate = Get-Date | Select -Property DateTime |ConvertTo-Html -Fragment

#General Information
$ComputerSystem = Get-WmiObject -Class Win32_ComputerSystem | 
Select -Property Model , Manufacturer , Description , PrimaryOwnerName , SystemType |ConvertTo-Html -Fragment

#Boot Configuration
$BootConfiguration = Get-WmiObject -Class Win32_BootConfiguration |
Select -Property Name , ConfigurationPath | ConvertTo-Html -Fragment 

#BIOS Information
$BIOS = Get-WmiObject -Class Win32_BIOS | Select -Property PSComputerName , Manufacturer , Version | ConvertTo-Html -Fragment

#Operating System Information
$OS = Get-WmiObject -Class Win32_OperatingSystem | Select -Property Caption , CSDVersion , OSArchitecture , OSLanguage | ConvertTo-Html -Fragment

#Time Zone Information
$TimeZone = Get-WmiObject -Class Win32_TimeZone | Select Caption , StandardName |
ConvertTo-Html -Fragment

#Logical Disk Information
$Disk = Get-WmiObject -Class Win32_LogicalDisk -Filter DriveType=3 | 
Select SystemName , DeviceID , @{Name=”size(GB)”;Expression={“{0:N1}” -f($_.size/1gb)}}, @{Name=”freespace(GB)”;Expression={“{0:N1}” -f($_.freespace/1gb)}} |
ConvertTo-Html -Fragment

#CPU Information
$SystemProcessor = Get-WmiObject -Class Win32_Processor  | 
Select SystemName , Name , MaxClockSpeed , Manufacturer , status |ConvertTo-Html -Fragment

#Memory Information
$PhysicalMemory = Get-WmiObject -Class Win32_PhysicalMemory |
Select -Property Tag , SerialNumber , PartNumber , Manufacturer , DeviceLocator , @{Name="Capacity(GB)";Expression={"{0:N1}" -f ($_.Capacity/1GB)}} | ConvertTo-Html -Fragment

#Software Inventory
$Software = Get-WmiObject -Class Win32_Product |
Select Name , Vendor , Version , Caption | ConvertTo-Html -Fragment 

ConvertTo-Html -Body "<font color = blue><H4><B>Report Executed On</B></H4></font>$ReportDate
<font color = blue><H4><B>General Information</B></H4></font>$ComputerSystem
<font color = blue><H4><B>Boot Configuration</B></H4></font>$BootConfiguration
<font color = blue><H4><B>BIOS Information</B></H4></font>$BIOS
<font color = blue><H4><B>Operating System Information</B></H4></font>$OS
<font color = blue><H4><B>Time Zone Information</B></H4></font>$TimeZone
<font color = blue><H4><B>Disk Information</B></H4></font>$Disk
<font color = blue><H4><B>Processor Information</B></H4></font>$SystemProcessor
<font color = blue><H4><B>Memory Information</B></H4></font>$PhysicalMemory
<font color = blue><H4><B>Software Inventory</B></H4></font>$Software" -CssUri  "$filepath\style.CSS" -Title "Server Inventory" | Out-File "$FilePath\$ComputerName.html"

Write-Host "Script Execution Completed" -ForegroundColor Yellow
Invoke-Item -Path "$FilePath\$ComputerName.html"


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 01\Code3.ps1
************************************************************************
﻿<#
.Synopsis
   To add two integer values
.DESCRIPTION
   Windows PowerShell Script Demo to add two values
   This accepts pipeline values
.EXAMPLE
   Add-Values -Param1 20 -Param2 30
.EXAMPLE
   12,23 | Add-Values
#> 

function Add-Values
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        #Accepts Only Integer
        [int]$Param1,

        #Accepts only interger
        [Parameter(Mandatory=$true,
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [int]$Param2
    )

    Begin
    {
        "Script Begins"
    }
    Process
    {
        $result = $Param1 + $Param2
    }
    End
    {
        $result
    }
}



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 01\Code4.ps1
************************************************************************
﻿Function Get-SystemInformation
{
    [CmdletBinding()]
    PARAM (
        [Parameter(ValueFromPipeline = $true)]
        [Alias("Host")]
        [ValidateCount(0,15)]
        $ComputerName
    )

    BEGIN
    {
    
    }
    PROCESS
    {
        Write-Verbose -Message "Working On $ComputerName"  
        $ComputerSystem = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName
        $OperatingSystem = Get-WmiObject -class win32_OperatingSystem -ComputerName $ComputerName
        $Bios = Get-WmiObject -class win32_BIOS -ComputerName $ComputerName
        Write-Verbose -Message "Result $ComputerName..."
        $Properties = [Ordered]@{
            ComputerName = $ComputerName
            Manufacturer = $ComputerSystem.Manufacturer
            Model = $ComputerSystem.Model
            OperatingSystem = $OperatingSystem.Caption
            OperatingSystemVersion = $OperatingSystem.Version
            SerialNumber = $Bios.SerialNumber
        }          
        New-Object -TypeName PSobject -Property $Properties
    }
    
    END
    {
    
    } 
}

#Using Alias
Get-SystemInformation -host localhost -Verbose

#Using Param Name with Verbose
Get-SystemInformation -ComputerName localhost -Verbose



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 02\B04702_02_01.ps1
************************************************************************
﻿Function Get-SystemInformation
{
    param(
    [Parameter(Mandatory = $true)]
    [String]
    $ComputerName
    )

    $OS = Get-WmiObject -Class Win32_OperatingSystem
    $BIOS = Get-WmiObject -Class Win32_Bios
    $CS = Get-WmiObject -Class Win32_ComputerSystem

    $Properties = New-Object psobject -Property @{
    
    "OSName" = $OS.Caption
    "ServicePack" = $OS.CSDVersion
    "SerialNumber" = $BIOS.SerialNumber
    "Manufacturer" = $BIOS.Manufacturer
    "BootUpState" = $CS.BootupState

    }

    $Properties
}
Get-SystemInformation -ComputerName localhost


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 02\B04702_02_02.ps1
************************************************************************
﻿$hash = @{
ServiceName = (Get-Service -Name Bits).Name
Status = (Get-Service -Name Bits).Status
CanStop = (Get-Service -Name Bits).CanStop
CanPauseandContinue = (Get-Service -Name Bits).CanPauseAndContinue
}

$value = New-Object PSOBject -Property $hash
($value | Convertto-xml -NoTypeInformation).save("C:\Temp\Data.xml")

[xml]$xml = Get-Content C:\Temp\Data.xml
$xml.Objects.Object.Property


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 02\B04702_02_03.ps1
************************************************************************
﻿$FileName = $Env:USERNAME 
$savepath="C:\$FileName.docx" 
 
 
$word = New-object -ComObject "Word.Application" 
$doc=$word.documents.Add() 
$Resume=$word.Selection 
 
 
$Resume.Style="Title" 
$UserName = Get-ADUser -Identity $ENV:USERNAME -Properties * 
$Picture = Get-ADUser -Identity $ENV:USERNAME -Properties thumbnailphoto 
 
$Picture.thumbnailphoto | Set-Content "C:\Photo.jpg" -Encoding Byte 
$Resume.TypeText("$($UserName.Name)") 
$Resume.InlineShapes.AddPicture("C:\Photo.jpg") 
 
$Resume.TypeParagraph() 
$Resume.Style="Normal" 
$Resume.TypeText("Department: $($UserName.Department), Office Phone: $($UserName.OfficePhone), Email: $($UserName.mail)") 
 
 
$Resume.TypeParagraph() 
$Resume.Style="SubTitle" 
$Resume.TypeText(("Objective")) 
 
$Resume.TypeParagraph() 
$Resume.Style="SubTitle" 
$Resume.TypeText(("Skills")) 
 
$Resume.TypeParagraph() 
$Resume.Style="SubTitle" 
$Resume.TypeText(("Education")) 
 
$Resume.TypeParagraph() 
$Resume.Style="SubTitle" 
$Resume.TypeText(("Projects")) 
 
$Resume.TypeParagraph() 
$Resume.TypeParagraph() 
$Resume.TypeParagraph() 
$Resume.Style="SubTitle" 
$Resume.TypeText(("I hereby declare that the above written particulars are true to the best of my knowledge and belief.")) 
$Resume.TypeParagraph() 
$Resume.TypeParagraph() 
$Resume.TypeParagraph() 
$Resume.Style="Strong" 
$Resume.TypeText("Name    :    $($UserName.Name)") 
$Resume.TypeParagraph() 
$Date = Get-Date  
$Resume.TypeText("Date    :    $($Date)") 
 
$doc.SaveAs([ref]$savepath)     
$doc.Close() 
     
$word.quit() 
Invoke-Item $savepath


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 02\B04702_02_04.ps1
************************************************************************
﻿Function Get-Information
{
    (Get-Service).Where({$_.Status -eq 'Stopped'})
}
Get-Information


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 02\B04702_02_05.ps1
************************************************************************
﻿<# 
    .SYNOPSIS 
        Windows Machine Inventory Using PowerShell. 
 
    .DESCRIPTION 
        This script is to document the Windows machine. This script will work only for Local Machine. 
 
    .EXAMPLE 
        PS C:\> .\System_Inventory.PS1 
 
    .OUTPUTS 
        HTML File OutPut ReportDate , General Information , BIOS Information etc. 
 
#> 
 
 
$UserName = (Get-Item  env:\username).Value  
$ComputerName = (Get-Item env:\Computername).Value 
$filepath = (Get-ChildItem env:\userprofile).value 
 
 
Add-Content  "$Filepath\style.CSS"  -Value " body { 
font-family:Calibri; 
 font-size:10pt; 
} 
th {  
background-color:black; 
 
color:white; 
} 
td { 
 background-color:#19fff0; 
color:black; 
}" 
 
Write-Host "CSS File Created Successfully... Executing Inventory Report!!! Please Wait !!!" -ForegroundColor Yellow  
#ReportDate 
$ReportDate = Get-Date | Select -Property DateTime |ConvertTo-Html -Fragment 
 
#General Information 
$ComputerSystem = Get-WmiObject -Class Win32_ComputerSystem |  
Select -Property Model , Manufacturer , Description , PrimaryOwnerName , SystemType |ConvertTo-Html -Fragment 
 
#Boot Configuration 
$BootConfiguration = Get-WmiObject -Class Win32_BootConfiguration | 
Select -Property Name , ConfigurationPath | ConvertTo-Html -Fragment  
 
#BIOS Information 
$BIOS = Get-WmiObject -Class Win32_BIOS | Select -Property PSComputerName , Manufacturer , Version | ConvertTo-Html -Fragment 
 
#Operating System Information 
$OS = Get-WmiObject -Class Win32_OperatingSystem | Select -Property Caption , CSDVersion , OSArchitecture , OSLanguage | ConvertTo-Html -Fragment 
 
#Time Zone Information 
$TimeZone = Get-WmiObject -Class Win32_TimeZone | Select Caption , StandardName | 
ConvertTo-Html -Fragment 
 
#Logical Disk Information 
$Disk = Get-WmiObject -Class Win32_LogicalDisk -Filter DriveType=3 |  
Select SystemName , DeviceID , @{Name=”size(GB)”;Expression={“{0:N1}” -f($_.size/1gb)}}, @{Name=”freespace(GB)”;Expression={“{0:N1}” -f($_.freespace/1gb)}} | 
ConvertTo-Html -Fragment 
 
#CPU Information 
$SystemProcessor = Get-WmiObject -Class Win32_Processor  |  
Select SystemName , Name , MaxClockSpeed , Manufacturer , status |ConvertTo-Html -Fragment 
 
#Memory Information 
$PhysicalMemory = Get-WmiObject -Class Win32_PhysicalMemory | 
Select -Property Tag , SerialNumber , PartNumber , Manufacturer , DeviceLocator , @{Name="Capacity(GB)";Expression={"{0:N1}" -f ($_.Capacity/1GB)}} | ConvertTo-Html -Fragment 
 
#Software Inventory 
$Software = Get-WmiObject -Class Win32_Product | 
Select Name , Vendor , Version , Caption | ConvertTo-Html -Fragment  
 
ConvertTo-Html -Body "<font color = blue><H4><B>Report Executed On</B></H4></font>$ReportDate 
<font color = blue><H4><B>General Information</B></H4></font>$ComputerSystem 
<font color = blue><H4><B>Boot Configuration</B></H4></font>$BootConfiguration 
<font color = blue><H4><B>BIOS Information</B></H4></font>$BIOS 
<font color = blue><H4><B>Operating System Information</B></H4></font>$OS 
<font color = blue><H4><B>Time Zone Information</B></H4></font>$TimeZone 
<font color = blue><H4><B>Disk Information</B></H4></font>$Disk 
<font color = blue><H4><B>Processor Information</B></H4></font>$SystemProcessor 
<font color = blue><H4><B>Memory Information</B></H4></font>$PhysicalMemory 
<font color = blue><H4><B>Software Inventory</B></H4></font>$Software" -CssUri  "$filepath\style.CSS" -Title "Server Inventory" | Out-File "$FilePath\$ComputerName.html" 
 
Write-Host "Script Execution Completed" -ForegroundColor Yellow 
Invoke-Item -Path "$FilePath\$ComputerName.html"


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 02\B04702_02_06.ps1
************************************************************************
﻿<#
.Synopsis
   A script to retrieve OS information.
.DESCRIPTION
   This PowerShell script will retrieve OS information like Name , OS Architecture, Serial Number and Last Bootup time.
   This script use CIM instance.
.EXAMPLE
   Get-OSInformation -ComputerName localhost
.EXAMPLE
   Get-OSInformation -ComputerName localhost , remotecomputer
#>
function Get-OSInformation
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [String[]]$ComputerName

    )

    Begin
    {
        #Intentionally left blank
    }
    Process
    {
        foreach($computer in $ComputerName)
        {
            $params = @{'ComputerName' = $Computer
                        'Class' = 'CIM_OperatingSystem'}
            Get-CimInstance @Params | 
            Select Caption , OSArchitecture , SerialNumber , LastBootUptime
        }
    }
    End
    {
        #Intentionally left blank
    }
}

#Get-OSInformation -ComputerName localhost , localhost


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 03\B04702_03_01.PS1
************************************************************************
﻿Configuration WebServer
{
    Node $env:COMPUTERNAME
    {
        File DSCConfig
        {
            DestinationPath = 'C:\DSCConfig'
            Type = 'Directory'
            Ensure = 'Present'
        }
        WindowsFeature WebServer
        {
            Name = 'Web-Server'
            LogPath = 'C:\Web-Server.log'
            Ensure = 'Present'
            IncludeAllSubFeature = $true
        }

        WindowsFeature ASPNET45
        {
            Name = 'Web-Asp-Net45'
            LogPath = 'C:\Web-Asp-Net45.log'
            Ensure = 'Present'
            IncludeAllSubFeature = $true
        }
    }
}
WebServer -OutputPath C:\DSCConfig -Verbose


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 03\B04702_03_02.PS1
************************************************************************
﻿Configuration CreateFolder
{
    param([Parameter(Mandatory = $true)]
    $FolderName,
    [Parameter(Mandatory = $true)]
    $ComputerName,
    $Ensure = 'Present',
    $Type = 'Directory'
    )
    Node $ComputerName
    {
        File CreateFolder
        {
            DestinationPath =  $FolderName
            Ensure = $Ensure
            Type = $Type
            
        }
    }
   
}
 
CreateFolder -FolderName 'C:\Temp\PSDSC' -ComputerName localhost
Start-DscConfiguration .\CreateFolder -Wait -Verbose -Force


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 03\B04702_03_03.ps1
************************************************************************
﻿# From release notes

enum Ensure
{
    Absent
    Present
}

[DscResource()]
class StringLiteral
{
    [DscProperty(Key)]
    [string]$Path
    
    [DscProperty(Mandatory)]
    [Ensure] $Ensure    
    
    [DscProperty(Mandatory)]
    [string] $SourcePath

    [DscProperty(NotConfigurable)]   
    [Nullable[datetime]] $CreationTime 

    [void] Set()
    {             
    }

    [bool] Test()
    {
    }
    
    [StringLiteral] Get()
    {
    }
}


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 03\B04702_03_04.ps1
************************************************************************
﻿Configuration ConfigurePullServer
{
   param
   (
     [string[]]$ComputerName = "localhost"
   )
   Import-DSCResource -ModuleName xPSDesiredStateConfiguration
   Node $ComputerName
   {
     WindowsFeature DSCServiceFeature
     {
       Ensure = "Present"
       Name  = "DSC-Service"
     }
     xDscWebService PSDSCPullServer
     {
       Ensure                 = "Present"
       EndpointName           = "PSDSCPullServer"
       Port                   = 8080
       PhysicalPath           = "$env:SystemDrive\inetpub\wwwroot\PSDSCPullServer"
       CertificateThumbPrint  = "AllowUnencryptedTraffic"
       ModulePath             = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
       ConfigurationPath      = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
       State                  = "Started"
       DependsOn              = "[WindowsFeature]DSCServiceFeature"
     }
     xDscWebService PSDSCComplianceServer
     {
       Ensure                 = "Present"
       EndpointName           = "PSDSCComplianceServer"
       Port                   = 9080
       PhysicalPath           = "$env:SystemDrive\inetpub\wwwroot\PSDSCComplianceServer"
       CertificateThumbPrint  = "AllowUnencryptedTraffic"
       State                  = "Started"
       IsComplianceServer     = $true
       DependsOn              = ("[WindowsFeature]DSCServiceFeature","[xDSCWebService]PSDSCPullServer")
     }
   }
}
ConfigurePullServer -ComputerName localhost


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 03\B04702_03_05.ps1
************************************************************************
﻿Configuration SetPullMode
{
     # param([string]$guid)
 
     Node WMF5Node03.DSCDemoLab.Com
     {
         LocalConfigurationManager
         {
             ConfigurationMode = "ApplyAndAutoCorrect"
             ConfigurationModeFrequencyMins = 15
             ConfigurationID = "479316c3-712a-4e5a-9b87-4fde1bf0433e"
             RefreshMode = 'Pull'
             DownloadManagerName = 'WebDownloadManager'
             DownloadManagerCustomData = @{
             ServerUrl = 'http://WMF5Node01.DSCDemoLab.Com:8080/PSDSCPullServer.svc';
             AllowUnsecureConnection = 'true' }
         }
     }
}
 
SetPullMode 
Set-DSCLocalConfigurationManager -Computer WMF5Node03.DSCDemoLab.Com -Path "C:\SetPullMode" -Verbose 


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 03\B04702_03_06.ps1
************************************************************************
﻿Configuration InstallBackup {
     param (
     [string[]]$ComputerName = "localhost"
     )
     
     
     Node $ComputerName {
         
         WindowsFeature Backup {
             Ensure = "Present"
             Name   = "Windows-Server-Backup"
         }
     }
}
InstallBackup -ComputerName WMF5Node03.DSCDemolab.com


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_01_Code.ps1
************************************************************************
﻿Install-PswaWebApplication -UseTestCertificate -Verbose


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_02_Code.ps1
************************************************************************
﻿Get-Command -Module PowerShellWebAccess


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_03_Code.ps1
************************************************************************
﻿Uninstall-PswaWebApplication -WebApplicationName pswa -Verbose  -DeleteTestCertificate


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_04_Code.ps1
************************************************************************
﻿Configuration PSWA
{
    WindowsFeature IIS {
        Name = 'Web-Server'
        Ensure = 'Present'
        IncludeAllSubFeature = $true
    }
    WindowsFeature PS {
        Name = "WindowsPowerShellWebAccess"
        Ensure = "Present"
        IncludeAllSubFeature = $true 
    }
    Script PSWA {
        SetScript = {
            Install-PswaWebApplication
        }
        TestScript = {
            [bool](Get-WebApplication -Name pswa | where {$_.ApplicationPool -eq 'pswa_pool'}) -eq $true
        }
        GetScript = {
            $result = [bool](Get-WebApplication -Name pswa | where {$_.ApplicationPool -eq 'pswa_pool'})
            return @{Installed = $result}
        }
    }
}
PSWA


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_05_Code.ps1
************************************************************************
﻿help Add-PswaAuthorizationRule -Examples


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_06_Code.ps1
************************************************************************
﻿Add-PswaAuthorizationRule –UserName * -ComputerName *  -ConfigurationName *


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_07_Code.ps1
************************************************************************
﻿$param = @{
UserName = 'DSCDEMOLAB\ChenV'
ComputerName = $env:COMPUTERNAME
ConfigurationName = 'Microsoft.PowerShell'
Force = $true
Verbose = $true
}
Add-PswaAuthorizationRule @param



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_08_Code.ps1
************************************************************************
﻿$Odata = @{
            Uri = 'http://services.odata.org/v3/(S(snyobsk1hhutkb2yulwldgf1))/odata/odata.svc'
            MetadataUri = 'http://services.odata.org/v3/(S(snyobsk1hhutkb2yulwldgf1))/odata/odata.svc/$metadata'
            OutputModule = 'C:\Temp\DemoModule'
            AllowUnSecureConnection = $true
          }
Export-odataEndpointProxy @Odata


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_09_Code.ps1
************************************************************************
﻿Get-Command -Module DemoModule


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_10_Code.ps1
************************************************************************
﻿$request = Invoke-WebRequest 'https://www.facebook.com/login.php' -SessionVariable lgn
$Forms = $request.Forms[0]

#To Check the Internal Field Names
$Forms.Fields

$Forms.Fields['email'] = 'UserID'
$Forms.Fields['Password'] = 'Password'

$login =Invoke-WebRequest -Uri ("https://www.facebook.com" + $form.Action) -WebSession $lgn -Method POST -Body $Forms.Fields

#To Check the Post Action result
$login

$login =Invoke-WebRequest -Uri ("https://www.facebook.com" + $form.Action) -WebSession $lgn -Method POST -Body $Forms.Fields
$fb = $login.Forms[0]

#Output
$fb 


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_11_Code.ps1
************************************************************************
﻿Invoke-RestMethod -Uri http://blogs.technet.com/b/wikininjas/rss.aspx | Select Creator , PubDate


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_12_Code.ps1
************************************************************************
﻿$param = @{
            URI = 'http://powershell.com/Mastering-PowerShell.pdf'
            Outfile = 'C:\Temp\Mastering-PowerShell.pdf'
          }
Invoke-RestMethod @param


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_13_Code.ps1
************************************************************************
﻿$wc = New-Object System.Net.WebClient
$wc.DownloadFile('http://powershell.com/Mastering-PowerShell.pdf' , 'C:\Temp\Mastering-PowerShell.pdf')


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_14_Code.ps1
************************************************************************
﻿$Images = 'Url1/image1.jpg , url1/image2.jpg'
$Dir = 'C:\Temp\'
$wc = New-Object System.Net.WebClient
foreach ($sourceFile in $Images){
  $sourceFileName = 
    $sourceFile.SubString($sourceFile.LastIndexOf('/')+1)
  $targetFileName = $targetDirectory + $sourceFileName
  $wc.DownloadFile($sourceFile, 'C:\Temp')
}



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_15_Code.ps1
************************************************************************
﻿$url = "http://blogs.technet.com/b/wikininjas/rss.aspx"
[xml]$xml = (New-object System.Net.WebClient).DownloadString($url)
$xml.rss.channel.description


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_16_Code.ps1
************************************************************************
﻿$url = "http://blogs.technet.com/b/wikininjas/rss.aspx"
[xml]$xml = (New-object System.Net.WebClient).DownloadString($url)
$xml.rss.channel | %{$_.item} | ? {[DateTime]$_.pubDate -gt  (Get-Date).AddMonths(-3)} | FT creator


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_17_Code.ps1
************************************************************************
﻿$url = "http://blogs.technet.com/b/wikininjas/rss.aspx"
[xml]$xml = (New-object System.Net.WebClient).DownloadString($url)
$xml.rss.channel | %{$_.item} | ? {[DateTime]$_.pubDate -gt (Get-Date).AddDays(-7)} | FT creator , pubdate -AutoSize


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_18_Code.ps1
************************************************************************
﻿$var = New-WebServiceProxy -Uri http://www.webservicex.net/CurrencyConvertor.asmx?WSDL
$var.ConversionRate('Eur','US')



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_19_Code.ps1
************************************************************************
﻿$weather = New-WebServiceProxy -uri http://www.webservicex.com/globalweather.asmx?WSDL
([XML]$weather.GetWeather('Amsterdam','Netherlands')).CurrentWeather


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_20_Code.ps1
************************************************************************
﻿$Json = Invoke-WebRequest -Uri "http://itunes.apple.com/search?term=metallica" 
($Json | ConvertFrom-Json).Results | Select WrapperType, trackName | Select -First 25


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_21_Code.ps1
************************************************************************
﻿$Json = Invoke-RestMethod -Uri "http://itunes.apple.com/search?term=metallica"
$Json.results | Select WrapperType , trackName | Select -First 25


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_23_Code.ps1
************************************************************************
﻿$site = Get-AzureWebsite -Name MyAzureSiteDemo
$username = $site.PublishingUsername
$password = $site.PublishingPassword
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
$api = "https://$($site.Name).scm.azurewebsites.net/api"
$kudu = Invoke-RestMethod -Uri "$api/environment" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Method GET $kudu


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_24_Code.ps1
************************************************************************
﻿$json = @"
{
    "Title":  "Mr.",
    "Name":  "Scripting"
}
"@
$json | ConvertFrom-Json



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_25_Code.ps1
************************************************************************
﻿$json = @"
{
    "User1": {"Name": "Chen", "Role": "SharePoint IT Pro"}, 
    "User2": {"Name":"Keanu"}
}
"@
$data = $json | ConvertFrom-Json
$data.User1
$data.User2



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 04\B04702_04_26_Code.ps1
************************************************************************
﻿#Json Format in C:\Temp\JSON.json
{
"1": "One",
"2": "Two",
"3": "Three"
} 

#Reading the JSON content
$data = Get-Content C:\Temp\JSON.json -Raw | ConvertFrom-Json
$data.psobject.Properties.Name



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_01_Code.ps1
************************************************************************
﻿Function Set-Window {
  Param(
    [Parameter(Mandatory = $true)]
    $ID
  )
$code = @"
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int 
  nCmdShow);
"@
$demo = Add-Type -MemberDefinition $code -Name "Demo" -Namespace Win32Functions -PassThru
$demo::ShowWindowAsync((Get-Process -id $ID).MainWindowHandle , 2)
}
Set-Window -ID $pid


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_02_Code.ps1
************************************************************************
﻿Add-Type -AssemblyName System.Speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.Rate = 1
$speak.Speak("Welcome to PowerShell 5.0")



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_03_Code.ps1
************************************************************************
﻿$code = @"
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace ClassLibrary2
{
    public class Class1
    {
        public static int sum(int a,int b)
        {
            return a + b;
        }
    }
}
"@
Add-Type -TypeDefinition $code
[ClassLibrary2.Class1]::sum(34,45)



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_04_Code.ps1
************************************************************************
﻿Import-Module C:\Temp\ClassLibrary2\ClassLibrary2\bin\Debug\ClassLibrary2.dll
[ClassLibrary2.Class1]::sum(45,56)


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_05_Code.ps1
************************************************************************
﻿Import-Module MSOnline
$O365Cred = Get-Credential
$O365Session = New-PSSession –ConfigurationName Microsoft.Exchange `                             -ConnectionUri https://outlook.office365.com/powershell-liveid/?proxymethod=rps `
                             -Credential $O365Cred `
                             -Authentication Basic `
                             -AllowRedirection
Import-PSSession $O365Session
Connect-MsolService –Credential $O365Cred


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_06_Code.ps1
************************************************************************
﻿Get-MailboxFolderStatistics -Identity "TargetMailBoxID" | 
Select FolderType , Name , ItemsinFolder


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_07_Code.ps1
************************************************************************
﻿#Target MailboxID's
$MailboxNames =  "TargetMailID"

#Any Exchange Admin ID with appropriate permissions
$AdminID = "AdminID"

#Fetch password as secure string
$AdminPwd = Read-Host "Enter Password" -AsSecureString

#Load the Exchange Web Service DLL
$dllpath = "C:\Temp\Microsoft.Exchange.WebServices.dll"
[Reflection.Assembly]::LoadFile($dllpath)

#Create a Exchange Web Service
$Service = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService([Microsoft.Exchange.WebServices.Data.ExchangeVersion]::Exchange2013_SP1)

#Credentials to impersonate the mail box
$Service.Credentials = New-Object System.Net.NetworkCredential($AdminID , $AdminPwd)
foreach($MailboxName in $MailboxNames)
{

#Impersonate using Exchange WebService Class
$Service.ImpersonatedUserId = New-Object Microsoft.Exchange.WebServices.Data.ImpersonatedUserId([Microsoft.Exchange.WebServices.Data.ConnectingIdType]::SmtpAddress, $MailboxName)
$Service.AutodiscoverUrl($MailboxName,{$true})

#Assing EWS URL
$service.Url = 'https://outlook.office365.com/EWS/Exchange.asmx'
Write-Host "Processing Mailbox: $MailboxName" -ForegroundColor Green

#Fetch Root Folder ID
$RootFolderID = New-object Microsoft.Exchange.WebServices.Data.FolderId([Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::Root, $MailboxName)
$RootFolder = [Microsoft.Exchange.WebServices.Data.Folder]::Bind($Service,$RootFolderID)

#Create a Folder View
$FolderView = New-Object Microsoft.Exchange.WebServices.Data.FolderView(1000)
$FolderView.Traversal = [Microsoft.Exchange.WebServices.Data.FolderTraversal]::Deep

#Retrive the Information
$response = $RootFolder.FindFolders($FolderView)
$response | Select DisplayName , TotalCount , FolderClass
}



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_09_Code.ps1
************************************************************************
﻿Function Create-LyncClientGroup{
  param([Parameter(Mandatory = $true,ValueFromPipeline = $true)]
    [String[]]$GroupName
  )
  $client = [Microsoft.Lync.Model.LyncClient]::GetClient()
  $client.ContactManager.BeginAddGroup($GroupName, $null,$null)
}
"Test1" | Create-LyncClientGroup



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_10_Code.ps1
************************************************************************
﻿Import-Module -Name 'C:\Program Files (x86)\Microsoft Office\Office15\LyncSDK\Assemblies\Desktop\Microsoft.Lync.Model.dll'
$Client = [Microsoft.Lync.Model.LyncClient]::GetClient()
$self = $Client.Self
$contactInfo = New-object 'System.Collections.Generic.Dictionary[
  Microsoft.Lync.Model.PublishableContactInformationType, object]'
$contactInfo.Add([Microsoft.Lync.Model.PublishableContactInformationType]::Availability,6500)
$ar = $self.BeginPublishContactInformation($contactInfo, $null, $null)
$self.EndPublishContactInformation($ar)


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_11_Code.ps1
************************************************************************
﻿Import-Module 'C:\Program Files (x86)\Microsoft Office\Office15\LyncSDK\Assemblies\Desktop\Microsoft.Lync.Model.dll'
$LyncClient = [Microsoft.Lync.Model.LyncClient]::Getclient()
$Conversation = $LyncClient.ConversationManager.AddConversation()
[Void]$Conversation.AddParticipant($LyncClient.Self.TestCallEndpoint)
[Void]$Conversation.Modalities['AudioVideo'].BeginConnect({},0)


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_12_Code.ps1
************************************************************************
﻿#region 
Import-Module 'C:\Program Files (x86)\Microsoft Office\Office15\LyncSDK\Assemblies\Desktop\Microsoft.Lync.Model.dll'
$Client = [Microsoft.Lync.Model.LyncClient]::GetClient()
$TestCall = {
                $Conversation = $this.ConversationManager.AddConversation()
                [void]$Conversation.AddParticipant($this.Self.TestCallEndpoint)
                [void]$Conversation.Modalities['AudioVideo'].BeginConnect({}, 0)
                Add-Member -InputObject $Conversation -MemberType ScriptMethod -Name EndCall -Value {
                    [void]$this.Modalities['AudioVideo'].BeginDisconnect([Microsoft.Lync.Model.Conversation.ModalityDisconnectReason]::None, {}, 0)
                    } -PassThru
            }
Add-Member -InputObject $Client -MemberType ScriptMethod -Name TestCall -Value $TestCall -Force
#endregion

#region
$Conversation = $Client.TestCall()
Start-Sleep 15
$Conversation.EndCall()
#endregion



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_13_Code.ps1
************************************************************************
﻿Function Send-SelfIM{
    $LyncClient = [Microsoft.Lync.Model.LyncClient]::GetClient()
    $ConversationManager = $LyncClient.ConversationManager;
    $Conversation = $ConversationManager.AddConversation();
    [void]$Conversation.AddParticipant($LyncClient.Self.Contact)
    $Conversation.Modalities['InstantMessage'].BeginSendMessage("Okay! This Works",$null,$null);
}
Send-SelfIM



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_14_Code.ps1
************************************************************************
﻿Function Send-SelfIM{
    Param([Parameter(Mandatory = $true)]
        [String[]]$Greet
    )
    $LyncClient = [Microsoft.Lync.Model.LyncClient]::GetClient()
    $ConversationManager = $LyncClient.ConversationManager;
    $Conversation = $ConversationManager.AddConversation();
    [void]$Conversation.AddParticipant($LyncClient.Self.Contact)
    [Void]$Conversation.Modalities['InstantMessage'].BeginSendMessage($Greet,$null,$null);
}
Send-SelfIM -Greet "Hi, I am parameterized!"


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_15_Code.ps1
************************************************************************
﻿#Import the required DLL
Import-Module 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.UserProfiles.dll'

#Mysite URL
$site = 'https://Domain-my.sharepoint.com/'

#Admin User Principal Name
$admin = 'Admin@Domain.OnMicrosoft.Com'

#Get Password as secure String
$password = Read-Host 'Enter Password' -AsSecureString

#Get the Client Context and Bind the Site Collection
$context = New-Object Microsoft.SharePoint.Client.ClientContext($site)

#Authenticate
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($admin , $password)
$context.Credentials = $credentials

#Fetch the users in Site Collection
$users = $context.Web.SiteUsers
$context.Load($users)
$context.ExecuteQuery()

#Create an Object [People Manager] to retrieve profile information
$people = New-Object Microsoft.SharePoint.Client.UserProfiles.PeopleManager($context)
$collection = @()
Foreach($user in $users)
{
    $userprofile = $people.GetPropertiesFor($user.LoginName)
    $context.Load($userprofile)
    $context.ExecuteQuery()
    if($userprofile.Email -ne $null)
    {
        $upp = $userprofile.UserProfileProperties
        foreach($ups in $upp)
        {
            $profileData = "" | Select "FirstName" , "LastName" , "WorkEmail" , "Title" , "Responsibility"
            $profileData.FirstName = $ups.FirstName
            $profileData.LastName = $ups.LastName
            $profileData.WorkEmail = $ups.WorkEmail
            $profileData.Responsibility = $ups.'SPS-Responsibility'
            $collection += $profileData
        }
    }
}
$collection | Export-Csv C:\Temp\SPO-UserInformation.csv -NoTypeInformation -Encoding UTF8



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_16_Code.ps1
************************************************************************
﻿#Import the required DLL
Import-Module 'C:\Temp\CSOM\Microsoft.SharePoint.Client.dll'
Import-Module 'C:\Temp\CSOM\Microsoft.SharePoint.Client.Runtime.dll'
$site = 'https://site.domain.com/'
$admin = 'AdminID'
$password = Read-Host 'Enter Password' -AsSecureString
$context = New-Object Microsoft.SharePoint.Client.ClientContext($site)
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($admin , $password)
$context.Credentials = $credentials
$site = $context.Web
$context.Load($site)
$context.ExecuteQuery()
#Create List
$listinfo =New-Object Microsoft.SharePoint.Client.
  ListCreationInformation
$listinfo.Title = 'CSOM List'
$listinfo.TemplateType = [Microsoft.SharePoint.Client.ListTemplateType]'GenericList'
$list = $Site.Lists.Add($listinfo)
$context.ExecuteQuery()
Write-Host "Successfully Created List $($listinfo.Title)"


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 2\Chapter 05\B04702_05_17_Code.ps1
************************************************************************
﻿Import-Module 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll'
#OR
Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll'
#Site URL
$site = 'https://Domain.sharepoint.com/'
#Admin User Principal Name
$admin = 'Admin@Chensoffice365.OnMicrosoft.Com'
#Get Password as secure String
$password = Read-Host 'Enter Password' -AsSecureString
#Get the Client Context and Bind the Site Collection
$context = New-Object Microsoft.SharePoint.Client.ClientContext($site)
#Authenticate
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($admin , $password)
$context.Credentials = $credentials
#Delete List
$list = $context.Web.Lists.GetByTitle('PowerShell CSOM')
$context.Load($list)
$list.DeleteObject()
$list.Update()



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\2076_05_code\3557EN_05_code.ps1
************************************************************************
﻿###################################################################
# Chapter 5 - Code File
###################################################################

###################################################################
# Example On How to use the "." and "\." expressions
###################################################################
# Match any character in string
"This Matches Any Character" –cmatch "."
# Match any character in string that is $null
"" –cmatch "."
# Match the Period in string
"This Matches Just The Period." –cmatch "\."
# Match the period – no periods exist.
"This Matches Nothing" –cmatch "\."


###################################################################
# Example On How to Replace leveraging a Regular Expression
###################################################################
"This is PowerShell." –replace "Power","a Turtle"


###################################################################
# Example On How to match a variety of different types of data in strings
###################################################################
# Match to Digit Characters
"0132465789" –cmatch "\d"
# Match to Non-Digit Characters
"This String Contains Word Characters" –cmatch "\D"
# Match to Word Characters
"This String Contains Words" –cmatch "\w"
# Match to Non-word Characters
"!!@#@##$" –cmatch "\W"
# Match to Space Characters
"This String Contains A Space" –cmatch "\s"
# Match to Non Space Characters
"ThisCannotContainSpaces" –cmatch "\S"


###################################################################
# Example On How to use ranges and the OR comparison to evaluate a string
###################################################################
# Match Uppercase O OR Lowercase u
"Domain\User23" –cmatch "(O|u)"
# Match Uppercase O OR Uppercase U
"Domain\User23" –cmatch "(O|U)"
# Match Lowercase a-u or Uppercase A-U
"Domain\User23" –cmatch "[a-uA-U]"
# Match Lowercase a-u or Uppercase A-U or numbers 2-3
"Domain\User23" –cmatch "[a-uA-U2-3]"


###################################################################
# Example On How to properly use the * metacharacter in an expression
###################################################################
# Match the Word "Domain" and a backslash
"Domain\User23" –cmatch "Domain.*\\.*"
# Match the Word "Domain" and a backslash
"Domain.com\User23" –cmatch "Domain.*\\.*"
# Match the Word "Domain" and a backslash 
"User23.Domain.com" –cmatch "Domain.*\\.*"


###################################################################
# Example On How touse the “+” metacharacter in an expression
###################################################################
# Match the Word "Domain" at least once. 
"Domain\User23" –cmatch "Domain+"
# Match the Word ".com" at least once.
"Domain\User23" –cmatch "\.com+"
# Match the Word "Domain.com" at least once and a backslash
"Domain.com\User23" –cmatch "Domain\.com+.*\\"


###################################################################
# Example On How to use the “?” metacharacter in an expression
###################################################################
# Match "Domain", optional "com", and a backslash
"Domain.com\User23" –cmatch "Domain.*(com)?\\"
# Match "Domain", optional "com", and a backslash
"Domain\User23" –cmatch "Domain.*(com)?\\"
# Match "Domain", optional "com", and a backslash
"Domain.comUser23" –cmatch "Domain.*(com)?\\"


###################################################################
# Example On How to use the { } quantifier in an expression
###################################################################
# Match exactly one "Domain” and exactly one backslash
"Domain\User23" –cmatch "Domain{1}.*\\{1}"
# Match exactly one "Domain” and exactly two backslashes
"Domain\User23" –cmatch "Domain{1}.*\\{2}"
# Match exactly one "Domain” and exactly one backslash
"User32.Domain.com" –cmatch "Domain{1}.*\\{1}"


###################################################################
# Example On How to use the ^ and $ metacharacters in an expression
###################################################################
# Match at the beginning, if the string contains a word.
"Successfully connected to Active Directory." –cmatch "^\w"
# Match at the end, if the string contains a word. (does not)
"Successfully connected to Active Directory." –cmatch "\w$"
# Match at the end, if the string doesn’t contain a word. 
"Successfully connected to Active Directory." –cmatch "\W$"
# Match at the beginning, it contains a word, match any characters in between, and match at the end, it doesn’t contain a word.
"Successfully connected to Active Directory." –cmatch "^\w.*\W$"


###################################################################
# Example On How to use the whole word evaluators in an expression
###################################################################
# Matches the whole word "to".
"Error communicating to Active Directory." –cmatch "\bto\b"
# Matches the whole word "to".
"Error communicating with Active Directory." –cmatch "\bto\b"
# Matches where the whole word "to" does not exist.
"Error communicating with Active Directory." –cmatch "\Bto\B"
# Matches where the whole word "to" does not exist.
"Error communicating with AD." –cmatch "\Bto\B"

###################################################################
# Example On How to Validate a MAC Address
###################################################################
"00:a0:f8:12:34:56" -match "^([0-9a-f]{2}:){5}[0-9a-f]{2}$"

###################################################################
# Example On How to Validate a UNC Path
###################################################################
"\\servername\Public\" -match "^\\{2}\w+\\{1}\w+"

###################################################################
# Example On How to Validate an ICANN US Phone Number
###################################################################
"+1.4141231234" –cmatch "^\+{1}[1]{1}\.{1}\d{10}$"


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\2076_10_codes\3557EN_10_code.ps1
************************************************************************
﻿###################################################################
# Chapter 9 - Code File
###################################################################


###################################################################
# Example On How To use get-wmiobject to view a class
###################################################################
get-wmiobject –namespace root\cimv2 –class win32_computersystem


###################################################################
# Example On How To use get-ciminstance to view a class
###################################################################
get-ciminstance –namespace root\cimv2 –class win32_computersystem


###################################################################
# Example On How To View all of the attributes of a class
###################################################################
get-wmiobject –class win32_computersystem | get-member


###################################################################
# Example On How To Search in a list of classes for a specific value
###################################################################
get-wmiobject –list | where{$_.Name –like "*Time*"}


###################################################################
# Example On How To Search using get-cimclass for a specific value
###################################################################
get-cimclass | where{$_.CimClassName –like "*Time*"}


###################################################################
# Example On How To View and count the class properties of a class
###################################################################
$classProperties = (get-cimclass –class win32_Printer).CimClassProperties
$classProperties.count


###################################################################
# Example On How To use get-cimclass to view the cimclassmethods of a class
###################################################################
(get-cimclass –class win32_Printer).CimClassMethods


###################################################################
# Example On How To View qualifiers for cimclassmethods.
###################################################################
$method = (get-cimclass –class win32_Printer).CimClassMethods | where {$_.name -eq "SetDefaultPrinter"}
$method
$method.qualifiers


###################################################################
# Example On How To view to determine the writeable properties of a class
###################################################################
Get-cimclass win32_Environment | select –ExpandProperty CimClassProperties | where {$_.Qualifiers –match "write"}


###################################################################
# Example On How To view to determine the non-writeable properties of a class
###################################################################
Get-cimclass win32_Environment | select –ExpandProperty CimClassProperties | where {$_.Qualifiers –notmatch "write"} | select –ExpandProperty Name


###################################################################
# Example On How To view use the get-ciminstance
###################################################################
Get-ciminstance Win32_Environment


###################################################################
# Example On How To create a new property in a WMI class.
###################################################################
# Update the Domain\Username with valid credentials
New-CimInstance Win32_Environment -Property @{Name="PurchasedDate";VariableValue="10/17/2015"; UserName="DOMAIN\USERNAME"}
Get-Ciminstance Win32_Environment | Where {$_.name –match "PurchasedDate"}


###################################################################
# Example On How To modify a property in a WMI Class
###################################################################
$instance = Get-Ciminstance Win32_Environment | Where {$_.name –match "PurchasedDate"}
Set-ciminstance –ciminstance $instance –property @{Name="PurchasedDate";VariableValue="October 17, 2015";}
Get-Ciminstance win32_Environment | Where {$_.name –match "PurchasedDate"}


###################################################################
# Example On How To remove a property in a WMI class
###################################################################
$instance = Get-Ciminstance win32_environment | Where {$_.name –match "PurchasedDate"}
Remove-ciminstance –ciminstance $instance
Get-Ciminstance win32_environment | Where {$_.name –match "PurchasedDate"}


###################################################################
# Example On How To view the Properties of CimClassMethods
###################################################################
get-cimclass win32_process | select –ExpandProperty CimClassMethods


###################################################################
# Example On How To invoke a method using arugments.
###################################################################
Invoke-CimMethod Win32_Process -MethodName "Create" -Arguments @{ CommandLine = 'mspaint.exe'}


###################################################################
# Example On How To invoke a method using a query.
###################################################################
Invoke-CimMethod –Query 'select * from Win32_Process where name like "mspaint.exe"' –MethodName "Terminate"



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_01_code.ps1
************************************************************************
###################################################################
# Chapter 1 - Code File
###################################################################

###################################################################
#  Example On How to store a string in an array
###################################################################
$myString = "My String Has Multiple Words"
$myString 

###################################################################
#  Example On How to store a number in an array
###################################################################
$myNumber = 1
$myNumber

###################################################################
#  Example On How to Combine Two Strings
###################################################################
$a = "1"
$b = "2"
$c = $a + $b

###################################################################
#  Example On How to Add two numbers
###################################################################
$a = 1
$b = 2
$c = $a + $b

###################################################################
#  Example On storing an object in a variable, getting the object properties
###################################################################
$date = get-date
$date
$date | get-member

###################################################################
#  Example On How to View Object Properties and Invoke Methods
###################################################################
$date = get-date
$date.Year
$date.addyears("5")


###################################################################
#  Example On How to Create an Array
###################################################################
$myArray = "Example 1", "Example 2", "Example 3", "Example 4", "Example 5"
$myArray


###################################################################
#  Example On How to Obtain a single (first) value in an Array
###################################################################
$myArray = "Example 1", "Example 2", "Example 3", "Example 4", "Example 5"
$myArray[0]


###################################################################
#  Example On How to Create A Jagged Array and search the array
###################################################################
$myArray = ("Example 1","Red"), ("Example 2","Orange"), ("Example 3", "Yellow"), ("Example 4", "Green"), ("Example 5", "Blue")
$myArray[0][0]
$myArray[4][1]


###################################################################
#  Example On How to Update Array Values
###################################################################
$myArray = ("John","Doe"), ("Jane","Smith")
$myArray
$myArray[1][1] = "Doe"
$myArray


###################################################################
#  Example On How to Append data to an array
###################################################################
# Create the Array
$myArray = ("John","Doe"), ("Jane","Smith")
$myArray
# Append Data to the Array
$myArray += ("Sam","Smith")
$myArray


###################################################################
#  Example On How to Create a Hash Table
###################################################################
$users = @{"john.doe" = "jdoe"; "jane.doe" = "jdoe1"}
$users


###################################################################
#  Example On How to find a specific value in a Hash Table
###################################################################
$users = @{"john.doe" = "jdoe"; "jane.doe" = "jdoe1"}
$users["john.doe"]


###################################################################
#  Example On How to Add Values to A Hash table
###################################################################
$users = @{"john.doe" = "jdoe"; " jane.doe" = "jdoe1"}
$users
$users.add("John.Smith", "jsmith")
$users


###################################################################
#  Example On How to Update a Hash Value
###################################################################
$users = @{"john.doe" = "jdoe"; "jane.doe" = "jdoe1"}
$users
$users["jane.doe"] = "jadoe"
$users


###################################################################
#  Example On How to Remove A Hash Value
###################################################################
$users = @{"john.doe" = "jdoe"; "jane.doe" = "jdoe1"}
$users
$users.remove("Jane.Doe")
$users


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_02_code.ps1
************************************************************************
﻿###################################################################
# Chapter 2 - Code File
###################################################################

###################################################################
#  Example On How To Convert to Uppercase
###################################################################
$a = "Error: This is an example error"
$a.toUpper()


###################################################################
#  Example On How To Convert to Lowercase
###################################################################
$string = "The MAC Address is " 
$mac = "00:A0:AA:BB:CC:DD"
$message = $string + $mac.toLower()
$message


###################################################################
#  Example On How To Replace items in Strings
###################################################################
$usernames = "CN=juser,CN=jdoe,CN=jsmith,CN=bwhite,CN=sjones"
$usernames = $usernames.replace("CN=","")
$usernames


###################################################################
#  Example On How To Split Strings
###################################################################
$usernames = "juser,jdoe,jsmith,bwhite,sjones"
$userarray = $usernames.split(",")
$userarray


###################################################################
#  Example On How To Count Strings
###################################################################
$services = get-service
$services.count


###################################################################
#  Example On How To Count the Length of Strings
###################################################################
$path = "c:\windows\system32\drivers\1394bus.sys"
$path.length


###################################################################
#  Example On How To Trim White Space in Strings
###################################################################
$csvValue = "   servername.mydomain.com   "
$csvValue.trim()



###################################################################
#  Example On How To Trim Strings of a specific value
###################################################################
$csvValue = "servername.mydomain.com"
$csvValue = $csvValue.trim(".mydomain.com")
$csvValue



###################################################################
#  Example On How To Trim Strings at the Start and End of the string.
###################################################################
$csvValue = "FQDN: servername.mydomain.com"
$csvValue = $csvValue.trimStart("FQDN: ")
$csvValue = $csvValue.trimEnd(".mydomain.com")
$csvValue


###################################################################
#  Example On How To Trim will automatically remove items at the 
#  start and end of a string.
###################################################################
$csvValue = "computername.mydomain.com"
$csvValue.Trim("com")


###################################################################
#  Example On How To Select a Substring
###################################################################
$string = "TESTING123"
$string = $string.substring("7")
$string


###################################################################
#  Example On How To Select A Substring in the middle of a string
###################################################################
$string = "TESTING123"
$string = $string.substring("0","4")
$string


###################################################################
#  Example On How To Use the Contains Method on Strings
###################################################################
$ping = ping ThisDoesNotExistTesting.com –r 1
$ping
$deadlink = $ping.contains("Ping request could not find host")
$deadlink


###################################################################
#  Example On How To use the StartsWith Method on Strings
###################################################################
$ping = ping ThisDoesNotExistTesting.com –r 1
$ping
$deadlink = $ping.StartsWith("Ping request could not find host")
$deadlink


# True False EndsWith Example
###################################################################
#  Example On How To use the EndsWith Method on Strings
###################################################################
$ping = ping ThisDoesNotExistTesting.com –r 1
$ping
$deadlink = $ping.EndsWith("Please check the name and try again.")
$deadlink


###################################################################
#  Example On How To Generate pi
###################################################################
[math]::pi


###################################################################
#  Example On How To Generate Euler's Number
###################################################################
[math]::e


###################################################################
#  Example On How To Generate the Square root of a number
###################################################################
[math]::sqrt("996004")


###################################################################
#  Example On How To Round a number
###################################################################
$number = "214.123857123495731234948327312341657"
[math]::Round($number,"5")


###################################################################
#  Example On How To Format numbers
###################################################################
$number =12375134.132412
"{0:N4}" –f $number


###################################################################
#  Example On How To Format a number into a Hexadcimal
###################################################################
$number =12375134
$number = "{0:X0}" –f $number
$number


###################################################################
#  Example On How To Calculate TB / GB / MB / KB from Bytes
###################################################################
# 16 GB of Memory in Bytes
$ComputerMemory = 16849174528
$ComputerMemory / 1TB
$ComputerMemory / 1GB
$ComputerMemory / 1MB
$ComputerMemory / 1KB


###################################################################
#  Example On How To Generate the Date & Time
###################################################################
$time = get-date
$time


###################################################################
#  Example On How To Format the Date Time.
###################################################################
$date = get-date –format "MM/dd/yyyy HH:MM:ss tt"
$date


###################################################################
#  Example On How To Format the Date time and include strings
###################################################################
$date = get-date –format "MMddyyyyHHMMss"
$logfile = "Script" + $date + ".log"
$logfile


###################################################################
#  Example On How To Add Days to a date time value
###################################################################
$date = (get-date).AddDays(30).ToString("MM/dd/yyyy")
$date


###################################################################
#  Example On How To Format Ticks into a different Date Time Format
###################################################################
$date = [datetime]::FromFileTime("130752344000000000")
$date


###################################################################
#  Example On How To Force a String Data Type
###################################################################
[string]$myString = "Forcing a String Container"
$myString



###################################################################
#  Example On How To Try To Place a String Into an Integer Data Type
#  NOTE: This command is designed to throw an exception
###################################################################
[int]$myInt = "Trying to Place a String in an Int Container"



###################################################################
#  Example On How To use the pipeline
###################################################################
$services = get-service | where{$_.name –like "*Event*"} | Sort-object name
$services


###################################################################
#  Example On How To Use multiple Values in the Pipeline.
###################################################################
$largeFiles = get-childitem “c:\windows\system32\” | where{$_.length –gt 20MB}
$count = $largeFiles.count
Write-host "There are $count Files over 20MB"
write-host "Files Over 20MB in c:\Windows\System32\ :"
$largefiles | select-object name,length,lastwritetime | format-list



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_03_code.ps1
************************************************************************
﻿###################################################################
# Chapter 3 - Code File
###################################################################

###################################################################
#  Example On Boolean Comparison Results
###################################################################
$TrueVariable = $True
$FalseVariable = $False
if ($TrueVariable) { Write-Host "Statement is True." }
if ($FalseVariable) { Write-Host "Statement is False." }

###################################################################
#  Example On How to Use the Equal Operator
###################################################################
$value1 = "PowerShell"
$value2 = "PowerShell"
if ($value1 –eq $value2) { write-host "It’s Equal!" }

###################################################################
#  Example On How to Use Not Equal Operators with Characters
###################################################################
$value1 = "PowerShell"
$value2 = "POSH"
if ($value1 –ne $value2) { write-host "Values Are Not Equal" }

###################################################################
#  Example On How to Use Not Equal Operators
###################################################################
$value = "This is a value."
$length = $value.length
If ($length –ne 0) { Write-host "The variable has data in it. Do this action" }

###################################################################
#  Example On How to Use the Less Than Operator Example
###################################################################
$number1 = 10
$number2 = 20
If ($number1 –lt $number2) { write-host "Value $number1 is less than $number2" }

###################################################################
#  Example On How to uUse the Greater Than Operators
###################################################################
$olddate = get-date
Start-sleep –seconds 2
$newdate= get-date
If ($newdate –gt $olddate) { write-host "Value $newdate is greater than $olddate" }

###################################################################
#  Example On How to Use the Contains / NotContains Operators
###################################################################
$myarray = "this", "is", "my", "array"
If ($myarray –contains "this") { write-host "The array contains the word: this" }
If ($myarray –notcontains "that") { write-host "The array does not contain the word: that" }

###################################################################
#  Example On How to Use the Like / NotLike Operators
###################################################################
$myexample = "This is a PowerShell example."
If ($myexample –like "*shell*") { write-host "The variable has a word that is like shell" }
If ($myexample –notlike "*that*") { write-host "The variable doesn’t have a word that is like that" }

###################################################################
#  Example On How to Use the Match / NotMatch Operators
###################################################################
$myexample = "The network went down."
If ($myexample –match "[o]") { Write-Host "The variable matched the letter o. (Contains two o’s)" }
$matches
If ($myexample –notmatch "[U]") { Write-Host "The variable does not match U. (Doesn’t have a U)" }

###################################################################
#  Example On How to Use The And / Or Operators 
###################################################################
$myvar = $True
$myothervar = $False
If ($myvar –eq $True –AND $myothervar –eq $False) { Write-host "Both statements evaluate to be True" }
If ($myvar –eq $True –OR $myothervar –eq $True) { Write-host "At least one statement evaluates to be True" }



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_04_code.ps1
************************************************************************
﻿###################################################################
# Chapter 4 - Code File
###################################################################

###################################################################
# Example On How To Create a Function
###################################################################
Function Display-Text { Write-Host "Showing Text" }
Display-Text


###################################################################
# Example On How To Create a Function with Parameters in Parentheses
###################################################################
Function Display-Text($variable1,$variable2) {
    Write-Host "First Function Argument: $variable1"
    Write-Host "Second Function Argument: $variable2"
}
Display-Text "Hello" "Readers"


###################################################################
# Example On How To Create a Function with a Parameter Block
###################################################################
Function Display-Text { Param($variable1, $variable2)
    Write-Host "First Function Argument: $variable1"
    Write-Host "Second Function Argument: $variable2"
}
Display-Text "Hello" "Readers"


###################################################################
# Example On How To Create a Function with a [Parameter()] Decorator
###################################################################
Function Display-Text {
	#Declare the Parameter Block
    Param(
        #Set The First Parameter as Mandatory with a Help Message
        [Parameter(Mandatory=$True,HelpMessage="Error: Please Enter A Computer Name")]$computername, 
        #Set the Second Parameter as Not Mandatory
        [Parameter(Mandatory=$false)]$Message
    )
    Write-Host "First Mandatory Function Argument: $computername"
    Write-Host "Second Function Argument: $Message"
}
Display-Text –computername "MyComputerName" "MyMessage"
Display-Text


###################################################################
# Example On How To Create a Function That Returns Values
###################################################################
Function Create-WarningMessage {
	$MyError = "This is my Warning Message!"
	$MyError
}
Function Create-Message { return "My Return message." }
Function Create-Message2 { Write-Output "My Write-Output message." }
Create-WarningMessage | Write-Warning
Create-Message
Create-Message2


###################################################################
# Example On How to Use the Do / While Looping Structure
###################################################################
$x = 1
$myVar = $False
Do { 
    If ($x –ne "4") { 
	    Write-Host "This Task Has Looped $x Times"
    }
    If ($x –eq "4") {
	    $myVar = $True
	    Write-Host "Successfully executed the script $x times"
    }
    $x++
}
While ($myVar -eq $False)



###################################################################
# Example on How to Use the Do / until Looping Structure
###################################################################
$x = 1
$myVar = $False
Do { 
    If ($x –ne "4") { 
        Write-Host "This Task Has Looped $x Times"
    }
    If ($x –eq "4") {
        $myVar = $True
        Write-Host "Successfully executed the script $x times"
    }
    $x++
}
Until ($myVar -eq $True)


###################################################################
# Example on How to use the Foreach Looping Structure
###################################################################
$users = "Mitch", "Ted", "Tom", "Bill"
ForEach ($user in $users) {
    Write-host "Hello $user!"
}


###################################################################
# Example on how to Use the For Looping Structure
###################################################################
For ($x = 1; $x –lt "5"; $x++) {
    write-host "Hello World! Loop Attempt Number: $x"
}


###################################################################
# Example on How to Create a Switch
###################################################################
$x = "that"
Switch ($x) { 
	this { write-host "Value $x equals this." }
	that { write-host "Value $x equals that." } 
	Default { write-host "Value Doesn’t Match Any Other Value" }
}


###################################################################
# Example on How to Use Loops, Switches, and Functions Together
# A Menu System for Use With This Example
###################################################################
# A Menu System for Use With This Example
Function menu-system {
    Write-host "*********************************************"
    Write-Host "* Please Make A Selection Below:"
    Write-Host "*"
    Write-Host "* [1] Backup User Permissions."
    Write-host "*"
    Write-Host "* [2] Delete User Permissions."
    Write-host "*"
    Write-Host "* [3] Restore User Permisssions."
    Write-host "*"
    Write-host "*********************************************"
    Write-host ""
    Write-host "Please Make A Selection:"
    # Prompt for a User Input.
    $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    # A Switch to Evaluate User Input.
    Switch ($x.character) {
        1 { write-host "Option 1: User Permissions Backed Up." }
        2 { write-host "Option 2: User Permissions Deleted." }
        3 { write-host "Option 3: User Permissions Restored." }
        Default { 
            return $True
        }
	}
}
# A Loop Structure That will Loop Until $Restart doesn’t equal true.
Do {
    $restart = Menu-system
    If ($restart –eq $True) { 
        cls
        write-host "!! Invalid Selection: Please Try Again" 
        write-host "" 
    }
}
Until ($restart –ne $True)



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_05_code.ps1
************************************************************************
﻿###################################################################
# Chapter 5 - Code File
###################################################################

###################################################################
# Example On How to use the "." and "\." expressions
###################################################################
# Match any character in string
"This Matches Any Character" –cmatch "."
# Match any character in string that is $null
"" –cmatch "."
# Match the Period in string
"This Matches Just The Period." –cmatch "\."
# Match the period – no periods exist.
"This Matches Nothing" –cmatch "\."


###################################################################
# Example On How to Replace leveraging a Regular Expression
###################################################################
"This is PowerShell." –replace "Power","a Turtle"


###################################################################
# Example On How to match a variety of different types of data in strings
###################################################################
# Match to Digit Characters
"0132465789" –cmatch "\d"
# Match to Non-Digit Characters
"This String Contains Word Characters" –cmatch "\D"
# Match to Word Characters
"This String Contains Words" –cmatch "\w"
# Match to Non-word Characters
"!!@#@##$" –cmatch "\W"
# Match to Space Characters
"This String Contains A Space" –cmatch "\s"
# Match to Non Space Characters
"ThisCannotContainSpaces" –cmatch "\S"


###################################################################
# Example On How to use ranges and the OR comparison to evaluate a string
###################################################################
# Match Uppercase O OR Lowercase u
"Domain\User23" –cmatch "(O|u)"
# Match Uppercase O OR Uppercase U
"Domain\User23" –cmatch "(O|U)"
# Match Lowercase a-u or Uppercase A-U
"Domain\User23" –cmatch "[a-uA-U]"
# Match Lowercase a-u or Uppercase A-U or numbers 2-3
"Domain\User23" –cmatch "[a-uA-U2-3]"


###################################################################
# Example On How to properly use the * metacharacter in an expression
###################################################################
# Match the Word "Domain" and a backslash
"Domain\User23" –cmatch "Domain.*\\.*"
# Match the Word "Domain" and a backslash
"Domain.com\User23" –cmatch "Domain.*\\.*"
# Match the Word "Domain" and a backslash 
"User23.Domain.com" –cmatch "Domain.*\\.*"


###################################################################
# Example On How touse the “+” metacharacter in an expression
###################################################################
# Match the Word "Domain" at least once. 
"Domain\User23" –cmatch "Domain+"
# Match the Word ".com" at least once.
"Domain\User23" –cmatch "\.com+"
# Match the Word "Domain.com" at least once and a backslash
"Domain.com\User23" –cmatch "Domain\.com+.*\\"


###################################################################
# Example On How to use the “?” metacharacter in an expression
###################################################################
# Match "Domain", optional "com", and a backslash
"Domain.com\User23" –cmatch "Domain.*(com)?\\"
# Match "Domain", optional "com", and a backslash
"Domain\User23" –cmatch "Domain.*(com)?\\"
# Match "Domain", optional "com", and a backslash
"Domain.comUser23" –cmatch "Domain.*(com)?\\"


###################################################################
# Example On How to use the { } quantifier in an expression
###################################################################
# Match exactly one "Domain” and exactly one backslash
"Domain\User23" –cmatch "Domain{1}.*\\{1}"
# Match exactly one "Domain” and exactly two backslashes
"Domain\User23" –cmatch "Domain{1}.*\\{2}"
# Match exactly one "Domain” and exactly one backslash
"User32.Domain.com" –cmatch "Domain{1}.*\\{1}"


###################################################################
# Example On How to use the ^ and $ metacharacters in an expression
###################################################################
# Match at the beginning, if the string contains a word.
"Successfully connected to Active Directory." –cmatch "^\w"
# Match at the end, if the string contains a word. (does not)
"Successfully connected to Active Directory." –cmatch "\w$"
# Match at the end, if the string doesn’t contain a word. 
"Successfully connected to Active Directory." –cmatch "\W$"
# Match at the beginning, it contains a word, match any characters in between, and match at the end, it doesn’t contain a word.
"Successfully connected to Active Directory." –cmatch "^\w.*\W$"


###################################################################
# Example On How to use the whole word evaluators in an expression
###################################################################
# Matches the whole word "to".
"Error communicating to Active Directory." –cmatch "\bto\b"
# Matches the whole word "to".
"Error communicating with Active Directory." –cmatch "\bto\b"
# Matches where the whole word "to" does not exist.
"Error communicating with Active Directory." –cmatch "\Bto\B"
# Matches where the whole word "to" does not exist.
"Error communicating with AD." –cmatch "\Bto\B"

###################################################################
# Example On How to Validate a MAC Address
###################################################################
"00:a0:f8:12:34:56" -match "^([0-9a-f]{2}:){5}[0-9a-f]{2}$"

###################################################################
# Example On How to Validate a UNC Path
###################################################################
"\\servername\Public\" -match "^\\{2}\w+\\{1}\w+"

###################################################################
# Example On How to Validate an ICANN US Phone Number
###################################################################
"+1.4141231234" –cmatch "^\+{1}[1]{1}\.{1}\d{10}$"


c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_06_code.ps1
************************************************************************
﻿###################################################################
# Chapter 6 - Code File
###################################################################

###################################################################
# Example Of How To Use CMDlet Parameters for Exception Handling
###################################################################
Function serviceExample($svcName) { 
Get-service $svcName –ErrorAction SilentlyContinue –ErrorVariable err

    If ($err) {
	    Write-host "Error! Error Details: $err"
        return
    }
	
    Write-host "Successfully Retrieved Service Information for $svcName. "
}
ServiceExample "Windows Update"
Write-host "" 
ServiceExample "Does Not Exist"


###################################################################
# Example Of How to leverage the Try/Catch Method For Exception Handling
###################################################################
Try {
    1+ "abcd"
}
Catch {
	Write-host "Error Processing the Command: $_"
}
Write-host "" 
Write-host "Attempting to Add a String without Exception Handling:"
1+ "abcd"

###################################################################
# Example Of How to leverage the Try/Catch Method and CMDlet Paramerters For Exception Handling
###################################################################
Try {
    Get-process "Doesn’t Exist" –ErrorAction SilentlyContinue –ErrorVariable err
}
Catch {
	Write-host "Try/Catch Exception Details: $_"
}
if ($err) {
	Write-host "Cmdlet Error Handling Error Details: $err"
}


###################################################################
# Example Of Legacy Exception Handling
###################################################################
$err = netsh advfirewall firewall add rule name="Test Allow 12345" protocol=TCP dir=out localport=12345 action=Allow
If ($err –notlike "Ok.") {
	Write-host "Error Processing netsh command: $err"
}
Write-host "Data Contained in the Variable Err is $err"


###################################################################
# Example Of Legacy Exception Handling
###################################################################
$err = netsh advfirewall firewall add rule name="Test Allow 12345" protocol=TCP dir=out localport=1234567 action=Allow
If ($err –notlike "Ok.") {
	Write-host "Error Processing netsh command: $err"
}


###################################################################
# Example Of Legacy Exception Handling and parsing the error message
###################################################################
$err = netsh advfirewall firewall add rule name="Test Allow 12345" protocol=TCP dir=out localport=1234567 action=Allow
If ($err –notlike "Ok.") {
	Write-host "Array Line 0: " $err[0]
	Write-host "Array Line 1: " $err[1]
	Write-host "Array Line 2: " $err[2]
	Write-host "Array Line 3: " $err[3]
	Write-host ""
	Write-host "Error Processing netsh command:" $err[1]
}


###################################################################
# Example Of Using the -WhatIf Trigger
###################################################################
Get-service "Windows Update"
Stop-service "Windows Update" –WhatIf
Get-service "Windows Update"


###################################################################
# Example Of Creating A User Array - Validating Arrays
###################################################################
$array = "user.name", "joe.user", "jane.doe"
$array


###################################################################
# Example Of Counting an Array- Validating Variables
###################################################################
$services = get-service
$service.count
$services.count




c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_07_code.ps1
************************************************************************
﻿###################################################################
# Chapter 7 - Code File
###################################################################

###################################################################
# Example On How To Enable Kerberos for the use with WinRM
###################################################################
winrm set winrm/config/service/auth @{Kerberos="true"}


###################################################################
# Example On How To Accept WinRM Traffic over HTTP
###################################################################
winrm create winrm/config/Listener?Address=*+Transport=HTTP 


###################################################################
# Example On How To Accept WinRM Traffic over HTTPS
###################################################################
winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname="Host Computer";CertificateThumbprint=" 40-digit hex string thumbprint"}


###################################################################
# Example On How To Quick Configure WS-MAN
###################################################################
Set-WsManQuickConfig


###################################################################
# Example On How To Enable and Disable PS Remoting on a system
###################################################################
Enable-PSRemoting –SkipNetworkProfileCheck –Force
Disable-PSRemoting –force


###################################################################
# Example On How To Create a CIM Session
###################################################################
new-cimsession


###################################################################
# Example On How To Create a Multiple Sessions Grouped by a single name.
###################################################################
new-cimsession –computername Localhost,localhost,localhost –name LocalSessions


###################################################################
# Example On How To Create New CimSessionOptions and use them with a session
###################################################################
$sessionoptions = new-cimsessionoption –protocol DCOM
New-cimsession –sessionoption $sessionoptions –computername Localhost,localhost,localhost –name LocalSessions


###################################################################
# Example On How To Retrieve a New Session
###################################################################
New-cimsession
$newsession = get-cimsession
$newsession


###################################################################
# Example On How To Launch a Calculator on a Remote System
###################################################################
New-cimsession –name MyComputer
$newsession = get-cimsession –Name MyComputer
Invoke-cimmethod –cimsession $newsession –class win32_process –MethodName Create –Argument @{CommandLine='calc.exe';CurrentDirectory="c:\windows\system32"}


###################################################################
# Example On How To Remove a CIM Session
###################################################################
new-cimsession –Name MySession
remove-cimsession –Name MySession
get-cimsession



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_08_code.ps1
************************************************************************
﻿###################################################################
# Chapter 8 - Code File
###################################################################


###################################################################
# Example On How To Create a Folder and Registry Item
###################################################################
New-item –path "c:\Program Files\" -name MyCustomSoftware –ItemType Directory
New-item –path HKCU:\Software\MyCustomSoftware\ -force


###################################################################
# Example On How To Create Files Leveraging Triggers
###################################################################
$logpath = "c:\Program Files\MyCustomSoftware\Logs\"
New-item –path $logpath –ItemType Directory | out-null
$itemname = (get-date –format "yyyyMMddmmss") + "MyLogFile.txt"
$itemvalue = "Starting Logging at: " + " " + (get-date)
New-item –path $logpath -name $itemname –ItemType File –value $itemvalue
$logfile = $logpath + $itemname
$logfile


###################################################################
# Example On How To Create Registry Properties
###################################################################
$regpath = "HKCU:\Software\MyCustomSoftware\"
$regname = "BuildTime"
$regvalue = "Build Started At: " + " " + (get-date)
New-itemproperty –path $regpath –name $regname –PropertyType String –value $regvalue
$verifyValue = Get-itemproperty –path $regpath –name $regname
Write-Host "The $regName named value is set to: " $verifyValue.$regname


###################################################################
# Example On How To Verify Files, Folders, and Registry Items
###################################################################
$testfolder = test-path "c:\Program Files\MyCustomSoftware\Logs"
#Update The Following Line with the Date/Timestamp of your file
$testfile = test-path "c:\Program Files\MyCustomSoftware\Logs\201503163824MyLogFile.txt"
$testreg = test-path "HKCU:\Software\MyCustomSoftware\"
If ($testfolder) { write-host "Folder Found!" }
If ($testfile) { write-host "File Found!" }
If ($testreg) { write-host "Registry Key Found!" }


###################################################################
# Example On How To Copy and Move Files
###################################################################
New-item –path "c:\Program Files\MyCustomSoftware\AppTesting" –ItemType Directory | Out-null
New-item –path "c:\Program Files\MyCustomSoftware\AppTesting\Help" -ItemType Directory | Out-null
New-item –path "c:\Program Files\MyCustomSoftware\AppTesting\" –name AppTest.txt –ItemType File | out-null
New-item –path "c:\Program Files\MyCustomSoftware\AppTesting\Help\" –name HelpInformation.txt –ItemType File | out-null
New-item –path "c:\Program Files\MyCustomSoftware\" -name ConfigFile.txt –ItemType File | out-null
move-item –path "c:\Program Files\MyCustomSoftware\AppTesting" –destination "c:\Program Files\MyCustomSoftware\Archive" –force
copy-item –path "c:\Program Files\MyCustomSoftware\ConfigFile.txt" "c:\Program Files\MyCustomSoftware\Archive\Archived_ConfigFile.txt" –force


###################################################################
# Example On How To Rename Files and Folders
###################################################################
New-item –path "c:\Program Files\MyCustomSoftware\OldConfigFiles\" –ItemType Directory | out-null
Rename-item –path "c:\Program Files\MyCustomSoftware\OldConfigFiles" –newname "c:\Program Files\MyCustomSoftware\ConfigArchive" -force
copy-item –path "c:\Program Files\MyCustomSoftware\ConfigFile.txt" "c:\Program Files\MyCustomSoftware\ConfigArchive\ConfigFile.txt" –force
Rename-item –path "c:\Program Files\MyCustomSoftware\ConfigArchive\ConfigFile.txt" –newname "c:\Program Files\MyCustomSoftware\ConfigArchive\Old_ConfigFile.txt" –force


###################################################################
# Example On How To Rename Registry Keys
###################################################################
New-item –path "HKCU:\Software\MyCustomSoftware\" –name CInfo –force | out-null
Rename-item –path "HKCU:\Software\MyCustomSoftware\CInfo" –newname ConnectionInformation –force


###################################################################
# Example On How To Rename Registry Properties
###################################################################
$regpath = "HKCU:\Software\MyCustomSoftware\ConnectionInformation"
$regname = "DBServer"
$regvalue = "mySQLserver.mydomain.local"
New-itemproperty –path $regpath –name $regname –PropertyType String –value $regvalue | Out-null
Rename-itemproperty –path $regpath –name DBServer –newname DatabaseServer


###################################################################
# Example On How To Delete Files - Part 1 - Staging New Files
###################################################################
# Create New Directory
new-item –path "c:\program files\MyCustomSoftware\Graphics\" –ItemType Directory | Out-null
# Create Files for This Example
new-item –path "c:\program files\MyCustomSoftware\Graphics\" –name FirstGraphic.bmp –ItemType File | Out-Null
new-item –path "c:\program files\MyCustomSoftware\Graphics\" –name FirstGraphic.png –ItemType File | Out-Null
new-item –path "c:\program files\MyCustomSoftware\Graphics\" –name SecondGraphic.bmp –ItemType File | Out-Null
new-item –path "c:\program files\MyCustomSoftware\Graphics\" –name SecondGraphic.png –ItemType File | Out-Null
new-item –path "c:\program files\MyCustomSoftware\Logs\" –name 201301010101LogFile.txt –ItemType File | Out-Null
new-item –path "c:\program files\MyCustomSoftware\Logs\" –name 201302010101LogFile.txt –ItemType File | Out-Null
new-item –path "c:\program files\MyCustomSoftware\Logs\" –name 201303010101LogFile.txt –ItemType File | Out-Null
# Create New Registry Keys and Named Values
New-item –path "HKCU:\Software\MyCustomSoftware\AppSettings" | Out-null
New-item –path "HKCU:\Software\MyCustomSoftware\ApplicationSettings" | Out-null
New-itemproperty –path "HKCU:\Software\MyCustomSoftware\ApplicationSettings" –name AlwaysOn –PropertyType String –value True | Out-null
New-itemproperty –path "HKCU:\Software\MyCustomSoftware\ApplicationSettings" –name AutoDeleteLogs –PropertyType String –value True | Out-null



###################################################################
# Example On How To Delete Files - Part 2 - Deleting Files
###################################################################
# Get Current year
$currentyear = get-date –f yyyy
# Build the Exclude String
$exclude = "*" + $currentyear + "*"
# Remove Items from System
Remove-item –path "c:\Program Files\MyCustomSoftware\Graphics\" –include *.bmp –force -recurse
Remove-item –path "c:\Program Files\MyCustomSoftware\Logs\" –exclude $exclude -force –recurse
Remove-itemproperty –path "HKCU:\Software\MyCustomSoftware\ApplicationSettings" –Name AutoDeleteLogs
Remove-item –path "HKCU:\Software\MyCustomSoftware\ApplicationSettings"



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_09_code.ps1
************************************************************************
﻿###################################################################
# Chapter 9 - Code File
###################################################################


###################################################################
# Setup the Computer System for the Examples in this Chapter
###################################################################
# If the files, folders, and registry items don’t exist, create them.
if (!(test-path "HKCU:\Software\MyCustomSoftware\ConnectionInformation")) { New-item –path "HKCU:\Software\MyCustomSoftware\ConnectionInformation" -force | out-null  }
if (!(test-path "HKCU:\Software\MyCustomSoftware\AppSettings")) { New-item –path "HKCU:\Software\MyCustomSoftware\AppSettings" -force | out-null   }
if (!(test-path "c:\Program Files\MyCustomSoftware\Graphics\")){ New-item –path "c:\Program Files\MyCustomSoftware\" -name Graphics –ItemType Directory | out-null  }
if (!(test-path "c:\Program Files\MyCustomSoftware\Logs\")){ New-item –path "c:\Program Files\MyCustomSoftware\" -name Logs –ItemType Directory | out-null  }
if (!(test-path "c:\Program Files\MyCustomSoftware\Graphics\FirstGraphic.png")) { New-item –path "c:\Program Files\MyCustomSoftware\Graphics\" -name "FirstGraphic.png" –ItemType File | out-null  }
if (!(test-path "c:\Program Files\MyCustomSoftware\Graphics\SecondGraphic.png")) { New-item –path "c:\Program Files\MyCustomSoftware\Graphics\" -name "SecondGraphic.png" –ItemType File | out-null }


###################################################################
# Example On How To View Attributes of Folders and Attributes
###################################################################
$regItem = get-item –path "HKCU:\Software\MyCustomSoftware\"
$regItem
$regChildItem = get-childitem –path "HKCU:\Software\MyCustomSoftware\"
$regChildItem
$dirItem = get-item –path "c:\Program Files\MyCustomSoftware\Graphics\"
$dirItem
$dirChildItem = get-childitem –path "c:\Program Files\MyCustomSoftware\Graphics\"
$dirChildItem


###################################################################
# Example On How To View Extended Attributes
###################################################################
get-item –path "c:\Program Files\MyCustomSoftware\Graphics\FirstGraphic.png" | get-member


###################################################################
# Example On How To Set Mode and Extended File and Folder Attributes
###################################################################
# Get file attributes
$file = get-item –path "c:\Program Files\MyCustomSoftware\Graphics\FirstGraphic.png"
$attributes = $file.attributes
$attributes
# Append ReadOnly attribute to existing attributes
$newattributes = "$attributes, ReadOnly"
# Write over existing attributes with new attributes
$file.attributes = $newattributes
$file.attributes


###################################################################
# Example On How To Remove Mode and Extended File and Folder Attributes
###################################################################
# Get File Attributes
$file = get-item –path "c:\Program Files\MyCustomSoftware\Graphics\FirstGraphic.png"
$attributes = $file.attributes
# Convert attributes to string
$attributes = $attributes.tostring()
# Split individual attributes into array
$attributes = $attributes.split(",")
# Read through the individual attributes
Foreach ($attribute in $attributes) {
	# If read Only, skip
	if ($attribute –like "*ReadOnly*") { 
write-host "Skipping Attribute: $attribute" 
}
# Else add attribute to attribute list
	else { 
$newattribute += "$attribute," 
Write-Host "Attribute Added: $attribute"
}
}
# Remove the trailing comma
$newattribute = $newattribute.trimend(",")
# Write over existing attributes with new attributes
$file.attributes = $newattribute
Write-host "New File attributes are: " $file.attributes


###################################################################
# Example On How To Copy Access Control Lists
###################################################################
# Get the existing ACL on the FirstGraphic.png file
$fileACL = get-acl –path "c:\Program Files\MyCustomSoftware\Graphics\FirstGraphic.png"
# Set the ACL from FirstGraphic.png on SecondGraphic.png 
Set-acl –path "c:\Program Files\MyCustomSoftware\Graphics\SecondGraphic.png" –aclobject $fileACL
# Get the existing ACL on the Logs directory
$dirACL = get-acl –path "c:\Program Files\MyCustomSoftware\Logs"
# Set the ACL from the Logs directory on the Graphics directory
Set-acl –path "c:\Program Files\MyCustomSoftware\Graphics" –aclobject $dirACL
# Get the existing ACL from the ConnectionInformation key
$regACL = get-acl –path "HKCU:\Software\MyCustomSoftware\ConnectionInformation"
# Set the ACL from ConnectionInformation on the AppSettings key
Set-acl –path "HKCU:\Software\MyCustomSoftware\AppSettings" –aclobject $regACL



###################################################################
# Example On How To Set Permissions on a Folder / Access Control List Modification
###################################################################
# Get the ACL from the Graphics directory
$ACL = Get-Acl "c:\program files\MyCustomSoftware\Graphics"
# Search the updated ACL for the Everyone group
$ACL.access | where { $_.IdentityReference –contains "Everyone" }
# Populate group variable for permissions
$group = "Everyone"
# Populate the permissions variable for setting permissions
$permission = "FullControl, Synchronize"
# Designate the inheritance information for permissions
$inherit = [system.security.accesscontrol.InheritanceFlags]"ContainerInherit, ObjectInherit"
# Designate the propagation information for permission propagation
$propagation = [system.security.accesscontrol.PropagationFlags]"None"
# Set to Allow Permissions
$accesstype = "Allow"
# Create the New Access Control list Rule
$Rule = New-Object system.security.accesscontrol.filesystemaccessrule($group,$permission,$inherit,$propagation,$accesstype)
# Merge new permissions with the existing ACL object
$ACL.SetAccessRule($RULE)
# Set the ACL on folder
Set-Acl -path "c:\program files\MyCustomSoftware\Graphics" -aclobject $Acl
# Get Updated ACL on folder
$ACL = Get-Acl "c:\program files\MyCustomSoftware\Graphics"
# Search the updated ACL for the Everyone group
$ACL.access | where { $_.IdentityReference –contains "Everyone" }


###################################################################
# Example On How To Set Permissions on a Registry Key / Access Control List Modification
###################################################################
# Get the ACL from the ConnectionInformation registry key
$ACL = Get-Acl "HKCU:\Software\MyCustomSoftware\ConnectionInformation"
# Search the updated ACL for the Everyone group
$ACL.access | where { $_.IdentityReference –contains "Everyone" }
# Populate group variable for permissions
$group = "Everyone"
# Populate the permissions variable for setting permissions
$permission = "FullControl"
# Set to Allow Permissions
$accesstype = "Allow"
# Create the New Access Control list Rule
$Rule = New-Object system.security.accesscontrol.RegistryAccessrule($group,$permission,$accesstype)
# Merge new permissions with the existing ACL object
$ACL.SetAccessRule($RULE)
# Set the ACL on registry key
Set-Acl -path "HKCU:\Software\MyCustomSoftware\ConnectionInformation" -aclobject $Acl
# Get Updated ACL on registry key
$ACL = Get-Acl "HKCU:\Software\MyCustomSoftware\ConnectionInformation"
# Search the updated ACL for the Everyone group
$ACL.access | where { $_.IdentityReference –contains "Everyone" }



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_11_code.ps1
************************************************************************
﻿###################################################################
# Chapter 11 - Code File
###################################################################

###################################################################
# Quick Reference to Create the XML file for this chapter. 
###################################################################
$xmlcontent = "<?xml version=`"1.0`"?>`r`n"
$xmlcontent += "`r`n"
$xmlcontent += "<settings>`r`n"
$xmlcontent += "`r`n"
$xmlcontent += "<db dbserver=`"myserver.domain.local`">MainDB</db>`r`n"
$xmlcontent += "`r`n"
$xmlcontent += "<user username=`"john.doe`" permissions=`"Read-Only`"></user>`r`n"
$xmlcontent += "<user username=`"jane.doe`" permissions=`"Administrator`"></user>`r`n"
$xmlcontent += "<user username=`"joe.user`" permissions=`"Read-Only`"></user>`r`n"
$xmlcontent += "`r`n"
$xmlcontent += "</settings>`r`n"
New-item –path "c:\Program Files\MyCustomSoftware2\" -ItemType Directory
New-item –path “c:\Program Files\MyCustomSoftware2\” –ItemType File –Name “Answers.XML” –value $xmlcontent 


###################################################################
# Example On How To use get-content to retrieve XML data
###################################################################
$xmlfile = "c:\Program Files\MyCustomSoftware2\Answers.xml"
$xml = [xml] (get-content $xmlfile)
$xml


###################################################################
# Example On How To use dot notation to navigate different attributes
###################################################################
$xml.xml
$xml.settings
$xml.settings.db
$xml.settings.user


###################################################################
# Example On How To use getelementsbytagname to view attributes
###################################################################
$xml.GetElementsByTagName("db")
$xml.GetElementsByTagName("db").dbserver


###################################################################
# Example On How To use getelementsbytagname to view elements
###################################################################
$xml.GetElementsByTagName("db")
$xml.GetElementsByTagName("db")."#text"


###################################################################
# Example On How To Read Multiple Tags with the same Tag Name
###################################################################
$users = $xml.GetElementsByTagName("user")
Foreach ($user in $users) {
	Write-host "Username: " $user.username
	Write-host "Permission: " $user.permissions
	Write-host ""
}


###################################################################
# Example On How To Add Attributes to An XML Tag
###################################################################
$xmlfile = "c:\Program Files\MyCustomSoftware2\Answers.xml"
[xml]$xml = get-content $xmlfile
$addxml = $xml.CreateElement("user")
$addxml.SetAttribute("username","john.smith")
$addxml.SetAttribute("permissions","Administrator")
$xml.Settings.AppendChild($addxml)
$xml.save($xmlfile)


###################################################################
# Example On How To Create a new tag and add Inner XML Data.
###################################################################
$xmlfile = "c:\Program Files\MyCustomSoftware2\Answers.xml"
[xml]$xml = get-content $xmlfile
$addxml = $xml.CreateElement("webserver")
$addxml.set_InnerXML("MyWebServer.domain.local")
$xml.Settings.AppendChild($addxml)
$xml.save($xmlfile)


###################################################################
# Example On How To Modify Attributes of a tag from an XML file
###################################################################
$xmlfile = "c:\Program Files\MyCustomSoftware2\Answers.xml"
[xml]$xml = get-content $xmlfile
$findtag = $xml.settings.user | where {$_.username –match "jane.doe"}
$findtag
$findtag.SetAttribute("permissions","Read-Only")
$findtag
$xml.save($xmlfile) 


###################################################################
# Example On How To Modify XML Elements from an XML file
###################################################################
$xmlfile = "c:\Program Files\MyCustomSoftware2\Answers.xml"
[xml]$xml = get-content $xmlfile
$findtag = $xml.settings.db | where {$_."#text" –match "MainDB"}
$findtag
$findtag.set_InnerXML("MainDatabase")
$findtag 
$xml.save($xmlfile)


###################################################################
# Example On How To Remove an XML Tag from an XML file
###################################################################
$xmlfile = "c:\Program Files\MyCustomSoftware2\Answers.xml"
[xml]$xml = get-content $xmlfile
$findtag = $xml.settings.user | where {$_.username –match "john.doe"}
$xml.settings.RemoveChild($findtag)
$xml.save($xmlfile)



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_12_code.ps1
************************************************************************
﻿###################################################################
# Chapter 12 - Code File
###################################################################

###################################################################
# Example On How To Create Local Users with a function
###################################################################
$computername = [system.net.dns]::GetHostName()
Function create-user { param($Computer, $username, $password)
$ADSI = [ADSI]"WinNT://$Computer"
$user = $ADSI.Create("User", $username)
$user.setpassword("$Password")
$user.setinfo()
}
create-user $computername "svcLocalAccount" "P@ssw0rd"
create-user $computername "remLocalAccount" "P@ssw0rd"


###################################################################
# Example On How To Delete Local Users with a function
###################################################################
$computername = [system.net.dns]::GetHostName()
Function delete-user { param($Computer, $username)
$ADSI = [ADSI]"WinNT://$Computer"
$ADSI.Delete("user", "$username")
}
delete-user $computername "remLocalAccount"


###################################################################
# Example On How To Create Local Groups with a Function
###################################################################
Function create-group{ param($computer, $groupname, $description)
$ADSI = [ADSI]"WinNT://$Computer"
$Group = $ADSI.Create("Group", $groupname)
$Group.setinfo()
$Group.Description = "$description"
$Group.setinfo()
}
# Create the MyLocalGroup
create-group $computername "MyLocalGroup" "This is a test local group"
# Create the remLocalGroup
create-group $computername "remLocalGroup" "This is a test local group"


###################################################################
# Example On How To Delete Local Groups with a Function
###################################################################
$computername = [system.net.dns]::GetHostName()
Function delete-group { param($computer, $groupname)
$ADSI = [ADSI]"WinNT://$Computer"
$ADSI.Delete("Group", $groupname)
}
# Delete the local group remLocalGroup
delete-group $computername "remLocalGroup"


###################################################################
# Example On How To Add  Members From A Group
###################################################################
$computername = [system.net.dns]::GetHostName()
Function add-groupmember { param($computer, $user, $groupname)
$userADSI = ([ADSI]"WinNT://$computer/$user").path
$group = [ADSI]"WinNT://$computer/$groupname, group"
	$group.Add($userADSI)
}
add-groupmember $computername "svcLocalAccount" "MyLocalGroup"
add-groupmember $computername "svcLocalAccount" "Administrators"


###################################################################
# Example On How To Remove Members From A Group
###################################################################
$computername = [system.net.dns]::GetHostName()
Function delete-groupmember { param($computer, $user, $groupname)
$userADSI= ([ADSI]"WinNT://$computer/$user").path
$group = [ADSI]"WinNT://$computer/$groupname, group"
	$group.Remove($userADSI)
}
delete-groupmember $computername "svcLocalAccount" "Administrators"


###################################################################
# Example On How To Determine if A User or Group Exists
###################################################################
$computername = [system.net.dns]::GetHostName()
Function get-ADSISearch { param($computer, $objecttype, $object)
$test = [ADSI]::Exists("WinNT://$computer/$object, $objecttype")
If ($test) { Write-host "Local $objecttype Exists. Test Variable Returned: $test" }
If (!$test) { Write-host "Local $objecttype Does Not Exist. Test Variable Returned: $test" }
}
get-ADSISearch $computername "User" "svcLocalAccount"
get-ADSISearch $computername "Group" "MyLocalGroup"
get-ADSISearch $computername "Group" "NotARealGroup"

###################################################################
# Example On How To Enumerate the local group members 
###################################################################
$computername = [system.net.dns]::GetHostName()
Function get-groupmember { param($computer,$groupname)
    $group = [ADSI]"WinNT://$computer/$groupname"
    @($group.Invoke("Members")) | foreach { $_.GetType().InvokeMember("Name",'GetProperty',$null, $_, $null) }
}
$members = get-groupmember $computername "MyLocalGroup"
Write-host "The members for MyLocalGroup are: $members"
$members = get-groupmember $computername "Administrators"
Write-host "The members for Administrators are: $members"


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
stop-service –DisplayName "Windows Audio"
Set-service –name "Audiosrv" –Description "My New Windows Audio Description."
(get-wmiobject win32_service –filter "DisplayName='Windows Audio'").description
Set-service –name "Audiosrv" –Description $olddesc
(get-wmiobject win32_service –filter "DisplayName='Windows Audio'").description
start-service –DisplayName "Windows Audio"


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
get-process -id $process.id –FileVersionInfo


###################################################################
# Example On How To View the Modules of a Process
###################################################################
$process = get-process powersh*
$modules = get-process -id $process.id –module
$modules.count


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
# Example On How To Query the Windows Features
###################################################################
$featureinfo = get-WindowsFeature | Where {$_.DisplayName -match "Telnet"}
foreach ($feature in $featureinfo) {
    Write-host "Feature Display Name:" $feature.DisplayName
    Write-host "Feature Name:" $feature.Name
    Write-host "Feature Install State:" $feature.InstallState
    Write-host ""
}


###################################################################
# Example On How To Install Windows Features
###################################################################
Install-windowsFeature -name Telnet-Client -IncludeAllSubFeature -IncludeManagementTools
install-windowsFeature -name Telnet-Server -IncludeAllSubFeature –IncludeManagementTools


###################################################################
# Example On How To Uninstall Windows Features
###################################################################
Uninstall-WindowsFeature -Name "Telnet-Server"
uninstall-WindowsFeature -Name "Telnet-Client"





c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_13_code.ps1
************************************************************************
﻿###################################################################
# Chapter 13 - Code File
###################################################################

###################################################################
# Example On How To Launch PowerShell with the Remote Signed Execution Policy
###################################################################
$filepath = "powershell.exe"
$arguments = "-ExecutionPolicy RemoteSigned"
start-process –filepath $filepath –Verb RunAs -ArgumentList $arguments


###################################################################
# Example On How To use invoke-item to start a program
###################################################################
invoke-item "c:\windows\system32\calc.exe"


###################################################################
# Example On How To use invoke expression to ping the local system.
###################################################################
$string = “ping 127.0.0.1”
invoke-expression $string


###################################################################
# Contents of c:\temp\scripts\MasterScript.ps1
###################################################################
function wh { param([string]$message)
    write-host “Wh Function Output is: $message"
}
write-host "MasterScript.ps1: Launching Child Script..."
invoke-expression -command c:\temp\scripts\childscript.ps1


###################################################################
# Contents of c:\temp\scripts\ChildScript.ps1
###################################################################
wh "From ChildScript.ps1: The wh Function resides in MasterScript.ps1 file."
wh "From ChildScript.ps1: Childscript.ps1 is accessing the wh Function successfully from memory."
pause


###################################################################
# Example On How To Invoke the master script 
###################################################################
invoke-expression -command c:\temp\scripts\masterscript.ps1 


###################################################################
# Example On How To Create a configuration item
###################################################################
configuration InstallTelnet {
    param($computers)
    Node $computers {
        WindowsFeature Telnet-Client
        {
            Name = "TelnetClient"
            Ensure = "Present"
            IncludeAllSubFeature = "True"        
        }
    }

}


###################################################################
# Example On How To Create a configuration item for Telnet Client 
# and Server using Desired Configuration Management
###################################################################
configuration InstallTelnet {
    param($computers)
    Node $computers {
        WindowsFeature Telnet-Client
        {
            Name = "TelnetClient"
            Ensure = "Present"
            IncludeAllSubFeature = "True"        
        }
        WindowsFeature Telnet-Server
        {
            Name = "TelnetServer"
            Ensure = "Present"
            IncludeAllSubFeature = "True"  
            DependsOn = "[WindowsFeature]Telnet-Client" 
        }
    }

}
$computer = $env:computername
InstallTelnet -computers $computer


###################################################################
# Example On How To Push a DSM Configuration to a system.
###################################################################
start-DscConfiguration -path .\InstallTelnet -wait -force


###################################################################
# Example On How To View the Desired State Configuration On A System
###################################################################
get-dscconfiguration


###################################################################
# Example On How To Restore a Desired State Configuration On A System
###################################################################
Remove-WindowsFeature -name Telnet-Server
write-host "Telnet-Server Feature Has Been Manually Removed From The System"
$testresult = test-dscconfiguration
if ($testresult -like "False") { 
    Restore-dscconfiguration 
}
$testresult = test-dscconfiguration
if ($testresult -like "True") { 
    write-host "Telnet-Server Successfully Restored on The System" 
}



c:\users\rocky\desktop\powershell books examples\powershell automating administrative tasks\PowerShell_Automating Administrative Tasks_Code\Module 3\Chapter_14_code.ps1
************************************************************************
﻿###################################################################
# Chapter 14 - Code File
###################################################################


###################################################################
# Example On How To Create a Sample Header
###################################################################

<#
.SYNOPSIS
This script scans the network file shares for clear text files, and determined if there
are clear text username and passwords in the files.

.DESCRIPTION
This script scans the network file shares for clear text files, and determined if there
are clear text username and passwords in the files. 

Author: Brenton J.W. Blawat / Packt Publishing / Author / email@email.com
Revision: 1.3a - Initial Release of Script / 5-27-2016
Revision: 1.4 - Paul Brandes / Company XYZ / Consultant / email@company.com / 10-27-2016
R1.4 Details: Corrected the scanning function to accommodate large UNC paths and process 
paths over 248 character

.PARAMETER PATH
The optional path parameter enables you to specify a path to the file structure to scan.

.EXAMPLE
powershellscript.ps1 /path \\uncpath\folder\

.NOTES
You must have administrative rights to the paths you are scanning. You must run the script
in an Administrator powershell window.
#>


