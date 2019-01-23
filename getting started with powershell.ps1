
c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_06_Code\datefolder.ps1
************************************************************************
﻿cd (new-item -ItemType Directory -Path c:\temp\$(get-date -format yyyyMMdd) )



c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_06_Code\ForEach.ps1
************************************************************************
﻿ForEach($file in (dir c:\temp -file)){
    write-output $file.Extension
}


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_06_Code\IfElse.ps1
************************************************************************
﻿Param($number)
if($number -eq 5){
    write-Output 'You guessed the magic number'
} else 
{
  write-output 'You did not guess it, you lose'
}


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_06_Code\IfElseIf.ps1
************************************************************************
﻿$weekDay=Get-Date | select-Object -ExpandProperty DayOfWeek
if($weekDay -eq 'Saturday'){
    write-host '2 days of weekend left'
} elseif ($weekday -eq 'Sunday'){
    write-host '1 day of weekend left'
} else {
    write-host 'Have to go to work today!'
}


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_06_Code\IfStatement.ps1
************************************************************************
﻿Param($number)
if($number -eq 5){
    write-Output 'You guessed the magic number'
}


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_06_Code\mdAndGo.ps1
************************************************************************
﻿Param($path)
new-item -ItemType Directory -Name $path
cd $path


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_06_Code\SetName.ps1
************************************************************************
﻿$name='Mike'
write-host "Your name is $name"


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_07_Code\get-average.ps1
************************************************************************
﻿function get-average{
param([int]$a,[int]$b)
   return ($a+$b)/2
}


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_07_Code\GetGreetingFunction.ps1
************************************************************************
﻿function get-greeting{
Param($subject='World')
   write-host "Hello $subject"
} 


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_07_Code\MdAndGo.ps1
************************************************************************
﻿function MdAndGo{
    Param($path)
    new-item -ItemType Directory -path $path
    cd $path
}



c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_07_Code\MdAndGo_2.ps1
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



c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_07_Code\MultipleOutput.ps1
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


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_07_Code\OutputFunctions.ps1
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


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_07_Code\testPathsFunction.ps1
************************************************************************
﻿function test-paths{
Param([string]$path1,[string]$path2)

    return (test-path $path1) -and (test-path $path2)
}


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_07_Code\TestSwichFunction.ps1
************************************************************************
﻿function test-switch{
param([switch]$MySwitch)
    if ($MySwitch){
        write-host 'You used the switch'
    } else {
        write-host 'You didn''t use the switch'
    }
 }


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_08_Code\AreaFunctions.ps1
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


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_09_Code\ExportCSVExample.ps1
************************************************************************
﻿dir c:\temp | select-object -Property Name,Length |
   Export-csv C:\temp\FileList.csv


c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_09_Code\GetContentExample.ps1
************************************************************************
﻿$servers=get-content servers.txt
foreach($server in $servers){
    get-service -Name MSSQLSERVER -ComputerName $server
}



c:\users\rocky\desktop\powershell books examples\getting started with powershell\B04691_11_Code\Code\GetWebAppPool.ps1
************************************************************************
﻿function Get-WebAppPool{
param([string]$name)
    if($name){
        dir IIS:\AppPools | where Name -like $name
    } else {
        dir IIS:\AppPools
    }
}

