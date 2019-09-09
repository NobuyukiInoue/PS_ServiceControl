param($cmd)


if (-Not($cmd)) {
    Write-Host "Usage :" $MyInvocation.MyCommand.Name "[Start | Stop]"
    exit
}

$lowerCmd = $cmd.ToLower()

if ($lowerCmd -eq "on") {
    bcdedit /set hypervisorlaunchtype auto
}

elseif ($lowerCmd -eq "off") {
    bcdedit /set hypervisorlaunchtype off
}
