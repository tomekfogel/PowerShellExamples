
c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Liesmich.txt
************************************************************************
Sie sollten 4 ZIP Dateien sehen:

* Windows PowerShell - DE.zip
Beinhaltet das deutsche Handbuch zum ersten Windows PowerShell Workshop: 
"Einführung in die Windows PowerShell" (im PDF und XPS Format) 

* Windows PowerShell - DE-2.zip
Beinhaltet das deutsche Handbuch zum zweiten Windows PowerShell Workshop: 
"Administrative Aufgaben mit Windows PowerShell" (im PDF und XPS Format)

* Workshop1.zip
Beinhaltet alle Übungsaufgaben zum ersten Workshop und dazu:
- Eine TXT Datei mit allen Source Codes

* Workshop2.zip
Beinhaltet alle Übungsaufgaben zum zweiten Workshop und dazu:
- Eine TXT Datei mit allen Source Codes
- Eine TXT Datei mit Links zu kostenloser Zusatzsoftware, die Sie für den Workshop
  brauchen und herunterladen sollten

Sie finden alle weiteren Anleitungen in den jeweiligen Workshop-Handbüchern.
Es wird empfohlen, die Aufgaben in der angegebenen Reihenfolge durchzuführen.

Fragen oder Anregungen? Nehmen Sie mit mir Kontakt auf: 
frankoch@microsoft.com 		oder		http://frankoch.com





c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop1\Files\Files1.txt
************************************************************************
get-childitem fk:\dateien | select-object extension | sort-object extension -unique `
| foreach-object {new-item ("fk:\dateien\restored_" + $_.extension) -type directory}


c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop1\Files\Files2.txt
************************************************************************
get-childitem fk:\dateien | where-object {$_.mode -notmatch "d"} | foreach-object {$b= `
"fk:\dateien\Restored_" + $_.extension; move-item $_.fullname $b}



c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop1\Files\get-service-ps1.txt
************************************************************************
get-service | ConvertTo-Html -Title "Get-Service" -Body "<H2>The result of get-service</H2> " -Property Name,Status | 
foreach {if($_ -like "*<td>Running</td>*"){$_ -replace "<tr>", "<tr bgcolor=green>"}elseif($_ -like "*<td>Stopped</td>*"){$_ -replace "<tr>", "<tr bgcolor=red>"}else{$_}}   >  fk:\get-service.html


c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop1\Files\hilfe.txt
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop1\Files\Master.txt
************************************************************************
[Setzen des Pfads]

New-PSDrive -name FK -PSProvider FileSystem -root c:\users\frankoch\downloads\Powershell


[Demo zum Anfang]

"Hello World"


[Logfiles Analyse]

dir $env:windir\*.log | select-string -List error | format-table path,linenumber –autosize


[RSS Feed]

([xml](new-object net.webclient).DownloadString( "http://blogs.msdn.com/powershell/rss.aspx")).rss.channel.item | format-table title,link



[WinForms]

[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
$form = new-object Windows.Forms.Form
$form.Text = "My First Form"
$button = new-object Windows.Forms.Button
$button.text="Push Me!"
$button.Dock="fill"
$button.add_click({$form.close()})
$form.controls.add($button)
$form.Add_Shown({$form.Activate()})
$form.ShowDialog()




[Demo Service HTML in Farbe]

get-service | ConvertTo-Html -Title "Get-Service" -Body "<H2>The result of get-service</H2> " -Property Name,Status | 
foreach {if($_ -like "*<td>Running</td>*"){$_ -replace "<tr>", "<tr bgcolor=green>"}elseif($_ -like "*<td>Stopped</td>*"){$_ -replace "<tr>", "<tr bgcolor=red>"}else{$_}}   >  fk:\get-service.html



[Demo Dateien sortieren]

get-childitem fk:\dateien | select-object extension | sort-object extension -unique `
| foreach-object {new-item ("fk:\dateien\restored_" + $_.extension) -type directory}

get-childitem fk:\dateien | where-object {$_.mode -notmatch "d"} | foreach-object {$b= `
"fk:\dateien\Restored_" + $_.extension; move-item $_.fullname $b}



[Demo Excel Automatisierung]

$a = New-Object -comobject Excel.Application
$a.Visible = $True
$b = $a.Workbooks.Add()
$c = $b.Worksheets.Item(1)
$c.Cells.Item(1,1) = "Service Name"
$c.Cells.Item(1,2) = "Service Status"
$i = 2
Get-service | foreach-object{ $c.cells.item($i,1) = $_.Name; $c.cells.item($i,2) = $_.status; $i=$i+1}
$b.SaveAs("C:\Users\frankoch\Downloads\Test.xls")






c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop1\Files\Setdrive.txt
************************************************************************
New-PSDrive -name FK -PSProvider FileSystem -root c:\users\frankoch\downloads\eth


c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop1\Master-1.txt
************************************************************************
#[Erstellen eines PS Drives für spätere Übungen / Create new PS Drive for later usage]

New-PSDrive -name FK -PSProvider FileSystem -root "c:\users\frankoch\downloads\Powershell\01 Introduction"


#[Beispiele der Powerpoint Slides / Examples of PowerPoint slides]

"Hello World"


#[Logfiles Analyse / logfile analysis]

dir $env:windir\*.log | select-string -List error | format-table path,linenumber –autosize


#[RSS Feed]

([xml](new-object net.webclient).DownloadString( "http://blogs.msdn.com/powershell/rss.aspx")).rss.channel.item | format-table title,link



#[WinForms]

[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
$form = new-object Windows.Forms.Form
$form.Text = "My First Form"
$button = new-object Windows.Forms.Button
$button.text="Push Me!"
$button.Dock="fill"
$button.add_click({$form.close()})
$form.controls.add($button)
$form.Add_Shown({$form.Activate()})
$form.ShowDialog()




#[Service als HTML Seite / services as HTML page]

get-service | ConvertTo-Html -Title "Get-Service" -Body "<H2>The result of get-service</H2> " -Property Name,Status | 
foreach {if($_ -like "*<td>Running</td>*"){$_ -replace "<tr>", "<tr bgcolor=green>"}elseif($_ -like "*<td>Stopped</td>*"){$_ -replace "<tr>", "<tr bgcolor=red>"}else{$_}}   >  fk:\get-service.html



#[Dateien sortieren / sorting the files]

get-childitem fk:\Files | select-object extension | sort-object extension -unique `
| foreach-object {new-item ("fk:\Files\restored_" + $_.extension) -type directory}

get-childitem fk:\Files | where-object {$_.mode -notmatch "d"} | foreach-object {$b= `
"fk:\Files\Restored_" + $_.extension; move-item $_.fullname $b}



#[Excel Automatisierung / Excel automation]

$a = New-Object -comobject Excel.Application
$a.Visible = $True
$b = $a.Workbooks.Add()
$c = $b.Worksheets.Item(1)
$c.Cells.Item(1,1) = "Service Name"
$c.Cells.Item(1,2) = "Service Status"
$i = 2
Get-service | foreach-object{ $c.cells.item($i,1) = $_.Name; $c.cells.item($i,2) = $_.status; $i=$i+1}
$b.SaveAs("C:\Users\frankoch\Downloads\PowerShell\Test.xlsx")


#[MSAgent Peedy]

$PC = New-Object -com agent.control.2
$pc.connected = $true
[void]$pc.Characters.load("Peedy","C:\windows\MSAgent\chars\Peedy.acs")
$Peedy = $pc.Characters.Item("Peedy")
[void] $peedy.show()

[void]$peedy.moveto(100,300)

[void]$peedy.Play("GetAttention")
Start-sleep –seconds 2
[void]$Peedy.StopAll()

[void]$peedy.Play("GetAttention")
Start-sleep –seconds 2
[void]$Peedy.StopAll()

[void]$peedy.Play("Greet")
Start-sleep –seconds 2
[void]$Peedy.StopAll()

[void]$peedy.Speak("The Show starts in 5 minutes")
Start-sleep –seconds 5

[void]$peedy.Play("Greet")
Start-sleep –seconds 2
[void]$Peedy.StopAll()

[void]$peedy.Hide()




c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop2\C\Files\Files1.txt
************************************************************************
get-childitem fk:\dateien | select-object extension | sort-object extension -unique `
| foreach-object {new-item ("fk:\dateien\restored_" + $_.extension) -type directory}


c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop2\C\Files\Files2.txt
************************************************************************
get-childitem fk:\dateien | where-object {$_.mode -notmatch "d"} | foreach-object {$b= `
"fk:\dateien\Restored_" + $_.extension; move-item $_.fullname $b}



c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop2\C\Files\get-service-ps1.txt
************************************************************************
get-service | ConvertTo-Html -Title "Get-Service" -Body "<H2>The result of get-service</H2> " -Property Name,Status | 
foreach {if($_ -like "*<td>Running</td>*"){$_ -replace "<tr>", "<tr bgcolor=green>"}elseif($_ -like "*<td>Stopped</td>*"){$_ -replace "<tr>", "<tr bgcolor=red>"}else{$_}}   >  fk:\get-service.html


c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop2\C\Files\hilfe.txt
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop2\C\Files\Master.txt
************************************************************************
[Setzen des Pfads]

New-PSDrive -name FK -PSProvider FileSystem -root c:\users\frankoch\downloads\Powershell


[Demo zum Anfang]

"Hello World"


[Logfiles Analyse]

dir $env:windir\*.log | select-string -List error | format-table path,linenumber –autosize


[RSS Feed]

([xml](new-object net.webclient).DownloadString( "http://blogs.msdn.com/powershell/rss.aspx")).rss.channel.item | format-table title,link



[WinForms]

[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
$form = new-object Windows.Forms.Form
$form.Text = "My First Form"
$button = new-object Windows.Forms.Button
$button.text="Push Me!"
$button.Dock="fill"
$button.add_click({$form.close()})
$form.controls.add($button)
$form.Add_Shown({$form.Activate()})
$form.ShowDialog()




[Demo Service HTML in Farbe]

get-service | ConvertTo-Html -Title "Get-Service" -Body "<H2>The result of get-service</H2> " -Property Name,Status | 
foreach {if($_ -like "*<td>Running</td>*"){$_ -replace "<tr>", "<tr bgcolor=green>"}elseif($_ -like "*<td>Stopped</td>*"){$_ -replace "<tr>", "<tr bgcolor=red>"}else{$_}}   >  fk:\get-service.html



[Demo Dateien sortieren]

get-childitem fk:\dateien | select-object extension | sort-object extension -unique `
| foreach-object {new-item ("fk:\dateien\restored_" + $_.extension) -type directory}

get-childitem fk:\dateien | where-object {$_.mode -notmatch "d"} | foreach-object {$b= `
"fk:\dateien\Restored_" + $_.extension; move-item $_.fullname $b}



[Demo Excel Automatisierung]

$a = New-Object -comobject Excel.Application
$a.Visible = $True
$b = $a.Workbooks.Add()
$c = $b.Worksheets.Item(1)
$c.Cells.Item(1,1) = "Service Name"
$c.Cells.Item(1,2) = "Service Status"
$i = 2
Get-service | foreach-object{ $c.cells.item($i,1) = $_.Name; $c.cells.item($i,2) = $_.status; $i=$i+1}
$b.SaveAs("C:\Users\frankoch\Downloads\Test.xls")






c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop2\C\Files\Setdrive.txt
************************************************************************
New-PSDrive -name FK -PSProvider FileSystem -root c:\users\frankoch\downloads\eth


c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop2\Links-2.txt
************************************************************************
Intro
www.microsoft.com/PowerShell
http://blogs.msdn.com/PowerShell/
http://blogs.technet.com/chITPro-de

Appendix
VirtualPC & VHD for Testing
http://www.microsoft.com/windows/products/winfamily/virtualpc/default.mspx
http://www.microsoft.com/downloads/details.aspx?displaylang=de&FamilyID=04d26402-3199-48a3-afa2-2dc0b40a73b6
http://www.microsoft.com/downloads/details.aspx?FamilyID=77f24c9d-b4b8-4f73-99e3-c66f80e415b6&DisplayLang=en

Books / Bücher
http://www.microsoft-press.de/search.asp?cnt=search&s3=9783866456174
http://www.manning.com/payette/ 

**************************************************************************

A1
http://www.microsoft.com/downloads/details.aspx?FamilyId=10EE29AF-7C3A-4057-8367-C9C1DAB6E2BF&displaylang=en

B3
http://www.microsoft.com/downloads/details.aspx?FamilyID=2917a564-dbbc-4da7-82c8-fe08b3ef4e6d&DisplayLang=en

C5
http://www.xxcopy.com/xxcopy38.htm

E11
http://office.microsoft.com/de-ch/outlook/default.aspx

G
http://www.microsoft.com/msagent/downloads/user.aspx#character

H5
http://www.quest.com

H6
http://www.codeplex.com/PowerShellCX 

I1
http://www.microsoft.com/downloads/details.aspx?familyid=7287252C-402E-4F72-97A5-E0FD290D4B76&displaylang=en 

I2
http://www.powergadgets.com/

J
https://www.dellbatteryprogram.com/

K
http://www.codeplex.com/PowerShellCX
http://www.codeplex.com/PowerShellCX/Release/ProjectReleases.aspx?ReleaseId=2688

L
http://www.sdmsoftware.com

M
http://www.fullarmor.com

N
http://www.microsoft.com/downloads/details.aspx?FamilyID=220549b5-0b07-4448-8848-dcc397514b41&displaylang=en
http://www.microsoft.com/downloads/details.aspx?FamilyId=C243A5AE-4BD1-4E3D-94B8-5A0F62BF7796&DisplayLang=en
http://msdn2.microsoft.com/en-us/netframework/aa904594.aspx
http://www.microsoft.com/sql/techinfo/whitepapers/sql_2008_manageability.mspx





c:\users\rocky\desktop\powershell books examples\powershell-workshops-de\Workshop2\Master-2.txt
************************************************************************
Scripts Windows PowerShell Workshop 2
=====================================


A1
WindowsServer2003-KB926139-x86-ENU.exe /?
WindowsServer2003-KB926139-x86-ENU.exe /quiet (/norestart)

B1
Get-executionpolicy

cd hklm:
cd HKLM:\software\Microsoft\PowerShell\1\ShellIds
Get-ItemProperty .\Microsoft.PowerShell

B2
Set-Executionpolicy RemoteSigned

B4
Das Gruppenrichtlinien-Template setzt den folgenden Registry Key:
HKLM:\Software\Policies\Microsoft\Windows\PowerShell
 
C1
# Das folgende Skript analysiert einen Ausgangsordner und räumt diesen auf. 
# Hierzu werden zunächst alle Dateitypen aufgelistet und für jeden Typ
# ein eigener Ordner erstellt
# Als erstes wird ein neues PS Drive angelegt, um die Schreibarbeit zu minimieren
# Out-NUL unterdrückt unschöne Ergebnismeldungen

New-PSDrive -name FK -PSProvider FileSystem -root C:\Downloads\Files | out-Null

# Nun werden alle Dateien aufgelistet, nach deren Endung selektiert & sortiert 
# und jede Endung nur 1x ausgewählt. Anschliessend wird für jede dieser Endungen
# jeweils 1 Unterordner angelegt. Dies wird mit dem klassischen MD 
# (statt new-item) gemacht. new-item ist länger, kennt aber –force um bei bereits 
# existierenden Verzeichnissen keine Fehlermeldungen  zu verursachen.
# Daher muss man gut abwägen!
# Out-NUL unterdrückt wieder unschöne Erfolgsmeldungen

get-childitem fk:\ | sort-object extension -unique | foreach-object {
# Nach dem die neuen Ordner angelegt wurden, 
	MD ( "fk:\restored_" + $_.extension) | Out-Null }

# werden die Dateien aber nicht die Ordner! in die jeweiligen Unterordner verschoben
get-childitem fk:\ | where-object {$_.mode -notmatch "d"} | foreach-object {
	move-item $_.fullname ("fk:\Restored_" + $_.extension) }
# Hiermit ist das Skript beendet.


C2
# Die Verwendung eines PSDrives ist optional und verkürzt nur das spätere Tippen
New-PSDrive -name FK -PSProvider FileSystem -root c:\Downloads\files | out-Null
get-childitem fk:\ –recurse | where-object {$_.mode -notmatch "d"} | foreach-object {
	$_.isreadonly = 0 }

powershell.exe c:\Downloads\Scripts\C2.ps1



# C1-Prepare.ps1
dir c:\Downloads\Files -Recurse | where-object {$_.mode -notmatch "d"} | sort extension -unique | foreach { $_.IsReadOnly = $False; $_.LastAccessTime = (get-date).AddYears(-1) }
dir c:\Downloads\Files -Recurse | where-object {$_.mode -notmatch "d"} | sort extension -desc -unique | foreach { $_.IsReadOnly = $False; $_.LastAccessTime = (get-date).AddYears(-2) }

 
C3
# The scripts starts here. First check: do we have 3 parameters?
If ($Args.count –ne 3) { 
	write-warning "call the script with 3 parameter: source target date-in-months" 
} else {
If (test-path $Args[0]) { 
	If (test-path $Args[1] ) {
	$CheckDate = ((Get-date).AddMonths(- $Args[2])).ToOADate()
	Dir $args[0] -recurse | where-object {$_.mode -notmatch "d"} | foreach-object { 
		if ( ($_.LastAccessTime).ToOADate() -lt $CheckDate) { 
		$_.name + "   " + (($_.LastAccessTime))
		}
	}
} else { Write-Warning "Target path does not exists" }
} else {Write-Warning ("Source path does not exists: " + $Args[0]) } 
}


C4
# The scripts starts here. First check: do we have 3 parameters?
If ($Args.count –ne 3) { 
	write-warning "call the script with 3 parameter: source target date-in-months" 
} else {
If (test-path $Args[0]) { 
	If (test-path $Args[1] ) {
	$CheckDate = ((Get-date).AddMonths(- $Args[2])).ToOADate()
	$MyPath = $Args[1]
	Dir $args[0] -recurse | where-object {$_.mode -notmatch "d"} | foreach-object { 
		if ( ($_.LastAccessTime).ToOADate() -lt $CheckDate) { 
		$myACL = get-Acl $_.FullName
		$MyName = $MyPath + "\" + $_.Name
		Move-Item $_.FullName $MyPath
		Set-Acl $Myname $myACL
		}
	}
} else { Write-Warning "Target path does not exists" }
} else {Write-Warning ("Source path does not exists: " + $Args[0]) } 
}

 
C5
# The scripts starts here. First check: do we have 3 parameters?
If ($Args.count –ne 3) { 
	write-warning "call the script with 3 parameter: source target date-in-months" 
} else {
If (test-path $Args[0]) { 
	If (test-path $Args[1] ) {
	$CheckDate = ((Get-date).AddMonths(- $Args[2])).ToOADate()
	$MyPath = $Args[1]
	Dir $args[0] -recurse | where-object {$_.mode -notmatch "d"} | foreach-object { 
		if ( ($_.LastAccessTime).ToOADate() -lt $CheckDate) { 
		$myACL = get-Acl $_.FullName
		$MyName = $MyPath + "\" + $_.Name
		Move-Item $_.FullName $MyPath

		.\xxMkLink.exe $_.FullName $Myname /q

		Set-Acl $Myname $myACL
		$Myname = $_.FullName + ".lnk"
		Set-Acl $Myname $myACL
		}
	}
} else { Write-Warning "Target path does not exists" }
} else {Write-Warning ("Source path does not exists: " + $Args[0]) } 
}


D1
CD HKL:
CD HKLM:\Software\Microsoft
Dir W*


D2
CD HKL:
CD HKLM:\Software\Microsoft
dir W*R\*\W*

 
D3
New-Item –path "HKLM:\Software" –Name "Contoso"
New-itemproperty –literalpath "HKLM:\Software\Contoso" –Name "Appname" –Value
              "Contoso CRM" –type string
Remove-item .\contoso


D4
Cd HKLM:\Software\Microsoft\Windows\CurrentVersion
Get-itemproperty run
New-itemproperty –literalpath "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" –Name "Notepad" –Value
           "c:\windows\notepad.exe" –type string
# Beim erneuten EInloggen sollte automatisch Notepad gestartet werden.


E1
# Auslesen des Computernamens mit Hilfe von WMI Klassen
$Name = (get-wmiobject Win32_Computersystem).name
# Das HTML Skript wurde bereits im ersten Workshop hergeleitet und dort kommentiert
get-service | ConvertTo-Html -Title "Get-Service" -Body "<H2>The result of get-service</H2> " -Property Name,Status | foreach { 
if($_ -like "*<td>Running</td>*"){ 
$_ -replace "<tr>", "<tr bgcolor=green>"
} elseif ($_ -like "*<td>Stopped</td>*"){ 
$_ -replace "<tr>", "<tr bgcolor=red>" 
}else { $_} }   >  ("fk:\" + $name + ".html")



RSS-Reader
([XML](new-object net.webclient).DownloadString("http://blogs.msdn.com/powershell/rss.aspx")).rss.channel.item | format-table title, link 



E2a
[void][System.reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
$form = new-object Windows.Forms.Form
$button = new-object Windows.Forms.Button
$button.add_click({$form.close()})
$form.controls.add($button)
$form.ShowDialog()

E2b
[void][System.reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
$form = new-object Windows.Forms.Form
$button = new-object Windows.Forms.Button
$form.Text = "My First Form"
$button.text="Push Me!"
$button.Dock="fill"
$button.add_click({$form.close()})
$form.controls.add($button)
$form.ShowDialog()


E3
[void][System.reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
$form = new-object System.Windows.Forms.Form
$DataGridView = new-object System.windows.forms.DataGridView
$Form.Text = "My First Datagrid"
$array= new-object System.Collections.ArrayList
$array.AddRange( @(  get-service | write-output  ) )
$DataGridView.DataSource = $array
$DataGridView.Dock = "fill"
$DataGridView.AllowUsertoResizeColumns=$True
$form.Controls.Add($DataGridView)
$form.showdialog()

 
E4
[void][System.reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
$form = new-object System.Windows.Forms.Form
$DataGridView = new-object System.windows.forms.DataGridView
$Form.Text = "My First Datagrid"
$array= new-object System.Collections.ArrayList
$array.AddRange( @(  get-service | sort-object status | write-output  ) )
$DataGridView.DataSource = $array
$DataGridView.Dock = "fill"
$DataGridView.AllowUsertoResizeColumns=$True
$form.Controls.Add($DataGridView)
$form.showdialog()

[void][System.reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
$form = new-object System.Windows.Forms.Form
$DataGridView = new-object System.windows.forms.DataGridView
$Form.Text = "My First Datagrid"
$array= new-object System.Collections.ArrayList
$array.AddRange( @(  get-process | sort-object company | write-output  ) )
$DataGridView.DataSource = $array
$DataGridView.Dock = "fill"
$DataGridView.AllowUsertoResizeColumns=$True
$form.Controls.Add($DataGridView)
$form.showdialog()


E5
# Erstellen einer Liste mit allen Datei-Endungen
$ext = Get-ChildItem * -recurse | foreach {[System.io.path]::GetExtension($_) }
# Gruppieren der Endungen und Sortieren nach ihrer Anzahl (count)
$ext | where { $_ -ne ""} | group | sort count


E6
# Ausgabe der Endung auf Position 1
($ext | where { $_ -ne ""} | group | sort count | select -last 1).Name


E7
$newrights =  [System.Security.AccessControl.FileSystemRights]"Read, Write"
$InheritanceFlag =  [System.Security.AccessControl.InheritanceFlags]::None
$PropagationFlag =  [System.Security.AccessControl.PropagationFlags]::None
$Typ =[System.Security.AccessControl.AccessControlType]::Allow
$ID = new-object System.Security.Principal.NTAccount("Contoso\Administrator")
$SecRule =new-object  System.Security.AccessControl.FileSystemAccessRule($ID, $newrights, $InheritanceFlag, $PropagationFlag, $Typ)

$myACL = get-acl ".\c1-prepare.ps1"
$myACL.AddAccessRule($SecRule)
Set-ACL ".\c1-prepare.ps1" $myACL



E8
# Email versenden mit Hilfe von .NET
$mailserver = "contoso-dc1.contoso.local"
$Mail = New-Object System.Net.Mail.MailMessage("Info@contoso.local", "administrator@contoso.local")

$Mail.Subject = "PowerShell Information von " + (dir env:\Computername).Value

$Mail.Body = "Serveralarm auf " + (dir env:\Computername).Value + " um " + (get-date)
$Mail.IsBodyHTML = $False

$MailClient = New-Object System.Net.Mail.SmtpClient($Mailserver)
$MailClient.UseDefaultCredentials = $True
$MailClient.Send($Mail)

 

E9
# Email versenden mit Hilfe von .NET und Attachment
$mailserver = "contoso-dc1.contoso.local"
$Mail = New-Object System.Net.Mail.MailMessage("Info@contoso.local", "administrator@contoso.local")
$Mail.Subject = "PowerShell Information von " + (dir env:\Computername).Value
$Mail.Body = "Serveralarm auf " + (dir env:\Computername).Value + " um " + (get-date)
$Mail.IsBodyHTML = $False

$Attached = New-Object System.Net.Mail.Attachment("C:\boot.ini")
$Mail.Attachments.Add($Attached)

$MailClient = New-Object System.Net.Mail.SmtpClient($Mailserver)

$MailClient.UseDefaultCredentials = $False
$MailClient.Credentials = New-Object System.Net.NetworkCredential("contoso\Info", "Pass1word")

$MailClient.Send($Mail)



E10
# Email versenden mit Hilfe von .NET und Attachment
$mailserver = "contoso-dc1.contoso.local"
$Mail = New-Object System.Net.Mail.MailMessage( "Info@contoso.local", "administrator@contoso.local")
$Mail.Subject = "PowerShell Information von " + (dir env:\Computername).Value
$Mail.Body = "Serveralarm auf " + (dir env:\Computername).Value + " um " + (get-date)
$Mail.IsBodyHTML = $False

$Attached = New-Object System.Net.Mail.Attachment("C:\boot.ini")
$Mail.Attachments.Add($Attached)

$MailClient = New-Object System.Net.Mail.SmtpClient($Mailserver)

$MailClient.UseDefaultCredentials = $False
$MailClient.Credentials = New-Object System.Net.NetworkCredential("contoso\Info", "Pass1word")

$MailClient.Send($Mail)


E11
$Inbox.items | where { $_.Unread }| foreach { write-host $_.Subject }




F1
dir $env:windir\*.log | select-string error | format-table path,linenumber –autosize
# Der Parameter –list listet immer nur das erste Auftreten des Strings auf; wird er nicht gesetzt, so werden alle Positionen des Strings ausgegeben


F2
Get-eventlog "Windows PowerShell" –newest 10
Get-eventlog "Windows PowerShell" | group EventID | sort count –descending


F3
$a = new-object –type system.diagnostics.eventlog –argumentlist System
# Die Source stellt die Quelle des Events dar und kann frei (aber passend?) gewählt werden
$a.source = "Windows PowerShell Labs"
get-service | where { $_.status -eq "Stopped"} | select -first 5 | foreach { 
$a.writeentry("Service gestopped: "+ $_.Name,"Information") 
}
get-eventlog System -newest 10


G1
$Agentpath = "" + @(Join-path $env:windir "MSAgent\chars\peedy.acs")
if ((test-path $Agentpath) -eq $false) {
   write-host "Please download Peedy from www.microsoft.com/msagents"
} else {
$AgentControl = New-Object -com agent.control.2
$AgentControl.connected = $true
[void]$AgentControl.Characters.load("Peedy", $Agentpath)
$Peedy = $AgentControl.Characters.Item("Peedy")
[Void]$Peedy.Show()
[Void]$Peedy.moveto(300,300)
[void]$Peedy.Speak("I am ready, and you?")
}


G2
$PC = New-Object -com agent.control.2
$pc.connected = $true
[void]$pc.Characters.load("Peedy","C:\windows\MSAgent\chars\Peedy.acs")
$Peedy = $pc.Characters.Item("Peedy")

$Display = Get-WmiObject -class Win32_DesktopMonitor
# check if multiscreen display is enabled:
if (($display | measure-object).count -gt 1) {
	$height = $display[0].ScreenHeight - $peedy.height
	$width = $display[0].ScreenWidth - $peedy.width} else {
	$height = $display.ScreenHeight - $peedy.height
	$width = $display.ScreenWidth - $peedy.width } 
[void]$peedy.show()

[Void]$Peedy.moveto(0,0)
Start-sleep -seconds 3
[Void]$Peedy.moveto(0,$height)
Start-sleep -seconds 3
[Void]$Peedy.moveto($width,$height)
Start-sleep -seconds 3
[Void]$Peedy.moveto($width,0)
Start-sleep -seconds 3
[Void]$Peedy.moveto(0,0)



G3
# Erzeugen einer Liste aller Animationen von Peedy durch Auslesen der AnimationNames Eigenschaft des Objekts:
$Peedy.AnimationNames

# Erzeugen der Liste aller Animationen durch einfaches Aufrufen, Abspielen aller Animationen mit einer ForEach Schleife und Ausgabe des jeweiligen Animations-Namens:

$Peedy.AnimationNames | foreach {
	$_
[void]$Peedy.Play($_)
	Start-sleep –seconds 5
	[void]$Peedy.StopAll()
}



G4
# Systemmonitoring mit Peedy. Das folgende Skript erzeugt zunächst eine Peedy Instanz, stellt Peedy auf dem Bildschirm dar, erzeugt eine Liste von 5 gestoppten Services und gibt dies emit Peedy aus:
$PC = New-Object -com agent.control.2
$pc.connected = $true
[void]$pc.Characters.load("Peedy","C:\windows\MSAgent\chars\Peedy.acs")
$Peedy = $pc.Characters.Item("Peedy")
[void] $peedy.show()
[void]$peedy.moveto(100,300)


[void]$peedy.Play("GetAttention")
Start-sleep –seconds 2
[void]$Peedy.StopAll()

Get-service | where { $_.status –eq "Stopped" } | select-object –first 5 | foreach {
[void] $Peedy.Speak($_.Name)
Start-sleep –seconds 5
 [void]$Peedy.StopAll()
}
[void]$peedy.Hide()




Presentation Intro
# Load peedy as usual; no WINDIR checks!
$PC = New-Object -com agent.control.2
$pc.connected = $true

[void]$pc.Characters.load("Peedy","C:\windows\MSAgent\chars\Peedy.acs")
$Peedy = $pc.Characters.Item("Peedy")

# Move Peedy to right screen position
[void] $peedy.show()
[void]$peedy.moveto(100,300)

# Play some animation to get attention from audience
[void]$peedy.Play("GetAttention")
Start-sleep –seconds 5
[void]$Peedy.StopAll()

# show how polite Peedy can be
[void]$peedy.Play("Greet")
Start-sleep –seconds 5
[void]$Peedy.StopAll()

# spread the word: the session will start soon
[void]$peedy.Speak("The Show starts in 5 minutes")
Start-sleep –seconds 5

# say goodbye to the audience and disappear 
[void]$peedy.Play("Greet")
Start-sleep –seconds 5
[void]$Peedy.StopAll()
[void]$peedy.Hide()




# Modify Peedy Language & voice capabilities
$peedy.LanguageID=1031
$peedy.TTSModeID = "{3A1FB760-A92B-11d1-B17B-0020AFED142E}"  #  --> Anna = Frau
$peedy.TTSModeID = "{3A1FB761-A92B-11d1-B17B-0020AFED142E}"  #  --> Stefan = Mann




G5
Function   out-peedy {
$PC = New-Object -com agent.control.2
$pc.connected = $true
[void]$pc.Characters.load("Peedy","C:\windows\MSAgent\chars\Peedy.acs")
$Peedy = $pc.Characters.Item("Peedy")
 [void] $peedy.show()
[void]$peedy.moveto(100,300)
$text = "" + $Args[0]
 [void]$peedy.Speak($text)
Start-sleep –seconds 5
 [void]$Peedy.StopAll()
[void]$peedy.Hide()
}


G6
Function   out-peedy {
$PC = New-Object -com agent.control.2
$pc.connected = $true
[void]$pc.Characters.load("Peedy","C:\windows\MSAgent\chars\Peedy.acs")
$Peedy = $pc.Characters.Item("Peedy")
 [void] $peedy.show()
[void]$peedy.moveto(100,300)
$text = "" + $Args[0]
If ($Args.Count –gt 1) {
	If ($Args[1]  -match "-q") { [void]$peedy.Think($text)
} else {  [void]$peedy.Speak($text) } 
} Else {  [void]$peedy.Speak($text) } 
Start-sleep –seconds 5
 [void]$Peedy.StopAll()
[void]$peedy.Hide()
}
 


G7
# Aufruf von Outlook 2007 und des Posteingangs (Folder 6)
$Outlook = New-Object -com Outlook.Application
$Inbox = $Outlook.Session.GetDefaultFolder(6)
$Inbox.items | where { $_.Unread }| foreach { out-peedy $_.Subject }



# Merlin
$PC = New-Object -com agent.control.2
$pc.connected = $true
[void]$pc.Characters.load("Merlin","C:\windows\MSAgent\chars\merlin.acs")
$Merlin  = $pc.Characters.Item("Merlin")
$Merlin.Show()




H1
$objDomain = [ADSI]"LDAP://dc=contoso,dc=local"
$objOU = $objDomain.Create("organizationalUnit", "ou=HR")
$objOU.SetInfo()

$objOU = [ADSI]"LDAP://ou=hr,dc=contoso,dc=local"
$objGrp = $objOU.Create(„group", „cn=HRGroup")
$objGrp.Put(„sAMAccountName", „HRGroup")
$objGrp.SetInfo()

$objUser = $objOU.Create(„user", „cn=frankoch")
$objUser.Put(„sAMAccountName", „frankoch")
$objuser.SetInfo()

$objUser2 = $objOU.Create(„user", „cn=frankoch2")
$objUser2.Put(„sAMAccountName", „frankoch2")
$objuser2.SetInfo()



H2
$objUser = [ADSI]"LDAP://cn=frankoch,ou=HR,dc=contoso,dc=local"
$objUser.SetPassword("Pass1wort")
$objUser.psbase.InvokeSet("AccountDisabled",$false)
$objUser.SetInfo()
$objUser = [ADSI]"LDAP://cn=frankoch2,ou=HR,dc=contoso,dc=local"
$objUser.SetPassword("Pass1wort")
$objUser.psbase.InvokeSet("AccountDisabled",$false)
$objUser.SetInfo()




# AD Search Example: Computer
$ADDomain = [ADSI]"LDAP://dc=contoso,dc=local"
$ADSearch = New-Object System.DirectoryServices.DirectorySearcher
$ADSearch.SearchRoot = $ADDomain
# definition des Filters: nur Computer,Suche nach Namen
$ADSearch.Filter = "(objectCategory=computer)"
$ADSearch.PropertiesToLoad.Add("name")
$ergebnis = $ADSearch.FindAll()

# Zur Ausgabe wenden wir einen Trick an, um nur den Namen auszugeben
Foreach ($erg in $ergebnis)
{
	$ADComp = $erg.Properties
	$ADcomp.Name
}




H4
$ADDomain = [ADSI]"LDAP://dc=contoso,dc=local"
$ADSearch = New-Object System.DirectoryServices.DirectorySearcher
$ADSearch.SearchRoot = $ADDomain
# definition des Filters: nur Computer,Suche nach Namen
$ADSearch.Filter = "(objectCategory=user)"
$ADSearch.PropertiesToLoad.Add("name")
$ADSearch.PropertiesToLoad.Add("description")
$ergebnis = $ADSearch.FindAll()



# Zur Ausgabe wenden wir einen Trick an, um nur den Namen auszugeben
# Achtung, ADSI ist hier sehr case-sensitive: name und description unbedingt klein schreiben!

Foreach ($erg in $ergebnis) {
	$ADuser = $erg.Properties
	$ADUser.name + " " + $ADUser.description
}


H5
Get-command –pssanpin Quest.ActiveRoles.ADManagement
# Um die Quest-Addins immer verfügbar zu haben, muss man den Aufruf Add-PSSnapIn Quest.ActiveRoles.ADManagement in eine der Profil-Dateien eintragen.


H6
# Anlegen eines neuen Benutzers:
New-QADUser -name "Frankoch3" -organizationalUnit "OU=HR,DC=contoso,DC=local" -samAccountName "Frankoch3" -UserPassword "Pass1word"

# Anlegen einer neuen Gruppe:
new-qadGroup -name "HR Group2" -organizationalUnit "OU=HR,DC=contoso,DC=local" -samAccountName "hrgroup2" -Grouptype "Security" -Groupscope "Global"

# Hinzufügen eines Benutzers in eine Gruppe:
add-QADGroupMember -identity "CN=HR Group2,OU=HR,DC=contoso,DC=local" -member "Contoso\frankoch3"



H7
import-csv h7-users.csv | foreach { new-QADuser -name $_.Name -sam $_.sam -password $_.password  -Org $_.OU }



I Skript Out-Chart.ps1
param($xaxis, $yaxis, $height=800, $length=500, $type=3, $outfile="chart" )
begin {
 $script:categories = @()
 $script:values = @()
 $script:chDataLiteral = -1 
 $script:chDimCategories = 1  
 $script:chDimValues = 2 
 $script:chart = new-object -com OWC11.ChartSpace.11
 $chart.Clear()
 $c = $chart.charts.Add(0) 
 $c.Type = $type 
 $c.HasTitle = $true  
 $c.Title.Caption = "Chart generated on $(get-date)" 
 $script:series = ([array] $chart.charts)[0].SeriesCollection.Add(0)
}
Process {
$categories += $_.$xaxis 
 $values += $_.$yaxis *1
}
End {
 $series.Caption = "chart"
 $series.SetData($chDimCategories, $chDataLiteral, $categories) 
 $series.SetData($chDimValues, $chDataLiteral, $values)
 $filename = (resolve-path .).Path + "\$outfile.jpg" 
 $chart.ExportPicture($filename, "jpg", $height, $length)
 invoke-item $filename
}



I: Office Web Components example
# Author Stephen Hulse shulse@hotmail.com
$categories = @()
$values = @()
$chart = new-object -com OWC11.ChartSpace.11
$chart.Clear()
$c = $chart.charts.Add(0)
$c.Type = 4
$series = ([array] $chart.charts)[0].SeriesCollection.Add(0)

Get-Process | Sort-Object cpu | Select-Object processname,cpu -last 10 | foreach-object {
	$values += $_.cpu * 1
	$categories += $_.processname }

$series.Caption = "chart"
$series.SetData(1, -1, $categories) 
$series.SetData(2, -1, $values)

$filename = (resolve-path .).Path + "\chart2.jpg" 
$chart.ExportPicture($filename, "jpg", 800, 500)
invoke-item $filename


# Outchart.ps1
param($xaxis, $yaxis)

begin {
$categories = @()
$values = @()
$chart = new-object -com OWC11.ChartSpace.11
 $chart.Clear()
 $c = $chart.charts.Add(0) 
 $c.Type = 4 
 $c.HasTitle = $true  
 $c.Title.Caption = "Chart generated on $(get-date)" 
 $series = ([array] $chart.charts)[0].SeriesCollection.Add(0)
}

Process {
$categories += $_.$xaxis 
 $values += $_.$yaxis *1
}

End {
 $series.Caption = "chart"
 $series.SetData(1, -1, $categories) 
 $series.SetData(2, -1, $values)
 $filename = (resolve-path .).Path + "\chart.jpg" 
 $chart.ExportPicture($filename, "jpg", 800,  500)
 invoke-item $filename
}


I1
get-process | sort cpu | select -last 10 | .\out-chart.ps1 processname CPU


I2
Get-pssnapins
Add-pssnapin PowerGadgets


I3
Get-command –pssnapin PowerGadgets
get-process | sort cpu | select name, cpu -last 10 | out-chart


I4
# Ausgabe von Dateiextensions
dir *.* | group Extension | out-chart -Values Count -Label Name
dir *.* | sort length | select name, length –last 10 | out-chart


I5
# Um einen Rückgabewert durch Doppelklick zu erhalten, muss man lediglich die Pipeline nach dem Out-Chart weiterführen:
get-process | sort cpu | select name, cpu -last 10 | out-chart | foreach { $_ } 


J1
Get-WmiObject -list | where {$_ -match "win32_n"}
Get-WmiObject -list | where {$_ -match "win32_n"} | measure-object


J2
Get-WmiObject -Class "Win32_NetworkAdapterConfiguration" -Filter IPEnabled=True | format-table index, IPAddress, Description -autosize

Get-WmiObject -Class "Win32_NetworkAdapter" | get-member

Get-WmiObject -Class "Win32_NetworkAdapter" | foreach{ $_.Disable() }


J3
$WC = New-Object net.webclient
$Global:BatSeite = $wc.downloadstring("https://www.dellbatteryprogram.com/")

$R = [regex]"&nbsp;([A-Z0-9][A-Z0-9][0-9][0-9][0-9])"
$Matches = $R.Matches($Global:BatSeite)
Write-Host "Anzahl gelisteter Akku-Typen: $($Matches.Count) "

$Global:BatterieListe = $Matches | ForEach { $_.Groups[1].Captures[0].value }
Get-WMIObject –Class Win32_Battery | ForEach { $BatName = $_.name; break }

If ((select-string –pattern  $BatName  -InputObject  $BatterieListe –Quiet)  -eq $True) {
   BatterieListe | Where {$BatName –match $_ } | Foreach { 
     Write-Warning "Betroffen:Akku $Name – Übereinstimmungen: *$_*`n" } } 



K1
Get-pssnapin
get-command -PSSnapin  PSCX
(get-command -PSSnapin  PSCX | measure-object).count
Get-help *pscx
Get-help about_PSCX



K2
# The scripts starts here. First check: do we have 3 parameters?
If ($Args.count –ne 3) { 
	write-warning "call the script with 3 parameter: source target date-in-months" 
} else {
If (test-path $Args[0]) { 
	If (test-path $Args[1] ) {
	$CheckDate = ((Get-date).AddMonths(- $Args[2])).ToOADate()
	$MyPath = $Args[1]
	Dir $args[0] -recurse | where-object {$_.mode -notmatch "d"} | foreach-object { 
		if ( ($_.LastAccessTime).ToOADate() -lt $CheckDate) { 
		$myACL = get-Acl $_.FullName
		$MyName = $MyPath + "\" + $_.Name
		Move-Item $_.FullName $MyPath
#Statt xxMKLink verwenden wir nun das PSCX Cmdlet New-Link
		New-Link $_.FullName $Myname /q

		Set-Acl $Myname $myACL
		$Myname = $_.FullName + ".lnk"
		Set-Acl $Myname $myACL
		}
	}
} else { Write-Warning "Target path does not exists" }
} else {Write-Warning ("Source path does not exists: " + $Args[0]) } 
}



K3
# Aufruf von Outlook 2007 und des Posteingangs (Folder 6)
$Outlook = New-Object -com Outlook.Application
$Inbox = $Outlook.Session.GetDefaultFolder(6)
$Inbox.items | where { $_.Unread }| foreach { out-speech $_.Subject }


K4
Ping-Host localhost
Ping-Host localhost –q | get-member 
(Ping-Host localhost –q).loss


K5
Send-SmtpMail  -SmtpHost contoso-DC1.Contoso.local –to Administrator@contoso.local  -from info@contoso.local `
-subject "PowerShell Information von " + (dir env:\Computername).Value – body  "Serveralarm auf " + (dir nv:\Computername).Value + " um " + (get-date)


# Create a ZIP file
dir c:\Downloads\Files -recurse | write-zip -outputpath test.zip


K6
cd contoso:  # Vergessen Sie nicht den Doppelpunkt!
CD \; Dir users
Get-ADObject   -class user


K7
New-Item  PSCX –type OrganizationalUnit
cd PSCX
New-Item PSCX1 –type User
New-Item PSCX2 –type User
New-Item PSCX-Group –type Group

Set-Itemproperty PSCX1  Disabled  $False
Set-Itemproperty PSCX2  Disabled  $False

Get-Itemproperty Pscx1  # der Vorname ist in der Eigenschaft Surname gespeichert
Set-ItemProperty PSCX  Surname  "Frank"


Cd \; Cd HR
Dir
Del *
Dir


L1
Get-pssnapin
get-command -PSSnapin  SDMGPOSnapIn
(get-command -PSSnapin  SDMGPOSnapIn | measure-object).count


L2
get-sdmgpo *
get-sdmgposecurity "Default Domain Policy"
get-sdmgplink "OU=Domain Controllers,dc=contoso,dc=local"


L3
New-SDMgpo "Test-GPO"
Add-SDMgplin -name Test-GPO -scope "OU=HR, DC=contoso, DC=local" -Location -1


L4
Get-pssnapin
get-command -pssnapin getgpobjectpssnapin

$gpo = Get-SDMgpobject -gponame "gpo://contoso.local/Default Domain Policy"   -openbyname $true
$stng = $gpo.GetObject("User Configuration/Administrative Templates/Desktop/Active Desktop/Active Desktop Wallpaper");
$stng.Put("State", [GPOSDK.AdmTempSettingState]"Enabled");
$stng.Put("Wallpaper Name:", "%WINDIR%\Web\Wallpaper\Ascent.jpg");
$stng.Put("Wallpaper Style:", "0");
$stng.Save();

# Anschliessend aktualisieren Sie die Gruppenrichtlinien und loggen sich einmal aus und wieder ein:
Gpupdate /force




N
# Create new Database
$SQLCn = New-Object System.Data.SqlClient.SqlConnection("Server=.\SQLEXPRESS;Trusted_Connection=Yes")
$SQLCn.Open()
$SQLCMD = $SQLCn.CreateCommand()
$SQLCMD.CommandText = “CREATE DATABASE EventDB”
$Result= $SQLCMD.ExecuteNonQuery()
If ($Result) { Write-Host "Anlegen der Datenbank erfolgreich." }
$SQLCN.Close()


# Create new Table
$SQLCn = New-Object System.Data.SqlClient.SqlConnection( "Server=Contoso-DC1\SQLEXPRESS;Trusted_Connection=Yes;Database=EventDB")
$SQLCn.Open()
$SQLCMD = $SQLCn.CreateCommand()
$SQLCMD.CommandText = "CREATE TABLE Events (EvtIX int, EvtTXT varchar(1000), EvtTYPE varchar(50), EvtTIME datetime, EvtID int, EvtSrc varchar(100))"
$Result= $SQLCMD.ExecuteNonQuery()
If ($Result) { Write-Host "Anlegen der Tabelle erfolgreich." }
$SQLCN.Close()


# Create new row / entry 
$SQLCn = New-Object System.Data.SqlClient.SqlConnection( “Server=Contoso-DC1\SQLEXPRESS;Trusted_Connection=Yes;Database=EventDB”)
$SQLCn.Open()
Get-eventlog system –newest 10 | foreach-object { 
	$SQLCMD = $SQLCn.CreateCommand()
	$SQLCMD.CommandText = "INSERT Into Events VALUES(@EvtIX, @EvtTXT, @EvtTYPE, @EvtTIME, @EvtID, @EvtSrc)"
	$P = $SQLCMD.Parameters.AddwithValue("@EvtIX", $_.Index)
	$P = $SQLCMD.Parameters.AddwithValue("@EvtTXT", $_.Message)
	$P = $SQLCMD.Parameters.AddwithValue("@EvtTYPE", $_.Category)
	$P = $SQLCMD.Parameters.AddwithValue("@EvtTIME", $_.TimeGenerated)
	$P = $SQLCMD.Parameters.AddwithValue("@EvtID", $_.EventID)
	$P = $SQLCMD.Parameters.AddwithValue("@EvtSrc", $_.Source)
	$Result= $SQLCMD.ExecuteNonQuery()
	If ($result –eq $False) { Write-Host "Fehler beim Datenschreiben" }
}
$SQLCN.Close()


# Read row / entry
$SQLCn = New-Object System.Data.SqlClient.SqlConnection( "Server=Contoso-DC1\SQLEXPRESS;Trusted_Connection=Yes;Database=EventDB")
$SQLCn.Open()
$SQLCMD = $SQLCn.CreateCommand()
$SQLCMD.CommandText = "SELECT * FROM Events"
$Results = $SQLCMD.ExecuteReader()
While ( $Results.Read() ) {
	Write-Host $Results.Item("EvtIX") $Results.Item("EvtTIME") $Results.Item("EvtTXT")
}
$SQLCN.Close()




Weitere BeispielSkripte
#Auflistung aller Dateien aus allen Unterordnern mit Statistik zu: 
#     •	Art des Dateityps (.doc, .TXT…)
#     •	Anzahl der Dateien pro Typ (5, 10, …)
#     •	Gesamtgrösse aller Dateien dieses Typs (1345 KB)

X1
New-PSDrive -name FK -PSProvider FileSystem -root c:\Downloads\Files | out-null
get-childitem FK:\ -recurse | where-object {$_.mode -notmatch "d"} | 
Group-Object extension | foreach { write-host $_.name, $_.count, (Get-childitem ("FK:\*"+ $_.name) -recurse |  measure-object length –sum).sum }




# Speichern der Ausgabe von X1 in Excel statt auf dem Bildschirm

x2
New-PSDrive -name FK -PSProvider FileSystem -root c:\downloads\files | out-null
$a = New-Object -comobject Excel.Application
$b = $a.Workbooks.Add()
$c = $b.Worksheets.Item(1)
$c.Cells.Item(1,1) = "Dateityp"
$c.Cells.Item(1,2) = "Anzahl"
$c.Cells.Item(1,3) = "Gesamtgrösse"
$i = 2
get-childitem FK:\ * -recurse | where-object {$_.mode -notmatch "d"} | 
Group-Object extension | foreach { 
	$c.cells.item($i,1) = $_.Name
	$c.cells.item($i,2) = $_.count
	$c.cells.item($i,3) = (Get-childitem ("FK:\*"+ $_.name) -recurse |  measure-object length –sum).sum
	$i = $i + 1
}
$b.SaveAs("C:\Downloads\Scripts\Report-X2.xlsx")
$a.quit()



