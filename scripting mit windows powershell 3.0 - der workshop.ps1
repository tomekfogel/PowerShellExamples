
c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k1 intro\Scripts\install_help.ps1
************************************************************************
﻿# requires full administrative permissions
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k10 Objekte verstehen\Skripts\compare_filelist.ps1
************************************************************************
﻿$server1 = '\\storage1'
$server2 = '\\powershellpc'

$fileList1 = Get-ChildItem $server1\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server1 -passThru

$fileList2 = Get-ChildItem $server2\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server2 -passThru

# Unterschiedliche Dateien finden (basierend auf "Name" und "Length") und Objekte mit -passThru
# weitergeben:
Compare-Object -ReferenceObject $fileList1 -DifferenceObject $fileList2 -Property Name, Length -PassThru |
  Sort-Object -Property Name |
  Select-Object -Property ComputerName, Name, Length, LastWriteTime |
  Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k10 Objekte verstehen\Skripts\compare_fileversion.ps1
************************************************************************
﻿$server1 = '\\storage1'
$server2 = '\\powershellpc'

$fileList1 = Get-ChildItem $server1\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server1 -passThru |
  Add-Member -MemberType ScriptProperty -Name Version -Value { $this.VersionInfo.ProductVersion } -PassThru

$fileList2 = Get-ChildItem $server2\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server2 -passThru |
  Add-Member -MemberType ScriptProperty -Name Version -Value { $this.VersionInfo.ProductVersion } -PassThru

# Unterschiedliche Dateien finden (basierend auf "Name" und "Length") und Objekte mit -passThru
# weitergeben:
Compare-Object -ReferenceObject $fileList1 -DifferenceObject $fileList2 -Property Name, Version -PassThru |
  Sort-Object -Property Name |
  Select-Object -Property ComputerName, Name, Version |
  Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k10 Objekte verstehen\Skripts\Get-MemberExtension.ps1
************************************************************************
﻿Function Get-MemberExtension
{
  $xml = New-Object xml

  Function Get-SingleExtension
  {
    param
    (
      $Node,

      $FilePath,

      $typename
    )

    $o = 1 | Select-Object -Property MemberName, ExtensionType, TypeName, Extension, DefiningPath
    $o.DefiningPath = $FilePath
    $o.TypeName = $typename
    $o.Extension = $node.InnerXML
    $o.MemberName = $node.FirstChild.'#text'
    $o.ExtensionType = $node.LocalName

    $o
  }

  $host.Runspace.InitialSessionState.Types |
  Select-Object -ExpandProperty FileName |
  ForEach-Object {
    $FilePath = $_
    $xml.load($FilePath)
    $xml.Types.Type |
    ForEach-Object {
      $typename = $_.Name
      $_.Members | ForEach-Object {
        if ($_.hasChildNodes)
        {
          $child = $_.FirstChild
          do
          {
            Get-SingleExtension $child $FilePath $typename
            $child = $child.NextSibling
          } while ($child)
        }
      }
    }
  } | 
  Sort-Object -Property MemberName
}

Get-MemberExtension | Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k10 Objekte verstehen\Skripts\Get-NTFSPermission.ps1
************************************************************************
﻿Function Get-NTFSPermission
{
  param
  (
    [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Mandatory=$true)]
    [String[]]
    # ...und auch in Objekten, die die Eigenschaft "FullName" oder "Path" besitzen
    # (also zum Beispiel Ergebnisse von Get-ChildItem)
    [Alias('FullName')]
    $Path
  )

  # der process-Block wird für jedes empfangene Pipeline-Element wiederholt:

  Process
  {
    # falls mehrere Pfade kommasepariert angegeben wurden, einzeln bearbeiten:
    $Path | ForEach-Object {
      # Pfad merken für später
      $currentPath = $_
      # NTFS-Berechtigungen lesen
      # das kann zu terminierenden Fehlern führen (bei fehlenden Berechtigungen)
      # daher ist dieser Teil in einen try-Block gestellt (siehe "Fehlerhandler")
      try
      {
        $ACL = Get-Acl -Path $currentPath

        # Access Control Entries einzeln bearbeiten und für jeden davon ein
        # Ergebnisobjekt liefern:
        $ACL.Access | ForEach-Object {
          # Ergebnisobjekt setzt sich zusammen aus VORHANDENEN und NEUEN Eigenschaften
          # Neue Eigenschaften sind "Path", "Identity", "Right" und "Type", denn diese waren
          # vorher nicht vorhanden. Alle bestehenden Eigenschaften, die "Inheri" enthalten,
          # werden übernommen:
          $Result = $_ | Select-Object -Property Path, Identity, Right, Type,  *Inheri*
          # "Path" wird der aktuelle Pfad zugewiesen. Diese Information fehlte in ACL-Objekten bisher:
          $Result.Path = $currentPath
          # den übrigen neuen Eigenschaften werden die unveränderten alten Eigenschaften zugewiesen.
          # dies geschieht nur, um den Eigenschaften bessere (schönere, verständlicherer) Namen zu geben:
          $Result.Identity = $_.IdentityReference
          $Result.Type = $_.AccessControlType
          $Result.Right = $_.FileSystemRights
          # danach wird das Ergebnisobjekt zurückgeliefert:
          $Result
        }
      }
      catch
      {
        Write-Warning "Kein Zugriff auf $currentPath. Fehler: '$_'"
      }
    }
  }
}

# Alle NTFS-Rechte aller Dateien und Ordner im Windows-Ordner
Get-ChildItem -Path $env:windir |
Get-NTFSPermission |
Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k10 Objekte verstehen\Skripts\readwrite_scriptproperty.ps1
************************************************************************
﻿$code_get = { [System.IO.Path]::GetFileNameWithoutExtension($this.Name) }
$code_set = {
    try {
        $extension = $this.Extension
        $newname = $args[0] + $extension
        Write-Host ("Benenne '{0}' um in '{1}'." -f $this.FullName, $newname)
        Rename-Item -Path $this.FullName -NewName $newname -ErrorAction Stop
    }
    catch
    {
        Throw "Unable to change base name: $_"
    }
}

# testdatei anlegen und neue Eigenschaft hinzufügen:
$file = New-Item -Path $home\Desktop\eine_testdatei.txt -ItemType File | 
  Add-Member -MemberType ScriptProperty -Name BaseNameNeu -Value $code_get -SecondValue $code_set -PassThru


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k10 Objekte verstehen\Skripts\Set-ConsoleWidth1.ps1
************************************************************************
﻿# Code muss in einer echten PowerShell-Konsole ausgeführt werden,
# nicht im ISE-Editor!

# Gesamten Inhalt der Eigenschaft "BufferSize" lesen:
PS> $bufferSize = $host.UI.RawUI.BufferSize

# das Objekt auf die sichtbare Breite einstellen.
# dies allein bewirkt keine Änderung der Konsole:
PS> $bufferSize.Width = $host.UI.RawUI.WindowSize.Width

# das geänderte Objekt wieder zurück in die Eigenschaft
# "Buffersize" schreiben. Jetzt ändert sich die Pufferbreite:
$host.UI.RawUI.BufferSize = $bufferSize


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k10 Objekte verstehen\Skripts\Set-ConsoleWidth2.ps1
************************************************************************
﻿Function Set-ConsoleWidth
{
  param
  (
    [Int]
    # gewünschte Breite der Konsole, optional
    # Vorgabe ist die sichtbare Breite:
    $Width = $host.ui.RawUI.WindowSize.Width,

    [Switch]
    # automatisch Konsole so breit wie möglich machen
    $Maximum
  )

  # maximal mögliche Breite der Konsole:
  $maximumWidth = $host.ui.RawUI.MaxPhysicalWindowSize.Width

  # aktuelle Breite der Konsole:
  $currentWindowWidth = $host.ui.RawUI.WindowSize.Width

  # aktuelle Breite des Puffers:
  $currentBufferWidth = $host.ui.RawUI.BufferSize.Width

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
      $buffer = $host.UI.RawUI.BufferSize
      $buffer.Width = $Width
      $host.UI.RawUI.BufferSize = $buffer
  }

  function AdjustWindow
  {
      # Sichtbaren Bereich anpassen
      $buffer = $host.UI.RawUI.WindowSize
      $buffer.Width = $Width
      $host.UI.RawUI.WindowSize = $buffer
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k10 Objekte verstehen\Skripts\WaitForExit.ps1
************************************************************************
﻿$ProzessObjekt = Start-Process -FilePath notepad -PassThru
$ergebnis = $ProzessObjekt.WaitForExit(3000)
if ($ergebnis)
{
  'Prozess wurde innerhalb von 3 Sekunden beendet und läuft nicht mehr.'
}
else
{
  'Prozess wurde in den letzten 3 Sekunden nicht beendet und läuft noch.'
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k10 Objekte verstehen\Skripts\WMI_dateconverter.ps1
************************************************************************
﻿

$os = Get-WmiObject -Class Win32_OperatingSystem
$InstallDate = $os.InstallDate
$LastBootDate = $os.LastBootUpTime

$InstallDate
$LastBootDate

$os.ConvertToDateTime($InstallDate)
$os.ConvertToDateTime($LastBootDate)



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\autotagger.type.ps1
************************************************************************
﻿$Path = "$env:temp\autotagger.type.ps1xml"
$erweiterung = @'
<Types>
    <Type>
      <Name>System.Object</Name>
        <Members>
          <ScriptMethod>
            <Name>AddTag</Name>
            <Script>
              Add-Member -InputObject $this -Name $args[0] -value $args[1] -MemberType Noteproperty -Force
            </Script>
          </ScriptMethod>
        </Members>
    </Type>
</Types>
'@

Set-Content -Value $erweiterung -Path $Path
Update-TypeData -PrependPath $Path


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\compare_filelist.ps1
************************************************************************
﻿$server1 = '\\storage1'
$server2 = '\\powershellpc'

$fileList1 = Get-ChildItem $server1\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server1 -passThru

$fileList2 = Get-ChildItem $server2\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server2 -passThru

# Unterschiedliche Dateien finden (basierend auf "Name" und "Length") und Objekte mit -passThru
# weitergeben:
Compare-Object -ReferenceObject $fileList1 -DifferenceObject $fileList2 -Property Name, Length -PassThru |
  Sort-Object -Property Name |
  Select-Object -Property ComputerName, Name, Length, LastWriteTime |
  Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\compare_fileversion.ps1
************************************************************************
﻿$server1 = '\\storage1'
$server2 = '\\powershellpc'

$fileList1 = Get-ChildItem $server1\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server1 -passThru |
  Add-Member -MemberType ScriptProperty -Name Version -Value { $this.VersionInfo.ProductVersion } -PassThru

$fileList2 = Get-ChildItem $server2\c$\windows\system32\*.dll |
  Sort-Object -Property Name |
  # eine neue Eigenschaft namens "ComputerName" anfügen und den Herkunftsserver darin angeben:
  Add-Member -MemberType NoteProperty -Name ComputerName -Value $server2 -passThru |
  Add-Member -MemberType ScriptProperty -Name Version -Value { $this.VersionInfo.ProductVersion } -PassThru

# Unterschiedliche Dateien finden (basierend auf "Name" und "Length") und Objekte mit -passThru
# weitergeben:
Compare-Object -ReferenceObject $fileList1 -DifferenceObject $fileList2 -Property Name, Version -PassThru |
  Sort-Object -Property Name |
  Select-Object -Property ComputerName, Name, Version |
  Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\filesize_kb.ps1
************************************************************************
﻿Get-ChildItem -Path $env:windir | 
    Add-Member -MemberType ScriptProperty -Name LengthGB -Value { 
        $this.Length | Add-Member -MemberType ScriptMethod -Name toString -Value { '{0:n2} KB' -f ($this/1KB) } -Force -PassThru 
    } -Force -PassThru |
    Select-Object -Property Mode, LastWriteTime, LengthGB, Name |
    Sort-Object -Property Name
 

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\GetHelp.ps1
************************************************************************
﻿

$code = {
    $url = 'http://msdn.microsoft.com/de-de/library/{0}(v=vs.80).aspx' -f $this.GetType().FullName
    Start-Process $url
}

Update-TypeData -MemberType ScriptMethod -MemberName GetHelp -Value $code -TypeName System.Object -Force


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\GetHelp2.ps1
************************************************************************
﻿$code = {
  Function Get-WMIHelpLocation
  {
    param
    (
      $WMIClassName
    )

    $uri = 'http://www.bing.com/search?q={0}+site:msdn.microsoft.com' -f $WMIClassName
    (Invoke-WebRequest -Uri $uri -UseBasicParsing).Links |
    Where-Object href -Like 'http://msdn.microsoft.com*' |
    Select-Object -ExpandProperty href -First 1
  }

  if (-not $args[0])
  {
    $types = $this | Get-Member | Select-Object -ExpandProperty TypeName | Sort-Object -Unique
  }
  else
  {
    $types = Get-Member -InputObject $this | Select-Object -ExpandProperty TypeName | Sort-Object -Unique
  }

  $types  |
  ForEach-Object {
    if ($_ -like '*#root*')
    {
      $WMIClassName = $_.Split('#')[-1].Split('\')[-1]
      Write-Host $WMIClassName
      $url = Get-WMIHelpLocation -WMIClassName $WMIClassName
    }
    else
    {
      $template = 'http://msdn.microsoft.com/de-de/library/{0}(v=vs.80).aspx'
      $url = $template -f $_
    }

    try { Start-Process $url -ErrorAction SilentlyContinue } catch {}
  }
}

Update-TypeData -MemberType ScriptMethod -MemberName GetHelp -Value $code -TypeName System.Object -Force


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\Get-MemberExtension.ps1
************************************************************************
﻿Function Get-MemberExtension
{
  $xml = New-Object xml

  Function Get-SingleExtension
  {
    param
    (
      $Node,

      $FilePath,

      $typename
    )

    $o = 1 | Select-Object -Property MemberName, ExtensionType, TypeName, Extension, DefiningPath
    $o.DefiningPath = $FilePath
    $o.TypeName = $typename
    $o.Extension = $node.InnerXML
    $o.MemberName = $node.FirstChild.'#text'
    $o.ExtensionType = $node.LocalName

    $o
  }

  $host.Runspace.InitialSessionState.Types |
  Select-Object -ExpandProperty FileName |
  ForEach-Object {
    $FilePath = $_
    $xml.load($FilePath)
    $xml.Types.Type |
    ForEach-Object {
      $typename = $_.Name
      $_.Members | ForEach-Object {
        if ($_.hasChildNodes)
        {
          $child = $_.FirstChild
          do
          {
            Get-SingleExtension $child $FilePath $typename
            $child = $child.NextSibling
          } while ($child)
        }
      }
    }
  } | 
  Sort-Object -Property MemberName
}

Get-MemberExtension | Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\Get-NTFSPermission.ps1
************************************************************************
﻿Function Get-NTFSPermission
{
  param
  (
    [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Mandatory=$true)]
    [String[]]
    # ...und auch in Objekten, die die Eigenschaft "FullName" oder "Path" besitzen
    # (also zum Beispiel Ergebnisse von Get-ChildItem)
    [Alias('FullName')]
    $Path
  )

  # der process-Block wird für jedes empfangene Pipeline-Element wiederholt:

  Process
  {
    # falls mehrere Pfade kommasepariert angegeben wurden, einzeln bearbeiten:
    $Path | ForEach-Object {
      # Pfad merken für später
      $currentPath = $_
      # NTFS-Berechtigungen lesen
      # das kann zu terminierenden Fehlern führen (bei fehlenden Berechtigungen)
      # daher ist dieser Teil in einen try-Block gestellt (siehe "Fehlerhandler")
      try
      {
        $ACL = Get-Acl -Path $currentPath

        # Access Control Entries einzeln bearbeiten und für jeden davon ein
        # Ergebnisobjekt liefern:
        $ACL.Access | ForEach-Object {
          # Ergebnisobjekt setzt sich zusammen aus VORHANDENEN und NEUEN Eigenschaften
          # Neue Eigenschaften sind "Path", "Identity", "Right" und "Type", denn diese waren
          # vorher nicht vorhanden. Alle bestehenden Eigenschaften, die "Inheri" enthalten,
          # werden übernommen:
          $Result = $_ | Select-Object -Property Path, Identity, Right, Type,  *Inheri*
          # "Path" wird der aktuelle Pfad zugewiesen. Diese Information fehlte in ACL-Objekten bisher:
          $Result.Path = $currentPath
          # den übrigen neuen Eigenschaften werden die unveränderten alten Eigenschaften zugewiesen.
          # dies geschieht nur, um den Eigenschaften bessere (schönere, verständlicherer) Namen zu geben:
          $Result.Identity = $_.IdentityReference
          $Result.Type = $_.AccessControlType
          $Result.Right = $_.FileSystemRights
          # danach wird das Ergebnisobjekt zurückgeliefert:
          $Result
        }
      }
      catch
      {
        Write-Warning "Kein Zugriff auf $currentPath. Fehler: '$_'"
      }
    }
  }
}

# Alle NTFS-Rechte aller Dateien und Ordner im Windows-Ordner
Get-ChildItem -Path $env:windir |
Get-NTFSPermission |
Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\Get-WMIClassName.ps1
************************************************************************
﻿Function Get-WMIHelpLocation
{
  param
  (
    $WMIClassName
  )

  $uri = 'http://www.bing.com/search?q={0}+site:msdn.microsoft.com' -f $WMIClassName
  (Invoke-WebRequest -Uri $uri -UseBasicParsing).Links |
  Where-Object href -Like 'http://msdn.microsoft.com*' |
  Select-Object -ExpandProperty href -First 1
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\readwrite_scriptproperty.ps1
************************************************************************
﻿$code_get = { [System.IO.Path]::GetFileNameWithoutExtension($this.Name) }
$code_set = {
    try {
        $extension = $this.Extension
        $newname = $args[0] + $extension
        Write-Host ("Benenne '{0}' um in '{1}'." -f $this.FullName, $newname)
        Rename-Item -Path $this.FullName -NewName $newname -ErrorAction Stop
    }
    catch
    {
        Throw "Unable to change base name: $_"
    }
}

# testdatei anlegen und neue Eigenschaft hinzufügen:
$file = New-Item -Path $home\Desktop\eine_testdatei.txt -ItemType File | 
  Add-Member -MemberType ScriptProperty -Name BaseNameNeu -Value $code_get -SecondValue $code_set -PassThru


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\Set-ConsoleWidth1.ps1
************************************************************************
﻿# Code muss in einer echten PowerShell-Konsole ausgeführt werden,
# nicht im ISE-Editor!

# Gesamten Inhalt der Eigenschaft "BufferSize" lesen:
PS> $bufferSize = $host.UI.RawUI.BufferSize

# das Objekt auf die sichtbare Breite einstellen.
# dies allein bewirkt keine Änderung der Konsole:
PS> $bufferSize.Width = $host.UI.RawUI.WindowSize.Width

# das geänderte Objekt wieder zurück in die Eigenschaft
# "Buffersize" schreiben. Jetzt ändert sich die Pufferbreite:
$host.UI.RawUI.BufferSize = $bufferSize


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\Set-ConsoleWidth2.ps1
************************************************************************
﻿Function Set-ConsoleWidth
{
  param
  (
    [Int]
    # gewünschte Breite der Konsole, optional
    # Vorgabe ist die sichtbare Breite:
    $Width = $host.ui.RawUI.WindowSize.Width,

    [Switch]
    # automatisch Konsole so breit wie möglich machen
    $Maximum
  )

  # maximal mögliche Breite der Konsole:
  $maximumWidth = $host.ui.RawUI.MaxPhysicalWindowSize.Width

  # aktuelle Breite der Konsole:
  $currentWindowWidth = $host.ui.RawUI.WindowSize.Width

  # aktuelle Breite des Puffers:
  $currentBufferWidth = $host.ui.RawUI.BufferSize.Width

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
      $buffer = $host.UI.RawUI.BufferSize
      $buffer.Width = $Width
      $host.UI.RawUI.BufferSize = $buffer
  }

  function AdjustWindow
  {
      # Sichtbaren Bereich anpassen
      $buffer = $host.UI.RawUI.WindowSize
      $buffer.Width = $Width
      $host.UI.RawUI.WindowSize = $buffer
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\update-typedata1.ps1
************************************************************************
﻿$Path = "$env:temp\erweiterung.ps1xml"
$erweiterung = @'
<Types>
    <Type>
      <Name>System.IO.FileInfo</Name>
        <Members>
          <ScriptProperty>
            <Name>LengthKB</Name>
            <GetScriptBlock>
              $this.Length | Add-Member -MemberType ScriptMethod -Name toString -Value { '{0:n2} KB' -f ($this/1KB) } -Force -PassThru
            </GetScriptBlock>
          </ScriptProperty>
        </Members>
    </Type>
</Types>
'@

Set-Content -Value $erweiterung -Path $Path
Update-TypeData -PrependPath $Path


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\vorlage_typerweiterung.ps1xml
************************************************************************
﻿<Types>
    <Type>
        <Name>Typ-Name, für die die Erweiterung gilt</Name>
        <Members>
            [Erweiterung]
         </Members>
    </Type>
</Types>



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\WaitForExit.ps1
************************************************************************
﻿$ProzessObjekt = Start-Process -FilePath notepad -PassThru
$ergebnis = $ProzessObjekt.WaitForExit(3000)
if ($ergebnis)
{
  'Prozess wurde innerhalb von 3 Sekunden beendet und läuft nicht mehr.'
}
else
{
  'Prozess wurde in den letzten 3 Sekunden nicht beendet und läuft noch.'
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k11 Objekte erweitern\Skripts\WMI_dateconverter.ps1
************************************************************************
﻿

$os = Get-WmiObject -Class Win32_OperatingSystem
$InstallDate = $os.InstallDate
$LastBootDate = $os.LastBootUpTime

$InstallDate
$LastBootDate

$os.ConvertToDateTime($InstallDate)
$os.ConvertToDateTime($LastBootDate)



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Check-Link.ps1
************************************************************************
﻿$shell = New-Object -ComObject wscript.shell

$StartUser = $shell.SpecialFolders.Item('StartMenu')
$StartAll = "$env:allusersprofile\Windows\Startmenü"

Get-ChildItem -Path $StartUser, $StartAll -Filter *.lnk -Recurse -ErrorAction SilentlyContinue | 
ForEach-Object {
  $lnkfile = $shell.CreateShortcut($_.FullName)
  $rv = 1 | Select-Object Name, Hotkey
  $rv.Hotkey =  $lnkfile.Hotkey
  $rv.Name = $_.Name
  $rv
} 


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Create_share1.ps1
************************************************************************
﻿$shareklasse = [wmiclass]'\\storage1\root\cimv2:Win32_Share'
$pfad = 'C:\'
$name = 'serviceshare'
$type = 0
$maximumallowed = 5
$description = 'Interner Share für Wartungsaufgaben'
$shareklasse.Create($pfad, $Name, $Type, $MaximumAllowed, $Description).ReturnValue


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Create_share2.ps1
************************************************************************
﻿# Anmeldeinformationen festlegen:
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\excel1.ps1
************************************************************************
﻿$excel = New-Object -ComObject Excel.Application
$workbook = $excel.Workbooks.Add()
$excel.Visible = $True
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\excel2.ps1
************************************************************************
﻿Function Use-Culture
{
  param
  (
    [ScriptBlock]
    [Parameter(Mandatory=$true)]
    $code,

    [System.Globalization.CultureInfo]
    $culture='en-US'
  )

  trap {
    [System.Threading.Thread]::CurrentThread.CurrentCulture = $currentCulture
  }

  $currentCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
  [System.Threading.Thread]::CurrentThread.CurrentCulture = $culture
  Invoke-Command $code
  [System.Threading.Thread]::CurrentThread.CurrentCulture = $currentCulture
}

$code = {
  $excel = New-Object -ComObject Excel.Application
  $workbook = $excel.Workbooks.Add()
  $excel.Visible = $True
  $excel.Cells.Item(1,1) = 'Service Name'
  $excel.Cells.Item(1,2) = 'Service Status'
  $excel.Cells.Item(1,3) = 'Service Status'

  $i = 2
  Get-Service |
  ForEach-Object {
    $excel.Cells.Item($i,1) = $_.name
    $excel.Cells.Item($i,2) = $_.status
    $excel.Cells.Item($i,3) = "$($_.status)"
    $i=$i+1
  }
}

Use-Culture $code


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Export-Import-Credential.ps1
************************************************************************
﻿function Export-Credential($cred, $file) {
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Get-Constructor.ps1
************************************************************************
﻿Function Get-Constructor
{
  param
  (
    [Type]$Type
  )

  $pattern = '\(.*?\)'
  $Type.GetConstructors() |
  ForEach-Object {
    $Signature = if ($_.toString() -match $pattern)
    {
      $matches[0]
    }
    else
    {
      'unknown'
    }

    '$object = New-Object -TypeName {0}{1}' -f $Type.FullName, $Signature
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Get-ExchangeRate.ps1
************************************************************************
﻿Function Get-ExchangeRate
{
  $xml = New-Object xml
  $xml.Load('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml')

  # aus den XML-Daten die Wechselkursinformationen ansprechen:
  $xml.Envelope.Cube.Cube.Cube
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Get-Movie.ps1
************************************************************************
﻿function Get-Movie
{
  param(
    [Parameter(Mandatory=$true)]
    $Name
  )

  $xml = New-Object xml
  $xml.Load("http://a.disas.de/ofdbgw/search/$Name")
  $xml.ofdbgw.resultat.eintrag
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Get-PopularName.ps1
************************************************************************
﻿Function Get-PopularName
{
  param
  (
    [ValidateSet('1880','1890','1900','1910','1920','1930','1940','1950','1960','1970','1980','1990','2000','2010')]
    $Decade = '1950'
  )

  # Muster der Information im Quelltext der Webseite
  # runde Klammern markieren Informationen, die separat extrahiert werden sollen (außer solche, die mit "?:" markiert sind)
  # (.*?) steht für "beliebiger Text"
  # (?si) steht für "single line mode" und "case-insensitive"
  $pattern = '(?si)<td>(\d{1,3})</td>\s*?<td align="center">(.*?)</td>\s*?<td>((?:\d{0,3}\,)*\d{1,3})</td>\s*?<td align="center">(.*?)</td>\s*?<td>((?:\d{0,3}\,)*\d{1,3})</td></tr>'

  # WebClient besorgen und universell konfigurieren:
  $webclient = New-Object System.Net.WebClient
  try
  {
    $proxy = [System.Net.WebRequest]::GetSystemWebProxy()
    $proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    $webclient.proxy = $proxy
  } catch {}
  $webclient.UseDefaultCredentials = $true

  # Quelltext der Webseite herunterladen:
  $html = $webclient.DownloadString("http://www.ssa.gov/OACT/babynames/decades/names$($decade)s.html")

  # RegEx-Engine durch Typumwandlung erstellen:
  $regex = [regex]$pattern

  # Treffer im Text suchen:
  $Matches = $regex.Matches($html)

  # Ergebnisse auswerten und in Objekte verpacken:
  $matches | ForEach-Object {
    $match = $_

    $rv = New-Object PSObject | Select-Object -Property Name, Rank, Number, Gender
    $rv.Rank = $match.Groups[1].Value
    $rv.Gender = 'm'
    $rv.Name = $match.Groups[2].Value
    $rv.Number = [Int]$match.Groups[3].Value
    $rv

    $rv = New-Object PSObject | Select-Object -Property Name, Rank, Number, Gender
    $rv.Rank = $match.Groups[1].Value
    $rv.Gender = 'f'
    $rv.Name = $match.Groups[4].Value
    $rv.Number = [Int]$match.Groups[5].Value
    $rv
  } | Sort-Object Name, Rank
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Get-UserAccount.ps1
************************************************************************
﻿Function Get-UserAccount
{
  [CmdletBinding(DefaultParameterSetName='localAccount')]

  param
  (
    [Parameter(Position=0)]
    $UserName=$env:UserName,

    [Parameter(ParameterSetName='localAccount')]
    $ComputerName=$env:Computername,

    [Parameter(ParameterSetName='domainAccount')]
    $DomainName=$env:UserDomain
  )

  # handelt es sich um ein Domänenkonto oder lokales Konto?
  $type = $PSCmdlet.ParameterSetName

  # wirklich? Wenn der Computername und der Domänenname identisch
  # sind, ist es ein lokales Konto:

  if ($DomainName -eq $ComputerName)
  {
    $type = 'localAccount'
  }

  if ($type -eq 'localAccount')
  {
    # lokales Konto direkt vom Computer lesen:
    $computer = [ADSI]"WinNT://$Computername,computer"
    $computer.Children.Find($UserName, 'user')
  }
  else
  {
    # Domänenkonto aus der Domäne lesen:
    $domain = [ADSI]"WinNT://$DomainName,domain"
    $domain.Children.Find($UserName, 'user')
  }
}



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\mitarbeiterliste.ps1
************************************************************************
﻿$xml = @'
<?xml version="1.0" ?>
<Belegschaft Zweigstelle="Hannover" Typ="Aussendienst">
  <Mitarbeiter>
    <Name>Tobias Weltner</Name>
    <Rolle>Leitung</Rolle>
    <Alter>41</Alter>
  </Mitarbeiter>
  <Mitarbeiter>
    <Name>Cofi Heidecke</Name>
    <Rolle>Sicherheit</Rolle>
    <Alter>6</Alter>
  </Mitarbeiter>
</Belegschaft>
'@ | Out-File $env:temp\mitarbeiter.xml


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\new-Link.ps1
************************************************************************
﻿$shell = New-Object -ComObject WScript.Shell

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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\newsticker1.ps1
************************************************************************
﻿$link = @{
  Name = 'Internetlink'
  Expression = { $_.Link.HRef }
}

$published = @{
  Name = 'Veröffentlicht'
  Expression = { [DateTime]$_.Published }
}


$xml = New-Object XML
$xml.Load('http://www.heise.de/ct/rss/artikel-atom.xml')
$xml.feed.entry | 
  Select-Object -Property Title, $Link, $Published, Summary | 
  Out-GridView



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\newsticker2.ps1
************************************************************************
﻿$link = @{
  Name = 'Internetlink'
  Expression = { $_.Link.HRef }
}

$published = @{
  Name = 'Veröffentlicht'
  Expression = { [DateTime]$_.Published }
}


$xml = New-Object XML
$xml.Load('http://www.heise.de/ct/rss/artikel-atom.xml')
$xml.feed.entry | 
  Select-Object -Property Title, $Link, $Published, Summary | 
  Out-GridView



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\popup_dialog.ps1
************************************************************************
﻿$wshell = New-Object -ComObject WScript.Shell
$message = 'Ihr Rechner wird jetzt neu gestartet. Einverstanden?'
$title = 'Wichtig'
$response = $wshell.Popup($message, 10, $title, (4+48))
if ($response -ne 7)
{
    Restart-Computer -WhatIf
}

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\prompt.ps1
************************************************************************
﻿$auswahl = [System.Management.Automation.Host.ChoiceDescription[]]('&Ja','&Nein')
$antwort = $Host.ui.PromptForChoice('Reboot', 'Darf das System jetzt neu gestartet werden?',$auswahl,1)


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Select-Folder.ps1
************************************************************************
﻿Function Select-Folder
{
  param
  (
    $Message='Select a folder',

    $Path = 0
  )

  $object = New-Object -ComObject Shell.Application

  $folder = $object.BrowseForFolder(0, $message, 0, $path)

  if ($folder -ne $null)
  {
    $folder.self.Path
  }
}

Select-Folder -message 'Welcher Ordner?' -Path $env:windir

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Test-Date.ps1
************************************************************************
﻿function Test-Date($Value) { ($Value -as [DateTime]) -ne $null }

do
{
    $datum = Read-Host 'Geben Sie ein Datum ein'
    $isDate = Test-Date $datum
    if (-not $isDate)
    {
        Write-Warning "Ihre Eingabe '$datum' war kein gültiges Datum. Nochmal."
    }
} until ($isDate)

"Eingabe: $datum"
Get-Date -Date $datum -Format 'yyyy-MM-dd HH:mm:ss'
$datetime = [DateTime]$datum
$datetime


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\Test-UserPassword.ps1
************************************************************************
﻿Function Get-UserAccount
{
  [CmdletBinding(DefaultParameterSetName='localAccount')]

  param
  (
    [Parameter(Position=0)]
    $UserName=$env:UserName,

    [Parameter(ParameterSetName='localAccount')]
    $ComputerName=$env:Computername,

    [Parameter(ParameterSetName='domainAccount')]
    $DomainName=$env:UserDomain
  )

  # handelt es sich um ein Domänenkonto oder lokales Konto?
  $type = $PSCmdlet.ParameterSetName

  # wirklich? Wenn der Computername und der Domänenname identisch
  # sind, ist es ein lokales Konto:

  if ($DomainName -eq $ComputerName)
  {
    $type = 'localAccount'
  }

  if ($type -eq 'localAccount')
  {
    # lokales Konto direkt vom Computer lesen:
    $computer = [ADSI]"WinNT://$Computername,computer"
    $computer.Children.Find($UserName, 'user')
  }
  else
  {
    # Domänenkonto aus der Domäne lesen:
    $domain = [ADSI]"WinNT://$DomainName,domain"
    $domain.Children.Find($UserName, 'user')
  }
}

Function Test-UserPassword
{
  param
  (
    [Parameter(Mandatory=$true)]
    $Password,

    [Parameter(ValueFromPipeline=$true)]
    $InputObject
  )

  Process
  {
    try
    {
      # versuchsweise vermutetes Kennwort erneut setzen:
      $InputObject.ChangePassword($Password, $Password)
      # wenn erfolgreich, dann stimmt es:
      $true
    }
    catch
    {
        # bei Fehlermeldungen: die folgenden beiden besagen,
        # dass das Kennwort nicht geändert werden konnte
        # (zum Beispiel wegen Komplexitätskriterien oder weil
        # das Kennwort in der Kennworthistory gesperrt ist)
        # das Kennwort stimmt dann aber trotz des Fehlers:
        $errorcode = $_.Exception.InnerException.ErrorCode
        (($errorcode -eq 0x8007202f) -or ($errorcode -eq 0x800708c5))
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\webclient.ps1
************************************************************************
﻿$webclient = New-Object System.Net.WebClient
try
{
  $proxy = [System.Net.WebRequest]::GetSystemWebProxy()
  $proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
  $webClient.proxy = $proxy
}
catch {}

$webclient.UseDefaultCredentials = $true


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\webrequest.ps1
************************************************************************
﻿$url = 'http://www.heise.de/ct/rss/artikel-atom.xml'

# Low-Level WebRequest verwenden:
$request = [System.Net.WebRequest]::Create($url)
$request.Timeout = 1000

# Proxy einrichten:
$proxy = New-Object System.Net.WebProxy("http://yourProxy:8080")
# entweder mit Standardanmeldedaten arbeiten...
$proxy.useDefaultCredentials = $true
# ...oder nach Anmeldedaten fragen:
$proxy.Credentials = (Get-Credential).GetNetworkCredential()
$request.Proxy = $proxy

# Daten abrufen:
$response = $request.GetResponse()
$requestStream = $response.GetResponseStream()
$readStream = New-Object System.IO.StreamReader $requestStream
$data = $readStream.ReadToEnd()
$readStream.Close()
$response.Close()

# Daten in XML verwandeln:
$xml = [XML]$data
$xml


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\wetter.ps1
************************************************************************
﻿# Wetterdienst ansprechen:
$wetter = New-WebServiceProxy -Uri http://www.webservicex.com/globalweather.asmx?WSDL

# Wetterdaten abrufen:
$hannover = [XML]$wetter.GetWeather('Hannover', 'Germany')
$mallorca = [XML]$wetter.GetWeather('Palma', 'Spain')
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
Out-File $env:temp\wetter.hta
Invoke-Item $env:temp\wetter.hta


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k12 umwandlungen\Skripts\xml_umwandlung.ps1
************************************************************************
﻿# XML als reiner Text:
Get-Content $env:temp\mitarbeiter.xml
[XML](Get-Content $env:temp\mitarbeiter.xml)


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Check-Link.ps1
************************************************************************
﻿$shell = New-Object -ComObject wscript.shell

$StartUser = $shell.SpecialFolders.Item('StartMenu')
$StartAll = "$env:allusersprofile\Windows\Startmenü"

Get-ChildItem -Path $StartUser, $StartAll -Filter *.lnk -Recurse -ErrorAction SilentlyContinue | 
ForEach-Object {
  $lnkfile = $shell.CreateShortcut($_.FullName)
  $rv = 1 | Select-Object Name, Hotkey
  $rv.Hotkey =  $lnkfile.Hotkey
  $rv.Name = $_.Name
  $rv
} 


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Create_share1.ps1
************************************************************************
﻿$shareklasse = [wmiclass]'\\storage1\root\cimv2:Win32_Share'
$pfad = 'C:\'
$name = 'serviceshare'
$type = 0
$maximumallowed = 5
$description = 'Interner Share für Wartungsaufgaben'
$shareklasse.Create($pfad, $Name, $Type, $MaximumAllowed, $Description).ReturnValue


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Create_share2.ps1
************************************************************************
﻿# Anmeldeinformationen festlegen:
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\excel1.ps1
************************************************************************
﻿$excel = New-Object -ComObject Excel.Application
$workbook = $excel.Workbooks.Add()
$excel.Visible = $True
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\excel2.ps1
************************************************************************
﻿Function Use-Culture
{
  param
  (
    [ScriptBlock]
    [Parameter(Mandatory=$true)]
    $code,

    [System.Globalization.CultureInfo]
    $culture='en-US'
  )

  trap {
    [System.Threading.Thread]::CurrentThread.CurrentCulture = $currentCulture
  }

  $currentCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
  [System.Threading.Thread]::CurrentThread.CurrentCulture = $culture
  Invoke-Command $code
  [System.Threading.Thread]::CurrentThread.CurrentCulture = $currentCulture
}

$code = {
  $excel = New-Object -ComObject Excel.Application
  $workbook = $excel.Workbooks.Add()
  $excel.Visible = $True
  $excel.Cells.Item(1,1) = 'Service Name'
  $excel.Cells.Item(1,2) = 'Service Status'
  $excel.Cells.Item(1,3) = 'Service Status'

  $i = 2
  Get-Service |
  ForEach-Object {
    $excel.Cells.Item($i,1) = $_.name
    $excel.Cells.Item($i,2) = $_.status
    $excel.Cells.Item($i,3) = "$($_.status)"
    $i=$i+1
  }
}

Use-Culture $code


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Export-Import-Credential.ps1
************************************************************************
﻿function Export-Credential($cred, $file) {
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Get-Constructor.ps1
************************************************************************
﻿Function Get-Constructor
{
  param
  (
    [Type]$Type
  )

  $pattern = '\(.*?\)'
  $Type.GetConstructors() |
  ForEach-Object {
    $Signature = if ($_.toString() -match $pattern)
    {
      $matches[0]
    }
    else
    {
      'unknown'
    }

    '$object = New-Object -TypeName {0}{1}' -f $Type.FullName, $Signature
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Get-ExchangeRate.ps1
************************************************************************
﻿Function Get-ExchangeRate
{
  $xml = New-Object xml
  $xml.Load('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml')

  # aus den XML-Daten die Wechselkursinformationen ansprechen:
  $xml.Envelope.Cube.Cube.Cube
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Get-Movie.ps1
************************************************************************
﻿function Get-Movie
{
  param(
    [Parameter(Mandatory=$true)]
    $Name
  )

  $xml = New-Object xml
  $xml.Load("http://a.disas.de/ofdbgw/search/$Name")
  $xml.ofdbgw.resultat.eintrag
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Get-PopularName.ps1
************************************************************************
﻿Function Get-PopularName
{
  param
  (
    [ValidateSet('1880','1890','1900','1910','1920','1930','1940','1950','1960','1970','1980','1990','2000','2010')]
    $Decade = '1950'
  )

  # Muster der Information im Quelltext der Webseite
  # runde Klammern markieren Informationen, die separat extrahiert werden sollen (außer solche, die mit "?:" markiert sind)
  # (.*?) steht für "beliebiger Text"
  # (?si) steht für "single line mode" und "case-insensitive"
  $pattern = '(?si)<td>(\d{1,3})</td>\s*?<td align="center">(.*?)</td>\s*?<td>((?:\d{0,3}\,)*\d{1,3})</td>\s*?<td align="center">(.*?)</td>\s*?<td>((?:\d{0,3}\,)*\d{1,3})</td></tr>'

  # WebClient besorgen und universell konfigurieren:
  $webclient = New-Object System.Net.WebClient
  try
  {
    $proxy = [System.Net.WebRequest]::GetSystemWebProxy()
    $proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    $webclient.proxy = $proxy
  } catch {}
  $webclient.UseDefaultCredentials = $true

  # Quelltext der Webseite herunterladen:
  $html = $webclient.DownloadString("http://www.ssa.gov/OACT/babynames/decades/names$($decade)s.html")

  # RegEx-Engine durch Typumwandlung erstellen:
  $regex = [regex]$pattern

  # Treffer im Text suchen:
  $Matches = $regex.Matches($html)

  # Ergebnisse auswerten und in Objekte verpacken:
  $matches | ForEach-Object {
    $match = $_

    $rv = New-Object PSObject | Select-Object -Property Name, Rank, Number, Gender
    $rv.Rank = $match.Groups[1].Value
    $rv.Gender = 'm'
    $rv.Name = $match.Groups[2].Value
    $rv.Number = [Int]$match.Groups[3].Value
    $rv

    $rv = New-Object PSObject | Select-Object -Property Name, Rank, Number, Gender
    $rv.Rank = $match.Groups[1].Value
    $rv.Gender = 'f'
    $rv.Name = $match.Groups[4].Value
    $rv.Number = [Int]$match.Groups[5].Value
    $rv
  } | Sort-Object Name, Rank
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Get-UserAccount.ps1
************************************************************************
﻿Function Get-UserAccount
{
  [CmdletBinding(DefaultParameterSetName='localAccount')]

  param
  (
    [Parameter(Position=0)]
    $UserName=$env:UserName,

    [Parameter(ParameterSetName='localAccount')]
    $ComputerName=$env:Computername,

    [Parameter(ParameterSetName='domainAccount')]
    $DomainName=$env:UserDomain
  )

  # handelt es sich um ein Domänenkonto oder lokales Konto?
  $type = $PSCmdlet.ParameterSetName

  # wirklich? Wenn der Computername und der Domänenname identisch
  # sind, ist es ein lokales Konto:

  if ($DomainName -eq $ComputerName)
  {
    $type = 'localAccount'
  }

  if ($type -eq 'localAccount')
  {
    # lokales Konto direkt vom Computer lesen:
    $computer = [ADSI]"WinNT://$Computername,computer"
    $computer.Children.Find($UserName, 'user')
  }
  else
  {
    # Domänenkonto aus der Domäne lesen:
    $domain = [ADSI]"WinNT://$DomainName,domain"
    $domain.Children.Find($UserName, 'user')
  }
}



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\mitarbeiterliste.ps1
************************************************************************
﻿$xml = @'
<?xml version="1.0" ?>
<Belegschaft Zweigstelle="Hannover" Typ="Aussendienst">
  <Mitarbeiter>
    <Name>Tobias Weltner</Name>
    <Rolle>Leitung</Rolle>
    <Alter>41</Alter>
  </Mitarbeiter>
  <Mitarbeiter>
    <Name>Cofi Heidecke</Name>
    <Rolle>Sicherheit</Rolle>
    <Alter>6</Alter>
  </Mitarbeiter>
</Belegschaft>
'@ | Out-File $env:temp\mitarbeiter.xml


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\new-Link.ps1
************************************************************************
﻿$shell = New-Object -ComObject WScript.Shell

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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\newsticker1.ps1
************************************************************************
﻿$link = @{
  Name = 'Internetlink'
  Expression = { $_.Link.HRef }
}

$published = @{
  Name = 'Veröffentlicht'
  Expression = { [DateTime]$_.Published }
}


$xml = New-Object XML
$xml.Load('http://www.heise.de/ct/rss/artikel-atom.xml')
$xml.feed.entry | 
  Select-Object -Property Title, $Link, $Published, Summary | 
  Out-GridView



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\newsticker2.ps1
************************************************************************
﻿$link = @{
  Name = 'Internetlink'
  Expression = { $_.Link.HRef }
}

$published = @{
  Name = 'Veröffentlicht'
  Expression = { [DateTime]$_.Published }
}


$xml = New-Object XML
$xml.Load('http://www.heise.de/ct/rss/artikel-atom.xml')
$xml.feed.entry | 
  Select-Object -Property Title, $Link, $Published, Summary | 
  Out-GridView



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\popup_dialog.ps1
************************************************************************
﻿$wshell = New-Object -ComObject WScript.Shell
$message = 'Ihr Rechner wird jetzt neu gestartet. Einverstanden?'
$title = 'Wichtig'
$response = $wshell.Popup($message, 10, $title, (4+48))
if ($response -ne 7)
{
    Restart-Computer -WhatIf
}

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\prompt.ps1
************************************************************************
﻿$auswahl = [System.Management.Automation.Host.ChoiceDescription[]]('&Ja','&Nein')
$antwort = $Host.ui.PromptForChoice('Reboot', 'Darf das System jetzt neu gestartet werden?',$auswahl,1)


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Select-Folder.ps1
************************************************************************
﻿Function Select-Folder
{
  param
  (
    $Message='Select a folder',

    $Path = 0
  )

  $object = New-Object -ComObject Shell.Application

  $folder = $object.BrowseForFolder(0, $message, 0, $path)

  if ($folder -ne $null)
  {
    $folder.self.Path
  }
}

Select-Folder -message 'Welcher Ordner?' -Path $env:windir

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Test-Date.ps1
************************************************************************
﻿function Test-Date($Value) { ($Value -as [DateTime]) -ne $null }

do
{
    $datum = Read-Host 'Geben Sie ein Datum ein'
    $isDate = Test-Date $datum
    if (-not $isDate)
    {
        Write-Warning "Ihre Eingabe '$datum' war kein gültiges Datum. Nochmal."
    }
} until ($isDate)

"Eingabe: $datum"
Get-Date -Date $datum -Format 'yyyy-MM-dd HH:mm:ss'
$datetime = [DateTime]$datum
$datetime


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\Test-UserPassword.ps1
************************************************************************
﻿Function Get-UserAccount
{
  [CmdletBinding(DefaultParameterSetName='localAccount')]

  param
  (
    [Parameter(Position=0)]
    $UserName=$env:UserName,

    [Parameter(ParameterSetName='localAccount')]
    $ComputerName=$env:Computername,

    [Parameter(ParameterSetName='domainAccount')]
    $DomainName=$env:UserDomain
  )

  # handelt es sich um ein Domänenkonto oder lokales Konto?
  $type = $PSCmdlet.ParameterSetName

  # wirklich? Wenn der Computername und der Domänenname identisch
  # sind, ist es ein lokales Konto:

  if ($DomainName -eq $ComputerName)
  {
    $type = 'localAccount'
  }

  if ($type -eq 'localAccount')
  {
    # lokales Konto direkt vom Computer lesen:
    $computer = [ADSI]"WinNT://$Computername,computer"
    $computer.Children.Find($UserName, 'user')
  }
  else
  {
    # Domänenkonto aus der Domäne lesen:
    $domain = [ADSI]"WinNT://$DomainName,domain"
    $domain.Children.Find($UserName, 'user')
  }
}

Function Test-UserPassword
{
  param
  (
    [Parameter(Mandatory=$true)]
    $Password,

    [Parameter(ValueFromPipeline=$true)]
    $InputObject
  )

  Process
  {
    try
    {
      # versuchsweise vermutetes Kennwort erneut setzen:
      $InputObject.ChangePassword($Password, $Password)
      # wenn erfolgreich, dann stimmt es:
      $true
    }
    catch
    {
        # bei Fehlermeldungen: die folgenden beiden besagen,
        # dass das Kennwort nicht geändert werden konnte
        # (zum Beispiel wegen Komplexitätskriterien oder weil
        # das Kennwort in der Kennworthistory gesperrt ist)
        # das Kennwort stimmt dann aber trotz des Fehlers:
        $errorcode = $_.Exception.InnerException.ErrorCode
        (($errorcode -eq 0x8007202f) -or ($errorcode -eq 0x800708c5))
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\webclient.ps1
************************************************************************
﻿$webclient = New-Object System.Net.WebClient
try
{
  $proxy = [System.Net.WebRequest]::GetSystemWebProxy()
  $proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
  $webClient.proxy = $proxy
}
catch {}

$webclient.UseDefaultCredentials = $true


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\webrequest.ps1
************************************************************************
﻿$url = 'http://www.heise.de/ct/rss/artikel-atom.xml'

# Low-Level WebRequest verwenden:
$request = [System.Net.WebRequest]::Create($url)
$request.Timeout = 1000

# Proxy einrichten:
$proxy = New-Object System.Net.WebProxy("http://yourProxy:8080")
# entweder mit Standardanmeldedaten arbeiten...
$proxy.useDefaultCredentials = $true
# ...oder nach Anmeldedaten fragen:
$proxy.Credentials = (Get-Credential).GetNetworkCredential()
$request.Proxy = $proxy

# Daten abrufen:
$response = $request.GetResponse()
$requestStream = $response.GetResponseStream()
$readStream = New-Object System.IO.StreamReader $requestStream
$data = $readStream.ReadToEnd()
$readStream.Close()
$response.Close()

# Daten in XML verwandeln:
$xml = [XML]$data
$xml


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\wetter.ps1
************************************************************************
﻿# Wetterdienst ansprechen:
$wetter = New-WebServiceProxy -Uri http://www.webservicex.com/globalweather.asmx?WSDL

# Wetterdaten abrufen:
$hannover = [XML]$wetter.GetWeather('Hannover', 'Germany')
$mallorca = [XML]$wetter.GetWeather('Palma', 'Spain')
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
Out-File $env:temp\wetter.hta
Invoke-Item $env:temp\wetter.hta


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k13 Neue Objekte anlegen\Skripts\xml_umwandlung.ps1
************************************************************************
﻿# XML als reiner Text:
Get-Content $env:temp\mitarbeiter.xml
[XML](Get-Content $env:temp\mitarbeiter.xml)


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k14 Statische Methoden eines Typs\Skripts\Convert_datetime_culture.ps1
************************************************************************
﻿

# Datum liegt in einer französischen Schreibweise vor:
$datumFranzoesisch = 'vendredi 23 novembre 2012 11:19:13'

# für die Umwandlungen die Quell- und Zielkultur besorgen:
[System.Globalization.CultureInfo]$Frankreich = 'fr-FR'
[System.Globalization.CultureInfo]$Taiwan = 'zh-TW'

# Datumstext unter Angabe seiner Kultur in einen DateTime-Typ verwandeln
# dieser ist sprachunabhängig:
$DateTime = [DateTime]::Parse($datumFranzoesisch, $Frankreich)

# von hier aus in Zielkultur umwandeln
# das Ergebnis ist jetzt wieder Text (String):
$datumTaiwan = $DateTime.ToString($Taiwan)
""
"$datumFranzoesisch -> $datumTaiwan"




################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k14 Statische Methoden eines Typs\Skripts\ConvertTo-DateTimeFormat.ps1
************************************************************************
﻿Function ConvertTo-DateTimeFormat
{
  [CmdletBinding(DefaultParameterSetName='Specific')]
  param
  (
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [DateTime]
    $DateTime,

    [ValidateSet('UniversalSortableDateTime', 'SortableDateTime', 'FullDateTime', 'RFC1123', 'LongDate', 'LongTime', 'ShortDate','ShortTime','YearMonth', 'MonthDay')]
    $Format = 'SortableDateTime',

    [String]
    [Parameter(ParameterSetName='Specific')]
    $Culture = [System.Globalization.CultureInfo]::CurrentUICulture.Name,

    [Switch]
    [Parameter(ParameterSetName='Invariant')]
    $Neutral
  )

  Begin
  {
    # die Eigenschaften, die die Muster enthalten, heißen so wie in $Format angegeben, allerdings
    # um das Wort "Pattern" ergänzt:
    $FormatName = $Format + 'Pattern'

    # Das Muster des gewählten Formats auslesen:
    if ($Neutral) { $Culture = '' }
   
    # wurde kein Kultur-Kurzname angegeben, sondern ein Land?
    try
    {
        $CultureInfo = [System.Globalization.CultureInfo]::GetCultureInfo($Culture)
    }
    catch
    {
        # ja, liess sich nicht umwandeln, also suchen:
        $CultureInfo = [System.Globalization.CultureInfo]::GetCultures('InstalledWin32Cultures') |
          Where-Object { $_.DisplayName -like "*$Culture*" -or $_.NativeName -like "*$Culture*" } |
          Select-Object -First 1
    }
    
    $Pattern = $CultureInfo.DateTimeFormat.$FormatName

    # wenn der Anwender -Verbose angibt, werden das verwendete Muster und die Kultur angegeben:
    Write-Verbose "Das verwendete Muster lautet: '$Pattern'"
    Write-Verbose "Die verwendete Kultur lautet: '$CultureInfo'"
  }

  Process
  {
    # Datum/Zeit in $DateTime mit toString() in gewünschter Form und Kultur ausgeben:
    $DateTime.ToString($Pattern, $CultureInfo)
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k14 Statische Methoden eines Typs\Skripts\Find-TypeByCommandName.ps1
************************************************************************
﻿Function Find-TypeByCommandName
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
  Foreach-Object { $_.GetMethods() | Where-Object { $_.Name -like $Keyword } | Sort-Object -Property Name -Unique } |
  # die allgemeinen Methoden nach den Ausschlusslisten entfernen:
  Where-Object { $_.Name -notmatch "^($excludeStarting)" } |
  Where-Object { $_.Name -notmatch "($excludeEnding)$" } |
  Where-Object { $_.Name -notmatch "$excludeAll" } |
  Select-Object -Property Name, DeclaringType
}

Find-TypeByCommandName '*Network*' | Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k14 Statische Methoden eines Typs\Skripts\Find-TypeByName.ps1
************************************************************************
﻿Function Find-TypeByName
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

Find-TypeByName 'dialog' | Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k14 Statische Methoden eines Typs\Skripts\Get-PowerShellExample.ps1
************************************************************************
﻿Function Get-PowerShellExample
{
    param
    (
        $RegExFilter = '.'
    )
  Add-Type -AssemblyName System.Web
  $ProgressPreference = 'SilentlyContinue'

  [AppDomain]::CurrentDomain.GetAssemblies() | 
  ForEach-Object { $_.GetExportedTypes() }  |
  Where-Object { $_.isPublic} |
  Where-Object { $_.isClass } |
  Where-Object { $_.Name -notmatch '(Attribute|Handler|Args|Exception|Collection|Expression|Parser|Statement)$' } |
  Where-Object { $_.Name -notlike '*``*' } |
  Where-Object { $_.Fullname -match $RegExFilter } |
  Select-Object -Property Name, FullName |
  ForEach-Object {
    $TypeName = $_.Name
    $suche = '"New-Object {0}" PowerShell' -f $_.FullName
    $url = 'http://www.google.de/search?hl=de&as_q={0}' -f [System.Web.HttpUtility]::UrlEncode($suche)
    $result = Invoke-WebRequest -Uri $url
    $anzahl = if ( $result.Content -match '((?:\d{1,3}\.)*\d{1,3})\s*Ergebnisse' ) { [Int]($matches[1] -replace '[.,]') } else { 
    -1
    
     }
    Write-Host ('Zu "{0}" wurden {1:n} Treffer gefunden.' -f $TypeName, $anzahl) -ForegroundColor DarkYellow
    $result.Links |
    Where-Object { $_.href.StartsWith('/url?') } |
    ForEach-Object {
      $rv = 1 | Select-Object -Property TypeName, Thema, URL, Anzahl, Object, Type
      $rv.TypeName = $TypeName
      $rv.Anzahl = $anzahl
      $rv.URL =

      if ($_.href -match 'q=(.*?);')
      {
        $matches[1]
      }
      else
      {
        $_.href
      }

      $rv.Thema = $_.outerText
      $rv.Object = $true
      $rv.Type = $false
      $rv
    }
  }
}

$OutputPath = Split-Path $profile
$OutputFile = Join-Path -Path $OutputPath -ChildPath 'weblinks.csv'

if ( (Test-Path $OutputPath) -eq $false)
{
    $null = New-Item -Path $OutputPath -ItemType Directory -Force
}

Get-PowerShellExample | 
  Out-GridView -PassThru |
  Export-CSV -Path $OutputFile -Encoding UTF8 -NoTypeInformation -UseCulture



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k14 Statische Methoden eines Typs\Skripts\Get-TypeAccelerator.ps1
************************************************************************
﻿Function Get-TypeAccelerator
{
  $typname = 'System.Management.Automation.TypeAccelerators'
  $typ = [psobject].Assembly.GetType($typname)
  ($typ::Get).GetEnumerator() |
  Where-Object { $_.Value.FullName -notlike '*attribute' } |
  Sort-Object -Property Key 
}

Get-TypeAccelerator | Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k14 Statische Methoden eines Typs\Skripts\openfiledialog.ps1
************************************************************************
﻿

$dialog = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$dialog.AddExtension = $true
$dialog.Filter = 'PowerShell-Skript (*.ps1)|*.ps1|Alle Dateien|*.*'
$dialog.Multiselect = $false
$dialog.FilterIndex = 0
$dialog.InitialDirectory = "$home\Documents"
$dialog.RestoreDirectory = $true
$dialog.ShowReadOnly = $true
$dialog.ReadOnlyChecked = $true
$dialog.Title = 'Suchen Sie sich ein PowerShell-Skript aus!'
$result = $dialog.ShowDialog()

if ($result = 'OK')
{
    $filename = $dialog.FileName
    $readonly = $dialog.ReadOnlyChecked
    if ($readonly) { $wie = 'schreibgeschützt' } else { 'normal' }
    "Es soll die Datei '$filename' $wie geöffnet werden"
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k14 Statische Methoden eines Typs\Skripts\search_types1.ps1
************************************************************************
﻿[System.Diagnostics.Process].Assembly.GetExportedTypes() | 
  Where-Object { $_.isPublic} | 
  Where-Object { $_.isClass } |
  Where-Object { $_.Name -notmatch '(Attribute|Handler|Args|Exception|Collection|Expression|Parser|Statement)$' } |
  Select-Object -Property Name, FullName |
  Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k15 neue Typen und API\Skripts\Convert-PictureFile.ps1
************************************************************************
﻿Function Convert-PictureFile
{
  param
  (
    [Parameter(Mandatory=$true,
      ValueFromPipelineByPropertyName=$true,
      ValueFromPipeline=$true,
      Position=0)]
    [Alias('FullName')]
    [String]
    $Path,

    $TargetFolder = "$env:temp\TargetFolder", 

    [ValidateSet('BMP', 'JPEG', 'GIF', 'TIFF', 'PNG')]
    $TargetFormat = 'PNG'
  )

  Begin
  {
    Add-Type -AssemblyName 'System.Drawing'
    $ImageCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
        Where-Object { $_.FormatDescription -eq $TargetFormat }

    $TargetExtension = $ImageCodec.FilenameExtension.Replace('*','').Split(';')
    if ( (Test-Path -Path $TargetFolder) -eq $false)
    { $null = New-Item -Path $TargetFolder -ItemType Directory }
  }

  Process
  {
    if ($TargetExtension -notcontains [System.IO.Path]::GetExtension($Path))
    {
      $quellname = [System.IO.Path]::GetFileName($Path)
      $zielname = [System.IO.Path]::ChangeExtension($quellname, $TargetExtension[0])
      Write-Host "Konvertiere '$quellname'..." -NoNewline
      $NewPath = Join-Path -Path $TargetFolder -Child $zielname
      $Image = [system.drawing.image]::FromFile($Path)
      $Image.Save($NewPath, $ImageCodec.FormatId)
      $Image.Dispose()
      Write-Host "nach '$zielname': OK."
    }
  }
}

Get-ChildItem -Path $env:windir -Filter *.jpg -Recurse -ErrorAction SilentlyContinue |
  Convert-PictureFile -TargetFormat PNG -TargetFolder $env:temp\Pictures

Invoke-Item -Path $env:temp\Pictures



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k15 neue Typen und API\Skripts\ConvertTo-ZIP.ps1
************************************************************************
# Ordner bestimmen, in dem Skript sich befindet:
# (in Modulen ist das der Inhalt von $PSScriptRoot)
$SelfPath = Split-Path $MyInvocation.MyCommand.Definition

# DLL nachladen:
Add-Type -Path "$SelfPath\Ionic.Zip.dll"

Function ConvertTo-ZIP
{
  [CmdletBinding()]

  param
  (
    [Parameter(Mandatory=$true)]
    # Pfadname zur ZIP-Datei
    $ZipPath,

    [Parameter(ValueFromPipeline=$true,Mandatory=$true)]
    # Pfadname der zu verpackenden Datei
    $Path,

    [Switch]
    # selbstextrahierendes Archiv erzeugen
    $SelfExtract
  )

  Begin
  {
    # Neues Objekt vom geladenen Typ "Ionic.Zip.ZipFile" herstellen:
    $zipfile = New-Object Ionic.Zip.ZipFile
  }

  Process
  {
    $Path | ForEach-Object {
      $FileObject = $_

      # wurde ein Textpfad angegeben?
      if ($FileObject -is [String])
      {
        # ja, dann Dateiobjekt beschaffen, wenn es existiert:
        if ((Test-Path -Path $FileObject))
        {
          $FileObject = Get-Item $FileObject
        }
      }

      # Ordner oder Datei?
      try {
        if ($FileObject -is [System.IO.DirectoryInfo])
        {
          # Ordner, also im ZIP-File einen Ordner anlegen:
          $e = $zipfile.AddDirectory($FileObject.FullName, '')
        }
        elseif ($FileObject -is [System.IO.FileInfo])
        {
          # Datei, also Datei zu ZIP-File hinzuf�gen:
          $e = $zipfile.AddFile($FileObject.FullName, '')
        }
      } catch {
        Write-Warning "ConvertTo-ZIP: $($_.Exception.InnerException.Message)"
      }
    }
  }

  End
  {
    # wird ein selbstextrahierendes Archiv gew�nscht?
    if ($SelfExtract)
    {
      # ja, Dateierweiterung ggfs. anpassen:
      $ZipPath = [System.IO.Path]::ChangeExtension($ZipPath, '.exe')

      # Alternative: "WinFormsApplication" statt "ConsoleApplication":
      $zipfile.SaveSelfExtractor($ZipPath, 'ConsoleApplication')
    }
    else
    {
      $zipfile.Save($ZipPath)
    }

    # Objekt freigeben:
    $zipfile.Dispose()
    Write-Warning "Saved ZIP-file to '$ZIPPath'"
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erl�utert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollst�ndig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag �bernehmen eine Haftung f�r Folgen, die durch die Ausf�hrung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k15 neue Typen und API\Skripts\Download_Video.ps1
************************************************************************
﻿# benötigte Assembly nachladen:
Add-Type -AssemblyName Microsoft.VisualBasic

# Downloadadresse einer Datei:
$URL = 'http://anon.nasa-global.edgesuite.net/anon.nasa-global/NASAHD/sts-116/STS-116_LaunchHD_480p.wmv'

# Hier soll die Datei gespeichert werden:
$Path = "$env:temp\video.wmv"

# Objekt mit Downloadmethoden beschaffen:
$objekt = New-Object Microsoft.VisualBasic.Devices.Network

# Download durchführen:
$objekt.DownloadFile($URL, $Path, '', '', $true, 500, $true, "DoNothing")

# Datei öffnen
Invoke-Item $Path


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k15 neue Typen und API\Skripts\Download_VideoShort.ps1
************************************************************************
﻿(New-Object Microsoft.VisualBasic.Devices.Network).DownloadFile('http://anon.nasa-global.edgesuite.net/anon.nasa-global/NASAHD/sts-116/STS-116_LaunchHD_480p.wmv', "$env:temp\video.wmv", '', '', $true, 500, $true, "DoNothing"); Invoke-Item "$env:temp\video.wmv"




################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Convert-CSV.ps1
************************************************************************
﻿function Convert-CSV
{
    param
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [Alias('FullName')]
        [String]
        $Path,

        [Parameter(Mandatory=$true)]
        [Char]
        $NewDelimiter,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [Char]
        $OriginalDelimiter = (Get-Culture).TextInfo.ListSeparator,

        [ValidateSet('Unicode','UTF7','UTF8','ASCII','UTF32','BigEndianUnicode','Default','OEM')]
        [String]
        $Encoding = 'UTF8'
    )

    process
    {
        if ($OriginalDelimiter -ne $NewDelimiter)
        {
           (Import-CSV -Path $Path -Delimiter $OriginalDelimiter -Encoding $Encoding) |
              Export-CSV -Path $Path -Delimiter $NewDelimiter -Encoding $Encoding
        }
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Expand-Path1.ps1
************************************************************************
﻿function Expand-Path
{
    param
    (
        [Parameter(Mandatory=$true)]
        $Path
    )

    Resolve-Path -Path $Path -ErrorAction SilentlyContinue |
      Select-Object -Property Path, Drive, File, Extension |
      ForEach-Object {
        $_.Drive = [System.IO.Path]::GetPathRoot($_.Path)
        $_.File = [System.IO.Path]::GetFileNameWithoutExtension($_.Path)
        $_.Extension = [System.IO.Path]::GetExtension($_.Path)

        $_
      }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Expand-Path2.ps1
************************************************************************
﻿function Expand-Path
{
    param
    (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        $Path
    )

    process
    {
      Resolve-Path -Path $Path -ErrorAction SilentlyContinue |
        Select-Object -Property Path, Drive, File, Extension |
        ForEach-Object {
          $_.Drive = [System.IO.Path]::GetPathRoot($_.Path)
          $_.File = [System.IO.Path]::GetFileNameWithoutExtension($_.Path)
          $_.Extension = [System.IO.Path]::GetExtension($_.Path)

          $_
        }
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Expand-Path3.ps1
************************************************************************
﻿function Expand-Path
{
    param
    (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [Alias('FullName')]
        [String]
        $Path
    )

    process
    {
      Resolve-Path -Path $Path -ErrorAction SilentlyContinue |
        Select-Object -Property Path, Drive, File, Extension |
        ForEach-Object {
          $_.Drive = [System.IO.Path]::GetPathRoot($_.Path)
          $_.File = [System.IO.Path]::GetFileNameWithoutExtension($_.Path)
          $_.Extension = [System.IO.Path]::GetExtension($_.Path)

          $_
        }
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Expand-Path4.ps1
************************************************************************
﻿function Expand-Path
{
    param
    (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [Alias('FullName','FileName')]
        [String]
        $Path,

        $Drive = '*',
        $File = '*',
        $Extension = '*'
    )

    process
    {
      Resolve-Path -Path $Path -ErrorAction SilentlyContinue |
        Select-Object -Property Path, Drive, File, Extension |
        ForEach-Object {
          $_.Drive = [System.IO.Path]::GetPathRoot($_.Path)
          $_.File = [System.IO.Path]::GetFileNameWithoutExtension($_.Path)
          $_.Extension = [System.IO.Path]::GetExtension($_.Path)

          $_
        } |
        Where-Object { $_.Drive -like "*$Drive*" } |
        Where-Object { $_.File -like "*$File*" } |
        Where-Object { $_.Extension -like "*$Extension*" }
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Expand-Path5.ps1
************************************************************************
﻿function Expand-Path
{
    param
    (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [Alias('FullName','FileName')]
        [String]
        $Path,

        $Drive = '*',
        $File = '*',
        $Extension = '*'
    )

    process
    {
      $result = Resolve-Path -Path $Path -ErrorAction SilentlyContinue 
      if ($result -eq $null)
      {
        $result = 'dummy' | Select-Object -Property Path
        $result.Path = $Path
      }
      
      $result |
        Select-Object -Property Path, Drive, File, Extension |
        ForEach-Object {
          $_.Drive = (Split-Path -Path $_.Path -Qualifier).toLower()
          $_.File = [System.IO.Path]::GetFileNameWithoutExtension($_.Path).toLower()
          $_.Extension = [System.IO.Path]::GetExtension($_.Path).toLower()

          $_
        } |
        Where-Object { $_.Drive -like "*$Drive*" } |
        Where-Object { $_.File -like "*$File*" } |
        Where-Object { $_.Extension -like "*$Extension*" }
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Get-CSVDelimiter.ps1
************************************************************************
﻿Function Get-CSVDelimiter
{
  param
  (
    [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
    [Alias('FullName')]
    [String]
    $Path
  )

  Begin
  {
    # ASCII-Codes, die als Trennzeichen nicht verwendet werden: 0-9, A-Z, a-z, and space:
    $excluded = ([Int][Char]'0'..[Int][Char]'9') + ([Int][Char]'A'..[Int][Char]'Z') + ([Int][Char]'a'..[Int][Char]'z')  + 32

    Function Get-DelimitersFromLine
    {
      param
      (
        $TextLine
      )

      $quoted = $false
      $result = @{}

      # Zeile zeichenweise untersuchen:

      ForEach ($char in $line.ToCharArray())
      {
        # bei Anführungszeichen ein Flag umschalten, um Text innerhalb von
        # Anführungszeichen nicht zu berücksichtigen:

        if ($char -eq '"')
        {
          $quoted = -not $quoted
        }
        elseif ($quoted -eq $false)
        {
          if ($excluded -notcontains [Int]$char)
          {
            $result.$([Int]$char) ++
          }
        }
      }

      $result
    }
  }

  Process
  {
    $oldcandidates = $null

    ForEach ($line in (Get-Content -Path $Path -ReadCount 0))
    {
      $candidates = Get-DelimitersFromLine $line

      # wenn dies die erste Zeile einer CSV-Datei ist, nicht
      # analysieren, weil noch kein Vergleich möglich ist:

      if ($oldcandidates -eq $null)
      {
        # wenn erste Zeile mit "#" beginnt, ignorieren:
        if (-not $line.StartsWith('#'))
        {
          $oldcandidates = $candidates
        }
      }
      else
      {
        $new = @{}
        $keys = $oldcandidates.Keys

        ForEach ($key in $keys)
        {
          if ($candidates.$key -eq $oldcandidates.$key)
          {
            $new.$key = $candidates.$key
          }
        }

        $oldcandidates = $new

        # sobald nur noch ein Trennzeichen in Frage kommt, ist die
        # Arbeit getan, und die Schleife kann vorzeitig verlassen werden:
        if ($oldcandidates.keys.count -lt 2)
        {
          break
        }
      }
    }

    # Rückgabeobjekt anlegen und füllen:
    $rv = New-Object PSObject | Select-Object -Property Path, Name, Delimiter, FriendlyName, ASCII, Rows, Status
    $rv.Path = $Path
    $rv.Name = Split-Path -Path $path -Leaf

    if ($oldcandidates.keys.count -eq 0)
    {
      $rv.Status = 'No delimiter found'
    }
    elseif ($oldcandidates.keys.count -eq 1)
    {
      $ascii = $oldcandidates.keys | ForEach-Object { $_ }
      $rv.ASCII = $ascii
      # ASCII-Code in echtes Zeichen verwandeln:
      $rv.Delimiter = [String][Char]$ascii
      # Anzahl der Spalten in CSV-Datei ist die Häufigkeit
      # des Trennzeichens in der Zeile plus eins:
      $rv.rows = $oldcandidates.$ascii + 1

      switch ($ascii)
      {
        9    { $rv.FriendlyName = 'TAB' }
        44   { $rv.FriendlyName = 'Comma' }
        59   { $rv.FriendlyName = 'Semicolon' }
      }
      $rv.Status = 'Found'
    }
    else
    {
      # Alle infrage kommenden Trennzeichen in kommaseparierte Liste verwandeln:
      $delimiters = (($oldcandidates.keys | ForEach-Object { ('"{0}"' -f [String][Char]$_) }) -join ',')
      $rv.Status =  "Ambiguous separator keys: $delimiters"
    }

    $rv
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\New-User.ps1
************************************************************************
﻿function New-User
{
    param
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [String]
        $Name,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [String]
        $Vorname,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [Int]
        $ID
    )

    process
    {
        "Hier könnte der User $Vorname $Name mit der ID $ID angelegt werden."      
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Select-OldFile.ps1
************************************************************************
﻿function Select-OldFile
{
    param
    (
        [Parameter(Mandatory=$true)]
        $Days,

        [Parameter(ValueFromPipeline=$true)]
        $File
    )

    process
    {
        $Age = (Get-Date) - $File.LastWriteTime
        if ($Age.Days -gt $Days) { $File }
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Show-Process.ps1
************************************************************************
﻿function Show-Process {
  Param (
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    $name,    
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    $company
  )

  Process {
    "Das Programm $name wurde hergestellt von $company"
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-Calc1.ps1
************************************************************************
﻿function Test-Calc
{
    param
    (
        [Parameter(Mandatory=$true)]
        [Double]
        $Wert
    )

    $Wert * $Wert
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-Calc2.ps1
************************************************************************
﻿function Test-Calc
{
    param
    (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [Double]
        $Wert
    )

    $Wert * $Wert
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-Calc3.ps1
************************************************************************
﻿function Test-Calc
{
    param
    (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [Double]
        $Wert
    )

    process
    {
      $Wert * $Wert
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-Function1.ps1
************************************************************************
﻿function Test-Function
{
    param
    (
        [Parameter(ValueFromPipeline=$true)]
        $InputObject
    )

    begin
    {
        $container = @()
    }

    process
    {
        $container += $InputObject
    }

    end
    {
        $count = $container.Count
        "Collected $count elements."
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-Function2.ps1
************************************************************************
﻿function Test-Function
{
    param
    (
        [Parameter(ValueFromPipeline=$true)]
        $InputObject
    )

    $count = $Input.Count
    "Collected $count elements."
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-Function3.ps1
************************************************************************
﻿function Test-Function
{
    param
    (
        [Parameter(ValueFromPipeline=$true)]
        $InputObject
    )

    $alldata = @($Input)
    $count = $alldata.Count
    "Collected $count elements."
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-Function4.ps1
************************************************************************
﻿function Test-Function
{
    "Empfangene Daten: $Input"
    "Empfangene Daten: $Input"
    $Input.Reset()
    "Empfangene Daten: $Input"
    $Input.GetType().FullName
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-Function5.ps1
************************************************************************
﻿function Test-Function
{
    $daten = @($Input)
    "Empfangene Daten: $Daten"
    "Empfangene Daten: $Daten"
    "Empfangene Daten: $Daten"
    $daten.GetType().FullName
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-PipelineInput1.ps1
************************************************************************
﻿function Test-PipelineInput {
  param (
    [Parameter(ValueFromPipeline=$true)]
    [Double]
    $zahl,
    
    [Parameter(ValueFromPipeline=$true)]
    [DateTime]
    $datum,
    
    [Parameter(ValueFromPipeline=$true)]
    [Bool]
    $boolean
  )
  
  process {
    "Zahl: $zahl"
    "Datum: $datum"
    "Ja/Nein: $boolean"
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k16 pipelinef�hige funktionen\Skripts\Test-PipelineInput2.ps1
************************************************************************
﻿function Test-PipelineInput {
  [CmdletBinding(DefaultParameterSetName='zahl')]
  param (
    [Parameter(ParameterSetName='zahl',ValueFromPipeline=$true)]
    [Double]
    $zahl,
    
    [Parameter(ParameterSetName='datum', ValueFromPipeline=$true)]
    [DateTime]
    $datum,
    
    [Parameter(ParameterSetName='boolean', ValueFromPipeline=$true)]
    [Bool]
    $boolean
  )
  
  process {
    switch ($PSCmdlet.ParameterSetName) {
    'zahl' {"Zahl: $zahl"}
    'datum' {"Datum: $datum"}
    'boolean' {"Ja/Nein: $boolean"}
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k17 Fortgeschrittene R�ckgabewerte\Skripts\Get-PathComponent1.ps1
************************************************************************
﻿Function Get-PathComponent
{
  param
  (
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    $Path
  )

  $result = New-Object PSObject |
  Select-Object -Property Parent, FileName, Extension, Drive, BaseName, Path

  try {
    $Path = $Path.ToLower()
    $result.FileName = [System.IO.Path]::GetFileName($Path)
    $result.BaseName = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    $result.Extension = [System.IO.Path]::GetExtension($Path)
    $result.Parent = [System.IO.Path]::GetDirectoryName($Path)
    $result.Drive  = [System.IO.Path]::GetPathRoot($Path)
    $result.Path = $Path
  }
  catch
  {}
  $result
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k17 Fortgeschrittene R�ckgabewerte\Skripts\Get-PathComponent2.ps1
************************************************************************
﻿Function Get-PathComponent
{
  param
  (
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    $Path
  )

  $result = New-Object PSObject |
  Select-Object -Property Parent, FileName, Extension, Drive, BaseName, Path

  try {
    $Path = $Path.ToLower()
    $result.FileName = [System.IO.Path]::GetFileName($Path)
    $result.BaseName = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    $result.Extension = [System.IO.Path]::GetExtension($Path)
    $result.Parent = [System.IO.Path]::GetDirectoryName($Path)
    $result.Drive  = [System.IO.Path]::GetPathRoot($Path)
    $result.Path = $Path
  }
  catch
  {}

  # ETS: gewünschte Defaulteigenschaften
  [String[]]$properties = 'BaseName','Extension','Parent'
  [System.Management.Automation.PSMemberInfo[]]$PSStandardMembers = New-Object System.Management.Automation.PSPropertySet DefaultDisplayPropertySet,$properties

  # an Rückgabeobjekt anhängen:  
  $result | Add-Member -MemberType MemberSet -Name PSStandardMembers -Value $PSStandardMembers

  $result
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k17 Fortgeschrittene R�ckgabewerte\Skripts\Get-PathComponent3.ps1
************************************************************************
﻿function Get-PathComponent
{
  param
  (
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    $Path
  )

  $result = New-Object PSObject |
  Select-Object -Property Parent, FileName, Extension, Drive, BaseName, Path

  try {
    $Path = $Path.ToLower()
    $result.FileName = [System.IO.Path]::GetFileName($Path)
    $result.BaseName = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    $result.Extension = [System.IO.Path]::GetExtension($Path)
    $result.Parent = [System.IO.Path]::GetDirectoryName($Path)
    $result.Drive  = [System.IO.Path]::GetPathRoot($Path)
    $result.Path = $Path
  }
  catch
  {}

  # ETS: gewünschte Defaulteigenschaften
  # PowerShell 3.0 erforderlich:
  if ($PSVersionTable.PSVersion.Major -ge 3)
  {
    Update-TypeData -DefaultDisplayPropertySet  'BaseName','Extension','Parent' -TypeName MyFormat
    $result.PSTypeNames.Add('MyFormat')
  }
  $result
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k17 Fortgeschrittene R�ckgabewerte\Skripts\json1.ps1
************************************************************************
﻿
$text = '{
    "Vorname":  "Tobias",
    "Name":  "Weltner",
    "ID":  12
}'

$objekt = ConvertFrom-Json -InputObject $text
$objekt

$objekt.Name
$objekt.Vorname

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k17 Fortgeschrittene R�ckgabewerte\Skripts\json2.ps1
************************************************************************
﻿$objekt = '{"Vorname":"Tobias","Name":"Weltner","ID":12}' | ConvertFrom-Json 
$objekt


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Configure-System.ps1
************************************************************************
﻿function Configure-System {
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\define_enum1.ps1
************************************************************************
﻿$enum = '
using System;
 
namespace Sample
{
     public enum Level
     {
         Beginner = 1,
         Advanced = 10,
         Professional = 100,
         GodlikeBeing = 102
     }
}'
Add-Type -TypeDefinition $enum


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\define_enum2.ps1
************************************************************************
﻿$enum = '
using System;
 
namespace Sample
{
     [FlagsAttribute]
     public enum LevelAdvanced
     {
         Beginner = 1,
         Advanced = 2,
         Professional = 3,
         GodlikeBeing = 4
     }
}'
Add-Type -TypeDefinition $enum


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\define_enum3.ps1
************************************************************************
﻿$enum = '
using System;
 
namespace Sample
{
     [FlagsAttribute]
     public enum LevelAdvancedSeparate
     {
         Beginner = 1,
         Advanced = 2,
         Professional = 4,
         GodlikeBeing = 8
     }
}'
Add-Type -TypeDefinition $enum


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Enable-AutoPageFile.ps1
************************************************************************
﻿function Enable-AutoPageFile { 
  [CmdletBinding(SupportsShouldProcess=$True)]
  param()
  
  $computer = Get-WmiObject -class Win32_ComputerSystem -EnableAllPrivileges
  $computer.AutomaticManagedPagefile=$true
  if ($PSCmdlet.ShouldProcess($env:computername, "Automatische Auslagerungsdatei einschalten")) 
  { 
    $computer.Put() | Out-Null 
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Find-Enum.ps1
************************************************************************
﻿<#
  .SYNOPSIS
  Searches assemblies for enumeration data types that can be used to declare PowerShell function parameters
  .DESCRIPTION
  By default, only default assemblies are searched that are generally available in PowerShell. 
  With the switch parameter -All, all currently loaded assemblies are searched.
  The results may then include types that are not commonly available and may require modules or assemblies to be loaded first.
  .EXAMPLE
  Find-Enum
  lists all enumeration data types for all default assemblies
  .EXAMPLE
  Find-Enum *comput*
  lists all enumeration data types for all default assemblies that contain at least one value that matches
"*comput*
  .EXAMPLE
  Find-Enum red -All
  finds all enumeration data types in all currently loaded assemblies that contain the value "red"
#>
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
  Where-Object { $_.isEnum } |
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Get-Data.ps1
************************************************************************
﻿function Get-Data
{
    [CmdletBinding()]
    param()

    for($x=0; $x -lt 100; $x++) { Start-Sleep -milli 400;  $x }
}

Get-Data -OutBuffer 5 | ForEach-Object { "empfangen: $_" }


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Get-Drive1.ps1
************************************************************************
﻿function Get-Drive
{
    Get-WmiObject -Class Win32_LogicalDisk | 
      Select-Object DeviceID, VolumeName, Size, FreeSpace
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Get-Drive2.ps1
************************************************************************
﻿function Get-Drive
{
  param
  (
    $ComputerName,
    $Credential
  )

    Get-WmiObject -Class Win32_LogicalDisk @PSBoundParameters | 
      Select-Object DeviceID, VolumeName, Size, FreeSpace
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Get-Drive3.ps1
************************************************************************
﻿function Get-Drive
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Get-ErrorEvents.ps1
************************************************************************
﻿function Get-ErrorEvents
{ 
    [OutputType('System.Diagnostics.EventLogEntry')]
    param()

    Get-EventLog -LogName System -EntryType Error
}  


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\list_common_parameters.ps1
************************************************************************
﻿[System.Management.Automation.Internal.CommonParameters].GetProperties() |
    Foreach-Object {
     $rv = $_ | Select-Object -Property Name, PropertyType, Alias
     $rv.Alias = $_.CustomAttributes.ConstructorArguments.Value.Value -join ','
     $rv
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\listenum.ps1
************************************************************************
﻿$typ = [System.ConsoleColor]
$names = $typ.GetEnumNames()
$valuetype = $typ.GetEnumUnderlyingType()

$names | ForEach-Object { 
    $result = New-Object PSObject | Select-Object -Property Name, Value
    $result.Name = $_
    $result.Value = [System.Enum]::Parse($typ, $_) -as $valuetype
    $result
} | Format-Table -AutoSize


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\New-NETObject.ps1
************************************************************************
﻿function New-NETObject
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Out-Text1.ps1
************************************************************************
﻿function Out-Text {
  [CmdletBinding()]
  param([String]$text)
  Write-Verbose ('Der Text enthält {0} Zeichen' -f $text.Length)
  "Sie haben eingegeben: $text"
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Out-Text2.ps1
************************************************************************
﻿function Out-Text {
  [CmdletBinding()]
  param([String]$text)
  if ($text.length -gt 10) {
    Write-Warning 'Sie haben einen sehr langen Text angegeben.'
  }
  "Sie haben eingegeben: $text"
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Remove-OutputType.ps1
************************************************************************
﻿Function Remove-OutputType
{
  [CmdletBinding(SupportsShouldProcess=$true)]

  param
  (
    [Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
    [Alias('FullName')]
    [String[]]
    $Path
  )

  Process
  {
    $Path | ForEach-Object {
      $FilePath = $_

      $pattern =  '\[OutputType\(.*?\)\]'
      $content = Get-Content -Path $FilePath -Raw

      if ($content -match $pattern)
      {
        if ($PSCmdlet.ShouldProcess($_, 'Remove [Output()] attribute'))
        {
          $content -replace $pattern |
          Set-Content -Path $FilePath
        }
      }
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Select-Color1.ps1
************************************************************************
﻿function Select-Color
{
    param
    (
        [ValidateSet('Red','Green','Blue')]
        $Color
    )

    "Gewählte Farbe: $Color"
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Select-Color2.ps1
************************************************************************
﻿function Select-Color
{
    param
    (
        [System.ConsoleColor]
        $Color
    )

    "Gewählte Farbe: $Color"
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\splatting.ps1
************************************************************************
﻿$argumente = @{
    LogName = 'System'
    EntryType = 'Error', 'Warning'
    After = (Get-Date).AddDays(-1) 
}

Get-EventLog @argumente


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\sprachausgabe.ps1
************************************************************************
﻿Add-Type -AssemblyName System.Speech
$Speaker = New-Object System.Speech.Synthesis.SpeechSynthesizer
$Speaker.Rate = -10
$Speaker.Volume = 100 
$null = $Speaker.SpeakAsync('I am feeling dizzy!')



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-Binding1.ps1
************************************************************************
﻿function Test-Binding {
  [CmdletBinding(DefaultParameterSetName='Name')]
  param(
    [Parameter(ParameterSetName='ID', Position=0, Mandatory=$true)][Int]$ID,
    [Parameter(ParameterSetName='Name', Position=0, Mandatory=$true)][String]$Name
  )
  
  
  $set = $PSCmdlet.ParameterSetName
  "Sie haben Parameterset $set gewählt."
  
  if ($set -eq 'ID') {
    "Die ID ist $ID"
  } else {
    "Der Name lautet $Name"
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-Binding2.ps1
************************************************************************
﻿function Test-Binding {
   [CmdletBinding(DefaultParameterSetName='ID')]
   param(
    [Parameter(ParameterSetName='ID', Position=0, Mandatory=$true)]
    [Parameter(ParameterSetName='Name',Position=1)][Int]$Wert1,
    [Parameter(ParameterSetName='Name', Position=0, Mandatory=$true)][String]$Wert2,
    [Parameter(ParameterSetName='Name', Position=2, Mandatory=$true)][DateTime]$Wert3,
    $Wert4
  )
  
  
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-Binding3.ps1
************************************************************************
﻿function Test-Binding {
  [CmdletBinding(DefaultParameterSetName='ID')]
  param(
    [Parameter(ParameterSetName='ID', Position=0, Mandatory=$true)][Int]$ID,
    [Parameter(ParameterSetName='Name', Position=0, Mandatory=$true)][String]$Name
  )
  
  
  $set = $PSCmdlet.ParameterSetName
  "Sie haben Parameterset $set gewählt."
  
  if ($set -eq 'ID') {
    "Die ID ist $ID"
  } else {
    "Der Name lautet $Name"
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-DynamicArguments.ps1
************************************************************************
﻿# Erweiterung für die Vervollständigung mit Prozessnamen zur Laufzeit:
$completion_Process = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
    Get-Process | 
      Sort-Object -Property Name -Unique | 
      Where-Object { $_.Name -like "$wordToComplete*" } |
      ForEach-Object {
        New-Object System.Management.Automation.CompletionResult $_.Name, $_.Name, 'ParameterValue', ('{0} ({1})' -f $_.Description, $_.ID) 
    }
}

# Erweiterung in globale Variable aufnehmen und festlegen, dass die Erweiterung für die
# Funktion "Test-DynamicArguments" und dessen Parameter "ProcessName" gelten soll:
if (-not $global:options) { 
  $global:options = @{CustomArgumentCompleters = @{};NativeArgumentCompleters = @{}}
}
$global:options['CustomArgumentCompleters']['Test-DynamicArguments:ProcessName'] = $Completion_Process

# PowerShell-Codevervollständigung um die selbstdefinierten Erweiterung(en) ergänzen:
$function:tabexpansion2 = $function:tabexpansion2 -replace 'End\r\n{','End { if ($null -ne $options) { $options += $global:options} else {$options = $global:options}'

# Funktion besitzt nun eine dynamische Autovervollständigung für ihren Parameter "ProcessName":
function Test-DynamicArguments
{
    param
    (
        $ProcessName
    )

    "Hello $ProcessName"
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-DynamicParameter1.ps1
************************************************************************
﻿Function Test-DynamicParameter
{
  [CmdletBinding()]

  param
  ([Int]$Count)

  dynamicparam
  {
    $paramDictionary = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary

    ForEach ($Property in (1..$Count))
    {
      $attributes = New-Object System.Management.Automation.ParameterAttribute
      $attributes.ParameterSetName = '__AllParameterSets'
      $attributes.Mandatory = $false
      $attributeCollection = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
      $attributeCollection.Add($attributes)
      $Name = "Param$Property"
      $dynParam = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter($Name, [Int32], $attributeCollection)
      $paramDictionary.Add($Name, $dynParam)
    }

    $paramDictionary
  }

  end
  {
    "Die übergebenen Parameter:"
    $PSBoundParameters
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-DynamicParameter2.ps1
************************************************************************
﻿Function Test-DynamicParameter
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

  Dynamicparam
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
      $dynParam = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter($Name, [String], $attributeCollection)
      $paramDictionary.Add($Name, $dynParam)

      # Parameter zurückgeben:
      $paramDictionary
    }
  }

  End
  {
    'Die übergebenen Parameter:'
    $PSBoundParameters
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-ErrorAction.ps1
************************************************************************
﻿function Test-ErrorAction
{
    [CmdletBinding()]
    param()

    'Start'
    1/$null
    Get-Process NichtVorhanden
    [System.Net.DNS]::GetHostByName('gibtesnicht')
    'Ende'
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-Optional.ps1
************************************************************************
﻿function Test-Optional
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-Parameter.ps1
************************************************************************
﻿function Test-Parameter
{
    param
    (
        $Wert1,
        $Wert2,
        $Wert3
    )

    $PSBoundParameters
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-Risk1.ps1
************************************************************************
﻿function Test-Risk
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param()

    Stop-Service -Name Spooler 
    Start-Service -Name Spooler
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-Risk2.ps1
************************************************************************
﻿function Test-Risk
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k18 advanced parameter\Skripts\Test-Risk3.ps1
************************************************************************
﻿function Test-SecondFunction
{
    New-Item -Path $env:temp\somefolder -Type Directory -ErrorAction SilentlyContinue
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\createproxy.ps1
************************************************************************
﻿$metadata = New-Object System.Management.Automation.CommandMetaData (Get-Command Stop-Process)
[System.Management.Automation.ProxyCommand]::Create($metadata) | clip


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\Get-ChildItem_Ex1.ps1
************************************************************************
﻿<#
.ForwardHelpTargetName Get-ChildItem
.ForwardHelpCategory Cmdlet
#>
Function Get-ChildItem_Ex
{
  [CmdletBinding(DefaultParameterSetName='Items', SupportsTransactions=$true)]
  
  param
  (
    [Parameter(ParameterSetName='Items', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
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

    [Switch]
    $FileOnly,

    [Switch]
    $FolderOnly,

    [DateTime]
    $Before,

    [DateTime]
    $After,

    [Int64]
    $MaxFileSize,

    [Int64]
    $MinFileSize,

    [Int]
    $OlderThan,

    [Int]
    $NewerThan,

    [String]
    $Sort
  )

  Begin
  {
    try
    {
      # Initialize pre- and post-Pipeline command store:
      [String[]]$PrePipeline = ''
      [String[]]$PostPipeline = ''
      [String[]]$Pipeline = '& $wrappedCmd @PSBoundParameters'

      if ($PSBoundParameters.ContainsKey('FileOnly'))
      {
        $PostPipeline += { Where-Object { $_.PSIsContainer -eq $false } }
      }

      if ($PSBoundParameters.ContainsKey('FolderOnly'))
      {
        $PostPipeline += { Where-Object { $_.PSIsContainer -eq $true } }
      }

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
      $scriptCmd = [ScriptBlock]::Create( (($PrePipeline + $Pipeline + $PostPipeline) | Where-Object { $_ }) -join ' | ')

      $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
      $steppablePipeline.Begin($PSCmdlet)
    } catch {
      throw
    }
  }

  Process
  {
    try
    {
      $steppablePipeline.Process($_)
    } catch {
      throw
    }
  }

  End
  {
    try
    {
      $steppablePipeline.End()
    } catch {
      throw
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\Get-ChildItem_Ex2.ps1
************************************************************************
﻿<#
.ForwardHelpTargetName Get-ChildItem
.ForwardHelpCategory Cmdlet
#>
Function Get-ChildItem_Ex
{
  [CmdletBinding(DefaultParameterSetName='Items', SupportsTransactions=$true)]
  
  param
  (
    [Parameter(ParameterSetName='Items', Position=0)]
    [string[]]
    $Path,

    [Parameter(ParameterSetName='LiteralItems', Mandatory=$true)]
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

    [Switch]
    $FileOnly,

    [Switch]
    $FolderOnly,

    [DateTime]
    $Before,

    [DateTime]
    $After,

    [Int64]
    $MaxFileSize,

    [Int64]
    $MinFileSize,

    [Int]
    $OlderThan,

    [Int]
    $NewerThan,

    [String]
    $Sort
  )

  # Initialize pre- and post-Pipeline command store:
  [String[]]$PostPipeline = ''
  [String[]]$Pipeline = '& Get-ChildItem @PSBoundParameters'

  if ($PSBoundParameters.ContainsKey('FileOnly'))
  {
    $PostPipeline += { Where-Object { $_.PSIsContainer -eq $false } }
  }

  if ($PSBoundParameters.ContainsKey('FolderOnly'))
  {
    $PostPipeline += { Where-Object { $_.PSIsContainer -eq $true } }
  }

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
  & ([ScriptBlock]::Create((($Pipeline + $PostPipeline) | Where-Object {$_}) -join ' | '))
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\New-ProxyFunction.ps1
************************************************************************
﻿Function New-ProxyFunction
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\Out-Default1.ps1
************************************************************************
﻿Function Out-Default
{
  param
  (
    [Parameter(ValueFromPipeline=$true)]
    $InputObject
  )

  Process
  {
    "Ich gebe aus: $_"
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\Out-Default2.ps1
************************************************************************
﻿function Out-StringEx
{
    param
    (
        [Parameter(ValueFromPipeline=$true)]
        $InputObject
    )

    begin
    {
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Out-String', 'Cmdlet')
        $scriptCmd = {&  $wrappedCmd -OutVariable script:TranscriptContent -Stream | Out-Null }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    }


    process
    {
        $steppablePipeline.Process($_)
        $_
    }

    end
    {
        $steppablePipeline.End()
    }   
}

Function Out-Default
{
  param
  (
    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    $InputObject
  )

  Begin
  {
    try {
      $OriginalCommand = $null
      $script:TranscriptContent = $null 
      $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Out-Default', 'Cmdlet')

      if ($global:isTranscribing)
      {
        $scriptCmd = { Out-StringEx | & $wrappedCmd }
      }
      else
      {
        $scriptCmd = {& $wrappedCmd }
      }

      $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
      $steppablePipeline.Begin($PSCmdlet)
    } catch {
      throw
    }
  }

  Process
  {
    try {
      $steppablePipeline.Process($_)

      if ($global:isTranscribing)
      {
        if ($OriginalCommand -eq $null)
        {  
           $cmd = (Get-Variable -Name MyInvocation -Scope 1).Value.MyCommand.Definition
           $OriginalCommand = '{0}{1}' -f (prompt), $cmd
        }
      }
    } catch {
      throw
    }
  }

  End
  {
    try {
      $steppablePipeline.End()
    } catch {
      throw
    }
    finally
    {
      if ($global:isTranscribing)
      {
        $OriginalCommand | Out-File -Append -FilePath $global:TranscriptPath
        $script:TranscriptContent | Out-File -Append -FilePath $global:TranscriptPath
        $script:TranscriptContent=$null
      }
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\Out-LogFile1.ps1
************************************************************************
﻿function Out-LogFile
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\Out-LogFile2.ps1
************************************************************************
﻿function Out-LogFile
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\Out-LogFile3.ps1
************************************************************************
﻿function Out-LogFile
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\ProxyGenerator\New-FunctionFromCmdlet.ps1
************************************************************************
[Error] - File could not be written...


c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k19 proxyfunktionen\Skripts\Start-Transcript.ps1
************************************************************************
﻿Function Start-Transcript
{
  param
  (
    [Parameter(Position=0)]
    [ValidateNotNullOrEmpty()]
    [Alias('LiteralPath','PSPath')]
    [string]
    $Path='',

    [switch]
    $Append,

    [switch]
    $Force,

    [Alias('NoOverwrite')]
    [switch]
    $NoClobber
  )

  if($global:isTranscribing)
  {
  Throw 'Start-Transcript : Transcription has already been started. Use the stop-transcript command to stop transcription.'
  }

  $timestamp = Get-Date -Format yyyyMMddHHmmss
  $username = "$env:USERDOMAIN\$env:username"
  $os = Get-WmiObject -Class Win32_OperatingSystem
  $operatingsystem = '{0} ({1} {2} {3})' -f $os.CSName,$os.Caption, $os.Version, $os.CSDVersion

  if ($Path -eq '')
  {
    $Folder = Split-Path (Split-Path $profile) 
    $File = "PowerShell_transcript.$timestamp.txt"
    $Path = Join-Path -Path $Folder -ChildPath $File
  }
  if ($NoClobber)
  {
    if (Test-Path -Path $Path)
    {
      Throw "Start-Transcript: File $Path already exists and NoClobber was specified."
    }
  }


  $header = "
**********************
Windows PowerShell transcript start
Start time: $timestamp
Username  : $username
Machine	  : $operatingsystem
**********************
Transcript started, output file is $path
"
  $header | Out-File -FilePath $Path -Append:$Append -Force:$Force
  Remove-Variable TranscriptContent -Scope Script
  "Transcript started, output file is $path" 
  $global:isTranscribing=$true
  $global:TranscriptPath=$Path
  
}

Function Stop-Transcript
{
  param()

  if ($global:isTranscribing)
  {
    $global:isTranscribing=$false
    "Transcript stopped, output file is $global:TranscriptPath"
  }
  else
  {
    Throw 'Stop-Transcript : An error occurred stopping transcription: The host is not currently transcribing.'
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k2 cmdlets\Scripts\download_video.ps1
************************************************************************
﻿Import-Module BITSTransfer -Verbose

$url = 'http://anon.nasa-global.edgesuite.net/HD_downloads/HD_Earth_Views.mov'
Start-BitsTransfer $url $HOME\video1.wmv
Invoke-Item $HOME\video1.wmv


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k20 Module\Modulbeispiel dynamisch\WindowsPowerShell\Modules\UniversalModul\Get-SoftwareUpdate3.ps1
************************************************************************
﻿Function Get-SoftwareUpdate
{
  $filter = @{
    logname='Microsoft-Windows-Application-Experience/Program-Inventory'
    id=905
  }
  Get-WinEvent -FilterHashtable $filter |
  ForEach-Object { 
    $info = 1 | Select-Object Datum, Anwendung, Version, Herausgeber, Sprache, Typ
    $info.Datum = $_.TimeCreated
    $info.Anwendung = $_.Properties[0].Value
    $info.Version = $_.Properties[1].Value
    $info.Herausgeber = $_.Properties[2].Value
    $info.Sprache = $_.Properties[3].Value
    $info.Typ = $_.Properties[4].Value
    $info.pstypenames.Insert(0,'mySoftwareUpdateResults') 
    $info
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k20 Module\Modulbeispiel dynamisch\WindowsPowerShell\Modules\UniversalModul\mySoftwareUpdateResult.format.ps1xml
************************************************************************
﻿<Configuration>
   

  <!-- ################ VIEW DEFINITIONS ################ -->

  <ViewDefinitions>    
    <View>
      <Name>UpdateResult</Name>
      <ViewSelectedBy>
        <TypeName>mySoftwareUpdateResults</TypeName>
      </ViewSelectedBy>      
      <TableControl>
        <TableHeaders>
          <TableColumnHeader>
            <Label>Datum</Label>
            <Width>19</Width>
            <Alignment>left</Alignment>
          </TableColumnHeader>
          <TableColumnHeader>
            <Label>Anwendung</Label>
            <Alignment>left</Alignment>
          </TableColumnHeader> 
	  <TableColumnHeader>
            <Label>Version</Label>
            <Alignment>right</Alignment>
            <Width>15</Width>
          </TableColumnHeader>          
        </TableHeaders>
        <TableRowEntries>
          <TableRowEntry>
            <Wrap/>
            <TableColumnItems>
              <TableColumnItem>
                <PropertyName>Datum</PropertyName>
              </TableColumnItem>
              <TableColumnItem>
                <PropertyName>Anwendung</PropertyName>
              </TableColumnItem>
	      <TableColumnItem>
                <PropertyName>Version</PropertyName>
              </TableColumnItem>              
            </TableColumnItems>
          </TableRowEntry>
        </TableRowEntries>
      </TableControl>
    </View>
  </ViewDefinitions>
</Configuration>



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k20 Module\Modulbeispiel dynamisch\WindowsPowerShell\Modules\UniversalModul\problematische_skriptdatei.ps1
************************************************************************
﻿
# Beispiel für ein Skript, das so wie es ist,
# NICHT in ein Modul integriert werden sollte, weil
# es SOFORT Befehle ausführt.

# OK: eine Funktionsdefinition
function Some-Command
{
  Start-Sleep -Seconds 3
}

# FALSCH: Funktion wird direkt im Skript aufgerufen
Some-Command

# FALSCH: Befehle werden sofort im Skript aufgerufen
Get-Process



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k20 Module\Modulbeispiel statisch\WindowsPowerShell\Modules\MeineTools\Get-SoftwareUpdate3.ps1
************************************************************************
﻿Function Get-SoftwareUpdate
{
  $filter = @{
    logname='Microsoft-Windows-Application-Experience/Program-Inventory'
    id=905
  }
  Get-WinEvent -FilterHashtable $filter |
  ForEach-Object { 
    $info = 1 | Select-Object Datum, Anwendung, Version, Herausgeber, Sprache, Typ
    $info.Datum = $_.TimeCreated
    $info.Anwendung = $_.Properties[0].Value
    $info.Version = $_.Properties[1].Value
    $info.Herausgeber = $_.Properties[2].Value
    $info.Sprache = $_.Properties[3].Value
    $info.Typ = $_.Properties[4].Value
    $info.pstypenames.Insert(0,'mySoftwareUpdateResults') 
    $info
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k20 Module\Modulbeispiel statisch\WindowsPowerShell\Modules\MeineTools\mySoftwareUpdateResult.format.ps1xml
************************************************************************
﻿<Configuration>
   

  <!-- ################ VIEW DEFINITIONS ################ -->

  <ViewDefinitions>    
    <View>
      <Name>UpdateResult</Name>
      <ViewSelectedBy>
        <TypeName>mySoftwareUpdateResults</TypeName>
      </ViewSelectedBy>      
      <TableControl>
        <TableHeaders>
          <TableColumnHeader>
            <Label>Datum</Label>
            <Width>19</Width>
            <Alignment>left</Alignment>
          </TableColumnHeader>
          <TableColumnHeader>
            <Label>Anwendung</Label>
            <Alignment>left</Alignment>
          </TableColumnHeader> 
	  <TableColumnHeader>
            <Label>Version</Label>
            <Alignment>right</Alignment>
            <Width>15</Width>
          </TableColumnHeader>          
        </TableHeaders>
        <TableRowEntries>
          <TableRowEntry>
            <Wrap/>
            <TableColumnItems>
              <TableColumnItem>
                <PropertyName>Datum</PropertyName>
              </TableColumnItem>
              <TableColumnItem>
                <PropertyName>Anwendung</PropertyName>
              </TableColumnItem>
	      <TableColumnItem>
                <PropertyName>Version</PropertyName>
              </TableColumnItem>              
            </TableColumnItems>
          </TableRowEntry>
        </TableRowEntries>
      </TableControl>
    </View>
  </ViewDefinitions>
</Configuration>



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k20 Module\Skripts\Get-SoftwareUpdate1.ps1
************************************************************************
﻿Function Get-SoftwareUpdate
{
  $filter = @{
    logname='Microsoft-Windows-Application-Experience/Program-Inventory'
    id=905
  }
  Get-WinEvent -FilterHashtable $filter |
  ForEach-Object { 
    $info = 1 | Select-Object Datum, Anwendung, Version, Herausgeber
    $info.Datum = $_.TimeCreated
    $info.Anwendung = $_.Properties[0].Value
    $info.Version = $_.Properties[1].Value
    $info.Herausgeber = $_.Properties[2].Value
    $info
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k20 Module\Skripts\Get-SoftwareUpdate2.ps1
************************************************************************
﻿Function Get-SoftwareUpdate
{
  $filter = @{
    logname='Microsoft-Windows-Application-Experience/Program-Inventory'
    id=905
  }
  Get-WinEvent -FilterHashtable $filter |
  ForEach-Object { 
    $info = 1 | Select-Object Datum, Anwendung, Version, Herausgeber, Sprache, Typ
    $info.Datum = $_.TimeCreated
    $info.Anwendung = $_.Properties[0].Value
    $info.Version = $_.Properties[1].Value
    $info.Herausgeber = $_.Properties[2].Value
    $info.Sprache = $_.Properties[3].Value
    $info.Typ = $_.Properties[4].Value
    $info
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k20 Module\Skripts\Get-SoftwareUpdate3.ps1
************************************************************************
﻿Function Get-SoftwareUpdate
{
  $filter = @{
    logname='Microsoft-Windows-Application-Experience/Program-Inventory'
    id=905
  }
  Get-WinEvent -FilterHashtable $filter |
  ForEach-Object { 
    $info = 1 | Select-Object Datum, Anwendung, Version, Herausgeber, Sprache, Typ
    $info.Datum = $_.TimeCreated
    $info.Anwendung = $_.Properties[0].Value
    $info.Version = $_.Properties[1].Value
    $info.Herausgeber = $_.Properties[2].Value
    $info.Sprache = $_.Properties[3].Value
    $info.Typ = $_.Properties[4].Value
    $info.pstypenames.Insert(0,'mySoftwareUpdateResults') 
    $info
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k20 Module\Skripts\mySoftwareUpdateResult.format.ps1xml
************************************************************************
﻿<Configuration>
   

  <!-- ################ VIEW DEFINITIONS ################ -->

  <ViewDefinitions>    
    <View>
      <Name>UpdateResult</Name>
      <ViewSelectedBy>
        <TypeName>mySoftwareUpdateResults</TypeName>
      </ViewSelectedBy>      
      <TableControl>
        <TableHeaders>
          <TableColumnHeader>
            <Label>Datum</Label>
            <Width>19</Width>
            <Alignment>left</Alignment>
          </TableColumnHeader>
          <TableColumnHeader>
            <Label>Installiertes Produkt</Label>
            <Alignment>left</Alignment>
          </TableColumnHeader> 
	  <TableColumnHeader>
            <Label>Produktversion</Label>
            <Alignment>right</Alignment>
            <Width>15</Width>
          </TableColumnHeader>          
        </TableHeaders>
        <TableRowEntries>
          <TableRowEntry>
            <Wrap/>
            <TableColumnItems>
              <TableColumnItem>
                <PropertyName>Datum</PropertyName>
              </TableColumnItem>
              <TableColumnItem>
                <PropertyName>Anwendung</PropertyName>
              </TableColumnItem>
	      <TableColumnItem>
                <PropertyName>Version</PropertyName>
              </TableColumnItem>              
            </TableColumnItems>
          </TableRowEntry>
        </TableRowEntries>
      </TableControl>
    </View>
  </ViewDefinitions>
</Configuration>



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k21 G�ltigkeitsbereiche\Skripts\Find-VariableScope.ps1
************************************************************************
﻿Function Find-VariableScope
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
    $text = $text.PadLeft([Int]($text.Length + ((70 - $text.Length) / 2)))
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

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k21 G�ltigkeitsbereiche\Skripts\Get-NestedDepth.ps1
************************************************************************
﻿Function Get-NestedDepth
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


function Test-Recurse
{
    $tiefe = Get-NestedDepth
    'Verschachtelungstiefe: {0}' -f $tiefe

    # ab einer Verschachtelungstiefe von 10 abbrechen:
    if ($tiefe -ge 10)
    {
        break
    }
    # Funktion ruft sich selbst auf und führt normalerweise
    # zu einer Endlosschleife:
    Test-Recurse
}

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k21 G�ltigkeitsbereiche\Skripts\Get-ScriptLocation.ps1
************************************************************************
﻿

function Get-ScriptLocation
{
    Split-Path $script:MyInvocation.MyCommand.Definition
}

$Path = Get-ScriptLocation
"Dieses Skript befindet sich im Ordner $Path"

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k21 G�ltigkeitsbereiche\Skripts\Scope.ps1
************************************************************************
﻿$info = 'Undefined'

function Set-Value
{
    param($NewValue)

    $script:info = $NewValue
}

function Get-Value
{
    "Wert ist $info"
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k21 G�ltigkeitsbereiche\Skripts\scope_reference.ps1
************************************************************************
﻿$mySetting = @{}

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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k21 G�ltigkeitsbereiche\Skripts\Test-DotSourced1.ps1
************************************************************************
﻿

function Test-DotSourced
{
    $global:MyInvocation -eq $script:MyInvocation
}

if (Test-DotSourced)
{
    'Script wurde dot-sourced im Aufruferkontext aufgerufen.'
}
else
{
    'Script wurde isoliert im eigenen Kontext aufgerufen'
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k21 G�ltigkeitsbereiche\Skripts\Test-DotSourced2.ps1
************************************************************************
﻿# prüfen, ob das Skript vom Anwender korrekt aufgerufen wurde:
if ($global:MyInvocation -ne $script:MyInvocation)
{
    Write-Warning 'Starten Sie das Skript dot-sourced, um die darin enthaltenen Funktionen nutzen zu können!'
    break
}

function New-Function
{
  'Ich bin eine neue Funktion!'
}

Write-Host 'Funktion New-Function ist nun einsatzbereit.' -ForegroundColor Green

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k22 Sicherheit und Signaturen\Skripts\certdialog.ps1
************************************************************************
﻿Add-Type -AssemblyName System.Security

$Store = New-Object system.security.cryptography.X509Certificates.x509Store("My", "CurrentUser")
$store.Open("ReadOnly")
$zertifikate = $store.Certificates
$store.Close()

[System.Security.Cryptography.x509Certificates.X509Certificate2UI]::SelectFromCollection($zertifikate,  "Ihre Zertifikate", "Bitte wählen", 0)


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k22 Sicherheit und Signaturen\Skripts\createtrust.ps1
************************************************************************
﻿# persönliches Zertifikat auswählen:
$name = 'Test1'
$zertifikat = Get-ChildItem -Path cert:\CurrentUser\My | Where-Object { $_.Subject -eq "CN=$name" }

# Zertifikatherausgeber für grundsätzlich vertrauensvoll erklären
$Store = New-Object system.security.cryptography.X509Certificates.x509Store("root", "CurrentUser")
$Store.Open("ReadWrite")
$Store.Add($zertifikat)
$Store.Close()

# Zertifikate dieses Herausgebers aktivieren:
$Store = New-Object system.security.cryptography.X509Certificates.x509Store("TrustedPublisher", "CurrentUser")
$Store.Open("ReadWrite")
$Store.Add($zertifikat)
$Store.Close()


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k22 Sicherheit und Signaturen\Skripts\Export-Certificate.ps1
************************************************************************
﻿Function Export-Certificate
{
  param
  (
    [Parameter(Mandatory=$true,HelpMessage='pfx file name')]
    $Path = "$home\Certificate.pfx",

    [Parameter(Mandatory=$true,HelpMessage='name of installed certificate')]
    $CertificateName,

    [System.Security.SecureString]
    $Password = $null,

    [ValidateSet('cer', 'pfx')]
    $ExportType
  )

  # installiertes Zertifikat auswählen:
  $cert = @(Get-ChildItem cert:\ -Recurse -CodeSigningCert |
    Where-Object { $_.Subject -eq "CN=$CertificateName" })[0]

  # falls ein Zertifikat mit dem angegebenen Namen gefunden wurde,
  # dieses als Datei exportieren:

  if ($cert)
  {
    # wie lautet die Dateierweiterung des angegebenen Dateipfads?
    $ext = [System.IO.Path]::GetExtension($Path).TrimStart('.')

    # falls kein besonderer Exporttyp angegeben wurde, automatisch
    # aus Dateierweiterung festlegen:

    if ($ExportType -eq $null)
    {
      # wurde eine gültige Dateierweiterung angegeben?

      if ('cer', 'pfx' -contains $ext)
      {
        # ja, also diesen Exporttyp wählen:
        $ExportType = $ext
      }
      elseif ($cert.hasPrivateKey)
      {
        # ja, also pfx-Export:
        $ExportType = 'pfx'
        $Path += '.pfx'
      }
      else
      {
        # nein, also cer-Export:
        $ExportType = 'cer'
        $Path += '.cer'
      }
    }

    # tatsächliche Export-Dateierweiterung festlegen:
    $Path = [System.IO.Path]::ChangeExtension($Path, $ExportType)

    # Exportvorgang versuchen:
    try
    {
      # falls pfx-Export und kein Kennwort festgelegt, dieses erfragen:

      if ($ExportType -eq 'pfx' -and $Password -eq $null)
      {
        $Password = Read-Host -AsSecureString -Prompt 'Enter password to protect pfx-file'
      }
      else
      {
        $Password = $null
      }

      # Zertifikat in Datei exportieren:
      $bytes = $cert.Export($ExportType, $Password)
      $filestream = New-Object System.IO.FileStream($Path, 'Create')
      $filestream.Write($bytes, 0, $bytes.Length)
      $filestream.Close()

      # Datei zurückliefern:
      Get-Item -Path $path
    }
    catch
    {
      # falls Export fehlschlägt: darf Zertifikat überhaupt exportiert werden?
      Write-Warning "Certificate '$CertificateName' cannot be exported. It may not be marked as exportable."
    }
  }
  else
  {
    Write-Warning "No certificate found with name '$CertificateName'."
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k22 Sicherheit und Signaturen\Skripts\Get-CodesigningCertificate.ps1
************************************************************************
﻿Function Get-CodesigningCertificate
{
  param
  (
    $titel = 'Verfügbare Identitäten',

    $text = 'Bitte Zertifikat für Signatur auswählen'
  )

  # Zertifikate ermitteln:
  $zertifikate = Get-ChildItem cert:\currentuser\my -Codesigning

  # Zertifikatcontainer beschaffen und füllen:
  Add-Type -AssemblyName System.Security
  $container = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
  $container.AddRange($zertifikate)

  # Auswahlfeld anzeigen:
  [System.Security.Cryptography.x509Certificates.X509Certificate2UI]::SelectFromCollection($container, $titel, $text, 0)
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k22 Sicherheit und Signaturen\Skripts\makecert.ps1
************************************************************************
﻿$name = 'PSTestzertifikat'
$path = "$env:ProgramFiles\Microsoft Visual Studio 8\SDK\v2.0\Bin\makecert.exe"

if (Test-Path -Path $Path)
{
    $argumente = ('-pe -r -n "CN={0}" -eku 1.3.6.1.5.5.7.3.3 -ss "my"' -f $name)
    Start-Process -FilePath $Path -ArgumentList $argumente
}
else
{
    Write-Warning "
    makecert.exe unter folgendem Pfad nicht gefunden:
    '$Path'. 
    Bitte überprüfen Sie den Pfad und passen Sie ihn gegebenenfalls an."
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k22 Sicherheit und Signaturen\Skripts\New-SelfsignCertificate.ps1
************************************************************************
Function New-SelfsignCertificate
{
  [CmdletBinding()]

  param
  (
    [string][Parameter(Mandatory=$true)]$Name,

    [switch]$CreateTrust,

    [ValidateSet('ServerAuthentication','ClientAuthentication','CodeSigning','Email','Timestamp','OCSPSign')]
    $Purpose = 'CodeSigning',

    [datetime]$NotBefore = (Get-Date).AddDays(-1),

    [datetime]$NotAfter = $NotBefore.AddDays(365),

    [int][ValidateSet('1024', '2048')]$KeyLength = 1024,

    [switch]$PrivateKeyExportable
  )

  # Unterst�tzt die Windows-Version das Anlegen von Zertifikaten?
  $OSversion = ([System.Version]((Get-WmiObject Win32_OperatingSystem).Version)).Major

  if ($OSversion -lt 6)
  {
    Write-Warning 'With this version of windows, you cannot create certificates.'
    return
  }

  # Hashtable mit den Codes der Verwendungszwecke:
  $purposeCode = @{
    ServerAuthentication='1.3.6.1.5.5.7.3.1'
    ClientAuthentication='1.3.6.1.5.5.7.3.2'
    CodeSigning='1.3.6.1.5.5.7.3.3'
    Email='1.3.6.1.5.5.7.3.4'
    Timestamp='1.3.6.1.5.5.7.3.8'
    OCSPSign='1.3.6.1.5.5.7.3.9'
  }

  # DistinguishedName f�r Zertifikat herstellen:
  $subject = "CN=$name"
  $SubjectDN = New-Object -ComObject X509Enrollment.CX500DistinguishedName
  $SubjectDN.Encode($Subject, 0x0)

  # Verwendungszweck hinterlegen:
  $OID = New-Object -ComObject X509Enrollment.CObjectID
  $OID.InitializeFromValue($purposeCode.$purpose)
  $OIDs = New-Object -ComObject X509Enrollment.CObjectIDs
  $OIDs.Add($OID)

  # Privaten Schl�ssel erzeugen:
  $EKU = New-Object -ComObject X509Enrollment.CX509ExtensionEnhancedKeyUsage
  $EKU.InitializeEncode($OIDs)
  $PrivateKey = New-Object -ComObject X509Enrollment.CX509PrivateKey
  $PrivateKey.ProviderName = 'Microsoft Base Cryptographic Provider v1.0'
  $PrivateKey.KeySpec = 0x2
  $PrivateKey.Length = $KeyLength
  $PrivateKey.MachineContext = 0x0

  if ($PrivateKeyExportable)
  {
    $PrivateKey.ExportPolicy = 0x1
  }

  $PrivateKey.Create()

  # Zertifikatanforderung herstellen:
  $Cert = New-Object -ComObject X509Enrollment.CX509CertificateRequestCertificate
  $Cert.InitializeFromPrivateKey(0x1,$PrivateKey,'')
  $Cert.Subject = $SubjectDN
  $Cert.Issuer = $Cert.Subject
  $Cert.NotBefore = $NotBefore
  $Cert.NotAfter = $NotAfter
  $Cert.X509Extensions.Add($EKU)
  $Cert.Encode()

  # Zertifikat gem�� Request herstellen und installieren
  $Request = New-Object -ComObject X509Enrollment.CX509enrollment
  $Request.InitializeFromRequest($Cert)
  $endCert = $Request.CreateRequest(0x1)
  $Request.InstallResponse(0x2,$endCert,0x1,'')

  # Vertrauen auf lokalem Computer herstellen, indem Zertifikat
  # als Stammzertifizierungsstelle und vertrauensw�rdiger
  # Herausgeber eingetragen wird:

  if ($CreateTrust)
  {
    [Byte[]]$bytes = [System.Convert]::FromBase64String($endCert)

    ForEach ($Container in 'Root', 'TrustedPublisher')
    {
      $x509store = New-Object Security.Cryptography.X509Certificates.X509Store $Container, 'CurrentUser'
      $x509store.Open([Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
      $x509store.Add([Security.Cryptography.X509Certificates.X509Certificate2]$bytes)
      $x509store.Close()
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erl�utert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollst�ndig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag �bernehmen eine Haftung f�r Folgen, die durch die Ausf�hrung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k22 Sicherheit und Signaturen\Skripts\securityaudit.ps1
************************************************************************
﻿Get-ChildItem -Path $home -Filter *.ps1 -Recurse  | 
  Get-AuthenticodeSignature | 
  Where-Object { 'Valid', 'UnknownError' -notcontains $_.Status } | 
  Select-Object -Property Path, Status, StatusMessage | 
  Out-GridView


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k22 Sicherheit und Signaturen\Skripts\showcert.ps1
************************************************************************
﻿$name = 'Test'
$zertifikat = Get-ChildItem -Path cert:\CurrentUser\My | Where-Object { $_.Subject -like "CN=$Name" }
Add-Type -AssemblyName System.Security
[System.Security.Cryptography.x509Certificates.X509Certificate2UI]::DisplayCertificate($zertifikat)


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k22 Sicherheit und Signaturen\Skripts\Test-Certificate.ps1
************************************************************************
﻿
Function Test-Certificate
{
  param
  (
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    $Certificate
  )

  $ok = $zertifikat.Verify()

  if (-not $ok)
  {
    Add-Type -AssemblyName System.Security
    $chain = New-Object System.Security.Cryptography.X509Certificates.X509Chain
    $chain.Build($zertifikat)
    $reason = $chain.ChainStatus
    $reason
  }
  else
  {
    $rv = 1 | Select-Object -Property Status, StatusInformation
    $rv.Status = 'OK'
    $rv.StatusInformation = 'Trusted by local system.'
    $rv
  }
}


$name = 'Test'
$zertifikat = Get-ChildItem -Path cert:\CurrentUser\My | Where-Object { $_.Subject -like "CN=$Name" }
Test-Certificate -Certificate $zertifikat


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\credssp1.ps1
************************************************************************
﻿Invoke-Command { Get-WmiObject -Class Win32_OperatingSystem -ComputerName storage1 | 
  Select-Object -ExpandProperty Caption } -ComputerName testserver


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\credssp2.ps1
************************************************************************
﻿Invoke-Command { Get-WmiObject -Class Win32_OperatingSystem -ComputerName storage1 | 
  Select-Object -ExpandProperty Caption } -ComputerName testserver -Authentication Credssp -Credential "$env:userdomain\$env:username"




################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\fehler1.ps1
************************************************************************
﻿
$Datei = "$env:temp\testdatei$(Get-Random).txt"
Test-Path -Path $Datei

Enter-PSSession -ComputerName storage1
Get-Date | Out-File -FilePath $Datei
Exit-PSSession

Test-Path -Path $Datei

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\fehler2.ps1
************************************************************************
﻿Function Get-ErrorEvent
{
  param
  (
    [Parameter(Mandatory=$true)]
    $ComputerName,

    $LogName='System'
  )

  $code = { Get-EventLog -LogName $LogName -EntryType Error | 
             Export-Csv $env:temp\result.csv -NoTypeInformation -Encoding UTF8 -UseCulture }
  Invoke-Command -ScriptBlock $code -ComputerName $ComputerName
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\firewall.ps1
************************************************************************
﻿function Get-FirewallRule($rule = '*', $port = '*') {
  try {
    (New-Object -ComObject HNetCfg.FwPolicy2).Rules | 
      Where-Object { $_.Name -like $rule } | 
      Where-Object { $_.LocalPorts -like $port 
    }
  }
  catch [system.Management.Automation.PSArgumentException] {
    # this handles firewall rules on Windows XP:
    0..2 | ForEach-Object {
      $obj = New-Object -ComObject HnetCfg.FwMgr
    }{ 
      try {
        $obj.LocalPolicy.GetProfileByType($_).GloballyOpenPorts 
        } catch {}} | 
        Where-Object { $_.Name -like $rule } | 
        Where-Object { $_.Port.toString() -like $port 
    }
  }
}

function Disable-FirewallRule([Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]$rule) {
  process {
    $rule.Enabled = $false
  }
}

function Enable-FirewallRule([Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]$rule) {
  process {
    $rule.Enabled = $true
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\Get-FirewallRule.ps1
************************************************************************
﻿function Get-FirewallRule($rule = '*', $port = '*') {
  try {
    (New-Object -ComObject HNetCfg.FwPolicy2).Rules | 
      Where-Object { $_.Name -like $rule } | 
      Where-Object { $_.LocalPorts -like $port 
    }
  }
  catch [system.Management.Automation.PSArgumentException] {
    # this handles firewall rules on Windows XP:
    0..2 | ForEach-Object {
      $obj = New-Object -ComObject HnetCfg.FwMgr
    }{ 
      try {
        $obj.LocalPolicy.GetProfileByType($_).GloballyOpenPorts 
        } catch {}} | 
        Where-Object { $_.Name -like $rule } | 
        Where-Object { $_.Port.toString() -like $port 
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\Get-RemoteSessionUser.ps1
************************************************************************
﻿function Get-RemoteSessionUser
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

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\Get-RemotingCmdlet.ps1
************************************************************************
﻿Function Get-RemotingCmdlet
{
  $CredSupport = @{
    Name = 'SupportsCredential'
    Expression = { $_.Parameters.ContainsKey('Credential') }
  }

  # alle Module von Microsoft importieren:
  Get-Module -ListAvailable |
    Where-Object { $_.Author -eq 'Microsoft Corporation' } |
    Import-Module 

  Get-Command -ListImported | 
    Where-Object RemotingCapability -like '*Command' |
    Select-Object -Property Name, RemotingCapability, $CredSupport |
    Sort-Object -Property RemotingCapability, Name
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\Get-SystemInfo.ps1
************************************************************************
﻿Function Get-SystemInfo
{
  param
  (
    $ComputerName,

    $Credential
  )

  $code = { 
    Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' |
      Select-Object -Property ProductName, InstallationType, ProductID, CSDVersion
  }

  Invoke-Command -ScriptBlock $code @PSBoundParameters
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\Get-SystemInfo2.ps1
************************************************************************
﻿Function Get-SystemInfo
{
  param
  (
    $ComputerName,

    $Credential
  )

  $code = { 
    Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' |
      Select-Object -Property ProductName, ProductID, CSDVersion
  }

  Invoke-Command -ScriptBlock $code @PSBoundParameters |
    Select-Object -Property ProductName, ProductID, CSDVersion, PSComputerName
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\Get-SystemInfo3.ps1
************************************************************************
﻿Function Get-SystemInfo
{
  param
  (
    $ComputerName,

    $Credential
  )
  $absender = @{
    Name = 'ComputerName'
    Expression = { $_.PSComputerName }
  }

  $code = { 
    Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' |
      Select-Object -Property ProductName, ProductID, CSDVersion
  }

  Invoke-Command -ScriptBlock $code @PSBoundParameters |
    Select-Object -Property ProductName, ProductID, CSDVersion, $absender
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\l�sung1.ps1
************************************************************************
﻿Function Get-ErrorEvent
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
         Export-Csv $env:temp\result.csv -NoTypeInformation -Encoding UTF8 -UseCulture 
     }

  Invoke-Command -ScriptBlock $code -ComputerName $ComputerName -ArgumentList $LogName
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\l�sung2.ps1
************************************************************************
﻿Function Get-ErrorEvent
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
         Export-Csv $env:temp\result.csv -NoTypeInformation -Encoding UTF8 -UseCulture 
     }

  Invoke-Command -ScriptBlock $code -ComputerName $ComputerName 
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\l�sung3.ps1
************************************************************************
﻿Function Get-ErrorEvent
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\Set-RemoteDesktop.ps1
************************************************************************
﻿function Set-RemoteDesktop
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
     Set-ItemProperty -Path $key -Name fDenyTSConnections -Value ([int]$Value ) -Type DWORD

    if ($Disable)
    {
      netsh.exe advfirewall firewall set rule group="Remotedesktop " new enable=no
      Write-Warning "Remote Desktop disabled on \\$env:COMPUTERNAME"
    }
    else
    {
      netsh.exe advfirewall firewall set rule group="Remotedesktop " new enable=yes
      Write-Warning "Remote Desktop enabled on \\$env:COMPUTERNAME"
    }
  }

  Invoke-Command -ScriptBlock $code @PSBoundParameters -ArgumentList $Disable
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\Show-RemotingCmdlet.ps1
************************************************************************
﻿Function Show-RemotingCmdlet
{
  $CredSupport = @{
    Name = 'supports -Credential'
    Expression = {
      if ($_.Parameters.ContainsKey('Credential'))
      {
        'yes'
      }
    }
  }

  # alle Module von Microsoft importieren:
  Write-Progress -Activity 'Finding modules' -Status 'this may take a moment...'
  Get-Module -ListAvailable |
      Where-Object { $_.Author -eq 'Microsoft Corporation' } |
      Import-Module

  $cmdlets = Get-Command -ListImported -CommandType Cmdlet |
      Where-Object RemotingCapability -Like '*Command'
      Write-Progress -Activity 'Finding modules' -Status 'this may take a moment...' -Completed

  $counter = 0

  # alle gefundenen Cmdlets untersuchen:
  $cmdlets |
    Select-Object -Property Name, Synopsis, $CredSupport |
    ForEach-Object {
      $counter++
      Write-Progress -Activity 'Examining Cmdlet' -Status $_.Name -PercentComplete ($counter*100/$cmdlets.Count)

      # Hilfe für Cmdlet abrufen:
      $help = Get-Help -Name $_.Name

      # Hilfe vorhanden?

      if ($help.Remarks -notlike '*go.microsoft.com*')
      {
        # Beschreibung übernehmen:
        $_.Synopsis = $help.Synopsis
      }

      $_
    } |
    Sort-Object -Property Name |
    # in PowerShell 2.0 wird -PassThru nicht unterstützt:
    Out-GridView -Title 'Select Remoting Cmdlet' -PassThru |
    ForEach-Object {
      # Hilfe für die ausgewählten Cmdlets in Fenster öffnen
      # (erfordert PowerShell 3.0):
      Get-Help -Name $_.Name -ShowWindow
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k23 remoting\Skripts\Test-NetworkPort.ps1
************************************************************************
﻿Function Test-NetworkPort
{
  param
  (
    $ComputerName = $env:COMPUTERNAME,

    [Int32[]]
    [Parameter(ValueFromPipeline=$true)]
    $Port = $(135..139 + 443 + 445 + 5980..5990),

    [Int32]
    $Timeout=1000,

    [Switch]
    $AllResults
  )

  Process
  {
    $count = 0
    ForEach ($PortNumber in $Port)
    {
      $count ++
      $percentComplete = $count * 100 / $Port.Count
      Write-Progress -Activity "Scanning on \\$ComputerName" -Status "Port $PortNumber" -PercentComplete $percentComplete
      # in PowerShell 2.0 muss [Ordered] entfernt werden; dann ist die Reihenfolge der Eigenschaften aber zufällig.
      $result = New-Object PSObject -Property ([Ordered]@{Port="$PortNumber";Open=$False;Type='TCP';ComputerName=$ComputerName})
      
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k24 Hintergrundjobs\Skripts\async_thread.ps1
************************************************************************
$code = {
  Start-Sleep -Seconds 2
  'Hello'
}

# neuen Thread erzeugen:
$newPowerShell = [PowerShell]::Create().AddScript($code)

# Thread asynchron starten:
$handle = $newPowerShell.BeginInvoke()

# auf Beendigung warten und w�hrenddessen etwas
# anderes tun:
while ($handle.IsCompleted -eq $false) {
  Write-Host '.' -NoNewline
  Start-Sleep -Milliseconds 500
}

# Ergebnis aus anderem Thread abrufen:
Write-Host ''
$newPowerShell.EndInvoke($handle)


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erl�utert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollst�ndig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag �bernehmen eine Haftung f�r Folgen, die durch die Ausf�hrung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k24 Hintergrundjobs\Skripts\basic_thread.ps1
************************************************************************
$code = {
    Start-Sleep -Seconds 2
    "Hello"
}

$newPowerShell = [PowerShell]::Create().AddScript($code)
$newPowerShell.Invoke()
  
  


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erl�utert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollst�ndig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag �bernehmen eine Haftung f�r Folgen, die durch die Ausf�hrung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k24 Hintergrundjobs\Skripts\Get-Newsticker.ps1
************************************************************************
﻿Function Get-NewsTicker
{
  param
  (
    $url = 'http://www.heise.de/newsticker/heise-atom.xml'
  )

  $ticker = Invoke-WebRequest -Uri $url -UseBasicParsing
  $xml = New-Object -TypeName XML
  $xml.LoadXML($ticker.Content)
  $xml.feed.entry |
  ForEach-Object { '{0} : {1}' -f $_.title, $_.summary }
}

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k24 Hintergrundjobs\Skripts\job_overhead.ps1
************************************************************************
﻿$code = @'
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
            _powerShell.Runspace.AvailabilityChanged += new EventHandler<RunspaceAvailabilityEventArgs>(Runspace_AvailabilityChanged);

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

Function Start-JobInProcess
{
  [CmdletBinding()]
  param
  (
    [ScriptBlock] $ScriptBlock,
    $ArgumentList,
    [string] $Name
  )

  Function Get-JobRepository
  {
    [cmdletbinding()]
    param()
    $pscmdlet.JobRepository
  }

  Function Add-Job
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
  $powershell = [PowerShell]::Create().AddScript($ScriptBlock).AddArgument($argumentlist)
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

######################TEST#########################

Write-Warning 'Erhebe Beispiel-Daten. Das kann einige Minuten dauern...'
$data = Get-ChildItem $env:windir -Filter *.dll -Recurse -ErrorAction SilentlyContinue

# dieser Code wird von beiden Hintergrundjobs ausgeführt.
# er empfängt große Datenmengen und gibt diese wieder in zufälliger Reihenfolge zurück
# (Provokationstest):
$code = {
  Get-Random -InputObject $args -Count $args.Count
}

Write-Warning 'Messe klassischen Hintergrund-Job...'

$dauer = Measure-Command {
  $job = Start-Job -ScriptBlock $code -ArgumentList $data
  Wait-Job $job
  $result = Receive-Job $job
  Remove-Job $job
}

'Klassischer Job: {0:N0} ms' -f $dauer.TotalMilliseconds
'Anzahl Ergebnisse: {0:N0}' -f $result.Count
'Datentypen:'
$result |
Get-Member |
Sort-Object -Property TypeName -Unique |
Select-Object -ExpandProperty TypeName

Write-Warning 'Messe InProcess-Job...'

$dauer = Measure-Command {
  $job = Start-JobInProcess -ScriptBlock $code -ArgumentList $data
  Wait-Job $job
  $result = Receive-Job $job
  Remove-Job $job
}

'InProcess-Job: {0:N0} ms' -f $dauer.TotalMilliseconds
'Anzahl Ergebnisse: {0:N0}' -f $result.Count
'Datentypen:'
$result |
Get-Member |
Sort-Object -Property TypeName -Unique |
Select-Object -ExpandProperty TypeName


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k24 Hintergrundjobs\Skripts\Start-JobInProcess.ps1
************************************************************************
﻿$code = @'
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
            _powerShell.Runspace.AvailabilityChanged += new EventHandler<RunspaceAvailabilityEventArgs>(Runspace_AvailabilityChanged);

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

Function Start-JobInProcess
{
  [CmdletBinding()]
  param
  (
    [ScriptBlock] $ScriptBlock,
    $ArgumentList,
    [string] $Name
  )

  Function Get-JobRepository
  {
    [cmdletbinding()]
    param()
    $pscmdlet.JobRepository
  }

  Function Add-Job
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
  $powershell = [PowerShell]::Create().AddScript($ScriptBlock).AddArgument($argumentlist)
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

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k24 Hintergrundjobs\Skripts\Start-Newsticker.ps1
************************************************************************
﻿Function Get-NewsTicker
{
  param
  (
    $url = 'http://www.heise.de/newsticker/heise-atom.xml'
  )

  $ticker = Invoke-WebRequest -Uri $url -UseBasicParsing
  $xml = New-Object -TypeName XML
  $xml.LoadXML($ticker.Content)
  $xml.feed.entry |
  ForEach-Object { '{0} : {1}' -f $_.title, $_.summary }
}

Function Start-Newsticker
{
  param
  (
    $Text = $(Get-NewsTicker),

    $Delay=250
  )

  $code = {
    param
    (
      $Text,
      $theHost,
      $Delay
    )

    $Text = Get-Random -InputObject $text -count $Text.Length

    $Text = $Text -join ' '
    
    $TextLength = $Text.Length
    $Factor = [Math]::Ceiling((1600 / $TextLength))
    $Text = $Text * $Factor
    $Text = $Text * 2


    do
    {
      For ($x=0; $x -lt $TextLength; $x+=3)
      {
        $theHost.UI.RawUI.WindowTitle = $Text.Substring($x,800)
        Start-Sleep -Milliseconds $Delay
      }
    } while ($true)
  }

  $script:newPowerShell = [PowerShell]::Create().AddScript($Code).AddParameter('Text',$Text).AddParameter('Delay',$Delay).AddParameter('theHost',$host)
  $handle = $newPowerShell.BeginInvoke()
}

Function Stop-Newsticker
{
  if ($script:newPowerShell -ne $null)
  {
    Write-Host 'Trying to stop newsticker...' -NoNewline
    $script:newPowerShell.Stop()
    $script:newPowerShell.Runspace.Close()
    $script:newPowerShell.Dispose()
    Remove-Variable newPowerShell -Scope script
    Write-Host 'Done!'
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k24 Hintergrundjobs\Skripts\Start-Progress.ps1
************************************************************************
Function Start-Progress
{
  param
  (
    [ScriptBlock]
    $code
  )

  $newPowerShell = [PowerShell]::Create().AddScript($code)
  $handle = $newPowerShell.BeginInvoke()

  while ($handle.IsCompleted -eq $false) {
    Write-Host '.' -NoNewline
    Start-Sleep -Milliseconds 500
  }
  Write-Host ''

  $newPowerShell.EndInvoke($handle)

  # zweiten Thread ordnungsgem�� entsorgen:
  $newPowerShell.Runspace.Close()
  $newPowerShell.Dispose()
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erl�utert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollst�ndig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag �bernehmen eine Haftung f�r Folgen, die durch die Ausf�hrung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k24 Hintergrundjobs\Skripts\Start-Timebomb.ps1
************************************************************************
Function Start-Timebomb
{
  param
  (
    [Int32]
    [Parameter(Mandatory=$true)]
    [ValidateRange(5,600)]
    $Seconds,

    [ScriptBlock]
    $Action = { Stop-Process -Id $PID }
  )

  $Wait = "Start-Sleep -seconds $seconds"
  $script:newPowerShell = [PowerShell]::Create().AddScript($Wait).AddScript($Action)
  $handle = $newPowerShell.BeginInvoke()
  Write-Warning "Timebomb is active and will go off in $Seconds seconds unless you call Stop-Timebomb before."
}

Function Stop-Timebomb
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erl�utert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollst�ndig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag �bernehmen eine Haftung f�r Folgen, die durch die Ausf�hrung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k24 Hintergrundjobs\Skripts\sync_ticker.ps1
************************************************************************
﻿$code = {
    param
    (
      # der Text für die Laufschrift:
      #[String[]]
      $Text,
      # eine Referenz auf den Host ($host)
      $theHost,
      # die Verzögerung für die Laufschrift:
      $Delay
    )

    # die einzelnen Texte werden mit Get-Random zufällig angeordnet,
    # damit bei jedem Start eine andere Reihenfolge gewählt wird:
    $Text = Get-Random -InputObject $text -count $Text.Length

    # aus den Einzeltexten wird ein Gesamttext gemacht:
    $Text = $Text -join ' '

    # es wird berechnet, wie oft der Text wiederholt werden muss, um mindestens
    # 1600 Zeichen lang zu sein (doppelte Länge der geplanten Anzeigenbreite
    # von 800 Zeichen):
    $TextLength = $Text.Length
    # aufrunden:
    $Factor = [Math]::Ceiling((1600 / $TextLength))
    $Text = $Text * $Factor

    # verdoppeln:
    $Text = $Text * 2

    # eine Endlosschleife:
    do
    {
      # in 3er Schritten von 0 bis Textende:
      For ($x=0; $x -lt $TextLength; $x+=3)
      {
        # in der Titelleiste des Fensters den Anfang des Textes entsprechend verschieben:
        $theHost.UI.RawUI.WindowTitle = $Text.Substring($x,800)
        # eingebaute Verzögerung:
        Start-Sleep -Milliseconds $Delay
      }
    } while ($true)
  }

  & $code -Text (Get-Newsticker) -theHost $host -Delay 200

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k25 ereignisbehandlung\Skripts\beep.ps1
************************************************************************
﻿$timer = New-Object Timers.Timer
$job = Register-ObjectEvent $timer -EventName Elapsed -Action { [System.Console]::Beep(1000,500) }
$timer.Interval = 2000
$timer.Enabled = $true



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k25 ereignisbehandlung\Skripts\Do-Every.ps1
************************************************************************
﻿function Do-Every
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k25 ereignisbehandlung\Skripts\Monitor-Folder.ps1
************************************************************************
﻿function Monitor-Folder {
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k25 ereignisbehandlung\Skripts\Monitor-Variable.ps1
************************************************************************
﻿Register-EngineEvent -SourceIdentifier VariableChange -Action { Write-Host ($event.MessageData) -Fore 'DarkGreen' -Back 'White'} | Out-Null

function Monitor-Variable($variablename) {
  $action = '$true; New-Event -SourceIdentifier VariableChange -MessageData "Neuer Wert $_ für Variable {0}"' -f $variablename
  (Get-Variable $variablename).Attributes.Add((New-Object System.Management.Automation.ValidateScriptAttribute ([scriptblock]::Create($action))))
} 


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k26 Workflows\Skripts\Test-LongTask.ps1
************************************************************************
﻿workflow Test-LongTask {
  if((Get-Date).DayOfWeek -gt 4)
  {
    Write-Warning -Message "Kann nicht am Wochenende gestartet werden. Resume-Job $jobInstanceId verwenden" 
    Suspend-Workflow 
  }
  'Hier könnte eine langwierige Aufgabe stehen, die nicht ins Wochenende reichen darf...'
}

Test-LongTask


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k26 Workflows\Skripts\Test-ParallelForeach.ps1
************************************************************************
﻿Workflow Test-ParallelForeach
{
  param
  (
    $ComputerName
  )

  ForEach -parallel ($Machine in $ComputerName)
  {
    "Beginn $Machine"
    Start-Sleep -Seconds 4
    "Ende $Machine"
  }
}

Test-ParallelForeach -ComputerName server1, server2, server3, server4


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k26 Workflows\Skripts\Test-ParallelForeachSequenz.ps1
************************************************************************
﻿Workflow Test-ParallelForeachSequence
{
  parallel 
  {
    sequence 
    {
        "Beginn Server1"
        Start-Sleep -Seconds 4
        "Ende Server1"
    }
    sequence 
    {
        "Beginn Server2"
        Start-Sleep -Seconds 4
        "Ende Server2"
    }
    sequence 
    {
        "Beginn Server3"
        Start-Sleep -Seconds 4
        "Ende Server3"
    }
    sequence 
    {
        "Beginn Server4"
        Start-Sleep -Seconds 4
        "Ende Server4"
    }
  }
}

Test-ParallelForeachSequence 


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k26 Workflows\Skripts\Test-ParallelWorkflow.ps1
************************************************************************
﻿Workflow Test-ParallelWorkflow
{
  parallel
  {
    $workflow:Processes = Get-Process
    Start-Sleep -Seconds 2
    Start-Sleep -Seconds 4
    $workflow:errors = Get-EventLog -LogName System -EntryType Error

    sequence
    {
      $data = Get-Content -Path $env:windir\windowsupdate.log -ReadCount 0
      $workflow:installations = $data -like '*successfully installed*'
    }
  }

  $processes
  $errors
  $installations
}

Test-ParallelWorkflow


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k26 Workflows\Skripts\Test-ParallelWorkflowDirect.ps1
************************************************************************
﻿Workflow Test-ParallelWorkflow
{
  parallel
  {
    Get-Process
    Start-Sleep -Seconds 2
    Start-Sleep -Seconds 4
    Get-EventLog -LogName System -EntryType Error

    sequence
    {
      $data = Get-Content -Path $env:windir\windowsupdate.log -ReadCount 0
      $data -like '*successfully installed*'
    }
  }
}

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k26 Workflows\Skripts\Test-RemotingTarget.ps1
************************************************************************
﻿workflow Test-RemotingTarget
{
    param($Credential)

    InlineScript
    {
        "Ausführung auf $Using:PSComputername"
        "Beweis: $env:COMPUTERNAME" 
    }

    InlineScript
    {
        "Ausführung festgelegt auf $Using:PSComputername"
        "Beweis: $env:COMPUTERNAME" 
    } -PSComputerName localhost

    InlineScript
    {
        "Ausführung festgelegt auf $Using:PSComputername"
        "Beweis: $env:COMPUTERNAME" 
    } -PSComputerName Server4 -PSCredential $Credential
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k26 Workflows\Skripts\Test-WorkflowData.ps1
************************************************************************
﻿workflow Test-WorkflowData
{
    Get-PSWorkflowData
}

Test-WorkflowData
Test-WorkflowData -PSComputerName Server8

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k27 Oberfl�chen\Skripts\draw.ps1
************************************************************************
﻿# nur in der PowerShell-Konsole notwendig:##
Add-Type –assemblyName PresentationFramework
Add-Type –assemblyName PresentationCore
Add-Type –assemblyName WindowsBase
############################################

$window = New-Object Windows.Window
$inkCanvas = New-Object Windows.Controls.InkCanvas

$window.Title = 'Zeichenfläche'
$window.Content = $inkCanvas
$window.Width = 800
$window.Height = 600
$window.WindowStartupLocation = 'CenterScreen'

$inkCanvas.MinWidth = $inkCanvas.MinHeight = 100

$null = $window.ShowDialog()



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k27 Oberfl�chen\Skripts\drawprint.ps1
************************************************************************
﻿$window = New-Object Windows.Window
$inkCanvas = New-Object Windows.Controls.InkCanvas

$window.Title = 'Zeichenfläche'
#$window.Content = $inkCanvas
$window.Width = 800
$window.Height = 600
$window.WindowStartupLocation = 'CenterScreen'

$inkCanvas.MinWidth = $inkCanvas.MinHeight = 100
$inkCanvas.Margin="0,22,0,0"
$print = {

 
    $printDialog = New-Object System.Windows.Controls.PrintDialog
    if ($printDialog.ShowDialog().GetValueOrDefault($false))
    {
        $printDialog.PrintVisual($window, $window.Title) 
    }
}


$Menu = New-Object Windows.Controls.Menu
$MenuItem1 = New-Object Windows.Controls.MenuItem
$SubMenuItem1 = New-Object Windows.Controls.MenuItem

$Menu.Height="22"
$Menu.VerticalAlignment="Top"
$Menu.HorizontalAlignment="Stretch"
$Menu.Items.Add($MenuItem1)

$MenuItem1.Header = '_Datei'
$MenuItem1.Items.Add($SubMenuItem1)

$SubMenuItem1.Header = '_Print'
[Object[]]$arg = $null
$SubMenuItem1.add_Click( { $window.Dispatcher.BeginInvoke($print,$arg) } )

$Grid = New-Object Windows.Controls.Grid
$Grid.Children.Add($Menu)
$Grid.Children.Add($inkCanvas)

$Window.Content = $Grid


$null = $window.ShowDialog()



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k27 Oberfl�chen\Skripts\Find-Type.ps1
************************************************************************
﻿# nur in der PowerShell-Konsole notwendig:##
Add-Type –assemblyName PresentationFramework
Add-Type –assemblyName PresentationCore
Add-Type –assemblyName WindowsBase
############################################

Function Find-Type
{
  # falls Variable "$script" noch nicht gefüllt ist, 
  # alle .NET Typen ermitteln:
  if (!$script:types)
  {
    # geladene Assemblies bestimmen:
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
    # dann wird daraus ein Regulärer Ausdruck erstellt, der nur die Texte
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

  $null = $window.ShowDialog()
  $listBox.SelectedItem
}

Find-Type


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k27 Oberfl�chen\Skripts\Lock-Screen.ps1
************************************************************************
﻿# nur in der PowerShell-Konsole notwendig:##
Add-Type –assemblyName PresentationFramework
Add-Type –assemblyName PresentationCore
Add-Type –assemblyName WindowsBase
############################################

Function Lock-Screen
{
  param
  (
    $Title = 'Access temporarily unavailable',

    $Delay = 10
  )

  $window = New-Object Windows.Window
  $label = New-Object Windows.Controls.Label

  $label.Content = $Title
  $label.FontSize = 60
  $label.FontFamily = 'Consolas'
  $label.Background = 'Transparent'
  $label.Foreground = 'Red'
  $label.HorizontalAlignment = 'Center'
  $label.VerticalAlignment = 'Center'

  $Window.AllowsTransparency = $True
  $Window.Opacity = .7
  $window.WindowStyle = 'None'
  $window.Content = $label
  $window.Left = $window.Top = 0
  $window.WindowState = 'Maximized'
  $window.Topmost = $true

  $null = $window.Show()
  Start-Sleep -Seconds $Delay
  $window.Close()
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k27 Oberfl�chen\Skripts\Show-StopService.ps1
************************************************************************
﻿# nur in der PowerShell-Konsole notwendig:##
Add-Type –assemblyName PresentationFramework
Add-Type –assemblyName PresentationCore
Add-Type –assemblyName WindowsBase
############################################

# grafische Elemente:
$window = New-Object Windows.Window
$combobox = New-Object Windows.Controls.Combobox
$button = New-Object Windows.Controls.Button
$label = New-Object Windows.Controls.Label

# Schaltfläche konfigurieren:
$button.Content = 'Stop Service'
$button.Width = 100
$button.HorizontalAlignment = 'Right'
$stopHandler = {
  Stop-Service -DisplayName $combobox.SelectedItem -WhatIf
  & $refreshCombo
}
# beim Klick den gewählten Dienst stoppen:
$button.add_Click($StopHandler)
$button.Margin = '10,10,10,10'

# Beschriftung konfigurieren:
$label.Content = 'Select Service to stop:'
$label.FontSize = 25
$label.Margin = '10,10,10,10'

# Combobox konfigurieren:
$combobox.Width = 700
$comboBox.Margin = '10,10,10,10'
$combobox.FontSize = 20
$refreshCombo = {
  [Object[]]$inhalt =  Get-Service | 
                            Where-Object { $_.Status -eq 'Running' } | 
                            Foreach-Object { $_.DisplayName.Substring(0, [Math]::Min($_.DisplayName.Length, 72)) } | 
                            Sort-Object
  $combobox.ItemsSource = ($inhalt)
  $combobox.SelectedIndex = 0
  $combobox.MaxWidth = $combobox.Width
}
# Inhalt einlesen:
& $refreshCombo

$stackPanel = New-Object Windows.Controls.StackPanel
$stackPanel.Orientation='Vertical'
$stackPanel.AddChild($label)
$stackPanel.AddChild($combobox)
$stackPanel.AddChild($button)

$window.Title = 'Dienste-Stopper'
$window.SizeToContent = 'WidthAndHeight'
$window.WindowStartupLocation = 'CenterScreen'
$window.Content = $stackPanel

$null = $window.ShowDialog()


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k27 Oberfl�chen\Skripts\simple_message.ps1
************************************************************************
﻿# nur in der PowerShell-Konsole notwendig:##
Add-Type –assemblyName PresentationFramework
Add-Type –assemblyName PresentationCore
Add-Type –assemblyName WindowsBase
############################################

# Fenster und Label erzeugen:
$window = New-Object Windows.Window
$label = New-Object Windows.Controls.Label

# Label konfigurieren:
$label.Content = 'System wird in 15 Minuten neu gestartet...'
$label.FontSize = 45
$label.FontFamily = 'Consolas'
$label.Background = [System.Windows.Media.Brushes]::Blue
$label.Foreground = [System.Windows.Media.Brushes]::White
$label.BorderThickness = 4
$label.BorderBrush = [System.Windows.Media.Brushes]::PowderBlue

# Fenster konfigurieren:
$window.ResizeMode = 'NoResize'
$window.Title = 'Ein WPF-Fenster'
$window.Content = $label
$window.SizeToContent = 'WidthAndHeight'
$window.Topmost = $true
$window.WindowStartupLocation = 'CenterScreen'
$window.WindowStyle = 'None'
# Fenster modal anzeigen:
$null = $window.Show()

# Fenster nach 4 Sekunden wieder schließen:
Start-Sleep -Seconds 4
$window.Close()



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k27 Oberfl�chen\Skripts\simple_window_wpf.ps1
************************************************************************
﻿# nur in der PowerShell-Konsole notwendig:##
Add-Type –assemblyName PresentationFramework
Add-Type –assemblyName PresentationCore
Add-Type –assemblyName WindowsBase
############################################

# Fenster und Label erzeugen:
$window = New-Object Windows.Window
$label = New-Object Windows.Controls.Label

# Fenster konfigurieren:
$window.Title = 'Ein WPF-Fenster'
$label.Content, $label.FontSize = 'System wird in 15 Minuten neu gestartet...', 40
$window.Content = $label
$window.SizeToContent = 'WidthAndHeight'
$window.Topmost = $true

# Fenster anzeigen
$null = $window.ShowDialog()


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k27 Oberfl�chen\Skripts\xaml.ps1
************************************************************************
﻿$xaml = @"
<StackPanel xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'>
<Grid>
    <Grid.RowDefinitions>
        <RowDefinition Height="Auto" />
        <RowDefinition Height="Auto" />
        <RowDefinition Height="*" />
        <RowDefinition Height="28" />
    </Grid.RowDefinitions>
    <Grid.ColumnDefinitions>
        <ColumnDefinition Width="Auto" />
        <ColumnDefinition Width="200" />
    </Grid.ColumnDefinitions>
    <Label Grid.Row="0" Grid.Column="0" Content="Name:"/>
    <Label Grid.Row="1" Grid.Column="0" Content="Email:"/>
    <Label Grid.Row="2" Grid.Column="0" Content="Nachricht:"/>
    <TextBox Grid.Column="1" Grid.Row="0" Margin="3" />
    <TextBox Grid.Column="1" Grid.Row="1" Margin="3" />
    <TextBox Grid.Column="1" Grid.Row="2" Margin="3" />
    <Button Grid.Column="1" Grid.Row="3" HorizontalAlignment="Right"
            MinWidth="80" Margin="3" Content="Senden"  />
</Grid>
</StackPanel>
"@
 # XAML einlesen und in Controls verwandeln
 $reader = [System.XML.XMLReader]::Create([System.IO.StringReader] $xaml)
 $content = [System.Windows.Markup.XAMLReader]::load($reader)

 # Fenster erzeugen und konfigurieren:
 $window = New-Object Windows.Window
 $window.SizeToContent = 'WidthAndHeight'
 $window.ResizeMode = 'NoResize'
 $window.Title = 'Formular'

 # Nachträgliche Anpassungen per Code:

 # aus dem XAML-Content das Stackpanel lesen:
 $stackpanel = $Content.Children[0]
 # und nachträglich den Rahmen festlegen:
 $stackpanel.Margin = '10,20,10,5'

 # im Stackpanel auf den Button zugreifen und einen Click-
 # Handler einfügen:
 $stackpanel.Children[6].add_Click( { $window.Close() })

 # der ersten Textbox den Eingabefokus geben:
 $stackpanel.Children[3].Focus()

 # Content in Fenster laden und Fenster öffnen:
 $window.Content = $content
 $window.ShowDialog()

 # Ergebnisse aus dem Stackpanel in eine Hashtable lesen:
 $result = @{}
 $result.Name = $stackpanel.Children[3].Text
 $result.Email = $stackpanel.Children[4].Text
 $result.Nachricht = $stackpanel.Children[5].Text

 # Hashtable in ein Objekt verwandeln und zurückgeben:
 New-Object PSObject -Property $result 


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k28 ISE\Skripts\Get-AST.ps1
************************************************************************
﻿ function Get-AST
{
  $text = $psISE.CurrentFile.Editor.Text
  $ast = [System.Management.Automation.Language.Parser]::ParseInput($text, [ref]$null, [ref]$null)
  $elemente = $ast.FindAll({ $true },$true)

  $elemente
}
 

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k28 ISE\Skripts\Get-ISEToken.ps1
************************************************************************
﻿Function Get-ISEToken
{
  # Inhalt des aktuellen Skripts im ISE-Editor lesen:
  $text = $psise.CurrentFile.Editor.Text

  # Code in Token zerlegen:
  [System.Management.Automation.PSParser]::Tokenize($text, [ref]$null)
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k28 ISE\Skripts\Get-ISEVariable.ps1
************************************************************************
﻿function Get-ISEVariable
{
  # Inhalt des aktuellen Skripts im ISE-Editor lesen:
  $text = $psISE.CurrentFile.Editor.Text

  # alle Variablen im Code in finden
   [System.Management.Automation.PSParser]::Tokenize($text, [ref]$null) |
    Where-Object { $_.Type -eq 'Variable' } |
    # Name der Variable finden
    ForEach-Object {
        $rv = 1 | Select-Object -Property Line, Name, Code
        $rv.Name = $text.Substring($_.Start, $_.Length)
        $rv.Line = $_.StartLine

        # die Zeile, in der die Variable steht, als Text lesen:
        $psISE.CurrentFile.Editor.SetCaretPosition($_.StartLine,1)
        $psISE.CurrentFile.Editor.SelectCaretLine()
        $rv.Code = $psISE.CurrentFile.Editor.SelectedText.Trim()

        # Informationen zurückliefern
        $rv
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k28 ISE\Skripts\ise_menu.ps1
************************************************************************
﻿

function Find-AddonMenu
{
    param(
        $Title = '*',
        $MenuItem = $psise.CurrentPowerShellTab.AddOnsMenu,
        [Switch]
        $Recurse
    )

    foreach($item in $MenuItem.SubMenus)
    {
        if ($Recurse)
        {
        Find-AddonMenu -Title $title -MenuItem $item
        }
        
        if ($item.DisplayName -like "*$Title*")
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
        $Parent = $psise.CurrentPowerShellTab.AddOnsMenu
        $Items = $DisplayName -split '\\'
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

    $Parent = $psise.CurrentPowerShellTab.AddOnsMenu
    $Items = $DisplayName -split '\\'
    $MenuItems = @($psise.CurrentPowerShellTab.AddOnsMenu)
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

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k28 ISE\Skripts\ISE_settings.ps1
************************************************************************
﻿# häufig verwendete Editor-Einstellungen:
$psise.Options.AutoSaveMinuteInterval = 1
$psise.Options.IntellisenseTimeoutInSeconds = 1
$psise.Options.ShowWarningBeforeSavingOnRun = $false
$psise.Options.Zoom = 100

# Liste zuletzt geöffneter Skriptdateien im Menü "Datei" löschen:
$psise.Options.MruCount = 0
$psise.Options.MruCount = 15

# Farben der Token für "Variablen" in der Konsole auf vordefinierte Farbe setzen:
$psise.Options.ConsoleTokenColors['Variable'] = 'Red'
# Farben der Token für "Variablen" im Editor auf selbstdefinierte Farbe setzen:
$psise.Options.TokenColors['Variable'] = '#90FF1012'

# Farben der Standardfehlermeldungen ändern
$psise.Options.ErrorBackgroundColor = 'White'
$psise.Options.ErrorForegroundColor = 'Red'




################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k28 ISE\Skripts\Remove-ISEAlias.ps1
************************************************************************
﻿function Remove-ISEAlias 
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
        $befehl = $text.Substring($_.Start,  $_.Length) 
        $befehlstyp = @(try {Get-Command $befehl  -ErrorAction 0} catch {})[0]

        if ($befehlstyp -is [System.Management.Automation.AliasInfo])
        {
          $sb.Remove($_.Start, $_.Length)
          $sb.Insert($_.Start, $befehlstyp.ResolvedCommandName )
        }

    # Aktualisierten Text in Editor ersetzen:
    $psISE.CurrentFile.Editor.Text = $sb.toString()
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k28 ISE\Skripts\Remove-ISEComment.ps1
************************************************************************
﻿
Function Remove-ISEComment
{
  # Inhalt des aktuellen Skripts im ISE-Editor lesen:
  $text = $psise.CurrentFile.Editor.Text
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
    $psise.CurrentFile.Editor.Text = $sb.toString() 
}

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k28 ISE\Skripts\Rename-ISEVariable.ps1
************************************************************************
﻿Function Rename-ISEVariable
{
    param
    (
        $OldName,

        $NewName
    )

    $OldName = $OldName.TrimStart('$')
    $NewName = $NewName.TrimStart('$')


  # Inhalt des aktuellen Skripts im ISE-Editor lesen:
  $text = $psise.CurrentFile.Editor.Text

  # für die schnelle Bearbeitung des Textes diesen in einen "StringBuilder" laden:
  $sb = New-Object System.Text.StringBuilder $text

  # alle Variablen im Code in umgekehrter Reihenfolge finden
  # (letzte Variable zuerst):
  $variables = [System.Management.Automation.PSParser]::Tokenize($text, [ref]$null) |
    Where-Object { $_.Type -eq 'Variable' } |
    Sort-Object -Property Start -Descending |
    # nur die gewünschte Variable ändern
    Where-Object {
       $text.SubString($_.Start+1, $_.Length-1) -eq $OldName
    } |
    # alle Textstellen im Editor umbenennen
    ForEach-Object {
       $sb.Remove($_.Start+1, $_.Length-1)
       $sb.Insert($_.Start+1, $NewName)
    }
    
    # Aktualisierten Text in Editor ersetzen:
    $psise.CurrentFile.Editor.Text = $sb.toString() 
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k28 ISE\Skripts\Set-TokenHighlight.ps1
************************************************************************
﻿Function Set-TokenHighlight
{
  [CmdletBinding(DefaultParameterSetName='Set')]
  param
  (
    # Liste der Tokentypen, die hervorgehoben werden sollen
    # wenn kein Tokentyp angegeben wird, werden die Standardfarben
    # wiederhergestellt
    [Parameter(ParameterSetName='Token', Position=0)]
    [System.Management.Automation.PSTokenType[]]
    $TokenType,

    [Parameter(ParameterSetName='Set', Position=0)]
    [ValidateSet('Off','Grouping', 'Command', 'Keyword')]
    $Group,

    # Transparenzgrad der übrigen Token
    # Vorgabe ist 70 (stark abgeblendet)
    # erlaubt ist ein Wert zwischen 10 und 90 (Prozent)
    [ValidateRange(10,90)]
    $Transparency=70
  )

  # Prozentgrad der Durchsichtigkeit umrechnen in die
  # Byte-Skala der Nicht-Durchsichtigkeit, die benötigt wird:
  [Int]$Level = (100-$Transparency) * 2.55

  if ($PSCmdlet.ParameterSetName -eq 'Set')
  {
    Switch($Group)
    {
      'Command'   { $TokenType = 'Command', 'GroupStart', 'GroupEnd', 'CommandArgument', 'CommandParameter' }
      'Grouping'  { $TokenType = 'GroupStart', 'GroupEnd' }
      'Keyword'   { $TokenType = 'Keyword', 'GroupStart', 'GroupEnd', 'Attribute', 'CommandArgument' }
      'Off'       {}

    }
  }

  # alle Standardfarben wiederherstellen:
  $psise.Options.RestoreDefaultTokenColors()

  # wenn überhaupt in $TokenType etwas angegeben wurde...
  if ($TokenType)
  {
    # dann die Namen der Token lesen...
    ([String[]]$psise.Options.TokenColors.Keys) |
    # nur diejenigen bearbeiten, die NICHT angegeben wurden...
    Where-Object { $TokenType -notcontains $_ } |
    ForEach-Object {
      # und deren Transparenz neu setzen:
      $color = $psISE.Options.TokenColors[$_]
      $color.A = $Level
      $psISE.Options.TokenColors[$_] = $color
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k4 scripts\Skripts\Copy-File.ps1
************************************************************************
﻿param(
    [Parameter(Mandatory=$true,HelpMessage='Pfad zum Quellordner')]
    $Source,

    [Parameter(Mandatory=$true,HelpMessage='Pfad zum Zielordner')]
    $Destination,

    [Parameter(Mandatory=$true,HelpMessage='Auswahlfilter, z.B. *.log')]
    $Filter
)

robocopy $Source $Destination $Filter /R:0  /S /XD *winsxs*


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k4 scripts\Skripts\profile.ps1
************************************************************************
﻿function prompt 
{
  'PS> '
  $host.UI.RawUI.WindowTitle = Get-Location
}

$host.PrivateData.ErrorBackgroundColor = 'White'
$MaximumHistoryCount = 30KB


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k4 scripts\Skripts\programmauswahl.ps1
************************************************************************
﻿# ACHTUNG: läuft NICHT in der ISE, nur in der echten
# PowerShell-Konsole!

Clear-Host
'Programmauswahl leicht gemacht:
NOTEPAD
REGEDIT
EXPLORER'

CHOICE /N /C:123 /M 'Ihre Auswahl (1, 2 oder 3)?'

Switch ($LASTEXITCODE)
{
    1  { notepad }
    2  { regedit }
    3  { explorer }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k4 scripts\Skripts\Set-ProfileScript.ps1
************************************************************************
﻿param(
    $Path=$Profile.CurrentUserAllHosts
)

$vorhanden = Test-Path -Path $Path

if (-not $vorhanden)
{
    $null = New-Item -Path $Path -ItemType File -Force 
}

ise -File $Path


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k5 pipeline\Skripts\Add-FromHistory.ps1
************************************************************************
﻿
function Add-FromHistory
{
    $command = Get-History |
      Sort-Object -Property CommandLine -Unique |
      Sort-Object -Property ID -Descending | 
      Select-Object -ExpandProperty CommandLine | 
      Out-GridView -Title 'Wählen Sie einen Befehl!' -PassThru | 
      Out-String

    $psise.CurrentFile.Editor.InsertText($command)
}

try 
{
$null = $psise.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('Aus Befehlshistorie einfügen', {Add-FromHistory}, 'SHIFT+ALT+H')
} catch {}
Set-Alias -Name afh -Value Add-FromHistory -ErrorAction SilentlyContinue

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k5 pipeline\Skripts\Get-PhysicalMemory.ps1
************************************************************************
﻿function Get-PhysicalMemory {

  param(
    $ComputerName='.'
  )

  $memorytype = "Unknown", "Other", "DRAM", "Synchronous DRAM", "Cache DRAM", "EDO", "EDRAM", "VRAM", "SRAM", "RAM", "ROM", "Flash", "EEPROM", "FEPROM", "EPROM", "CDRAM", "3DRAM", "SDRAM", "SGRAM", "RDRAM", "DDR", "DDR-2"
  $formfactor = "Unknown", "Other", "SIP", "DIP", "ZIP", "SOJ", "Proprietary", "SIMM", "DIMM", "TSOP", "PGA", "RIMM", "SODIMM", "SRIMM", "SMD", "SSMP", "QFP", "TQFP", "SOIC", "LCC", "PLCC", "BGA", "FPBGA", "LGA"

  $spalte1 = @{Name='Größe (GB)'; Expression={ $_.Capacity/1GB } }
  $spalte2 = @{Name='Bauart'; Expression={$formfactor[$_.FormFactor]} }
  $spalte3 = @{Name='Speichertyp'; Expression={ $memorytype[$_.MemoryType] } }

  Get-WmiObject Win32_PhysicalMemory -ComputerName $ComputerName | Select-Object BankLabel, $spalte1, $spalte2, $spalte3
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k5 pipeline\Skripts\memory.ps1
************************************************************************
﻿$memorytype = "Unknown", "Other", "DRAM", "Synchronous DRAM", "Cache DRAM", "EDO", "EDRAM", "VRAM", "SRAM", "RAM", "ROM", "Flash", "EEPROM", "FEPROM", "EPROM", "CDRAM", "3DRAM", "SDRAM", "SGRAM", "RDRAM", "DDR", "DDR-2"
$formfactor = "Unknown", "Other", "SIP", "DIP", "ZIP", "SOJ", "Proprietary", "SIMM", "DIMM", "TSOP", "PGA", "RIMM", "SODIMM", "SRIMM", "SMD", "SSMP", "QFP", "TQFP", "SOIC", "LCC", "PLCC", "BGA", "FPBGA", "LGA"

$spalte1 = @{Name='Größe (GB)'; Expression={ $_.Capacity/1GB } }
$spalte2 = @{Name='Bauart'; Expression={$formfactor[$_.FormFactor]} }
$spalte3 = @{Name='Speichertyp'; Expression={ $memorytype[$_.MemoryType] } }

Get-WmiObject Win32_PhysicalMemory | Select-Object BankLabel, $spalte1, $spalte2, $spalte3


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k5 pipeline\Skripts\performancetest_A.ps1
************************************************************************
﻿Get-Content $env:windir\windowsupdate.log -Encoding UTF8 | 
    Where-Object { $_ -like '*successfully installed*' } |
    ForEach-Object { ($_ -split 'following update: ')[-1] }


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k5 pipeline\Skripts\performancetest_B.ps1
************************************************************************
﻿$zeilen = Get-Content $env:windir\windowsupdate.log -Encoding UTF8 -ReadCount 0
foreach ($zeile in $zeilen)
{
 if ($zeile -like '*successfully installed*')
 { ($zeile -split 'following update: ')[-1] }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k5 pipeline\Skripts\pipelineabbruch.ps1
************************************************************************
﻿filter Stop-Pipeline([scriptblock]$condition = {$true}) {
 $_
 if (& $condition) {continue}
}

Do { Get-Content -Path $env:windir\windowsupdate.log | Foreach-Object { if ($_ -like '*error*') { $_; Stop-Pipeline } } } While ($false)


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\html_kombiniert.ps1
************************************************************************
﻿Get-Service | ConvertTo-Html DisplayName, ServiceName, Status -title 'Inventarisierungsreport' -body "<h2>Report für '$env:computername'</h2><h3>Diensteübersicht</h3>" | Out-File $HOME\report.hta 
Get-WMIObject Win32_OperatingSystem | Select-Object * -exclude __* | ConvertTo-Html -As List -body '<h3>Betriebssystem-Details</h3>' | Out-File $HOME\report.hta -Append
Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, InstallDate, DisplayVersion, Language | ConvertTo-Html -body '<h3>Installierte Software</h3>' | Out-File $HOME\report.hta -Append
Invoke-Item -Path $HOME\report.hta


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\html_mit_bild.ps1
************************************************************************
﻿$style = @'
 <style>
  body { background-color:#EEEEEE; }
  body,table,td,th,h1 { font-family:Tahoma; color:Black; Font-Size:10pt }
  th { font-weight:bold; background-color:#AAAAAA; }
  td { background-color:white; }
  h1 { Font-Size:20pt; text-align:left }
 </style>
'@

$titel = "<img src='$env:windir\web\wallpaper\windows\img0.jpg' width=10%><h1>Report</h1>"
Get-Process | ConvertTo-Html Name, Company, CPU -Head $style -PreContent $titel | Out-File $HOME\report.hta
Invoke-Item -Path $HOME\report.hta


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\html_mit_hintergrund.ps1
************************************************************************
﻿$style = @"
 <style>
  body { background-image:url($("file:///$env:windir\web\wallpaper\windows\img0.jpg".Replace("\", "//"))); background-position:left top; background-repeat:repeat; }
  body,table,td,th { font-family:Tahoma; color:Black; Font-Size:10pt }
  th { font-weight:bold; background-color:#AAAAAA; }
  td { background-color:white; }
</style>
"@

Get-Process | ConvertTo-Html Name, Company, CPU -Head $style | Out-File $HOME\report.hta
Invoke-Item -Path $HOME\report.hta


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\html_systemreport.ps1
************************************************************************
﻿& {
'<HTML><HEAD><TITLE>Inventarisierungsbericht</TITLE>'
"<BODY><h2>Report für '$env:computername'</h2><h3>Diensteübersicht</h3>"
Get-Service | ConvertTo-Html DisplayName, ServiceName, Status -Fragment 
'<h3>Betriebssystem-Details</h3>'
Get-WMIObject Win32_OperatingSystem | Select-Object * -Exclude __* | ConvertTo-Html -As List -Fragment 
'<h3>Installierte Software</h3>'
Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, InstallDate, DisplayVersion, Language | ConvertTo-Html -Fragment
'</BODY></HTML>' 
} | Out-File $HOME\report.hta 

Invoke-Item -Path $HOME\report.hta


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\htmlanzeige.ps1
************************************************************************
﻿$html = Get-Process | Select-Object Name, Company, CPU | ConvertTo-Html | Out-String
$ie = New-Object -ComObject InternetExplorer.Application
$ie.Navigate("about:blank")
while ($ie.busy) { Start-Sleep -Milliseconds 200 }
$ie.Document.IHTMLDocument2_write($html)
$ie.Visible = $true


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\htmlformatiert.ps1
************************************************************************
﻿$style = @'
 <style>
  body { background-color:#EEEEEE; }
  body,table,td,th { font-family:Tahoma; color:Black; Font-Size:10pt }
  th { font-weight:bold; background-color:#AAAAAA; }
  td { background-color:white; }
 </style>
'@

Get-Process | ConvertTo-Html Name, Company, CPU -Head $style | Out-File $HOME\report.hta
Invoke-Item -Path $HOME\report.hta


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\Out-ExcelReport.ps1
************************************************************************
﻿Function Out-ExcelReport
{
  param
  (
    $Path = "$env:temp\$(Get-Random).csv"
  )

  $Input | Export-Csv -Path $Path -Encoding UTF8 -NoTypeInformation -UseCulture
  Invoke-Item -Path $Path
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\Out-HTML.ps1
************************************************************************
﻿Function Out-Html
{
  $html = $Input | ConvertTo-Html | Out-String
  $ie = New-Object -ComObject InternetExplorer.Application
  $ie.Navigate('about:blank')
  while ($ie.busy) { Start-Sleep -Milliseconds 200 }
  $ie.Visible = $true
  $ie.Document.IHTMLDocument2_write($html)
  while ($ie.busy) { Start-Sleep -Milliseconds 200 }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\Out-PDF.ps1
************************************************************************
﻿Function Out-PDF
{
  param
  (
    $Path = "$env:temp\$(Get-Random).pdf",
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k6 ergebnisse\Skripts\Out-WinWord.ps1
************************************************************************
﻿Function Out-WinWord
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\benannter_unterausdruck.ps1
************************************************************************
﻿$quellcode = '<a href="eine adresse">Link 1</a><a href="noch eine">Link 2</a>'
$pattern = '<a href="(?<link>.*?)".*?>(?<text>.*?)</a>'
$quellcode -match $pattern
$matches
$matches.link
$matches.text


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\delegat.ps1
************************************************************************
﻿$liste = 'server1', 'server2', 'server12'
$pattern = '(?i)server(\d{1,3})'
foreach($element in $liste) {
  [RegEx]::Replace(
    $element, 
    $pattern, 
    { param($match)
      $alles = $match.Groups[0].Value
      $id = $match.Groups[1].Value

      'VM_{0:000} (war mal {1})' -f [Int]$id, $alles 
    }
   ) 
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\find_kb1.ps1
************************************************************************
﻿$text = 'Das Problem ist in KB 254333299 beschrieben.'
$pattern = '\bKB\s{0,1}\d{6,9}\b'
if ($text -match $pattern) { 'Die KB-Nummer lautet {0}' -f $matches[0] } else { 'nix gefunden.' }


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\find_kb2.ps1
************************************************************************
﻿$pattern = '\b(KB|Artikel)\s{0,1}\d{6,9}\b'


$text = 'Das Problem ist in KB254333299 beschrieben.'
if ($text -match $pattern) { 'Die KB-Nummer lautet {0}' -f $matches[0] } else { 'nix gefunden.' }


$text = 'Das Problem ist in Artikel 254333299 beschrieben.'
if ($text -match $pattern) { 'Die KB-Nummer lautet {0}' -f $matches[0] } else { 'nix gefunden.' }



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\find_kb3.ps1
************************************************************************
﻿$pattern = '\b(?:KB|Artikel)\s{0,1}(\d{6,9})\b'


$text = 'Das Problem ist in KB254333299 beschrieben.'
if ($text -match $pattern) { 'Die KB-Nummer lautet KB{0}' -f $matches[1] } else { 'nix gefunden.' }


$text = 'Das Problem ist in Artikel 254333299 beschrieben.'
if ($text -match $pattern) { 'Die KB-Nummer lautet KB{0}' -f $matches[1] } else { 'nix gefunden.' }


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\Get-Matches.ps1
************************************************************************
﻿Function Get-Matches
{
  param
  (
    [Parameter(Mandatory=$true)]
    $Pattern,

    [Parameter(ValueFromPipeline=$true)]
    $InputObject
  )

  Begin
  {
    try {
      $regex = New-Object Regex($pattern)
    }
    catch {
      Throw "Get-Matches: Pattern not correct. '$Pattern' is no valid regular expression."
    }
    $groups = @($regex.GetGroupNames() |
      Where-Object { ($_ -as [Int32]) -eq $null } |
      ForEach-Object { $_.toString() })
  }

  Process
  {
    ForEach ($line in $InputObject)
    {
      ForEach ($match in ($regex.Matches($line)))
      {
        if ($groups.Count -eq 0)
        {
          ([Object[]]$match.Groups)[-1].Value
        }
        else
        {
          $rv = 1 | Select-Object -Property $groups
          $groups | ForEach-Object {
            $rv.$_ = $match.Groups[$_].Value
          }
          $rv
        }
      }
    }
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\grosskleinschreibung.ps1
************************************************************************
﻿$text = @'
Hier steht nichts.
Hier steht kb1234567.
Hier steht KB6635242.
'@

$pattern = 'KB\d{6,8}'

if ($text -match $pattern)
{
    '{0,-20} : gefunden: {1}' -f '-match', $matches[0]
}
else
{
    "nicht gefunden."
}

Get-Matches -Pattern $pattern -InputObject $text |
  ForEach-Object {
     '{0,-20} : gefunden: {1}' -f 'Get-Matches', $_
  }


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\mehrere_treffer1.ps1
************************************************************************
﻿$quellcode = '<a href="eine adresse">Link 1</a><a href="noch eine">Link 2</a>'
$pattern = '<a href="(?<link>.*?)".*?>(?<text>.*?)</a>'
Select-String -AllMatches -Pattern $pattern -InputObject $quellcode |
  Select-Object -ExpandProperty Matches |
  Foreach-Object { '{0}={1}' -f $_.Groups[1].Value, $_.Groups[2].Value }


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\mehrere_treffer2.ps1
************************************************************************
﻿$quellcode = '<a href="eine adresse">Link 1</a><a href="noch eine">Link 2</a>'
$pattern = '<a href="(?<link>.*?)".*?>(?<text>.*?)</a>'
$ergebnis = [RegEx]::Matches($quellcode, $pattern)

$ergebnis[0].Groups[1].Value
$ergebnis[0].Groups[2].Value
$ergebnis[1].Groups[1].Value
$ergebnis[1].Groups[2].Value


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\mehrere_treffer3.ps1
************************************************************************
﻿# erfordert die Funktion "Get-Matches"!

$quellcode = '<a href="eine adresse">Link 1</a><a href="noch eine">Link 2</a>'
$pattern = '<a href="(?<link>.*?)".*?>(?<text>.*?)</a>'
$ergebnis = Get-Matches -Pattern $pattern -InputObject $quellcode
$ergebnis
$ergebnis[0].link

# diese Anweisungen funktionieren erst in PowerShell 3.0:
$ergebnis.link
$ergebnis.text


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\multilinemodus.ps1
************************************************************************
﻿$text = @'
Hier folgt ein kleiner Text.
Diesen Text möchte ich als Zitat an eine Email anhängen.
Deshalb würde ich gern vor jede Zeile ein ">" stellen.
'@

$text -replace '^', '> '
$text -replace '(?m)^', '> '

################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\website_links1.ps1
************************************************************************
﻿# benötigt PowerShell 3.0!

# alle Links von dieser Webseite holen:
$url = 'http://www.tagesschau.de'

# Muster, um <a...></a>-Struktur auszuwerten:
$pattern = '<a href="(?<url>.*?)".*?>(?:<.*?>){0,}(?<title>.*?)(?:<.*?>){0,}</a>'

# Inhalt der Webseite abrufen (erfordert PowerShell 3.0):
$website = Invoke-WebRequest -UseBasicParsing -Uri $url

# alle Hyperlinks parsen:
$website.Links | Select-Object -ExpandProperty outerHTML | ForEach-Object {
  # trifft der Reguläre Ausdruck zu?
  if ($_ -match $pattern)
  {
    # ja, also dann findet sich der Linktitel jetzt in $matches.title
    # und die URL in $matches.url
    # falls Titel leer ist oder URL mit '#' beginnt, überspringen:
    if (($matches.title.Trim()) -ne '' -and ($matches.url.StartsWith('#') -eq $false))
    {
      # ein neues leeres Objekt mit den Eigenschaften "Title" und "URL" anlegen:
      $ergebnis = New-Object PSObject | Select-Object Title, URL

      # wenn die URL mit '/' beginnt, ist sie relativ
      if ($matches.url.StartsWith('/'))
      {
        # dann die URL der Homepage voranstellen:
        $ergebnis.URL = $url + $matches.url
      }
      else
      {
        # sonst die URL unverändert übernehmen:
        $ergebnis.URL = $matches.url
      }

      # Titel des Links in Objekt aufnehmen:
      $ergebnis.Title = $matches.title
      # Objekt dann als Ergebnis zurückgeben:
      $ergebnis
    }
  }
  # schließlich noch nach "Title" sortieren und im GridView ausgeben:
} | Sort-Object -Property Title |
Out-GridView -Title 'Aktuelle Links der Tagesschau-Webseite'  


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\website_links2.ps1
************************************************************************
﻿# alle Links von dieser Webseite holen:
$url = 'http://www.tagesschau.de'

# Muster, um <a...></a>-Struktur auszuwerten:
$pattern = '<a href="(?<url>.*?)".*?>(?:<.*?>){0,}(?<title>.*?)(?:<.*?>){0,}</a>'

# Inhalt der Webseite abrufen (funktioniert in dieser Weise nur bei direktem Internetzugang):
$webclient = New-Object System.Net.WebClient
$webclient.Encoding = [System.Text.Encoding]::UTF8

# Webseiteninhalt abrufen und als Gesamttext zusammenfügen:
$html = $webclient.DownloadString($url) | Out-String

# HTML parsen:
Get-Matches -Pattern $pattern -InputObject $html | ForEach-Object {
  # Linktitel findet sich jetzt in $_.title
  # und die URL in $_.url
  # falls Titel leer ist oder URL mit '#' beginnt, überspringen:

  if (($_.title.Trim()) -ne '' -and ($_.url.StartsWith('#') -eq $false))
  {
    # ein neues leeres Objekt mit den Eigenschaften "Title" und "URL" anlegen:
    $ergebnis = New-Object PSObject | Select-Object Title, URL

    # wenn die URL mit '/' beginnt, ist sie relativ

    if ($_.url.StartsWith('/'))
    {
      # dann die URL der Homepage voranstellen:
      $ergebnis.URL = $url + $_.url
    }
    else
    {
      # sonst die URL unverändert übernehmen:
      $ergebnis.URL = $_.url
    }

    # Titel des Links in Objekt aufnehmen:
    $ergebnis.Title = $_.title
    # Objekt dann als Ergebnis zurückgeben:
    $ergebnis
  }

  # schließlich noch nach "Title" sortieren:
} | Sort-Object -Property Title |
Out-GridView -Title 'Aktuelle Links der Tagesschau-Webseite'


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\windowsupdate_parsen1.ps1
************************************************************************
﻿# erfordert die Funktion "Get-Matches"!

$pattern = '(?<Datum>.*?)\t(?<Uhrzeit>.*?)\t.*?Installation Successful: Windows successfully installed the following update: (?<Update>.*)'
Get-Content $env:windir\windowsupdate.log -Encoding UTF8 | Get-Matches -Pattern $pattern 


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k7 Vergleichsoperatoren\Skripts\windowsupdate_parsen2.ps1
************************************************************************
﻿# erfordert die Funktion "Get-Matches"!

$pattern = '(?<Datum>\d{4}-\d{2}-\d{2})\t(?<Uhrzeit>\d{2}:\d{2}:\d{2}):\d{3}\t.*?the following update: (?<Update>.*)'
Get-Content $env:windir\windowsupdate.log -Encoding UTF8 | Get-Matches -Pattern $pattern 



################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Convert-Currency1.ps1
************************************************************************
﻿function Convert-Currency() {
  param
  (
    [Parameter(Mandatory=$true)]
    $Betrag, 

    $Wechselkurs = 5.77 
  )

  $Betrag * $Wechselkurs 
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Convert-Currency2.ps1
************************************************************************
﻿function Convert-Currency() {
  param
  (
    [Double]
    [Parameter(Mandatory=$true)]
    $Betrag, 

    $Wechselkurs = 5.77 
  )

  $Betrag * $Wechselkurs 
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Convert-Currency3.ps1
************************************************************************
﻿Function Convert-Currency
{
  param
  (
    [Double[]]
    [Parameter(Mandatory=$true)]
    $Betrag,

    $Wechselkurs = 5.77
  )

  ForEach ($wert in $betrag)
  {
    $wert * $Wechselkurs
  }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\get-bios1.ps1
************************************************************************
﻿function Get-BIOS
{
  param($ComputerName = $env:COMPUTERNAME)

  Get-WmiObject -Class Win32_BIOS -ComputerName $ComputerName
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Get-CriticalEvent1.ps1
************************************************************************
﻿function Get-CriticalEvent
{
  $heute = Get-Date
  $Differenz = New-TimeSpan -Hours 48
  $stichtag = $heute - $Differenz
  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag | 
    Select-Object -Property TimeGenerated, Message
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Get-CriticalEvent2.ps1
************************************************************************
﻿function Get-CriticalEvent
{
  param($Hours=48, [Switch]$ShowWindow)

  $heute = Get-Date
  $Differenz = New-TimeSpan -Hours 48
  $stichtag = $heute - $Differenz
  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag | 
    Select-Object -Property TimeGenerated, Message
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Get-CriticalEvent3.ps1
************************************************************************
﻿function Get-CriticalEvent
{
  param($Hours=48, [Switch]$ShowWindow)

  if ($ShowWindow)
  {
    Set-Alias -Name Out-Default -Value Out-GridView
  }
  
  $heute = Get-Date
  $differenz = New-TimeSpan -Hours $Hours
  $stichtag = $heute - $differenz
  Get-EventLog -LogName System -EntryType Error, Warning -After $stichtag | 
    Select-Object -Property TimeGenerated, Message |
    Out-Default
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Get-CriticalEvent4.ps1
************************************************************************
﻿function Get-CriticalEvent
{
<#
    .SYNOPSIS
        listet Fehler und Warnungen aus dem System-Logbuch auf
    .DESCRIPTION
        liefert Fehler und Warnungen der letzten 48 Stunden aus dem System-Logbuch,
        die auf Wunsch in einem GridView angezeigt werden. Der Beobachtungszeitraum
        kann mit dem Parameter -Hours geändert werden.
    .PARAMETER  Hours
        Anzahl der Stunden des Beobachtungszeitraums. Vorgabe ist 48.
    .PARAMETER  ShowWindow
        Wenn dieser Switch-Parameter angegeben wird, erscheint das Ergebnis in einem
        eigenen Fenster und wird nicht in die Konsole ausgegeben
    .EXAMPLE
        Get-CriticalEvent
        liefert Fehler und Warnungen der letzten 48 Stunden aus dem System-Logbuch
    .EXAMPLE
        Get-CriticalEvent -Hours 100
        liefert Fehler und Warnungen der letzten 100 Stunden aus dem System-Logbuch
    .EXAMPLE
        Get-CriticalEvent -Hours 24 -ShowWindow
        liefert Fehler und Warnungen der letzten 24 Stunden aus dem System-Logbuch und
        stellt sie in einem eigenen Fenster dar
    .NOTES
        Dies ist ein Beispiel aus "PowerShell Einsteigerworkshop"
    .LINK
        http://www.microsoft-press.de
#>
  param($Hours=48, [Switch]$ShowWindow)

  if ($ShowWindow)
  {
    Set-Alias Out-Default Out-GridView
  }

  $heute = Get-Date
  $differenz = New-TimeSpan -Hours $Hours
  $stichtag = $heute - $differenz

  Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag | 
    Select-Object -Property TimeGenerated, Message | Out-Default
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Get-FolderSize.ps1
************************************************************************
﻿function Get-FolderSize
{
  param
  (
    [Parameter(Mandatory=$true, HelpMessage='Enter the folder path to analyze')]
    $Path
  )

  Get-ChildItem -Path $Path -Recurse -ErrorAction SilentlyContinue -Force |
    Measure-Object -Property Length -Sum |
    Select-Object -ExpandProperty Sum
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Get-TopLevelProcess1.ps1
************************************************************************
﻿function Get-TopLevelProcess
{
    param
    (
      [Switch]
      $ShowWindow
    )

    if ($ShowWindow)
    {
        Set-Alias -Name Out-Default -Value Out-GridView
    }

    Get-Process | 
        Where-Object MainWindowTitle | 
        Select-Object -Property Name, Description, Company, CPU |
        Out-Default
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Get-TopLevelProcess2.ps1
************************************************************************
﻿function Get-TopLevelProcess
{
    param
    (
      [Switch]
      $ShowWindow
    )

    $result = Get-Process | 
        Where-Object MainWindowTitle | 
        Select-Object -Property Name, Description, Company, CPU 

    if ($ShowWindow)
    {
        $result | Out-GridView
    }
    else
    {
        $result
    }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\make_module.ps1
************************************************************************
﻿$name = 'Get-CriticalEvent'
New-Item -Path $home\Documents\WindowsPowerShell\Modules\$name\$name.psm1 -ItemType File -Force -Value  "function $name { $((Get-Item function:\$name).Definition) }"


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\positionalbinding.ps1
************************************************************************
﻿function test 
{
  [CmdletBinding(PositionalBinding=$false)] 
  param
  (
    $vorname,
    $nachname
  )

  'Vorname: {0}, Nachname: {1}' -f $vorname, $nachname 
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Speak-Text.ps1
************************************************************************
﻿function Speak-Text($text) {
  $speaker = New-Object -COMObject SAPI.SPVoice
  $speaker.Speak($text)
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\systemstatus.ps1
************************************************************************
﻿$heute = Get-Date
$Differenz = New-TimeSpan -Hours 48
$stichtag = $heute - $Differenz
Get-EventLog -LogName System -EntryType Error, Warning -After $Stichtag | 
  Select-Object -Property TimeGenerated, Message


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\test.ps1
************************************************************************
﻿function test 
{ 
  <#
  .SYNOPSIS
    Eine Testfunktion mit zwei Parametern
  #>
  param
  (
    # gibt den Vornamen an
    $vorname, 
    
    # gibt den Nachnamen an
    [Parameter(ParameterSetName='Beliebig')]
    $nachname
  ) 
  
  'Vorname: {0}, Nachname: {1}' -f $vorname, $nachname 
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Test-ReturnValue.ps1
************************************************************************
﻿Function Test-ReturnValue
{
  param
  (
    $Anzahl = 1
  )

  1..$Anzahl |
    ForEach-Object {  'ich wurde einfach liegengelassen' }
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k8 einfache funktionen\Skripts\Test-StatusMessage.ps1
************************************************************************
﻿Function Test-StatusMessage
{
  Write-Debug 'Dies ist ein Entwicklerkommentar'
  1..100 | ForEach-Object {
    Write-Progress -Activity 'Dies ist eine Fortschrittsanzeige' -Status $_ -PercentComplete $_
    Start-Sleep -Milliseconds 50
  }
  Write-Verbose 'Dies ist eine ausführliche Zusatzinfo'
  Write-Warning 'Dies ist eine Warnmeldung'
  Write-Error 'Dies ist eine Fehlermeldung'
  Write-Host 'Dies ist eine freidefinierte Meldung' -ForegroundColor Red -BackgroundColor Yellow
}


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k9 fehlerhandling\Skripts\Get-DerivedException.ps1
************************************************************************
﻿function Get-DerivedException {
  param
  (
    [Parameter(Mandatory=$true)]
    $ExceptionName
  )

  # alle geladenen .NET-Assemblies...
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k9 fehlerhandling\Skripts\prototyp.ps1
************************************************************************
﻿trap {
  $zeile = $_.InvocationInfo.Line
  $scriptname = $_.InvocationInfo.ScriptName
  $zeilennummer = $_.InvocationInfo.ScriptLineNumber
  $zeilenoffset = $_.InvocationInfo.OffsetInLine
  $meldung = $_.Exception.Message
  $zeit = Get-Date
  $user = $env:username

  $vorlage = @'
  #####################################################################
  Skriptfehler in "{0}"
  am {1} in Zeile {2} Spalte {3}:

  Ursache:
    "{4}"

  Befehlszeile:
    {5}
  Ausgeführt von {6}
  #####################################################################
  
'@ 

  $meldung = $vorlage -f $scriptname, $zeit, $zeilennummer, $zeilenoffset, $meldung, $zeile, $user  
  $meldung
  continue
}


# hier folgt der individuelle Code des Skripts:
dir zumsel: -ErrorAction Stop
1/$null
Get-Process -id 99999 -ErrorAction Stop


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k9 fehlerhandling\Skripts\spezifisch.ps1
************************************************************************
﻿trap [System.ArithmeticException] {
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k9 fehlerhandling\Skripts\trap1.ps1
************************************************************************
﻿# alle Fehler abfangen:
$Backup = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

trap [System.Management.Automation.ItemNotFoundException]
{
  "Ein Element wurde nicht gefunden: $_"
  continue
}

trap [System.DivideByZeroException]
{
  'Sie haben durch null dividiert'
  continue
}

trap [Microsoft.PowerShell.Commands.ProcessCommandException]
{
  'Sie haben Get-Process einen Prozessnamen genannt, aber solch ein Programm läuft nicht.'
  continue
}

trap [System.Management.Automation.RemoteException]
{
  "Es ist ein Problem beim Aufruf eines Konsolenbefehls aufgetreten: $_"
  continue
}

trap
{
  "Es ist ein allgemeiner Fehler aufgetreten: $_"
  continue
}

Get-ChildItem -Path c:\gibtesnicht
1/$null
Get-Process -Name gibtsnicht
net.exe user gibtsnicht

# vorheriges Fehlerverhalten wiederherstellen:
$ErrorActionPreference = $Backup


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k9 fehlerhandling\Skripts\trap2.ps1
************************************************************************
﻿# alle Fehler abfangen:
$Backup = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

trap 
{
  trap [System.Management.Automation.ItemNotFoundException]
  {
    "Ein Element wurde nicht gefunden: $_"
    continue
  }

  trap [System.DivideByZeroException]
  {
    'Sie haben durch null dividiert'
    continue
  }

  trap [Microsoft.PowerShell.Commands.ProcessCommandException]
  {
    'Sie haben Get-Process einen Prozessnamen genannt, aber solch ein Programm läuft nicht.'
    continue
  }

  trap [System.Management.Automation.RemoteException]
  {
    "Es ist ein Problem beim Aufruf eines Konsolenbefehls aufgetreten: $_"
    continue
  }

  trap
  {
    "Es ist ein allgemeiner Fehler aufgetreten: $_"
    continue
  }

  # hier wird die NEUE Exception basierend auf der echten alten Exception
  # ausgelöst. Diese wird dann von den inneren traps spezifisch gehandelt:
  Throw $_.Exception
  continue
}


Get-ChildItem -Path c:\gibtesnicht
1/$null
Get-Process -Name gibtsnicht
net.exe user gibtsnicht

# vorheriges Fehlerverhalten wiederherstellen:
$ErrorActionPreference = $Backup 


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################



c:\users\rocky\desktop\powershell books examples\scripting mit windows powershell 3.0 - der workshop\CD\k9 fehlerhandling\Skripts\verschachtelt.ps1
************************************************************************
﻿& {
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


################################################################
#
# VERWENDUNG DIESES SKRIPTS AUF EIGENE GEFAHR / OHNE ZUSICHERUNG
#
# Wichtiger Hinweis:
#
# Dieses PowerShell-Skript stammt aus den Begleitmedien des Buches
# "Scripting mit Windows PowerShell 3.0 - Der Workshop" von 
# Dr. Tobias Weltner, erschienen 2013 beim Verlag Microsoft Press
# (ISBN-13: 978-3-86645-687-7).
#
# Das Skript und seine Funktion werden im Buch erläutert und liegen
# in dieser Datei vor, um die Eingabe des Codes zu erleichtern.
#
# Bitte vergewissern Sie sich im Kontext des Buches und des jeweiligen
# Kapitels, was die Aufgabe und Funktionsweise dieses Skripts ist, 
# und dass das Skript vollständig dem abgedruckten Code im Buch entspricht. 
#
# Weder Autor noch Verlag übernehmen eine Haftung für Folgen, die durch die Ausführung
# dieses Skripts entstehen.
#
################################################################


