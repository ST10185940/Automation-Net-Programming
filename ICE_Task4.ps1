#1
Get-Process |
Where-Object {$_.WorkingSet -gt 100MB}

#2
$dir = "C:\Windows";
Get-ChildItem -Path $dir |
Sort-Object Length -Descending | 
Select-Object FullName , Length -First 10

#3

Get-Service | Where-Object {$_.Status -eq "Running"} |
Select-Object DisplayName

#4
Get-EventLog -LogName System | 
Where-Object {$_.InstanceID -gt 1000} |
Sort-Object -Property Name |
Select-Object DisplayName
Format-Table -AutoSize


#5
Get-WmiObject -Class Win32_LogonSession |
Where-Object {$_.LogonType -eq 2} |  # Interactive logon sessions
ForEach-Object {
    $user = (Get-WmiObject -Query "ASSOCIATORS OF {Win32_LogonSession.LogonId='$($_.LogonId)'} WHERE AssocClass=Win32_LoggedOnUser").Name
    [PSCustomObject]@{
        Name = $user
        LogonTime = [System.Management.ManagementDateTimeConverter]::ToDateTime($_.StartTime)
    }
} |
Sort-Object -Property LogonTime |
Format-Table Name, LogonTime -AutoSize

#6

Get-ChildItem Env: |
Sort-Object Name | 
Export-Csv -Path "C:\Users\blazi\Desktop\Env_Variables.csv" -NoTypeInformation


#7

$car = @{
    make = "Buick"
    model = "Grand National"
    year  = 1987
}

foreach($key in $car.Keys){
    $value = $car[$key]
    Write-Host " $key : $value"
}

#8
$device = [PSCustomObject]@{
    MAC = "00-B0-D0-63-C2-26"
    IP = "192.158.1.255"
    Status = "Active"
}

Write-Host "Device properties:"
$device.MAC 
$device.IP
$device.Status

#9
$person = [PSCustomObject]@{
    First_Name = "Mad"
    Last_Name = "Max"
}

function Get-FullName {
    param (
       [PSCustomObject]$person
    )
    if(!$person.PSObject.Properties["FullName"]){
        $person | Add-Member -MemberType NoteProperty -Name "FullName" -Value ($person.First_Name + " " +  $person.Last_Name) -Force
    }
    Write-Host $person.FullName
}

Get-FullName -person $person
Write-Host $person

#10s
$book = [PSCustomObject]@{
    title =  "Blood Meridian"
    author = "Cormac Mc Carthy"
    year = 1985
}

$book | Add-Member -MemberType ScriptMethod -Name "OlderThan20yrs" -Value {
    return (Get-Date).Year - $book.year -gt 20 
}

$book.OlderThan20yrs()

#11
class Student {
    [int]$studentNum
    [string]$Name
    [double]$Grade

    Student([int]$stnum, [string]$name , [int]$grade){
        $this.studentNum = $stnum
        $this.Name = $name
        $this.Grade = $grade
    }
}

$st1 = [Student]::new(11,"Freddy",77.7)
$st2 = [Student]::new(11,"Vince",88.5)
$st3 = [Student]::new(11,"Joson",93.4)

$students = @($st1 , $st2 , $st3)

function Get-Averages([Student[]]$students){
    $totalgrades
    foreach($st in $students){
        $totalgrades += $st.Grade
    }
    $average = $totalgrades / $students.Count 
    $average = [Math]::Round($average,2) 
    Write-Host "Grade average is:" $average "%"
}

Get-Averages -students $students

#13

class Computer{
    [string]$CPU_Type
    [int]$RAM
    [int]$Disk_Space

    Computer([string]$cpu_type,[int]$ram,[int]$disk_space){
        $this.CPU_Type = $cpu_type
        $this.RAM = $ram
        $this.Disk_Space = $disk_space
    }

    [string]UpgradeRAM([int]$ram){
       if($ram -gt 0  && $ram.GetType -eq [int]){
         $this.RAM += $ram
         return "Device RAM Updated by $ram and is now : $($this.RAM) GB"
       }else {
        return "Error updating RAM"
       }   
    }

    [string]AddDiskSpace([int]$space){
        if($space -gt 0  && $space.GetType -eq [int]){
          $this.Disk_Space += $space
          return "Device Disk Space Updated by $space  and is now : $($this.Disk_Space) GB"
        }else {
         return "Error adding Disk Space"
        }   
     }
}


$pc = [Computer]::new("Core i5" , 16 , 500)

$pc.UpgradeRAM(16)
$pc.AddDiskSpace(500)


