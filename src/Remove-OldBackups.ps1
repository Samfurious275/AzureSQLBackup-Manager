param (
    [string]$StorageAccountName,
    [string]$StorageAccountKey,
    [string]$ContainerName = "sql-backups",
    [int]$RetentionDays = 7
)

try {
    # Create storage context
    $storageContext = New-AzStorageContext `
        -StorageAccountName $StorageAccountName `
        -StorageAccountKey $StorageAccountKey

    # Get current date
    $currentDate = Get-Date

    # List all blobs in the container
    $blobs = Get-AzStorageBlob -Container $ContainerName -Context $storageContext

    foreach ($blob in $blobs) {
        $blobLastModified = $blob.LastModified.DateTime

        # Calculate age of the blob
        $age = ($currentDate - $blobLastModified).Days

        if ($age -gt $RetentionDays) {
            Write-Output "Deleting old backup: $($blob.Name) (Last Modified: $blobLastModified)"
            Remove-AzStorageBlob -Container $ContainerName -Blob $blob.Name -Context $storageContext
        }
    }

    Write-Output "Cleanup complete. Retained backups older than $RetentionDays days."
    return $true
}
catch {
    Write-Error "Cleanup failed: $_"
    exit 1
}
