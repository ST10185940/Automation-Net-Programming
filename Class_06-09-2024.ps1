$root = 'C:\Users\blazi\OneDrive\Documents\PowerShel'
$path = 'C:\Users\blazi\OneDrive\Documents\PowerShell\Exc_For_6-09-2024'

# bulk rename
Get-ChildItem -path  $root -filter "*.txt" |
Rename-Item -NewName {$_.name -replace '.txt', '.bak'}


#mving all files of same type 
Get-ChildItem -Path $root -Filter '*.jpg' |
Move-Item -Destination $path 

#filtering 
Get-ChildItem -Path $root |
Where-Object {$._Legth -gt 1MB}


#count lines in a txt file
$lines = [System.IO.File]::ReadAllLines($root).Count
write-host "total records: $lines"


New-Item -Path 'C:\Users\blazi\OneDrive\Documents\PowerShell\Exc_For_6-09-2024' -Name "Example_Dir" -ItemType Directory
$exampleDir = 'C:\Users\blazi\OneDrive\Documents\PowerShell\Exc_For_6-09-2024\Example_Dir'

#monitoring 
$daysAgo = (Get-Date).AddDays(-3)
Get-ChildItem -Path $exampleDir -File |
Where-Object {$_.LastWriteTime -gt $daysAgo} 

$oneMonthAgo = (get-date).AddDays(-30)
Get-ChildItem -path $exampleDir -file |
where-object {$_.LastWriteTime -gt $oneMonthAgo} | Remove-Item


$path = 'C:\Users\blazi\OneDrive\Documents\PowerShell\beginnerq3e3.txt'
if(test-path $path){
    Resolve-Path $path
}else{
    write-host "path does not exist"
}




