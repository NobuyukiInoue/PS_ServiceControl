Get-Service | Where-Object {$_.status -eq "running"}
Get-Service | Where-Object {$_.status -eq "stopped"}
