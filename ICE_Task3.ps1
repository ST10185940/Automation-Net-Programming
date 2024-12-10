 # 1
$num = -5;
if ($num -lt 0) {  # added parenthesis around conditional statement
    Write-Output "The number is negative";  # Write-Host insead of Write-Ouptut as it output to the terminal and is not pasrsed into another command
 }else{
    Write-Output "The number is positive";  # Write-Host insead of Write-Ouptut
 }

 # 2
$path = "C:\nonexistentfile.txt"
try{  # encased operation in try catch block 
    $content = Get-Content -Path $path -ErrorAction Stop;  # ensure any error is a terminating error allowing catch block to hanlde it  
    Write-Output $content; 
}catch{  #generic cacth block to catch all expcections
    Write-Host "File not found" # displays custom error message instead of compiler eror message , since error is known and anticipated
} 

#3
$num1 = 10;
$num2 = 0;
try{ # try catch block to make the operation robust and handle errors gracefully
    $result = $num1/$num2;
    Write-Host $result;
}catch [System.DivideByZeroException]{  # added specific Divide by zero expection 
    Write-Host "Thy Shall not divide by zero";
}catch{ # added geneic catch for all errors
    Write-Host "An erorr ocurred:"$_.ErrorDetails;
}

#4 
$DebugPreference = 'Continue';
$VerbosePreference = 'Continue';

Write-Verbose "Setting Debug and verbose Preferences";
Write-Verbose "Setting a file path";
$filename = "C:\example.txt"
Write-Verbose "Processing file: $filename"
try{
    Write-Verbose "Checking if the file exists"
    if (Test-Path $filename) {
        Write-Verbose "File found .Reading content"
        $content = Get-Content $filename 
        Write-Output $content; 
    } else {
        Write-Verbose "File not found at path: $filename"
    }
}catch [System.IO.FileNotFoundException]{
    Write-Verbose "File not found"
}catch{
    Write-Debug "An error occured: "$_.ErrorDetails;
}


# 5
Set-PSDebug -Trace 2
$a = 10
$b = 5
try{
    $c = $a - $b
    $total = $a + $b + $c
    Write-Output "Total is $total"
}catch{
    Write-Host "An error ocurrred: " $_.ErrorDetails
}
Set-PSDebug -Trace 0