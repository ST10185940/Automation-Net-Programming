function prompt {
    "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
}

function Get-Weather {
    param([string]$City = "Gauteng")
    (Invoke-WebRequest "http://wttr.in/$City?format=3").Content
}

function Show-SystemInfo {
    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor
    $mem = Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum

    Write-Host " "
    Write-Host "System Information" -ForegroundColor Cyan
    Write-Host "=================" -ForegroundColor Cyan
    Write-Host "OS: $($os.Caption) $($os.Version)"
    Write-Host "CPU: $($cpu.Name)"
    Write-Host "RAM: $([math]::Round($mem.Sum / 1GB, 2)) GB"
    Write-Host "Uptime: $((Get-Date) - $os.LastBootUpTime)"
}

# function Get-BatteryStatus {
#     $battery = Get-WmiObject Win32_Battery
#     if ($battery) {
#         $status = switch ($battery.BatteryStatus) {
#             1 { "Discharging" }
#             2 { "AC Power" }
#             3 { "Fully Charged" }
#             4 { "Low" }
#             5 { "Critical" }
#             default { "Unknown" }
#         }
        
#         Write-Host "Battery Status: $status"
#         Write-Host "Charge Remaining: $($battery.EstimatedChargeRemaining)%"
#     } else {
#         Write-Host "No battery detected. This might be a desktop computer."
#     }
# }

# Set PSReadLine options (for better command-line editing):
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

Write-Host "Welcome to PowerShell, Moses!, Today is $(Get-Date -Format 'dddd, MMMM dd, yyyy')" -ForegroundColor Cyan
Show-SystemInfo

Set-Alias lvim 'C:\Users\blazi\.local\bin\lvim.ps1'
