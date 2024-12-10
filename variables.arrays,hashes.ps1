#1
$myVariable = 10;
Write-Host $myVariable;

#2
[string]$myString = "Hello powershell";
$myString.GetType();

#3
[int]$myVal = 100;
$myVal = $myVal*20;
Write-Host $myVal
$myVal.GetType();

#4
[string]$first = "John"
[string]$last = "Doe"
Write-Host "my name is $first $last"

#5
write-host $env:Path

#6
$myArray =  10,20,30,40,50,60
Write-Host $myArray[2]

#8 
$array = 2,4,6,8,10
for ( $i =  1; $i -gt $array.Length; i++ ){
    write-host $array[$i];
}

#9
$fruits = "apple","pear","grenade"
foreach ($fruit in $fruits){
    write-host "i like $fuit"
}

#10
$numbers = 1,20,40,50,33,44,56,73,91
$sortedNums  = $numbers | sort-object -Descending
write-host $sortedNums

#11
$person = @{
    name = "max"
    age = 78;
    occupation = "dev"
}
write-host $person

#12
write-host $person["occupation"]

#13
$person["location"] = "NYC"
write-host $person["location"]
write-host $persion

#14
$person.Remove("age")
write-host $person["age"]


#15
foreach ($key in $person.Keys){
    $value = $person[$key]
    write-host "$key : $value"
}


Copy-Item '.\variables.arrays,hashes.ps1' -Destination $root 


Get-Item '.\variables.arrays,hashes.ps1' | 
Copy-Item -Destination 'Exc_For_6-09-2024' -PassThru | 
Rename-Item -NewName {$_.Name -replace '.ps1','.txt'}
