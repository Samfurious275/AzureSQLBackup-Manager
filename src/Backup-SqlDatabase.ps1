param (
    [string]$ResourceGroupName,
    [string]$SqlServerName,
    [string]$DatabaseName,
    [string]$StorageAccountName,
    [string]$ContainerName,
    [string]$StorageAccountKey
)

try {
    # Create storage context
    $storageContext = New-AzStorageContext `
        -StorageAccountName $StorageAccountName `
        -StorageAccountKey $StorageAccountKey

    # Generate backup filename
    $backupFile = "$DatabaseName-$(Get-Date -Format 'yyyyMMddHHmm').bak"

    # Export database to Blob Storage
    $exportRequest = New-AzSqlDatabaseExport `
        -ResourceGroupName $ResourceGroupName `
        -ServerName $SqlServerName `
        -DatabaseName $DatabaseName `
        -StorageKeyType "SharedAccessKey" `
        -StorageKey $StorageAccountKey `
        -StorageUri "https://$StorageAccountName.blob.core.windows.net/$ContainerName/$backupFile"

    Write-Output "Backup started: $backupFile"
    return $true
}
catch {
    Write-Error "Backup failed: $_"
    exit 1
}
