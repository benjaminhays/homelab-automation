# Find-RDP.ps1
# (c) Ben Hays, 2023
# Description: Find all the computers joined to an AD domain that are running RDP

$computers = Get-ADComputer -Filter *
foreach ($Name in $computers.DNSHostName) {
    $rdpSuccess = Test-Connection -TargetName $Name -TimeoutSeconds 2 -TcpPort 3389 -Quiet
    if ($rdpSuccess) {
        Write-Output $Name
    }
}
