New-Item  -Path 'C:\Users\blazi\OneDrive\Documents\PowerShell\Exc_For_6-09-2024\Example_Dir' -Name "New_Dir"  -ItemType Directory
$new_root =  'C:\Users\blazi\OneDrive\Documents\PowerShell\Exc_For_6-09-2024\Example_Dir\New_Dir'
$sub_root =  new-item -Path $new_root\"sub_dir" -name ""

New-Item -Path $new_root -ItemType File -Name "exercise.txt" 
Set-Content -Path $new_root\"exercise.txt" -value " a line of text"

Add-Content -path $new_root\"exercise.txt" -value "some more text"

Get-ChildItem -path $new_root -Recurse

$lastsv = (Get-Date).AddDays(-7)
Get-ChildItem -path $new_root | Where-Object {$_.LastWriteTime -gt $lastsv}

Get-ChildItem -path $new_root | Copy-Item -Destination $sub_root

$lastMnth = (Get-Date).AddDays(-30)
Get-ChildItem -path $sub_root | Where-Object {$_.LastAccessTime -gt $lastMnth} | Remove-Item


