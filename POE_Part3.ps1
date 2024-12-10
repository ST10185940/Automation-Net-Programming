function get-SysDetails{
    param ($computer)
    
        $OS = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $Computer 
        $BIOS = Get-WmiObject -Class Win32_BIOS -ComputerName $Computer
        $CompSystem = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $Computer 

    [PSCustomObject]@{
        OSversionName = $OS.Caption + " " + $OS.Version
        Domain = $CompSystem.Domain
        DomainHost = $CompSystem.DNSHostName
        BIOSSerial = $BIOS.SerialNumber
    }
}

get-SysDetails -computer "SystemM" | Format-Table -AutoSize


$cname = Read-Host "Enter remote computer name"

if(!$cname -match "localhost"){
    Get-WmiObject -Class Win32_ComputerSystem -ComputerName $cname -ErrorAction Stop |
    Format-Table -AutoSize
}


Get-WmiObject -Class Win32_LogicalDisk |
ForEach-Object {
    $drivetypestring = switch ($_.DriveType) {
        1 { "NoRootDirectory" }
        2 { "Removable" }
        3 { "Fixed Disk" }
        4 { "Network Drive" }
    }
    [PSCustomObject]@{
        DeviceID = $_.DeviceID
        DriveType = $drivetypestring
    }
    
} | Format-Table -AutoSize


Import-Module ActiveDirectory

$computers = Get-ADComputer -Filter * -Properties OperatingSystem, OperatingSystemServicePack

$computers | 
Group-Object -Property OperatingSystem, OperatingSystemServicePack | 
Sort-Object Count -Descending | 
ForEach-Object {
    [PSCustomObject]@{
        'OS' = $_.Group[0].OperatingSystem
        'ServicePack' = $_.Group[0].OperatingSystemServicePack
        'Count' = $_.Count
    }
} | Format-Table -AutoSize

Write-Host "`nTotal Computers: $($computers.Count)" 



Get-ADComputer |
ForEach-Object -Parallel {
    Get-Service -ComputerName $_.Name |
            Where-Object {
                $_.StartType -ne "Automatic" -and $_.Status -ne "Running"
            } | ForEach-Object{
                    [PSCustomObject]@{
                        Service = $_.Name
                        DisplayName = $_.DisplayName
                        Status = $_.Status
                        StartType = $_.StartType
                    }
                }
        
} | Group-Object Service |
Format-Table -AutoSize


# Get-ADComputer -Filter * -Properties LastLogonDate, IPv4Address |
# Where-Object { $_.LastLogonDate -and $_.LastLogonDate -lt (Get-Date).AddDays(-60) } |
# ForEach-Object {
#     $days = (New-TimeSpan -Start $_.LastLogonDate -End (Get-Date)).Days

#     if ($days -ge 90) {
#         Remove-ADComputer -Identity $_.DistinguishedName -Confirm:$false
#     }
#     else {
#         Move-ADObject -Identity $_.DistinguishedName -TargetPath "OU=Disabled,DC=domain,DC=com"
#     }

#     if ($_.IPv4Address) {
#         Move-ADObject -Identity $_.DistinguishedName -TargetPath (
#             switch (($_.IPv4Address -split '\.')[0..2] -join '.') {
#                 '192.168.1' { "OU=Internal,DC=domain,DC=com" }
#                 '10.0.0'    { "OU=Network,DC=domain,DC=com" }
#                 default     { "OU=Unassigned,DC=domain,DC=com" }
#             }
#         )
#     }
# }


# A
Get-Service | Where-Object {$_.Status -eq "Stopped"}  | Select-Object -First 10 

# B
Get-Service | Where-Object {$_.Name -like 'C*'} | Select-Object -First 10

# C
Get-Service | Where-Object {$_.StartType -eq "Automatic"} | Select-Object -Property DisplayName, StartType -First 5 

# D
Restart-Service Winmgmt

# E 
Get-Service | 
Select-Object Name, Status | 
Out-File -FilePath "C:\Users\blazi\Desktop\Services_Report.txt"

Import-Module ActiveDirectory

New-ADUser -Name "Morbius M. Morbius" `
  -GivenName "Morbius" `
  -Surname "Morbius" `
  -SamAccountName "Morbius" `
  -UserPrincipalName "Morbius@yourdomain.com" `
  -Path "OU=Users,DC=yourdomain,DC=com" `
  -AccountPassword (ConvertTo-SecureString "P@ssword!" -AsPlainText -Force) `
  -Enabled $true

Move-ADObject -Identity "CN=Morbius M. Morbius,OU=Users,DC=yourdomain,DC=com" `
-TargetPath "OU=Administrators,DC=yourdomain,DC=com"



$string = "PShell"
$height = 5

for($i = 1; $i -le $height ; $i++){
   for ($j = 1; $j -le $height - $i ; $j++) {
    Write-Host -NoNewline $string
   }
   Write-Host
}


$timetable = @{
    "Monday" = "NEPR7312"
    "Tuesday" = "NEPR7312"
    "Wednesday" = "NEPR7312"
}

$timetable  | Format-Table -AutoSize


$connectedIPs = @()

Get-NetTCPConnection | ForEach-Object {
    $connectedIPs += $_.LocalAddress
}

$connectedIPs | Select-Object -First 5

# Get the IP configuration data and exclude IPX and WINS properties
Get-NetIPConfiguration | Select-Object -Property InterfaceAlias, IPv4Address, IPv6Address, DefaultGateway, DNSServer, DHCP, PNPDeviceID | Format-Table -AutoSize


For ($i = 1; $i -lt 255; $i++) {
    $ip = "172.16.0.$i"
    Test-Connection -ComputerName $ip -Count 1 -Quiet
}

Get-NetAdapter | Where-Object {$_.DHCPEnabled -eq $true -and $_.Status -eq 'Up'} #status up for ones that are operational 

