function checkAge([int]$someAge){
    if($someAge -ge 18){
        write-host "adult"
    }else{
        write-host "child"
    }
}
checkAge -someAge 15


function GetWeather(){

    para(
        [Parameter(Mandatory=$true)]
        [string]$condition
    )
    switch($condition){
        "Sunny" {write-host "Its a sunny day outside."}
        "Rainy" {write-host "grab an umbrella"}
        "Snowy" {write-host "bundle up , its nippy outside"}
        default {write-host "that does happen around here!, what kind of weather IS that?"}
    }
}
GetWeather -condition Snowy

#Operators

# -eq : = 
# -ne : !=

# -gt : >
# -lt : <

# and, or , not 

$colors = @("Red", "Green", "Yellow", "Blue", "Cyan")

for ($i = 0; $i -lt $colors.Length; $i++) {
    $color = $colors[$i]
    Write-Host "Color $($i + 1): $color" -ForegroundColor $color
}

function AddUser{
  param([string]$name,[string]$last)
  $UserList += $user
  return $UserList
}



