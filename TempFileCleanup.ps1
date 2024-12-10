function Remove-TempFiles{
    param(
        [string]$path,
        [int]$ageInDays
    )

    $ExpiryDate = (Get-Date).AddDays($age);

    Get-ChildItem -Path $path -Recurse -File |
    Where-Object {$_.LastWriteTime -lt $ExpiryDate} |
    ForEach-Object{
        try{
            remove-item $_.FullName -Force
            Write-Host "Deleted: $($_.FullName)"
        }catch{
            Write-Host "Failed to delete  $($_.FullName)"
        }
    }
}

$tempFolders = @(
    "$env:C:\Users\blazi\Desktop\TestTempFiles"
)

$daysOld = 7

foreach($folder in $tempFolders){
    Write-Host "cleaning temp files in folder $folder older than $daysOld days"
    Remove-TempFiles -path $folder -ageInDays $daysOld
}


Write-Host "Temp files have been removed. Cleanup complete!"

