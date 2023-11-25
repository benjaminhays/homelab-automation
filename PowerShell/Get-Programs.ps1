# Get-Programs.ps1
# (c) Ben Hays, 2023
# Description: Get a list of installed programs for backup purposes

$FinalList = @()

# Grab list from common directories
$ProgramDirs = "C:\Program Files", "C:\Program Files (x86)"
$FinalList += Get-ChildItem $ProgramDirs | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty Name -Unique | Sort-Object

# Grab list from Windows Registry
$FinalList += Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object { $_.DisplayName } | Select-Object -ExpandProperty DisplayName -Unique
$FinalList += Get-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object { $_.DisplayName } | Select-Object -ExpandProperty DisplayName -Unique

Write-Output $FinalList