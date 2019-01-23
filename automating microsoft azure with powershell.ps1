
c:\users\rocky\desktop\powershell books examples\automating microsoft azure with powershell\8873EN_Code\8873EN_02_Code\8873EN_02_Code\BackupFiles.ps1
************************************************************************
# Script Variables: Update these variables depending on the system configuration
$azureStorageAccessKey = "<Insert key here>"
$azureStorageAccountName = "<Insert storage account name here>"

$pathToCompress = "C:\BackupFiles"

$azureSdkVersion = "v2.5"
$programFilesPath = "C:\Program Files"

# Add the Microsoft.WindowsAzure.Storage.dll assembly to the PowerShell session
# Update the Path provided if using a different version of the Azure SDK for .NET or if Program Files is on a different drive
Add-Type -Path ($programFilesPath + "\Microsoft SDKs\Azure\.NET SDK\" + $azureSdkVersion + "\ToolsRef\Microsoft.WindowsAzure.Storage.dll") -ErrorAction SilentlyContinue

# Setup Functions to Zip Files
# From http://blogs.msdn.com/b/daiken/archive/2007/02/12/compress-files-with-windows-powershell-then-package-a-windows-vista-sidebar-gadget.aspx
function New-Zip
{
	param([string]$zipfilename)
	set-content $zipfilename ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
	(dir $zipfilename).IsReadOnly = $false
}

function Add-Zip
{
	param([string]$zipfilename)

	if(-not (test-path($zipfilename)))
	{
		set-content $zipfilename ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
		(dir $zipfilename).IsReadOnly = $false	
	}
	
	$shellApplication = new-object -com shell.application
	$zipPackage = $shellApplication.NameSpace($zipfilename)
	
	foreach($file in $input) 
	{ 
        $zipPackage.CopyHere($file.FullName)
        Start-sleep -milliseconds 500
	}
}


# Get the files to backup, exclude sub-directories
$files = Get-ChildItem -Path $pathToCompress | Where-Object { $_.PsIsContainer -eq $false }

# Compress the files
Write-Host "Compressing Backup Files"
$backupDate = Get-Date
$zipName = ("Backup_" + $backupDate.ToString("yyyy_MM_dd_HH_mm_ss") + ".zip")
$zipPath = [System.IO.Path]::Combine($pwd.Path, $zipName)
New-Zip $zipPath
$files | Add-Zip $zipPath

# Create the Azure storage account context
$context = New-AzureStorageContext $azureStorageAccountName $azureStorageAccessKey

# Get or create the Azure blob container for backups
$container = Get-AzureStorageContainer -Name backups -Context $context -ErrorAction SilentlyContinue
if ($container -eq $null)
{
    $container = New-AzureStorageContainer -Name backups -Context $context -Permission Off
}

# Upload the backup to Azure blob storage
Write-Host "Uploading Backup Files to Azure Blob Storage"
Set-AzureStorageBlobContent -File $zipPath -Blob $zipName -Container backups -Context $context

# Get or create the Azure table for backup records
$table = Get-AzureStorageTable backuprecords -Context $context -ErrorAction SilentlyContinue
if ($table -eq $null)
{
    $table = New-AzureStorageTable backuprecords -Context $context
}

# Insert a record of each backed up file into the table
Write-Host "Writing File Records to Azure Table Storage"
$row = 0
foreach ($file in $files)
{
    $filePath = $file.FullName

    # The backup name will be used as the PartitionKey and the RowKey will be $row
    $entity = New-Object Microsoft.WindowsAzure.Storage.Table.DynamicTableEntity -ArgumentList $zipName, $row
    $entity.Properties.Add("BackupDate", [String] $backupDate.ToString())
    $entity.Properties.Add("BackupZip", [String] $zipName)
    $entity.Properties.Add("FilePath", [String] $filePath)

    # Execute the table insert operation
    # The $result variable could be used to determine the success or failure of the operation
    $result = $table.CloudTable.Execute([Microsoft.WindowsAzure.Storage.Table.TableOperation]::Insert($entity))    
    $row = $row + 1
}

# Get or create the Azure Queue to send the backup message
$queue = Get-AzureStorageQueue backupqueue -Context $context -ErrorAction SilentlyContinue
if ($queue -eq $null)
{
    $queue = New-AzureStorageQueue backupqueue -Context $context
}

# Create the message to send
$messageString = ("Backup '" + $zipName + "' completed. " + $files.Count.ToString() + " files backed up.");
$message = New-Object Microsoft.WindowsAzure.Storage.Queue.CloudQueueMessage -ArgumentList $messageString

# Send the message to the queue
Write-Host "Sending Message to Azure Queue Storage"
$queue.CloudQueue.AddMessage($message)

# Complete
Write-Host $messageString

