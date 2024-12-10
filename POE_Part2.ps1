# Activity 1 
# 1
Get-Service | Where-Object {$_.Name -like "s*"};

$range = '^[hH-mM]$';
Get-Service | Where-Object {$_.Name -match $range};

# 2
Get-Process

# 3
Get-Process -IncludeUserName

# 4 
Get-Service | Sort-Object -Property Status

# 5 
Get-Process |  Where-Object {$_.PriorityClass -ne $null}    |
Group-Object -Property PriorityClass |
ForEach-Object {
    Write-Host "Priority Class: $($_.Name)"
    $_.Group | Select-Object Name, Id, PriorityClass
    Write-Host "----------------------------------"
}

# 6 
Get-Process | Where-Object {$_.StartTime -ne $null}
Sort-Object -Property StartTime |
Select-Object StartTime, Name | 
Format-Table

# 7 
Get-ChildItem -Path "C:\Windows\*.log" | 
Format-Table -AutoSize

# 8 
Get-ChildItem -Path "C:\Windows\*.log" -Recurse | 
Format-Table -AutoSize

# 9 

Get-ChildItem -Path "C:\Windows\*.log" | 
Select-String -Pattern "error|errors" 


# ----------
# Activity 2
# 1

$path = "C:\TainingFiles"
New-Item -Path $path -ItemType Directory -Force

New-Item -Path "$path\Demos" -Force -ItemType Directory
New-Item -Path "$path\Demos" -Force -ItemType File -Name "lab1.txt"

New-Item -Path "$path\Manuals" -Force -ItemType Directory
New-Item -Path "$path\Manuals" -Force -ItemType File -Name "gettingstarted.txt"
New-Item -Path "$path\Manuals" -Force -ItemType File -Name "powershellnotes.txt"

New-Item -Path "$path\reports" -Force -ItemType Directory
New-Item -Path "$path\reports" -ItemType File -Name "register.txt"

$headers = "NAME, SURNAME, TELEPHONE, DEPRATMENT, DATE"
Set-Content -Path "$path\reports\register.txt" -Value $headers


# 2

Set-Content -Path  "$path\Manuals\powershellnotes.txt" -Value "File to be updated. Work in progress"

Set-Content -Path  "$path\Demos\lab1.txt" -Value "File to be updated. Work in progress"

# 3 

New-Item -Path $path -ItemType File -Name "processes.html" -Force

$htmlContent = @"
<html>
<head>
    <title>Processes</title>
</head>
<body>
    <h1>List of Running Processes</h1>
    <table>
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>CPU</th>
            <th>Memory</th>
        </tr>
"@

$processes = Get-Process | 
ForEach-Object {
$htmlContent += "   <tr>
                        <td>$($_.Id)</td>
                        <td>$($_.Name)</td>
                        <td>$($_.CPU)</td>
                        <td>$($_.VM)</td>
                    </tr>`n"
}

# Close the HTML tags
$htmlContent += @"
    </table>
</body>
</html>
"@

Set-Content -Path "$path\processes.html" -Value $htmlContent

# 4 

$demos = "$path\Demos\lab1.txt"

if (Test-Path $demos){
    New-Item -Path "$path\Demos" -ItemType File -Name "Lab2.txt" -Force
    New-Item -Path "$path\Demos" -ItemType File -Name "Lab3.txt" -Force
    New-Item -Path "$path\Demos" -ItemType File -Name "Test.txt" -Force
}

# 5 
Copy-Item -Path "$path\Demos\Test.txt" -Destination "$path\Manuals" -Force
Copy-Item -Path "$path\Demos\Test.txt" -Destination "$path\reports" -Force

# 6 
Get-ChildItem -Path $path -Recurse

# 7 
Rename-Item -Path "$path\Demos\Test.txt" -NewName "KnightsOftheSouthernOrder.txt"

