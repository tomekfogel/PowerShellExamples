
c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\1.1.ps1
************************************************************************
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont]
"0"="Consolas"
"00"="Courier New"
"000"="Lucida Console"
"0000"="Lucida Sans Typewriter"
"00000"="OCR A Extended"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\1.2.ps1
************************************************************************
# requires full administrative permissions
# run in a PowerShell with elevated rights!

Update-Help -UICulture en-us -Force
$CurrentCulture = $Host.CurrentUICulture.Name
if ($CurrentCulture -ne 'en-us')
{
  if ( (Test-Path $PSHOME\$CurrentCulture) -eq $false)
  {
    $null = New-Item $PSHOME\$CurrentCulture -ItemType Directory
  }
  Copy-Item $PSHOME\en-us\* -Destination $PSHOME\$CurrentCulture -ErrorAction SilentlyContinue
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.1.ps1
************************************************************************
$lottozahlen = 1..49 | Get-Random -Count 6 | Sort-Object
$lottozahlen -join ', '



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.10.ps1
************************************************************************
$driveC = Get-WmiObject -Class Win32_LogicalDisk -Filter 'DeviceID="C:"'
$sizeByte = $driveC.Size
$sizeGB = $sizeByte / 1GB

'Festplatte C:\ Größe: {0:n1} GB' -f $sizeGB



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.11.ps1
************************************************************************
$zeichen = 'abcdefghijklmnopqrstuvwxyz0123456789!"§$%&/()=?'.ToCharArray()
-join (Get-Random -InputObject $zeichen -Count 7)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.12.ps1
************************************************************************
$text = 'Hallo Welt.'
$positionAnfang = $text.IndexOf('Hallo') + 6
$positionEnde = $text.IndexOf('.', $positionAnfang+1)
$text.Substring($positionAnfang, $positionEnde - $positionAnfang)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.13.ps1
************************************************************************
$vorlage = 'Name: {{Vorname:Hans} {Nachname:Müller}}'
$ergebnis = 'Name: Tobias Weltner' | ConvertFrom-String -TemplateContent $vorlage



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.14.ps1
************************************************************************
$template = @'

Ping wird ausgeführt für powershell.com [65.38.114.170] mit 32 Bytes Daten:
Antwort von {IP*:65.38.114.170}: Bytes=32 Zeit={Time:164}ms TTL={TTLValue:112}
Antwort von {IP*:100.38.4.70}: Bytes=32 Zeit={Time:1}ms TTL={TTLValue:1}
Antwort von {IP*:5.250.14.2}: Bytes=32 Zeit={Time:3000}ms TTL={TTLValue:99}
Zeitüberschreitung der Anforderung.

Ping-Statistik für 65.38.114.170:
    Pakete: Gesendet = 4, Empfangen = 3, Verloren = 1
    (25% Verlust),
Ca. Zeitangaben in Millisek.:
    Minimum = 163ms, Maximum = 165ms, Mittelwert = 164ms
'@

ping powershell.com | ConvertFrom-String -TemplateContent $template
ping powershellmagazine.com | ConvertFrom-String -TemplateContent $template



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.15.ps1
************************************************************************
$text = 'Hallo Welt.'
$muster = 'Hallo (\w{1,})'
if ($text -match $muster) 
{ 
  $Matches[1] 
} 
else 
{ 
  Write-Warning 'nicht gefunden!' 
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.16.ps1
************************************************************************
$text = 'Mar 18, 2016	Server_07786	success'
$muster = 'Server_\d{5}'

if ($text -match $muster)
{
  $matches[0]
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.17.ps1
************************************************************************
$path = "$env:temp\sample.log"

1..1000 | ForEach-Object {
  '{0:MMM dd, yyyy} Server_{1:d5} {2}' -f (Get-Date), (Get-Random -Maximum 99999), ('success', 'failure' | Get-Random)

} | Set-Content -Path $Path -Encoding UTF8

notepad $path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.18.ps1
************************************************************************
$path = "$env:temp\sample.log"
$muster = 'Server_\d{5}'

Get-Content -Path $path |
  Where-Object { $_ -match $muster } |
  ForEach-Object { $matches[0] }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.19.ps1
************************************************************************
$path = "$env:temp\sample.log"
$muster = '(Server_\d{5})\s{1,}(\w{1,})'

Get-Content -Path $path |
  Where-Object { $_ -match $muster } |
  ForEach-Object { $matches[1], $matches[2] }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.2.ps1
************************************************************************
$lottozahlen = 1..49 | Get-Random -Count 6 | Sort-Object
$text =  $lottozahlen -join '] [' 
"[$text]"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.20.ps1
************************************************************************
$path = "$env:temp\sample.log"
$muster = '(?<Server>Server_\d{5})\s{1,}(?<Status>\w{1,})'

Get-Content -Path $path |
  Where-Object { $_ -match $muster } |
  ForEach-Object { 
    New-Object -TypeName PSObject -Property $matches |
    Select-Object -Property Server, Status
  }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.21.ps1
************************************************************************
$quellcode = '<a href="eine adresse">Link 1</a><a href="noch eine">Link 2</a>'
$pattern = '<a href="(?<link>.*)".*>(?<text>.*)</a>'
if ($quellcode -match $pattern) { $Matches }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.22.ps1
************************************************************************
$quellcode = '<a href="eine adresse">Link 1</a><a href="noch eine">Link 2</a>'
$pattern = '<a href="(?<link>.*?)".*?>(?<text>.*?)</a>'
if ($quellcode -match $pattern) { $Matches }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.23.ps1
************************************************************************
$quellcode = '<a href="eine adresse">Link 1</a><a href="noch eine">Link 2</a>'
$pattern = '(?i)<a href="(?<link>.*?)".*?>(?<text>.*?)</a>'
[RegEx]::Matches($quellcode, $pattern)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.24.ps1
************************************************************************
$text = 'wir müssen server1, server22 und server9 umbenennen.'

# Muster muss am Anfang (?i) enthalten, wenn die
# Groß- und Kleinschreibung ignoriert werden soll
# Das Muster beschreibt den Servernamen
$pattern = '(?i)server(\d{1,3})'

$code = 
{
  # Skriptblock empfängt jeden Treffer über seinen Parameter 
  param($match)
      
  # die Indexzahlen entsprechen den Indexzahlen, die beim
  # normalen -match-Operator in $Matches zurückgegeben würde:
  $alles = $match.Groups[0].Value
  $id = $match.Groups[1].Value

  # neuen Text aus diesen Informationen zusammenbauen:
  'VM_{0:000} (war mal {1})' -f [Int]$id, $alles
}

[RegEx]::Replace($text, $pattern, $code)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.25.ps1
************************************************************************
$text = @'
Hier steht nichts.
Hier steht kb1234567.
Hier steht KB6635242.
'@

$pattern = '(?i)KB\d{6,8}'

[Regex]::Matches($text, $pattern)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.26.ps1
************************************************************************
function Get-Excuse
{
  $url = 'http://pages.cs.wisc.edu/~ballard/bofh/bofhserver.pl'
  $page = Invoke-WebRequest -Uri $url -UseBasicParsing
  $pattern = '(?s)<br><font size\s?=\s?"\+2">(.+)</font'

  if ($page.Content -match $pattern)
  {
    $matches[1]
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.27.ps1
************************************************************************
function Get-Excuse
{
  $url = 'http://pages.cs.wisc.edu/~ballard/bofh/bofhserver.pl'
  $page = Invoke-WebRequest -Uri $url -UseBasicParsing
  $pattern = '(?<=<br><font size\s?=\s?"\+2">).+'
  if ($page.Content -match $pattern)
  {
    $matches[0]
  }
}


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.3.ps1
************************************************************************
$path = "$env:temp\report.csv"

Get-EventLog -LogName System -Newest 10 |
  Select-Object -Property TimeWritten, Message, EntryType, ReplacementStrings |
  ForEach-Object {
    $_.ReplacementStrings = $_.ReplacementStrings -join ', '
    $_
  } |
  Export-CSV -Path $path -UseCulture -NoTypeInformation -Encoding UTF8
  
Invoke-Item -Path $path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.4.ps1
************************************************************************
$lottozahlen = 1..49 | Get-Random -Count 7
$zusatzzahl = $lottozahlen[0]
$zahlen = $lottozahlen[1..6] | Sort-Object

"Die Lottozahlen lauten $zahlen und die Zusatzzahl ist $zusatzzahl"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.5.ps1
************************************************************************
$lottozahlen = 1..49 | Get-Random -Count 7
$zusatzzahl = $lottozahlen[0]
$zahlen = $lottozahlen[1..6] | Sort-Object

$ofs = ','
"Die Lottozahlen lauten $zahlen und die Zusatzzahl ist $zusatzzahl"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.6.ps1
************************************************************************
# Direktvariable:
"$($env:username): angemeldeter Benutzer"

# Escape-Zeichen
"$env:username`: angemeldeter Benutzer"

# Verkettung:
$env:username + ': angemeldeter Benutzer'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.7.ps1
************************************************************************
# Beispiel Lottozahlen
$lottozahlen = 1..49 | Get-Random -Count 7
$zusatzzahl = $lottozahlen[0]
$zahlen = $lottozahlen[1..6] | Sort-Object
'Die Lottozahlen lauten {0} und die Zusatzzahl ist {1}' -f ($zahlen -join ','), $zusatzzahl
# Beispiel PowerShell-Version
'Die PowerShell-Version lautet {0}' -f $host.Version
# Beispiel Benutzername
'{0}: angemeldeter Benutzer' -f $env:username


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.8.ps1
************************************************************************
Get-Service |
ForEach-Object {
  '{0,-35} : {1,-28}' -f $_.Name, $_.Status
}


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\10.9.ps1
************************************************************************
Get-Service |
Format-Table -Property Name, Status -AutoSize


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.1.ps1
************************************************************************
do
{
  $eingabe = Read-Host 'Eine Zahl'

} until ($eingabe -as [Int])



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.10.ps1
************************************************************************
# Datum liegt in einer französischen Schreibweise vor:
$datumFranzoesisch = 'vendredi 23 novembre 2012 11:19:13'

# für die Umwandlungen die Quell- und Zielkultur besorgen:
[System.Globalization.CultureInfo]$Frankreich = 'fr-FR'
[System.Globalization.CultureInfo]$Taiwan = 'zh-TW'

# Datumstext unter Angabe seiner Kultur in einen DateTime-Typ verwandeln
# dieser ist sprachunabhängig:
$DateTime = [datetime] XE "[datetime]" ::Parse($datumFranzoesisch, $Frankreich)

# von hier aus in Zielkultur umwandeln
# das Ergebnis ist jetzt wieder Text (String):
$datumTaiwan = $DateTime.ToString($Taiwan)

''
"$datumFranzoesisch -> $datumTaiwan"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.11.ps1
************************************************************************
filter Get-Constructor 
{
  $type = $_
         
  foreach($constructor in $type.GetConstructors())
  {
    $info = $constructor.GetParameters().Foreach{$_.ToString()} -Join ', '
    "($info)"
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.12.ps1
************************************************************************
$username = 'firma\Hans'
$password = 'topSecret99' | ConvertTo-SecureString -AsPlainText -Force
$credential = New-Object -TypeName PSCredential($username, $password)

Get-WmiObject -Class Win32_BIOS -ComputerName RemoteServerABC -Credential $credential



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.13.ps1
************************************************************************
function Export-Credential($cred, $file) {
  $ergebnis = 1 | Select-Object Username, Password
  $ergebnis.Username = $cred.UserName
  $ergebnis.Password = $cred.Password | ConvertFrom-SecureString
  $ergebnis | Export-Clixml $file
}

function Import-Credential($file) {
  $ergebnis = Import-Clixml $file
  $user = $ergebnis.username
  $password = $ergebnis.password | ConvertTo-SecureString 
  New-Object system.Management.Automation.PSCredential($user, $password)
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.14.ps1
************************************************************************
@'
<?xml version="1.0" ?>
<Belegschaft Zweigstelle="Hannover" Typ="Aussendienst">
  <Mitarbeiter>
    <Name>Tobias Weltner</Name>
    <Rolle>Leitung</Rolle>
    <Alter>47</Alter>
  </Mitarbeiter>
  <Mitarbeiter>
    <Name>Cofi Heidecke</Name>
    <Rolle>Sicherheit</Rolle>
    <Alter>23</Alter>
  </Mitarbeiter>
</Belegschaft>
'@ | Set-Content -Path $env:temp\mitarbeiter.xml -Encoding UTF8



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.15.ps1
************************************************************************
$xml = [xml](Get-Content $env:temp\mitarbeiter.xml)
$xml.Belegschaft.Mitarbeiter


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.16.ps1
************************************************************************
$xml = New-Object xml
$xml.Load("$env:temp\mitarbeiter.xml")
$xml.Belegschaft.Mitarbeiter



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.17.ps1
************************************************************************
$shareklasse = [wmiclass] XE "[wmiclass]" '\\storage1\root\cimv2:Win32_Share'
$pfad = 'C:\'
$name = 'serviceshare'
$type = 0
$maximumallowed = 5
$description = 'Interner Share für Wartungsaufgaben'
$shareklasse.Create($pfad, $Name, $Type, $MaximumAllowed, $Description).ReturnValue



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.18.ps1
************************************************************************
# Anmeldeinformationen festlegen:
$WMIOptionen = New-Object System.Management.ConnectionOptions
$anmeldung = Get-Credential
$WMIOptionen.SecurePassword = $anmeldung.Password
$WMIOptionen.UserName = $anmeldung.UserName

$path = '\\storage1\root\cimv2:Win32_Share'
$scope = New-Object System.Management.ManagementScope($path, $WMIOptions)
$scope.Connect()

$optionen = New-Object System.Management.ObjectGetOptions

# Freigabe einrichten:
$shareklasse = New-Object System.Management.ManagementClass($scope, $path, $optionen)
$pfad = 'C:\'
$name = 'serviceshare_neu'
$type = 0
$maximumallowed = 5
$description = 'Interner Share für Wartungsaufgaben'
$shareklasse.Create($pfad, $Name, $Type, $MaximumAllowed, $Description).ReturnValue



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.19.ps1
************************************************************************
$ie = New-Object -COMObject InternetExplorer.Application 
$ie.Navigate2('www.powertheshell.com')
$ie.Visible = $true



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.2.ps1
************************************************************************
function Test-IPv4 
{
  param($IPAddress)
  
  $IP = $IPAddress -as [System.Net.IPAddress]
  $IP.AddressFamily -eq 'InternetWork' -and $IPAddress -like '*.*.*.*'  
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.20.ps1
************************************************************************
# COM-Objekt besorgen:
$wshell = New-Object -ComObject WScript.Shell

# Argumente vorbereiten:
$message = 'Ihr Rechner wird jetzt neu gestartet. Einverstanden?'
$title = 'Wichtig'

# Methode Popup() aufrufen:
$response = $wshell.Popup($message, 10, $title, (4+48))

# Ergebnis auswerten:
if ($response -ne 7)
{
  Restart-Computer -WhatIf
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.21.ps1
************************************************************************
$message = 'Suchen Sie sich einen Ordner aus!'
$path = "$HOME\Documents"

$object = New-Object -ComObject Shell.Application
$folder = $object.BrowseForFolder(0, $message, 0, $path)
if ($folder -ne $null)
{
  $folder.self.Path
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.22.ps1
************************************************************************
$speaker = New-Object -ComObject SAPI.SpVoice
$null = $speaker.Speak('Hello World!')
$speaker.Rate = -10
$null = $speaker.Speak('Hello World!')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.23.ps1
************************************************************************
$speaker = New-Object -ComObject SAPI.SpVoice -Property @{Speak='Initializing'}
$speaker.Rate = -20
$null = $speaker.Speak('What a night!')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.24.ps1
************************************************************************
$excel = New-Object -ComObject Excel.Application
$workbook = $excel.Workbooks.Add()
$excel.Visible = $true
$excel.Cells.Item(1,1) = "Service Name" 
$excel.Cells.Item(1,2) = "Service Status"
$excel.Cells.Item(1,3) = "Service Status"

$i = 2 
Get-Service | 
  ForEach-Object { 
    $excel.Cells.Item($i,1) = $_.name
    $excel.Cells.Item($i,2) = $_.status
    $excel.Cells.Item($i,3) = "$($_.status)"
    $i=$i+1
  }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.25.ps1
************************************************************************
$shell = New-Object -ComObject WScript.Shell

$LinkFile = 'Windows PowerShell.lnk'
$Desktop = $shell.SpecialFolders.Item('Desktop')

$Path = Join-Path -Path $Desktop -ChildPath $LinkFile

# Pfad zum AKTUELLEN PowerShell-Host ermitteln:
$TargetPath = (Get-Process -id $pid).Path

# Link-Datei anlegen:
$shortcut = $shell.CreateShortcut($path)
# erstes Icon in der EXE-Datei verwenden:
$shortcut.IconLocation = '{0},{1}' -f $TargetPath, 0
$shortcut.TargetPath = $TargetPath

$shortcut.Save()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.26.ps1
************************************************************************
$shell = New-Object -ComObject Wscript.Shell

$StartUser = $shell.SpecialFolders.Item('StartMenu')
$StartAll = "$env:ALLUSERSPROFILE\Windows\Startmenü"

Get-ChildItem -Path $StartUser, $StartAll -Filter *.lnk -Recurse -ErrorAction SilentlyContinue | 
ForEach-Object {
  $lnkfile = $shell.CreateShortcut($_.FullName)
  New-Object -TypeName PSObject -Property @{
      Hotkey =  $lnkfile.Hotkey
      Name = $_.Name
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.27.ps1
************************************************************************
# Guid erzeugen
$guid = [guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"

# Typ finden
$type = [type]::GetTypeFromCLSID($guid)

# COM-Objekt anlegen:
$netzwerk = [Activator]::CreateInstance($type)

$netzwerk



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.28.ps1
************************************************************************
# Guid erzeugen
$guid = [guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"

# Typ finden
$type = [type]::GetTypeFromCLSID($guid)

# COM-Objekt anlegen:
$netzwerk = [Activator]::CreateInstance($type)

# Hashtables für die auszulesenden Eigenschaften definieren:
$name = @{Name='Name'; Expression={ $_.GetName() }}
$beschreibung = @{Name='Beschreibung'; Expression={ $_.GetDescription() }}
$kategorie = @{Name='Kategorie'; Expression={ $_.GetCategory() }}

$netzwerk.GetNetworkConnections() | 
  ForEach-Object { $_.GetNetwork() } | 
    Select-Object $Name, $Beschreibung, $kategorie, isConnectedToInternet



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.29.ps1
************************************************************************
# Wetterdienst ansprechen:
$wetter = New-WebServiceProxy -Uri http://www.webservicex.com/globalweather.asmx?WSDL

# Wetterdaten abrufen:
$hannover = [xml]$wetter.GetWeather('Hannover', 'Germany')
$mallorca = [xml]$wetter.GetWeather('Palma', 'Spain')
$celsiusHannover =
if ($hannover.CurrentWeather.Temperature -match 'F \((.*?) C\)')
{
  $Matches[1]
}

$celsiusPalma =
if ($mallorca.CurrentWeather.Temperature -match 'F \((.*?) C\)')
{
  $Matches[1]
}

$differenz = $celsiusPalma - $celsiusHannover

"In Palma de Mallorca ist es gerade $differenz Grad Celsius wärmer."

# HTML-Report der Wetterdaten anlegen und öffnen:
$mallorca.currentweather, $hannover.currentweather |
  Select-Object Location, Time, Wind, Visibility, Temperature, DewPoint, RelativeHumidity, Pressure, Status |
  ConvertTo-Html -Title 'Wetterbericht Palma und Hannover' |
  Out-File $env:TEMP\wetter.hta

# Report öffnen:
Invoke-Item $env:TEMP\wetter.hta



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.3.ps1
************************************************************************
$hashtable = @{
  MultiSelect = $false
  CheckFileExists = $true
  InitialDirectory = "$Home\Documents"
  Title = 'PowerShell Skript auswählen'
  Filter = 'PS-Skript|*.ps1|Alles|*.*'
}
$dialog = [Microsoft.Win32.OpenFileDialog]$hashtable
$ok = $dialog.ShowDialog()
if ($ok)
{
  $dialog.FileName
}


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.30.ps1
************************************************************************
$xml = New-Object xml
$xml.Load('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml')

# aus den XML-Daten die Wechselkursinformationen ansprechen:
$xml.Envelope.Cube.Cube.Cube



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.31.ps1
************************************************************************
$typname = 'System.Management.Automation.TypeAccelerators'
  $typ = [psobject].Assembly.GetType($typname)
  ($typ::Get).GetEnumerator() |
    Where-Object { $_.Value.FullName -notlike '*attribute' } |
    Sort-Object -Property Key



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.32.ps1
************************************************************************
[System.Diagnostics.Process].Assembly.GetExportedTypes() |
  Where-Object { $_.isPublic} |
  Where-Object { $_.isClass } |
  Where-Object { $_.Name 
    -notmatch '(Attribute|Handler|Args|Exception|Collection|Expression|Parser|Statement)$' } |
  Select-Object -Property Name, FullName |
  Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.33.ps1
************************************************************************
function Find-TypeByName
{
  param
  (
    [Parameter(Mandatory=$true)]
    $Keyword
  )

  [AppDomain]::CurrentDomain.GetAssemblies() |
    ForEach-Object { try { $_.GetExportedTypes() } catch {} } |
    Where-Object { $_.isPublic} |
    Where-Object { $_.isClass } |
    Where-Object { $_.Name -notmatch '(Attribute|Handler|Args|Exception|Collection|Expression)$' }|
    Where-Object { $_.Name -like "*$Keyword*" } |
    Select-Object -Property Name, FullName
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.34.ps1
************************************************************************
function Find-TypeByCommandName
{
  param
  (
    [Parameter(Mandatory=$true)]
    $Keyword
  )

  # diese Methoden sind zu allgemein, ausschließen:
  $excludeAll = 'Invoke|InitializeLifetimeService|GetType|GetHashCode|Equals|Dispose'

  # diese Namensendung wird für asynchrone Aufrufe benötigt, ausschließen:
  $excludeEnding = 'Async'

  # diese Präfixe sind Methoden, die Eigenschaften und Operatoren abbilden. Ausschließen:
  $excludeStarting = 'get_|set_|op_|add_|remove_'

  [AppDomain]::CurrentDomain.GetAssemblies() |
  ForEach-Object { try { $_.GetExportedTypes() } catch {} } |
  Where-Object { $_.isPublic} |
  Where-Object { $_.isClass } |
  Where-Object { $_.Name -notmatch '(Attribute|Handler|Args|Exception|Collection|Expression)$' }|
  # nur Methoden, die dem Schlüsselwort entsprechen, und Doppelgänger ausschließen:
  ForEach-Object { $_.GetMethods() | Where-Object { $_.Name -like $Keyword } | Sort-Object Name -Unique } |
  # die allgemeinen Methoden nach den Ausschlusslisten entfernen:
  Where-Object { $_.Name -notmatch "^($excludeStarting)" } |
  Where-Object { $_.Name -notmatch "($excludeEnding)$" } |
  Where-Object { $_.Name -notmatch "$excludeAll" } |
  Select-Object -Property Name, DeclaringType
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.35.ps1
************************************************************************
Start-Process powershell.exe -ArgumentList '-noprofile -command [AppDomain]::CurrentDomain.GetAssemblies().Fullname.Foreach{$_.Split('','')[0]} | Sort-Object | clip'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.36.ps1
************************************************************************
$auswahl = [System.Management.Automation.Host.ChoiceDescription[]]('&Ja','&Nein')
$antwort = $Host.UI.PromptForChoice('Reboot', 'Darf das System jetzt neu gestartet werden?',$auswahl,1)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.4.ps1
************************************************************************
ï»¿Measure-Command {
  $text = 'Start'
  for ($x = 1; $x -lt 100000; $x ++)
  {
    $text += 'neuer Text'
  }
}


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.5.ps1
************************************************************************
Measure-Command {
  $text = [Text.StringBuilder]'Start'
  for ($x = 1; $x -lt 100000; $x ++)
  {
    $null = $text.Append('neuer Text')
  }
  $gesamttext = $text.ToString()
}


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.6.ps1
************************************************************************
Measure-Command {
  $array = 1,2,3
  for ($x = 4; $x -lt 10000; $x ++)
  {
    $array += $x
  }
}
$array.Count


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.7.ps1
************************************************************************
Measure-Command {
  $array = 1,2,3
  $array = [Collections.ArrayList]$array
  for ($x = 4; $x -lt 100000; $x ++)
  {
    $null = $array.Add($x)
  }
}


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.8.ps1
************************************************************************
$text = 'Meine E-Mail lautet tobias.weltner@irgendwo.de. Alternativ können Sie auch an tobias@somewhere.com oder tobias.weltner@powertheshell.com mailen.'

$regex = [regex]'(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b'

$regex.Matches($text).Value



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\11.9.ps1
************************************************************************
# "dynamische" Methode aus einem Objekt
'Hallo'.ToUpper()

# "statische" Methode aus einem Typ
[Console]::Beep()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.1.ps1
************************************************************************
$Heute = Get-Date
$Differenz = New-TimeSpan -Hours 48
$Stichtag = $Heute - $Differenz
Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag |
  Select-Object -Property TimeGenerated, Message



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.10.ps1
************************************************************************
function prompt
{
  'PS> '
  $host.UI.RawUI.WindowTitle = Get-Location
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.11.ps1
************************************************************************
function ConvertTo-Euro
{
  param
  (
    [Parameter(Mandatory=$true,HelpMessage='Der Betrag in Dollar')]
    [Double]
    $Betrag,

    [Double]
    $Wechselkurs = 0.97
  )

  $Ergebnis = $Betrag * $Wechselkurs
  return $Ergebnis
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.12.ps1
************************************************************************
function Test-ReturnValue
{
  param
  (
    $Anzahl = 1
  )

  1..$Anzahl |
    ForEach-Object {  'ich wurde einfach liegengelassen' }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.13.ps1
************************************************************************
function Test-ReturnValue
{
    'halli'
    'hallo'
    return
    'hallöle'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.14.ps1
************************************************************************
function Test-ReturnValue
{
    'halli' | Write-Output
    'hallo' | Write-Output
    return
    'hallöle' | Write-Output
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.15.ps1
************************************************************************
function Speak-Text($text) {
  $speaker = New-Object -COMObject SAPI.SPVoice
  $speaker.Speak($text)
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.2.ps1
************************************************************************
function Get-CriticalEvent
{
  $Heute = Get-Date
  $Differenz = New-TimeSpan -Hours 48
  $Stichtag = $Heute - $Differenz
  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag |
    Select-Object -Property TimeGenerated, Message
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.3.ps1
************************************************************************
function Get-CriticalEvent
{
  param([Int]$Hours=48, [Switch]$ShowWindow)

  $Heute = Get-Date
  $Differenz = New-TimeSpan -Hours 48
  $Stichtag = $Heute - $Differenz
  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag |
    Select-Object -Property TimeGenerated, Message
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.4.ps1
************************************************************************
function Get-CriticalEvent
{
  param
  (
    # Das Zeitfenster in Stunden, das berücksichtigt werden soll
    [Int]
    $Hours=48, # <- wichtig, Komma nicht vergessen!
    
    # zeigt die Ergebnisse in einem Fenster an
    [Switch]
    $ShowWindow
  )

  $Heute = Get-Date
  $Differenz = New-TimeSpan -Hours 48
  $Stichtag = $Heute - $Differenz
  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag |
    Select-Object -Property TimeGenerated, Message
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.5.ps1
************************************************************************
function Get-CriticalEvent([Int]$Hours=48,[Switch]$ShowWindow)
{
  $Heute = Get-Date
  $Differenz = New-TimeSpan -Hours 48
  $Stichtag = $Heute - $Differenz
  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag |
    Select-Object -Property TimeGenerated, Message
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.6.ps1
************************************************************************
function Get-CriticalEvent
{
  param($Hours=48, [Switch]$ShowWindow)

  if ($ShowWindow)
  {
    # Die Ausgabe an das GridView umleiten
    Set-Alias -Name Out-Default -Value Out-GridView
  }

  $Heute = Get-Date
  $Differenz = New-TimeSpan -Hours $Hours
  $Stichtag = $Heute - $Differenz
  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag |
    Select-Object -Property TimeGenerated, Message |
    Out-Default
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.7.ps1
************************************************************************
$name = 'Get-CriticalEvent'
$path = Split-Path -Path $profile
$code = "function $name { $((Get-Item function:\$name).Definition) }"
New-Item -Path $path\Modules\$name\$name.psm1 -ItemType File -Force -Value $code



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.8.ps1
************************************************************************
function Get-CriticalEvent
{
<#
    .SYNOPSIS
        listet Fehler und Warnungen aus dem System-Ereignisprotokoll auf
    .DESCRIPTION
        liefert Fehler und Warnungen der letzten 48 Stunden aus dem 
        System-Ereignisprotokoll,
        die auf Wunsch in einem GridView angezeigt werden. Der Beobachtungszeitraum
        kann mit dem Parameter -Hours geändert werden.
    .PARAMETER  Hours
        Anzahl der Stunden des Beobachtungszeitraums. Vorgabe ist 48.
    .PARAMETER  ShowWindow
        Wenn dieser Switch-Parameter angegeben wird, erscheint das Ergebnis in einem
        eigenen Fenster und wird nicht in die Konsole ausgegeben
    .EXAMPLE
        Get-CriticalEvent
        liefert Fehler und Warnungen der letzten 48 Stunden aus dem 
        System-Ereignisprotokoll
    .EXAMPLE
        Get-CriticalEvent -Hours 100
        liefert Fehler und Warnungen der letzten 100 Stunden aus dem 
        System-Ereignisprotokoll
    .EXAMPLE
        Get-CriticalEvent -Hours 24 -ShowWindow
        liefert Fehler und Warnungen der letzten 24 Stunden aus dem 
        System-Ereignisprotokoll und stellt sie in einem eigenen Fenster dar
    .NOTES
        Dies ist ein Beispiel aus Tobias Weltners' PowerShell Buch
    .LINK
        http://www.powertheshell.com
#>
  param($Hours=48, [Switch]$ShowWindow)

  if ($ShowWindow)
  {
    Set-Alias Out-Default Out-GridView
  }

  $Heute = Get-Date
  $Differenz = New-TimeSpan -Hours $Hours
  $Stichtag = $Heute - $Differenz

  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag |
    Select-Object -Property TimeGenerated, Message | Out-Default
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\12.9.ps1
************************************************************************
function Get-CriticalEvent
{
<#
    .SYNOPSIS
        listet Fehler und Warnungen aus dem System-Ereignisprotokoll auf
    .DESCRIPTION
        liefert Fehler und Warnungen der letzten 48 Stunden aus dem System-Ereignisprotokoll, die auf Wunsch in einem GridView angezeigt werden. Der Beobachtungszeitraum kann mit dem Parameter -Hours geändert werden.
    .EXAMPLE
        Get-CriticalEvent
        liefert Fehler und Warnungen der letzten 48 Stunden aus dem System-Ereignisprotokoll
    .EXAMPLE
        Get-CriticalEvent -Hours 100
        liefert Fehler und Warnungen der letzten 100 Stunden aus dem System-Ereignisprotokoll
    .EXAMPLE
        Get-CriticalEvent -Hours 24 -ShowWindow
        liefert Fehler und Warnungen der letzten 24 Stunden aus dem System-Ereignisprotokoll und stellt sie in einem eigenen Fenster dar
    .NOTES
        Dies ist ein Beispiel aus Tobias Weltners' PowerShell Buch
    .LINK
        http://www.powertheshell.com
#>
  param
  (
    # Anzahl der Stunden des Beobachtungszeitraums. Vorgabe ist 48.
    $Hours=48, 
    
    # Wenn dieser Switch-Parameter angegeben wird, erscheint das Ergebnis in einem eigenen Fenster und wird nicht in die Konsole ausgegeben
    [Switch]$ShowWindow
  )

  if ($ShowWindow)
  {
    Set-Alias Out-Default Out-GridView
  }

  $Heute = Get-Date
  $Differenz = New-TimeSpan -Hours $Hours
  $Stichtag = $Heute - $Differenz

  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag |
    Select-Object -Property TimeGenerated, Message | Out-Default
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.1.ps1
************************************************************************
function ConvertTo-Euro
{
  param
  (
    [Parameter(Mandatory=$true,HelpMessage='Der Betrag in Dollar')]
    [Double]
    $Betrag,

    [Double]
    $Wechselkurs = 0.97
  )

  $Ergebnis = $Betrag * $Wechselkurs
  return $Ergebnis
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.10.ps1
************************************************************************
$scriptblock = 
{
    Write-Host 'Write Host'
    Write-Verbose 'Write-Verbose'
    Write-Warning 'Write-Warning'
    Write-Debug 'Write-Debug'
    Write-Information 'Write-Information'
    Write-Output 'Write-Output'
    1..10 | 
      ForEach-Object { 
        Write-Progress -Activity 'Write-Progress' -Status $_ -PercentComplete ($_*10)
        Start-Sleep -Milliseconds 300
      }
}

$ergebnis = & $scriptblock
"Ergebnis geliefert: $ergebnis"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.11.ps1
************************************************************************
$code = 
{
  [CmdletBinding()]
  param()


  Write-Verbose 'Zusatzinformation'
  'Normale Ausgabe'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.12.ps1
************************************************************************
$Zähler = 
{
  begin { $i = 0 }
  process { $i++ }
  end { $i }
}


# wie viele Dienste gibt es?
$anzahl = Get-Service | & $Zähler
"Es gibt $anzahl Dienste."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.13.ps1
************************************************************************
function Get-ObjectCount 
{
  begin { $i = 0 }
  process { $i++ }
  end { $i }
}


# wie viele Dienste gibt es?
$anzahl = Get-Service | Get-ObjectCount
"Es gibt $anzahl Dienste."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.14.ps1
************************************************************************
for ($x = 1000; $x -lt 15000; $x += 300) 
{
  "Frequency $x Hz"
  [Console]::Beep($x, 500)
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.15.ps1
************************************************************************
$aquarium = Get-Service

foreach ($fisch in $aquarium)
{
  $dienstname = $fisch.DisplayName
  "Ich angle gerade $dienstname"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.16.ps1
************************************************************************
$Path = "$env:temp\Testordner"
$existiert = Test-Path -Path $Path

if ($existiert -eq $false)
{
  $null = New-Item -Path $Path -ItemType Directory
  Write-Host 'Ordner neu angelegt'
}
else
{
  Write-Host "Ordner '$Path' existierte schon."
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.17.ps1
************************************************************************
$Code = {
  "A = $a"
  $a = 12
  "A = $a"
}

$a = 1000
& $Code
"Am Ende ist A = $a"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.18.ps1
************************************************************************
$Code = { "Wert = $wert" }

$wert = 1
& $Code 

$wert = 2
& $Code



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.19.ps1
************************************************************************
$wert = 0
$Code = { "Wert = $wert" }.GetNewClosure()

$wert = 1
& $Code 

$wert = 2
& $Code



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.2.ps1
************************************************************************
$code = 
{
  param
  (
    [Parameter(Mandatory=$true,HelpMessage='Der Betrag in Dollar')]
    [Double]
    $Betrag,

    [Double]
    $Wechselkurs = 0.97
  )

  $Ergebnis = $Betrag * $Wechselkurs
  return $Ergebnis
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.20.ps1
************************************************************************
PS> $delegate = { [Version]$_ }
PS> '10.10.100.1', '2.99.1.13', '100.84.12.99' | Sort-Object -Property $delegate
2.99.1.13
10.10.100.1
100.84.12.99



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.21.ps1
************************************************************************
$code = {
    $ergebnis = Get-Service | Where-Object Status -eq Running
}

$code.Ast.FindAll( { $true }, $true) |
  Add-Member -Member ScriptProperty -Name Type -Value { $this.GetType().Name } -PassThru



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.22.ps1
************************************************************************
$code = { 
    @{
        Name = 'Tobias'
        ID = 12
    }
}


$code.CheckRestrictedLanguage([String[]]'', [String[]]'', $null)

& $code



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.23.ps1
************************************************************************
$code = { 
    @{
        Name = 'Tobias'
        ID = 12
        Datum = Get-Date
    }
}


$code.CheckRestrictedLanguage([String[]]'', [String[]]'', $null)

& $code



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.24.ps1
************************************************************************
$code = { 
    @{
        Name = 'Tobias'
        ID = $test
        Datum = Get-Date
    }
}

$test = 100

try
{
    $code.CheckRestrictedLanguage([String[]]@('Get-Date'), [String[]]@('test'), $null)
    & $code
}
catch
{
    Write-Warning "Unzulässig: $_"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.25.ps1
************************************************************************
function Get-HashTable
{
    param
    (
        [Parameter(Mandatory=$true)]
        $Path
    )

    # gesamten Text der Datei einlesen
    $code = Get-Content -Path $Path -Raw
    # eingelesener Text ist soll der Inhalt eines Hashtables sein
    $hashtablecode = "@{$code}"

    # aus diesem Code einen Skriptblock herstellen
    $scriptblock = [ScriptBlock]::Create($hashtablecode)
    try
    {
        # enthõlt der Skriptblock aktive Elemente?
        $scriptblock.CheckRestrictedLanguage([String[]]@(), [String[]]@(), $null)
        # nein, ausf³hren und Hashtable generieren
        & $scriptblock
    }
    catch
    {
        # ja, nicht ausf³hren
        Write-Warning "Gefõhrliche Inhalte in $Path"
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.3.ps1
************************************************************************
$eigenerProzess = Get-Process -id $pid
$fremderProzess = powershell.exe { Get-Process -id $pid }

$eigenerProzess
$fremderProzess



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.4.ps1
************************************************************************
$scriptBlock = { [IntPtr]::Size }

$32bitPowerShell = "$env:windir\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"

& $scriptBlock
& $32bitPowerShell $scriptBlock



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.5.ps1
************************************************************************
$Code = 
{
  # Die letzten 5 Fehler-Eintrõge aus dem System-Logbuch lesen
  Get-EventLog -LogName System -EntryType Error -Newest 5
}

Invoke-Command -ScriptBlock $Code -ComputerName Server_012_win



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.6.ps1
************************************************************************
$Code = 
{
  param
  (
    $LogName = 'System'
  )
  
  Get-EventLog -LogName $LogName -EntryType Error -Newest 5
}

Invoke-Command -ScriptBlock $Code -ComputerName Server_012_win -ArgumentList Application



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.7.ps1
************************************************************************
$scriptblock = 
{
    # Rückgabewerte definieren:
    Write-Output "Hallo", (Get-Date)

    # Alles, was liegen gelassen wird, gehört auch dazu:
    123
    Get-Item -Path $env:windir
}

$ergebnis = & $scriptblock



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.8.ps1
************************************************************************
$scriptblock = 
{
    Get-Date

    return 100

    'Dieser Teil wird nicht mehr erreicht'
}

$ergebnis = & $scriptblock



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\13.9.ps1
************************************************************************
$scriptblock = 
{
    Write-Host 'Gebe Datum aus.' -ForegroundColor DarkGreen -BackgroundColor White
    Get-Date
}

$ergebnis = & $scriptblock
$ergebnis



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.1.ps1
************************************************************************
Get-Service | ForEach-Object -Begin { $start = Get-Date } -Process { if ($_.Status -eq 'Running') { Write-Host $_.DisplayName -ForegroundColor Green } else { Write-Host $_.DisplayName -ForegroundColor Red }} -End { $ende = Get-Date; $dauer = $ende - $start; $millisec = $dauer.TotalMilliSeconds; Write-Warning "Ausführungszeit: $millisec ms" }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.10.ps1
************************************************************************
function Filter-FileSize
{
  param
  (
    [Parameter(Mandatory=$true)]
    [Int]
    $SizeKB,
    
    [Parameter(ValueFromPipeline=$true)]
    [System.IO.FileInfo]
    $File,
    
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Int]
    $Length
  )

  process
  {
    if (($Length/1KB) -ge $SizeKB ) { $File }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.11.ps1
************************************************************************
function Receive-ProcessID
{
  param
  (
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName = $true)]
    [Int]
    $ID
  )

  process
  {
    "bearbeite Prozess-ID $id"
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.12.ps1
************************************************************************
$daten = @'
Name, Vorname, ID
Weltner,Tobias,1
Schröter,Indra,2
Wolters,Patrik,3
'@

$Path = "$env:temp\testdaten.csv"
$daten | Set-Content -Path $Path -Encoding UTF8



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.13.ps1
************************************************************************
function New-User
{
    param
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [string]
        $Name,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [string]
        $Vorname,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [int]
        $ID
    )

    process
    {
        "Hier könnte der User $Vorname $Name mit der ID $ID angelegt werden."
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.14.ps1
************************************************************************
{
  param
  (
    [Parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName = $true)]
    [Alias('Path','FullName')]
    [String]
    $FilePath
  )
  process
  {
    "bearbeite Pfad $FilePath"
  }
}


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.15.ps1
************************************************************************
# diese Webseite untersuchen:
$URL = 'www.tagesschau.de'
$destination = 'c:\webpics'
$existiert = Test-Path -Path $destination
if ($existiert -eq $false) { mkdir $destination }

try
{
  # Inhalt der Webseite abrufen und in $result speichern
  # -UseBasicParsing verhindert Dialogfelder
  $result = Invoke-WebRequest -Uri $URL -UseBasicParsing -ErrorAction Stop

  # alle Images aus der Webseite abrufen
  $result.Images | 
  # und daraus die Eigenschaft "src" auflisten:  
  Select-Object -ExpandProperty src |
  # jede URL nur einmal herunterladen
  Sort-Object -Unique |
  # Links, die Parameter enthalten, wollen wir nicht:
  Where-Object { $_ -notmatch '\?'} |
  # jede einzelne URL nun bearbeiten:
  ForEach-Object { 
    # die empfangene einzelne URL einer eigenen Variable zuweisen:
    $linkUrl = $_

    # wenn die URL nicht mit "http" beginnt...
    if ($linkUrl -notlike 'http*')
    {
      # ...dann eine absolute URL daraus machen, indem die 
      # Adresse der Webseite vorangestellt wird
      $linkUrl = "http://$URL/$linkUrl"
    }

    # Ergebnis wieder zurückgeben:
    $linkUrl
  } | ForEach-Object {
    # wir empfangen eine absolute URL des Bildes:
    $absoluteLinkURL = $_

    # hier sollen die Bilder gespeichert werden:
    $filename = Split-Path -Path $absoluteLinkURL -Leaf
    $destinationPath = Join-Path -Path $destination -ChildPath $filename

    # Bild herunterladen
    $NewPath = $destinationPath
    $Counter = 0
  
    # so lange an den Dateinamen eine Zahl anhängen, bis
    # die Datei nicht mehr existiert:
    While (Test-Path -Path $NewPath)
    {
      # neuen Dateinamen erzeugen
      $Counter++
      $parts = $destinationPath.Split('.')
      $parts[-2]+= "($Counter)"
      $NewPath = $parts -join '.'
    }
  
    Invoke-WebRequest -Uri $absoluteLinkURL -OutFile $NewPath  
  
  }
}
catch {} 

# Bilderordner öffnen
explorer $destination



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.16.ps1
************************************************************************
function Get-NewFilenameIfPresent
{
  param
  (
    [Parameter(Mandatory=$true)]
    [String]
    $Path
  )

  $NewPath = $Path
  $Counter = 0
  
  # so lange an den Dateinamen eine Zahl anhängen, bis
  # die Datei nicht mehr existiert:
  While (Test-Path -Path $NewPath)
  {
    # neuen Dateinamen erzeugen
    $Counter++
    $parts = $Path.Split('.')
    $parts[-2]+= "($Counter)"
    $NewPath = $parts -join '.'
  }
  
  return $NewPath
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.17.ps1
************************************************************************
function ConvertTo-AbsoluteURL 
{ 
  param
  (
    [Parameter(Mandatory = $true, ValueFromPipeline=$true)]
    [string]
    $URL,
        
    [Parameter(Mandatory = $true)]
    [string]
    $WebsiteURL
  )

  begin
  {
    if ($WebsiteURL -notlike 'http*')
    {
      $WebsiteURL = "http://$WebsiteURL"
    }
    
    # Schrägstriche normalisieren
    $WebsiteURL = $WebsiteURL.Replace('\', '/').TrimEnd('/')
    
    # Wurzel der Webseite ermitteln
    $WebsiteURL = ($WebsiteURL -split '(?<=[^/])/')[0,1] -join '/' 
  }
  
  process
  {
    $URL = $URL.Replace('\', '/').TrimStart('/')
    
    # wenn die URL nicht mit "http" beginnt...
    if ($URL -notlike 'http*')
    {
      # ...dann eine absolute URL daraus machen, indem die 
      # Adresse der Webseite vorangestellt wird
      return "$WebsiteURL/$URL"
    }
    else
    {
      # andernfalls unverändert zurückgeben
      return $URL
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.18.ps1
************************************************************************
function Get-ImageFromWebsite
{
  param
  (
    [Parameter(Mandatory = $true)]
    [String]
    $URL ,
    
    [String]
    $Filter = ''
  )


  # Inhalt der Webseite abrufen und in $result speichern
  # -UseBasicParsing verhindert Dialogfelder
  $result = Invoke-WebRequest -Uri $URL -UseBasicParsing

  # alle Images aus der Webseite abrufen
  $result.Images | 
  # und daraus die Eigenschaft "src" auflisten:  
  Select-Object -ExpandProperty src |
  # jede URL nur einmal herunterladen
  Sort-Object -Unique |
  # Links, die Parameter enthalten, wollen wir nicht:
  Where-Object { $_ -notmatch '\?'} |
  ConvertTo-AbsoluteURL -WebsiteURL $URL |
  Where-Object { $_ -like "*$Filter" }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.19.ps1
************************************************************************
function Download-File
{
  param
  (
    [Parameter(Mandatory = $true, ValueFromPipeline=$true)]
    [String]
    $Url,

    [Parameter(Mandatory = $true)]
    [String]
    $DestinationFolder,
    
    [Switch]
    $Force,
    
    [Switch]
    $Open,
    
    [Switch]
    $PassThru
  )

  # dies nur EINMAL am Anfang prüfen:
  begin
  {
    # Sicherstellen, dass der Zielordner existiert
    $existiert = Test-Path -Path $DestinationFolder
    if ($existiert -eq $false) 
    {
      $null = New-Item -Path $DestinationFolder -ItemType Directory
    }
  }

  # dies für ALLE einlaufenden URLs machen:
  process
  {
    # Datei-Zielname aus Link extrahieren:
    $filename = Split-Path -Path $Url -Leaf
    $destinationPath = Join-Path -Path $DestinationFolder -ChildPath $filename

    # Bild herunterladen
    try
    {
      # falls nicht überschrieben werden soll, zuerst prüfen, ob die Datei
      # schon existiert, und gegebenenfalls einen neuen Dateinamen erstellen
      if (!$Force)
      {
        $destinationPath = Get-NewFileNameIfPresent -Path $destinationPath
      }
      Invoke-WebRequest -Uri $Url -OutFile $destinationPath -ErrorAction Stop
      if ($PassThru) { $destinationPath }
    }
    catch
    {
      Write-Warning "$Url wurde nicht gefunden."
    }
  }
  
  end
  {
    if ($Open)
    {
      explorer $destinationFolder
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.2.ps1
************************************************************************
function Watch-Service
{
  begin 
  { 
    $start = Get-Date 
  } 
  
  process 
  { 
    if ($_.Status -eq 'Running') 
    { Write-Host $_.DisplayName -ForegroundColor Green } 
    else 
    { Write-Host $_.DisplayName -ForegroundColor Red }
  } 
  
  end 
  { 
    $ende = Get-Date
    $dauer = $ende - $start
    $millisec = $dauer.TotalMilliSeconds
    Write-Warning "Ausführungszeit: $millisec ms" 
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.3.ps1
************************************************************************
function Watch-Service
{
  param
  (
    [Parameter(ValueFromPipeline=$true)]
    $Dienst
  )

  begin 
  { 
    $start = Get-Date 
  } 
  
  process 
  { 
    if ($Dienst.Status -eq 'Running') 
    { Write-Host $Dienst.DisplayName -ForegroundColor Green } 
    else 
    { Write-Host $Dienst.DisplayName -ForegroundColor Red }
  } 
  
  end 
  { 
    $ende = Get-Date
    $dauer = $ende - $start
    $millisec = $dauer.TotalMilliSeconds
    Write-Warning "Ausführungszeit: $millisec ms" 
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.4.ps1
************************************************************************
function Watch-Service
{
  param
  (
    [Parameter(ValueFromPipeline=$true)]
    $Dienst
  )

  begin 
  { 
    $start = Get-Date 
  } 
  
  process 
  { 
    foreach($Einzeldienst in $Dienst)
    {
      if ($Einzeldienst.Status -eq 'Running') 
      { Write-Host $Einzeldienst.DisplayName -ForegroundColor Green } 
      else 
      { Write-Host $Einzeldienst.DisplayName -ForegroundColor Red }
    }
  } 
  
  end 
  { 
    $ende = Get-Date
    $dauer = $ende - $start
    $millisec = $dauer.TotalMilliSeconds
    Write-Warning "Ausführungszeit: $millisec ms" 
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.5.ps1
************************************************************************
function Find-OldItem
{
  param
  (
    [Int]
    $Days
  )
  
  process
  {
    $CheckDate = (Get-Date).AddDays(-$Days)
    if ($_.LastWriteTime -lt $CheckDate) { $_ }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.6.ps1
************************************************************************
function Find-OldItem
{
  param
  (
    [Parameter(ValueFromPipeline=$true)]
    [System.IO.FileSystemInfo]
    $Item,
    
    [Parameter(Mandatory = $true)]
    [Int]
    $Days
  )
  
  begin
  {
    $CheckDate = (Get-Date).AddDays(-$Days)
  }
  process
  {
    if ($Item.LastWriteTime -lt $CheckDate)
    {
      $Item
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.7.ps1
************************************************************************
function Test-PipelineInput {
  param (
    [Parameter(ValueFromPipeline=$true)]
    [double]
    $Zahl=-1,

    [Parameter(ValueFromPipeline=$true)]
    [datetime]
    $Datum = (Get-Date),

    [Parameter(ValueFromPipeline=$true)]
    [bool]
    $Boolean = $false,

    [Parameter(ValueFromPipeline=$true)]
    $Objekt = $null
  )

  process {
    "Zahl: $Zahl"
    "Datum: $Datum"
    "Ja/Nein: $Boolean"
    "Objekt: $Objekt"
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.8.ps1
************************************************************************
function Test-PipelineInput {
  [CmdletBinding(DefaultParameterSetName='Numerisch')]
  param (
    [Parameter(ValueFromPipeline=$true,ParameterSetName='Numerisch')]
    [double]
    $Zahl=-1,

    [Parameter(ValueFromPipeline=$true,ParameterSetName='Datum')]
    [datetime]
    $Datum = (Get-Date),

    [Parameter(ValueFromPipeline=$true,ParameterSetName='JaNein')]
    [bool]
    $Boolean = $false,

    [Parameter(ValueFromPipeline=$true,ParameterSetName='Text')]
    [string]
    $Text = ''
  )

  process {
    switch ($PSCmdlet.ParameterSetName)
    {
        'Numerisch'   { "Es wurde die Zahl $Zahl übergeben" }
        'Datum'       { "Es wurde das Datum $Datum übergeben" }
        'JaNein'      { "Es wurde der boolsche Wert $Boolean übergeben" }
        'Text'        { "Es wurde der Text $Text übergeben" }
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\14.9.ps1
************************************************************************
function Format-File
{
  param
  (
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]
    $Name,
    
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Int]
    $Length,
    
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]
    $FullName
  )

  process
  {
    "empfange $Name mit Größe $Length von $FullName"
    'empfange {0,-10} mit Größe {1:n1} MB von {2}' -f $Name, ($Length/1MB), $FullName
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\15.1.ps1
************************************************************************
function Get-PathComponent
{
  param
  (
    [Parameter(Mandatory=$true)]
    $Path
  )

  [System.IO.Path]::GetFileName($Path)
  [System.IO.Path]::GetFileNameWithoutExtension($Path)
  [System.IO.Path]::GetExtension($Path)
  [System.IO.Path]::GetDirectoryName($Path)
  [System.IO.Path]::GetPathRoot($Path)
  $Path
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\15.2.ps1
************************************************************************
function Get-PathComponent
{
  param
  (
    [Parameter(Mandatory=$true)]
    $Path
  )

  $erg = 1 | Select-Object -Property Parent, FileName, Extension, Drive, BaseName, Path
  $erg.FileName = [System.IO.Path]::GetFileName($Path)
  $erg.BaseName = [System.IO.Path]::GetFileNameWithoutExtension($Path)
  $erg.Extension = [System.IO.Path]::GetExtension($Path)
  $erg.Parent = [System.IO.Path]::GetDirectoryName($Path)
  $erg.Drive  = [System.IO.Path]::GetPathRoot($Path)
  $erg.Path = $Path
  $erg 
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\15.3.ps1
************************************************************************
function Get-PathComponent{  param  (    [Parameter(Mandatory=$true)]    $Path  )  # Informationen in einem Hashtable hinterlegen:  $hash = [Ordered]@{    FileName = [System.IO.Path]::GetFileName($Path)    BaseName = [System.IO.Path]::GetFileNameWithoutExtension($Path)    Extension = [System.IO.Path]::GetExtension($Path)    Parent = [System.IO.Path]::GetDirectoryName($Path)    Drive  = [System.IO.Path]::GetPathRoot($Path)    Path = $Path  }    # Neues Objekt aus Hashtable herstellen:  New-Object -TypeName PSObject -Property $hash}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\15.4.ps1
************************************************************************
$code = 
{
  '{0:n1} MB' -f ($this/1MB)
}
$zahl = 576235342 | Add-Member -MemberType ScriptMethod -Name toString -Value $code -Force -PassThru



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\15.5.ps1
************************************************************************
function Get-PathComponent 
{   
  param   
  (     
    [Parameter(Mandatory=$true)]     
    $Path   
  )
  # Rückgabewerte in einem Hashtable hinterlegen   
  $hash = [Ordered]@{     
    FileName = [System.IO.Path]::GetFileName($Path)
    BaseName = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    Extension = [System.IO.Path]::GetExtension($Path)
    Parent = [System.IO.Path]::GetDirectoryName($Path)
    Drive  = [System.IO.Path]::GetPathRoot($Path)
    Path = $Path   
  }

  # Aus dem Hashtable ein Objekt herstellen
  $result = New-Object -TypeName PSObject -Property $hash 
      
  # Eigenschaften angeben, die sofort sichtbar sein sollen:
  [string[]]$sichtbar = 'BaseName','Extension','Parent'
  # daraus ein Info-Objekt herstellen, das PowerShell bei der Ausgabe
  # auswertet:
  $typ = 'DefaultDisplayPropertySet'
  [System.Management.Automation.PSMemberInfo[]]$info = 
    New-Object System.Management.Automation.PSPropertySet($typ,$sichtbar)

  # an Rückgabeobjekt anhängen:
  $result | 
    Add-Member -MemberType MemberSet -Name PSStandardMembers -Value $info -PassThru    
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.1.ps1
************************************************************************
function Test-AutoCompleter
{
  param
  (
    [System.ServiceProcess.ServiceStartMode]
    $Modus
  )

  "Gewählt: $Modus"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.10.ps1
************************************************************************
function Ping-Computer
{
  param
  (
    [ValidatePattern('^Server\d{1,3}$')]
    [String]
    $ComputerName = $env:COMPUTERNAME
  )

  # Computer anpingen. Wenn das Ergebnis eine Zahl gefolgt von "ms" liefert,
  # $true zurückliefern, sonst $false:
  (@(ping.exe $ComputerName -n 1 -w 500) -match '\dms').Count -gt 0
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.11.ps1
************************************************************************
function Ping-Computer
{
  param
  (
    [ValidateCount(1,5)]
    [String[]]
    $ComputerName = $env:COMPUTERNAME
  )

  foreach($Name in $ComputerName)
  {
    $info = [Ordered]@{}
    $info.ComputerName = $Name
    $info.Online = (@(ping.exe $Name -n 1 -w 500) -match '\dms').Count -gt 0

    New-Object -TypeName PSObject -Property $info
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.12.ps1
************************************************************************
function Start-Executable
{
  param
  (
    [ValidateScript({ (Get-ChildItem $env:windir\system32 "$_.exe").Count -eq 1})]
    [Parameter(Mandatory=$true)]
    [String]
    $Name
  )

  $path = Join-Path -Path $env:windir\system32 -ChildPath $Name
  Start-Process -FilePath $path
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.13.ps1
************************************************************************
function Test-Binding {
  [CmdletBinding(DefaultParameterSetName='Name')]
  param(
    [Parameter(ParameterSetName='ID', Position=0, Mandatory=$true)][int]$ID,
    [Parameter(ParameterSetName='Name', Position=0, Mandatory=$true)][string]$Name
  )

  $set = $PSCmdlet.ParameterSetName
  "Sie haben Parameterset $set gewählt."

  if ($set -eq 'ID') {
    "Die ID ist $ID"
  } else {
    "Der Name lautet $Name"
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.14.ps1
************************************************************************
function Get-BIOS
{
  [CmdletBinding(DefaultParameterSetName='ParameterSet1')]
  param
  (
    [Parameter(ParameterSetName='ParameterSet1', Position=0, Mandatory=$false)]
    [Parameter(ParameterSetName='ParameterSet2', Mandatory=$true)]
    [String]
    $ComputerName,
    
    [Parameter(ParameterSetName='ParameterSet2', Position=0, Mandatory=$false)]
    [PSCredential]
    $Credential
  )
  
  
  Get-WmiObject -Class Win32_BIOS @PSBoundParameters
  
  
  
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.15.ps1
************************************************************************
function Test-Risk
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param()

    Stop-Service -Name Spooler
    Start-Service -Name Spooler
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.16.ps1
************************************************************************
function Test-Risk
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param()

    $message1 = $env:COMPUTERNAME
    $message2 = 'Spooler-Dienst neu starten'
    $doit = $PSCmdlet.ShouldProcess($message1, $message2)

    if ($doit)
    {
        Stop-Service -Name Spooler
        Start-Service -Name Spooler
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.17.ps1
************************************************************************
function Test-SecondFunction
{
    New-Item -Path $env:TEMP\somefolder -Type Directory -ErrorAction SilentlyContinue
}

function Test-Risk
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param()


    $message1 = $env:COMPUTERNAME
    $message2 = 'Spooler-Dienst neu starten'
    $doit = $PSCmdlet.ShouldProcess($message1, $message2)

    if ($doit)
    {
        Stop-Service -Name Spooler
        Start-Service -Name Spooler
    }

    Test-SecondFunction
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.18.ps1
************************************************************************
function Enable-AutoPageFile {
  [CmdletBinding(SupportsShouldProcess=$True)]
  param()

  $computer = Get-WmiObject -class Win32_ComputerSystem -EnableAllPrivileges
  $computer.AutomaticManagedPagefile=$true
  if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Automatische Auslagerungsdatei einschalten"))
  {
    $computer.Put() | Out-Null
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.19.ps1
************************************************************************
function Configure-System 
{
  [CmdletBinding(ConfirmImpact='High')]
  Param()

  ' Ich werde immer ausgeführt!'
  if ($PSCmdlet.ShouldProcess('Configure-System', 'Änderungen am System'))
  {
    'Ich werde nur ausgeführt, wenn Sie zustimmen!'
  }
  else
  {
    'Ich werde ausgeführt, wenn Sie NICHT zustimmen'
  }
  'Ich werde auch immer ausgeführt!'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.2.ps1
************************************************************************
function Select-Color
{
    param
    (
        [System.ConsoleColor]
        $Color
    )

    "Gewählte Farbe: $Color"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.20.ps1
************************************************************************
function Test-ParameterStatic
{
    param
    (
        [Parameter(Mandatory=$true)]
        [Int]
        $ID,

        [Parameter(Mandatory=$false)]
        [String]
        [ValidateSet('NewYork','Cork','Hannover')]
        $City='Hannover'
    )

    "ID ist $ID und Stadt ist $City"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.21.ps1
************************************************************************
function Test-ParameterDynamic
{
  # Cmdletbinding und param() zwingend nötig
  [CmdletBinding()]
  param()

  # definiert die dynamischen Parameter:
  dynamicparam
  {
    # der "Eimer" sammelt alle dynamischen Parameter und wird
    # am Ende zurückgegeben:
    $Eimer = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary

    # 1. Parameter definieren
    # eine Liste für die Attribute anlegen:
    $ListeAttribute = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]	
    # [Parameter()]-Attribut definieren:
    $AttribParameter = New-Object System.Management.Automation.ParameterAttribute
    $AttribParameter.Mandatory = $true
    # der Attributliste hinzufügen:
    $ListeAttribute.Add($AttribParameter)
    # neuen Parameter mit Name, Typ und Attributen definieren:
    $Parameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter('ID',[Int], $ListeAttribute)
    # in den "Eimer" legen:
    $Eimer.Add('ID', $Parameter)

    # 2. Parameter definieren:
    $ListeAttribute = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]	
    $AttribParameter = New-Object System.Management.Automation.ParameterAttribute
    $AttribParameter.Mandatory = $false
    $ListeAttribute.Add($AttribParameter)

    # ein zusätzliches [ValidateSet()] Attribut hinzufügen:
    $Werte = 'NewYork','Cork','Hannover'
    $AttribValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($Werte)
    $ListeAttribute.Add($AttribValidateSet)

    $Parameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter('City',[String], $ListeAttribute)
    $Eimer.Add('City', $Parameter)

    # die beiden dynamischen Parameter zurückgeben:
    $Eimer
  }

  end
  {
    "ID ist $ID und Stadt ist $City"
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.22.ps1
************************************************************************
function Test-ParameterDynamic
{
  # Cmdletbinding und param() zwingend nötig
  [CmdletBinding()]
  param()

  # definiert die dynamischen Parameter:
  dynamicparam
  {
    # der "Eimer" sammelt alle dynamischen Parameter und wird
    # am Ende zurückgegeben:
    $Eimer = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary

    # 1. Parameter definieren
    # eine Liste für die Attribute anlegen:
    $ListeAttribute = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]	
    # [Parameter()]-Attribut definieren:
    $AttribParameter = New-Object System.Management.Automation.ParameterAttribute
    $AttribParameter.Mandatory = $true
    # der Attributliste hinzufügen:
    $ListeAttribute.Add($AttribParameter)
    # neuen Parameter mit Name, Typ und Attributen definieren:
    $Parameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter('ID',[Int], $ListeAttribute)
    # in den "Eimer" legen:
    $Eimer.Add('ID', $Parameter)

    # 2. Parameter definieren:
    $ListeAttribute = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]	
    $AttribParameter = New-Object System.Management.Automation.ParameterAttribute
    $AttribParameter.Mandatory = $false
    $ListeAttribute.Add($AttribParameter)

    # ein zusätzliches [ValidateSet()] Attribut hinzufügen:
    $Werte = 'NewYork','Cork','Hannover'
    $AttribValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($Werte)
    $ListeAttribute.Add($AttribValidateSet)

    $Parameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter('City',[String], $ListeAttribute)
    $Eimer.Add('City', $Parameter)

    # die beiden dynamischen Parameter zurückgeben:
    $Eimer
  }

  end
  {
    # automatisch alle Werte von verwendeten
    # dynamischen Parametern in Variablen speichern:
    foreach($key in $PSBoundParameters.Keys)
    {
      if ($MyInvocation.MyCommand.Parameters.$key.isDynamic)
      {
        Set-Variable -Name $key -Value $PSBoundParameters.$key
      }
    }
    
    "ID ist $ID und Stadt ist $City"
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.23.ps1
************************************************************************
function Test-ParameterDynamicNeu
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory=$true)]
    [ValidateSet('ChangeLocation','ChangeSomethingElse')]
    $Mode
  )

  dynamicparam
  {
    $Eimer = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary

    # dynamische Parameter nur anzeigen, wenn in -Mode der Wert 'ChangeLocation' gewählt wurde:
    if ($Mode -eq 'ChangeLocation')
    {
  
      $ListeAttribute = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]	
      $AttribParameter = New-Object System.Management.Automation.ParameterAttribute
      $AttribParameter.Mandatory = $true
      $ListeAttribute.Add($AttribParameter)
      $Parameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter('ID',[Int], $ListeAttribute)
      $Eimer.Add('ID', $Parameter)

      $ListeAttribute = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]	
      $AttribParameter = New-Object System.Management.Automation.ParameterAttribute
      $AttribParameter.Mandatory = $false
      $ListeAttribute.Add($AttribParameter)

      $Werte = 'NewYork','Cork','Hannover'
      $AttribValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($Werte)
      $ListeAttribute.Add($AttribValidateSet)

      $Parameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter('City',[String], $ListeAttribute)
      $Eimer.Add('City', $Parameter)
    }
    $Eimer
  }
  

  end
  {
    foreach($key in $PSBoundParameters.Keys)
    {
      if ($MyInvocation.MyCommand.Parameters.$key.isDynamic)
      {
        Set-Variable -Name $key -Value $PSBoundParameters.$key
      }
    }
    "ID ist $ID und Stadt ist $City"
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.24.ps1
************************************************************************
function Test-ParameterDynamicInvoke
{
  [CmdletBinding()]
  param()

  dynamicparam
  {
    [Console]::Beep(440, 300)
  }
  
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.25.ps1
************************************************************************
function ConvertTo-Euro
{
  [CmdletBinding()]
  param(
    # der Betrag der Fremdwährung
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Double]
    $Value
  )

  dynamicparam
  {
    $Eimer = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary

    # zwingenden Parameter "Currency" hinzufügen, der die Umrechungswährungen
    # der EZB enthält:
    $ListeAttribute = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]	
    $AttribParameter = New-Object System.Management.Automation.ParameterAttribute
    $AttribParameter.Mandatory = $true
    $ListeAttribute.Add($AttribParameter)
    
    # gibt es noch keine Währungsliste?
    if ($script:currencies -eq $null)
    {
      # dann aus dem Internet abrufen:
      # dazu als Warnung einmal piepen:
      [Console]::Beep()
      
      $url = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'
      $result = Invoke-RestMethod  -Uri $url
      # Währungsliste in scriptglobaler Variable speichern
      $script:currencies = $result.Envelope.Cube.Cube.Cube.currency
    }
    
    # ValidateSet mit den verfügbaren Währungen hinzufügen:
    # (die Währungen werden jetzt aus der gepufferten skriptglobalen
    # Variable verwendet und NICHT jedes Mal neu von der EZB abgerufen)
    $AttribValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($script:currencies)
    $ListeAttribute.Add($AttribValidateSet)

    $Parameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter('Currency',[String], $ListeAttribute)
    $Eimer.Add('Currency', $Parameter)

    # dynamischen Parameter zurückgeben:
    $Eimer
  }

  # nur EINMAL die aktuellen Wechselkurse am Anfang der Pipeline
  # abrufen und dynamische Parameter in Variablen speichern (begin-Block):
  begin
  {
    # alle dynamischen Parameter in entsprechende
    # Variablen speichern
    foreach($key in $PSBoundParameters.Keys)
    {
      if ($MyInvocation.MyCommand.Parameters.$key.isDynamic)
      {
        Set-Variable -Name $key -Value $PSBoundParameters.$key
      }
    }
  
    # aktuellen Wechselkurs abrufen:
    $url = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'
    $rates = Invoke-RestMethod  -Uri $url
    $rate = $rates.Envelope.Cube.Cube.Cube | 
    Where-Object { $_.currency -eq $Currency} |
    Select-Object -ExpandProperty Rate
  }

  # für JEDES über die Pipeline empfangene Objekt die
  # Berechnung durchführen:
  process
  {
    $result = [Ordered]@{
      Value = $Value
      Currency = $Currency
      Rate = $rate
      Euro = ($Value / $rate)
      Date = Get-Date
    }
    
    # Informationen als Objekt zurückgeben:
    New-Object -TypeName PSObject -Property $result
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.26.ps1
************************************************************************
Add-Type -AssemblyName System.Speech
$Speaker = New-Object System.Speech.Synthesis.SpeechSynthesizer XE "System.Speech.Synthesis.SpeechSynthesizer" 
$Speaker.Rate = -10
$Speaker.Volume = 100
$null = $Speaker.SpeakAsync('I am feeling dizzy!')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.27.ps1
************************************************************************
Add-Type -AssemblyName System.Speech

$speaker = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer -Property @{Rate = -10; Volume = 100}
$null = $Speaker.SpeakAsync('I am feeling dizzy!')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.28.ps1
************************************************************************
Add-Type -AssemblyName System.Speech

$speaker = [System.Speech.Synthesis.SpeechSynthesizer] @{Rate = -10; Volume = 100}
$null = $Speaker.SpeakAsync('I am feeling dizzy!')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.29.ps1
************************************************************************
function New-NetObject
{
  [CmdletBinding()]
  param
  (
    [type]
    $TypeName
  )

  dynamicparam
  {
    if (-not ($TypeName.IsClass -and !$TypeName.GetConstructor([Type]::EmptyTypes)))
    {
      $paramDictionary = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary
      $Properties = $TypeName.GetProperties() | Where-Object CanWrite

      foreach ($Property in $Properties)
      {
        $attributes = New-Object System.Management.Automation.ParameterAttribute
        $attributes.ParameterSetName = '__AllParameterSets'
        $attributes.Mandatory = $false
        $attributeCollection =
          New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
        $attributeCollection.Add($attributes)
        $dynParam1 = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter($Property.Name,
         $Property.PropertyType, $attributeCollection)
        $paramDictionary.Add($Property.Name, $dynParam1)
      }

      $paramDictionary
    }
  }

  end
  {
    $null = $PSBoundParameters.Remove('TypeName')
    $PSBoundParameters -as $TypeName
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.3.ps1
************************************************************************
$typ = [System.ConsoleColor]
$names = $typ.GetEnumNames()
$valuetype = $typ.GetEnumUnderlyingType()

$names | ForEach-Object {
    $result = New-Object PSObject | Select-Object -Property Name, Value
    $result.Name = $_
    $result.Value = [System.Enum]::Parse($typ, $_) -as $valuetype
    $result
} | Format-Table -AutoSize



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.30.ps1
************************************************************************
Add-Type -AssemblyName System.Speech
$speaker = New-NETObject System.Speech.Synthesis.SpeechSynthesizer -Rate 1 -Volume 100
$speaker.Speak('Hello World!')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.31.ps1
************************************************************************
function Test-DynamicParameter
{
  [CmdletBinding()]

  param
  (
    [Parameter(Mandatory=$true)]
    [ValidateSet('FirmaA','FirmaB','FirmaC','FirmaD')]
    # Name der Firma, erlaubt sind nur die im ValidateSet angegebenen
    # Firmennamen 'FirmaA','FirmaB','FirmaC' und 'FirmaD'
    $Firma
  )

  dynamicparam
  {
    # der zweite (dynamische) Parameter -Abteilung wird nur eingeblendet,
    # wenn bereits mit -Firma eine Firma ausgewählt wurde

    # hier stehen für jede Firma die gültigen Werte, die für
    # -Abteilung angegeben werden dürfen:
    $data = @{
      FirmaA = 'Geschäftsführung', 'Marketing', 'Vertrieb'
      FirmaB = 'Marketing', 'Vertrieb'
      FirmaC = 'Geschäftsführung', 'Außendienst', 'Fuhrpark'
      FirmaD = 'Geschäftsführung', 'Gebäudemanagement', 'Fuhrpark'
    }

    # wurde bereits die Firma mit -Firma angegeben?
    if ($Firma)
    {
      # ja, also dynamischen Parameter anlegen:
      $paramDictionary = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary
      $attributeCollection = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]

      # Parameter-Attribute festsetzen:
      $attribute = New-Object System.Management.Automation.ParameterAttribute
      $attribute.ParameterSetName = '__AllParameterSets'
      $attribute.Mandatory = $false
      $attributeCollection.Add($attribute)

      # gültige Werte festsetzen;
      # die gültigen Abteilungsnamen für eine Firma stehen im Hashtable $data
      # $data.$firma liefert also die Liste der für die jeweilige Firma gültigen
      # Abteilungsnamen.
      # Diese werden als ValidateSet dynamisch dem Parameter hinzugefügt:
      $attribute = New-Object System.Management.Automation.ValidateSetAttribute($data.$firma)
      $attributeCollection.Add($attribute)

      # dynamischen Parameter -Abteilung anlegen:
      $Name = 'Abteilung'
      $dynParam = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter($Name,
        [string], $attributeCollection)
      $paramDictionary.Add($Name, $dynParam)

      # Parameter zurückgeben:
      $paramDictionary
    }
  }

  end
  {
    'Die übergebenen Parameter:'
    $PSBoundParameters
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.32.ps1
************************************************************************
$argumente = @{
    LogName = 'System'
    EntryType = 'Error', 'Warning'
    After = (Get-Date).AddDays(-1)
}

Get-EventLog @argumente



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.33.ps1
************************************************************************
function Test-Parameter
{
    param
    (
        $Wert1,
        $Wert2,
        $Wert3
    )

    $PSBoundParameters
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.34.ps1
************************************************************************
function Get-Drive
{
    Get-WmiObject -Class Win32_LogicalDisk |
      Select-Object DeviceID, VolumeName, Size, FreeSpace
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.35.ps1
************************************************************************
function Get-Drive
{
  param
  (
    $ComputerName,
    $Credential
  )

    Get-WmiObject -Class Win32_LogicalDisk @PSBoundParameters |
      Select-Object DeviceID, VolumeName, Size, FreeSpace
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.36.ps1
************************************************************************
function Get-Drive
{
  param
  (
    $ComputerName,
    $Credential,
    [Switch]
    $AsGridView
  )

    $null = $PSBoundParameters.Remove('AsGridView')

    $result = Get-WmiObject -Class Win32_LogicalDisk @PSBoundParameters |
      Select-Object DeviceID, VolumeName, Size, FreeSpace

    if ($AsGridView)
    {
        $result | Out-GridView
    }
    else
    {
        $result
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.37.ps1
************************************************************************
function Test-Optional
{
  param
  (
    $ComputerName = $env:COMPUTERNAME
  )

    if ($PSBoundParameters.ContainsKey('ComputerName') -eq $false)
    {
        $null = $PSBoundParameters.Add('ComputerName', $ComputerName)
    }

    $PSBoundParameters
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.4.ps1
************************************************************************
function Select-Color
{
    param
    (
        [ValidateSet('Red','Green','Blue')]
        [String]
        $Color
    )

    "Gewählte Farbe: $Color"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.5.ps1
************************************************************************
function Find-Enum
{
    param
    (
        $Value = '*',
        $Name = '*',
        [Switch]
        $All
    )

    $default = 'CommonLanguageRuntimeLibrary', 'Microsoft.CSharp.dll',
      'Microsoft.Management.Infrastructure.dll', 'Microsoft.PowerShell.Commands.Management.dll',
      'Microsoft.PowerShell.Commands.Utility.dll', 'System.Configuration.dll',
      'System.Configuration.Install.dll', 'System.Core.dll', 'System.Data.dll',
      'System.DirectoryServices.dll', 'System.dll', 'System.Management.Automation.dll',
      'System.Management.dll', 'System.Transactions.dll', 'System.Xml.dll'

[AppDomain]::CurrentDomain.GetAssemblies() |
  Where-Object { $All -or ($default -contains $_.ManifestModule) } |
  ForEach-Object { try { $_.GetExportedTypes() } catch {} } |
  Where-Object { $_.IsEnum } |
  Where-Object { $_.Name -like $Name } |
  Sort-Object -Property Name |
  ForEach-Object {
    $rv = $_ | Select-Object -Property Name, Values, Source
    $rv.Name = '[{0}]' -f $_.FullName
    $rv.Source = $_.Module.ScopeName
    $rv.Values = [System.Enum]::GetNames($_) -join ', '
    $rv
  } |
  Where-Object { @($_.Values -split ', ') -like $Value }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.6.ps1
************************************************************************
function Test-ParameterCompleter
{
  param
  (
    [System.Net.HttpResponseHeader] 
    $Auswahl
  )

  "gewählt: $Auswahl"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.7.ps1
************************************************************************
$enum = '
using System;

public enum Level
{
    Beginner,
    Advanced,
    Professional,
    GodlikeBeing
}
'
Add-Type -TypeDefinition $enum



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.8.ps1
************************************************************************
function Get-WürfelErgebnis
{
  param
  (
    [ValidateRange(1,3)]
    [Int]
    $Würfe = 1
  )

  for($x=1; $x -le $Würfe; $x++) 
  {
    Get-Random -Minimum 1 -Maximum 7  
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\16.9.ps1
************************************************************************
function Ping-Computer
{
  param
  (
    [ValidateLength(5,10)]
    [String]
    $ComputerName = $env:COMPUTERNAME
  )

  # Computer anpingen. Wenn das Ergebnis eine Zahl gefolgt von "ms" liefert,
  # $true zurückliefern, sonst $false:
  (@(ping.exe $ComputerName -n 1 -w 500) -match '\dms').Count -gt 0
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\17.1.ps1
************************************************************************
function Get-SoftwareUpdate
{
    $Filter = @{
      ProviderName="Microsoft-Windows-WindowsUpdateClient"
      ID=19
    }

  Get-WinEvent -FilterHashtable $filter |
    ForEach-Object {
      $rv = $_ | Select-Object -Property TimeCreated, Name, Activity, Status
      $rv.Name = $_.Properties[0].Value
      $rv.Activity = $_.KeywordsDisplayNames[0]
      $rv.Status = $_.KeywordsDisplayNames[1]
      $rv
    }
  
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\17.2.ps1
************************************************************************
#
# Modulmanifest für das Modul "mysystemtools"
#
# Generiert von: Tobias
#
# Generiert am: 27.10.2015
#

@{

# Die diesem Manifest zugeordnete Skript- oder Binärmoduldatei.
RootModule = 'mysystemtools.psm1'

# Die Versionsnummer dieses Moduls
ModuleVersion = '1.0'

# ID zur eindeutigen Kennzeichnung dieses Moduls
GUID = '2bc09680-d4aa-417a-b503-70eec5a7ae23'

# Autor dieses Moduls
Author = 'Tobias'

# Unternehmen oder Hersteller dieses Moduls
CompanyName = 'Unbekannt'

# Urheberrechtserklärung für dieses Modul
Copyright = '(c) 2015 Tobias. Alle Rechte vorbehalten.'

# Beschreibung der von diesem Modul bereitgestellten Funktionen
# Description = ''

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
# PowerShellVersion = ''

# Der Name des für dieses Modul erforderlichen Windows PowerShell-Hosts
# PowerShellHostName = ''

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
# PowerShellHostVersion = ''

# Die für dieses Modul mindestens erforderliche Microsoft .NET Framework-Version
# DotNetFrameworkVersion = ''

# Die für dieses Modul mindestens erforderliche Version der CLR (Common Language Runtime)
# CLRVersion = ''

# Die für dieses Modul erforderliche Prozessorarchitektur ("Keine", "X86", "Amd64").
# ProcessorArchitecture = ''

# Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden müssen
# RequiredModules = @()

# Die Assemblys, die vor dem Importieren dieses Moduls geladen werden müssen
# RequiredAssemblies = @()

# Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgeführt werden.
# ScriptsToProcess = @()

# Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# TypesToProcess = @()

# Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# FormatsToProcess = @()

# Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcess" angegebenen Moduls importiert werden sollen.
# NestedModules = @()

# Aus diesem Modul zu exportierende Funktionen
FunctionsToExport = '*'

# Aus diesem Modul zu exportierende Cmdlets
CmdletsToExport = '*'

# Die aus diesem Modul zu exportierenden Variablen
VariablesToExport = '*'

# Aus diesem Modul zu exportierende Aliase
AliasesToExport = '*'

# Aus diesem Modul zu exportierende DSC-Ressourcen
# DscResourcesToExport = @()

# Liste aller Module in diesem Modulpaket
# ModuleList = @()

# Liste aller Dateien in diesem Modulpaket
# FileList = @()

# Die privaten Daten, die an das in "RootModule/ModuleToProcess" angegebene Modul übergeben werden sollen. Diese können auch eine PSData-Hashtabelle mit zusätzlichen von PowerShell verwendeten Modulmetadaten enthalten.
PrivateData = @{

    PSData = @{

        # 'Tags' wurde auf das Modul angewendet und unterstützt die Modulermittlung in Onlinekatalogen.
        # Tags = @()

        # Eine URL zur Lizenz für dieses Modul.
        # LicenseUri = ''

        # Eine URL zur Hauptwebsite für dieses Projekt.
        # ProjectUri = ''

        # Eine URL zu einem Symbol, das das Modul darstellt.
        # IconUri = ''

        # 'ReleaseNotes' des Moduls
        # ReleaseNotes = ''

    } # Ende der PSData-Hashtabelle

} # Ende der PrivateData-Hashtabelle

# HelpInfo-URI dieses Moduls
# HelpInfoURI = ''

# Standardpräfix für Befehle, die aus diesem Modul exportiert werden. Das Standardpräfix kann mit "Import-Module -Prefix" überschrieben werden.
# DefaultCommandPrefix = ''

}




c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\17.3.ps1
************************************************************************
$path = "$HOME\Documents\WindowsPowerShell\Modules\MySystemTools\mysystemtools.psd1"
$content = Get-Content -Path $path -Raw
$info = Invoke-Expression $content

$info



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\17.4.ps1
************************************************************************
function Get-SoftwareUpdate
{
    $Filter = @{
      ProviderName="Microsoft-Windows-WindowsUpdateClient"
      ID=19
    }

  Get-WinEvent -FilterHashtable $filter |
    ForEach-Object {
      $rv = $_ | 
  Select-Object -Property TimeCreated, Name, Activity, Status, UserId, TaskDisplayName
      $rv.Name = $_.Properties[0].Value
      $rv.Activity = $_.KeywordsDisplayNames[0]
      $rv.Status = $_.KeywordsDisplayNames[1]
      $rv
    }
  
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\17.5.ps1
************************************************************************
function Get-SoftwareUpdate
{
    $Filter = @{
      ProviderName="Microsoft-Windows-WindowsUpdateClient"
      ID=19
    }

  Get-WinEvent -FilterHashtable $filter |
    ForEach-Object {
      $rv = $_ | 
  Select-Object -Property TimeCreated, Name, Activity, Status, UserId, TaskDisplayName
      $rv.Name = $_.Properties[0].Value
      $rv.Activity = $_.KeywordsDisplayNames[0]
      $rv.Status = $_.KeywordsDisplayNames[1]
      $rv.PSTypeNames.Insert(0,'mySoftwareUpdateResults')
      $rv
    }
  
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\17.6.ps1
************************************************************************
<Configuration>
  <ViewDefinitions>
    <View>
      <Name>UpdateResult</Name>
      <ViewSelectedBy>
        <TypeName>mySoftwareUpdateResults</TypeName>
      </ViewSelectedBy>
      <TableControl>
        <TableHeaders>
          <TableColumnHeader>
            <Label>Date</Label>
            <Width>19</Width>
            <Alignment>left</Alignment>
          </TableColumnHeader>
          <TableColumnHeader>
            <Label>Installed Product</Label>
            <Alignment>left</Alignment>
          </TableColumnHeader>
        </TableHeaders>
        <TableRowEntries>
          <TableRowEntry>
            <Wrap/>
            <TableColumnItems>
              <TableColumnItem>
                <PropertyName>TimeCreated</PropertyName>
              </TableColumnItem>
              <TableColumnItem>
                <PropertyName>Name</PropertyName>
              </TableColumnItem>
            </TableColumnItems>
          </TableRowEntry>
        </TableRowEntries>
      </TableControl>
    </View>
  </ViewDefinitions>
</Configuration>



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\17.7.ps1
************************************************************************
# wird beim Import des Moduls ausgeführt

# <hier könnten zunächst weitere Skripts dot-sourced geladen
# oder Funktionen definiert werden>

Write-Host 'Modul ist geladen.' -ForegroundColor Green

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    # wird beim Entfernen des Moduls ausgeführt
    Write-Host 'Modul ist wieder entfernt.' -ForegroundColor Red
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.1.ps1
************************************************************************
function test
{
  "A ist innerhalb $a"
  $a = 12
  "A ist innerhalb $a"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.10.ps1
************************************************************************
# prüfen, ob das Skript vom Anwender korrekt aufgerufen wurde:
if ($global:MyInvocation -ne $script:MyInvocation)
{
    Write-Warning 'Starten Sie das Skript dotsourced, um die darin enthaltenen Funktionen nutzen zu können!'
    break
}

function New-Function
{
  'Ich bin eine neue Funktion!'
}

Write-Host 'Funktion New-Function ist nun einsatzbereit.' -ForegroundColor Green



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.11.ps1
************************************************************************
$wert = 0

function Increment
{
    $script:wert++
    "Wert ist nun $wert"
}

function Decrement
{
    $script:wert--
    "Wert ist nun $wert"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.2.ps1
************************************************************************
function test
{
  # Variablen auf Grundwerte setzen, die in der Funktion benötigt werden
  $a = $b = $c = $d = 0

  "A ist innerhalb $a"
  $a = 12
  "A ist innerhalb $a"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.3.ps1
************************************************************************
$mySetting = @{}

function Set-SettingA
{
    param($NewValue)
    $mySetting.SettingA = $NewValue
}

function Set-SettingB
{
    param($NewValue)
    $mySetting.SettingB = $NewValue
}

function Get-Setting
{
  $mySetting
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.4.ps1
************************************************************************
function Test-Parameter
{
  param
  (
    [PSObject]
    $Information
  )
  
  $Information.Name = 'Willibald'
}

$objekt = New-Object -TypeName PSObject -Property @{ Name = 'Weltner'; ID = 12 }

$objekt
Test-Parameter -Information $objekt
$objekt



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.5.ps1
************************************************************************
$info = 'Undefined'

function Set-Value
{
    param($NewValue)

    $script:info = $NewValue
}

function Get-Value
{
    "Wert ist $info"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.6.ps1
************************************************************************
function Find-VariableScope
{
  param
  (
    # Name der Variable, die untersucht werden soll:
    $VariableName='MyInvocation'
  )

  # falls versehentlich mit führendem "$" angegeben, dieses entfernen:
  $VariableName = $VariableName.TrimStart('$')

  # 11 Verschachtelungstiefen testen:
  ForEach ($level in (0..10))
  {
    try
    {
      # existiert die Variable im untersuchten Gültigkeitsbereich (Scope)?
      $variable = Get-Variable $VariableName -Scope $level -ErrorAction SilentlyContinue

      if ($variable -eq $null)
      {
        # nein:
        $value = '[not defined]'
      }
      else
      {
        # ja, Inhalt als Text ausgeben:
        $value = $variable.Value | Out-String
      }
    }
    catch
    {
      # falls ein terminierender Fehler auftritt, ist kein übergeordneter
      # Gültigkeitsbereich mehr vorhanden, also abbrechen:
      break
    }

    # Textmeldung zentriert ausgeben:
    '*' * 70
    $text = "Gültigkeitsbereich Nr. $level, Inhalt der Variable '$VariableName':"
    $text = $text.PadLeft([int]($text.Length + ((70 - $text.Length) / 2)))
    $text
    '*' * 70
    # Inhalt der Variable in diesem Gültigkeitsbereich ausgeben:
    $value
  }
}

$testvariable = 100
function testit
{
    $testvariable = 12
    Find-VariableScope testvariable
}

testit



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.7.ps1
************************************************************************
function Get-NestedDepth
{
  ForEach ($level in (1..100))
  {
    try
    {
      $variable = Get-Variable MyInvocation -Scope $level -ErrorAction SilentlyContinue
    }
    catch { return ($level-=2) }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.8.ps1
************************************************************************
function Get-NestLevel
{
    try
    {
    $i = 0
    do 
    {
        $i++
        $null = Get-Variable -Name host -Scope $i
    } while ($true)
    }
    catch
    {
        $i-2
    }
}

function Test-NestLevel
{
    Get-NestLevel
}

Get-NestLevel 
Test-NestLevel



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\19.9.ps1
************************************************************************
function Test-DotSourced
{
    $global:MyInvocation -eq $script:MyInvocation
}

if (Test-DotSourced)
{
    'Skript wurde dot-sourced im Aufruferkontext aufgerufen.'
}
else
{
    'Skript wurde isoliert im eigenen Kontext aufgerufen'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\2.1.ps1
************************************************************************
Import-Module BITSTransfer
$url = 'http://anon.nasa-global.edgesuite.net/HD_downloads/HD_Earth_Views.mov'
Start-BitsTransfer $url $HOME\video1.wmv
Invoke-Item $HOME\video1.wmv



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\20.1.ps1
************************************************************************
Write-Debug 'Beginne'

$fixes = Get-HotFix

Write-Debug 'Vor Schleife'

foreach($fix in $fixes)
{
    Write-Debug 'Ausgabe einzelner Fix'
    $fix.HotfixID
}

Write-Debug 'Fertig'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\20.2.ps1
************************************************************************
function Get-Ast
{
  param
  (
    [ValidateSet('All','Array','ArrayLiteral','AssignmentStatement','Attribute','AttributeBase','Attributed','Binary','BlockStatement','BreakStatement','CatchClause','Command','CommandBase','CommandElement','CommandParameter','Constant','ContinueStatement','Convert','DataStatement','DoUntilStatement','DoWhileStatement','Error','ErrorStatement','ExitStatement','ExpandableString','FileRedirection','ForEachStatement','ForStatement','FunctionDefinition','Hashtable','IfStatement','Index','InvokeMember','LabeledStatement','LoopStatement','Member','MergingRedirection','NamedAttributeArgument','NamedBlock','ParamBlock','Parameter','Paren','Pipeline','PipelineBase','Redirection','ReturnStatement','ScriptBlock','SequencePoint','Statement','StatementBlock','StringConstant','Sub','SwitchStatement','ThrowStatement','TrapStatement','TryStatement','Type','TypeConstraint','Unary','Using','Variable','WhileStatement')]
    $AstType='All',

    [Switch]
    $NonRecurse,
    
    [System.Management.Automation.Language.Ast]
    $Parent=$null
  )
  # analyze current editor code
  $Code = $psise.CurrentFile.Editor.Text
  # provide buckets for errors and tokens
  $Errors = $Tokens = $null
  # ask PowerShell to parse code
  $AST = [System.Management.Automation.Language.Parser]::ParseInput($Code, [ref]$Tokens, [ref]$Errors)
  [bool]$recurse = $NonRecurse.IsPresent -eq $false
  # search for AST instances recursively
  if ($AstType -eq 'All')
  {
    $AST.FindAll({ $true }, $recurse) |
    Where-Object { $Parent -eq $null -or ($_.Extent.StartOffset -ge $Parent.Extent.StartOffset -and $_.Extent.EndOffset -le $Parent.Extent.EndOffset) }
  }
  else
  {
    $AST.FindAll({ $args[0].GetType().Name -like "*$ASTType*Ast" }, $recurse) | Where-Object { $Parent -eq $null -or ($_.Extent.StartOffset -ge $Parent.Extent.StartOffset -and $_.Extent.EndOffset -le $Parent.Extent.EndOffset) }
  }
}


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\20.3.ps1
************************************************************************
function Enable-WriteDebugBreakpoint
{
  [CmdletBinding(DefaultParameterSetName='Output')]
  param
  (
    [Parameter(ParameterSetName='Output')]
    [Switch]
    $VerboseOnly,

    [Parameter(ParameterSetName='Discard')]      
    [Switch]
    $Off
  )
    
  $results = Get-Ast -AstType Command |
  Where-Object { $_.CommandElements } |
  Where-Object { $_.CommandElements[0].Value -eq 'Write-Debug' } |
  ForEach-Object {
    # remove breakpoint on these lines if present
    $line = $_.Extent.StartLineNumber
    Get-PSBreakpoint -Script $psise.CurrentFile.FullPath | 
      Where-Object { $_.Line -eq $line } | 
      Remove-PSBreakpoint
      
    if ($PSCmdlet.ParameterSetName -ne 'Discard') { $_ } 
  } |
  Where-Object { !$VerboseOnly -or (@($_.CommandElements | 
  Where-Object { $_ -is [System.Management.Automation.Language.CommandParameterAst] -and $_.ParameterName -eq 'Verbose'}).Count -gt 0) } |
  ForEach-Object {
    $line = $_.Extent.StartLineNumber
    $argument = $_.CommandElements | Select-Object -Skip 1 | 
      Where-Object { $_ -is [System.Management.Automation.Language.StringConstantExpressionAst] } | 
      Select-Object -First 1 -ExpandProperty Value
    
    Get-PSBreakpoint -Script $psise.CurrentFile.FullPath | 
      Where-Object { $_.Line -eq $line } | 
      Remove-PSBreakpoint
      
    $null = Set-PSBreakpoint -Script $psise.CurrentFile.FullPath -Line $line -Action { Write-Host "Breaking at '$argument'" -ForegroundColor Yellow; break; }.GetNewClosure()
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\20.4.ps1
************************************************************************
Write-Debug 'Beginne'

$fixes = Get-HotFix

Write-Debug 'Vor Schleife'

foreach($fix in $fixes)
{
    Write-Debug 'Ausgabe einzelner Fix' -Verbose
    $fix.HotfixID
}

Write-Debug 'Fertig'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\20.5.ps1
************************************************************************
for ($i = 1; $i -lt 10000; $i++)
{ 
    Start-Sleep -Seconds 1
    Write-Warning "Processing $i..."
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.1.ps1
************************************************************************
filter Get-ErrorDetail
{
    $Category = @{
        Name = 'Category'
        Expression = { $_.CategoryInfo.Category }
    }

    $Exception = @{
        Name = 'Exception'
        Expression = { $_.Exception.Message }
    }

    $LineNumber = @{
        Name = 'Line'
        Expression = { $_.InvocationInfo.ScriptLineNumber }
    }

    $ScriptName = @{
        Name = 'Script'
        Expression = { $_.InvocationInfo.ScriptName }
    }

    $Target = @{
        Name = 'Target'
        Expression = { $_.TargetObject }
    }

    $ErrorID = @{
        Name = 'ErrorID'
        Expression = { $_.FullyQualifiedErrorID }
    }

    $Input |
      Select-Object $Category, $Exception, $LineNumber, $ScriptName, $Target, $ErrorID
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.10.ps1
************************************************************************
try
{
    # Cmdletfehler, benötigt ErrorAction=Stop
    $ErrorActionPreference = 'Stop'
    Get-ChildItem -Path GibtEsNicht
}
catch
{
    # Objektstruktur in $_ visualisieren:
    $_ | Format-Custom -Property * -Depth 1 -Force 
    # Fehlerinformationen mit der Funktion Get-ErrorDetail
    # auswerten (Funktion muss wie beschrieben vorher
    # definiert worden sein)
    $_ | Get-ErrorDetail | Out-GridView
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.11.ps1
************************************************************************
try
{
  Write-Host 'Ich starte'
  Start-Sleep -Seconds 3
  Write-Host 'Ich bin fertig'
}
finally
{
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.12.ps1
************************************************************************
try
{
  Write-Host 'Ich starte'
  Start-Sleep -Seconds 300
}
finally
{
  Write-Host 'Ich bin fertig'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.13.ps1
************************************************************************
try
{
  'Ich starte'
  Start-Sleep -Seconds 30
}
finally
{
  'Ich bin fertig'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.14.ps1
************************************************************************
'Starte.'

Get-ChildItem -Path c:\gibtesnicht

try
{
  # alle Fehler abfangen:
  $Backup = $ErrorActionPreference
  $ErrorActionPreference = 'Stop'

  1/$null
  Get-Process -Name gibtsnicht
  net user gibtsnicht
}
catch
{
  "Fehler: $_"
}
finally
{
  # vorheriges Fehlerverhalten wiederherstellen:
  $ErrorActionPreference = $Backup
}

'Fertig.'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.15.ps1
************************************************************************
# alle Fehler abfangen:
$Backup = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

trap
{
  "Fehler: $_"

  # Fehler ist behandelt, also nicht an PowerShell weitergeben:
  continue
}

'Starte.'

Get-ChildItem -Path c:\gibtesnicht
1/$null
Get-Process -Name gibtsnicht
net user gibtsnicht

# vorheriges Fehlerverhalten wiederherstellen:
$ErrorActionPreference = $Backup

'Fertig.'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.16.ps1
************************************************************************
$Backup = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

trap
{
  "Fehler: $_"

  # Fehler ist behandelt, also nicht an PowerShell weitergeben:
  continue
}

'Starte.'

Get-ChildItem -Path c:\gibtesnicht

& {
    1/$null
    Get-Process -Name gibtsnicht
    net user gibtsnicht
}

# vorheriges Fehlerverhalten wiederherstellen:
$ErrorActionPreference = $Backup

'Fertig.'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.17.ps1
************************************************************************
try
{
  # diesen Fehler analysieren:
  1/0
}
catch
{
  if ($_.Exception.InnerException)
  {
    Write-Warning $_.Exception.InnerException.GetType().FullName 
  }
  else
  {
    Write-Warning $_.Exception.GetType().FullName 
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.18.ps1
************************************************************************
try
{
  1/0
}
catch [System.DivideByZeroException]
{
  Write-Warning 'Es wurde durch null geteilt!'
}
catch
{
  Write-Warning "Allgemeiner Fehler: $_"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.19.ps1
************************************************************************
try
{
  $null = New-Item -Path c:\willibald -ItemType Directory -ErrorAction Stop
}
catch [System.IO.IOException]
{
  Write-Warning "IO-Fehler: $_"
}
catch [System.Management.Automation.DriveNotFoundException]
{
  Write-Warning 'Laufwerk nicht gültig'
}
catch [System.UnauthorizedAccessException]
{
  Write-Warning 'Fehlende Zugriffsrechte'
}
catch [System.NotSupportedException]
{
  Write-Warning "Nicht unterstützt: $_"
}
catch
{
  Write-Warning ('Unbekannter Fehler: {0} (Typ: [{1}])' -f $_, $_.Exception.GetType().FullName)
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.2.ps1
************************************************************************
$ListEXE = Get-ChildItem -Path $env:windir -Recurse -Filter *.exe -ErrorVariable fehler -ErrorAction SilentlyContinue
$listProc = Get-Process -FileVersionInfo -ErrorVariable +fehler -ErrorAction SilentlyContinue

"Fehler insgesamt: {0}" -f $fehler.Count

$fehler | Get-ErrorDetail | Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.20.ps1
************************************************************************
# alle Fehler abfangen:
$Backup = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

trap [System.DivideByZeroException]
{
  Write-Warning 'Sie haben durch null dividiert'
  continue
}

trap [System.Management.Automation.ItemNotFoundException]
{
  Write-Warning "Ein Element wurde nicht gefunden: $_"
  continue
}

trap [Microsoft.PowerShell.Commands.ProcessCommandException]
{
  Write-Warning 'Sie haben Get-Process einen Prozessnamen genannt, aber solch ein Programm läuft nicht.'
  continue
}

trap [System.Management.Automation.RemoteException]
{
  Write-Warning "Es ist ein Problem beim Aufruf eines Konsolenbefehls aufgetreten: $_"
  continue
}

trap [System.Management.Automation.DriveNotFoundException]
{
  Write-Warning 'Laufwerk nicht gültig'
  continue
}

trap [System.UnauthorizedAccessException]
{
  Write-Warning 'Fehlende Zugriffsrechte'
  continue
}

trap [System.NotSupportedException]
{
  Write-Warning "Nicht unterstützt: $_"
  continue
}

trap
{
  Write-Warning ('Unbekannter Fehler: {0} (Typ: [{1}])' -f $_, $_.Exception.GetType().FullName)
  continue
}

Get-ChildItem -Path c:\gibtesnicht
Get-ChildItem -Path h:\
$null = New-Item -Path c:\windows\test -ItemType Directory
1/$null
Get-Process -Name gibtsnicht
net.exe user gibtsnicht

# vorheriges Fehlerverhalten wiederherstellen:
$ErrorActionPreference = $Backup



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.21.ps1
************************************************************************
# alle Fehler abfangen:
$Backup = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

trap [System.DivideByZeroException]
{
  Write-Warning 'Sie haben durch null dividiert'
  continue
}

# Stop-Fehler behandeln:
trap [System.Management.Automation.ActionPreferenceStopException]
{
  # Originalfehler ausgeben und behandeln
  throw $_.Exception
  continue

  trap [System.Management.Automation.ItemNotFoundException]
  {
    Write-Warning "Ein Element wurde nicht gefunden: $_"
    continue
  }

  trap [Microsoft.PowerShell.Commands.ProcessCommandException]
  {
    Write-Warning 'Sie haben Get-Process einen Prozessnamen genannt, aber solch ein Programm läuft nicht.'
    continue
  }

  trap [System.Management.Automation.RemoteException]
  {
    Write-Warning "Es ist ein Problem beim Aufruf eines Konsolenbefehls aufgetreten: $_"
    continue
  }

  trap [System.Management.Automation.DriveNotFoundException]
  {
    Write-Warning 'Laufwerk nicht gültig'
    continue
  }

  trap [System.UnauthorizedAccessException]
  {
    Write-Warning 'Fehlende Zugriffsrechte'
    continue
  }

  trap [System.NotSupportedException]
  {
    Write-Warning "Nicht unterstützt: $_"
    continue
  }

  trap
  {
    Write-Warning ('Unbekannter Fehler: {0} (Typ: [{1}])' -f $_, $_.Exception.GetType().FullName)
    continue
  }
}

trap
{
  Write-Warning ('Unbekannter Fehler: {0} (Typ: [{1}])' -f $_, $_.Exception.GetType().FullName)
  continue
}

Get-ChildItem -Path c:\gibtesnicht
Get-ChildItem -Path h:\
$null = New-Item -Path c:\windows\test -ItemType Directory
1/$null
Get-Process -Name gibtsnicht
net.exe user gibtsnicht

# vorheriges Fehlerverhalten wiederherstellen:
$ErrorActionPreference = $Backup



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.22.ps1
************************************************************************
function Invoke-ScriptBlock
{

  param
  (
    [ScriptBlock]
    [Parameter(Mandatory = $true)]
    $ScriptBlock
  )
  
  $ErrorActionPreference = 'Stop'
  try
  {
    $ScriptBlock.Invoke()
  }

  catch [System.Management.Automation.ItemNotFoundException]
  {
    Write-Warning "Ein Element wurde nicht gefunden: $_"
  }

  catch [System.DivideByZeroException]
  {
    Write-Warning 'Sie haben durch null dividiert'
  }

  catch [Microsoft.PowerShell.Commands.ProcessCommandException]
  {
    Write-Warning 'Sie haben Get-Process einen Prozessnamen genannt, aber solch ein Programm läuft nicht.'
  }

  catch [System.Management.Automation.RemoteException]
  {
    Write-Warning "Es ist ein Problem beim Aufruf eines Konsolenbefehls aufgetreten: $_"
  }

  catch
  {
    Write-Warning "Es ist ein allgemeiner Fehler aufgetreten: $_"
  }
}

Invoke-ScriptBlock { Get-ChildItem -Path c:\gibtesnicht }
Invoke-ScriptBlock { Get-Process -Name gibtsnicht }
Invoke-ScriptBlock { net.exe user gibtsnicht }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.23.ps1
************************************************************************
function Invoke-ScriptBlock
{

  param
  (
    [ScriptBlock]
    [Parameter(Mandatory = $true)]
    $ScriptBlock
  )
  
  $ErrorActionPreference = 'Stop'
  try
  {
    $ScriptBlock.Invoke()
  }
  
  catch [System.DivideByZeroException]
  {
    Write-Warning 'Sie haben durch null dividiert'
  }
  
  catch [System.Management.Automation.ActionPreferenceStopException]
  {
    try
    {
      Throw $_.Exception
    }
    catch [System.Management.Automation.ItemNotFoundException]
    {
      Write-Warning "Ein Element wurde nicht gefunden: $_"
    }

    catch [Microsoft.PowerShell.Commands.ProcessCommandException]
    {
      Write-Warning 'Sie haben Get-Process einen Prozessnamen genannt, aber solch ein Programm läuft nicht.'
    }

    catch [System.Management.Automation.RemoteException]
    {
      Write-Warning "Es ist ein Problem beim Aufruf eines Konsolenbefehls aufgetreten: $_"
    }
    
    catch
    {
      Write-Warning "Es ist ein allgemeiner Fehler aufgetreten: $_"
    }
  }
  
  catch
  {
    Write-Warning "Es ist ein allgemeiner Fehler aufgetreten: $_"
  }
}

Invoke-ScriptBlock { Get-ChildItem -Path c:\gibtesnicht }
Invoke-ScriptBlock { 1/$null }
Invoke-ScriptBlock { Get-Process -Name gibtsnicht }
Invoke-ScriptBlock { net.exe user gibtsnicht }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.24.ps1
************************************************************************
function Get-DerivedException {
  param
  (
    [Parameter(Mandatory=$true)]
    $ExceptionName
  )

  # alle geladenen .NET-Assemblys...
  [AppDomain]::CurrentDomain.GetAssemblies() |
    # ...auf alle exportierten Typen durchsuchen (falls möglich)...
    ForEach-Object { try {$_.GetExportedTypes()} catch {} } |
    # ...aber nur solche, die im Namen "Exception" tragen...
    Where-Object { $_.Name -like '*Exception*' } |
    # ...und nur solche, die vom angegebenen Typ abgeleitet sind...
    Where-Object { $_.BaseType -like $ExceptionName } |
    # ...und davon bitte den Namen:
    Select-Object -ExpandProperty Name
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.25.ps1
************************************************************************
trap [System.ArithmeticException] {
  'Fehler in arithmetischer Operation'
  continue
}

trap [System.Exception] {
  'Allgemeine Exception'
  continue
}

trap [System.DivideByZeroException] {
  'Fehler beim Teilen durch Null'
  continue
}

trap {
  'Allgemeiner Fehler'
  continue
}

1/$null



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.26.ps1
************************************************************************
& {
  trap [System.ArithmeticException] {
    'Fehler in arithmetischer Operation'
    break
  }
  & {
    trap [System.Exception] {
      'Allgemeine Exception'
      break
    }

    & {
      trap [System.DivideByZeroException] {
        'Fehler beim Teilen durch Null'
        break
      }

      & {
        trap {
          'Allgemeiner Fehler'
          break
        }

        1 / $null
      }
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.27.ps1
************************************************************************
function Get-Alter 
{
  param
  (
    [Parameter(Mandatory=$true)]
    $datum
  )
  if (-not ($datum -as [DateTime])) {
    'Sie haben kein Datum angegeben!'
    break
  }
  $differenz = New-TimeSpan ($datum -as [DateTime])
  'Sie sind {0} Tage alt!' -f $differenz.Days
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.28.ps1
************************************************************************
function Get-Alter 
{
  param
  (
    [Parameter(Mandatory=$true)]
    $datum
  )
  if (-not ($datum -as [DateTime])) {
    Throw "'$datum' ist kein gültiges Datum."
  }
  $differenz = New-TimeSpan ($datum -as [DateTime])
  'Sie sind {0:n0} Tage alt!' -f $differenz.Days
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.29.ps1
************************************************************************
do
{
  $ok = $false
  try
  {
    Get-Alter
    $ok = $true
  }
  catch
  {
    Write-Warning "Bitte geben Sie ein gültiges Datum ein!"
  }
} until ($ok)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.3.ps1
************************************************************************
# Standardwerte für Fehlerhandling setzen
$PSDefaultParameterValues_old = $PSDefaultParameterValues
$ErrorActionPreference_old = $ErrorActionPreference

$fehler = $null
$PSDefaultParameterValues =@{}
$PSDefaultParameterValues.Add('*:ErrorVariable','+fehler')
$ErrorActionPreference = 'SilentlyContinue'


$ListEXE = Get-ChildItem -Path $env:windir -Recurse -Filter *.exe 
$listProc = Get-Process -FileVersionInfo 

"Fehler insgesamt: {0}" -f $fehler.Count

$fehler | Get-ErrorDetail | Out-GridView

# vorherige Werte zurücksetzen
$PSDefaultParameterValues = $PSDefaultParameterValues_old
$ErrorActionPreference = $ErrorActionPreference_old



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.30.ps1
************************************************************************
do
{
  $datum = Read-Host -Prompt 'Datum eingeben'
} until ($datum -as [DateTime])

$differenz = New-TimeSpan $datum
'Sie sind {0:n0} Tage alt!' -f $differenz.Days



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.31.ps1
************************************************************************
Get-ChildItem -Path $env:windir -Recurse -ErrorAction SilentlyContinue | 
  ForEach-Object -Begin { 
    $c = 0 
  } -Process { 
    # empfangene Elemente zählen
    $c++

    # wenn mehr als 5 Elemente empfangen wurden, einen Fehler auslösen:
    if ($c -gt 5) { Throw 'Ich habe fünf Elemente, mehr will ich nicht!' } 
    
    # empfangenes Element ausgeben
    $_ 
  }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.32.ps1
************************************************************************
$e = Get-ChildItem -Path $env:windir -Recurse -ErrorAction SilentlyContinue | 
  Select-Object -First 5
$e



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.33.ps1
************************************************************************
$stichtag = Get-Date -Hour 0 -Minute 0 -Second 0
$anmeldungen = Get-EventLog -LogName Security -InstanceId 4624 -After $stichtag
$anmeldungen.Count
$anmeldungen | Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.34.ps1
************************************************************************
$stichtag = Get-Date -Hour 0 -Minute 0 -Second 0

# Scheife, die nur EINMAL läuft:
$anmeldungen = do
{
  Get-EventLog -LogName Security -InstanceId 4624 |
  ForEach-Object {
    # wenn ein Eintrag empfangen wird, der VOR dem Stichtag liegt, 
    # abbrechen:
    if ($_.TimeGenerated -lt $Stichtag) { continue }
    # andernfalls Ergebnis zurückgeben:
    $_
  }
} while ($false)

$anmeldungen.Count
$anmeldungen | Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.4.ps1
************************************************************************
try
{
    1/0
}
catch
{
    Write-Warning $_.Exception.Message
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.5.ps1
************************************************************************
$computer = Read-Host -Prompt 'Geben Sie Computernamen ein'

try
{
    [System.Net.DNS]::GetHostByName($Computer)
}
catch
{
    Write-Warning $_.Exception.InnerException.Message
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.6.ps1
************************************************************************
try
{
  New-Item -Path c:\neuerordner -Type Directory
  'Erfolgreich angelegt.'
}
catch
{
  "Fehler aufgetreten: $_"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.7.ps1
************************************************************************
try
{
  New-Item -Path c:\neuerordner -Type Directory -ErrorAction Stop
  'Erfolgreich angelegt.'
}
catch
{
  "Fehler aufgetreten: $_"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.8.ps1
************************************************************************
try
{
  # der folgende Computer muss via Netzwerk erreichbar sein
  # (ggfs. Namen anpassen)
  $Computer = 'testcomputer'
  Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer -Credential Unbekannt
}
catch
{
  "Fehler aufgetreten: $_"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\21.9.ps1
************************************************************************
try
{
    # Cmdlet-Fehler, benötigt ErrorAction=Stop
    $ErrorActionPreference = 'Stop'
    Get-ChildItem -Path GibtEsNicht
}
catch
{
    "Fehler entdeckt: $_"
}

try
{
    # Konsolenbefehl-Fehler benötigt ErrorAction=Stop
    # und Umleitung des Fehlerkanals
    $ErrorActionPreference = 'Stop'
    net user GibtEsNicht 2>&1
}
catch
{
    "Fehler entdeckt: $_"
}

try
{
    # .NET-Fehler benötigt keine besondere ErrorAction
    [System.Net.DNS]::GetHostByName('gibtesnicht')
}
catch
{
    "Fehler entdeckt: $_"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\22.1.ps1
************************************************************************
function Test-NetworkPort
{
  param
  (
    $ComputerName = $env:COMPUTERNAME,

    [int32[]]
    [Parameter(ValueFromPipeline=$true)]
    $Port = $(137..139 + 445 + 5985),

    [int32]
    $Timeout=1000,

    [switch]
    $AllResults
  )

  process
  {
    $count = 0
    ForEach ($PortNumber in $Port)
    {
      $count ++
      $perc = $count * 100 / $Port.Count
      Write-Progress -Activity "Scanning on \\$ComputerName" -Status "Port $PortNumber" -PercentComplete $perc

      # in PowerShell 2.0 muss [Ordered] entfernt werden
      # dann ist die Reihenfolge der Eigenschaften aber zufällig.
      $result = New-Object PSObject -Property ([Ordered]@{
        Port="$PortNumber"; Open=$False; Type='TCP'; ComputerName=$ComputerName})

      $TCPClient = New-Object System.Net.Sockets.TcpClient
      $Connection = $TCPClient.BeginConnect($ComputerName, $PortNumber, $null, $null)

      try
      {
        if ($Connection.AsyncWaitHandle.WaitOne($Timeout, $false))
        {
          $null = $TCPClient.EndConnect($Connection)
          $result.Open = $true
        }
      }
      catch {} finally { $TCPClient.Close() }

      $result | Where-Object { $AllResults -or $_.Open }
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.1.ps1
************************************************************************
function Test-PSRemoting
{
  # WinRM-Dienst
  $service = Get-Service -Name WinRM

  # Firewall-Ausnahmen...
  $firewall = @(Get-NetFirewallRule -Name WINRM-HTTP-In* | 
                  # ...die nicht disabled sind
                  Where-Object { $_.Enabled -eq $true })

  # Unterstützung für lokale Adminkonten
  $Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system'
  $key = Get-ItemProperty -Path $Path

  # WSMan Listener
  $Application = 'winrm/config/Listener'
  $Selector = @{Address='*';Transport='http'}
  $listener = @(Get-WSManInstance $Application -SelectorSet $Selector)

  # PSSessionConfigurations...
  $config = @(Get-PSSessionConfiguration |
                  # ...die nicht disabled sind 
                  Where-Object { $_.SecurityDescriptorSDDL -notlike '*(D;;GA;;;NU)*' })

  $test = [Ordered]@{
      'WinRM-Service läuft' = $service.Status -eq 'Running'
      'Firewall erlaubt Zugriff' = $firewall.Count -eq 2
      'Unterstützung für lokale Adminkonten' = $key.LocalAccountTokenFilterPolicy -eq 1
      'WSMan-Listener konfiguriert' = $listener.Count -gt 0
      'PSSessionConfigurations aktiv' = $config.Count -gt 0
  }

  New-Object -TypeName PSObject -Property $test
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.10.ps1
************************************************************************
$remotecode = 
{
  Get-WmiObject Win32_OperatingSystem -ComputerName storage1 |
    Select-Object -ExpandProperty Caption
}

Invoke-Command -ScriptBlock $code -ComputerName testserver -Authentication Credssp -Credential "$env:USERDOMAIN\$env:USERNAME"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.11.ps1
************************************************************************
# Hinweis: wenn Sie den lokalen Computer abfragen wollen,
# muss dieses Skript mit Administrator-Rechten ausgeführt 
# werden

# diesen Computer mit aktueller Identität abfragen
$Computer1 = 'dell1'

# diesen Computer mit dem Benutzerkonto "PSRemoting" abfragen
# (Konto muss auf dem Computer existieren und über Adminrechte verfügen)
$Computer2 = 'tobiasair1'
$Credential2 = Get-Credential -Credential PSRemoting

# ein leeres Array anlegen:
$Sessions = @()
# nacheinander beliebig viele manuell konfigurierte Sessions hinzufügen
$Sessions += New-PSSession -ComputerName $Computer1
$Sessions += New-PSSession -ComputerName $Computer2 -Credential $Credential2

# Code, der in den Sessions ausgeführt werden soll:
$code = 
{
  # Systeminventar als CSV generieren und in Objekte wandeln:
  $Spaltennamen = 'Hostname',
  'Betriebssystemname',
  'Betriebssystemversion',
  'Betriebssystemhersteller',
  'Betriebssystemkonfiguration',
  'BetriebssystemBuildtyp',
  'RegistrierterBenutzer',
  'RegistrierteOrganisation',
  'ProduktID',
  'Installationsdatum',
  'Systemstartzeit',
  'Systemhersteller',
  'Systemmodell',
  'Systemtyp',
  'Prozessor',
  'BIOSVersion',
  'WindowsVerzeichnis',
  'SystemVerzeichnis',
  'Startgeraet',
  'Systemgebietsschema',
  'Eingabegebietsschema',
  'Zeitzone',
  'GesamterPhysischerSpeicher',
  'VerfügbarerPhysischerSpeicher',
  'VirtuellerArbeitsspeicherMax',
  'VirtuellerArbeitsspeicherVerfügbar',
  'VirtuellerArbeitsspeicherVerwendet',
  'Auslagerungsdateipfad',
  'Domaene',
  'Anmeldeserver',
  'Hotfixes',
  'Netzwerkkarte',
  'HyperV'
                    


  systeminfo.exe /FO CSV | 
  Select-Object -Skip 1 |
  ConvertFrom-CSV -Header $Spaltennamen
}

# Code in allen Sessions gleichzeitig ausführen:
Invoke-Command -ScriptBlock $code -Session $sessions | 
  Out-GridView -Title Systemübersicht

# Sessions am Ende entfernen
Remove-PSSession -Session $Sessions



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.12.ps1
************************************************************************
$befehl = { systeminfo.exe /FO CSV | ConvertFrom-CSV  }

$remotecode = 
{ 
    param($Code)
    $job = Start-Job ([ScriptBlock]::Create($Code)) -Name Aufgabe1
    $null = Wait-Job $job 
    Receive-Job -Name Aufgabe1
    Remove-Job -Name Aufgabe1
}  

Invoke-Command -ComputerName dell1 -ArgumentList $befehl -ScriptBlock $remotecode



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.13.ps1
************************************************************************
$computername = 'server02'

Connect-WSMan $computername
Get-ChildItem -Path "wsman:\$computername\plugin\*\Filename" |
      Where-Object Value -like '*pwrshplugin.dll' | ForEach-Object {Split-Path -Leaf $_.PSParentPath }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.14.ps1
************************************************************************
# Pfadname zu einer neuen pssc-Datei festlegen
$Path = "$env:temp\DruckerAdmin.pssc"

# Datei anlegen
New-PSSessionConfigurationFile -Path $Path –SessionType RestrictedRemoteServer -LanguageMode NoLanguage –ExecutionPolicy Restricted –ModulesToImport PrintManagement -VisibleFunctions Get-Printer, Add-Printer

# Dateiinhalt anzeigen
notepad $path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.15.ps1
************************************************************************
# Pfadname zu einer neuen pssc-Datei festlegen
$Path = "$env:temp\DruckerAdmin.pssc"

# erlaubte Befehle definieren
$stopComputer = @{
  Name = 'Stop-Computer'
  Parameters = @{Name = 'Force'}
}

$stopService = @{
  Name = 'Stop-Service'
  Parameters = @{Name = 'Name'; ValidateSet = 'Spooler', 'WebClient' }
}

$getWMIObject = @{
  Name = 'Get-WMIObject'
  Parameters = @{Name = 'Class'; ValidatePattern = 'Win32_.*' }, @{Name = 'ComputerName'; ValidatePattern = 'server\d{1,4}' }
}



# Datei anlegen
New-PSSessionConfigurationFile -Path $Path –SessionType RestrictedRemoteServer -LanguageMode NoLanguage –ExecutionPolicy Restricted -VisibleCmdlets $stopservice, $stopcomputer, $getWMIObject

# Endpunkt anlegen
Register-PSSessionConfiguration -Path $Path -Name ServerAdmins -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.16.ps1
************************************************************************
# Anmeldeinformationen für den Benutzer angeben,
# unter dem der Endpunkt ausgeführt werden soll
$msg = 'Geben Sie das Konto an, unter dem dieser Endpunkt ausgeführt werden soll!'
$Credential = Get-Credential -UserName PSRemoting -Message $msg

# Pfadname zu einer neuen pssc-Datei festlegen
$Path = "$env:temp\jea1.pssc"

# eigene Funktionen festlegen

# Get-UserInfo liefert den Wert von $PSSenderInfo zurück
# darin ist der Name des aufrufenden Anwenders zu finden
$getUserInfo = @{
  Name='Get-UserInfo'

  ScriptBlock=
  { 
    $PSSenderInfo 
  }
}

# Restart-Computer startet nur die Computer neu, die in einer
# Whitelist zugelassen sind
$restartServer = @{
  Name='Restart-Server'

  ScriptBlock=
  { 
    param
    (
      [Parameter(Mandatory=$true)]
      [String[]]
      $ComputerName
    )
    
    # Liste der zugelassenen Servernamen:
    $WhiteList = 'server1', 'exch12', $env:COMPUTERNAME
    
    $ComputerName |
      Foreach-Object {
        # ist der Servername zugelassen?
        if ($WhiteList -notcontains $_)
        {
          Write-Warning "$_ kann nicht neu gestartet werden. Fehlende Berechtigungen."
        }
        else
        {
          $_
        } 
      } |
      Restart-Computer -WhatIf  # <- ACHTUNG: erst wenn -WhatIf entfernt wird, 
                                # werden Systeme tatsächlich neu gestartet!
  }
}

# Datei anlegen
New-PSSessionConfigurationFile -Path $Path –SessionType RestrictedRemoteServer -LanguageMode NoLanguage –ExecutionPolicy Restricted -FunctionDefinitions $getUserInfo, $restartServer 

# Endpunkt anlegen:
Register-PSSessionConfiguration -Name ServerAdmins -Path $Path -RunAsCredential $Credential -ShowSecurityDescriptorUI -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.17.ps1
************************************************************************
function Limit-Runspace
{
  [CmdletBinding()]
  param
  (
    # kommaseparierte Liste erlaubter PowerShell-Befehle
    # Platzhalterzeichen sind nicht erlaubt
    [String[]]
    $AllowedCommands,
    
    # kommaseparierte Liste der absoluten Pfadnamen zu nativen Befehlen
    # Platzhalterzeichen wie "*" sind erlaubt
    # Beispiel: *\notepad.exe
    [String[]]
    $AllowedNativeCommands,
    
    # in einer normalen PowerShell ist der Defaultwert "RestrictedLanguage"
    # in einer Remoteshell ist der Defaultwert "NoLanguage"
    [System.Management.Automation.PSLanguageMode]
    $LanguageMode = $(if ($host.Name -eq 'ServerRemoteHost') { 'NoLanguage' } else { 'RestrictedLanguage' }),
    
    # werden die Basiscmdlets der PowerShell entfernt, kann die Sitzung
    # nicht mehr interaktiv ausgeführt werden. Die Sitzung kann dann
    # nur noch mit Invoke-Command verwendet werden.
    [Switch]
    $ExcludeDefaultCommands,
    
    [Switch]
    $IncludeTabExpansion,
    
    [Microsoft.PowerShell.ExecutionPolicy]
    $ExecutionPolicy = 'Restricted'
  )
  
  # läuft diese Funktion in einer Remoteshell?
  $isRemote = $host.Name -eq 'ServerRemoteHost'
  Write-Verbose "Remotesession? $isRemote"
  
  # DefaultCommands dürfen nur in einer Remotepowershell entfernt werden
  # eine normale PowerShell benötigt diese für den Betrieb
  if ($ExcludeDefaultCommands -and !$isRemote)
  {
    Write-Warning 'DefaultCommands können in lokaler PowerShell nicht entfernt werden.'
    $ExcludeDefaultCommands = $false
  }
  Write-Verbose "Exclude Default Commands? $ExcludeDefaultCommands"

  # Anwendungsliste löschen
  $ExecutionContext.SessionState.Applications.Clear()
  Write-Verbose 'Removing Applications.'
  if ($AllowedNativeCommands.Count -gt 0)
  {
    $ExecutionContext.SessionState.Applications.AddRange($AllowedNativeCommands)
    Write-Verbose "Adding Applications: $AllowedNativeCommands"
  }

  # Skriptliste löschen
  $ExecutionContext.SessionState.Scripts.Clear()
  Write-Verbose 'Removing Scripts.'

  # Erlaubte Befehle definieren
  $issHash = @{}
  
  [System.Collections.ArrayList]$BaseCommands = New-Object System.Collections.ArrayList
  if (!$ExcludeDefaultCommands)
  {
    $type = [Management.Automation.Runspaces.InitialSessionState]
    $iss = $type::CreateRestricted('RemoteServer')
    
    # wenn dies eine Remoteshell ist, werden die Basisbefehle als
    # Proxycommands importiert
    # bei einer lokalen Shell werden die vorhandenen Befehle nicht entfernt
    if ($isRemote)
    {
      foreach($proxy in $iss.Commands | Where-Object { $_.CommandType -eq 'Function'})
      {
        Set-Item "function:global:$($proxy.Name)" $proxy.Definition
        $name = '{0}-{1}' -f $proxy.Name, $proxy.CommandType
        $issHash[$name] = $proxy
        Write-Verbose ("Adding Proxy Command " + $proxy.Name)
      }
    }
    else
    {
      [System.Collections.ArrayList]$BaseCommands = $iss.Commands | 
      Where-Object { $_.Visibility -eq 'Public' } | 
      Select-Object -ExpandProperty Name
      Write-Verbose 'Enabling Default PowerShell Commands'
    }
  }
  
  # aktiviert Tabvervollständigung
  # ACHTUNG: Tabvervollständigung zeigt auch versteckte Befehlsnamen an,
  # obwohl diese Befehle nicht ausführbar sind
  if ($IncludeTabExpansion)
  {
    $null = $BaseCommands.Add('tabexpansion2')
    Write-Verbose 'Enabling Tabexpansion'
  }
  
  if ($AllowedCommands.Count -gt 0)
  {
    $BaseCommands.AddRange($AllowedCommands)
    Write-Verbose "Enabling Explicit Commands: $AllowedCommands"
  }
  
  # ExecutionPolicy setzen
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy $ExecutionPolicy -ErrorAction SilentlyContinue
  Write-Verbose "Setting Execution Policy: $ExecutionPolicy"

  # Alle Befehle mit Ausnahme der erlaubten Befehle verstecken
  [System.Collections.ArrayList]$hide = @(Get-Command | 
  Where-Object {$BaseCommands -notcontains $_.Name}) |
  Where-Object {
    $name = '{0}-{1}' -f $_.Name, $_.CommandType 
    
    $issCmd = $issHash[$name]
    !$issCmd -or $issCmd.Visibility -ne 'Public'
  }

  # Alle Aliase mit Ausnahme der erlaubten verstecken:
  Get-Alias | 
  Where-Object {$BaseCommands -notcontains $_.Name} | 
  ForEach-Object { $null = $hide.Add($_) }

  Write-Verbose "Language Mode = $LanguageMode"
  
  foreach($hidden in $hide) 
  { 
    Write-Verbose ('Hiding {0} ({1})' -f $hidden.Name, $hidden.CommandType)
  }
  
  foreach($hidden in $hide) 
  { 
    $hidden.Visibility = 'Private' 
  }

  # LanguageMode setzen
  $ExecutionContext.SessionState.LanguageMode = $LanguageMode
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.18.ps1
************************************************************************
function Limit-Runspace
{
  ... (abgekürzt, hier muss die Funktion Limit-Runspace eingefügt werden)
}

Import-Module PrintManagement
Limit-Runspace -AllowedCommands Get-Printer, Add-Printer



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.19.ps1
************************************************************************
function Limit-Runspace
{
  ... (abgekürzt, hier muss die Funktion Limit-Runspace eingefügt werden)
}

function Test-WMI
{
  Get-WMIObject -Class Win32_BIOS
}


Limit-Runspace -AllowedCommands Test-WMI



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.2.ps1
************************************************************************
function Get-RemoteSessionUser
{
  param
  (
      $ComputerName,
      $Credential
  )

  Get-WmiObject -Class Win32_Process -Filter 'Name="wsmprovhost.exe"' @PSBoundParameters |
    ForEach-Object {
      $owner = $_.GetOwner()

      $rv = $_ | Select-Object -Property User, StartTime, ID
      $rv.StartTime = $_.ConvertToDateTime($_.CreationDate)
      $rv.User = '{0}\{1}' -f $owner.Domain, $owner.User
      $rv.ID = $_.ProcessID
      $rv
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.20.ps1
************************************************************************
# Spooler-Dienst lokal abrufen
$dienst = Get-Service -Name Spooler
$dienst

# Spooler-Dienst über PowerShell Remoting abrufen
$dienst = Invoke-Command -ScriptBlock { Get-Service -Name Spooler } -Computername dell1
$dienst



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.21.ps1
************************************************************************
# Spooler-Dienst lokal abrufen
$dienst = Get-Service -Name Spooler
$dienst.GetType().FullName
$dienst.PSTypeNames[0]

# Spooler-Dienst über PowerShell Remoting abrufen
$dienst = Invoke-Command -ScriptBlock { Get-Service -Name Spooler } -Computername dell1
$dienst.GetType().FullName
$dienst.PSTypeNames[0]



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.22.ps1
************************************************************************
# Member des Dienstobjekts lokal und remote abrufen:
$lokal = Get-Service -Name Spooler |
    Get-Member | 
    Add-Member -MemberType NoteProperty -Name 'Origin' -Value 'local' -PassThru

$remote = Invoke-Command { Get-Service -Name Spooler } -Computername dell1 | 
    Get-Member | 
    Add-Member -MemberType NoteProperty -Name 'Origin' -Value 'remote' -PassThru

# Namen der Member vergleichen:
Compare-Object -Reference $lokal -Difference $remote -Property Name -PassThru |
  Sort-Object -Property Origin, Name |
  Select-Object -Property Origin, Name, MemberType, Definition



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.23.ps1
************************************************************************
# Objekt in Textform hier speichern
$path = "$env:temp\dienst.txt"

# Spoolerdienst lokal abrufen
$dienstOriginal = Get-Service -Name Spooler, WUAUServ

# Zeitmessung
$start = Get-Date

# Objekt in Textform serialisieren
$dienstOriginal | Export-Clixml $path
# Objektkopie aus Textform deserialisieren
$dienstKopie = Import-Clixml $path

# Zeitmessung
$ende = Get-Date

# Analyse
$ausgabe = [Ordered]@{}

$ausgabe.Originaltyp = $dienstOriginal | 
                        Get-Member | 
                        Select-Object -ExpandProperty TypeName | 
                        Sort-Object -Unique

$ausgabe.'Deserialisierter Typ' = $dienstKopie | 
                        Get-Member | 
                        Select-Object -ExpandProperty TypeName | 
                        Sort-Object -Unique

$ausgabe.'Zeit (ms)' = [int]($ende - $start).TotalMilliseconds
$ausgabe.'Methoden im Original' = ($dienstOriginal | Get-Member -MemberType *Method).Count
$ausgabe.'Methoden in Kopie' = ($dienstKopie | Get-Member -MemberType *Method).Count
$ausgabe.Datenmenge = '{0:n1} KB' -f  ((Get-Item -Path $Path).Length / 1KB)

New-Object -TypeName PSObject -Property $ausgabe

# Textdatei öffnen
notepad $path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.24.ps1
************************************************************************
$Version = @{Name='Version'; Expression={ $_.VersionInfo.ProductVersion }}

Get-ChildItem -Path c:\windows\system32 | 
  Where-Object { ($_.VersionInfo.ProductVersion -as [Version]) -gt '6.0.0.0' } |
  Select-Object -Property Name, $Version



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.25.ps1
************************************************************************
$start = Get-Date

$Version = @{Name='Version'; Expression={ $_.VersionInfo.ProductVersion }}

$dateien = Invoke-Command { Get-ChildItem -Path c:\windows\system32 } -Computername dell1

$dateien | 
  Where-Object { ($_.VersionInfo.ProductVersion -as [Version]) -gt '6.0.0.0' } |
  Select-Object -Property Name, $Version
  
$ende = Get-Date
$sekunden = ($ende-$start).TotalSeconds
Write-Warning "Gesamtdauer $sekunden sec."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.26.ps1
************************************************************************
$start = Get-Date

# gesamte Logik als Skriptblock verpacken...
$code = 
{
  $Version = @{Name='Version'; Expression={ $_.VersionInfo.ProductVersion }}

  Get-ChildItem -Path c:\windows\system32 | 
  Where-Object { ($_.VersionInfo.ProductVersion -as [Version]) -gt '6.0.0.0' } |
  Select-Object -Property Name, $Version
}

# ...und dann komplett auf der Serverseite ausführen:
$dateien = Invoke-Command $code -Computername dell1
 
$ende = Get-Date
$sekunden = ($ende-$start).TotalSeconds
Write-Warning "Gesamtdauer $sekunden sec."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.27.ps1
************************************************************************
$session = New-PSSession -ComputerName server02
Copy-Item -Path C:\daten\4302.jpg -Destination C:\ -ToSession $session



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.28.ps1
************************************************************************
# neuen lokalen Ordner anlegen:
New-Item -Path c:\daten -ItemType Directory | Out-Null

$session = New-PSSession -ComputerName server02
Copy-Item -Path C:\protokolle -Destination c:\daten -FromSession $session -Recurse



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.29.ps1
************************************************************************
# Kultur auf Spanisch festlegen:
$options = New-PSSessionOption -Culture "es-es"
$session = New-PSSession -ComputerName dell1 -SessionOption $options
Invoke-Command $session { Get-Date | Out-String }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.3.ps1
************************************************************************
function Get-ErrorEvent
{
  param
  (
    [Parameter(Mandatory=$true)]
    $ComputerName,

    $LogName='System'
  )

  $code = { Get-EventLog -LogName $LogName -EntryType Error |
             Export-Csv $env:TEMP\result.csv -NoTypeInformation -Encoding UTF8 -UseCulture }
  Invoke-Command -ScriptBlock $code -ComputerName $ComputerName
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.4.ps1
************************************************************************
function Get-ErrorEvent
{
  param
  (
    [Parameter(Mandatory=$true)]
    $ComputerName,

    $LogName='System'
  )

     $code =
     {
       param($LogName)

       Get-EventLog -LogName $LogName -EntryType Error |
         Export-Csv $env:TEMP\result.csv -NoTypeInformation -Encoding UTF8 -UseCulture
     }

  Invoke-Command -ScriptBlock $code -ComputerName $ComputerName -ArgumentList $LogName
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.5.ps1
************************************************************************
function Get-ErrorEvent
{
  param
  (
    [Parameter(Mandatory=$true)]
    $ComputerName,

    $LogName='System'
  )

     $code =
     {
       Get-EventLog -LogName $Using:LogName -EntryType Error |
         Export-Csv $env:TEMP\result.csv -NoTypeInformation -Encoding UTF8 -UseCulture
     }

  Invoke-Command -ScriptBlock $code -ComputerName $ComputerName
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.6.ps1
************************************************************************
function Get-ErrorEvent
{
  param
  (
    [Parameter(Mandatory=$true)]
    $ComputerName,

    $LogName='System'
  )

     $code =
     {
       param($LogName)

       Get-EventLog -LogName $LogName -EntryType Error
     }

  Invoke-Command -ScriptBlock $code -ComputerName $ComputerName -ArgumentList $LogName |
         Export-Csv $env:temp\result.csv -NoTypeInformation -Encoding UTF8 -UseCulture
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.7.ps1
************************************************************************
function Set-RemoteDesktop
{
  param
  (
    $ComputerName,

    $Credential,

    [switch]
    $Disable
  )

  # diesen Parameter nicht an Invoke-Command weitergeben
  $null = $PSBoundParameters.Remove('Disable')

  $code = {
    param([bool]$Disable)

    $key = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'
    if ($Disable) {
        $Value = 1
    }
    else {
        $Value = 0
    }
    Set-ItemProperty -Path $key -Name fDenyTSConnections -Value ([int]$Value) -Type DWORD

    if ($Disable)
    {
      netsh.exe advfirewall firewall set rule group="Remotedesktop" new enable=no
      Write-Warning "Remote Desktop disabled on \\$env:COMPUTERNAME"
    }
    else
    {
      netsh.exe advfirewall firewall set rule group="Remotedesktop" new enable=yes
      Write-Warning "Remote Desktop enabled on \\$env:COMPUTERNAME"
    }
  }

  Invoke-Command -ScriptBlock $code @PSBoundParameters -ArgumentList $Disable
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.8.ps1
************************************************************************
$code = 
{
  Get-WmiObject Win32_OperatingSystem -ComputerName storage1 |
    Select-Object -ExpandProperty Caption
}

Invoke-Command -ScriptBlock $code -ComputerName testserver



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\23.9.ps1
************************************************************************
$anmeldung = Get-Credential "$env:USERDOMAIN\$env:USERNAME"
$code = 
{
  param($Credential)
  Get-WmiObject Win32_OperatingSystem -ComputerName storage1 -Credential $Credential |
    Select-Object -ExpandProperty Caption
}

Invoke-Command -ScriptBlock $code -ComputerName testserver -ArgumentList $anmeldung



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.1.ps1
************************************************************************
$operator = New-ADUser -Name TestOperator -AccountPassword $password -PassThru
Enable-ADAccount -Identity $operator

$normaluser = New-ADUser -Name Normaluser -AccountPassword $password -PassThru
Enable-ADAccount -Identity $normaluser


Add-ADGroupMember -Identity $jeaAdmin -Members $operator



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.10.ps1
************************************************************************
# Name der Fähigkeit:
$Name = 'ManageService'


# Konfiguration definieren:
$Config = @{
    VisibleCmdlets = 'Microsoft.PowerShell.Management\*-Service'
}

# Name des neuen Moduls:
$guid = [Guid]::NewGuid().toString('d')
$ModuleName = 'Role{0}_{1}' -f $Name,$guid
$modulePath = "$env:programfiles\WindowsPowerShell\Modules\$ModuleName"

# Modul herstellen:
New-Item -Path "$modulePath\RoleCapabilities" -ItemType Directory -Force
New-PSRoleCapabilityFile -Path "$modulePath\RoleCapabilities\$Name.psrc" @Config
New-ModuleManifest -Path "$modulePath\$ModuleName.psd1"


# Name der Fähigkeit:
$Name = 'ManageLog'


# Konfiguration definieren:
$Config = @{
    VisibleCmdlets = 'Microsoft.PowerShell.Management\*-EventLog'
}

# Name des neuen Moduls:
$guid = [Guid]::NewGuid().toString('d')
$ModuleName = 'Role{0}_{1}' -f $Name,$guid
$modulePath = "$env:programfiles\WindowsPowerShell\Modules\$ModuleName"

# Modul herstellen:
New-Item -Path "$modulePath\RoleCapabilities" -ItemType Directory -Force
New-PSRoleCapabilityFile -Path "$modulePath\RoleCapabilities\$Name.psrc" @Config
New-ModuleManifest -Path "$modulePath\$ModuleName.psd1"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.11.ps1
************************************************************************
# Pfadname zu einer neuen pssc-Datei festlegen
$Path = "$env:temp\jeaAD.pssc"

# Get-UserInfo liefert den Wert von $PSSenderInfo zurück
# darin ist der Name des aufrufenden Anwenders zu finden
$getUserInfo = @{
  Name='Get-UserInfo'

  ScriptBlock=
  { 
    $PSSenderInfo 
  }
}


$resetADPassword = @{
  Name='Reset-ADPassword'
  
  ScriptBlock=
  {
    param($Identity)
    $NewPassword = Read-Host -Prompt 'Enter New Password' -AsSecureString
    # Reset the password
    ActiveDirectory\Set-ADAccountPassword -Identity $Identity -NewPassword $NewPassword -Reset
    # Require the user to reset at next logon
    ActiveDirectory\Set-ADUser -Identity $Identity -ChangePasswordAtLogon $true
  }
} 

 
$VisibleCmdlets = 'Get-ADUser',
'Unlock-ADAccount', 
@{ Name = 'Set-ADUser'; Parameters = @{ Name = 'Title'; ValidateSet = 'Manager', 'Engineer' }},
'Search-ADAccount',
@{ Name = 'Add-ADGroupMember'; Parameters = 
  @{Name = 'Identity'; ValidateSet = 'TestGroup'},
@{Name = 'Members'}},
@{ Name = 'Remove-ADGroupMember'; Parameters = 
  @{Name = 'Identity'; ValidateSet = 'TestGroup'},
@{Name = 'Members'}},
'Enable-ADAccount',
'Disable-ADAccount' 
                  


# Datei anlegen
New-PSSessionConfigurationFile -Path $Path –SessionType RestrictedRemoteServer -LanguageMode NoLanguage –ExecutionPolicy Restricted -RunAsVirtualAccount -VisibleCmdlets $VisibleCmdlets -FunctionDefinitions $resetADPassword, $getUserInfo

# Endpunkt anlegen
Register-PSSessionConfiguration -Path $Path -Name ADAdmin -ShowSecurityDescriptorUI -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.12.ps1
************************************************************************
# Session verwenden
$session = New-PSSession -ComputerName DC01 -ConfigurationName ADAdmin

# Inhalt als Modul "ADAdmin" exportieren
Export-PSSession -OutputModule ADAdmin -CommandName * -CommandType Cmdlet, Function -Session $session -Force 

# Session verwerfen
Remove-PSSession $session



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.13.ps1
************************************************************************
# Name der Fähigkeit:
$Name = 'ADAdmin'

# Funktionen definieren:
$getUserInfo = @{
  Name='Get-UserInfo'

  ScriptBlock=
  { 
    $PSSenderInfo 
  }
}


$resetADPassword = @{
  Name='Reset-ADPassword'
  
  ScriptBlock=
  {
    param($Identity)
    $NewPassword = Read-Host -Prompt 'Enter New Password' -AsSecureString
    # Reset the password
    ActiveDirectory\Set-ADAccountPassword -Identity $Identity -NewPassword $NewPassword -Reset
    # Require the user to reset at next logon
    ActiveDirectory\Set-ADUser -Identity $Identity -ChangePasswordAtLogon $true
  }
} 


# sichtbare Cmdlets definieren:
$VisibleCmdlets = 'Get-ADUser',
'Unlock-ADAccount', 
@{ Name = 'Set-ADUser'; Parameters = @{ Name = 'Title'; ValidateSet = 'Manager', 'Engineer' }},
'Search-ADAccount',
@{ Name = 'Add-ADGroupMember'; Parameters = 
  @{Name = 'Identity'; ValidateSet = 'TestGroup'},
@{Name = 'Members'}},
@{ Name = 'Remove-ADGroupMember'; Parameters = 
  @{Name = 'Identity'; ValidateSet = 'TestGroup'},
@{Name = 'Members'}},
'Enable-ADAccount',
'Disable-ADAccount' 
                


# Konfiguration definieren:
$Config = @{
    FunctionDefinitions = $getUserInfo, $resetADPassword
    VisibleCmdlets = $VisibleCmdlets
}

# Name des neuen Moduls:
$guid = [Guid]::NewGuid().toString('d')
$ModuleName = 'Role{0}_{1}' -f $Name,$guid
$modulePath = "$env:programfiles\WindowsPowerShell\Modules\$ModuleName"

# Modul herstellen:
New-Item -Path "$modulePath\RoleCapabilities" -ItemType Directory -Force
New-PSRoleCapabilityFile -Path "$modulePath\RoleCapabilities\$Name.psrc" @Config
New-ModuleManifest -Path "$modulePath\$ModuleName.psd1"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.14.ps1
************************************************************************
# Pfadname zu einer neuen pssc-Datei festlegen
$Path = "$env:temp\jea3.pssc"

# Rollen definieren
$roles = @{
  'mycompany\JEA_Info' = @{RoleCapabilities = 'Information', 'Generic'}
  'mycompany\JEA_Service' = @{RoleCapabilities = 'ManageService', 'ManageLog', 'ADAdmin', 'Generic'}
}

# Datei anlegen
New-PSSessionConfigurationFile -Path $Path –SessionType RestrictedRemoteServer -LanguageMode NoLanguage –ExecutionPolicy Restricted -RunAsVirtualAccount -RoleDefinitions $roles 

# Endpunkt anlegen
Register-PSSessionConfiguration -Path $Path -Name JEA3 -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.2.ps1
************************************************************************
# Pfadname zu einer neuen pssc-Datei festlegen
$Path = "$env:temp\jea1.pssc"

# Get-UserInfo liefert den Wert von $PSSenderInfo zurück
# darin ist der Name des aufrufenden Anwenders zu finden
$getUserInfo = @{
  Name='Get-UserInfo'

  ScriptBlock=
  { 
    $PSSenderInfo 
  }
}

# Datei anlegen
New-PSSessionConfigurationFile -Path $Path –SessionType RestrictedRemoteServer -LanguageMode NoLanguage –ExecutionPolicy Restricted -RunAsVirtualAccount -VisibleCmdlets Microsoft.PowerShell.Management\*-Service, Get-* -ModulesToImport Microsoft.* -FunctionDefinitions $getUserInfo 

# Endpunkt anlegen
Register-PSSessionConfiguration -Path $Path -Name JEA1 -Force

# JEA-Gruppe berechtigen
Set-PSSessionConfiguration -Name JEA1 -ShowSecurityDescriptorUI -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.3.ps1
************************************************************************
function Get-SomeData
{
  $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
  $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  $isAdmin = $prp.IsInRole($adm)  
  
  $info = [ordered]@{}
  $info.'Current User' = $env:USERDOMAIN + "\" + $env:username
  $info.'Is Admin?' = $isAdmin
  New-Object PSObject -Property $info
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.4.ps1
************************************************************************
$Code = @'

function Get-SomeData
{
  $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
  $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  $isAdmin = $prp.IsInRole($adm)  
  
  $info = [ordered]@{}
  $info.'Current User' = $env:USERDOMAIN + "\" + $env:username
  $info.'Is Admin?' = $isAdmin
  New-Object PSObject -Property $info
}

'@

New-Item -Path "$env:ProgramFiles\WindowsPowerShell\Modules\Microsoft.Angriff\Microsoft.Angriff.psm1" -ItemType File -Value $Code -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.5.ps1
************************************************************************
# Pfadname zu einer neuen pssc-Datei festlegen
$Path = "$env:temp\jea2.pssc"

# Get-UserInfo liefert den Wert von $PSSenderInfo zurück
# darin ist der Name des aufrufenden Anwenders zu finden
$getUserInfo = @{
  Name='Get-UserInfo'

  ScriptBlock=
  { 
    $PSSenderInfo 
  }
}

# Datei anlegen
New-PSSessionConfigurationFile -Path $Path –SessionType RestrictedRemoteServer -LanguageMode NoLanguage –ExecutionPolicy RemoteSigned -RunAsVirtualAccount -VisibleCmdlets Microsoft.PowerShell.Management\* -FunctionDefinitions $getUserInfo -VisibleProviders FileSystem

# Endpunkt anlegen
Register-PSSessionConfiguration -Path $Path -Name JEA2 -Force

# JEA-Gruppe berechtigen
Set-PSSessionConfiguration -Name JEA2 -ShowSecurityDescriptorUI -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.6.ps1
************************************************************************
$serviceAdmins = New-ADGroup -Name JEA_Service -GroupScope DomainLocal -PassThru
$infoAdmins = New-ADGroup -Name JEA_Info -GroupScope DomainLocal -PassThru

$password = ConvertTo-SecureString -String P@ssw0rd -AsPlainText -Force

$serviceUser = New-ADUser -Name ServiceUser -AccountPassword $password -PassThru
Enable-ADAccount -Identity $serviceUser

$infoUser = New-ADUser -Name InfoUser -AccountPassword $password -PassThru
Enable-ADAccount -Identity $infoUser


Add-ADGroupMember -Identity $serviceAdmins -Members $serviceUser
Add-ADGroupMember -Identity $infoAdmins -Members $infoUser



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.7.ps1
************************************************************************
# Pfadname zu einer neuen pssc-Datei festlegen
$Path = "$env:temp\jea3.pssc"

# Rollen definieren
$roles = @{
  'mycompany\JEA_Info' = @{RoleCapabilities = 'Information', 'Generic'}
  'mycompany\JEA_Service' = @{RoleCapabilities = 'ManageService', 'ManageLog', 'Generic'}
}

# Datei anlegen
New-PSSessionConfigurationFile -Path $Path –SessionType RestrictedRemoteServer -LanguageMode NoLanguage –ExecutionPolicy Restricted -RunAsVirtualAccount -RoleDefinitions $roles 

# Endpunkt anlegen
Register-PSSessionConfiguration -Path $Path -Name JEA3 -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.8.ps1
************************************************************************
# Name der Fähigkeit:
$Name = 'Generic'


# private Funktion definieren:
$GetUserInfo = @{
  Name = 'Get-UserInfo'
  ScriptBlock = { $PSSenderInfo } 
}

# Konfiguration definieren:
$Config = @{
    FunctionDefinitions = $GetUserInfo
}

# Name des neuen Moduls:
$guid = [Guid]::NewGuid().toString('d')
$ModuleName = 'Role{0}_{1}' -f $Name,$guid
$modulePath = "$env:programfiles\WindowsPowerShell\Modules\$ModuleName"

# Modul herstellen:
New-Item -Path "$modulePath\RoleCapabilities" -ItemType Directory -Force
New-PSRoleCapabilityFile -Path "$modulePath\RoleCapabilities\$Name.psrc" @Config
New-ModuleManifest -Path "$modulePath\$ModuleName.psd1"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\24.9.ps1
************************************************************************
# Name der Fähigkeit:
$Name = 'Information'


# Konfiguration definieren:
$Config = @{
    VisibleExternalCommands = 'c:\windows\system32\systeminfo.exe', 'c:\windows\system32\netstat.exe'
    VisibleCmdlets = 'Get-WMIObject', 'Get-ACL'
}

# Name des neuen Moduls:
$guid = [Guid]::NewGuid().toString('d')
$ModuleName = 'Role{0}_{1}' -f $Name,$guid
$modulePath = "$env:programfiles\WindowsPowerShell\Modules\$ModuleName"

# Modul herstellen:
New-Item -Path "$modulePath\RoleCapabilities" -ItemType Directory -Force
New-PSRoleCapabilityFile -Path "$modulePath\RoleCapabilities\$Name.psrc" @Config
New-ModuleManifest -Path "$modulePath\$ModuleName.psd1"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.1.ps1
************************************************************************
$start = Get-Date

& $code1
& $code2
& $code3

$end = Get-Date
$timespan = $end - $start
$seconds = $timespan.TotalSeconds
Write-Host "Gesamtdauer: $seconds sec."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.10.ps1
************************************************************************
function Start-Timebomb
{
  param
  (
    [int32]
    [Parameter(Mandatory=$true)]
    [ValidateRange(5,600)]
    $Seconds,

    [scriptblock]
    $Action = { Stop-Process -Id $PID }
  )

  $Wait = "Start-Sleep -seconds $seconds"
  $script:newPowerShell = [powershell]::Create().AddScript($Wait).AddScript($Action)
  $handle = $newPowerShell.BeginInvoke()
  Write-Warning "Timebomb is active and will go off in $Seconds seconds unless you call Stop-Timebomb before."
}

function Stop-Timebomb
{
  if ($script:newPowerShell -ne $null)
  {
    Write-Host 'Trying to stop timebomb...' -NoNewline
    $script:newPowerShell.Stop()
    $script:newPowerShell.Runspace.Close()
    $script:newPowerShell.Dispose()
    Remove-Variable newPowerShell -Scope script
    Write-Host 'Done!'
  }
  else
  {
    Write-Warning 'No timebomb found.'
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.11.ps1
************************************************************************
function Foreach-Parallel {
  param (   
    [Parameter(Mandatory=$true)]
    [ScriptBlock]
    $Process,

    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    $InputObject,

    [Int]
    [ValidateRange(2,200)]
    $ThrottleLimit = 32,

    [Int]
    [ValidateRange(100,10000)]
    $CheckIntervalMilliseconds = 200,

    [Int]
    $TimeoutSec = -1,
    
    [Switch]
    $UseLocalVariables
  )
  
  # Initialisierungsarbeiten durchführen
  Begin {
    # einen initialen Standard-Zustand der PowerShell beschaffen:
    $SessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
    
    # darin auf Wunsch alle lokalen Variablen einblenden:
    if ($UseLocalVariables)
    {
      # zuerst in einer "frischen" PowerShell alle Standardvariablen ermitteln:
      $ps = [Powershell]::Create()
      $null = $ps.AddCommand('Get-Variable')
      $oldVars = $ps.Invoke().Name
      $ps.Runspace.Close()
      $ps.Dispose()

      # nun aus der vorhandenen PowerShell alle eigenen Variablen in der neuen PowerShell einblenden,
      # (die nicht zu den Standardvariablen zählen):
      Get-Variable | 
      Where-Object { $_.Name -notin $oldVars } |
      Foreach-Object {
        $SessionState.Variables.Add((New-Object System.Management.Automation.Runspaces.SessionStateVariableEntry($_.Name, $_.Value, $null)))
      }
    }

    # einen Runspace-Pool mit den nötigen Threads anlegen:
    $RunspacePool = [Runspacefactory]::CreateRunspacePool(1, $ThrottleLimit, $SessionState, $host)
    $RunspacePool.Open() 

    # in dieser Liste die aktuell noch laufenden Threads vermerken:
    $ThreadList = New-Object System.Collections.ArrayList        
  }


  # für jedes empfangene Pipeline-Element einen Thread starten:
  Process
  {
    # Code in eine Pipeline einbetten, damit $_ gefüllt ist:
    $Code = '$args | Foreach-Object { ' + $Process.toString() + '}'
    
    # Thread anlegen:
    $powershell = [powershell]::Create()
    $null = $PowerShell.AddScript($Code).AddArgument($InputObject)
    $powershell.RunspacePool = $RunspacePool

    # Informationen über diesen Thread in einem Hashtable speichern:
    $threadID++
    Write-Verbose "Starte Thread $threadID"
    $threadInfo = @{
      PowerShell = $powershell
      StartTime = Get-Date
      ThreadID = $threadID
      Runspace = $powershell.BeginInvoke()
    }

    # diese Information in der Liste der laufenden Threads vermerken:
    $null = $ThreadList.Add($threadInfo)
  }


  # am Ende überprüfen, welche Threads inzwischen fertiggestellt sind:
  End 
  {
    $aborted = 0 
    try
    {
      Do {
        # alle noch vorhandenen Threads untersuchen:
        Foreach($thread in $ThreadList) {
          If ($thread.Runspace.isCompleted) {
            # wenn der Thread abgeschlossen ist, Ergebnis abrufen und
            # Thread als "erledigt" kennzeichnen:
            if($thread.powershell.Streams.Error.Count -gt 0) 
            {
              # falls es zu Fehlern kam, Fehler ausgeben:
              foreach($ErrorRecord in $thread.powershell.Streams.Error) {
                Write-Error -ErrorRecord $ErrorRecord
              }
            }
            if ($thread.TimedOut -ne $true)
            {
              # Ergebnisse des Threads lesen:
              $thread.powershell.EndInvoke($thread.Runspace)
              Write-Verbose "empfange Thread $($thread.ThreadID)"
            }
            $thread.Done = $true
          }
          # falls eine maximale Laufzeit festgelegt ist, diese überprüfen:
          elseif ($TimeoutSec -gt 0 -and $thread.TimedOut -ne $true)
          {
            # Thread abbrechen, falls er zu lange lief:
            $runtimeSeconds = ((Get-Date) - $thread.StartTime).TotalSeconds
            if ($runtimeSeconds -gt $TimeoutSec)
            {
              Write-Error -Message "Thread $($thread.ThreadID) timed out."
              $thread.TimedOut = $true
              $null = $thread.PowerShell.BeginStop({}, $null)
            }
          }
        }

        # alle abgeschlossenen Threads ermitteln:
        $ThreadCompletedList = $ThreadList | Where-Object { $_.Done -eq $true }
        if ($ThreadCompletedList.Count -gt 0)
        {
          # diese Threads aus der Liste der aktuellen Threads entfernen:
          foreach($threadCompleted in $ThreadCompletedList)
          {
            # Thread entsorgen:
            $threadCompleted.powershell.Stop()
            $threadCompleted.powershell.dispose()
            $threadCompleted.Runspace = $null
            $threadCompleted.powershell = $null
            $ThreadList.remove($threadCompleted)
          }
          
          Start-Sleep -milliseconds $CheckIntervalMilliseconds
        }
        # erneut versuchen, falls es weitere unerledigte Threads gibt:
      } while ($ThreadList.Count -gt 0)
      
    }
    # abschließend Aufräumungsarbeiten durchführen:
    finally
    {
      # falls es noch laufende Threads gibt (Benutzer hat CTRL+C gedrückt)
      # diese abbrechen und entsorgen:
      foreach($thread in $ThreadList)
      {
        $thread.powershell.dispose() 
        $thread.Runspace = $null
        $thread.powershell = $null
      }
      # RunspacePool schließen:
      $RunspacePool.close()
      # Speicher aufräumen:
      [GC]::Collect() 
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.12.ps1
************************************************************************
1..6 | Foreach-Parallel {
  $start = Get-Date -Format 'HH:mm:ss:ffffff'
  Write-Host "$start : Starte $_" -ForegroundColor Green
  Start-Sleep -Seconds 2
  $ende = Get-Date -Format 'HH:mm:ss:ffffff'
  Write-Host "$ende : Beende $_" -ForegroundColor Red

} -ThrottleLimit 2



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.13.ps1
************************************************************************
1..4 | Foreach-Parallel { 
  # an den Thread übergebene Zahl merken:
  $id = $_
  
  # Aufgabe mit Fortschrittsanzeige durchführen:
  1..100 |  ForEach-Object { 
    Write-Progress -id $id -Activity "Task $id" -Status 'Working...' -PercentComplete $_
    Start-Sleep -Milliseconds 30
  }
  Write-Progress -id $id -Activity "Task $id" -Status 'Completed!' -PercentComplete 100
} -ThrottleLimit 2



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.14.ps1
************************************************************************
1..5 | Foreach-Parallel { 
  $s = Get-Random -Minimum 1 -Maximum 5
  Write-Host "Thread $_ wird $s sec. benötigen" -ForegroundColor Green
  
  Start-Sleep -Seconds $s
  
  return "Thread $_ wurde beendet" 
  } -TimeoutSec 3



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.15.ps1
************************************************************************
$Information = 'Dies ist eine lokale Variable'

1..5 | Foreach-Parallel { "Durchlauf $_ : Information ist: $Information" }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.16.ps1
************************************************************************
1..5 | Foreach-Parallel { "Durchlauf $_ : Information ist: $Information" } -UseLocalVariables



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.17.ps1
************************************************************************
$Information = 'Dies ist eine lokale Variable'

1..5 | Foreach-Parallel { 
    "Durchlauf $_ : Information ist $Information" 
    
    # Variablen sollten NICHT geändert werden!
    $Information = Get-Random
} -UseLocalVariables



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.18.ps1
************************************************************************
$hash = [hashtable]::Synchronized(@{})
$hash.Info = 'es geht los!'

1..5 | Foreach-Parallel { 
    "Durchlauf $_ : Information ist: " + $hash.Info 
    
    # Variablen sollten NICHT geändert werden!
    $hash.Info = "thread $_ war hier!"
} -UseLocalVariables



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.19.ps1
************************************************************************
$code = @'
using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace InProcess
{
    public class InMemoryJob : System.Management.Automation.Job
    {
        public InMemoryJob(ScriptBlock scriptBlock, string name)
        {
            _powerShell = PowerShell.Create().AddScript(scriptBlock.ToString());
            SetUpStreams(name);
        }

        public InMemoryJob(PowerShell powerShell, string name)
        {
            _powerShell = powerShell;
            SetUpStreams(name);
        }

        private void SetUpStreams(string name)
        {
          _powerShell.Streams.Verbose = this.Verbose;
          _powerShell.Streams.Error = this.Error;
          _powerShell.Streams.Debug = this.Debug;
          _powerShell.Streams.Warning = this.Warning;
          _powerShell.Runspace.AvailabilityChanged += 
            new EventHandler<RunspaceAvailabilityEventArgs>(Runspace_AvailabilityChanged);

            int id = System.Threading.Interlocked.Add(ref InMemoryJobNumber, 1);
            if (!string.IsNullOrEmpty(name))
            {
                this.Name = name;
            }
            else
            {
                this.Name = "InProcessJob" + id;
            }
        }

        void Runspace_AvailabilityChanged(object sender, RunspaceAvailabilityEventArgs e)
        {
            if (e.RunspaceAvailability == RunspaceAvailability.Available)
            {
                this.SetJobState(JobState.Completed);
            }
        }

        PowerShell _powerShell;
        static int InMemoryJobNumber = 0;

        public override bool HasMoreData
        {
            get {
                return (Output.Count > 0);
            }
        }
        public override string Location
        {
            get { return "In Process"; }
        }

        public override string StatusMessage
        {
            get { return "A new status message"; }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (!isDisposed)
                {
                    isDisposed = true;
                    try
                    {
                        if (!IsFinishedState(JobStateInfo.State))
                        {
                            StopJob();
                        }

                        foreach (Job job in ChildJobs)
                        {
                            job.Dispose();
                        }
                    }
                    finally
                    {
                        base.Dispose(disposing);
                    }
                }
            }
        }

        private bool isDisposed = false;

        internal bool IsFinishedState(JobState state)
        {
            return (state == JobState.Completed || state == JobState.Failed || state == JobState.Stopped);
        }

        public override void StopJob()
        {
            _powerShell.Stop();
            _powerShell.EndInvoke(_asyncResult);
            SetJobState(JobState.Stopped);
        }

        public void Start()
        {
            _asyncResult = _powerShell.BeginInvoke<PSObject, PSObject>(null, Output);
            SetJobState(JobState.Running);
        }
        IAsyncResult _asyncResult;

        public void WaitJob()
        {
            _asyncResult.AsyncWaitHandle.WaitOne();
        }

        public void WaitJob(TimeSpan timeout)
        {
            _asyncResult.AsyncWaitHandle.WaitOne(timeout);
        }
    }

}
'@

Add-Type -TypeDefinition $code

function Start-JobInProcess
{
  [CmdletBinding()]
   param
  (
    [scriptblock] $ScriptBlock,

    $ArgumentList,

    [string] $Name
  )

  function Get-JobRepository
  {
    [cmdletbinding()]
    param()
    $pscmdlet.JobRepository
  }

  function Add-Job
  {
    [cmdletbinding()]
    param
    (
      $job
    )

    $pscmdlet.JobRepository.Add($job)
  }

  if ($ArgumentList)
  {
    $powershell = [powershell]::Create().AddScript($ScriptBlock).AddArgument($argumentlist)
    $MemoryJob = New-Object InProcess.InMemoryJob $powershell, $Name
  }
  else
  {
    $MemoryJob = New-Object InProcess.InMemoryJob $ScriptBlock, $Name
  }

  $MemoryJob.Start()
  Add-Job $MemoryJob
  $MemoryJob
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.2.ps1
************************************************************************
$start = Get-Date

# drei Aufgaben definieren
$code1 = { Start-Sleep -Seconds 5; "A" }
$code2 = { Start-Sleep -Seconds 6; "B" }
$code3 = { Start-Sleep -Seconds 7; "C" }

# zwei Aufgaben in Hintergrundjobs verlagern und dort ausführen:
$job1 = Start-Job -ScriptBlock $code1 
$job2 = Start-Job -ScriptBlock $code2 

# die voraussichtlich längste Aufgabe in der eigenen PowerShell ausführen:
$result3 = & $code3 

# warten, bis alle Hintergrundjobs ihre Aufgabe erledigt haben:
$alljobs = Wait-Job $job1, $job2 

# Ergebnisse der Hintergrundjobs abfragen:
$result1 = Receive-Job $job1
$result2 = Receive-Job $job2

# Hintergrundjobs wieder entfernen
Remove-Job $alljobs

$end = Get-Date

# Ergebnisse ausgeben
$result1, $result2, $result3

$timespan = $end - $start
$seconds = $timespan.TotalSeconds
Write-Host "Gesamtdauer: $seconds sec."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.3.ps1
************************************************************************
$code1 = { Get-Service }
$code2 = { Get-Process }
$code3 = { Get-Hotfix }

$start = Get-Date

$ergebnis1 = & $code1
$ergebnis2 = & $code2
$ergebnis3 = & $code3

$end = Get-Date
$timespan = $end - $start
$seconds = $timespan.TotalSeconds
Write-Host "Gesamtdauer: $seconds sec."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.4.ps1
************************************************************************
$ips = 1..255 | ForEach-Object { "192.168.2.$_" }
$job = Test-Connection $ips -ErrorAction SilentlyContinue -Count 1 -AsJob
$null = Wait-Job $job
Receive-Job $job | Where-Object { $_.ResponseTime -ne $null } | 
    Select-Object Address, ResponseTime 

Remove-Job $job



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.5.ps1
************************************************************************
$ips = 1..255 | ForEach-Object { "192.168.2.$_" }
$job = Test-Connection $ips -ErrorAction SilentlyContinue -Count 1 -AsJob
$null = Wait-Job $job
Receive-Job $job | Where-Object { $_.ResponseTime -ne $null } | 
    Select-Object Address, ResponseTime |
    Sort-Object -Property { $_.Address -as [Version] }

Remove-Job $job



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.6.ps1
************************************************************************
$befehl = { powercfg.exe /LIST }

$remotecode = 
{ 
    param($Code)
    $job = Start-Job ([ScriptBlock]::Create($Code)) -Name Aufgabe1
    $null = Wait-Job $job 
    Receive-Job -Name Aufgabe1
    Remove-Job -Name Aufgabe1
}  

Invoke-Command -ComputerName dell1 -ArgumentList $befehl -ScriptBlock $remotecode



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.7.ps1
************************************************************************
$code = {
    Start-Sleep -Seconds 2
    "Hello"
}

$newPowerShell = [powershell]::Create().AddScript($code)
$newPowerShell.Invoke()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.8.ps1
************************************************************************
$code = {
  Start-Sleep -Seconds 2
  'Hello'
}

# neuen Thread erzeugen:
$newPowerShell = [powershell]::Create().AddScript($code)

# Thread asynchron starten:
$handle = $newPowerShell.BeginInvoke()

# auf Beendigung warten und währenddessen etwas
# anderes tun:
while ($handle.IsCompleted -eq $false) {
  Write-Host '.' -NoNewline
  Start-Sleep -Milliseconds 500
}
Write-Host ''

# Ergebnis aus anderem Thread abrufen:
$newPowerShell.EndInvoke($handle)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\25.9.ps1
************************************************************************
function Start-Progress
{
  param
  (
    [scriptblock]
    $code
  )

  $newPowerShell = [powershell]::Create().AddScript($code)
  $handle = $newPowerShell.BeginInvoke()

  while ($handle.IsCompleted -eq $false) {
    Write-Host '.' -NoNewline
    Start-Sleep -Milliseconds 500
  }
  Write-Host ''

  $newPowerShell.EndInvoke($handle)

  # zweiten Thread ordnungsgemäß entsorgen:
  $newPowerShell.Runspace.Close()
  $newPowerShell.Dispose()
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.1.ps1
************************************************************************
function Restart-Service
{
  Invoke-Command -ComputerName AppServer1 {
    Stop-Service -Name MyApp -Force
    Stop-Service -Name MyAppQueue -Force
  }

  Invoke-Command -ComputerName ServerA, ServerB {
    Remove-Item -Path "D:\MyApp\Files\QueueLog.xml" –Force
  }

  Invoke-Command -ComputerName AppServer1 {
    Start-Service -Name MyAppQueue -Force
    Start-Service -Name MyApp -Force
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.10.ps1
************************************************************************
workflow Test-Workflow
{
    # bei der Zuweisung einer Variable auf oberster Workflow-Ebene
    # darf workflow: nicht eingesetzt werden!
    $wert = 1
    sequence 
    {
        $workflow:wert
        $workflow:wert += 1

        sequence
        {
            $workflow:wert
            $workflow:wert++
        }
    }
    $workflow:wert
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.11.ps1
************************************************************************
workflow Test-Workflow
{
    param
    (
        $EineInformation
    )

    "Parameter: $EineInformation"
    'Variable $text: ' + $Text
}

function Test-Function
{
    param
    (
        $EineInformation
    )

    "Parameter: $EineInformation"
    'Variable $text: ' + $Text
}

$Text = "Hallo!"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.12.ps1
************************************************************************
workflow Test-Workflow
{
    param
    (
        $Name
    )

    Get-Service -Name $Name
}

function Test-Function
{
    param
    (
        $Name
    )

    Get-Service -Name $Name
}

$dienstWorkflow = Test-Workflow -Name Spooler
$dienstFunktion = Test-Function -Name Spooler



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.13.ps1
************************************************************************
function Test-Function
{
    Get-ChildItem -Path $env:windir\system32 |
      Select-Object { $_.FullName }
}

workflow Test-Workflow
{
    Get-ChildItem -Path $env:windir\system32 |
      Select-Object { $_.FullName }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.14.ps1
************************************************************************
function Get-Environment
{
    $hash = [Ordered]@{}
    $hash.'64bit Betriebsystem?' = [Environment]::Is64BitOperatingSystem
    $hash.'64bit Prozess?' = [Environment]::Is64BitProcess
    $hash.'Computername' = [Environment]::MachineName
    $hash.'Betriebsystem?' = [Environment]::OSVersion
    $hash.'Anzahl Kerne' = [Environment]::ProcessorCount

    New-Object PSObject -Property $hash
}

workflow Test-Workflow
{
    Get-Environment
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.15.ps1
************************************************************************
workflow Test-Workflow
{
    InlineScript 
    {
      $hash = [Ordered]@{}
      $hash.'64bit Betriebsystem?' = [Environment]::Is64BitOperatingSystem
      $hash.'64bit Prozess?' = [Environment]::Is64BitProcess
      $hash.'Computername' = [Environment]::MachineName
      $hash.'Betriebsystem?' = [Environment]::OSVersion
      $hash.'Anzahl Kerne' = [Environment]::ProcessorCount

      New-Object PSObject -Property $hash
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.16.ps1
************************************************************************
function Get-RemoteService1
{
    # Invoke-Command führt beliebigen PowerShell-Code auf einem
    # lokalen oder Remote-System aus
    Invoke-Command { Get-Service } -ComputerName dell1
}

Workflow Get-RemoteService2
{
    # InlineScript verhält sich wie Invoke-Command
    InlineScript { Get-Service } -PSComputerName dell1
}

Workflow Get-RemoteService3
{
    # ein Workflow kann insgesamt lokal oder remote ausgeführt werden
    # wenn der Parameter -PSComputerName beim Aufruf verwendet wird
    # das InlineScript wird dann auf demselben Computer ausgeführt wie
    # der Workflow, sofern es nicht selbst -PSComputerName festlegt
    InlineScript { Get-Service } 
}

Workflow Get-RemoteService4
{
    # Get-Service ist ein unterstützes Cmdlet und kann deshalb auch
    # ohne InlineScript direkt ausgeführt werden
    Get-Service 
}

$a = Get-RemoteService1
$b = Get-RemoteService2
$c = Get-RemoteService3 -PSComputerName dell1
$d = Get-RemoteService4 -PSComputerName dell1



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.17.ps1
************************************************************************
function Write-DelayMessage
{
    param($Info)
    "beginne Schritt $Info."
    Start-Sleep -Seconds 2
    "beende Schritt $Info."
}

workflow Test-Workflow
{
  parallel
    {
      Write-DelayMessage 1
      Write-DelayMessage 2
      Write-DelayMessage 3
    } 
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.18.ps1
************************************************************************
workflow Test-Workflow
{
  parallel
    {
      Get-HotFix
      Get-Service
      Get-Process
    } 
}

$ergebnis = Test-Workflow
$ergebnis.Count



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.19.ps1
************************************************************************
workflow Test-Workflow
{
  parallel
  {
    $workflow:hotfix = Get-HotFix
    $workflow:service = Get-Service
    $workflow:process = Get-Process
  }
    
  $hotfix, $service, $process
}

$ergebnis = Test-Workflow
$ergebnis.Count



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.2.ps1
************************************************************************
workflow Restart-Service
{
  sequence
  {
    InlineScript 
    {
        Stop-Service -Name MyApp -Force
        Stop-Service -name MyAppQueue -Force
    } -PSComputerName AppServer1
    

    parallel
    {
      InlineScript 
      {
        Remove-Item -Path "D:\MyApp\Files\MyAppQueue.xml" –Force
      } -PSComputerName ServerA

      InlineScript 
      {
        Remove-Item -Path "D:\MyApp\Files\MyAppQueue.xml" –Force
      } -PSComputerName ServerB
      

    } 

    InlineScript 
    {
        Start-Service -Name MyAppQueue -Force
        Start-Service -name MyApp -Force
    } -PSComputerName AppServer1
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.20.ps1
************************************************************************
workflow Test-Workflow
{
  parallel
  {
    $workflow:hotfix = InlineScript  { Get-HotFix }
    $workflow:service = InlineScript { Get-Service }
    $workflow:process = InlineScript { Get-Process }
  }
    
  $hotfix, $service, $process
}

$ergebnis = Test-Workflow
$ergebnis.Count



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.21.ps1
************************************************************************
workflow Test-ParallelForeach
{
  param
  (
    [String[]]
    $ComputerName
  )

  foreach -parallel ($Machine in $ComputerName)
  {
    "Beginn $Machine"
    Start-Sleep -Seconds 4
    "Ende $Machine"
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.22.ps1
************************************************************************
workflow Ping-Computer
{
  param
  (
    [String[]]
    $ComputerName
  )

  foreach -parallel -throttlelimit 40 ($Machine in $ComputerName)
  {
    Test-Connection -Count 1 -ComputerName $Machine -ErrorAction Ignore
  }
}

$Computer = Get-Content -Path 'c:\...\computerliste.txt'
Ping-Computer -ComputerName $Computer | Select-Object -Property Address, ResponseTime



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.23.ps1
************************************************************************
function Ping-Computer
{
  param
  (
    [Parameter(Mandatory=$true)]
    [String[]]
    $ComputerName,
  
    $Timeout = 4000
  )

  $Filter = ($ComputerName | 
     ForEach-Object { 'Address="{0}" and Timeout={1}' -f $_, $Timeout}) -join ' or '
  
  Get-WmiObject -Class Win32_PingStatus -Filter $filter |
  Select-Object -Property Address, ProtocolAddress, ResponseTime, Timeout 
  
}


$liste = 'powertheshell.com', 'powershellmagazine.com', 'powershell.com'
Ping-Computer -ComputerName $liste



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.24.ps1
************************************************************************
# Logdateien löschen, falls vorhanden:
Remove-Item $env:temp\beforeSuspend.txt -ErrorAction Ignore
Remove-Item $env:temp\afterResume.txt -ErrorAction Ignore
 
workflow Test-RestartComputer
{
    Get-Date | Out-File -FilePath $env:temp\beforeSuspend.txt
 
    # Workflow unterbrechen
    Suspend-Workflow
 
    Get-Date | Out-File -FilePath $env:temp\afterResume.txt
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.25.ps1
************************************************************************
# Logdateien löschen, falls vorhanden:
Remove-Item $env:temp\beforeSuspend.txt -ErrorAction Ignore
Remove-Item $env:temp\afterResume.txt -ErrorAction Ignore
 
workflow Test-RestartComputer
{
    Get-Date | Out-File -FilePath $env:temp\beforeSuspend.txt
 
    # Workflow unterbrechen durch Neustart des Systems
    Restart-Computer -Wait
 
    Get-Date | Out-File -FilePath $env:temp\afterResume.txt
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.26.ps1
************************************************************************
workflow Test-Job
{
    Suspend-Workflow
}

Test-Job -AsJob



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.27.ps1
************************************************************************
mkdir c:\workflow | Out-Null

$options = New-PSWorkflowExecutionOption -OutOfProcessActivity ""
$options.MaxPersistenceStoreSizeGB = 3
$options.PersistencePath = 'c:\workflow'
Register-PSSessionConfiguration -Name Microsoft.PowerShell.CustomWorkflow -SessionType Workflow  -SessionTypeOption $options



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.3.ps1
************************************************************************
function Write-DelayMessage
{
    param($Info)
    "beginne Schritt $Info."
    Start-Sleep -Seconds 2
    "beende Schritt $Info."
}

workflow Test-Workflow
{
  sequence
  {
    Write-DelayMessage 1
    

    parallel
    {
      Write-DelayMessage 2
      Write-DelayMessage 3
      Write-DelayMessage 4
    } 

    Write-DelayMessage 5
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.4.ps1
************************************************************************
workflow Test-Workflow
{
    # Splatting wird nicht unterstützt:
    $hash = @{Name = 'Spooler'}
    Get-Service  @hash
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.5.ps1
************************************************************************
workflow Test-Workflow
{
  $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
  $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  $prp.IsInRole($adm)  
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.6.ps1
************************************************************************
workflow Test-Workflow
{
  InlineScript {
    $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
    $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $prp.IsInRole($adm)
  }  
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.7.ps1
************************************************************************
workflow Test-Workflow
{
    "Ausgabe: $Text"
}

function Test-Function
{
    "Ausgabe: $Text"
}

$Text = "Hallo!"

Test-Workflow
Test-Function



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.8.ps1
************************************************************************
workflow Test-Workflow
{
    $wert = 1
    sequence 
    {
        $wert

        sequence
        {
            $wert
        }
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\26.9.ps1
************************************************************************
workflow Test-Workflow
{
    $wert = 1
    sequence 
    {
        $wert
        $workflow:wert += 1

        sequence
        {
            $wert
            $workflow:wert++
        }
    }
    $wert
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.1.ps1
************************************************************************
Configuration createDSCFolder
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

    Node "localhost"
    {
        File createFolder
        {
            Type = 'Directory'
            Ensure = 'Present'
            DestinationPath = 'c:\newfolderDSC'
            Force = $true
        }
    }
}

$file = createDSCFolder -OutputPath c:\myDSCDefinitions



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.10.ps1
************************************************************************
Configuration ClientServerConfig
{
  Import-DscResource -ModuleName PSDesiredStateConfiguration

  # diesen Teil nur für Server durchführen:
  node $AllNodes.Where{$_.Role -eq 'Server'}.NodeName
  {
    File ServerFile
    {
      Ensure = 'Present'
      DestinationPath = 'c:\DSC\serverfolder\info.txt'
      Contents = 'I am a server'
    }
  }

  # diesen Teil nur für Clients durchführen:
  node $AllNodes.Where{$_.Role -eq 'Client'}.NodeName
  {
    File ClientFile
    {
      Ensure = 'Present'
      DestinationPath = 'c:\DSC\clientfolder\info.txt'
      Contents = 'I am a client'
    }
  }

  # diesen Teil für alle Computer durchführen:
  node $AllNodes.NodeName
  {
    File AllFile
    {
      Ensure = 'Present'
      DestinationPath = 'c:\DSC\info.txt'
      Contents = 'I am a computer'
    }
  }
}

$file = ClientServerConfig -OutputPath c:\dscSpooler -ConfigurationData $info


Start-DscConfiguration -Path C:\dscSpooler -Wait -Verbose -ComputerName $info.AllNodes.NodeName -Credential PSRemoting 



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.11.ps1
************************************************************************
# neue Website auf zwei Webservern einrichten:

@{
  AllNodes = @(
    @{
      # diese Angaben gelten für alle Computer
      NodeName           = "*"
      WebsiteName        = "powertheshell.com"
      SourcePath         = "C:\PTS\"
      DestinationPath    = "C:\inetpub\PowerTheShell"
      DefaultWebSitePath = "C:\inetpub\wwwroot"
    },
 
    @{
      NodeName           = "WebServer1.PTS.com"
      Role               = "Web"
    },
 
    @{
      NodeName           = "WebServer2.PTS.com"
      Role               = "Web"
    }
  )
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.12.ps1
************************************************************************
configuration ConfigWebsite
{
  # Module für alle verwendeten Ressourcen importieren
  Import-DscResource -Module xWebAdministration, PSDesiredStateConfiguration
 
  # Betroffene Computer aus ConfigurationData ermitteln
  Node $AllNodes.where{$_.Role -eq "Web"}.NodeName
  {
    
    # Existierende Webseite stoppen
    xWebsite DefaultSite
    {
      Ensure          = "Present"
      Name            = "Default Web Site"
      State           = "Stopped"
      PhysicalPath    = $Node.DefaultWebSitePath
      DependsOn       = "[WindowsFeature]IIS"
    }
    
    # IIS-Rolle installieren
    WindowsFeature IIS
    {
      Ensure          = "Present"
      Name            = "Web-Server"
    }
 
    # .NET 4.5 installieren
    WindowsFeature AspNet45
    {
      Ensure          = "Present"
      Name            = "Web-Asp-Net45"
    }
 
    # Webseiteninhalt kopieren
    File WebContent
    {
      Ensure          = "Present"
      SourcePath      = $Node.SourcePath
      DestinationPath = $Node.DestinationPath
      Recurse         = $true
      Type            = "Directory"
      DependsOn       = "[WindowsFeature]AspNet45"
    }      
 
    # neue Webseite generieren
    xWebsite NewWebSite
    {
      Ensure          = "Present"
      Name            = $Node.WebsiteName
      State           = "Started"
      PhysicalPath    = $Node.DestinationPath
      DependsOn       = "[File]WebContent"
    }
  }
}

ConfigWebsite -ConfigurationData C:\webserverConfig\webpts.psd1 -OutputPath c:\DSCConfigsWebServer
ConfigWebsite -ConfigurationData C:\webserverConfig\webpts.psd1 -OutputPath c:\DSCConfigsWebServer



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.13.ps1
************************************************************************
$info = @{
  AllNodes = @(
    @{
      NodeName = 'localhost'
      PSDscAllowPlainTextPassword = $true
      Credential = Get-Credential $env:username
      ConsoleTextColor = '0E'
    }
  )
}

Configuration SetPSConsoleTextColor
{
  Import-DscResource -ModuleName PSDesiredStateConfiguration

  Node $AllNodes.NodeName
  {
    Registry regKey
    {
      Key = 'HKEY_CURRENT_USER\Software\Microsoft\Command Processor'
      ValueName = 'DefaultColor'
      ValueData = $Node.ConsoleTextColor
      ValueType = 'DWORD'
      Ensure = 'Present'
      Force = $true
      Hex = $true
      PsDscRunAsCredential = $Node.Credential
    }
  }
}
 
$file = SetPSConsoleTextColor -ConfigurationData $info -OutputPath c:\dscConsole 
Start-DscConfiguration -Path c:\dscConsole -Wait -Verbose -ComputerName $info.AllNodes.NodeName -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.14.ps1
************************************************************************
$info = @{
  AllNodes = @(
    @{
      NodeName = 'localhost'
      PSDscAllowPlainTextPassword = $true
      Credential = Get-Credential "$env:userdomain\$env:username"
    }
  )
}

Configuration TestUserCredential
{
  Import-DscResource -ModuleName PSDesiredStateConfiguration

  Node $AllNodes.NodeName
  {
    Script customScript
    {
      PsDscRunAsCredential = $Node.Credential
      GetScript = '@{}'
      TestScript = '$false'
      SetScript = {        
        New-Item -ItemType File -Path c:\dscTestIdentity\identity.txt -Value "$env:userdomain\$env:username" -Force
      }
    }
  }
}
 
$file = TestUserCredential -ConfigurationData $info -OutputPath c:\dscTestIdentity 
Start-DscConfiguration -Path c:\dscTestIdentity -Wait -Verbose -ComputerName $info.AllNodes.NodeName -Force
notepad c:\dscTestIdentity\identity.txt



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.15.ps1
************************************************************************
function New-CMSTestCert
{
  param
  (
    [SecureString]
    [Parameter(Mandatory=$true)]
    $Password,

    $FriendlyName = 'CMS Test Cert',

    $CN = 'CMSTestCert',

    $OutputPath = "$env:temp\CMSTestCertificate",

    $ValidUntil = (Get-Date).AddYears(5)
  )

  # Zertifikat im User-Store ablegen:
  $cert = New-SelfSignedCertificate -KeyUsage DataEncipherment, KeyEncipherment -KeySpec KeyExchange -FriendlyName $FriendlyName -Subject "CN=$CN" -KeyExportPolicy ExportableEncrypted -CertStoreLocation Cert:\CurrentUser\My -NotAfter $ValidUntil -TextExtension @('2.5.29.37={text}1.3.6.1.4.1.311.80.1')
  
  # öffentlichen Teil als cert-Datei exportieren:
  if (!(Test-Path -Path $OutputPath)) { $null = New-Item -Path $outputPath -ItemType Directory -Force }
  $pathCer = Join-Path -Path $OutputPath -ChildPath "$CN.cer"
  $null = Export-Certificate -Type CERT -FilePath $pathCer -Cert $cert -Force
  
  # privaten Teil als pfx-Datei exportieren:
  $pathPfx = Join-Path -Path $OutputPath -ChildPath "$CN.pfx"
  $null = $cert | Export-PfxCertificate -Password $Password -FilePath $pathPfx 

  # Zertifikat aus Zertifikat-Speicher löschen:
  $cert | Remove-Item
  Get-Item Cert:\CurrentUser\CA\$($cert.Thumbprint) | Remove-Item

  # Ergebnis anzeigen
  explorer $OutputPath
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.16.ps1
************************************************************************
$info = @'
-----BEGIN CMS-----
MIIBngYJKoZIhvcNAQcDoIIBjzCCAYsCAQAxggFGMIIBQgIBADAqMBYxFDASBgNVBAMMC0NNU1Rl
c3RDZXJ0AhAtZfLpu8+4tkqIo4c6d6hQMA0GCSqGSIb3DQEBBzAABIIBACFgM8L/xmoAL2q0nmZR
lD2dWyClH1w1MTbBdvZvUkd3Jg2w0rxLvg7NV3aeyPJ3V9yBQYqlNDL4zhKj+I4zejNJ5I5tjJoV
qXK6P+BAxnRXYK2hYeCWCYH1du3yGL4g0AvNo1W7V7Xjh80wnSfKP1zJvemWpp1V6BQ8ffA4veHp
TtWiC+73go96DAo+59jcMmib67xKRyYLCkEDl6GQaSDzVl9ufxRYCaYRB2gLL2fllGOlIze0tv4v
X4N2f7VP7DuzKfjoeLnXqKJF8DO2Xn8vkqDNH7AqU06TsfuSfh2K7WS//b2JGJdL0NOBvb3aaiJs
5oP+ZxT4+3RgDW0z5wkwPAYJKoZIhvcNAQcBMB0GCWCGSAFlAwQBKgQQ1gVeibawRWKEq94aglaR
64AQF+kvNY+C5Nb7RoSfugUqig==
-----END CMS-----
'@

$message = $info | Get-CmsMessage
$message.RecipientInfos[0].RecipientIdentifier.Value 



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.17.ps1
************************************************************************
#Requires -RunAsAdministrator

function New-DSCTestCert
{
  param
  (
    [SecureString]
    [Parameter(Mandatory=$true)]
    $Password,

    $FriendlyName = 'DSC Test Cert',

    $CN = 'DSCTestCert',

    $OutputPath = "$env:temp\DSCTestCertificate",

    $ValidUntil = (Get-Date).AddYears(5)
  )

  # Zertifikat im User-Store ablegen:
  $cert = New-SelfSignedCertificate -KeyUsage DataEncipherment, KeyEncipherment -KeySpec KeyExchange -FriendlyName $FriendlyName -Subject "CN=$CN" -KeyExportPolicy ExportableEncrypted -CertStoreLocation Cert:\LocalMachine\My -NotAfter $ValidUntil -TextExtension @('2.5.29.37={text}1.3.6.1.4.1.311.80.1')
  
  # öffentlichen Teil als cert-Datei exportieren:
  if (!(Test-Path -Path $OutputPath)) { $null = New-Item -Path $outputPath -ItemType Directory -Force }
  $pathCer = Join-Path -Path $OutputPath -ChildPath "$CN.cert"
  $null = Export-Certificate -Type CERT -FilePath $pathCer -Cert $cert -Force
  
  # privaten Teil als pfx-Datei exportieren:
  $pathPfx = Join-Path -Path $OutputPath -ChildPath "$CN.pfx"
  $null = $cert | Export-PfxCertificate -Password $Password -FilePath $pathPfx 

  # Zertifikat aus Liste der Zwischenzertifizierungsstellen löschen:
  Get-Item Cert:\CurrentUser\CA\$($cert.Thumbprint) | Remove-Item

  # Ergebnis anzeigen
  explorer $OutputPath
  
  # Zertifikatinfos zurückgeben
  $thumbprint = $cert.Thumbprint
  "Thumbprint =      '$thumbprint'"
  "CertificateFile = '$pathCer'"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.18.ps1
************************************************************************
$info = @{
  AllNodes = @(
    @{
      NodeName = 'localhost'
      Thumbprint =      '3C11ED594A9E34554B09614784FA555932498FF7'
      CertificateFile = 'C:\Users\Tobias\AppData\Local\Temp\DSCTestCertificate\DSCTestCert.cert'
      Credential = Get-Credential $env:username
      ConsoleTextColor = '0E'
    }
  )
}
Configuration SetPSConsoleTextColor
{
  Import-DscResource -ModuleName PSDesiredStateConfiguration

  Node $AllNodes.NodeName
  {
    LocalConfigurationManager 
    { 
      CertificateId = $node.Thumbprint 
    }

    Registry regKey
    {
      Key = 'HKEY_CURRENT_USER\Software\Microsoft\Command Processor'
      ValueName = 'DefaultColor'
      ValueData = $Node.ConsoleTextColor
      ValueType = 'DWORD'
      Ensure = 'Present'
      Force = $true
      Hex = $true
      PsDscRunAsCredential = $Node.Credential
    }
  }
}
 
$file = SetPSConsoleTextColor -ConfigurationData $info -OutputPath c:\dscConsole 



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.19.ps1
************************************************************************
#requires -Version 5

$archive = Join-Path -Path $env:temp -ChildPath winScripts.zip

# alle PowerShell-Skripts im gesamten Windows-Ordner finden
# (ersetzen Sie $env:windir durch $home, wenn Sie stattdessen alle 
# PowerShell-Skripts in Ihrem Benutzerprofil sichern wollen)
Get-ChildItem -Path $env:windir -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue -File |
    # Get-ChildItem liefert trotz des Filters auch *.ps1xml Dateien, daher zusätzlich
    # hier ein clientseitiger Filter:
    Where-Object Extension -eq '.ps1' |
    # Dateien in ZIP-Datei schreiben und vorhandene ZIP-Datei
    # ggfs. überschreiben (-Update):
    Compress-Archive -DestinationPath $archive -CompressionLevel Optimal -Update

# angelegte oder aktualisierte ZIP-Datei im Explorer anzeigen
explorer "/select,$destinationPath"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.2.ps1
************************************************************************
Configuration createDSCFolder
{
  Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

  File createFolder
  {
      Type = 'Directory'
      Ensure = 'Present'
      DestinationPath = 'c:\newfolderDSC'
      Force = $true
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.20.ps1
************************************************************************
#requires -Version 5

$archive = Join-Path -Path $env:temp -ChildPath winScripts.zip
$target = Join-Path -Path $env:temp -ChildPath WinScripts

# Entblocken ist nur erforderlich für ZIP-Archive, die aus dem
# Internet oder anderen potentiell unsicheren Quellen heruntergeladen
# wurden und wird hier nur der Vollständigkeit halber aufgeführt:
Unblock-File -Path $archive

# Inhalt der ZIP-Datei auspacken und vorhandene Dateien ggfs.
# überschreiben (-Force)
Expand-Archive -Path $archive -DestinationPath $target -Force

# entpackten Ordner im Explorer anzeigen
explorer.exe $target



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.21.ps1
************************************************************************
# Quelle und Ziel angeben
$archive = Join-Path -Path $env:temp -ChildPath winScripts.zip
$target = Join-Path -Path $env:temp -ChildPath WinScriptsDSCManual
# DSC-Ressource finden
$resource = Get-DscResource -Name Archive
# DSC-Ressource als Modul laden
$module = import-module $resource.Path -PassThru
# Variable in Modul nachträglich ändern
# (die Cache-Variable zeigt auf einen geschützten Systemordner;
# damit die Ressource ohne Adminrechte aufrufbar wird, muss der
# Cache-Ordner in einen Bereich verlegt werden, der keine
# Adminrechte erfordert)
. $module { $CacheLocation = Join-Path -Path $env:temp -ChildPath ArchiveCache }
# DSC-Ressource aufrufen (heißt immer Set-TargetResource)
Set-TargetResource -Path $archive -Destination $target -Ensure Present -Force $true -Credential (Get-Credential)
# Targetordner im Explorer öffnen
explorer $target


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.22.ps1
************************************************************************
# Quelle und Ziel angeben
$archive = Join-Path -Path $env:temp -ChildPath winScripts.zip
$target = Join-Path -Path $env:temp -ChildPath WinScriptsDSCManual

# DSC-Ressource finden
$resource = Get-DscResource -Name Archive
# DSC-Ressource als Modul laden
$module = import-module $resource.Path -PassThru

# Variable in Modul nachträglich ändern
# (die Cache-Variable zeigt auf einen geschützten System-Ordner;
# damit die Ressource ohne Adminrechte aufrufbar wird, muss der
# Cache-Ordner in einen Bereich verlegt werden, der keine
# Adminrechte erfordert)
. $module { $CacheLocation = Join-Path -Path $env:temp -ChildPath ArchiveCache }

# DSC-Ressource aufrufen (heißt immer Set-TargetResource)
Set-TargetResource -Path $archive -Destination $target -Ensure Present -Force $true -Credential (Get-Credential)

# Targetordner im Explorer öffnen
explorer $target



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.23.ps1
************************************************************************
function Set-ArchiveResource
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Path,
        
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Destination,
        
        [Switch] $Validate,
        
        [ValidateSet("", "SHA-1", "SHA-256", "SHA-512", "CreatedDate", "ModifiedDate")]
        [string] $Checksum,

        [Switch] $Force,
        
        [pscredential] $Credential,

        [ValidateSet("Present", "Absent")]
        [string] $Ensure = "Present"
    )

# DSC-Ressource finden
$ProgressPreference = 'SilentlyContinue'

#$resource = Get-DscResource -Name Archive 
# DSC-Ressource als Modul laden
#$module = import-module $resource.Path -PassThru
$module = Import-Module -PassThru -Name "$PSHOME\Modules\PsDesiredStateConfiguration\DSCResources\MSFT_ArchiveResource\MSFT_ArchiveResource.psm1"
# Variable in Modul nachträglich ändern
# (die Cache-Variable zeigt auf einen geschützten System-Ordner;
# damit die Ressource ohne Adminrechte aufrufbar wird, muss der
# Cache-Ordner in einen Bereich verlegt werden, der keine
# Adminrechte erfordert)
. $module { $CacheLocation = Join-Path -Path $env:temp -ChildPath ArchiveCache }

# DSC-Ressource aufrufen (heißt immer Set-TargetResource)
Set-TargetResource @PSBoundParameters

# Modul entladen
Remove-Module $module

# Targetordner im Explorer öffnen
explorer $Destination
}

# Quelle und Ziel angeben
$archive = Join-Path -Path $env:temp -ChildPath winScripts.zip
$target = Join-Path -Path $env:temp -ChildPath WinScriptsDSCManual

Set-ArchiveResource -Path $archive -Destination $target



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.24.ps1
************************************************************************
#requires -Version 1

# Umgebungsvariablen im "Process"-Set
# (gelten nur für die aktuelle Anwendung und
# alle von ihr gestarteten Anwendungen)

# anlegen:
$env:NewVariable = 'test'

# lesen:
$env:NewVariable

# löschen:
# ACHTUNG: nicht $env:NewVariable angeben, sondern env:NewVariable
# andernfalls wird der INHALT der Variablen gelesen und dieser Pfad
# gelöscht!
Remove-Item -Path env:NewVariable

# Umgebungsvariablen im "User"-Set
# (gelten für den aktuellen Anwender)

# anlegen:
[Environment]::SetEnvironmentVariable('test', '100', 'user')

# lesen:
[Environment]::GetEnvironmentVariable('test', 'user')

# löschen:
[Environment]::SetEnvironmentVariable('test', '', 'user')


# Umgebungsvariablen im "Machine"-Set
# (gelten für alle Anwender, das Anlegen erfordert
# Administrator Rechte)

# anlegen:
[Environment]::SetEnvironmentVariable('test', '100', 'machine')

# lesen:
[Environment]::GetEnvironmentVariable('test', 'machine')

# löschen:
[Environment]::SetEnvironmentVariable('test', '', 'machine')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.25.ps1
************************************************************************
# Pfad in %PATH% aufnehmen ("Machine"-Set für alle User)
Invoke-DscResource -Name Environment -Method Set -ModuleName PSDesiredStateConfiguration -Property @{Name = 'Path'; Path = $true; Value = 'c:\newfolder';  Ensure = 'Present'}

# Erfolg überprüfen:
[Environment]::GetEnvironmentVariable('Path', 'machine') -split ';'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.26.ps1
************************************************************************
# Pfad in %PATH% aufnehmen ("Machine"-Set für alle User)
Invoke-DscResource -Name Environment -Method Set -ModuleName PSDesiredStateConfiguration -Property @{Name = 'Path'; Path = $true; Value = 'c:\newfolder';  Ensure = 'Absent'}

# Erfolg überprüfen:
[Environment]::GetEnvironmentVariable('Path', 'machine') -split ';'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.27.ps1
************************************************************************
# Pfad in %PATH% aufnehmen ("Machine"-Set für alle User)
Invoke-DscResource -Name Environment -Method Set -ModuleName PSDesiredStateConfiguration -Property @{Name = 'Test'; Path = $false; Value = '100';  Ensure = 'Present'}

# Erfolg überprüfen:
[Environment]::GetEnvironmentVariable('Test', 'machine')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.28.ps1
************************************************************************
Invoke-DscResource -Name Group -Method Set -ModuleName PSDesiredStateConfiguration -Property @{GroupName = 'PowerShellUsers'; Description = 'created by DSC'; Ensure = 'Present'}

# überprüfen
net localgroup



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.29.ps1
************************************************************************
Find-DscResource |
 Select-Object Name, Version, ModuleName |
 Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.3.ps1
************************************************************************
$LCM = Get-WmiObject MSFT_Providers | Where-Object { $_.Provider -like 'dsccore' }
$id = $LCM.HostProcessIdentifier
Get-Process -Id $id



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.30.ps1
************************************************************************
Find-Module -Tag DSC | 
  Select -Property Name, Author, Version, PublishedDate, Description, ProjectUri | 
  Sort-Object -Property PublishedDate -Descending |
  Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.31.ps1
************************************************************************
configuration Defender
{
  Import-DscResource -ModuleName xDefender
  node Localhost
  {
    xMpPreference Test1
    {
      Name = 'MyPreferences1'
      CheckForSignaturesBeforeRunningScan = $True
      HighThreatDefaultAction = 'Clean'
    }   
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.32.ps1
************************************************************************
configuration Defender
{
  Import-DscResource -ModuleName xDefender
  node Localhost
  {
    xMpPreference SignatureSetting
    {
      Name = 'SignatureCheck'
      CheckForSignaturesBeforeRunningScan = $True
    } 

    xMpPreference HighThreatAction
    {
      Name = 'HighThreadAction'
      HighThreatDefaultAction = 'Clean'
    }     
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.33.ps1
************************************************************************
# Angaben zu Modul und Ressource:
$ModuleName = 'xConfigPersonalData'
$ResourceName = 'xSetOwnerInfo'
$parameters = @()
$parameters += New-xDscResourceProperty –Name RegisteredOwner –Type String –Attribute Key
$parameters += New-xDscResourceProperty –Name RegisteredOrganization –Type String –Attribute Key


# Default-Property hinzufügen
$parameters += New-xDscResourceProperty –Name Ensure –Type String –Attribute Write –ValidateSet 'Absent', 'Present'

# Modul und Ressource anlegen:
$ModulePath = "$env:ProgramFiles\WindowsPowerShell\Modules\$ModuleName"
New-xDscResource –Name $ResourceName -Property $parameters -Path $ModulePath

# Modulmanifest hinzufügen (Version, Beschreibung, etc.)
New-ModuleManifest -Path "$ModulePath\$ModuleName.psd1" -Author Tobias -Description 'Verwaltet persönliche Einstellungen wie z.B. Angaben über den Besitzer des Computers' -ModuleVersion 1.0

# Modul-Datei im ISE-Editor öffnen
ise "$ModulePath\$ModuleName.psm1"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.34.ps1
************************************************************************
function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $RegisterdOwner,

        [parameter(Mandatory = $true)]
        [System.String]
        $RegisterdOrganization
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $returnValue = @{
    RegisterdOwner = [System.String]
    RegisterdOrganization = [System.String]
    Ensure = [System.String]
    }

    $returnValue
    #>
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $RegisterdOwner,

        [parameter(Mandatory = $true)]
        [System.String]
        $RegisterdOrganization,

        [ValidateSet("Absent","Present")]
        [System.String]
        $Ensure
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    #Include this line if the resource requires a system reboot.
    #$global:DSCMachineStatus = 1


}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $RegisterdOwner,

        [parameter(Mandatory = $true)]
        [System.String]
        $RegisterdOrganization,

        [ValidateSet("Absent","Present")]
        [System.String]
        $Ensure
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $result = [System.Boolean]
    
    $result
    #>
}


Export-ModuleMember -Function *-TargetResource



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.35.ps1
************************************************************************
function Get-TargetResource
{
  [CmdletBinding()]
  [OutputType([System.Collections.Hashtable])]
  param
  (
    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOwner = '',

    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOrganization = '',

    [ValidateSet('Absent','Present')]
    [System.String]
    $Ensure
  )

  # Registry ansprechen und Werte aus einem Schlüssel lesen:
  $key = 'Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
  $values = Get-ItemProperty -Path $key

  # für diese Konfiguration relevante Werte als Hashtable zurückliefern:
  $returnValue = @{
    RegisteredOwner = $values.RegisteredOwner
    RegisteredOrganization = $values.RegisteredOrganization
  }

  $returnValue
    
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.36.ps1
************************************************************************
function Test-TargetResource
{
  [CmdletBinding()]
  [OutputType([System.Boolean])]
  param
  (
    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOwner = '',

    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOrganization = '',

    [ValidateSet('Absent','Present')]
    [System.String]
    $Ensure
  )

  # aktuelle Konfiguration lesen
  $aktuell = Get-TargetResource -RegisteredOwner $RegisteredOwner -RegisteredOrganization $RegisteredOwner
    
  # entspricht diese den Wünschen?
  $wert1OK = $aktuell.RegisteredOwner -eq $RegisteredOwner
  $wert2OK = $aktuell.RegisteredOrganization -eq $RegisteredOrganization
    
  $wert1OK -and $wert2OK
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.37.ps1
************************************************************************
function Set-TargetResource
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOwner = '',

    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOrganization = '',

    [ValidateSet('Absent','Present')]
    [System.String]
    $Ensure
  )

  # Registrierungsschlüssel, der geändert wird
  $key = 'Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
  
  # Werte neu eintragen
  if ($Ensure -eq 'Present')
  {
    Write-Verbose "Updating Owner Info: $RegisteredOwner $RegisteredOrganization"
    Set-ItemProperty -Path $key -Name RegisteredOwner -Value $RegisteredOwner
    Set-ItemProperty -Path $key -Name RegisteredOrganization -Value $RegisteredOrganization
  }
  # Werte entfernen
  elseif ($Ensure -eq 'Absent')
  {
    Write-Verbose 'Clearing Owner Info'
    Clear-ItemProperty -Path $key -Name RegisteredOwner 
    Clear-ItemProperty -Path $key -Name RegisteredOrganization 
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.38.ps1
************************************************************************
function Get-TargetResource
{
  [CmdletBinding()]
  [OutputType([System.Collections.Hashtable])]
  param
  (
    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOwner = '',

    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOrganization = '',

    [ValidateSet('Absent','Present')]
    [System.String]
    $Ensure
  )

  # Registry ansprechen und Werte aus einem Schlüssel lesen:
  $key = 'Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
  $values = Get-ItemProperty -Path $key

  # für diese Konfiguration relevante Werte als Hashtable zurückliefern:
  $returnValue = @{
    RegisteredOwner = $values.RegisteredOwner
    RegisteredOrganization = $values.RegisteredOrganization
  }

  $returnValue
    
}

function Set-TargetResource
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOwner = '',

    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOrganization = '',

    [ValidateSet('Absent','Present')]
    [System.String]
    $Ensure
  )

  # Registrierungsschlüssel, der geändert wird
  $key = 'Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
  
  # Werte neu eintragen
  if ($Ensure -eq 'Present')
  {
    Write-Verbose "Updating Owner Info: $RegisteredOwner $RegisteredOrganization"
    Set-ItemProperty -Path $key -Name RegisteredOwner -Value $RegisteredOwner
    Set-ItemProperty -Path $key -Name RegisteredOrganization -Value $RegisteredOrganization
  }
  # Werte entfernen
  elseif ($Ensure -eq 'Absent')
  {
    Write-Verbose 'Clearing Owner Info'
    Clear-ItemProperty -Path $key -Name RegisteredOwner 
    Clear-ItemProperty -Path $key -Name RegisteredOrganization 
  }
}

function Test-TargetResource
{
  [CmdletBinding()]
  [OutputType([System.Boolean])]
  param
  (
    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOwner = '',

    [Parameter(Mandatory=$true)]
    [AllowEmptyString()]
    [System.String]
    $RegisteredOrganization = '',

    [ValidateSet('Absent','Present')]
    [System.String]
    $Ensure
  )

  # aktuelle Konfiguration lesen
  $aktuell = Get-TargetResource -RegisteredOwner $RegisteredOwner -RegisteredOrganization $RegisteredOwner
    
  # entspricht diese den Wünschen?
  $wert1OK = $aktuell.RegisteredOwner -eq $RegisteredOwner
  $wert2OK = $aktuell.RegisteredOrganization -eq $RegisteredOrganization
    
  $wert1OK -and $wert2OK
}

Export-ModuleMember -Function *-TargetResource



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.39.ps1
************************************************************************
Configuration TestScriptResource
{
  Import-DscResource -ModuleName PSDesiredStateConfiguration

  Node localhost
  {
    Script customScript
    {
      GetScript = {
        # Registry ansprechen und Werte aus einem Schlüssel lesen:
        $key = 'Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
        $values = Get-ItemProperty -Path $key

        # für diese Konfiguration relevante Werte als Hashtable zurückliefern:
        $returnValue = @{
          RegisteredOwner = $values.RegisteredOwner
          RegisteredOrganization = $values.RegisteredOrganization
        }

        $returnValue
      }
      TestScript = {
        $RegisteredOwner = 'Tobias Weltner'
        $RegisteredOrganization = 'powertheshell.com'

        $key = 'Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
        $values = Get-ItemProperty -Path $key
        
        # entspricht diese den Wünschen?
        $wert1OK = $values.RegisteredOwner -eq $RegisteredOwner
        $wert2OK = $values.RegisteredOrganization -eq $RegisteredOrganization
        
        $wert1OK -and $wert2OK
      }
      
      SetScript = {
        $RegisteredOwner = 'Tobias Weltner'
        $RegisteredOrganization = 'powertheshell.com'

        # Registrierungsschlüssel, der geändert wird
        $key = 'Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
        Write-Verbose "Updating Owner Info: $RegisteredOwner $RegisteredOrganization"
        Set-ItemProperty -Path $key -Name RegisteredOwner -Value $RegisteredOwner
        Set-ItemProperty -Path $key -Name RegisteredOrganization -Value $RegisteredOrganization
      }
    }
  }
}
 
$file = TestScriptResource -ConfigurationData $info -OutputPath c:\dscTest 
Start-DscConfiguration -Path c:\dscTest -Wait -Verbose -ComputerName localhost -Force

# Erfolg der Konfiguration prüfen:
winver.exe



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.4.ps1
************************************************************************
Configuration LCMDefaultConfig
{ 
    Param([string]$ComputerName)
    
    node ($ComputerName)
    {
        LocalConfigurationManager 
        {
            RebootNodeIfNeeded = $false 
        }
     }
}

# Metadatei für LCM generieren
$path = 'C:\LCMConfig'
$file = LCMDefaultConfig -OutputPath $path -ComputerName localhost

# Metadatei an LCM senden
Set-DscLocalConfigurationManager -Path $path -ComputerName localhost



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.40.ps1
************************************************************************
Configuration changeSystemOwner
{
    Import-DscResource –ModuleName xConfigPersonalData

    Node 'localhost'
    {
        xSetOwnerInfo OwnerConfig
        {
            RegisteredOwner = 'Dr. Tobias Weltner'
            RegisteredOrganization = 'powertheshell.com'
            Ensure = 'Present'
        }
    }
}

$file = changeSystemOwner -OutputPath c:\myDSCDefinitions



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.41.ps1
************************************************************************
Configuration LocalUserConfig {

  Import-DscResource –ModuleName PSDesiredStateConfiguration

  Node localhost 
  {
    Group PSGroup 
    {
      Ensure = 'Present'
      GroupName = 'PowerShellUsers'
      MembersToInclude = 'Dozent'
      DependsOn = '[User]GroupMember'
    }

    User GroupMember {
      Ensure = 'Present'
      UserName = 'Dozent'
      PasswordNeverExpires = $true
    }
  }
}

$file = LocalUserConfig -OutputPath c:\DSCLocalUser 
Start-DscConfiguration -Path c:\DSCLocalUser -ComputerName localhost -Wait -Verbose



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.42.ps1
************************************************************************
Configuration CreateTextFileClient
{
  Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
  WaitForAny WaitForB
  {
    ResourceName = '[File]CreateTextFileServer'
    NodeName = 'SYSTEM_B'
    RetryIntervalSec = 30
    RetryCount = 30
  }
  File TestFile
  {
    DestinationPath = 'C:\DSCWaitFor\test.txt'
    Contents = 'beliebiger Inhalt'
  }
}

CreateTextFileClient -OutputPath c:\DSCWaitFor



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.43.ps1
************************************************************************
Configuration CreateTextFileServer 
{
  Import-DscResource -ModuleName 'PSDesiredStateConfiguration' 
     
  File TestFile
  {
    DestinationPath = 'C:\DSCWaitFor\test.txt'
    Contents = 'anderer beliebiger Inhalt'
  }
}

CreateTextFileServer -OutputPath c:\DSCWaitFor



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.44.ps1
************************************************************************
[DscLocalConfigurationManager()]
Configuration SetupPartialConfig
{
  PartialConfiguration SpoolerService
  {
    Description = 'Enables the Spooler Service'
    RefreshMode = 'Push'
  }

  PartialConfiguration TextFile
  {
    Description = 'Create a text file'
    RefreshMode = 'Push'
    DependsOn = '[PartialConfiguration]SpoolerService'
  }
}

# Metadata generieren
SetupPartialConfig -OutputPath c:\TestPartialConfigs

# LCM konfigurieren
Set-DscLocalConfigurationManager -Path c:\TestPartialConfigs -Verbose



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.45.ps1
************************************************************************
Configuration SpoolerService
{
  Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
  Service SpoolerService
  {
    Ensure = 'Present'
    Name = 'Spooler'
    StartupType = 'Automatic'
    State = 'Running'
  }
}
SpoolerService -OutputPath c:\SpoolerService
Publish-DscConfiguration -Path c:\SpoolerService -Verbose



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.46.ps1
************************************************************************
Configuration TextFile
{
  Import-DscResource -ModuleName 'PSDesiredStateConfiguration'            
  File TestFile
  {
    DestinationPath = 'C:\TextFile\test.txt'
    Contents = 'beliebiger Inhalt'
  }
}
TextFile -OutputPath c:\TextFile
Publish-DscConfiguration -Path c:\TextFile -Verbose



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.47.ps1
************************************************************************
Configuration SpoolerService
{
  Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
  Service SpoolerService
  {
    Ensure = 'Present'
    Name = 'Spooler'
    StartupType = 'Disabled'
    State = 'Stopped'
  }
}
SpoolerService -OutputPath c:\SpoolerService
Publish-DscConfiguration -Path c:\SpoolerService -Verbose



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.48.ps1
************************************************************************
ComputerSyncPUSH -ConfigurationData $ConfigData -OutputPath c:\DSCTest



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.49.ps1
************************************************************************
function Start-DscMonitor
{
  $code = {
    param($hostobj)
    do
    {
        $status = (Get-DscLocalConfigurationManager).LCMStateDetail
        if (!$status) { $status = 'LCM is idle' }
        $hostobj.ui.RawUI.WindowTitle = $status
        Start-Sleep -Milliseconds 300
    } while ($true)
  }

  $global:OldTitle = $host.UI.RawUI.WindowTitle
  $global:DSCMonitor = [PowerShell]::Create()
  $null = $global:DSCMonitor.AddScript($code).AddArgument($host)
  $null = $global:DSCMonitor.BeginInvoke()
  Write-Warning 'DSC Monitor enabled. Use Stop-DscMonitor to disable'
}

function Stop-DscMonitor
{
  if ($global:DSCMonitor -eq $null) { return }
  
  $global:DSCMonitor.Runspace.Close()
  $global:DSCMonitor.Dispose()
  $global:DSCMonitor = $null
  $host.UI.RawUI.WindowTitle = $global:OldTitle
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.5.ps1
************************************************************************
Configuration SpoolerService
{
  Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

  node localhost
  {
    Service SpoolerService
    {
      Ensure = 'Present'
      Name = 'Spooler'
      StartupType = 'Automatic'
      State = 'Running'
    }
  }
}

$file = SpoolerService -OutputPath c:\dscSpooler

Start-DscConfiguration -Path C:\dscSpooler -Wait -Verbose



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.50.ps1
************************************************************************
configuration SpoolerWatch
{
  Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
  
  service Spoolerüberwachung
  {
    Name = 'Spooler'
    StartupType = 'Automatic'
    State = 'Running'
    Ensure = 'Present'
  }
}

$file = SpoolerWatch -OutputPath C:\SpoolerConfig



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.51.ps1
************************************************************************
Configuration LCMConfigMonitor
{ 
    Param([string]$ComputerName)
    
    node ($ComputerName)
    {
        LocalConfigurationManager 
        {
            ConfigurationMode = 'ApplyAndAutoCorrect'   
            ConfigurationModeFrequencyMins = 15  
            RefreshFrequencyMins = 30      
        }
     }
}

# Metadatei für LCM generieren
$path = 'C:\LCMConfig'
$file = LCMConfigMonitor -OutputPath $path -ComputerName localhost

# Metadatei an LCM senden
Set-DscLocalConfigurationManager -Path $path -ComputerName localhost



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.52.ps1
************************************************************************
Configuration LCMConfigMonitor
{ 
    Param([string]$ComputerName)
    
    node ($ComputerName)
    {
        LocalConfigurationManager 
        {
            ConfigurationMode = 'ApplyOnly'   
        }
     }
}

# Metadatei für LCM generieren
$path = 'C:\LCMConfig'
$file = LCMConfigMonitor -OutputPath $path -ComputerName localhost

# Metadatei an LCM senden
Set-DscLocalConfigurationManager -Path $path -ComputerName localhost



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.6.ps1
************************************************************************
$Computer = 'SERVER_B'

Configuration SpoolerService
{
  Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

  node $Computer
  {
    Service SpoolerService
    {
      Ensure = 'Present'
      Name = 'Spooler'
      StartupType = 'Automatic'
      State = 'Running'
    }
  }
}

$file = SpoolerService -OutputPath c:\dscSpooler

Start-DscConfiguration -Path C:\dscSpooler -Wait -Verbose -ComputerName $Computer 



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.7.ps1
************************************************************************
$info =
@{
  AllNodes =
  @(
    @{
      NodeName = 'SERVER_B'
    }
  )
}

Configuration SpoolerService
{
  Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

  node $AllNodes.NodeName
  {
    Service SpoolerService
    {
      Ensure = 'Present'
      Name = 'Spooler'
      StartupType = 'Automatic'
      State = 'Running'
    }
  }
}

$file = SpoolerService -OutputPath c:\dscSpooler -ConfigurationData $info


Start-DscConfiguration -Path C:\dscSpooler -Wait -Verbose -ComputerName $info.AllNodes.NodeName 



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.8.ps1
************************************************************************
$info =
@{
  AllNodes =
  @(
    @{
      NodeName = 'SERVER_B'
    },
    @{
      NodeName = 'SERVER_C'
    }
  )
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\27.9.ps1
************************************************************************
$info =
@{
  AllNodes =
  @(
    @{
      NodeName = 'win10box1'
      Role = 'Client'
    },
    @{
      NodeName = 'SERVER_A'
      Role = 'Server'
    },
    @{
      NodeName = 'win8box99'
      Role = 'Client'
    }
  );
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\28.1.ps1
************************************************************************
$timer = New-Object Timers.Timer
$job = Register-ObjectEvent $timer -EventName Elapsed -Action { [System.Console]::Beep(1000,500) }
$timer.Interval = 2000
$timer.Enabled = $true



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\28.2.ps1
************************************************************************
$job = Invoke-Command -Computer storage1 { dir $env:windir *.log -Recurse -ea 0 } -AsJob
Register-ObjectEvent $job -EventName StateChanged -SourceIdentifier JobEnd -Action {
  if($job.State -eq "Completed")
    {
      Write-Host 'Hintergrundjob ist fertig!' -Back 'White' -Fore 'Red'
      Write-Host "$(Receive-Job $job | Out-String)"
      Unregister-Event -SourceIdentifier JobEnd
      Remove-Job -Name JobEnd
      Remove-Job $job
    }
  } | Out-Null



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\28.3.ps1
************************************************************************
function Monitor-Folder {
    param([string]$folder)

    $fsw = New-Object System.IO.FileSystemWatcher
    $fsw.Path = $folder

    $global:folderchange = @()

    $action = {
        [System.Console]::Beep(440,100)
  $info = @{}
  $info.Path = $eventArgs.FullPath
  $info.Type = $eventArgs.ChangeType
  $info.Timestamp = (Get-Date)
  $global:folderchange += (New-Object PSObject -Property $info)
    }

    Register-ObjectEvent $fsw -EventName Created -Action $action -SourceIdentifier Watch1 | Out-Null
    Register-ObjectEvent $fsw -EventName Changed -Action $action -SourceIdentifier Watch2 | Out-Null
    Register-ObjectEvent $fsw -EventName Deleted -Action $action -SourceIdentifier Watch3 | Out-Null
}

function Unmonitor-Folder {
  Unregister-Event Watch*
  Remove-Job -Name Watch*
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\28.4.ps1
************************************************************************
While ($true) {
  [System.Console]::Beep(500,100)
  Start-Sleep -Seconds 3
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\28.5.ps1
************************************************************************
function Do-Every
{
   param([int] $seconds,[scriptblock] $action )
   $timer = New-Object System.Timers.Timer
   $timer.Interval = $seconds * 1000
   $timer.Enabled = $true
   Register-ObjectEvent $timer "Elapsed" -SourceIdentifier 'DoEvery' -Action $action
}

function Clean-Every
{
  Unregister-Event DoEvery
  Remove-Job -name DoEvery
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\28.6.ps1
************************************************************************
Register-EngineEvent -SourceIdentifier VariableChange -Action { Write-Host ($event.MessageData) -Fore 'DarkGreen' -Back 'White'} | Out-Null

function Monitor-Variable($variablename) {
  $action = '$true; New-Event -SourceIdentifier VariableChange -MessageData "Neuer Wert $_ für Variable {0}"' -f $variablename
  (Get-Variable $variablename).Attributes.Add((New-Object System.Management.Automation.ValidateScriptAttribute ([scriptblock]::Create($action))))
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\29.1.ps1
************************************************************************
# Notepad starten
$notepad = Start-Process -FilePath notepad -PassThru

# alle aktuell laufenden Prozesse merken
$vorher = Get-Process | 
  Add-Member -MemberType NoteProperty -Name Status -Value entfernt -PassThru

# notepad beenden und Webseite öffnen:
$notepad | Stop-Process
Start-Process -FilePath http://www.tagesschau.de

# wieder alle aktuell laufenden Prozesse merken:
$nachher = Get-Process | 
  Add-Member -MemberType NoteProperty -Name Status -Value hinzugekommen -PassThru

# Prozesslisten vergleichen
Compare-Object -Reference $vorher -Difference $nachher -Property Name, ID -PassThru |
  Select-Object -Property Name, Id, Status



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\29.2.ps1
************************************************************************
$size = 21367125376521 | Add-Member -MemberType ScriptMethod -Name ShowMB -Value { [Math]::Round(($this / 1MB),1) } -PassThru



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\29.3.ps1
************************************************************************
$code = {[Math]::Round(($this / 1MB),1) } 

Update-TypeData -MemberType ScriptMethod -MemberName ShowMB -Value $code -TypeName System.Int64 -Force

Update-TypeData -MemberType ScriptMethod -MemberName ShowMB -Value $code -TypeName System.Int32 -Force



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\29.4.ps1
************************************************************************
$server1 = '\\storage1'
$server2 = '\\powershellpc'

$fileList1 = Get-ChildItem $server1\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server1 -PassThru

$fileList2 = Get-ChildItem $server2\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server2 -PassThru

# Unterschiedliche Dateien finden (basierend auf "Name" und "Length") und Objekte mit -PassThru
# weitergeben:
Compare-Object -ReferenceObject $fileList1 -DifferenceObject $fileList2 -Property Name, Length -PassThru |
  Sort-Object -Property Name |
  Select-Object -Property ComputerName, Name, Length, LastWriteTime |
  Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\29.5.ps1
************************************************************************
$server1 = '\\storage1'
$server2 = '\\powershellpc'

$fileList1 = Get-ChildItem $server1\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server1 -PassThru |
  Add-Member -MemberType ScriptProperty -Name Version -Value { $this.VersionInfo.ProductVersion } -PassThru

$fileList2 = Get-ChildItem $server2\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server2 -PassThru |
  Add-Member -MemberType ScriptProperty -Name Version -Value { $this.VersionInfo.ProductVersion } -PassThru

# Unterschiedliche Dateien finden (basierend auf "Name" und "Length") und Objekte mit -PassThru
# weitergeben:
Compare-Object -ReferenceObject $fileList1 -DifferenceObject $fileList2 -Property Name, Version -PassThru |
  Sort-Object -Property Name |
  Select-Object -Property ComputerName, Name, Version |
  Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\29.6.ps1
************************************************************************
PS> $os = Get-WmiObject -Class Win32_OperatingSystem
PS> $InstallDate = $os.InstallDate
PS> $LastBootDate = $os.LastBootUpTime

PS> $InstallDate
20120806185927.000000+120

PS> $LastBootDate
20121113065721.356498+060



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.1.ps1
************************************************************************
# dieser Ordner soll existieren:
$Path = 'c:\neuerordner'

# prüfen, ob Ordner schon vorhanden ist:
$existiert = Test-Path -Path $Path

# ausgehend davon Ordner anlegen, wenn er fehlt:
if (!$existiert)
{
    # Ergebnis von New-Item an $null zuweisen,
    # weil das Ergebnis nicht gebraucht wird
    $null = New-Item -Path $Path -ItemType Directory
    Write-Warning 'Neuer Ordner angelegt'
}
else
{
    Write-Warning "Ordner '$path' war bereits vorhanden."
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.10.ps1
************************************************************************
#requires -Version 1

# PowerShell Profil kopieren
$profil = "$home\Documents\WindowsPowerShell"
$ziel = "$home\Documents\SicherheitskopiePSProfil"

$existiert = Test-Path -Path $profil
if (!$existiert)
{
	Write-Warning "Das Profil $profil existiert nicht - nichts zu kopieren!"
	return
}

Copy-Item -Path $profil -Destination $ziel -Recurse

explorer $ziel



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.11.ps1
************************************************************************
#requires -Version 1

# PowerShell Profil kopieren
$profil = "$home\Documents\WindowsPowerShell"
$ziel = "$home\Documents\SicherheitskopiePSProfil"

$null = robocopy.exe $profil $Ziel /R:0 /S

explorer $ziel



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.12.ps1
************************************************************************
#requires -Version 1

# Pfadnamen definieren:
$desktop = "$home\Desktop"
$path = Join-Path -Path $desktop -ChildPath datei.txt

# Ergebnisse von Get-Process in Textdatei speichern:
Get-Process | Format-Table -AutoSize -Wrap | Out-File -FilePath $path -Width 120

# Ausgabedatei umbenennen
Rename-Item -Path $path -NewName prozesse.txt



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.13.ps1
************************************************************************
#requires -Version 3

# Zielordner muss existieren!
$zielordner = 'C:\Testbilder'
# Zielordner anlegen oder überschreiben, falls vorhanden
# ACHTUNG: Ein vorhandener Zielordner wird komplett gelöscht!
$null = New-Item -Path $zielordner -ItemType Directory -Force

# alle .log-Dateien im Windows-Ordner finden...
Get-ChildItem -Path $env:windir -Filter *.jpg -Recurse -ErrorAction SilentlyContinue -File |
  # ...und Dateien in Zielordner kopieren
  Copy-Item -Destination $zielordner

# Zielordner öffnen
explorer $zielordner



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.14.ps1
************************************************************************
#requires -Version 1


$zielordner = 'C:\Testbilder'
$index = 0

# alle Dateien im Testordner...
Get-ChildItem -Path $zielordner |
  # ...nach Größe aufsteigend sortieren...
  Sort-Object -Property Length |
  # ...danach mit laufender Nummer umbenennen:
  Rename-Item -NewName {
	  $datei = $_
	  $extension = $_.Extension
	  # Index um eins erhöhen
	  $script:index++
	  # neuen Dateinamen konstruieren 
	  'Picture{0:d3}{1}' -f $index, $extension
  }
  
  # Ordner öffnen
  explorer $zielordner



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.15.ps1
************************************************************************
#requires -Version 1

# RECENT Dateien löschen
Get-ChildItem -Path "$env:appdata\Microsoft\Windows\Recent" -Filter *.lnk | 
  Remove-Item 

# TEMP Ordner löschen
Get-ChildItem -Path $env:temp | Remove-Item  -Recurse -ErrorAction SilentlyContinue



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.16.ps1
************************************************************************
#requires -Version 1

$drive = Get-PSDrive -PSProvider FileSystem -Name C

$free = $drive.Free
$used = $drive.Used
$total = $free + $used
$percent = $used / $total

'Gesamt:   {0,10:n1} GB' -f ($total/1GB) 
'Belegt:   {0,10:n1} GB' -f ($used/1GB) 
'Frei:     {0,10:n1} GB' -f ($free/1GB) 
'Belegung:    {0,10:p}' -f $percent



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.17.ps1
************************************************************************
# die Größe dieses Ordners soll ermittelt werden
$Path = 'c:\windows'

# es sollen alle Dateien berücksichtigt werden
# (ersetzen Sie dies z.B. durch '*.log', um nur solche
# Dateien zu zählen)
$Filter = '*'

$TotalSize = Get-ChildItem -Path $Path -Filter $Filter -File -ErrorAction SilentlyContinue -Recurse -Force | Measure-Object -Property Length -Sum |  Select-Object -ExpandProperty Sum

"Die Gesamtgröße des Ordners $Path beträgt $TotalSize Bytes."

$TotalSizeMB = $TotalSize / 1MB

'Die Gesamtgröße des Ordners "{0}" beträgt {1:n1} MB.' -f $Path, $TotalSizeMB



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.18.ps1
************************************************************************
#requires -Version 1

# neue User-Umgebungsvariable anlegen
[Environment]::SetEnvironmentVariable('test', '123', 'User')

# Umgebungsvariable wieder löschen
[Environment]::SetEnvironmentVariable('test', $null, 'User')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.19.ps1
************************************************************************
#requires -Version 2

$Path32Bit = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
$Path64Bit = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'

Get-ItemProperty -Path $Path32Bit, $Path64Bit |
  Select-Object -Property DisplayName, DisplayVersion, UninstallString |
  Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.2.ps1
************************************************************************
# existiert die PowerShell-Profildatei bereits?
$existiert = Test-Path -Path $profile

# falls nicht, diese Datei anlegen...
if (!$existiert)
{
    $null = New-Item -Path $profile -ItemType File -Force
}

# ...danach im ISE-Editor öffnen
ise $profile



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.3.ps1
************************************************************************
# Pfad zum Desktop
$Path = "$HOME\Desktop"

# Datei mit den neuesten 20 kritischen System-Events erstellen
$FilePath = Join-Path -Path $Path -ChildPath 'FehlerEvents.txt'
Get-EventLog -LogName System -EntryType Error, Warning -Newest 20 | 
    Format-Table -AutoSize -Wrap | 
    Out-File -FilePath $FilePath -Width 120

notepad.exe $FilePath



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.4.ps1
************************************************************************
# Pfad zum Desktop
$Path = "$HOME\Desktop"

# unterschiedliche Ausgabe im Vergleich
$FilePath1 = Join-Path -Path $Path -ChildPath 'OutFile.txt'
$FilePath2 = Join-Path -Path $Path -ChildPath 'SetContent.txt'
$FilePath3 = Join-Path -Path $Path -ChildPath 'OutStringSetContent.txt'

$daten = Get-EventLog -LogName System -EntryType Error, Warning -Newest 20 

$daten | Out-File -FilePath $FilePath1
$daten | Set-Content -Path $FilePath2
$daten | Out-String | Set-Content -Path $FilePath3 -Encoding Unicode

notepad.exe $FilePath1
notepad.exe $FilePath2
notepad.exe $FilePath3



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.5.ps1
************************************************************************
$stichwort = Read-Host -Prompt 'Nach welchem Wort in Ihrem Skript suchen Sie'

Get-ChildItem -Path $home -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue |
  Select-String -Pattern $stichwort -List |
  Select-Object -Property LineNumber, Line, FileName, Path |
  Out-GridView -Title 'Datei aussuchen' -OutputMode Multiple |
  Select-Object -ExpandProperty Path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.6.ps1
************************************************************************
# nach einem Stichwort fragen
$stichwort = Read-Host -Prompt 'Nach welchem Wort in Ihrem Skript suchen Sie'
Write-Host 'Suche läuft...' -NoNewline

# Skripts mit diesem Stichwort finden
$resultat = Get-ChildItem -Path $home -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue |
  Select-String -Pattern $stichwort -List |
  Select-Object -Property LineNumber, Line, FileName, Path 

# Anzahl der Ergebnisse melden
$anzahl = $resultat.Count
Write-Host "$anzahl Ergebnisse."
  
# Nur wenn Skripts gefunden wurden, im GridView anzeigen...
if ($anzahl -gt 0)
{
  $resultat |
    Out-GridView -Title 'Datei aussuchen' -OutputMode Multiple |
    Select-Object -ExpandProperty Path |
    Foreach-Object { 
      # ...und jedes gefundene Skript mit der ISE öffnen:
      ise $_ 
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.7.ps1
************************************************************************
#requires -Version 3
# Datei anlegen:
$desktop = "$home\Desktop"
$original = Join-Path -Path $desktop -ChildPath 'original.txt'
$kopie = Join-Path -Path $desktop -ChildPath 'kopie.txt'

"Hallo Welt" | Set-Content -Path $original


# Sicherheitskopie erstellen:
Copy-Item -Path $original -Destination $kopie

# die zwei zuletzt geänderten Dateien auf dem Desktop auflisten:
Get-ChildItem -Path $desktop -File | 
  Sort-Object -Property LastWriteTime -Descending | 
  Select-Object -First 2



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.8.ps1
************************************************************************
#requires -Version 3

# Zielordner muss existieren!
$zielordner = 'C:\LogFiles'
# Zielordner anlegen oder überschreiben, falls vorhanden
# ACHTUNG: Ein vorhandener Zielordner wird komplett gelöscht!
$null = New-Item -Path $zielordner -ItemType Directory -Force

# alle .log-Dateien im Windows-Ordner finden...
Get-ChildItem -Path $env:windir -Filter *.log -Recurse -ErrorAction Ignore -File |
  # ...und Dateien in Zielordner kopieren
  Copy-Item -Destination $zielordner

# Zielordner öffnen
explorer $zielordner



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\3.9.ps1
************************************************************************
#requires -Version 1
$desktop = "$home\Desktop"
Get-ChildItem -Path $desktop -Filter *.ps1 |
  Copy-Item -Destination { 
	  $datei = $_
	  $name = $datei.Name
	  $newname = $name + '.bak'
	  Join-Path -Path $desktop -ChildPath $newname
	}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\30.1.ps1
************************************************************************
PS> $metadata = New-Object System.Management.Automation.CommandMetaData XE "System.Management.Automation.CommandMetaData"  (Get-Command Stop-Process)
PS> [System.Management.Automation.ProxyCommand] XE "[System.Management.Automation.ProxyCommand]" ::Create($metadata) | clip



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\30.2.ps1
************************************************************************
function Out-LogFile
{
    param
    (
        [Parameter(Mandatory=$true)]
        $Path,

        [Parameter(ValueFromPipeline=$true)]
        $InputObject
    )

    end
    {
        $data = @($Input)
        $data | Out-File -FilePath $Path -Append
        $data
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\30.3.ps1
************************************************************************
function Out-LogFile
{
    param
    (
        [Parameter(Mandatory=$true)]
        $Path,

        [Parameter(ValueFromPipeline=$true)]
        $InputObject
    )

    process
    {
        $InputObject | Out-File -FilePath $Path -Append
        $InputObject
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\30.4.ps1
************************************************************************
function Out-LogFile
{
    param
    (
        [Parameter(Mandatory=$true)]
        $Path,

        [Parameter(ValueFromPipeline=$true)]
        $InputObject
    )

    begin
    {
        # Zugriff auf das Cmdlet, an das die Daten geliefert werden sollen:
        $Cmdlet = 'Out-File'
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand($cmdlet, 'Cmdlet')

        # Befehlszeile festlegen. $wrappedCmd steht für das Cmdlet "Out-File":
        $scriptCmd = {&  $wrappedCmd -FilePath $Path -Append }

        # Zugriff auf diesen Befehl erhalten:
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)

        # begin-Block von "Out-File" aufrufen:
        $steppablePipeline.Begin($PSCmdlet)
}

    process
    {
        # process-Bock von "Out-File" aufrufen:
        $steppablePipeline.Process($_)

        # HIER DIE ERWEITERUNG:
        # AUSSERDEM das einlaufende Element in die Konsole zurückgeben:
        $_
    }

    end
    {
        # end-Block von "Out-File" aufrufen:
        $steppablePipeline.End()
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\30.5.ps1
************************************************************************
function New-ProxyFunction
{
  param
  (
    [Parameter(Mandatory=$true)]
    $CmdletName
  )

  $cmd = Get-Command $CmdletName -CommandType Cmdlet
  $meta = New-Object System.Management.Automation.CommandMetadata($cmd)
  $logic = [System.Management.Automation.ProxyCommand]::Create($meta)

  $FunctionName = '{0}_Ex' -f $CmdletName

  $code = "
function $FunctionName
{
$logic
}"

  $NewFile = $psISE.CurrentPowerShellTab.files.Add()
  $NewFile.Editor.Text = $code
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\30.6.ps1
************************************************************************
function Get-ChildItem_Ex
{
<#
.ForwardHelpTargetName Get-ChildItem
.ForwardHelpCategory Cmdlet
#>  [CmdletBinding(DefaultParameterSetName='Items', SupportsTransactions=$true,
    HelpUri='http://go.microsoft.com/fwlink/?LinkID=113308')]
    [OutputType('System.IO.FileInfo','System.IO.DirectoryInfo')]

  param
  (
    [Parameter(ParameterSetName='Items', Position=0, ValueFromPipeline=$true,
      ValueFromPipelineByPropertyName=$true)]
    [string[]]
    $Path,

    [Parameter(ParameterSetName='LiteralItems', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    $LiteralPath,

    [Parameter(Position=1)]
    [string]
    $Filter,

    [string[]]
    $Include,

    [string[]]
    $Exclude,

    [Alias('s')]
    [switch]
    $Recurse,

    [switch]
    $Force,

    [switch]
    $Name,

    [datetime]
    $Before,

    [datetime]
    $After,

    [int64]
    $MaxFileSize,

    [int64]
    $MinFileSize,

    [int]
    $OlderThan,

    [int]
    $NewerThan,

    [string]
    $Sort
  )

  begin
  {
    try
    {
      # Initialize pre- and post-Pipeline command store:
      [string[]]$PrePipeline = ''
      [string[]]$PostPipeline = ''
      [string[]]$Pipeline = '& $wrappedCmd @PSBoundParameters'

      if ($PSBoundParameters.ContainsKey('Before'))
      {
        $PostPipeline += { Where-Object { $_.LastWriteTime -lt $Before } }
      }

      if ($PSBoundParameters.ContainsKey('After'))
      {
        $PostPipeline += { Where-Object { $_.LastWriteTime -gt $After } }
      }

      if ($PSBoundParameters.ContainsKey('MaxFileSize'))
      {
        $PostPipeline += { Where-Object { $_.LastWriteTime -le $MaxFileSize -and -not $_.PSIsContainer }}
      }

      if ($PSBoundParameters.ContainsKey('MinFileSize'))
      {
        $PostPipeline += { Where-Object { $_.Length -ge $MinFileSize -and -not $_.PSIsContainer}}
      }

      if ($PSBoundParameters.ContainsKey('OlderThan'))
      {
        $PostPipeline += {Where-Object {((Get-Date) - (New-TimeSpan -Days $OlderThan)) -gt $_.LastWriteTime}}
      }

      if ($PSBoundParameters.ContainsKey('NewerThan'))
      {
        $PostPipeline += {Where-Object {((Get-Date) - (New-TimeSpan -Days $NewerThan)) -lt $_.LastWriteTime}}
      }

      if ($PSBoundParameters.ContainsKey('Sort'))
      {
        $PostPipeline += { Sort-Object -Property $Sort }
      }

      # Remove additional parameters before forwarding them to the original cmdlet:
      $null = $PSBoundParameters.Remove('FileOnly')
      $null = $PSBoundParameters.Remove('FolderOnly')
      $null = $PSBoundParameters.Remove('Before')
      $null = $PSBoundParameters.Remove('After')
      $null = $PSBoundParameters.Remove('MaxFileSize')
      $null = $PSBoundParameters.Remove('MinFileSize')
      $null = $PSBoundParameters.Remove('OlderThan')
      $null = $PSBoundParameters.Remove('NewerThan')
      $null = $PSBoundParameters.Remove('Sort')

      $outBuffer = $null

      if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
      {
        $PSBoundParameters['OutBuffer'] = 1
      }

      $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Get-ChildItem', 'Cmdlet')

      # add newly added pipeline components to the pipeline that gets executed:
      $scriptCmd = [scriptblock]::Create( (($PrePipeline + $Pipeline + $PostPipeline) |
        Where-Object { $_ }) -join ' | ')

      $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
      $steppablePipeline.Begin($PSCmdlet)
    } catch {
      throw
    }
  }

  process
  {
    try
    {
      $steppablePipeline.Process($_)
    } catch {
      throw
    }
  }

  end
  {
    try
    {
      $steppablePipeline.End()
    } catch {
      throw
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.1.ps1
************************************************************************
Add-Type -AssemblyName PresentationFramework

$window = New-Object Windows.Window
$window.Title='Send Message'
$window.SizeToContent='WidthAndHeight'
$window.WindowStyle='ToolWindow'
$window.ResizeMode='NoResize'

$stackpanel1 = New-Object -TypeName Windows.Controls.StackPanel
$stackpanel1.Orientation = 'Vertical'
$stackpanel1.Margin = 10

$window.Content = $stackpanel1

$stackpanel2 = New-Object -TypeName Windows.Controls.StackPanel
$stackpanel2.Orientation = 'Horizontal'
$stackpanel2.Margin = 5

$stackpanel3 = New-Object -TypeName Windows.Controls.StackPanel
$stackpanel3.Orientation = 'Horizontal'
$stackpanel3.Margin = 5

$stackpanel4 = New-Object -TypeName Windows.Controls.StackPanel
$stackpanel4.Orientation = 'Horizontal'
$stackpanel4.Margin = 5
$stackpanel4.HorizontalAlignment = 'Right'

$null = $stackpanel1.Children.Add($stackpanel2)
$null = $stackpanel1.Children.Add($stackpanel3)
$null = $stackpanel1.Children.Add($stackpanel4)

$label1 = New-Object -TypeName Windows.Controls.Label
$label1.Width = 100
$label1.Content = 'Name'

$textBox1 = New-Object -TypeName Windows.Controls.TextBox
$textBox1.Width = 300
$textBox1.Name = 'txtName'

$null = $stackpanel2.Children.Add($label1)
$null = $stackpanel2.Children.Add($textBox1)

$label2 = New-Object -TypeName Windows.Controls.Label
$label2.Width = 100
$label2.Content = 'Email'

$textBox2 = New-Object -TypeName Windows.Controls.TextBox
$textBox2.Width = 300
$textBox2.Name = 'txtEmail'

$null = $stackpanel3.Children.Add($label2)
$null = $stackpanel3.Children.Add($textBox2)

$button1 = New-Object -TypeName Windows.Controls.Button
$button1.Width = 80
$button1.Content = 'Send'
$button1.Margin = 5

$button2 = New-Object -TypeName Windows.Controls.Button
$button2.Width = 80
$button2.Content = 'Cancel'
$button2.Margin = 5

$null = $stackpanel4.Children.Add($button1)
$null = $stackpanel4.Children.Add($button2)

$label = New-Object Windows.Controls.Label

$window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.10.ps1
************************************************************************
Add-Type -AssemblyName PresentationFramework

$dialog = New-Object -TypeName Microsoft.Win32.OpenFileDialog
$dialog.Title = 'Datei aussuchen'
$dialog.Filter = 'Alles|*.*|PowerShell|*.ps1'
$dialog.InitialDirectory = "$home\Documents"
$result = $dialog.ShowDialog()

if ($result -eq $true)
{
  $dialog.FileName
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.11.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Title="Dienst stoppen"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

    <StackPanel Orientation="Vertical" Margin="10">

        <StackPanel Orientation="Vertical" Margin="5">
            <ComboBox Name="combo1" DisplayMemberPath="DisplayName" Width="300"/>
        </StackPanel>

        
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
            <Button x:Name="butStop" Width="80" Margin="5" Content="Stop"/>
            <Button x:Name="butCancel" Width="80" Margin="5" Content="Cancel"/>
        </StackPanel>

    </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Elemente ansprechen, mit denen etwas passieren soll:
$buttonStop = $window.FindName('butStop')
$buttonCancel = $window.FindName('butCancel')
$comboBox1 = $window.FindName('combo1')

# Click-Ereignisse der Schaltflächen mit Aktion versehen:
$code1 = { $window.DialogResult = $true }
$code2 = { $window.DialogResult = $false }

$buttonStop.add_Click($code1)
$buttonCancel.add_Click($code2)

# Dienste-Liste füllen
$liste = Get-Service | Where-Object Status -eq Running
$comboBox1.ItemsSource = $liste
$comboBox1.SelectedIndex = 1

$DialogResult = $window.ShowDialog()

if ($DialogResult -eq $true)
{
  $comboBox1.SelectedItem | Stop-Service -WhatIf
}
else
{
  Write-Warning 'Abbruch durch den User.'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.12.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Title="Dienst stoppen"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

    <StackPanel Orientation="Vertical" Margin="10">

        <StackPanel Orientation="Vertical" Margin="5">
            <ComboBox Name="combo1" DisplayMemberPath="DisplayName" Width="300"/>
        </StackPanel>

        
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
            <Button x:Name="butStop" Width="80" Margin="5" Content="Stop"/>
            <Button x:Name="butCancel" Width="80" Margin="5" Content="Done"/>
        </StackPanel>

    </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Elemente ansprechen, mit denen etwas passieren soll:
$buttonStop = $window.FindName('butStop')
$buttonCancel = $window.FindName('butCancel')
$comboBox1 = $window.FindName('combo1')

# Click-Ereignisse der Schaltflächen mit Aktion versehen:
$code1 = { 
  $comboBox1.SelectedItem | Stop-Service -WhatIf
  RefreshComboBox
}
$code2 = { $window.Close() }

$buttonStop.add_Click($code1)
$buttonCancel.add_Click($code2)

# Dienste-Liste füllen
function RefreshComboBox
{
  $liste = Get-Service | Where-Object Status -eq Running
  $comboBox1.ItemsSource = $liste
  $comboBox1.SelectedIndex = 1
}
RefreshComboBox
$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.13.ps1
************************************************************************
Add-Type -AssemblyName PresentationFramework

$xaml = @"
<Window
 xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'
 Title='Process Viewer' 
 MinWidth='300'
 MinHeight='300' 
 Height = '600'>

<Grid Margin="5">
  <Grid.RowDefinitions>
      <RowDefinition Height="*"></RowDefinition>
      <RowDefinition Height="Auto"></RowDefinition>
  </Grid.RowDefinitions>

  <ListView Name="View1">
    <ListView.View>
      <GridView>
        <GridViewColumn Width="140" Header="Name" DisplayMemberBinding="{Binding Name}"/>
        <GridViewColumn Width="350" Header="Fenstertitel" DisplayMemberBinding="{Binding MainWindowTitle}"/>
        <GridViewColumn Width="140" Header="Beschreibung" DisplayMemberBinding="{Binding Description}"/>
        <GridViewColumn Width="100" Header="Hersteller" DisplayMemberBinding="{Binding Company}"/>
      </GridView>
    </ListView.View>
  </ListView>
  <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Bottom">
    <Button Name="butStop" Width="80" Height="30" Margin="5">Stop</Button>
    <Button Name="butCancel" Width="80" Height="30" Margin="5">Cancel</Button>
  </StackPanel>
</Grid>

</Window>
"@

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader] $xaml)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Liste füllen
$view = $window.FindName('View1')

$view.ItemsSource = @(Get-Process | Where-Object { $_.MainWindowTitle }) | 
# MINDESTENS die Properties auswählen, die angezeigt werden sollen
# UND die später von nachgeschalteten Cmdlets (z.B. Stop-Process)
# benötigt werden:
Select-Object -Property Name, MainWindowTitle, Description, Company, Id

$buttonStop = $window.FindName('butStop')
$buttonCancel = $window.FindName('butCancel')
$code1 = { $window.DialogResult = $true }
$code2 = { $window.DialogResult = $false }

$buttonStop.add_Click($code1)
$buttonCancel.add_Click($code2)


# Fenster anzeigen
if ($window.ShowDialog())
{
  # Ergebnisse auswerten:
  $view.SelectedItems | Stop-Process -WhatIf
}
else
{
  Write-Warning 'Abbruch...'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.14.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  Title="Send Message"
  Width="300"
  MinWidth ="200"
  SizeToContent="Height"
  WindowStyle="ToolWindow">
    <Grid Margin="5">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"></ColumnDefinition>
            <ColumnDefinition Width="*"></ColumnDefinition>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"></RowDefinition>
            <RowDefinition Height="Auto"></RowDefinition>
            <RowDefinition Height="*"></RowDefinition>
        </Grid.RowDefinitions>
  
      <Label Grid.Column="0">Name</Label>
      <TextBox Grid.Column="1"  Name="txtName" Margin="5"></TextBox>
    
      <Label Grid.Column="0" Grid.Row="1">Email</Label>
      <TextBox  Grid.Column="1" Grid.Row="1" Name="txtEmail" Margin="5"></TextBox>
    
    <StackPanel Grid.ColumnSpan="2" Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Bottom">
      <Button Name="butSend" Width="80" Height="30" Margin="5">Send</Button>
      <Button Name="butCancel" Width="80" Height="30" Margin="5">Cancel</Button>
    </StackPanel>
    </Grid>
</Window>
'@



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.15.ps1
************************************************************************
$window.txtEmail.add_TextChanged(
  {
    [System.Object]$sender = $args[0]
    [System.Windows.Controls.TextChangedEventArgs]$e = $args[1]   
    
  }
)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.16.ps1
************************************************************************
function Convert-XAMLtoWindow
{
  param
  (
    [Parameter(Mandatory=$true)]
    [string]
    $XAML,
    
    [string[]]
    $NamedElements,
    
    [switch]
    $PassThru
  )
  
  Add-Type -AssemblyName PresentationFramework
  
  $reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
  $result = [System.Windows.Markup.XAMLReader]::Load($reader)
  foreach($Name in $NamedElements)
  {
    $result | Add-Member NoteProperty -Name $Name -Value $result.FindName($Name) -Force
  }
  
  if ($PassThru)
  {
    $result
  }
  else
  {
    $result.ShowDialog()
  }
}

$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  Title="Send Message"
  Width="300"
  MinWidth ="200"
  SizeToContent="Height"
  WindowStyle="ToolWindow">
    <Grid Margin="5">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"></ColumnDefinition>
            <ColumnDefinition Width="*"></ColumnDefinition>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"></RowDefinition>
            <RowDefinition Height="Auto"></RowDefinition>
            <RowDefinition Height="*"></RowDefinition>
        </Grid.RowDefinitions>
  
      <Label Grid.Column="0">Name</Label>
      <TextBox Grid.Column="1"  Name="txtName" Margin="5"></TextBox>
    
      <Label Grid.Column="0" Grid.Row="1">Email</Label>
      <TextBox  Grid.Column="1" Grid.Row="1" Name="txtEmail" Margin="5"></TextBox>
    
    <StackPanel Grid.ColumnSpan="2" Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Bottom">
      <Button Name="butSend" Width="80" Height="30" Margin="5">Send</Button>
      <Button Name="butCancel" Width="80" Height="30" Margin="5">Cancel</Button>
    </StackPanel>
    </Grid>
</Window>
'@

$window = Convert-XAMLtoWindow -XAML $xaml -NamedElements 'txtName', 'txtEmail', 'butSend', 'butCancel' -PassThru

# Send-Schaltfläche abschalten
$window.butSend.IsEnabled = $false

# wenn eine gültige Email-Adresse eingegeben wird,
# Send-Schaltfläche aktivieren
$window.txtEmail.add_TextChanged(
  {
    [System.Object]$sender = $args[0]
    [System.Windows.Controls.TextChangedEventArgs]$e = $args[1]   
    $text = $sender.Text
    $window.butSend.IsEnabled = $text -like '*?.?*@*?.?*'
  }
)

$window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.17.ps1
************************************************************************
$textbox | Get-Member -MemberType Event | Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.18.ps1
************************************************************************
Add-Type -AssemblyName PresentationFramework

$xaml = @"
<Window
 xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'
 SizeToContent='WidthAndHeight'
 WindowStartupLocation = 'CenterScreen'
 ResizeMode = 'NoResize'
 WindowStyle = 'None'
 Topmost='True' >

  <Label FontSize="100" FontFamily='Stencil' Background='Red' Foreground='White' BorderThickness='2' BorderBrush='Yellow'>
    Feueralarm!
  </Label>
</Window>
"@

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader] $xaml)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

$null = $window.Show()
Start-Sleep -Seconds 5
$window.Close()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.19.ps1
************************************************************************
function Lock-Screen
{
  param
  (
    $Title = 'Access temporarily unavailable',
    $Delay = 10
  )
  
  Add-Type -AssemblyName PresentationFramework
  
  $window = New-Object Windows.Window
  $label = New-Object Windows.Controls.Label
  $label.Content = $Title
  $label.FontSize = 60
  $label.FontFamily = 'Tahoma'
  $label.Background = 'Transparent'
  $label.Foreground = 'Red'
  $label.HorizontalAlignment = 'Center'
  $label.VerticalAlignment = 'Center'
  $Window.AllowsTransparency = $True
  $Window.Opacity = 0.6
  $window.WindowStyle = 'None'
  $window.Content = $label
  $window.Left = $window.Top = 0
  $window.WindowState = 'Maximized'
  $window.Topmost = $true
  $null = $window.Show()
  Start-Sleep -Seconds $Delay
  $window.Close()
}

Lock-Screen -Title 'Zugang vorübergehend verboten!' -Delay 4



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.2.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  Title="Send Message"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

  <StackPanel Orientation="Vertical" Margin="10">

    <StackPanel Orientation="Horizontal" Margin="5">
      <Label Width="100">Name</Label>
      <TextBox  Name="txtName" Width="300"></TextBox>
    </StackPanel>

    <StackPanel Orientation="Horizontal" Margin="5">
      <Label Width="100">Email</Label>
      <TextBox  Name="txtEmail" Width="300"></TextBox>
    </StackPanel>

    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
      <Button Name="butSend" Width="80" Margin="5">Send</Button>
      <Button Name="butCancel" Width="80" Margin="5">Cancel</Button>
    </StackPanel>
  
  </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

$window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.20.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Title="Fortschrittsanzeige"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

    <StackPanel Orientation="Vertical" Margin="10">

        <StackPanel Orientation="Vertical" Margin="5">
            <ProgressBar Name="progress1" Minimum="0" Maximum="100" Value="0" Height="20"></ProgressBar>
        </StackPanel>

        
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
            <Button x:Name="butStart" Width="80" Margin="5" Content="Start"/>
            <Button x:Name="butOk" Width="80" Margin="5" Content="OK"/>
        </StackPanel>

    </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Elemente ansprechen, mit denen etwas passieren soll:
$buttonStart = $window.FindName('butStart')
$buttonOk = $window.FindName('butOk')
$progressBar = $window.FindName('progress1')

# Click-Ereignisse der Schaltflächen mit Aktion versehen:
$code1 = 
{ 
  # Schaltfläche ausgrauen:
  $buttonStart.IsEnabled = $false

  # 140 Schleifendurchläufe:
  $anzahl = 140
  $i = 0
  1..$anzahl | ForEach-Object {
    $i++
    # aktuellen Prozentsatz der Fertigstellung berechnen:
    $prozent = $i * 100 / $anzahl

    # Fortschrittsanzeige aktualisieren:
    $progressBar.Value = $prozent

    # etwas warten. Hier könnten später echte Aufgaben stehen,
    # die etwas Zeit kosten:
    Start-Sleep -Milliseconds 300
  }

  # Schaltfläche wieder aktivieren:
  $buttonStart.IsEnabled = $true
}
$code2 = { $window.DialogResult = $true }

$buttonStart.add_Click($code1)
$buttonOk.add_Click($code2)

$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.21.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Title="Fortschrittsanzeige"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

    <StackPanel Orientation="Vertical" Margin="10">

        <StackPanel Orientation="Vertical" Margin="5">
            <ProgressBar Name="progress1" Minimum="0" Maximum="100" Value="0" Height="20"></ProgressBar>
        </StackPanel>

        
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
            <Button x:Name="butStart" Width="80" Margin="5" Content="Start"/>
            <Button x:Name="butOk" Width="80" Margin="5" Content="OK"/>
        </StackPanel>

    </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Elemente ansprechen, mit denen etwas passieren soll:
$buttonStart = $window.FindName('butStart')
$buttonOk = $window.FindName('butOk')
$progressBar = $window.FindName('progress1')

# Click-Ereignisse der Schaltflächen mit Aktion versehen:
$code1 = 
{ 
  # Schaltfläche ausgrauen:
  $buttonStart.IsEnabled = $false

  # 140 Schleifendurchläufe:
  $anzahl = 140
  $i = 0
  1..$anzahl | ForEach-Object {
    $i++
    # aktuellen Prozentsatz der Fertigstellung berechnen:
    $prozent = $i * 100 / $anzahl

    # Fortschrittsanzeige aktualisieren:
    $progressBar.Value = $prozent

    # WPF AKTUALISIEREN:
    $window.Dispatcher.Invoke([System.Action]{}, 'Background')

    # etwas warten. Hier könnten später echte Aufgaben stehen,
    # die etwas Zeit kosten:
    Start-Sleep -Milliseconds 300
  }

  # Schaltfläche wieder aktivieren:
  $buttonStart.IsEnabled = $true
}
$code2 = { $window.DialogResult = $true }

$buttonStart.add_Click($code1)
$buttonOk.add_Click($code2)

$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.22.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Title="Fortschrittsanzeige"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

    <StackPanel Orientation="Vertical" Margin="10">

        <StackPanel Orientation="Vertical" Margin="5">
            <ProgressBar Name="progress1" Minimum="0" Maximum="100" Value="0" Height="20"></ProgressBar>
        </StackPanel>

        
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
            <Button x:Name="butStart" Width="80" Margin="5" Content="Start"/>
            <Button x:Name="butOk" Width="80" Margin="5" Content="OK"/>
        </StackPanel>

    </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Elemente ansprechen, mit denen etwas passieren soll:
$buttonStart = $window.FindName('butStart')
$buttonOk = $window.FindName('butOk')
$progressBar = $window.FindName('progress1')

$script:isActive =$false

# Click-Ereignisse der Schaltflächen mit Aktion versehen:
$code1 = 
{ 
  $script:isActive = -not $script:isActive

  if ($script:isActive)
  {
    # Schaltfläche ändern:
    $buttonStart.Content = 'Stop'

    # 140 Schleifendurchläufe:
    $anzahl = 140
    $i = 0
    do
    {
      1..$anzahl | ForEach-Object {
        $i++
        # aktuellen Prozentsatz der Fertigstellung berechnen:
        $prozent = $i * 100 / $anzahl

        # Fortschrittsanzeige aktualisieren:
        $progressBar.Value = $prozent

        # WPF AKTUALISIEREN:
        $window.Dispatcher.Invoke([System.Action]{}, 'Background')
      
        # falls abgebrochen wurde, Schleife beenden
        if (-not $script:isActive) { break }

        # etwas warten. Hier könnten später echte Aufgaben stehen,
        # die etwas Zeit kosten:
        Start-Sleep -Milliseconds 300
      }
    } while ($false)
  }
  else
  {
    $progressBar.Value = 0
  }

  # Schaltfläche wiederherstellen:
  $buttonStart.Content = 'Start'
}
$code2 = 
{ 
  $script:isActive = $false
  $window.DialogResult = $true 
}

$buttonStart.add_Click($code1)
$buttonOk.add_Click($code2)

$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.23.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  Title="PowerShell Cockpit"
  Width="300"
  MinWidth ="200"
  SizeToContent="Height"
  WindowStyle="ToolWindow">
    <Grid Margin="5">
      <Grid.ColumnDefinitions>
          <ColumnDefinition Width="50*"></ColumnDefinition>
          <ColumnDefinition Width="50*"></ColumnDefinition>
      </Grid.ColumnDefinitions>
      <Grid.RowDefinitions>
          <RowDefinition Height="Auto"></RowDefinition>
          <RowDefinition Height="Auto"></RowDefinition>
          <RowDefinition Height="*"></RowDefinition>
      </Grid.RowDefinitions>
  
      <Button Name="Aufgabe1" Width="80" Height="30" Margin="5" Grid.Column="0" Grid.Row="0">Aufgabe 1</Button>
      <Button Name="Aufgabe2" Width="80" Height="30" Margin="5" Grid.Column="1" Grid.Row="0">Aufgabe 2</Button>
      <Button Name="Aufgabe3" Width="80" Height="30" Margin="5" Grid.Column="0" Grid.Row="1">Aufgabe 3</Button>
      <Button Name="Aufgabe4" Width="80" Height="30" Margin="5" Grid.Column="1" Grid.Row="1">Aufgabe 4</Button>
      <Button Name="Aufgabe5" Width="80" Height="30" Margin="5" Grid.Column="0" Grid.Row="2">Aufgabe 5</Button>
      <Button Name="Aufgabe6" Width="80" Height="30" Margin="5" Grid.Column="1" Grid.Row="2">Aufgabe 6</Button>

    
    </Grid>
</Window>
'@

Add-Type -AssemblyName PresentationFramework
  
$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Aufgaben definieren
$code1 = { [Console]::Beep() }
$code2 = { Write-Host 'Du hast mich angeklickt!' }
$code3 = { Get-Service }
$code4 = { Get-Service | Out-Host }
$code5 = { Write-Warning 'Ich schlafe 5 Sekunden!'
           Start-Sleep -Seconds 5}
$code6 = { $antwort = [Windows.MessageBox]::Show('Wollen Sie das?', 'Mein Dialog', 'YesNo') }

# auf Schaltflächen zugreifen
$aufgabe1 = $window.FindName('Aufgabe1')
$aufgabe2 = $window.FindName('Aufgabe2')
$aufgabe3 = $window.FindName('Aufgabe3')
$aufgabe4 = $window.FindName('Aufgabe4')
$aufgabe5 = $window.FindName('Aufgabe5')
$aufgabe6 = $window.FindName('Aufgabe6')

# Code für das Click-Ereignis zuweisen
$aufgabe1.add_Click($code1)
$aufgabe2.add_Click($code2)
$aufgabe3.add_Click($code3)
$aufgabe4.add_Click($code4)
$aufgabe5.add_Click($code5)
$aufgabe6.add_Click($code6)

$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.24.ps1
************************************************************************
function Start-InNewThread
{
  param
  (
    [ScriptBlock]$Code,
    
    [Hashtable]$Parameters = @{}
  )
  
  $powershell = [PowerShell]::Create()
  $action = {
   
    $status = $event.SourceEventArgs.InvocationStateInfo.State
    
    if ($status -eq 'Completed')
    {
      try
      {
        $powershell = $event.Sender
        $powershell.Runspace.Close()
        $powershell.Dispose()
        Unregister-Event -SourceIdentifier $event.SourceIdentifier 
      }
      catch
      {
        Write-Warning "$_"
      }
    }
  }
  
  $null = Register-ObjectEvent -InputObject $powershell -Action $action -EventName InvocationStateChanged 
  $null = $powershell.AddScript($Code)
  
  foreach($key in $Parameters.Keys)
  {
    $null = $powershell.AddParameter($key, $Parameters.$key)
  }
 
  $handle = $powershell.BeginInvoke()
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.25.ps1
************************************************************************
$parameter = @{
  Dauer = 3000
  Frequenz = 500
}

Start-InNewThread -Code { param($Dauer, $Frequenz) [Console]::Beep($Frequenz, $Dauer) } -Parameters $parameter



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.26.ps1
************************************************************************
function Start-InNewThread
{
  param
  (
    [ScriptBlock]$Code,
    
    [Hashtable]$Parameters = @{}
  )
  
  $powershell = [PowerShell]::Create()
  $action = {
   
    $status = $event.SourceEventArgs.InvocationStateInfo.State
    
    if ($status -eq 'Completed')
    {
      try
      {
        $powershell = $event.Sender
        $powershell.Runspace.Close()
        $powershell.Dispose()
        Unregister-Event -SourceIdentifier $event.SourceIdentifier 
      }
      catch
      {
        Write-Warning "$_"
      }
    }
  }
  
  $null = Register-ObjectEvent -InputObject $powershell -Action $action -EventName InvocationStateChanged 
  $null = $powershell.AddScript($Code)
  
  foreach($key in $Parameters.Keys)
  {
    $null = $powershell.AddParameter($key, $Parameters.$key)
  }
 
  $handle = $powershell.BeginInvoke()
}


$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  Title="PowerShell Cockpit"
  Width="300"
  MinWidth ="200"
  SizeToContent="Height"
  WindowStyle="ToolWindow">
    <Grid Margin="5">
      <Grid.ColumnDefinitions>
          <ColumnDefinition Width="50*"></ColumnDefinition>
          <ColumnDefinition Width="50*"></ColumnDefinition>
      </Grid.ColumnDefinitions>
      <Grid.RowDefinitions>
          <RowDefinition Height="Auto"></RowDefinition>
          <RowDefinition Height="Auto"></RowDefinition>
          <RowDefinition Height="*"></RowDefinition>
      </Grid.RowDefinitions>
  
      <Button Name="Aufgabe1" Width="80" Height="30" Margin="5" Grid.Column="0" Grid.Row="0">Aufgabe 1</Button>
      <Button Name="Aufgabe2" Width="80" Height="30" Margin="5" Grid.Column="1" Grid.Row="0">Aufgabe 2</Button>
      <Button Name="Aufgabe3" Width="80" Height="30" Margin="5" Grid.Column="0" Grid.Row="1">Aufgabe 3</Button>
      <Button Name="Aufgabe4" Width="80" Height="30" Margin="5" Grid.Column="1" Grid.Row="1">Aufgabe 4</Button>
      <Button Name="Aufgabe5" Width="80" Height="30" Margin="5" Grid.Column="0" Grid.Row="2">Aufgabe 5</Button>
      <Button Name="Aufgabe6" Width="80" Height="30" Margin="5" Grid.Column="1" Grid.Row="2">Aufgabe 6</Button>

    
    </Grid>
</Window>
'@

Add-Type -AssemblyName PresentationFramework
  
$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Aufgaben definieren
$code1 = { [Console]::Beep(1000,1000) }
$code2 = { param($UI)
           $UI.WriteLine('Du hast mich angeklickt!') }
$code3 = { Get-Service }
$code4 = { param($UI)
           $UI.WriteLine((Get-Service | Out-String)) }
$code5 = { param($UI)
           $UI.WriteWarningLine('Ich schlafe 5 Sekunden!')
           Start-Sleep -Seconds 5}
$code6 = { $antwort = [Windows.MessageBox]::Show('Wollen Sie das?', 'Mein Dialog', 'YesNo') }

# auf Schaltflächen zugreifen
$aufgabe1 = $window.FindName('Aufgabe1')
$aufgabe2 = $window.FindName('Aufgabe2')
$aufgabe3 = $window.FindName('Aufgabe3')
$aufgabe4 = $window.FindName('Aufgabe4')
$aufgabe5 = $window.FindName('Aufgabe5')
$aufgabe6 = $window.FindName('Aufgabe6')

# Code für das Click-Ereignis zuweisen
$aufgabe1.add_Click({ Start-InNewThread -Code $code1 })
$aufgabe2.add_Click({ Start-InNewThread -Code $code2 -Parameter @{UI=$Host.UI} })
$aufgabe3.add_Click({ Start-InNewThread -Code $code3 })
$aufgabe4.add_Click({ Start-InNewThread -Code $code4 -Parameter @{UI=$Host.UI} })
$aufgabe5.add_Click({ Start-InNewThread -Code $code5 -Parameter @{UI=$Host.UI} })
$aufgabe6.add_Click({ Start-InNewThread -Code $code6 })

$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.27.ps1
************************************************************************
Add-Type -AssemblyName PresentationFramework

$xaml = @"
<Window
 xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'
 Title='Process Viewer' 
 MinWidth='300'
 Width='600'
 MinHeight='300' 
 Height = '300'>

<Grid Margin="5">
  <Grid.RowDefinitions>
      <RowDefinition Height="*"></RowDefinition>
      <RowDefinition Height="Auto"></RowDefinition>
  </Grid.RowDefinitions>

  <ListView Name="View1">
    <ListView.View>
      <GridView>
        <GridViewColumn Width="100" Header="KB" DisplayMemberBinding="{Binding HotfixID}"/>
        <GridViewColumn Width="150" Header="Typ" DisplayMemberBinding="{Binding Description}"/>
        <GridViewColumn Width="150" Header="Datum" DisplayMemberBinding="{Binding InstalledOn}"/>
        <GridViewColumn Width="150" Header="Verantwortlich" DisplayMemberBinding="{Binding InstalledBy}"/>
      </GridView>
    </ListView.View>
  </ListView>
  <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Bottom">
    <Button Name="butShow" Width="80" Height="30" Margin="5">Show</Button>
    <Button Name="butOK" Width="80" Height="30" Margin="5">OK</Button>
  </StackPanel>
</Grid>

</Window>
"@

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader] $xaml)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)


$buttonOK = $window.FindName('butOK')
$buttonShow = $window.FindName('butShow')

$code1 = { 
# Hotfixes abrufen und anzeigen
  [Windows.Input.Mouse]::OverrideCursor = 'Wait'
  $view = $window.FindName('View1')
  $view.ItemsSource = @(Get-Hotfix)
  [Windows.Input.Mouse]::OverrideCursor = $null
}

$code2 = { $window.Close() }

$buttonShow.add_Click($code1)
$buttonOK.add_Click($code2)


$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.28.ps1
************************************************************************
Add-Type -AssemblyName PresentationFramework

function Start-InNewThread
{
  param
  (
    [ScriptBlock]$Code,
    
    [Hashtable]$Parameters = @{}
  )
  
  $powershell = [PowerShell]::Create()
  $action = {
   
    $status = $event.SourceEventArgs.InvocationStateInfo.State
    
    if ($status -eq 'Completed')
    {
      try
      {
        $powershell = $event.Sender
        $powershell.Runspace.Close()
        $powershell.Dispose()
        Unregister-Event -SourceIdentifier $event.SourceIdentifier 
      }
      catch
      {
        Write-Warning "$_"
      }
    }
  }
  
  $null = Register-ObjectEvent -InputObject $powershell -Action $action -EventName InvocationStateChanged 
  $null = $powershell.AddScript($Code)
  
  foreach($key in $Parameters.Keys)
  {
    $null = $powershell.AddParameter($key, $Parameters.$key)
  }
 
  $handle = $powershell.BeginInvoke()
}

$xaml = @"
<Window
 xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'
 Title='Hotfix Viewer' 
 MinWidth='300'
 Width='600'
 MinHeight='300' 
 Height = '300'>

<Grid Margin="5">
  <Grid.RowDefinitions>
      <RowDefinition Height="*"></RowDefinition>
      <RowDefinition Height="Auto"></RowDefinition>
  </Grid.RowDefinitions>

  <ListView Name="View1">
    <ListView.View>
      <GridView>
        <GridViewColumn Width="100" Header="KB" DisplayMemberBinding="{Binding HotfixID}"/>
        <GridViewColumn Width="150" Header="Typ" DisplayMemberBinding="{Binding Description}"/>
        <GridViewColumn Width="150" Header="Datum" DisplayMemberBinding="{Binding InstalledOn}"/>
        <GridViewColumn Width="150" Header="Verantwortlich" DisplayMemberBinding="{Binding InstalledBy}"/>
      </GridView>
    </ListView.View>
  </ListView>
  <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Bottom">
    <Button Name="butShow" Width="80" Height="30" Margin="5">Show</Button>
    <Button Name="butOK" Width="80" Height="30" Margin="5">OK</Button>
  </StackPanel>
</Grid>

</Window>
"@

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader] $xaml)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)


$buttonOK = $window.FindName('butOK')
$buttonShow = $window.FindName('butShow')

$code1 = { 
  param($Fenster)
  
  # Hotfixes im Hintergrundthread abrufen...
  [Console]::Beep(500,600)
  $hotfixes = Get-Hotfix
  [Console]::Beep(1500,600)

  # ...und dann im UI-Thread anwenden:
  $Fenster.Dispatcher.Invoke([Action]{
      $view = $Fenster.FindName('View1')
      $view.ItemsSource = @($hotfixes)
  },'Normal')
}
$code2 = { $window.Close() }

$buttonShow.add_Click({ Start-InNewThread -Code $code1 -Parameters @{Fenster=$window}})
$buttonOK.add_Click($code2)


$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.29.ps1
************************************************************************
Add-Type -AssemblyName PresentationFramework

function Start-InNewThread
{
  param
  (
    [ScriptBlock]$Code,
    
    [Hashtable]$Parameters = @{}
  )
  
  $powershell = [PowerShell]::Create()
  $action = {
   
    $status = $event.SourceEventArgs.InvocationStateInfo.State
    
    if ($status -eq 'Completed')
    {
      try
      {
        $powershell = $event.Sender
        $powershell.Runspace.Close()
        $powershell.Dispose()
        Unregister-Event -SourceIdentifier $event.SourceIdentifier 
      }
      catch
      {
        Write-Warning "$_"
      }
    }
  }
  
  $null = Register-ObjectEvent -InputObject $powershell -Action $action -EventName InvocationStateChanged 
  $null = $powershell.AddScript($Code)
  
  foreach($key in $Parameters.Keys)
  {
    $null = $powershell.AddParameter($key, $Parameters.$key)
  }
 
  $handle = $powershell.BeginInvoke()
}

$xaml = @"
<Window
 xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'
 Title='Hotfix Viewer' 
 MinWidth='300'
 Width='600'
 MinHeight='300' 
 Height = '300'>

<Grid Margin="5">
  <Grid.RowDefinitions>
      <RowDefinition Height="*"></RowDefinition>
      <RowDefinition Height="Auto"></RowDefinition>
  </Grid.RowDefinitions>

  <ListView Name="View1">
    <ListView.View>
      <GridView>
        <GridViewColumn Width="100" Header="KB" DisplayMemberBinding="{Binding HotfixID}"/>
        <GridViewColumn Width="150" Header="Typ" DisplayMemberBinding="{Binding Description}"/>
        <GridViewColumn Width="150" Header="Datum" DisplayMemberBinding="{Binding InstalledOn}"/>
        <GridViewColumn Width="150" Header="Verantwortlich" DisplayMemberBinding="{Binding InstalledBy}"/>
       </GridView>
    </ListView.View>
  </ListView>
  <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Bottom">
    <Button Name="butShow" Width="80" Height="30" Margin="5">Show</Button>
    <Button Name="butOK" Width="80" Height="30" Margin="5">OK</Button>
  </StackPanel>
</Grid>

</Window>
"@

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader] $xaml)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)


$buttonOK = $window.FindName('butOK')
$buttonShow = $window.FindName('butShow')

$code1 = { 
  param($Info)
  
  # ObservableCollection löschen
  $Info.Clear()
  Get-Hotfix | 
  # WICHTIG: mit Select-Object alle gewünschten Eigenschaften angeben:
  Select-Object -Property HotfixId, Description, InstalledBy, InstalledOn | 
  # Ergebnisse neu in ObservableCollection einfügen
  ForEach-Object { $null = $info.Add($_) }
}
$code2 = { $window.Close() }

# ObservableCollection als Parameter an Hintergrundthread übergeben:
$buttonShow.add_Click({ Start-InNewThread -Code $code1 -Parameters @{Info=$data}})

$buttonOK.add_Click($code2)

# eine leere ObservableCollection beschaffen
$data = New-Object System.Collections.ObjectModel.ObservableCollection[Object] 

# ObservableCollection threadsicher machen (erfordert .NET Framework 4.5)
$lock = 1
[Windows.Data.BindingOperations]::EnableCollectionSynchronization($data, $lock)

# als Datenquelle für das Grid setzen:
$view = $window.FindName('View1')
$view.ItemsSource = $data

$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.3.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  Title="Send Message"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

  <StackPanel Orientation="Vertical" Margin="10">

    <StackPanel Orientation="Horizontal" Margin="5">
      <Label Width="100">Name</Label>
      <TextBox  Name="txtName" Width="300"></TextBox>
    </StackPanel>

    <StackPanel Orientation="Horizontal" Margin="5">
      <Label Width="100">Email</Label>
      <TextBox  Name="txtEmail" Width="300"></TextBox>
    </StackPanel>

    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
      <Button Name="butSend" Width="80" Margin="5">Send</Button>
      <Button Name="butCancel" Width="80" Margin="5">Cancel</Button>
    </StackPanel>
  
  </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

$window.ShowDialog()

$name = $window.FindName('txtName').Text
$email = $window.FindName('txtEmail').Text

"Ich sende eine Email an $name. Die Adresse ist $email"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.30.ps1
************************************************************************
function Convert-PNG2Base64 
{
  param
  (
    [Parameter(Mandatory=$true)]
    $Path
  )

  $format = [System.Drawing.Imaging.ImageFormat]::Png

  $image = [System.Drawing.Image]::FromFile($Path)
  $stream = New-Object -TypeName System.IO.MemoryStream
  $image.Save($stream, $format)
  $bytes = [Byte[]]($stream.ToArray())
  [System.Convert]::ToBase64String($bytes, 'InsertLineBreaks')
}
 
Convert-PNG2Base64 -Path 'C:\...\bild.png' | clip.exe



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.31.ps1
************************************************************************
Add-Type -AssemblyName PresentationFramework

$bild1 = @'
iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAArdEVYdENvcHlyaWdodABDb3B5cmlnaHQgqSAyMDA4LTIwMTEgSU5DT1JTIEdtYkgQ
jiFPAAA44ElEQVR4Xu1dB3gUVde+wQAiKi106R0RKaIoTVEUURSkN+kQmtJC771D6ASQ3kOJ1ACh
905IryQkIYX0nuzO+c+5M3d2drLB4O/nx6d7n+c+S8JmMzvve95T74ZZl3VZl3VZl3VZl3VZl3VZ
l3VZl3VZl3VZl3VZl3VZl3VZl3VZl3VZl3X9Ty8b5dG6/ulr1iyWL8p/sF2s/8+fxvv2HpLg32dN
nEe3pT/9VKks/ncB+VnW9Y9YPn5t3oz1HvheXKB988SQocMTggb9FvFk0K3nHn0iIz16ZUR69JAi
n3STIh53NV5ybnPw049LfYA/VlD+aev6n1kAzMb/cseC0c/ty8Q/HflF0vNfxqaED98d4z/0Xozf
kOgYv0HZL/wGQIxPPyna52cpyqu3FOXRExB8eO7eBSIedpLCH3Q0nNjR6nDDekU/xJd8U35l63ot
14GDE/LHxU2smBg/vl1S1PgpUYET9sUEj/aIe/pLctzTkVLc0xFSXPBwKTbIXooNHCrFBgyGFwED
Ica3HyABINqrF2gJ8PzRTxB+v6MUdr+j8eTOFseqlC9sVYLXZcXELHwnNnby+/Fx0zokJs6amZY8
/XhK1ITApHCH5MQIh+zEiPGGxPBxUkLYWGPCs3FSfOhoKTH0F4gPHQFxwcMgLnAocAL4awnQG6I8
zQkQ8bAjhN37QXp2t73xxPZmRxrWK0ZKYCXBf2NlZKypmpm5ZEF6+rxTSTEz/FNeTE9MjpmenRwz
zYiPhhR6jJ4u4ddSasxkSI6cCEmRDpAcPg4Sw0ZDAhEgZCQSYDjEBWkJ0B/dgJYA3RUCdOIECL//
Izy7+70Uerud8djmT50bflDE6g7+Gysra7FjWuL8zLTEhZnpiQuN6cmLjBlJiyAzcQGkJ86DtLhZ
kBo7A1JjpkFK9BRIjkICPHeAJE6AMZDwTCZAPCeAfU4CeJsIEOne1USABz9C+L3v4dmd76WQm98Y
j21p6lylfH6rO/g7V3T0mrfT4ueEZ6avSs3MXJeZkbLUkJmyBDKSF0JG0nxIT5iLBJgtE+CFIMAk
mQARggC/mhMgkAgwCF74EQH6qgSI8lAI8LizhgDtIezud4AqIIXc+Mp4fOvHR2tVtcYEf9tKS1vw
ExIgw2jYaJCkjVJayor0jOTFxozkRSYCxOdGgPEqARJCRkH8U0GAIQoBMBPwJQL0QQJQINhDQwCM
Ax50QDfQnqtA2J3vIORmW+nptS+MRzc2PlS/zlv18fKsJPhPLgDHfAnRM5zTkxdnSrAJAJyASJCa
tCwtPWmhlJGELkAQIG4mEmA6EmCqTIDICQoBxsoECCUCYCAYNIwTIDZAEAADQSSAnAkgASgQfKwE
gpwAP8gEuNsOnt1uC6G3voagyy2Nh9fXP1ivVmErCf6TKz19VsXUuFlx2ZmrDQQ+cBJsAsm40ZiS
sDiNEwBjgPT4OegGFALEEAEoEFQIEE4EoEBQIQBmApgKynGAQgDzQLAbqoA2EBQE+A4J8C2E3WqL
SvAVBF5sZnReW8+54nv538dLtZLgP7FQ/kemxc9F6d8kCfDl7QSG7A3ZyXGYGKgEwEBQIUBKtJIJ
RDhwAugzgdiXZQIviQPC7pAKfAOhN7+G0GutIfBCU+NBx/ed69XKb1WCv3qh/BdIjJp2NTN1qVGW
f/12gozMtZnJsXMz0hMUAqiZgEIAjAMSRSZglgqa4oAYNRAUcYCGAC9xA89utoGn1z6HgPNNjAdW
1jrQqNbbVhL8lSs1dV6jlNgZyQbDOrR+k/zrSZCeuiotJXZ2tuVAkNyANhMQcYBCALM4gFRAEwfk
5gbufAvPbpEKtOGuIORqK/BzbWQ8sKr6garv5a+Hl24lwV+xMjLmLUlPmPcS8MV2gpSk5ampsbMM
abEiDpAJoI0DEnVxgL4iqC8IySogEyCC3ABmA2F3KRswqUDoja9wfwlPr7QAvzMNjM6rqh1+r1QB
a0zw/12RkfMLJ7+Y6mvIWJkHAmBQiJlBcvwiJMFMo3kgmHscoC0ImeoBmnTwCRGgiwU3IAeDqgog
AUKvt4anl5uD76kPjPuWVjrwQW01JhBzBdb5gldZqamzv015MT3LaFivC/5y25QebjImxS5IT3kx
Q0oRFUERB+RwA5o4wJIb8LTgBtRgMKcKhBABrn8BwZeagc/xOsb9Syoe2rygTvfAyy2Hht9svjzk
2meO00aVqYJvTUsK68ptZabO3YkpnmQ5+MttY2Zg2GhIjJmTnjMOEOmgph6Qww28pCpoSQW0sQCq
QAgSIOQakeAz8Pm9BrqE+hJ+PzPkepus4CstjbcPNbjVtV3JZvj2CuO2kiC3lZS0pERa9JTY7CzH
PMm/+ab0cGN20ovZWTwdFG6AZwO5uAG1KogEUKqCuQaDIhbQZQShFAxeRxIgAUIwMwi++Cl4Hqkq
Bbg1lVBdpCgkVfCVVtKN/e972Hcv+QO+zXdwW0lgaaWnzOqfGjtdAskSwHnZTpCdtS4bXYFBmw5a
zAa0RSF/C0UhvQo8NFcBS66ACEA76GJT8HSuwN1CDLqWKK8ePFi8c6CW/9QhpXviWy2KOx9/09Yl
L4DVtrFhE89Qo+fV5F+/nSArY012ctRUoz4bkKuCehXIGQxqVYBXBtWMIHdXoMYDnAStIOjCJ+B5
oCyS4VN8vT4Q6dmdk+CRc83wWfZ2g/Etl8BtJYFYyYnT6yZFTko2Zq/lIFoGNy9b7hlkZ6w2JEdO
kVQVUNvDSneQgsHcVEC0iM36A7qAUHUFuZEAleDCx+BxoBQEnm8C0ZhhkKoQCdydqyU6Tiw1Ht92
adxv8Bvwb1+p8TOmpcXO+BO+X7s3Evi4N1BmIGWlr0ASTJLMg0FFBUQwqFcBNSN4mSvQl4jb5kqC
QLdP4MleOwg49xFE0dAJkokKSI8PVkjaOLnEXDs7VgHfvq18F/6lC2BWocSIiQ8zUxYjiH+GACbg
jcZ1YDSsBWP2GvqelJW6zJgUMQFJoCkN51AB6hDqM4I+6Lt1ASHvEeTMCkwkoKDQRIKQa7S/QBJ8
DO67i0LA2Ub4OnKRKeTq5+B+oHzahknFHMsWZVXxNuSX78a/cCXHz6iXFDkx2ZC1+hUVgJ4rgF/P
gTdkrwZDliNkZ67ij5LkJGUkLZKoKPTyWEA7J2A+L8jTQp0ryJ0E5kogZwet0Q18Ao93vAP+Zz6E
SCoyIZHo/90PlDFsn1Vke83KrBbein/nWYSlU9sXDvAccSw5eppRBjUvJCDgqT0sA08WL4DPzlgB
WenLISttKRjwayJBWsI8VAEiQC4ZgaZLaAoIda6AVwg761LD3EigZAdUJ7iBJECwiQSPthUGv1P1
uAoQiYgsT/aXMu6bXfhI60asEd4Omjv856aJS5e3tY0P61I01qd33Rc+PTvF+3Zb+PTujydC7nZ4
Fh/yi0RDHgCbcedGAh7kKVZPck/Ao9UrwGcrwGelLgFyKZkpi7gqUExAnUOeEupVQFMd5MMiPCDU
uQIigdoneAkJRGBIrWOdSwi9/iV3Bw+2FgTfk3UxppB/np7jvq+k8ciCN8+1bcqoYPQW7v99EtDR
qyce/QrFhgx9PzFkSO+k4MFLo7z7ukZ69H4a5dk7LcqrpzHKq48x2qevhLIrvQgYIlHBhkC0DL65
1ZvkfqUC/DIT8HxucAHueZCeOBckw3r+GtQ0SuKFIVkFzKqDwhVoSsTmJBCpoZ4EWncgE4GniHqX
cPNL/DcNlHwC953yge+J2vjz+LP3fsD/+1py31dKOrXY9m67T1hrvH1v4/7fIkFi4pziiS8mfRwf
M25AauTYtdH+o6/GBg6Pig2yz44LtjfGBg03xAWPkOJCRhoTQn+VEkmGEQD8Ht58WYIJBALHaFiH
gGlVQFg9bm71WrlH4NN0wNOwCKpJevxsSIufhf+ezZWDXis1ZipXAbk6aO4KtCViEwlEaqitD5iT
wBQTKHOEWpeAaqANEJ/dasOzg7tODLxdquPP/yiT5lZb8NhfBs4uZd7237Mf8Za+i/t/gwRZWQsa
pESND0mMcEhLDB+fjY+GpOcTDUmRk41JUVOlpKgpUooyr5ccjr6YW6AswfqRbfp3MgZtMvAayUdS
qL4+Q1j9UshMlaU+I9lk8QL4tLgZkBo7nc8KyO6FXm8DLxUnhtM1mFyBtlFkFg+YpYa5kUBkB3LJ
2OQSdGqgEIEIwUmwkfH+AalAGD3vDpLgYFlwW86CHLqyn/HWFsP9+heMMpKnrkqOnpyanrI8PS1h
vkQWmIY+lwY1ML9XGzTJOUqz2htPN12WX1IE+lmKByS0fgKfS36uVj9fBp4mhDjwM1XgaUaAl4aj
JvLn0WvS6yU/n2juCkJIBXKSQJ4cskQCERMo2QGvE2jjAlEwUmIDQQSuCPiIX1PZWCZBTfwZfC7+
fygSxeNQRenyKhY5rTezx9trh/v1LRjFxk57NzFifERq0qJUo3GTlJKwMCM9AQnAJ3XMJ3aTRVFG
3Hj9pI5IxfCmU0BGFi5hsJcDfO7rFavnck/Ao9XnAjwvCSvko5/lJEA1SebXgiqguCN9PKAGhTky
AxETyNlBlKgTKCQwqYEcG2iDRNk1yGSgfwdd+hTubpDdAT1PDiDbgufRGtJVR5Y0bTBzKMxYGbzV
r2fBKD1u0s9IgEz0zzyNy8pcm5UaO8eQlmNiV1+bNw/C1BvOfW9fHonH4feyMzG657KP4AvJN7N6
Al6ZC7QI/Hg1+iewE8N+5W6ESGDIWoVB4RiZBNwV5EYCjRLwmECTHYg6gd4lWCCCSRGUGAFVgL4X
fPkzrgTex6ry/yMXQYGh9/H3paurWdo8e7awRMnXsGoIEePyx4WPOZMaNzuDUi3ht9NSl2fg96Q/
HtnGm64SQAnANMEXWV186EjL4CvnAoTVy1PBmpEwFXgFYFXqR/Kv5UBzM2Tj6ybxMwTaeECQAK9J
TwI1MFQaR7xYpIkLFDVQA0SM9M2JoMQIKhlQIfD7wZebySRAJeDkuIFBIwaMPic/lK455kt3HM42
2L3Dq4avT8EoJXFy/YTQ0clZGY7Z2qjdYNwgpcQvyBKWKU/qmFq0ckHGdMPVmy38rhjZ5je5DydN
VuoyBF+cClJ8vWr15jMAWovXAq8CG2zPX5MIQDsD3YkpHtCTwFwJRGAoUkSzuEBRAzU2eNwJiUBq
oFEEESNoyBCBmwjy9EpLuKO4g7C76CYoc0AS+Lo2lq6tyWfYMJrtqFGG1cFb/3rMHmbETViG0T6C
TzdSpGyyChiy1xtS4mYbuDT/weFNbTEmx8g2Wlk0Wllq7DTI1ICvSr7O6mXgtcGdEmhqwcSAMxbB
pJ8D2IIbSZA8Xx4gfSkJRHYgVMoUF5irgZ4IiiKIGEEhgzx0aiIEqcXTqy0Vd1ANg8Jv+QQyDaAG
uH0qXV9bQNruwI5/Uvs1qBomJU0pgXl0IAZjhpwEkAc2M9JWZtGsnhwIikyA3IAgAN5s1e+aCCBu
sMnX9uA3mBRFHAiVJV/29Sar1/rz3KWcAjuy5Be+P0MGEkooAR00yRsJxDWSGmC8oqqVCBAtEEHj
GrgqaMmguInnD/Df+P2nV1vBPaoTIAlCMVjkJLj+JWYNzaWb6wsZd09il79t8l+uGqbHT+iJIGYZ
s3Mf4CQSpCYszEqJmS5ZDgQJLE3gpevP6z/EgUAjn58mwLcw9SNb/cssVwcabuodyCRwQnLNlEmk
kkBzffz1lGu06BJyIYLGNchDJgoZVELI6vAcXUUkPka6dwb/i624O/A9UZOnhiHXZRIEX2op3XR6
x3hoOnvwbVP2FULxX6ka2mTFjjuH1o2RP0moZQLQDTUaNxpT42YZ9X5a9dGKpck5uCkO4DdWuAG8
mXQTyXLokCdJf3KkfBLY5OuFxcpyb97g0Uk2VfY0kk1koHSTSEATSfT68muK6xMkEK5EKIqeWC8n
gtxZVMiAJCAyRLp34o/h7j0hwnsQeN/6GW66tIfjmz6Ds6vKwP0tNjwWoC33FPi8gXR7SwnjkZnM
t28b9hPiUYQw4cj8HSszc1KdhGej0gyZf9zClaQNUnbmGvo0D4m7AQtWq95gxWL1I9scLLIktCAq
nRIoyZEWSGRWzSMLxdfw0wVsXggG5fDagA0tLta/P16vrAJUfaR0kq5Pdgn4+rnFE2ZqYIkIGB8g
CaI9u+Pv78m/H48/mxLlwGOZxOhZEO7rAF5Xf4Zr+76AsxsawZm19eGU4/twYmVtuIcqcHRVJQhB
FQjDgFB2B62p0yjd2V5GcpnNwn7pwPojLMVx/z1Vw/QXY+YnRTrkuX/P44HkpVwF/sgNmMa0KBug
G4k3UbgBBE72nR3kn6VyLgdfSDRZpkZBiEBc6hXgVTnWpWv0mg9+4K8lKxqSwLiBk5WOmZu7BBEX
yGQziy/85N9LRKCv44NHcKKT28rOQDdjXA/ZWWsgPnIeBD8cAQ9OduSgX9z2KVz4rSmc39wEzm5E
Aqz7kBPg9xV14eraInBq6Rswa3w9CL35DYTfIRJ8yQPDkOtfSvd2VZROzGXRE7uxXxCakrj/s1XD
mJjR78QGDg/ITFqIBMgZ/Fne3BVI6AqkVx7ZVq1XVoEoj248fSIQiTzqh0BpJF+fRZgsXgCvicg1
qRlV6ihjIRKQK6CuIwWt8nWKGEMhAZIuHn9v/NNh+L1f+XtKi58JWSmLwZi9Gl+D7s02/pgStxjC
vMeC95XecP/39nDL+Wu4cagNXN//BVzd0wou72zOSaAnwPEVdeD0iorwcDODCQPLwYzRdSD4ehsk
wdfwjE4m4X6GivDoYA3jqbksYXxvNgWjQvqgy/9cwSgt6tdOGLlLRpR2y2DntukAxzoplcrCL3MD
XAWERSluQKsCFAsgkNQ8ifHqI/8MkUZIvk411IkeM+A1+bgozPCiDJVqv4UMBFGkh4ZMRyQBFZXG
84yD4gMqQmWmLuHlZFkFt+L+jT8ScdKSlkF08GQIuj8UPC72gMeuneDhmZ/Q4n+Ee79/D3eOfgs3
kQTX97f+AwLUBpelNeH2hjdh75x3YUD3ajB5RC3wufglRHAS0KzBV5gutgH3I+9LJ+axtJkD2LJC
b7GKCNVfTwIPr9a28cHDT2Ba9wrWr91OkJm2nHcGLVYFVRXQSbnWmknGMZAi66UiyQsEPI4/Nyf4
PODiubipTi8DnxN06sTxRs3tr/H/vgMDSrV4jzRPQC5BBps2kUMmCMULGakrIf75bPTl4yDogT34
3ewPvtf7ghdaPBHA/XxXeIQk+DME+B0J4LoCg0FMC4f3rQZDe1aFcUNqgvvZ1vD8HjWWMEC8QR3G
NuBxvKF0Zp5NxuIBbHN5O1YNIftrq4bJ0aPqoY9ONGSsyrP/z7mdIC1hbi4j27mrgN6qo9CqqZxK
bVY5XuiPJBHPIZJQgKdYvZB6bvECeA3ool+vFF1Cb+DNfdxRvV7TRjLgzs5ai7K+CGLDZ0KEvwOE
ef4KIY9HoF8fBoH3hoDfrQF/IQFqwLHFVeHBZhtwdLCDoX2qg32vqjCqXw14dIZI8C2PDUJvfcXf
i6/rJ9Lp+fmylwxkextUYH/tsfXUsFFzkiLG4o34M9YvNsUDG+ggp6R2B81UQARYOp+uHt8SAONG
6ybgCFCuEqpCKJJPAZ6wepT6MLRsuTUr+vMm0PkQJz/nJx/ueHrpU6ApI3qvNIhCVp6MoMdHzIKY
p1MgKmgSPEfww33GwjMigPtIToCAu4M5AXz0BNC4gNtEAB4DmAhgKQgUBDi6qBpcXFUE3FbmhyF9
asDwn6vBsD5V+eNtly8g6gF9hA2RGN0CvreAiy0l1wW2hrUj2MlmtdhHCF0h3P+/NBESp7wdG2jv
k5m8gN8Uy+DmZfM0S0LfqqqAaVhTG2VrVIBbuEit5LqAHBDSrH0nCL7aEp6jX6eSMQcfc2w5stda
vSL1vN1K0zk0sCmD/pQAx9fg+0oLCL7SnEuq7Nc3QUr8YkiImgtxCP6LZ9MhGgkQGTgRIvzGY3A3
BkI9foGnqAAk/yoBrv0MXpd7gceF7uB+rguPAe4jAe66fAe3j7Q1J8COZuYEUNJAOQaQCXBsYXlw
38pg2vCKMOxnQQJ0CagGF/a3hOiHSG7qLiKxiQRBV1pL55e9bXD6hV1v04i1Qgj/f4dTUyNHdkBQ
siWjPFr15zZN98gTPkSEzOTFGGBRMJhbLKDNCCwHhHJW8ANabDO5qvYYfb4F8GWrJyuhaV1z4Alw
6sbRCd9gtHw61UOkIwIYUO4To+dxHx8bNgNiQqfxAC8yYAJEoM8P8xoNIU9GwdNHw3nQ539nEPhi
DOCNBPBEAjxx6waPz3aGh6c7wv0TP6gEuHHwK54CXtndEi4JAjh9BGc3NOQEOEkEWF4LXJZUh6ML
q4DzvMpwY21B2DfvXVSBmkiA6pwEtIf2qgandjaDqEfKe6VZg7tt8X1+LV1wLGr87Vf2qPNn7DuE
8c8fTk2JGL4EQULfTxGvJXBz22KsixeF1KFO2vR/VNc3VwF9LGA5vRPNFwr0KB4gYOnDGp4/JvBR
9imt4+BrrB7zZyHzsrUL4BH0i035mT6a3A083wgj/Xl4fVu49RP4cejvXxD4GuvXyz/5f//bA8H3
Rj/wvtoHPC/1NBHgVAe4f7w93DnWDm4d/sacANs/gwtbP4FzSABXJMDpNR/AyVV1zQkwtyKcXGQH
dzbZwK8DEfy+SIK+RAKZCIN7VoPDTp9B9GMKcNthqoiKh4/PbreTLq4tZdg5lvn2asW6IJR/rmp4
41KXzyK9+ifQRE7eXYCweARdObVj4HN98oQPfY8IkUJlXaECmrqA+ZyeSPMs5PgUD2BqSASgY1nU
ZQsjny/ApzIq9/No9VfR6knmEXiaxiHgA9HiA92aIPAfQcC5xvg6zfj1G7LXqZYvwFd9v2L9oWT9
evnPLQAkAqD/53WAA1/Ctb2fw+VdLeAiEsBty8dwblNjcF3fQCXA78tqwjEkwJEFlZEAFeDgrHJw
HwmwdlJJGEoEwEBweF/aRIjqMLB7Vdi1+hOIfEDvXQ52SQGpyHVtS4XsPeNZ+PDv2CCE809VDQs9
utx5PQKCKiBXy3ICLrZJ6k3AizFuZYY/Y7k6Ap6dvoIPgmozArMmkVJty+EKtNO6PB74CYIQRAro
yApM4NMpHdnqg5EkJPUq8OebQMD5xgh8Iwg42xD8z3zA3QoVcSjSJ5/PZV8DPpd+xffnav0k/+j/
H5P/F/JPAaDe/ysZABGA/L8rBYCr68GJlXVkAiyuJhNgzntwcGY5cF36NlxcnR8JUAdG9NOSoAa6
hupw8VBriHxkSnXlWYP2EHG/g3RnZ43s/Q4sdlhHNgYDglc+nJpv/uymDYLudnsqJmzzAjxVxcyA
FzP8NNSZupjP+JGi0GsKFTBVBzUk0LiCnPGAKSh8hj7Q37WBPEzBT+iYg8+tnku9sPhG/Pn+rh8i
+PXB70QtPsBC70+1evL5KPta8FXpV3z/S61fkX/u//Xyrw8AlQzghEgBF1WFw/MrwSEkwIEZZeDQ
TDteGZz5S2UY3r82kqAWJ8LgXugqtraEF56Y+WD8k2PWAFUBMyLp3qEPDKgEiUM7sBklCrPyiOsr
FYwKXjjcdkqUZx8JEGhzEhDw6OfVgxvm8/sy8OanduRR7vlg5DN6TrxbqJJAExCauwJNgYinhtr6
AJIAHwlssmZ+IEMFX5b8QAKfrB6lnls8Au+HVu93uh74nXofAvDfEmyAVPT9ZPEEPA/4hOxrwOeB
H0p/IIKfm/Vr0z+9/F9B+df6fwoAT1MAqPP/h+dVhEOzy3MC7J1SEq6uyg8HFxaBIf3qwggkwZDe
NcFp2acQ59UVInl/Qy56qZsTogPPlJ67d5bcXT7K3ufAUh26sBUlCrFKiGueD6fafP99hfIel9rf
I6BMrkBj9Rofz2f5zIBfpMz0ycCLUe70xDlcOYg0lBVoA0Ix1aPNCnLWB0xKEK24g8CzjRDoxkiA
Vqrly5KvsXqyeATe91Rd8D1ZB3yOV4dwVBCK/inS5xaPwR5ZPQV83Ocrsq+CL6QfI3+e+umsXx/9
5yb/qv9H+Vf9v5B/xf/vn16aE+DwjHfh0RYGowbVBnt0BQunNIY47248GFabXOqsAZJBbCQDfR3t
2Q08TzfPOjTFJnNKN7YScSUS5FkJbA85fd4r/H6nTKqTS0iAnFa/kvv4lx3X0s7w0wEO+j8iVBaS
xPQRbwoJtK7ALCjUZgZaEvTkb9T35Ptc6oMuo8/nlq8D/xSCj8DTMS2f4zXB+0hlfnQsLWkFB5yD
jhZPwJPVU8DHK35a8DHto9KvkH6zyF9v/XmVf/L/ivwfQfl3noMEQP+/byoSYHIJ2D/5XXiwkcG6
KaXBYWQDCH3YFWK8lNI3kiDySRdl3qATD47xfkjRPv2lcI9+Rp8rnQxXdn2WjYGm8ej88tL20ex5
2aKsB+JK5w/ylh0UKcqKPTzzzYlY/yESEYAs39zqyceLKV4a5LQMvDzXN50f16L+uyFjFZJgM35/
+svjAW0LVusOREzgTf33XhCKQSCdvKG8PvD8xyr4fqdR8lHuZauvxZ9D41deRyqhEq3j0k+Ac9DJ
4gl4xeop4COfL2RfgK+mfUrhJ4fvz4v1q+lfbZT/GnBkEaZ28yrBsXll4PSiInBheX64sZbxmcFr
+LhqYll4cqUzxPoQ8XvwmQO6D/EhwyE5ajLvvkYHTZS8r/eXbh9tZzy/uankuvZDOLNGqTMsqy0d
mJxf6tGCrUdY6TMO89w7eGPz0o9aB99oG0egkuyrVo/gU6dM6+NzAi8Ob9Bol2mOPyVmMq+1k6Lw
KiGf89MWiP6IBCI76IMbSYBkoGifrJvcgcnyEXxh9S7V+Ty+15GKEHKlOWSmr4GnCDYBzkFHi1eB
V6yeAj5V9gX4it8n6efdP630a31/Duun6L8xWn9DOLn6Q06A0ysrgtvK4nBldQG4hUDTUMjjnW+B
j0s1CLncAqW+M5w70gGuu/aEtOjxkB4/E+//CrxvGyAteTk8D5gEHhd6SqQ29HuIaBRncKXRFpow
0HSeZSc5DmaexQuz7ogrpYd5Xm9dO9pibcTjTlI2ST+mctzqzY5riVM7euAF6NQVpAMcmAIqc/x0
ro9cAaWGpAKmlrE2KNSTQBsYmkrGMbxg1BvBJpmvAwEU8Cmyr4J/lMCvzM/kxT+15zePwBabQOcW
rwGeon0K+ITPVy2fwFeqfqr0awo/svVj7r8Tc/9tzdH6m4KbU0O4sKE6XF5XCm6sKwB31jF4gFH+
k93vgv+pOryCSRNHiXgv6HRzBqqqZKBOJRXktvLGVPzzOdwt0e/mvw+V5qby+3K4mhyVxhqw14EZ
2jRkSxHT2rjzHAvYTBtd7QPvcy2CyG9SlK//ky78kKYq9cLiBfATlJkA7ckdeQSLwCcSEHnM5wby
QgLRPZTjAiIBzeWTvJPV+6L1k+ybLL8S/1g3TyRAWvx8CEKgCWwBOAcd/bwZ8IrV/xH4dxGM20eo
8fMNgtEGru1BAuz6DK7/9j7c3FIO7m9+Ex45MXi41QY895WAIIxXqMFFxkBGRNmRqQ0tzxxQsJya
sIRnJwF4XZ6UbWCs8YgUB3+v3t38EQGo3XxwehFpQW92o1AB1h5xpUphnldBly0fTcB8W+KSn4Lg
661eORlkCXgVdM3IFUX9RCjuCvDNkovgH/GiZgaWSKDNDkSxSI4LYnyRBEiI0BtfcivnJOA+X7Z8
At/jUDlUh/oQEzKT+3QCWrtJ6lXghdVTowejfQr4yOcL2Se/f+9EB7j7+48o/d/DrYOfw+3d9eDe
9nII9JvwZCv6cJT0k0sKgtP0krB6YXOICF+kAEwVVmpA0aYMS/5eVsZqiI+cw9NQij206iOaTZRu
/hkCUKrpPK+itGMMS/u4BpuJmNLpozwXiGxaNCtc9t7vn9yjfj0RgPx9jrN6itTrgdeCrgLKhy7t
+c/TTaAKIp/9t0gCEROIFFEpFunigheoBi/8+vHc39O5HPrS6uB1FME/XBHBLw/u++x4E8n/Fvp1
BFlsApxuNIGuWrwAnls9Rft48892hYeuuE8i+Mdaw7399eHBzjKYquXnFn51DYPD8wvB2onFYdKQ
cjC4dxUY1KMKDOhWEWZObsUzKRl8ucROJejUpGW8+0hpKAWiIu00KzjRtSgE4N1GC+lmXghwDIPN
fZMLSzO7MlfE9Avc1DnM87LdsbR+D3+3Zmlk5WT53NcrAR6BJ1s9Sr0OeA4gzdZpJ20VSY8LHMSL
SHRTeNeQ4oSXkUB9DQsugYjAyYBWg6CT1XsTAZzf46rgsb80hD4ewAHOsfEmE+gk9R4k9xd7grtb
D3h8rgdG+ii9x1vDg4MfwMOdJeHR1vxwDyP0S442sH9uYVg13g4mDK4Aw/pUhkE9q8DQXpVhaO/K
YN+rIt9DupcHv7t98D3+hu91jdx4UuYNePEpt3YzBZ+kAHhdREThevQEsNRtpGYTJ4BZsakqOM8u
A9tGseRa5dg4xPQ93HlvGFWuzIpe3NHgWNi99hId2FTPApqd2lFSumdo8WbAaydrtdY7gD9Ptgon
SI2bIROJSKDEBCbXIRREQyTl9UxZAp0GGsgrZe57S8jgo/Q/OVAK1aAKWnhfbtlmGwH3RMCfXEDw
L/SSizsc8PfRwu3g4RZbeLiJwUXHfLB7dhFYPq40TBiCAPepDoN7UZu2CgzrXQnsNaDb96zA98Cu
5WEfWiFkL+d+PgElniaMePk5l3ZzoLbdLNJOfbv5j7qNZummUICqPN3c7VBQsm/L9iOkn+KmIZI8
rzfWzKj8uffpD2PJElP5/L9i9WoAJ4DSA28OknauPsa7N7oRcgWbeWooTxSLGEJLKqEoIi7A10cS
mKsB/o6Agfxr6hg+3l0MPIkA+0uC+9H63KpJ0vkjAv7ErRfe2I7w6FgLeLi/Btz77R24ixH6fbRw
9z3F4NJyBpsmFYcxQ2rBsH51eFNmWD+5NUsWLwOPWwX9PRjag3Z5GNStPMwfU5maNhLADh7U8Xaz
GDbJZdqIF54o/RQlZySpqDjy2EPbbtaUm3m3kQhgqdsoqo3zKsL+aSVg0zAWVa4oG4KYUrPoldrG
hc/9Vmtl8OVm/AAI/QlXrdWbwNHKtLmv5pG7yOOpoOPVC2Lw0Zglj1lTppFbIGnuVvRqYE6E2KAh
vBZAQLrvQ+k+2Q5vIvpyfHx4tCk82FsZ7mGEToDTLN4TjNADztTnHUa6ptB73eDixppwYCKD8YOr
waj+1WFkPxrOqGoCn1u8bO0C+KHdy8GQbuVgZG9UnxMNIe3FVIn6J2LSKCZkqtxx1Fg/bzdb8v/o
nrj/JwLoKo583hAJcJXazfqCUy7dxsPUbZxVFnaOsZW6N2ebEc+GuF9pntBmzM/F6z44VCuQmjL8
pO4zBEYrzxppzgG8BnTR2BGz/PRzclS8GYPM+QoJtEFlbi5BGxto4wtqLQ9EYBH8XcXhwZ5KcH9r
YT55+2BLPp4SUgk58nEH/LlhUtyz8VK410jJ/VxnCf2pdHIV3sAVdeDojAKwalRRuSWrgK+1+qHc
6hXgu5dF8MtC/5/KgOvWuvDsanME30miOUMVfCH9iu/P1frR//PCUy7TRvqKoxoAinKzIIC+2zir
HOye8DYs68e8S7zDeiOmVB5+pVXwsGO18b6nP5Q4ENzytVav+Hgu9TrgCXT1AIc4sqU0Nh525EUQ
Hg9QHoxBZrJ6wEQTF+jUIDci8GvBTVPDFA/4/F6Ndw1f+PeH9PgZYMxcAWmJi6Uwn3GS+/ke0uVd
n0u8V08BlKjXo4S6LCgH+yfYoAJYAJ+A71FOsXoCvwwM6FwaVk+rAiFuHxIBJQnfzwsEXswaCPBV
6RfWr2s30wETnonkJv+59RuUAFC0m134vCH5f7nbeHBGGdg31Y6CQcM3DdlyxLMu7ldqF9s0qM7K
3NhV9TYNYhAByB9rx7pkqyep1wBP1q4HXRzZ4i3NDvh1R95wooDQmIURM08vLdUWcsYGauyB1yKf
5PmFP5/SVUPmSq4uRgQj8cUivOEj4MGJH+EKWs8VvHnkP3OzoOPLasGRKbaw0L6YKbrXWr0C/JCu
pWFQl1IwfmBZPnDif7qelJXpKCW+WKC2nEXnUYCvnTSy1G4W6V9u7WYu/y/x/6YMQG43H0QC8G7j
1JLoBt6EuT3Y3UIF+MfVvVJhiJat0+zyXZ8cqZIajVYun9IlXy+sXvbxpnEucXhDGeMWoNNQpzi9
Q9Mtd79Hyx2iuAInXnI2LzBp1YAIMJannTRpRM+j4lR2+jKg8TThTjLSHLn1kWWRFZF8ijIqWdBV
vQXpJRRv4tG5JWHPOBsYgimeJfAHI/iDu5aCQZ1KwvVdtSDwdF0Iu9teMhg2SlFa4DWzBgJ8VfpF
x1EUf5TgjxefqOH0Evk3mzZCAlicNhLt5mmlYN8UO3QDRWCzvU3GpzXYHMSzOu5XO29YtTgrcmpD
+cMB55pIsSi7JskXLVv5cIc6v685q6c9ssWHOpVZfj7teusb/iEO3BXAJg6qSDlJDVJfTAVKQ6lu
YMig5giBTc+V6+ZUWUxCq6ObTTfUbGBDkVCa2MkzAfAmuuBNdMZgcNpAOxhCwZ4Z+KVgcJeS0K9D
SdixsBIEu9YFb5cq9BF6xrjns01zBgS8dtaAwCfLp3I0gS+kX5v6KcUfS9ZvJv+6JpB+2ugoEuAQ
EoD8//5ppWH3xKKwY2wh2DrCRhrzPXNBOOmTS1+pMETrjYW/FmvxYG+ZFwQsEUBu1eqt3jS9YgJe
A7rZkS35GBR9nh4BScDSmX6aOaAsgaZ4ZLDJumULJ5LQgQ6KsukG+ytWRD5UpFAURGl96KsSgIY2
nacXhc2/2vLCjkn2ZfAH/GQHM0dgUHmmDvgerwFoFEZD9kYpXDtnoLScOfBKxK8Fn6qSQvp5BZKI
q/j+V243qwRA9UICHJpVBvZOKgI7xxZE329jXD2QRTq0Z1fbN2b7yxbjwyIdcNMHVr7yKnTC0W65
99FqUjQGe1zyFV+vPbUjz66J+X3NyR0O+Nem0zvqCZ7PIRZTOdmqqYQqtgw4lVHTEpfySV66wbyV
ayGI+ssIQDI6vyIcGMfAoW8JGEwEINlH8Ad1toOhXezg8eGa4HeiJpWeURFHGWJCZ0p8uIS2sHgB
vHKtavNJAV8t+wrpVyJ/sv5c280qAT4CV7x2sn6XxVX4XOHeCW8S4JmOA1jYxC7s2g9N2P5KpdiW
N/Oz9TY2bBHiNwZ3J9wUCL5SUUgsm8EdCta8ubV4AH1uPkk/B18EeMLq9Ue2FEtXAVcOcVCUzuf7
6DDHFXlsmzY/q5exmk/wxiHofGZf8ac5SqgKAbR+9JWi6FwIQDJ6cHJhWDusAAwk6ceAbzCC369j
cTi2ujIEnJSbT94u1Y0ZqY6GEASbE5O20nIm4IXV84CP1EoLvhL187RPK/2aa6bcXy7+4HXvbAbn
EfzTq+vCsfll4cDUt6VdY/NlrB/KIqZ1ZpfbNWJ7K5dimwsVZGtsGFuAeBHgNBPwOW46U0ifS0jz
Af+vD6MquGfuO6PdD5Qy8IOa3PJR8tVTOzS/Lh9pUi1etXRxgEM5tnWlhTzPf+kziEY3ArCdyzsv
oWryaCqi8IBKW0QhqxKBlCCATkr1N5PfSC0BaGiTCCD8qCAAyiiNbR0kKR3L4JdeqALk9zuWgBUT
ykHw6Rrg41IVvJwrQOi9n7KiQ6ZzoAXgHHQkpwCerlF0+7hSUQ8CrzUH+EjYe8e+Q99P19wWbji3
xWv+gs8XnFhakc8N7newMW4cxp5P68Iuf9+YA+6EFr4WcSHAR+PuhpuOjRHgdKSc/pgVffAUpX5/
GnTtsmlck5U+v7rwdRrDonP9Anz51I5i9RaBV87p0Ry/cmxLHun+mA+akOzTkS1tCZVSKj69qy+h
4s3WHtnSdtHyOrWrPbalD6SIAIfnVoS9DgVh6eA3EfySMKZvKfD+XQGfD5yUN8ZFzMyi6yCwBeCq
1GuBV6zefNYAgz4l6n9wknz/j7zid3l7Ezizqgocm/0u7HNgWevs2dOxXdiFbxqxPeWKsc1vvMHW
IQ56wEnWqeFDFv6XAm5p2a4bl7/znS2FU+gjz0j2VfDxayH3/HSuGfAK6Be1x7aa8E/EoEMbGSkr
5BIqndfTWL9e/kU0zWVV5NGWmijkSymQEnk01QG0ebTSSeNj20gA08FNpZBCkfS0ErDjV4byXwwu
bauKfr86eB2jtnN58HNrnvHM20HiQIuN18NBJ6kXwGutnls+Xie5KiTA/ePfw/V9KO3raoDLvKLS
vgn5UjcMY0Fo4ee/bsB2V7BDCy/ALXwu7lG46ShYc9w06fO3AZ5jVSvKiv6+2PaAx8H3pPCHHbjP
J8lXT+nSkS3u27XAa8/qyYc4/F3rQ+Iz+hyfrXxAQoDPu2fk+7XWr5d/jf9XA0BNMPVKkbSFQgqv
pM0sw2vpB2YXgaAztcGHBk0PVwL6YxBhnsPTREBntvF6+DVdVlrPl9A9XZJ9PrmnW4dawoWNNeHE
wiKS8+R8mVtHsWfTuzE3tPDdFUoyp4L5mSPeYgJ8JG4K2lrg1lo4BXCUx/99gFtY+Wb8zD69vo7F
BF78TCKfT+Crp3Tp4AYd1BQWb3Zyx3RsK+h8Y946TU9ertbPBfi8eyZ8v7B+bQ0dLU700HP4f10A
eF0JAOnY9kX0/24YAJ5D/0+NFE4A9P9mBEDrlwlQFnZPeEfaM9YGUz7F+p3fgycudVMDH44ykGVr
twx4L3wk8PugInWC24dawOXNtcF1aVE4MpVlOY1kgZM7M1e08F1lijEn2zfMLJwApw+MJAunUz6U
rhHgf6+F53EVOjSbLXmw422JPviQf76NIvkm8JsqFi/P78snd2iS90PwPV0Xojy7c+unvnmuR7aU
YgpPq3TWTxZHN95M/tH/k/zn6v//KAXUVtKml5Zr6SMZXFpX0ujjUhmeHCgreV3smPTErYf0xK07
ko8GS5CEeB2PXTvCHeeWcGVzTTi9+F3p8FSWsnEE85nalZ39uiHbVbooc8pvy1bjvZuNezjujrg/
w01/Zawc7tcacP2y+bEVq3ppJQvwOV5HIunn4CtHtoTV84OaZ7Und2iGvx7/owp0njA1cRkHXm2b
Cssn8LXSr6R+qu/XWj/5VI31v0z+1UGKlwSA8sHNsnIpdbId7BxbCLb/apvqcahCxqP9lVI9rg5M
f3wOf+epH+HOoeYIeHU4t6KI8dhMm5Sto1nA5K7sdOv6bEfZ4myTIumzcAvAaThDAE5/d5jSsv+6
pP/ZVWC7A/vl7mbbbA7+1RYIPlq+AF97Xk89vFEX5bQ2hGKMQBU+fmQLgRdWz0upVFET1TQFfC79
ZP0k/cL3a6zfLPq3JP959f+ilYoE2IcE2DPFDnZNKAJO9sywc+rbXld+q5x4dXM1cFv5Dpyay7J2
jmP+Ezuxk20ayoCjpJOFE+D010Go+dIUd03c/wjA9cumUQ1W+uQCduXJwfI86NOC70/gi/N6BPwJ
+eSO97EqQPMF1DsXjRO1hi5KqVRR04Ovk3697zcL/nJL/3TyT/6f5J96AFoCkALsRfnf41CE19J/
G2lDGUHGtnHMa2oPdvzzD9i24u+wTTY2HHCavh2KWwBeAzd9vh913v5RgFtatkuHsQ7XVrNkP9dG
Eh3YNAOfH9wg8DGKRtn3dqkGfifroPVvhufKoESea+hK2selX1P6Fb7fkvVbjP618o8EOK4Q4Mj8
ymotfRevpeczrh/K4ud2Z4/7tmLHqpZmWwrkZ6vwPU/DTX81nObum+CmDhv9GZh/BeA5VnU79u6+
GWzP/W1FpQC3j6VAHfjqeT0En9KoKI+eUlLsYniGYBPovI6u1NDJ6nk5lQI+8vla8IXfpzKqVvot
+H4z69eUf89vbAz883vXNYCTq6mWXg0Ozy4J+yYVhp2j3zBuHsGS5w5gnn1bM5eGVdi2YoXZhnz5
+DDFFNz9cNOYNflwYeE0ZkWfzvHvAdzCyjehB2uCAWGM57FaUsBZOrCpA59yaJrWPVKRHzkL9ZAr
e1rQqchDwAur51U1xecLy/cS4OulXxv5C+vXyv82+WNbTq9B0BeWB+cZRWDveFuK8NMW9GEeAwjw
qmzbu4XZRnw/K3BPxT0Adzvc9NFs9EGNpXBTK/V/Ikr/u1ehPZPZglsb3zT6ofWbZF+c1KUcGuOE
a62l+KgFEoEtGiccdAG8tnMmqmoa2deCr+2gkfRT509N/aj6t7sVgt4YTq+qDkfmFJf2TbSVtv/C
kpb1Y57D27ITH9dg24sUxsAtnyrrAvDGuOlEDU3S0h98tFp5HpZNx6asyulFzOfRvvKS38n3VZ9P
ls9P7RwoBQlhEyTy7xxsBXBu7cLiCXhh9VROFaVUBXwR9Ml+X5b+ey5IANzURLm2pyWc34CR/aLS
cHjam0aM0pNWDWTeo9qxk5/UZNvt3mUbbW15X3w6bvLj9HFrwo8LwOlYtRXwP7EKbBjNRlxd/UaW
OK1L4JPfJ+vHNFCKDpku+d00P6vHO2a0FYvXN1BErs99Pvf7KP20T3WEO2j1l7c2gDMryoPLrLfg
4ESWvdGeBY39kZ1uXodtL/ku24Q+XABO8/EUuH2MmyJ1CtysFv4XLpsmtVmpQzOY252txSSf35EA
4sDm/lIQ8aS35Hd7sERA801giy1Ap1q6BnjRQHF3o8/o6Qr3f/8Oru38WDq3prLkMruQdGACS1tj
z3zGd2CnW33AdhR/mzlharYGr0Xk4gJwbaROgP+7IvW/cdnOGcDan1/KkjycK0niwKaXc1nK940E
snZzwDWge+Gm41u8vOrWg9ql0s39zSW39dWkUwvelg5NYakbRjC/iZ3Y6S/qsx2liphV2wjwH3AL
wK2R+n9jUVq4bSLbeX39W5LnkYqSx4EyEHT5c6PXlX4Sde60m5/XQ7Cpe0aPj892ke4e/hwuOdWU
XJcUlY7OyJexfQwLmd6dnfu2Mdv1nh1zKmBrBjgVXz7BLaptVsBfg5VveDvW4MxCFvNgZ0npycEy
kt/17kaagiFJ97hAhzV7wZOLvdG3d4G7h7+Qrm2rA2dXFJOOz2LZO8ax4Ok9EfCP2K7yJcw6ZiNw
0x9V0jZQrJL+mq43t09g8y6vsjV6HK1udHfrbXx8nj79oiPcPUKA15XcVhWVTs1hGbsd2NP5P7ML
3zVhu8sVZ0753+A+nGbYLQEuOmZWwF/zZfMTpoXHZjOP61sqGK5tryddXF1cOrXQNv3AZPZsSX92
8cembE+VMmwTDTLi87U9cSvg/5CVf91INsh1AfN1HMYudm7OAacxJwJ8Pm76y1g05qSdeiHA/331
9H/oIgDJR1P9nMAWc22Wxpys5dV/6KJonEhAYJOkWwH/ly4C2wq4dVmXdVmXdVmXdVmXdVmXdVmX
dVmXdVmXdVmXdVmXdVmXdVmXdVmXdVmXdVnXf2ox9n+xrmI6BWMR2wAAAABJRU5ErkJggg==
'@

function Convert-Text2Picture
{
  param([Parameter(Mandatory=$true)]$Base64Text)
  
  $bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
  $bitmap.BeginInit()
  $bitmap.StreamSource = [System.IO.MemoryStream][System.Convert]::FromBase64String($base64Text)
  $bitmap.EndInit()
  $bitmap.Freeze()
  $bitmap
}



$xaml = @'
<Window
   xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
   xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
   FontFamily="Arial" Foreground="Blue" SizeToContent="Width"
   Title="Ein Bild anzeigen">
   <Grid Margin="20">
     <Image Name="Img1" Margin="20" HorizontalAlignment="Center"/>
     <TextBlock TextAlignment="Center" VerticalAlignment="Center" FontSize="40" HorizontalAlignment="Center">
      <TextBlock.Effect><DropShadowEffect ShadowDepth="4" Color="DarkGray" BlurRadius="4"/></TextBlock.Effect>
      PowerShell ist Gold wert!<LineBreak/><LineBreak/>Bild aus Text geladen
     </TextBlock>
   </Grid>
</Window>
'@

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)
$image =  $window.FindName('Img1')   
$image.Source = Convert-Text2Picture -Base64Text $Bild1
$null = $window.ShowDialog()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.4.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  Title="Send Message"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

  <StackPanel Orientation="Vertical" Margin="10">

    <StackPanel Orientation="Horizontal" Margin="5">
      <Label Width="100">Name</Label>
      <TextBox  Name="txtName" Width="300"></TextBox>
    </StackPanel>

    <StackPanel Orientation="Horizontal" Margin="5">
      <Label Width="100">Email</Label>
      <TextBox  Name="txtEmail" Width="300"></TextBox>
    </StackPanel>

    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
      <Button Name="butSend" Width="80" Margin="5">Send</Button>
      <Button Name="butCancel" Width="80" Margin="5">Cancel</Button>
    </StackPanel>
  
  </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Elemente ansprechen, mit denen etwas passieren soll:
$textBox1 = $window.FindName('txtName')
$textBox2 = $window.FindName('txtEmail')
$buttonSend = $window.FindName('butSend')
$buttonCancel = $window.FindName('butCancel')

# Eingabecursor in erstes Textfeld setzen:
$null = $textBox1.Focus()

# Click-Ereignisse der Schaltflächen mit Aktion versehen:
$code1 = { $window.DialogResult = $true }
$code2 = { $window.DialogResult = $false }

$buttonSend.add_Click($code1)
$buttonCancel.add_Click($code2)

$DialogResult = $window.ShowDialog()
if ($DialogResult -eq $true)
{
  $info = [Ordered]@{
    Name = $textBox1.Text
    Email = $textBox2.Text
  }
  New-Object -TypeName PSObject -Property $info
}
else
{
  Write-Warning 'Abbruch durch den User.'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.5.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  Title="Send Message"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

  <StackPanel Orientation="Vertical" Margin="10">

    <StackPanel Orientation="Horizontal" Margin="5">
      <Label Width="100">Name</Label>
      <TextBox  Name="txtName" Width="300"></TextBox>
    </StackPanel>

    <StackPanel Orientation="Horizontal" Margin="5">
      <Label Width="100">Email</Label>
      <TextBox  Name="txtEmail" Width="300"></TextBox>
    </StackPanel>

    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
      <Button Name="butSend" Width="80" Margin="5">Send</Button>
      <Button Name="butCancel" Width="80" Margin="5">Cancel</Button>
    </StackPanel>
  
  </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Elemente ansprechen, mit denen etwas passieren soll:
$textBox1 = $window.FindName('txtName')
$textBox2 = $window.FindName('txtEmail')
$buttonSend = $window.FindName('butSend')
$buttonCancel = $window.FindName('butCancel')

# Eingabecursor in erstes Textfeld setzen:
$null = $textBox1.Focus()

# Click-Ereignisse der Schaltflächen mit Aktion versehen:
$code1 = { $window.DialogResult = $true }
$code2 = { $window.DialogResult = $false }

$buttonSend.add_Click($code1)
$buttonCancel.add_Click($code2)

# KeyPress-Ereignisse der TextBox-Elemente definieren
$code3 = {
  [System.Windows.Input.KeyEventArgs]$e = $args[1]
  if ($e.Key -eq 'ENTER') { $textBox2.Focus() }  
}

$code4 = {
  [System.Windows.Input.KeyEventArgs]$e = $args[1]
  if ($e.Key -eq 'ENTER') { $window.DialogResult = $true }  
}
  
$textBox1.add_KeyUp($code3)
$textBox2.add_KeyUp($code4)

$DialogResult = $window.ShowDialog()
if ($DialogResult -eq $true)
{
  $info = [Ordered]@{
    Name = $textBox1.Text
    Email = $textBox2.Text
  }
  New-Object -TypeName PSObject -Property $info
}
else
{
  Write-Warning 'Abbruch durch den User.'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.6.ps1
************************************************************************
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Title="Aktion auswählen"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

    <StackPanel Orientation="Vertical" Margin="10">

        <StackPanel Orientation="Vertical" Margin="5">
            <RadioButton x:Name="radioButton1" Content="Neustart" Margin="5" IsChecked="True"/>
            <RadioButton x:Name="radioButton2" Content="Herunterfahren" Margin="5"/>
            <RadioButton x:Name="radioButton3" Content="Abmelden" Margin="5"/>
        </StackPanel>

        
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
            <Button x:Name="butSend" Width="80" Margin="5" Content="OK"/>
            <Button x:Name="butCancel" Width="80" Margin="5" Content="Cancel"/>
        </StackPanel>

    </StackPanel>
</Window>



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.7.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Title="Aktion auswählen"
  SizeToContent="WidthAndHeight"
  WindowStyle="ToolWindow"
  ResizeMode="NoResize">

    <StackPanel Orientation="Vertical" Margin="10">

        <StackPanel Orientation="Vertical" Margin="5">
            <RadioButton x:Name="radioButton1" Content="Neustart" Margin="5" IsChecked="True"/>
            <RadioButton x:Name="radioButton2" Content="Herunterfahren" Margin="5"/>
            <RadioButton x:Name="radioButton3" Content="Abmelden" Margin="5"/>
        </StackPanel>

        
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
            <Button x:Name="butSend" Width="80" Margin="5" Content="OK"/>
            <Button x:Name="butCancel" Width="80" Margin="5" Content="Cancel"/>
        </StackPanel>

    </StackPanel>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Elemente ansprechen, mit denen etwas passieren soll:
$buttonSend = $window.FindName('butSend')
$buttonCancel = $window.FindName('butCancel')

$radio1 = $window.FindName('radioButton1')
$radio2 = $window.FindName('radioButton2')
$radio3 = $window.FindName('radioButton3')

# Click-Ereignisse der Schaltflächen mit Aktion versehen:
$code1 = { $window.DialogResult = $true }
$code2 = { $window.DialogResult = $false }

$buttonSend.add_Click($code1)
$buttonCancel.add_Click($code2)

$DialogResult = $window.ShowDialog()
if ($DialogResult -eq $true)
{
  if ($radio1.isChecked)
  {
    1
  }
  elseif ($radio2.isChecked)
  {
    2
  }
  elseif ($radio3.isChecked)
  {
    3
  }
}
else
{
  Write-Warning 'Abbruch durch den User.'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.8.ps1
************************************************************************
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  Title="Send Message"
  Width="300"
  MinWidth ="200"
  SizeToContent="Height"
  WindowStyle="ToolWindow">
    <Grid Margin="5">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"></ColumnDefinition>
            <ColumnDefinition Width="*"></ColumnDefinition>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"></RowDefinition>
            <RowDefinition Height="Auto"></RowDefinition>
            <RowDefinition Height="*"></RowDefinition>
        </Grid.RowDefinitions>
  
      <Label Grid.Column="0">Name</Label>
      <TextBox Grid.Column="1"  Name="txtName" Margin="5"></TextBox>
    
      <Label Grid.Column="0" Grid.Row="1">Email</Label>
      <TextBox  Grid.Column="1" Grid.Row="1" Name="txtEmail" Margin="5"></TextBox>
    
    <StackPanel Grid.ColumnSpan="2" Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Bottom">
      <Button Name="butSend" Width="80" Height="30" Margin="5">Send</Button>
      <Button Name="butCancel" Width="80" Height="30" Margin="5">Cancel</Button>
    </StackPanel>
    </Grid>
</Window>
'@

Add-Type -AssemblyName PresentationFramework

$reader = [System.XML.XMLReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)

# Elemente ansprechen, mit denen etwas passieren soll:
$textBox1 = $window.FindName('txtName')
$textBox2 = $window.FindName('txtEmail')
$buttonSend = $window.FindName('butSend')
$buttonCancel = $window.FindName('butCancel')

# Eingabecursor in erstes Textfeld setzen:
$null = $textBox1.Focus()

# Click-Ereignisse der Schaltflächen mit Aktion versehen:
$code1 = { $window.DialogResult = $true }
$code2 = { $window.DialogResult = $false }

$buttonSend.add_Click($code1)
$buttonCancel.add_Click($code2)

# KeyPress-Ereignisse der TextBox-Elemente definieren
$code3 = {
  [System.Windows.Input.KeyEventArgs]$e = $args[1]
  if ($e.Key -eq 'ENTER') { $textBox2.Focus() }  
}

$code4 = {
  [System.Windows.Input.KeyEventArgs]$e = $args[1]
  if ($e.Key -eq 'ENTER') { $window.DialogResult = $true }  
}
  
$textBox1.add_KeyUp($code3)
$textBox2.add_KeyUp($code4)

$DialogResult = $window.ShowDialog()
if ($DialogResult -eq $true)
{
  $info = [Ordered]@{
    Name = $textBox1.Text
    Email = $textBox2.Text
  }
  New-Object -TypeName PSObject -Property $info
}
else
{
  Write-Warning 'Abbruch durch den User.'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\31.9.ps1
************************************************************************
function Find-Type
{
  Add-Type -AssemblyName PresentationFramework
  
  # falls Variable "$script" noch nicht gefüllt ist,
  # alle .NET Typen ermitteln:
  if (!$script:types)
  {
    # geladene Assemblys bestimmen:
    $assemblies = [AppDomain]::CurrentDomain.GetAssemblies()

    # Anzahl für Fortschrittsbalken merken:
    $all = $assemblies.Count
    $i = 0

    # Variable nun füllen
    $script:types = $assemblies |
    # Fortschrittsbalken anzeigen
    ForEach-Object {
      $prozent = $i * 100 / $all
      Write-Progress -Activity 'Examining assemblies' -Status $_.FullName -PercentComplete $prozent
      $i++; $_
    } |
    ForEach-Object { try { $_.GetExportedTypes() } catch {} } |
    Where-Object { $_.isPublic} |
    Where-Object { $_.isClass } |
    Where-Object { $_.Name -notmatch '(Attribute|Handler|Args|Exception|Collection|Expression)$' }|
    Select-Object -ExpandProperty FullName

    # Fortschrittsbalken wieder ausblenden:
    Write-Progress -Activity 'Examining assemblies' -Completed
  }

  # Fensterelemente beschaffen:
  $window = New-Object Windows.Window
  $textBlock = New-Object Windows.Controls.TextBlock
  $textBox = New-Object Windows.Controls.TextBox
  $listBox = New-Object Windows.Controls.Listbox
  $dockPanel = New-Object Windows.Controls.DockPanel

  # Fenster konfigurieren:
  $window.Width = 500
  $window.Height = 300
  $window.Title = '.NET Type Finder by Dr. Tobias Weltner'
  $window.Content = $dockPanel
  $window.Background = 'Orange'
  $window.TopMost = $true

  # Dockpanel konfigurieren:
  $dockPanel.LastChildFill = $true
  # Elemente ins Dockpanel aufnehmen:
  $dockpanel.AddChild($textBlock)
  $dockpanel.AddChild($textBox)
  $dockpanel.AddChild($listBox)
  # Dockingposition festlegen:
  [Windows.Controls.DockPanel]::SetDock($textBlock, 'top')
  [Windows.Controls.DockPanel]::SetDock($textbox, 'top')
  [Windows.Controls.DockPanel]::SetDock($listbox, 'top')

  # TextBlock konfigurieren:
  $textBlock.Text = 'Enter part of a .NET type name (i.e. "Dialog"). Multiple keywords are permitted. Press DOWN to switch to list and select type. Press ENTER to select type. Press ESC to clear search field. Window will close on ESC if search field is empty.'
  $textBlock.TextWrapping = 'Wrap'
  $textBlock.Margin = 3
  $textBlock.FontFamily = 'Tahoma'
  $textblock.Background = 'Orange'

  # Textbox konfigurieren:
  $textBox.FontFamily = 'Tahoma'
  $textBox.FontSize = 26
  # wenn der Text in der Textbox sich ändert,
  # sofort Liste aktualisieren:
  $refreshCode = {
    # aktualisiert den Inhalt der Listbox
    # die Worte in der Listbox werden gesplittet,
    # dann wird daraus ein regulärer Ausdruck erstellt, der nur die Texte
    # wählt, in denen ALLE Suchworte gemeinsam vorkommen:
    $regex = '^(?=.*?({0})).*$' -f ($textbox.Text.Trim() -split '\s{1,}' -join '))(?=.*?(')
    # Inhalt der Listbox sind alle Typen, die dem RegEx entsprechen:
    $listBox.ItemsSource = @($types -match $regex)
  }
  $textBox.add_TextChanged({ & $refreshCode })
  # festlegen, was bei Tastendrücken in der Textbox geschehen soll:
  $keyDownCode = {
    Switch ($args[1].Key)
    {
      'Return' { & $refreshCode }
      'Escape'    {
        # wenn ESCAPE gedrückt wird und die Textbox leer ist,
        # dann Fenster schließen...
        if ($textbox.Text -eq '')
        {
          $window.Close()
        }
        # ...sonst Textboxinhalt leeren:
        else
        {
          $textBox.Text = ''
        }
      }
    }
  }
  # wenn in der Textbox DOWN gedrückt wird, den Fokus in die ListBox setzen:
  $previewkeyDownCode = {
    if ($args[1].Key -eq 'Down')
    {
      & $refreshCode
      $listBox.Focus()
    }
  }
  # Textbox-Ereignishandler binden:
  $textBox.add_KeyDown( $keyDownCode )
  $textBox.add_PreviewKeyDown( $previewKeyDownCode )
  # Textbox soll nach dem Start eingabebereit sein:
  $null = $textBox.Focus()

  # Listbox konfigurieren:
  # wenn in der ListBox UP gedrückt wird und das oberste Element gewählt ist,
  # dann den Fokus in die Textbox setzen:
  $previewkeyDownCodeListBox = {
    if (($args[1].Key -eq 'Up') -and ($listbox.SelectedIndex -lt 1))
    {
      $listBox.SelectedIndex=-1
      $textBox.Focus()
    }
  }
  # festlegen, was bei Tastendrücken in der Listbox geschehen soll:
  $keyDownCodeListBox = {
    Switch ($args[1].Key)
    {
      'Return' { $window.Close() }
      'Escape'    { $textBox.Focus() }
    }
  }
  # Ereignishandler an die Listbox binden:
  $listBox.add_previewKeyDown($previewkeyDownCodeListBox)
  $listBox.add_KeyDown($keyDownCodeListBox)

  # Fenster anzeigen:
  $null = $window.ShowDialog()

  # ausgewählten Typ zurückgeben
  $listBox.SelectedItem
}

Find-Type



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.1.ps1
************************************************************************
$info = [Ordered]@{
    'Pester vorhanden' = (Get-Module -Name Pester -ListAvailable) -ne $null
    Version = (Get-Module -Name Pester -ListAvailable).Version
    'Aktuelle Version' = (Find-Module -Name Pester).Version
}

New-Object -TypeName PSObject -Property $info



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.10.ps1
************************************************************************
function Get-HelloWorld 
{
  param
  (
    $Name = ''
  )

  if ($Name.Length -gt 0) 
  {
    $Name = ' ' + $Name
  }

  "Hello World$Name!"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.11.ps1
************************************************************************
Import-Module Pester

Describe "Interaktive Demo" {
    It "Interaktive Demo" {
        { Get-Process powershell_ise -ErrorAction Stop } | Should Not Throw
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.12.ps1
************************************************************************
Import-Module Pester

Describe "Interaktive Demo" {
    It "Richtige Ausgabe" {
        { Get-Process powershell_ise -ErrorAction Stop } | Should Not Throw
        "Hello World" | Should Be 'hello world'
        "Hello World" | Should MatchExactly 'world'
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.13.ps1
************************************************************************
Import-Module Pester

Describe "Interaktive Demo" {
    It "ISE-Editor wird ausgeführt" {
        { Get-Process powershell_ise -ErrorAction Stop } | Should Not Throw
    }
}

Describe "Interaktive Demo" {
    It "gibt den Text 'Hello World' zurück (Groß- und Kleinschreibung egal)" {
        "Hello World" | Should Be 'hello world'
    }
}

Describe "Interaktive Demo" {
    It "enthält das Wort 'world' in Kleinschreibung" {
        "Hello World" | Should MatchExactly 'world'
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.14.ps1
************************************************************************
function Restart-InactiveComputer
{
  $explorer = Get-Process -Name explorer -ErrorAction SilentlyContinue
  if ($explorer.Count -eq 0)
  {
    Restart-Computer -Force
  }
}


c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.15.ps1
************************************************************************
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe 'Restart-InactiveComputer' {

  Mock Restart-Computer { <# Neustart wird nur simuliert #> }

  Context 'Computer sollte neu starten' {
    It 'Neustart, wenn niemand angemeldet ist' {

      Mock Get-Process {}

      Restart-InactiveComputer 

      Assert-MockCalled Restart-Computer -Exactly 1
    }
  }
    
  Context 'Computer sollte NICHT neu starten' {
    It 'Kein Neustart bei angemeldeten Benutzern' {

      Mock Get-Process { 'irgendetwas liefern' }

      Restart-InactiveComputer

      Assert-MockCalled Restart-Computer -Exactly 0
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.16.ps1
************************************************************************
function Remove-LogFile
{
  param
  (
    $Path
  )
  
  $exists = Test-Path $path
  
  if ($exists)
  {
    Remove-Item -Path $path
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.17.ps1
************************************************************************
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe 'Remove-LogFile' {
  Mock Remove-Item { <# es wird nicht wirklich gelöscht #> }
  Mock Test-Path { $true } -ParameterFilter { $Path -and $Path -eq "$env:temp\sample.txt" }
  Mock Test-Path { $false } 
  It 'existierende Datei löschen' {
    Remove-Logfile -Path "$env:temp\sample.txt" | Should BeNullOrEmpty
  }
  It 'nicht vorhandene Datei liefert Fehler' {
    { Remove-LogFile -Path c:\doesnotexist.txt } | Should Throw
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.18.ps1
************************************************************************
function New-LocalUserAccount 
{
  param
  (
    [Parameter(Mandatory=$true)]
    [string]
    $Name
  )
  
  # Lokales Benutzerkonto anlegen und
  # Fehler an PowerShell zurückliefern
  $ErrorActionPreference = 'Stop'
  $null = net user $Name /ADD 2>&1
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.19.ps1
************************************************************************
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe 'New-LocalUserAccount' {
    It "Lokales Benutzerkonto 'testaccount' existiert noch nicht" {
      {
        # Testkonto versuchsweise abrufen. Wenn es nicht existiert,
        # kommt es zu einem Fehler. Ein Fehler ist also erwartet:
        $ErrorActionPreference = 'Stop'
        net user Testaccount 2>&1 
      }| Should Throw
    }
    It "Neues Benutzerkonto namens 'Testaccount' anlegen" {
      { 
        # Konto anlegen. Das Konto existiert danach tatsächlich.
        New-LocalUserAccount -Name Testaccount 
      } | Should Not Throw
      
      {
        # Konto wird gesucht und sollte jetzt existieren:
        $ErrorActionPreference = 'Stop'
        net user Testaccount 2>&1 
      }| Should Not Throw
      
      # Aufräumungsarbeiten: Das Testkonto muss wieder entfernt werden:
      $null =  net user Testaccount /DELETE
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.2.ps1
************************************************************************
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-HelloWorld" {
    It "does something useful" {
        $true | Should Be $false
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.20.ps1
************************************************************************
function New-File 
{
  param
  (
    [Parameter(Mandatory = $true)]
    $Path
  )
  
  $exists = Test-Path -Path "FileSystem::$Path"
  
  if (!$exists)
  {
    New-Item -Path $Path -ItemType File -Force
  }
  else
  {
    Get-Item -Path $Path
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.21.ps1
************************************************************************
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe 'New-File' {
    It 'löst keinen Fehler aus' {
      { New-File 'TestDrive:\somefolder\anotherfolder\file.txt' } | Should Not Throw
    }
    It 'legt eine neue Datei mit notwendigen Ordnern an' {
      New-File 'TestDrive:\somefolder\anotherfolder\file.txt' | Should Exist 'TestDrive:\somefolder\anotherfolder\file.txt'
    }
    It 'ruft eine vorhandene Datei ab' {
      New-File 'TestDrive:\somefolder\anotherfolder\file.txt' | Should Not BeNullOrEmpty
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.22.ps1
************************************************************************
Import-Module Pester

Describe 'Testet Voraussetzungen' {
    It 'Notwendige Datei vorhanden' -TestCases @{file = "$env:windir\explorer.exe"},
        @{file = "$env:windir\system32\Windowspowershell"},
        @{file = "$home\Documents\WindowsPowerShell\Modules"} -Test {
        param ([string]$file)
 
        $file | Should Exist
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.3.ps1
************************************************************************
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-HelloWorld" {
    It "outputs 'Hello World!" {
        Get-HelloWorld | Should Be 'Hello World!'
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.4.ps1
************************************************************************
function Get-HelloWorld {

}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.5.ps1
************************************************************************
function Get-HelloWorld 
{
  'Hello World!'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.6.ps1
************************************************************************
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.7.ps1
************************************************************************
function Get-HelloWorld 
{
  'Hello World!'
}

Write-Host 'Ich könnte schlimme Dinge tun!' -ForegroundColor Red



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.8.ps1
************************************************************************
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-HelloWorld" {
    It "outputs 'Hello World!" {
        Get-HelloWorld | Should Be 'Hello World!'
    }

    It "outputs 'Hello World [NAME]!" {
        Get-HelloWorld -Name Tobias | Should Be 'Hello World Tobias!'
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\32.9.ps1
************************************************************************
function Get-HelloWorld 
{
  param
  (
    $Name
  )

  "Hello World $Name!"
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.1.ps1
************************************************************************
$result = [Ordered]@{}

foreach($user in 'AllUsers', 'CurrentUser')
{
    foreach($scope in 'AllHosts', 'CurrentHost')
    {
        $name = "$user$scope"
        $result.$name = Test-Path -Path $profile.$name
    }
}

New-Object -TypeName PSObject -Property $result



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.10.ps1
************************************************************************
#requires -Version 3
function Get-ScriptVariableReport
{
  # Inhalt des aktuellen Skripts im ISE-Editor lesen:
  $text = $psISE.CurrentFile.Editor.Text

  # alle Variablen im Code in finden
  [System.Management.Automation.PSParser]::Tokenize($text, [ref]$null) |
  Where-Object { $_.Type -eq 'Variable' } |
  # Name der Variable finden
  ForEach-Object {
    # die Zeile, in der die Variable steht, als Text lesen:
    $psISE.CurrentFile.Editor.SetCaretPosition($_.StartLine,1)
    $psISE.CurrentFile.Editor.SelectCaretLine()

    $hash = [Ordered]@{
      Name = $_.Content
      Line = $_.StartLine
      Code = $psISE.CurrentFile.Editor.SelectedText.Trim()
    }

    # Informationen zurückliefern
    New-Object -TypeName PSObject -Property $hash
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.11.ps1
************************************************************************
$code = 
{
  $Autor = '[Ihr Name]'
  $Datum = Get-Date -Format 'yyyy-MM-dd'

  $text = @"
########################
#
# Autor:   $Autor
# Version: 1.0
# Datum:   $datum
#
########################


"@

  $file = $psise.CurrentPowerShellTab.Files.Add()
  $file.Editor.Text = $text
  $file.Editor.SetCaretPosition(1,1)
  $file.Editor.SetCaretPosition($file.Editor.LineCount,1)
}

$null = $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('Neues Skript', $code, 'CTRL+ALT+N')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.12.ps1
************************************************************************
function New-Script
{
  $Autor = '[Ihr Name]'
  $Datum = Get-Date -Format 'yyyy-MM-dd'

  $text = @"
########################
#
# Autor:   $Autor
# Version: 1.0
# Datum:   $datum
#
########################


"@

  $file = $psise.CurrentPowerShellTab.Files.Add()
  $file.Editor.Text = $text
  $file.Editor.SetCaretPosition(1,1)
  $file.Editor.SetCaretPosition($file.Editor.LineCount,1)
}

$null = $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('Neues Skript', { New-Script }, 'CTRL+ALT+N')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.13.ps1
************************************************************************
function Find-AddonMenu
{
  param(
    $Title = '*',
    $MenuItem = $psISE.CurrentPowerShellTab.AddOnsMenu,
    [switch]
    $Recurse
  )

  foreach($item in $MenuItem.SubMenus)
  {
    if ($Recurse)
    {
      Find-AddonMenu -Title $title -MenuItem $item
    }

    if ($item.DisplayName -eq $Title)
    {
      $item
    }
  }
}

function New-AddonMenu
{
  param
  (
    [Parameter(Mandatory=$true)]
    $DisplayName,

    [ScriptBlock]
    $Action=$null,

    $Shortcut=$null
  )
  try
  {
    $Parent = $psISE.CurrentPowerShellTab.AddOnsMenu
    $Items = $DisplayName.Split('\')
    for($x=0; $x -lt $Items.Count-1; $x++)
    {
      $name = $Items[$x]
      $item = Find-AddonMenu -Title $name -MenuItem $parent
      if ($item -eq $null)
      {
        $item = $parent.SubMenus.Add($name, $null, $null)
      }
      $parent = $item
    }

    $item = Find-AddonMenu -Title $Items[-1] -MenuItem $parent
    if ($item -ne $null)
    {
      Write-Warning 'Menu item already exists.'
      break
    }

    try
    {
      $parent.SubMenus.Add($Items[-1], $Action, $Shortcut)
    }
    catch
    {
      try
      {
        $parent.SubMenus.Add($Items[-1], $Action, $null)
      }
      catch
      {
        Write-Warning "Unable to create addon menu item: $_"
      }
    }
  }
  catch
  {
    Write-Warning "Unable to create addon menu item: $_"
  }

}

function Remove-AddonMenu
{
  param
  (
    [Parameter(Mandatory=$true)]
    $DisplayName
  )

  $Parent = $psISE.CurrentPowerShellTab.AddOnsMenu
  $Items = $DisplayName -split '\\'
  $MenuItems = @($psISE.CurrentPowerShellTab.AddOnsMenu)
  for($x=0; $x -lt $Items.Count; $x++)
  {
    $name = $Items[$x]
    $parent = Find-AddonMenu -Title $name -MenuItem $parent
    $MenuItems += $parent
  }

  for($x=$MenuItems.Count -1; $x -gt 0; $x--)
  {
    if ($MenuItems[$x].SubMenus.Count -eq 0)
    {
      $null = $MenuItems[$x-1].Submenus.Remove($MenuItems[$x])
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.14.ps1
************************************************************************
function Get-TokenSimple
{

  [CmdletBinding(DefaultParameterSetName='All')]
  param
  (
    [Parameter(Mandatory=$false, Position=0, ParameterSetName='Selected')]
    [System.Management.Automation.PSTokenType]
    $Kind = 'Variable',
    
    [String]
    $Code = $psise.CurrentFile.Editor.Text
  )    
    
  # provide buckets for errors and tokens
  $Errors = $null
    
  # parse the code
  $Tokens = [System.Management.Automation.PSParser]::Tokenize($Code, [ref]$Errors)
  if ($PSCmdlet.ParameterSetName -eq 'All')
  {
    $Tokens
  } 
  else
  {
    $Tokens | Where-Object { $_.Type -eq $Kind }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.15.ps1
************************************************************************
function Get-TokenDetailed
{

  [CmdletBinding(DefaultParameterSetName='All')]
  param
  (
    [Parameter(Mandatory=$false, Position=0, ParameterSetName='Kind')]
    [System.Management.Automation.Language.TokenKind]
    $Kind = 'Variable',

    [Parameter(Mandatory=$false, Position=0, ParameterSetName='Flag')]      
    [System.Management.Automation.Language.TokenFlags]
    $Flag = 'CommandName',
    
    $Code = $psise.CurrentFile.Editor.Text
  )
    
  # provide buckets for errors and tokens
  $Errors = $Tokens = $null
    
  # parse the code
  $null = [System.Management.Automation.Language.Parser]::ParseInput($Code, [ref]$Tokens, [ref]$Errors)
    
  if ($PSCmdlet.ParameterSetName -eq 'All')
  {
    $Tokens
  } 
  elseif ($PSCmdlet.ParameterSetName -eq 'Flag')
  {
    $Tokens | Where-Object { $_.TokenFlags -eq $Flag }   
  }
  else
  {
    $Tokens | Where-Object { $_.Kind -eq $Kind }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.16.ps1
************************************************************************
function Remove-ISEComment
{
  # Inhalt des aktuellen Skripts im ISE-Editor lesen:
  $text = $psISE.CurrentFile.Editor.Text

  # für die schnelle Bearbeitung des Textes diesen in einen "StringBuilder" laden:
  $sb = New-Object System.Text.StringBuilder $text

  # alle Kommentare im Code in umgekehrter Reihenfolge finden
  # (letzter Kommentar zuerst):
  $comments = [System.Management.Automation.PSParser]::Tokenize($text, [ref]$null) |
    Where-Object { $_.Type -eq 'Comment' } |
    Sort-Object -Property Start -Descending |
    # alle Textstellen im Editor entfernen
    ForEach-Object {
        $sb.Remove($_.Start, $_.Length)

    }

    # Aktualisierten Text in Editor ersetzen:
    $psISE.CurrentFile.Editor.Text = $sb.toString()
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.17.ps1
************************************************************************
function Remove-ISEAlias
{
  # Inhalt des aktuellen Skripts im ISE-Editor lesen:
  $text = $psISE.CurrentFile.Editor.Text

  # für die schnelle Bearbeitung des Textes diesen in einen "StringBuilder" laden:
  $sb = New-Object System.Text.StringBuilder $text

  # alle Befehle im Code in umgekehrter Reihenfolge finden
  # (letzter Befehl zuerst):
  $befehle = [System.Management.Automation.PSParser]::Tokenize($text, [ref]$null) |
    Where-Object { $_.Type -eq 'Command' } |
    Sort-Object -Property Start -Descending |
      # alle Aliase auflösen
      ForEach-Object {
        $befehl = $text.Substring($_.Start, $_.Length)
        $befehlstyp = @(try {Get-Command $befehl -ErrorAction 0} catch {})[0]

        if ($befehlstyp -is [System.Management.Automation.AliasInfo])
        {
          $sb.Remove($_.Start, $_.Length)
          $sb.Insert($_.Start+1, $befehlstyp.ResolvedCommandName)
        }

    # Aktualisierten Text in Editor ersetzen:
    $psISE.CurrentFile.Editor.Text = $sb.toString()
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.18.ps1
************************************************************************
function Test-Script
{
  param
  (
    [Parameter(Mandatory=$true, ValueFromPipeline=$true,
     ValueFromPipelineByPropertyName=$true)]
    [String]
    [Alias('FullName')]
    $Path
  )
  
  process
  {
    $Errors = $null
    $exists = Test-Path -Path $Path
    if ($exists)
    {
      $text = Get-Content -Path $Path -Raw
      if ($text -eq $null) { $text = '' }
      $null = [System.Management.Automation.PSParser]::Tokenize($text, [ref]$Errors)
      $Message = ''
      if ($Errors.Count -gt 0)
      {
        $Message = $errors[0].Message
      }
      $result = [Ordered]@{
        Path = $Path
        Error = $Errors.Count -gt 0
        Message = $Message
        Errors = $Errors
      }

      New-Object -TypeName PSObject -Property $result   
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.19.ps1
************************************************************************
function Get-Ast
{

  param
  (
    [ValidateSet('All','Array','ArrayLiteral','AssignmentStatement','Attribute',
        'AttributeBase','Attributed','Binary','BlockStatement','BreakStatement',
        'CatchClause','Command','CommandBase','CommandElement','CommandParameter',
        'Constant','ContinueStatement','Convert','DataStatement','DoUntilStatement',
        'DoWhileStatement','Error','ErrorStatement','ExitStatement','ExpandableString',
        'FileRedirection','ForEachStatement','ForStatement','FunctionDefinition',
        'Hashtable','IfStatement','Index','InvokeMember','LabeledStatement',
        'LoopStatement','Member','MergingRedirection','NamedAttributeArgument',
        'NamedBlock','ParamBlock','Parameter','Paren','Pipeline','PipelineBase',
        'Redirection','ReturnStatement','ScriptBlock','SequencePoint','Statement',
        'StatementBlock','StringConstant','Sub','SwitchStatement','ThrowStatement',
        'TrapStatement','TryStatement','Type','TypeConstraint','Unary',
        'Using','Variable','WhileStatement')]
    $AstType='All',
    
    [String]
    $Code = $psise.CurrentFile.Editor.Text,
        
    [Switch]
    $NonRecurse,
        
    [System.Management.Automation.Language.Ast]
    $Parent=$null
  )

  # provide buckets for errors and tokens
  $Errors = $Tokens = $null

  # ask PowerShell to parse code
  $AST = [System.Management.Automation.Language.Parser]::ParseInput($Code, [ref]$Tokens, [ref]$Errors)

  [bool]$recurse = $NonRecurse.IsPresent -eq $false

  # search for AST instances recursively
  if ($AstType -eq 'All')
  {
    $AST.FindAll({ $true }, $recurse) | 
      Where-Object { $Parent -eq $null -or 
      ($_.Extent.StartOffset -ge $Parent.Extent.StartOffset -and
      $_.Extent.EndOffset -le $Parent.Extent.EndOffset) } |
      Add-Member -Member ScriptProperty -Na ASTType -Value { $this.GetType().Name } -Pa
  }
  else
  {
    $AST.FindAll({ $args[0].GetType().Name -like "*$ASTType*Ast" }, $recurse) | 
    Where-Object { $Parent -eq $null -or 
      ($_.Extent.StartOffset -ge $Parent.Extent.StartOffset -and 
    $_.Extent.EndOffset -le $Parent.Extent.EndOffset) } |
      Add-Member -Member ScriptProperty -Na ASTType -Value { $this.GetType().Name } -Pa
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.2.ps1
************************************************************************
$Path = $profile.CurrentUserAllHosts
$exists = Test-Path -Path $Path

# Profildatei nur anlegen, wenn sie noch nicht existiert
# -Force legt auch alle fehlenden Unterordner mit an:
if ($exists -eq $false)
{
    $null = New-Item -Path $path -ItemType File -Force
}

# Profildatei im ISE-Editor öffnen
ise $Path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.3.ps1
************************************************************************
Set-Alias -Name Gerätemanager -Value devmgmt.msc
Set-Alias -Name Systemsteuerug -Value control
Set-Alias -Name ie -Value 'C:\Program Files\Internet Explorer\iexplore.exe'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.4.ps1
************************************************************************
if([System.Windows.Input.Keyboard]::IsKeyDown('Ctrl') -eq $true) 
{ 
  Set-StrictMode -Version Latest
  $DebugPreference = 'Continue'
  $VerbosePreference = 'Continue'
  Write-Debug 'Debug-Mode aktiviert.'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.5.ps1
************************************************************************
function prompt
{
    'PS> '
    $host.UI.RawUI.WindowTitle = Get-Location
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.6.ps1
************************************************************************
function prompt
{
  $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
  $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  $isAdmin = $prp.IsInRole($adm) 
  
  if ($isAdmin)
  {
    Write-Host '[ADMIN]' -ForegroundColor Red -NoNewline
  }
  else
  {
    Write-Host '[NONADMIN]' -ForegroundColor Green -NoNewline
  }
  
  # immer mindestens ein Zeichen ausgeben 
  'PS> '
  $host.UI.RawUI.WindowTitle = Get-Location
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.7.ps1
************************************************************************
# häufig verwendete Editor-Einstellungen:
$psISE.Options.AutoSaveMinuteInterval = 1
$psISE.Options.IntelliSenseTimeoutInSeconds = 1
$psISE.Options.ShowWarningBeforeSavingOnRun = $false
$psISE.Options.Zoom = 100

# Liste zuletzt geöffneter Skriptdateien im Menü "Datei" löschen:
$psISE.Options.MruCount = 0
$psISE.Options.MruCount = 15

# Farben der Token für "Variablen" in der Konsole auf vordefinierte Farbe setzen:
$psISE.Options.ConsoleTokenColors['Variable'] = 'Red'
# Farben der Token für "Variablen" im Editor auf selbstdefinierte Farbe setzen:
$psISE.Options.TokenColors['Variable'] = '#90FF1012'

# Farben der Standardfehlermeldungen ändern
$psISE.Options.ErrorBackgroundColor = 'White'
$psISE.Options.ErrorForegroundColor = 'Red'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.8.ps1
************************************************************************
$Autor = '[Ihr Name]'
$Datum = Get-Date -Format 'yyyy-MM-dd'

$text = @"
########################
#
# Autor:   $Autor
# Version: 1.0
# Datum:   $datum
#
########################


"@

$file = $psise.CurrentPowerShellTab.Files.Add()
$file.Editor.Text = $text

# Cursorposition an den Anfang und dann an das
# Ende setzen, damit das Skript vollständig zu sehen ist:
$file.Editor.SetCaretPosition(1,1)
$file.Editor.SetCaretPosition($file.Editor.LineCount,1)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\33.9.ps1
************************************************************************
function Get-ScriptVariable
{
  # Inhalt des aktuellen Skripts im ISE-Editor lesen:
  $text = $psISE.CurrentFile.Editor.Text

  # alle Variablen im Code in finden
  [System.Management.Automation.PSParser]::Tokenize($text, [ref]$null) |
  Where-Object { $_.Type -eq 'Variable' } |
  Select-Object -ExpandProperty Content |
  Sort-Object -Unique
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.1.ps1
************************************************************************
$code = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'

$type = Add-Type -MemberDefinition $code -Name NativeMethods -namespace Win32 -PassThru



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.10.ps1
************************************************************************
#requires -Version 3

$code = @'
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
namespace AppManager
{
  public enum ShowStates
  {
    Hide,
    Normal,
    Minimized,
    Maximized,
    ShowNoActivateRecentPosition,
    Show,
    MinimizeActivateNext,
    MinimizeNoActivate,
    ShowNoActivate,
    Restore,
    ShowDefault,
    ForceMinimize
  }

  public class AppInstance : System.Diagnostics.Process
  {
    [DllImport("User32")]
    private static extern int ShowWindow(IntPtr hwnd, ShowStates nCmdShow);
    [DllImport("User32.dll")]
    public static extern IntPtr FindWindowEx(IntPtr parent, IntPtr childAfter, string className, string windowName);
    [DllImport("user32.dll")]
    private static extern int GetWindowThreadProcessId(IntPtr hWnd, out int ProcessId);
    [DllImport("user32.dll")]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

    public IntPtr WindowHandle;
    

    public AppInstance(string Name, bool Hidden) : this(Name, ProcessWindowStyle.Hidden)
    {
      if (Hidden == false) this.Show();
    }

    public AppInstance(string Name, ProcessWindowStyle WindowStyle) : base()
    {
      this.StartInfo.FileName = Name;
      this.StartInfo.WorkingDirectory = Environment.CurrentDirectory;
      this.StartInfo.WindowStyle = WindowStyle;
      this.Start();
      this.WaitForInputIdle();
      this.WindowHandle = this.MainWindowHandle;
      
      if (this.WindowHandle == IntPtr.Zero)
      {
        this.WindowHandle = FindWindow(this.Id);
      }
    }

    public AppInstance(string Name) : this(Name, ProcessWindowStyle.Normal) { }

    public void Show()
    {
      ShowWindow(this.WindowHandle, ShowStates.ShowDefault);
    }

    public void Minimize()
    {
      ShowWindow(this.WindowHandle, ShowStates.ForceMinimize);
    }

    public void Maximize()
    {
      ShowWindow(this.WindowHandle, ShowStates.Maximized);
    }

    public void Hide()
    {
      ShowWindow(this.WindowHandle, ShowStates.Hide);
    }

    public void SetWindowStyle(ShowStates WindowStyle)
    {
      ShowWindow(this.WindowHandle, WindowStyle);
    }

    public void Topmost(bool ShowTopmost = true)
    {
      IntPtr flag = new IntPtr(-2);
      if (ShowTopmost)
      {
        flag = new IntPtr(-1);
      }
      SetWindowPos(this.WindowHandle, flag, 0, 0, 0, 0, 3);
    }

    public void Stop()
    {
      this.Kill();
    }

    
    public void Close(int Timeout = 0)
    {
      this.CloseMainWindow();
      if (Timeout > 0)
      {
        this.WaitForExit(Timeout * 1000);
        if (this.HasExited == false)
        {
          this.Stop();
        }
      }
    }

    private IntPtr FindWindow(int Pid)
    {
      IntPtr h = IntPtr.Zero;
      int tid;
      int pid;
      
      do
      {
        pid = 0;
        h = FindWindowEx(IntPtr.Zero, h, null, null);
        tid = GetWindowThreadProcessId(h, out pid);
        if (pid == Pid)
        {
          break;
        }
      } while (!h.Equals(IntPtr.Zero));
      
      return h;
    }
  } 
}
'@

Add-Type -TypeDefinition $code



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.11.ps1
************************************************************************
# Prozess unsichtbar starten
$prozess = New-Object -TypeName AppManager.AppInstance('notepad.exe', $true)

# etwas warten
Start-Sleep -Seconds 2

# Prozess anzeigen und maximieren
$prozess.Maximize()



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.2.ps1
************************************************************************
$code = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
$type = Add-Type -MemberDefinition $code -Name NativeMethods -namespace Win32 -PassThru

# auf den PowerShell-Prozess zugreifen:
$process = Get-Process -Id $PID
# dessen Window-Handle erfragen:
$hwnd = $process.MainWindowHandle

# Fenster vorübergehend verstecken:
$type::ShowWindowAsync($hwnd, 0)

Start-Sleep -Seconds 2

# Fenster wiederherstellen:
$type::ShowWindowAsync($hwnd, 9)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.3.ps1
************************************************************************
#requires -Version 5

Enum ShowStates
{
  Hide                               = 0
  Normal                             = 1
  Minimized                          = 2
  Maximized                          = 3
  ShowNoActivateRecentPosition       = 4
  Show                               = 5
  MinimizeActivateNext               = 6
  MinimizeNoActivate                 = 7
  ShowNoActivate                     = 8
  Restore                            = 9
  ShowDefault                        = 10
  ForceMinimize                      = 11
}

function Set-Window
{
  param
  (
    [System.Diagnostics.Process]
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    $Process,
  
    [ShowStates]
    $Window = [ShowStates]::Normal
  )
  
  begin
  {
    $code = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
    $type = Add-Type -MemberDefinition $code -Name NativeMethods -namespace Win32 -PassThru
  }
  
  process
  {
    if ($process.MainWindowHandle -eq 0)
    {
      Write-Warning "Process $process has no window."
    }
    else
    {
      $type::ShowWindowAsync($process.MainWindowHandle, $Window)
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.4.ps1
************************************************************************
# im ISE-Editor ausführen!

Import-Module -Name NetTCPIP
$base = (Get-Module -Name NetTCPIP).ModuleBase
$path = Join-Path -Path $base -ChildPath 'Test-NetConnection.psm1'

$file = $psise.CurrentPowerShellTab.Files.Add()
$file.Editor.Text = Get-Content -Path $path -Raw
$file.Editor.SetCaretPosition(1,1)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.5.ps1
************************************************************************
class TestNetConnectionResult
{
    [string] $ComputerName

    #The Remote IP address used for connectivity
    [System.Net.IPAddress] $RemoteAddress

    #Indicates if the Ping was successful
    [bool] $PingSucceeded

    #Details of the ping
    [System.Net.NetworkInformation.PingReply] $PingReplyDetails

    #The TCP socket
    [System.Net.Sockets.Socket] $TcpClientSocket

    #If the test succeeded
    [bool] $TcpTestSucceeded

    #Remote port used
    [uint32] $RemotePort

    #The results of the traceroute
    [string[]] $TraceRoute

    #An indicator to the formatter that details should be shown
    [bool] $Detailed

    #Information on the interface used for connectivity
    [string] $InterfaceAlias
    [uint32] $InterfaceIndex
    [string] $InterfaceDescription
    [Microsoft.Management.Infrastructure.CimInstance] $NetAdapter
    [Microsoft.Management.Infrastructure.CimInstance] $NetRoute

    #Source IP address
    [Microsoft.Management.Infrastructure.CimInstance] $SourceAddress

    #DNS information
    [bool] $NameResolutionSucceeded
    [object] $BasicNameResolution
    [object] $LLMNRNetbiosRecords
    [object] $DNSOnlyRecords
    [object] $AllNameResolutionResults

    #NetSec Info
    [bool] $IsAdmin #If the test succeeded
    [string] $NetworkIsolationContext
    [Microsoft.Management.Infrastructure.CimInstance[]] $MatchingIPsecRules
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.6.ps1
************************************************************************
#requires -Version 5


class AppInstance 
{    
  # öffentliche Eigenschaften:
  [string]$Name 
  [System.Diagnostics.Process]$process

  # versteckte Eigenschaften:
  hidden [IntPtr]$hWnd 
    
  # Konstruktor (wird beim Anlegen einer Instanz dieser Klasse aufgerufen)
  AppInstance([string]$Name) 
  {
    $this.Name = $Name
    $this.process = Start-Process $this.Name -PassThru
    
    # warten, bis die Anwendung vollständig gestartet ist
    $this.process.WaitForInputIdle()
    $this.hWnd = $this.process.MainWindowHandle
  }

  [void]Stop() 
  {
    $this.process.Kill()
  }
  
  [void]Close([Int]$Timeout = 0) 
  {
    # Aufforderung zum Schließen senden:
    $this.process.CloseMainWindow()
    
    # Auf Erfolg warten:
    if ($Timeout -gt 0)
    {
      $null = $this.process.WaitForExit($Timeout * 1000)
    }
    
    # falls Prozess immer noch läuft, sofort beenden
    if ($this.process.HasExited -eq $false)
    {
      $this.Stop()
    }
  }
  
  [void]SetPriority([System.Diagnostics.ProcessPriorityClass] $Priority)
  {
    $this.process.PriorityClass = $Priority
  }
  
  [System.Diagnostics.ProcessPriorityClass]GetPriority()
  {
    if ($this.process.HasExited -eq $false)
    {
      return $this.process.PriorityClass 
    }
    else
    {
      Throw "Prozess mit PID $($this.process.Id) wird nicht mehr ausgeführt."
    }
  }

  static [System.Diagnostics.Process[]] GetAllProcesses()
  {
    return [AppInstance]::GetAllProcesses($false)
  }

  static [System.Diagnostics.Process[]] GetAllProcesses([bool]$All)
  {
    if ($All)
    {
      return Get-Process
    }
    else
    {
      return Get-Process | Where-Object { $_.MainWindowHandle -ne 0 }
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.7.ps1
************************************************************************
#requires -Version 5


class AppInstance : System.Diagnostics.Process
{    
    
  # Konstruktor (wird beim Anlegen einer Instanz dieser Klasse aufgerufen)
  AppInstance([string]$Name) : base()
  {
    
    $this.StartInfo.FileName = $Name
    $this.Start()
    
    # warten, bis die Anwendung vollständig gestartet ist
    $this.WaitForInputIdle()
  }

  [void]Stop() 
  {
    $this.Kill()
  }
  
  [void]Close([Int]$Timeout = 0) 
  {
    # Aufforderung zum Schließen senden:
    $this.CloseMainWindow()
    
    # Auf Erfolg warten:
    if ($Timeout -gt 0)
    {
      $null = $this.WaitForExit($Timeout * 1000)
    }
    
    # falls Prozess immer noch läuft, sofort beenden
    if ($this.HasExited -eq $false)
    {
      $this.Stop()
    }
  }
  
  [void]SetPriority([System.Diagnostics.ProcessPriorityClass] $Priority)
  {
    $this.PriorityClass = $Priority
  }
  
  [System.Diagnostics.ProcessPriorityClass]GetPriority()
  {
    if ($this.HasExited -eq $false)
    {
      return $this.PriorityClass 
    }
    else
    {
      Throw "Prozess mit PID $($this.Id) wird nicht mehr ausgeführt."
    }
  }

  static [System.Diagnostics.Process[]] GetAllProcesses()
  {
    return [AppInstance]::GetAllProcesses($false)
  }
  static [System.Diagnostics.Process[]] GetAllProcesses([bool]$All)
  {
    if ($All)
    {
      return Get-Process
    }
    else
    {
      return Get-Process | Where-Object { $_.MainWindowHandle -ne 0 }
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.8.ps1
************************************************************************
class MyWebClient : System.Net.WebClient
{
  MyWebClient() : base() 
  {
    # bei SSL-Zertifikatfehlern trotzdem Webseite ansprechen
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
    
    $proxy = [System.Net.WebRequest]::GetSystemWebProxy()
    $proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
    $this.Proxy = $proxy
    $this.UseDefaultCredentials = $true
    $this.Proxy.Credentials = $this.Credentials
  }
}

$client = New-Object -TypeName MyWebClient
$client.DownloadString('http://www.tagesschau.de')



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\34.9.ps1
************************************************************************
#requires -Version 5
Enum ShowStates
{
  Hide                               = 0
  Normal                             = 1
  Minimized                          = 2
  Maximized                          = 3
  ShowNoActivateRecentPosition       = 4
  Show                               = 5
  MinimizeActivateNext               = 6
  MinimizeNoActivate                 = 7
  ShowNoActivate                     = 8
  Restore                            = 9
  ShowDefault                        = 10
  ForceMinimize                      = 11
}

function Set-Window
{
  [CmdletBinding(DefaultParameterSetName='WindowStyle')]
  param
  (
    [System.Diagnostics.Process]
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    $Process,
  
    [Parameter(ParameterSetName='WindowStyle', Mandatory=$true)]
    [ShowStates]
    $Window = [ShowStates]::Normal,

    [Parameter(ParameterSetName='TopMost', Mandatory=$true)]
    [Switch]
    $TopMost

  )
  
  begin
  {
    $code = @'
[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
[DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

'@
    $type = Add-Type -MemberDefinition $code -Name API -namespace Win32 -PassThru
  }
  
  process
  {
    if ($process.MainWindowHandle -eq 0)
    {
      Write-Warning "Process $process has no window."
    }
    else
    {
      if ($PSCmdlet.ParameterSetName -eq 'TopMost')
      {
        if ($TopMost.IsPresent)
        {
          $flag = New-Object -TypeName IntPtr(-1)
        }
        else
        {
          $flag = New-Object -TypeName IntPtr(-2)          
        }
        $type::SetWindowPos($process.MainWindowHandle, $flag, 0, 0, 0, 0, 3)
      }
      else
      {
        $type::ShowWindowAsync($process.MainWindowHandle, $Window)
      }
    }
  }
}


class AppInstance : System.Diagnostics.Process
{    
    
  # Konstruktor (wird beim Anlegen einer Instanz dieser Klasse aufgerufen)
  AppInstance([string]$Name, [System.Diagnostics.ProcessWindowStyle]$Window) : base()
  {
    $this.initialize($Name, $Window)
    $this.Hide()
  }
  
  AppInstance([string]$Name, [bool]$Hidden) : base()
  {
    if ($Hidden)
    {
      $this.initialize($Name, [System.Diagnostics.ProcessWindowStyle]::Minimized)
      $this.Hide()
    }
    else
    {
      $this.Initialize($Name, [System.Diagnostics.ProcessWindowStyle]::Normal)
    }
  }

  AppInstance([string]$Name) : base()
  {
    $this.Initialize($Name, [System.Diagnostics.ProcessWindowStyle]::Normal) 
  }
  
  hidden [void]Initialize([string]$Name, [System.Diagnostics.ProcessWindowStyle]$Window)
  {
    $this.StartInfo.FileName = $Name
    $this.Start()
    
    # warten, bis die Anwendung vollständig gestartet ist
    $this.WaitForInputIdle()
  }
  

  [void]Show() 
  {
    Set-Window -Process $this -Window ([ShowStates]::ShowDefault)
  }

  [void]Minimize() 
  {
    Set-Window -Process $this -Window ([ShowStates]::ForceMinimize)
  }
  
  [void]Maximize() 
  {
    Set-Window -Process $this -Window ([ShowStates]::Maximized)
  }
  
  [void]Hide() 
  {
    Set-Window -Process $this -Window ([ShowStates]::Hide)
  }

  [void]TopMost() 
  {
    Set-Window -Process $this -TopMost
  }

  [void]TopMost([bool]$ShowTopmost) 
  {
    Set-Window -Process $this -TopMost:$ShowTopmost
  }

  [void]Stop() 
  {
    $this.Kill()
  }
  
  [void]Close([Int]$Timeout = 0) 
  {
    # Aufforderung zum Schließen senden:
    $this.CloseMainWindow()
    
    # Auf Erfolg warten:
    if ($Timeout -gt 0)
    {
      $null = $this.WaitForExit($Timeout * 1000)
    }
    
    # falls Prozess immer noch läuft, sofort beenden
    if ($this.HasExited -eq $false)
    {
      $this.Stop()
    }
  }
  
  [void]SetPriority([System.Diagnostics.ProcessPriorityClass] $Priority)
  {
    $this.PriorityClass = $Priority
  }
  
  [System.Diagnostics.ProcessPriorityClass]GetPriority()
  {
    if ($this.HasExited -eq $false)
    {
      return $this.PriorityClass 
    }
    else
    {
      Throw "Prozess mit PID $($this.Id) wird nicht mehr ausgeführt."
    }
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\4.1.ps1
************************************************************************
# sicherstellen, dass eine versteckte ISE Konsole vorhanden ist:
$null = cmd.exe /c echo

# Konsolen-Encoding korrigieren:
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# deutsche Umlaute erscheinen korrekt:
systeminfo.exe /FO CSV | ConvertFrom-CSV | Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\4.2.ps1
************************************************************************
Get-WmiObject -Class Win32_Process | Foreach-Object {
    $owner = $_.GetOwner()
    if ($owner.ReturnValue -eq 0)
    {
        $owner = '{0}\{1}' -f $owner.Domain, $owner.User
    }
    else
    {
        $owner = $null
    }
    $_ | Add-Member -MemberType NoteProperty -Name Owner -Value $owner -PassThru
} | Select-Object -Property Name, Owner, ProcessId |
Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\4.3.ps1
************************************************************************
#requires -Version 1
$name = 'notepad'
$prozesse = Get-Process -Name $name -ErrorAction SilentlyContinue
$anzahl = $prozesse.Count 
$läuft = $anzahl -gt 0

if ($läuft)
{
  "Es werden $anzahl Instanzen von $name ausgeführt."
}
else
{
  "$name läuft nicht."
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\4.4.ps1
************************************************************************
#requires -Version 2

# auf Microsoft Excel warten:
Wait-Process -Name excel -Timeout 10 -ErrorAction SilentlyContinue -ErrorVariable err

# Fehlermeldung auswerten:
if ($err.FullyQualifiedErrorId -eq 'ProcessNotTerminated,Microsoft.PowerShell.Commands.WaitProcessCommand')
{
  'Excel läuft immer noch.'
}
elseif ($err.FullyQualifiedErrorId -eq 'NoProcessFoundForGivenName,Microsoft.PowerShell.Commands.WaitProcessCommand')
{
  'Excel lief gar nicht.'
}
else
{
  'Excel wurde beendet.'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\4.5.ps1
************************************************************************
#requires -Version 1

# Priorität verringern
$prozess = Get-Process -id $pid
$prozess.PriorityClass = 'BelowNormal'

$liste = Get-ChildItem -Path $env:windir -Filter *.log -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Fullname

# Priorität wiederherstellen
$prozess.PriorityClass = 'Normal'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.1.ps1
************************************************************************
$geburtstag = Read-Host 'Wie lautet Ihr Geburtsdatum?'
$alter = New-TimeSpan $geburtstag
$alter
$tage = $alter.Days
"Sie sind $tage Tage alt!"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.10.ps1
************************************************************************
# Liste der Thumbprints von vertrauenswürdigen Zertifikaten:
$WhiteList = @('D10858D99CD176979DF793E4AD37A5639CB8D9D5', '6262A18EC19996DD521F7BDEAA0E079544B84241')

# Alle PowerShell Skripts im Benutzerprofil finden...
Get-ChildItem -Path $HOME -Filter *.ps1 -Include *.ps1 -Recurse -ErrorAction SilentlyContinue  |
  # zu kleine Dateien ausschließen (Signaturen erfordern Mindestlänge)
  Where-Object { $_.Length -gt 10 } |
  # Signatur lesen
  Get-AuthenticodeSignature |
  # nur ungültige Signaturen anzeigen
  Where-Object { 
    $ok = ($_.Status -eq 'Valid') -or ($_.Status -eq 'UnknownError' -and $WhiteList -contains $_.SignerCertificate.Thumbprint) 
    !$ok
  } |
  Select-Object -Property Path, Status, StatusMessage |
  Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.2.ps1
************************************************************************
$Path = $profile.CurrentUserAllHosts
$vorhanden = Test-Path -Path $Path

if (-not $vorhanden)
{
    $null = New-Item -Path $Path -ItemType File -Force
}
ise $Path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.3.ps1
************************************************************************
function prompt
{
  'PS> '
  $Host.UI.RawUI.WindowTitle = Get-Location
}

$Host.PrivateData.ErrorBackgroundColor = 'White'
$MaximumHistoryCount = 30KB



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.4.ps1
************************************************************************
#requires -Version 5

$Path = "$env:temp\zertifikat.pfx"
$Password = Read-Host -Prompt 'Kennwort für Zertifikat' -AsSecureString

# Zertifikat anlegen:
$cert = New-SelfSignedCertificate -KeyUsage DigitalSignature -KeySpec Signature -FriendlyName 'IT Sicherheit' -Subject CN=Sicherheitsabteilung -KeyExportPolicy ExportableEncrypted -CertStoreLocation Cert:\CurrentUser\My -NotAfter (Get-Date).AddYears(5) -TextExtension @('2.5.29.37={text}1.3.6.1.5.5.7.3.3')

# Zertifikat in Datei exportieren:
$cert | Export-PfxCertificate -Password $Password -FilePath $Path 

# Zertifikat aus Speicher löschen:
$cert | Remove-Item



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.5.ps1
************************************************************************
# Achtung: benötigt die Funktion New-SelfsignedCertificateEx 
# Bezugsquelle: https://gallery.technet.microsoft.com/scriptcenter/Self-signed-certificate-5920a7c6

$Path = "$env:temp\zertifikat.pfx"
$Password = Read-Host -Prompt 'Kennwort für Zertifikat' -AsSecureString

New-SelfsignedCertificateEx -Exportable  -Path $path -Password $password -Subject 'CN=Sicherheitsabteilung' -EKU '1.3.6.1.5.5.7.3.3' -KeySpec 'Signature' -KeyUsage 'DigitalSignature' -FriendlyName 'IT Sicherheit' -NotAfter (Get-Date).AddYears(5)



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.6.ps1
************************************************************************
# Zertifikat aus pfx-Datei laden
$path = "$env:temp\zertifikat.pfx"
$cert = Get-PfxCertificate -FilePath $Path

$cert



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.7.ps1
************************************************************************
function Get-CodesigningCertificate
{
  param
  (
    $titel = 'Verfügbare Identitäten',

    $text = 'Bitte Zertifikat für Signatur auswählen'
  )

  # Zertifikate ermitteln:
  # hier anpassen und mit Where-Object ergänzen,
  # falls nur bestimmte Zertifikate angezeigt werden sollen:
  $zertifikate = Get-ChildItem cert:\currentuser\my -Codesigning

  # Zertifikatcontainer beschaffen und füllen:
  Add-Type -AssemblyName System.Security
  $container = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
  $container.AddRange($zertifikate)

  # Auswahlfeld anzeigen:
  [System.Security.Cryptography.x509Certificates.X509Certificate2UI]::SelectFromCollection($container, $titel, $text, 0)
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.8.ps1
************************************************************************
# $cert muss bereits ein gültiges digitales Zertifikat enthalten (siehe Buch)
# entfernen Sie -whatIf, um die Signaturen tatsächlich einzufügen

Get-ChildItem -Path $HOME -Filter *.ps1 -Include *.ps1 -Recurse | 
Where-Object { 
  ($_ | Get-AuthenticodeSignature).Status -eq 'NotSigned'
} |
Set-AuthenticodeSignature -Certificate $cert -WhatIf



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\5.9.ps1
************************************************************************
Get-ChildItem -Path $HOME -Filter *.ps1 -Recurse  |
  Get-AuthenticodeSignature |
  Where-Object { 'Valid', 'UnknownError' -notcontains $_.Status } |
  Select-Object -Property Path, Status, StatusMessage |
  Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.1.ps1
************************************************************************
$hotfixes = Get-HotFix

foreach($hotfix in $hotfixes)
{
    if ($hotfix.HotFixID -like 'KB30*')
    {
        $hotfix
    }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.10.ps1
************************************************************************
$ergebnis = Get-Service | Group-Object -Property Status -AsHashTable -AsString

# alle laufenden Dienste abrufen
$ergebnis.Running

# alle gestoppten Dienste abrufen
$ergebnis.Stopped



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.11.ps1
************************************************************************
Get-ChildItem -Path $HOME -File -Recurse -Force -ErrorAction Ignore | ForEach-Object -Begin { $i=0 } -Process { $i+=$_.Length } -End { [Math]::Round( ($i/1MB), 1) }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.12.ps1
************************************************************************
#requires -Version 3

# Hashtable erstellen und Spaltendefinition festlegen:
$LängeMB = @{}
$LängeMB.Name='Length (MB)'
$LängeMB.Expression=
{ 
  # Wenn das Objekt kein Ordner ist...
  If ($_.PSIsContainer -eq $false) 
  { 
    # ...Length als MB ausgeben:
    '{0:0.00} MB' -f ($_.Length/1MB) 
  } 
} 

Get-ChildItem -Path $env:windir -File | 
  Select-Object -Property Mode, LastWriteTime, $LängeMB, Name



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.13.ps1
************************************************************************
$kriterium1 = @{Expression='Company'; Ascending=$true }
$kriterium2 = @{Expression='CPU'; Descending=$true }
Get-Process | Where-Object { $_.Company -ne $null } | Sort-Object $kriterium1, $kriterium2 | Select-Object Company, CPU



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.14.ps1
************************************************************************
# Klartextnamen für MemoryType
$memorytype = 'Unknown', 'Other', 'DRAM', 'Synchronous DRAM', 'Cache DRAM', 'EDO', 'EDRAM', 'VRAM', 'SRAM', 'RAM', 'ROM', 'Flash', 'EEPROM', 'FEPROM', 'EPROM', 'CDRAM', '3DRAM', 'SDRAM', 'SGRAM', 'RDRAM', 'DDR', 'DDR-2', 'DDR2 FB-DIMM', 'DDR3', 'FBD2'

# Klartextnamen für FormFactor
$formfactor = 'Unknown', 'Other', 'SIP', 'DIP', 'ZIP', 'SOJ', 'Proprietary', 'SIMM', 'DIMM', 'TSOP', 'PGA', 'RIMM', 'SODIMM', 'SRIMM', 'SMD', 'SSMP', 'QFP', 'TQFP', 'SOIC', 'LCC', 'PLCC', 'BGA', 'FPBGA', 'LGA'

# Berechnete Eigenschaften definieren:

# Capacity in Gigabyte umrechnen:
$spalte1 = @{Name='Größe (GB)'; Expression={ $_.Capacity/1GB } }

# FormFactor in Klartext umwandeln:
$spalte2 = @{Name='Bauart'; Expression={$formfactor[$_.FormFactor]} }

# MemoryType in Klartext umwandeln:
$spalte3 = @{Name='Speichertyp'; Expression={ $memorytype[$_.MemoryType] } }

Get-WmiObject Win32_PhysicalMemory | Select-Object PartNumber, $spalte1, $spalte2, $spalte3



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.15.ps1
************************************************************************
Get-Content $env:windir\windowsupdate.log -Encoding UTF8 |
    Where-Object { $_ -like '*successfully installed*' } |
    ForEach-Object { ($_ -split 'following update: ')[-1] }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.16.ps1
************************************************************************
$zeilen = Get-Content $env:windir\windowsupdate.log -Encoding UTF8 -ReadCount 0
foreach ($zeile in $zeilen)
{
 if ($zeile -like '*successfully installed*')
 { ($zeile -split 'following update: ')[-1] }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.2.ps1
************************************************************************
Get-Process | 
  Select-Object -Property ProcessName, Id | 
  Out-GridView -Title 'Prozess-ID Zuordnung'

Get-Process | 
  Select-Object -Property Name, Company, Description | 
  Out-GridView -Title 'Hersteller-Liste'

Get-Process | 
  Select-Object -Property Name, StartTime, CPU | 
  Out-GridView -Title 'Ressourcen-Ansicht'

Get-Process | 
  Select-Object -Property Name, *Time* | 
  Out-GridView -Title 'Zeitenübersicht'

Get-Process |
  Select-Object -Property * |
  Out-GridView -Title 'Alle Eigenschaften (max 30)'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.3.ps1
************************************************************************
$ergebnis = 1 | Select-Object -Property Name, BIOS, Datum
$ergebnis.Name = $env:COMPUTERNAME
$ergebnis.BIOS = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty Version
$ergebnis.Datum = Get-Date

$ergebnis | Out-GridView -Title 'System-Informationen'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.4.ps1
************************************************************************
$infos = systeminfo.exe /FO CSV | Select-Object -Skip 1
$einzelinfos = $infos -split '","'
$betriebssystem, $architektur = $einzelinfos[1,13]
"Sie betreiben $betriebssystem auf $architektur"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.5.ps1
************************************************************************
function Add-FromHistory
{
    $command = Get-History |
      Sort-Object -Property CommandLine -Unique |
      Sort-Object -Property ID -Descending |
      Select-Object -ExpandProperty CommandLine |
      Out-GridView -Title 'Wählen Sie einen Befehl!' -PassThru |
      Out-String

    $psISE.CurrentFile.Editor.InsertText($command)
}

try
{
$null = $pSISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('Aus Befehlshistorie einfügen', {Add-FromHistory},
'SHIFT+ALT+H')
} catch {}
Set-Alias -Name afh -Value Add-FromHistory -ErrorAction SilentlyContinue



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.6.ps1
************************************************************************
# Workaround für PowerShell Version 1,2,3,4:

Get-Process | 
  Select-Object -Property Name, Id |
  Format-Table -AutoSize

Get-Process | 
  Select-Object -Property Id |
  Format-Table -AutoSize



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.7.ps1
************************************************************************
Get-Service | 
  Select-Object -Property Name, DisplayName, Status |
  Out-Default

Get-Process | 
  Select-Object -Property Company, Name, Description |
  Out-Default  



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.8.ps1
************************************************************************
# Pipeline Streaming:
$ergebnis = Get-Service | Where-Object { $_.Status -eq 'Running' }

# klassischer Ansatz:
$liste = Get-Service
$ergebnis = foreach($element in $liste)
  {
    if ($element.Status -eq 'Running')
    {
      $element
    }
  }



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\6.9.ps1
************************************************************************
$liste = Get-Service
$liste.Where({$_.Status -eq 'Running'})



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.1.ps1
************************************************************************
$Path = "$env:temp\Fehlerreport.txt"

Get-EventLog -LogName System -EntryType Error -Newest 5 |
  Format-Table -AutoSize -Wrap |
  Out-File -FilePath $Path -Width 150

Invoke-Item -Path $Path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.10.ps1
************************************************************************
#requires -Version 2

# Daten als CSV serialisieren:
$Path = "$env:temp\prozesse.csv"
Get-Process | Export-CSV -Path $Path

# die Daten liegen nun als CSV-Datei vor
# der Computer könnte nun neu gestartet 
# oder die Daten könnten auf einen anderen
# Computer transferiert werden

# Daten aus CSV wiederherstellen:
$prozesse = Import-CSV -Path $Path 
$prozesse | Sort-Object CPU | Out-GridView

# Größe der Datei bestimmen:
$size = (Get-Item -Path $Path).Length
Write-Warning "Dateigröße: $size Bytes."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.11.ps1
************************************************************************
#requires -Version 2

# Daten als CSV serialisieren:
$Path = "$env:temp\prozesse.csv"
Get-Process | Select-Object -Property Handles, NPM, PM, WS, VM, CPU, Id, ProcessName | Export-CSV -Path $Path

# die Daten liegen nun als CSV-Datei vor
# der Computer könnte nun neu gestartet 
# oder die Daten könnten auf einen anderen
# Computer transferiert werden

# Daten aus CSV wiederherstellen:
$prozesse = Import-CSV -Path $Path 
$prozesse | Sort-Object CPU | Out-GridView

# Größe der Datei bestimmen:
$size = (Get-Item -Path $Path).Length
Write-Warning "Dateigröße: $size Bytes."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.12.ps1
************************************************************************
$path = "$env:temp\report.htm"
Get-Process | ConvertTo-Html Name, Company, CPU | Set-Content -Path $path -Encoding UTF8
Invoke-Item -Path $path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.13.ps1
************************************************************************
$path = "$env:temp\report.hta"

$style = @'
 <title>Laufende Prozesse</title>
 <style>
  body { background-color:#EEEEEE; }
  body,table,td,th { font-family:Tahoma; color:Black; Font-Size:10pt; padding: 15px; }
  th { font-weight:bold; background-color:#AAFFAA; text-align: left;}
  td { background-color:#EEFFEE; }
 </style>
'@

Get-Process | 
  ConvertTo-Html Name, Company, CPU -Head $style  | 
  Set-Content -Path $Path -Encoding UTF8

Invoke-Item -Path $Path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.2.ps1
************************************************************************
#requires -Version 1

$path = "$env:TEMP\data.txt"

Get-EventLog -LogName system -Newest 2 | 
  Format-Table -AutoSize -Wrap | 
  Export-Clixml -Path $path -Depth 5

notepad $path



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.3.ps1
************************************************************************
filter grep($stichwort) 
{
  # ist das Objekt ein Text?
  $noText = $_ -isnot [string]
  # falls nicht, muss das Objekt in Text umgewandelt werden
  if ($noText)
  {
    $text = $_ | 
    # ...sicherstellen, dass dabei keine Informationen abgeschnitten
    # werden, indem bis zu 5000 Zeichen lange Zeilen erlaubt werden:
    Format-Table -AutoSize | 
    Out-String -Width 5000 -Stream | 
    # die ersten drei Textzeilen verwerfen, die die Spaltenüberschriften
    # enthalten:
    Select-Object -Skip 3
  }
  else
  {
    # einlaufende Information war bereits Text:
    $text = $_
  }
  
  # Objekt herausfiltern, wenn das Stichwort nicht in seiner
  # Textrepräsentation gefunden wird
  # Dabei das Platzhalterzeichen "*" am Anfang und Ende des Stichworts
  # bereits vorgeben (sucht das Stichwort "irgendwo" im Text):
  $_ | Where-Object { $text -like "*$stichwort*" }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.4.ps1
************************************************************************
Get-Process -id $pid |
  Format-Table -AutoSize | 
  Out-String -Width 5000 -Stream | 
  Select-Object -Skip 3



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.5.ps1
************************************************************************
function Out-WinWord
{
  param
  (
    $Text = $null,
    $Title = $null,
    $Font = 'Courier',
    $FontSize = 12,
    $Width = 80,
    [Switch]$Print,
    [switch]$Landscape
  )

  if ($Text -eq $null)
  {
    $Text = $Input | Out-String -Width $Width
  }

  $WordObj = New-Object -ComObject Word.Application
  $document = $WordObj.Documents.Add()
  $document.PageSetup.Orientation = [Int][bool]$Landscape
  $document.Content.Text = $Text
  $document.Content.Font.Size = $FontSize
  $document.Content.Font.Name = $Font

  if ($Title -ne $null)
  {
    $WordObj.Selection.Font.Name = $Font
    $wordobj.Selection.Font.Size = 20
    $wordobj.Selection.TypeText($Title)
    $wordobj.Selection.ParagraphFormat.Alignment = 1
    $wordobj.Selection.TypeParagraph()
    $wordobj.Selection.TypeParagraph()
  }

  if ($Print)
  {
    $WordObj.PrintOut()
    $wdDoNotSaveChanges = 0
    $WordObj.NormalTemplate.Saved = $true
    $WordObj.Visible = $true
    $document.Close([ref]$wdDoNotSaveChanges)
    $WordObj.Quit([ref]$wdDoNotSaveChanges)
  }
  else
  {
    $WordObj.Visible = $true
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.6.ps1
************************************************************************
function Out-PDF
{
  param
  (
    $Path = "$env:TEMP\$(Get-Random).pdf",
    $Text = $null,
    $Title = $null,
    $Font = 'Courier',
    $FontSize = 12,
    $Width = 80,
    [Switch]$Open,
    [switch]$Landscape
  )

  if ($Text -eq $null)
  {
    $Text = $Input | Out-String -Width $Width
  }

  $WordObj = New-Object -ComObject Word.Application
  $document = $WordObj.Documents.Add()
  $document.PageSetup.Orientation = [Int][bool]$Landscape
  $document.Content.Text = $Text
  $document.Content.Font.Size = $FontSize
  $document.Content.Font.Name = $Font

  if ($Title -ne $null)
  {
    $WordObj.Selection.Font.Name = $Font
    $wordobj.Selection.Font.Size = 20
    $wordobj.Selection.TypeText($Title)
    $wordobj.Selection.ParagraphFormat.Alignment = 1
    $wordobj.Selection.TypeParagraph()
    $wordobj.Selection.TypeParagraph()
  }

  $saveaspath = [ref]$Path
  $formatPDF = [ref] 17
  $document.SaveAs($saveaspath,$formatPDF)
  $wdDoNotSaveChanges = 0
  $WordObj.NormalTemplate.Saved = $true
  $WordObj.Visible = $true
  $document.Close([ref]$wdDoNotSaveChanges)
  $WordObj.Quit([ref]$wdDoNotSaveChanges)

  if ($Open)
  {
    Invoke-Item -Path $Path
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.7.ps1
************************************************************************
function Out-ExcelReport
{
  param
  (
    $Path = "$env:TEMP\$(Get-Random).csv"
  )

  $Input | Export-Csv -Path $Path -Encoding UTF8 -NoTypeInformation -UseCulture
  Invoke-Item -Path $Path
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.8.ps1
************************************************************************
# Daten als XML serialisieren:
$Path = "$env:temp\prozesse.xml"
Get-Process | Select-Object Name, CPU | Export-Clixml $Path -Depth 1

# die Daten liegen nun als XML-Datei vor
# der Computer könnte nun neu gestartet 
# oder die Daten könnten auf einen anderen
# Computer transferiert werden

# Daten aus XML wiederherstellen:
$prozesse = Import-Clixml $Path
$prozesse | Sort-Object CPU | Out-GridView

# Größe der Datei bestimmen:
$size = (Get-Item -Path $Path).Length
Write-Warning "Dateigröße: $size Bytes."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\7.9.ps1
************************************************************************
#requires -Version 3

# Daten als JSON serialisieren:
$Path = "$env:temp\prozesse.json"
Get-Process | Select-Object Name, CPU | ConvertTo-Json -Depth 1 | Set-Content -Path $Path

# die Daten liegen nun als JSON-Datei vor
# der Computer könnte nun neu gestartet 
# oder die Daten könnten auf einen anderen
# Computer transferiert werden

# Daten aus JSON wiederherstellen:
$prozesse = Get-Content -Path $Path -Raw | ConvertFrom-Json 
$prozesse | Sort-Object CPU | Out-GridView

# Größe der Datei bestimmen:
$size = (Get-Item -Path $Path).Length
Write-Warning "Dateigröße: $size Bytes."



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\8.1.ps1
************************************************************************
$ProzessObjekt = Start-Process -FilePath notepad -PassThru
$ergebnis = $ProzessObjekt.WaitForExit(3000)
if ($ergebnis)
{
  'Prozess wurde innerhalb von 3 Sekunden beendet und läuft nicht mehr.'
}
else
{
  'Prozess wurde in den letzten 3 Sekunden nicht beendet und läuft noch.'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\8.2.ps1
************************************************************************
# gesamten Inhalt des Zertifikatspeichers auslesen
Get-ChildItem cert:\ -Recurse | 
# nur Zertifikate berücksichtigen 
Where-Object { 
  $_ -is [System.Security.Cryptography.X509Certificates.X509Certificate2] 
} | 
# nur abgelaufene Zertifikate
Where-Object {
  $_.NotAfter -lt (Get-Date)
} |
# nur Name und Ablaufdatum anzeigen
Select-Object -Property FriendlyName, NotAfter, Subject |
Out-GridView -Title 'Abgelaufene Zertifikate'



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\8.3.ps1
************************************************************************
# Inhalt des Windowsordners untersuchen
Get-ChildItem -Path $env:windir |
  # alle Eigenschaften finden
  Get-Member -MemberType *Property | 
  # die sich ändern lassen
  Where-Object { $_.Definition -like '*set;*' } | 
  Select-Object -Property * | 
  Sort-Object Name | 
  Out-GridView



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\8.4.ps1
************************************************************************
# Code muss in einer echten PowerShell-Konsole ausgeführt werden,
# nicht im ISE-Editor!

# Gesamten Inhalt der Eigenschaft "BufferSize" lesen:
PS> $bufferSize = $Host.UI.RawUI.BufferSize

# das Objekt auf die sichtbare Breite einstellen.
# dies allein bewirkt keine Änderung der Konsole:
PS> $bufferSize.Width = $Host.UI.RawUI.WindowSize.Width

# das geänderte Objekt wieder zurück in die Eigenschaft
# "Buffersize" schreiben. Jetzt ändert sich die Pufferbreite:
$Host.UI.RawUI.BufferSize = $bufferSize



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\8.5.ps1
************************************************************************
function Set-ConsoleWidth
{
  param
  (
    [Int]
    # gewünschte Breite der Konsole, optional
    # Vorgabe ist die sichtbare Breite:
    $Width = $Host.UI.RawUI.WindowSize.Width,

    [Switch]
    # automatisch Konsole so breit wie möglich machen
    $Maximum
  )

  # maximal mögliche Breite der Konsole:
  $maximumWidth = $Host.UI.RawUI.MaxPhysicalWindowSize.Width

  # aktuelle Breite der Konsole:
  $currentWindowWidth = $Host.UI.RawUI.WindowSize.Width

  # aktuelle Breite des Puffers:
  $currentBufferWidth = $Host.UI.RawUI.BufferSize.Width

  # maximale Breite gewünscht?
  if ($Maximum)
  {
    $Width = $maximumWidth
  }
  # Wunschbreite angegeben?
  elseif ($Width)
  {
    # falls größer als maximal erlaubt, begrenzen:
    if ($Width -gt $maximumWidth)
    {
      $Width = $maximumWidth
    }
  }

  # die Logik zum Anpassen des Buffers und des Fensters
  # sind interne Funktionen, weil diese je nach
  # aktuellen Werten in anderer Reihenfolge
  # aufgerufen werden müssen:
  function AdjustBuffer
  {
      # Konsolenpuffer auf neue Breite setzen:
      $buffer = $Host.UI.RawUI.BufferSize
      $buffer.Width = $Width
      $Host.UI.RawUI.BufferSize = $buffer
  }

  function AdjustWindow
  {
      # Sichtbaren Bereich anpassen
      $buffer = $Host.UI.RawUI.WindowSize
      $buffer.Width = $Width
      $Host.UI.RawUI.WindowSize = $buffer
  }

  # falls das Fenster aktuell GRÖSSER ist als die
  # neue gewünschte Breite, dann muss das Fenster
  # ZUERST verkleinert werden, bevor der Puffer
  # verkleinert werden darf:
  if ($currentWindowWidth -gt $Width)
  {
    AdjustWindow
    AdjustBuffer
  }
  # andernfalls umgekehrt:
  else
  {
    AdjustBuffer
    AdjustWindow
  }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\9.1.ps1
************************************************************************
$betrag = 300
$kurs = 1.04
$ergebnis = $betrag * $kurs

"$betrag USD zum Kurs von $kurs ergibt $ergebnis EUR"



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\9.2.ps1
************************************************************************
$ladezustand = Get-WmiObject -Class Win32_Battery |
  Measure-Object -Property EstimatedChargeRemaining -Average |
  Select-Object -ExpandProperty Average 

$alarm = $ladezustand -lt 10

if ($ladezustand -eq $null)
{
  'Kein Akku vorhanden.'
}
elseif ($alarm -eq $true)
{
  'Hier könnte eine Alarmmeldung oder Aktion stehen'
}
else
{
  'Alles in Ordnung.'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\9.3.ps1
************************************************************************
$datum = Get-Date
$stunde = $datum.Hour

$vormittag =  $stunde -gt 6 -and $stunde -lt 12
$mittag = $stunde -ge 12 -and $stunde -le 13
$nachmittag = $stunde -gt 13 -and $stunde -lt 18
$abend = $stunde -ge 18

if ($vormittag)
{
  'Guten Morgen!'
}
elseif ($mittag)
{
  'Guten Hunger!'
}
elseif ($nachmittag)
{
  'Bald ist Feierabend...!'
}
elseif ($abend)
{
  'bis morgen!'
}
else
{
  'Es herrscht Nacht...'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\9.4.ps1
************************************************************************
$datum = Get-Date
$stunde = $datum.Hour

if ($stunde -gt 6 -and $stunde -lt 12)
{
  'Guten Morgen!'
}
elseif ($stunde -ge 12 -and $stunde -le 13)
{
  'Guten Hunger!'
}
elseif ($stunde -gt 13 -and $stunde -lt 18)
{
  'Bald ist Feierabend...!'
}
elseif ($stunde -ge 18)
{
  'bis morgen!'
}
else
{
  'Es herrscht Nacht...'
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\9.5.ps1
************************************************************************
$datum = Get-Date
$stunde = $datum.Hour

Switch ($stunde)
{
  { $_ -gt 6 -and $_ -lt 12 }  { 'Guten Morgen!' }
  { $_ -ge 12 -and $_ -le 13 } { 'Guten Hunger!' }
  { $_ -gt 13 -and $_ -lt 18 } { 'Bald ist Feierabend...!' }
  { $_ -ge 18 }                { 'bis morgen!' }
  default                      { 'Es herrscht Nacht...' }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\9.6.ps1
************************************************************************
$errorcode = Get-Random -Maximum 10

switch ($errorcode)
{
  0            { 'OK.' }
  1            { 'Keine Holzkohle' }
  2            { 'Grillanzünder nicht vorhanden' }
  5            { 'Bratwurst not found'}
  7            { 'Gluttemperatur zu niedrig'}
  default      { "Unbekannte Fehlernummer $_" }
}



c:\users\rocky\desktop\powershell books examples\tobias - windows-automation fur einsteiger und profis\9.7.ps1
************************************************************************
$info = @{
  0 = 'OK.'
  1 = 'Keine Holzkohle' 
  2 = 'Grillanzünder nicht vorhanden' 
  5 = 'Bratwurst not found'
  7 = 'Gluttemperatur zu niedrig'
 }

$errorcode = Get-Random -Maximum 10
if ($info.ContainsKey($errorcode) -eq $false)
{
  "Unbekannter Fehler $errorcode"
}
else
{
  $info[$errorcode]
}


