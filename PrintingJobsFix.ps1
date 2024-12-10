function Get-StuckPrintJobs{
    param(
        [int]$ageInMin
    )
    $cutoffTime = (get-date).AddMinutes(-$ageInMin)
    Get-PrintJob -ComputerName $env:COMPUTERNAME |
    Where-Object {$_.SubmittedTime -lt $cutoffTime}
}

function Remove-PrintJob{
    param(
        [Microsoft.Management.Infrastructure.CimInstance]$PrintJob
    )
    try{
        Remove-PrintJob -InputObject $PrintJob
        Write-Host "Removed print job: $($PrintJob.Name)"
    }catch{
        write-host "failed to remove prit job: $($PrintJob.Name)"
    }
}

$age = 30

$stuckJobs = Get-StuckPrintJobs -ageInMin $age

if($stuckJobs.Count -eq 0){
    write-host "No stuck print jobs"
}else{
    write-host "Found: $($stuckJobs.Count) stuck jobs:"
    $stuckJobs| ForEach-Object Write-Host "$($_.name)"
    Write-Host "Removing stuck jobs found"
    foreach($job in $stuckJobs){
        Remove-PrintJob -PrintJob $job
    }
}

Write-Host "Print queue cleared of stuck print jobs"