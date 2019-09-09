param($cmd)

$execScript = "./ServiceControl.ps1"
$target_serviceName = "VMware"


##--------------------------------------------------------##
## Display Usage Message And Exit
##--------------------------------------------------------##
function print_msg_and_exit() {
    Write-Host "Usage :" $MyInvocation.MyCommand.Name "[Start | Stop | Status]"
    exit
}


##--------------------------------------------------------##
## Main
##--------------------------------------------------------##
if (-Not($cmd)) {
    print_msg_and_exit
}

$lowerCmd = $cmd.ToLower()

if ($lowerCmd -eq "start") {
    &$execScript $target_serviceName start
}
elseif ($lowerCmd -eq "stop") {
    &$execScript $target_serviceName stop
}
elseif ($lowerCmd -eq "status") {
    &$execScript $target_serviceName status
}
else {
    print_msg_and_exit
}


