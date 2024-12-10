#create dir and text file with content

[string]$basedir = "C:\Users\blazi\OneDrive\Documents\PowerShell"

New-Item -path $basedir\"BeginnerDocs" -ItemType Directory -Force

Get-ChildItem -Path $basedir -Filter ".*txt"

set-content -path $basedir\"beginner.txt" -value "hello powershell"

Get-ChildItem -Path $basedir\"*.txt" | rename-item -NewName {$_.Name -replace '.txt' , '.bak'}

Get-ChildItem -Path $basedir | Where-Object ${$_.Country -eq 'USA'} 

# copy and move files with filtering for file types 
$backupDir = "C:\Users\blazi\OneDrive\Documents\PowerShell\Backup"
new-item -path $backupDir -ItemType Directory -Force
Get-ChildItem -path "C:\Users\blazi\OneDrive\Documents\PowerShell" -filter "*.bak" -Recurse | Copy-Item -Destination $backupDir


#alert for file changes 
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\BeginnerDocs"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents =$true
Register-ObjectEvent $watcher "created" -Action {Write-Host "new files added: $($Event.SourceEventArgs.FullPath)"}

[xml]$xmlContent = Get-Content -path "C:\BeginnerDocs\data.xml"
$xmlContent.users.user | where-object {[int]$_.age -gt 25} | foreach-object {Write-Host $_.name}


