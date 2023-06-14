$backupFolder = "D:\Backup"
$daysToKeep = 7
$currentDate = Get-Date

# Get all files in the backup folder
$backupFiles = Get-ChildItem -Path $backupFolder -Filter "*.bak" -File

foreach ($file in $backupFiles) {
    $fileCreationDate = $file.CreationTime

    # Calculate the number of days between the current date and file creation date
    $daysDifference = ($currentDate - $fileCreationDate).Days

    if ($daysDifference -gt $daysToKeep) {
        Write-Host "Deleting file: $($file.FullName)"
        Remove-Item -Path $file.FullName -Force
    }
}
