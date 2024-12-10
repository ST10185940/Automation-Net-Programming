Start-Process notepad

Get-Process -name notepad | select-object id, cpu, path 

get-process | where-object {$_.WS -gt 50MB}

Stop-Process -name notepad

# Get RSAT items that are not currently installed:
$install = Get-WindowsCapability -Online |
  Where-Object {$_.Name -like "RSAT*" -AND $_.State -eq "NotPresent"}

# Install the RSAT items that meet the filter:
foreach ($item in $install) {
  try {
    Add-WindowsCapability -Online -Name $item.name
  }
  catch [System.Exception] {
    Write-Warning -Message $_.Exception.Message
  }
}

