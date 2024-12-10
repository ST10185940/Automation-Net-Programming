Get-ChildItem -Path "C:\Users\blazi"  -Recurse -File |
sort-object -property Length -Descending | 
select-object -First 5  -Property Name , Length , Directory |
Format-Table -AutoSize


get-process | where-object {$_.WS -gt 50MB } | Sort-Object WS -Descending |
select-object  -Property Name, WS -First 10


# Section 1 Pswh Pipelines
#Q1
Get-Process  | 
where-object {$_.WS -gt 100MB} |
Select-Object -Property Name


#Q2
Get-ChildItem C:\Windows -File |
Sort-Object -Property Length -Descending |
select-object -First 10 -Property Name

#Q3
Get-Service |
where-object {$_.Status -eq "Stopped" } |
select-object -Property Name


#Aliases
Set-Alias -Name bigRamUsage -Value Get-Process  | 
Where-object {$_.WS -gt 200MB} |
Select-Object  -First 10 -Property Name  


#network issue resolution 
Test-NetConnection -ComputerName "crowdstrike.com" -TraceRoute

Get-NetAdapterStatistics -Name "Wi-Fi"


Clear-DnsClientCache

Get-NetIPAddress | 
select-object IPv6Address , InterfaceAlias , AddressFamily

#Q4
Get-EventLog -LogName System |
Where-object {$_.InstanceID -gt 1000} |
Sort-Object -Property Name |
Format-Table -AutoSize




