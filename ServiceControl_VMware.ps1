param($cmd)

##--------------------------------------------------------##
## Service Start Main
##--------------------------------------------------------##
function StartMain() {
    Write-Host "VMware Services Starting..."
    f_startService "VMware Authorization Service"
    f_startService "VMware DHCP Service"
    f_startService "VMware NAT Service"
    f_startService "VMware USB Arbitration Service"
    f_printService("VMware")
}

##--------------------------------------------------------##
## Service Stop Main
##--------------------------------------------------------##
function StopMain() {
    Write-Host "VMware Services Stopping..."
    f_StopService "VMware Authorization Service"
    f_StopService "VMware DHCP Service"
    f_StopService "VMware NAT Service"
    f_StopService "VMware USB Arbitration Service"
    f_printService("VMware")
}

##--------------------------------------------------------##
## Start Services
##--------------------------------------------------------##
function f_startService($ServiceName) {
    Write-Host "Starting ... " -NoNewline
    Write-Host $ServiceName -ForegroundColor Yellow

    Start-Service $ServiceName
}

##--------------------------------------------------------##
## Stop Services
##--------------------------------------------------------##
function f_StopService($ServiceName) {
    Write-Host "Stoping ... " -NoNewline
    Write-Host $ServiceName -ForegroundColor Yellow

    Stop-Service $ServiceName
}

##--------------------------------------------------------##
## Display Service Status
##--------------------------------------------------------##
function f_printService($word) {
    $list = Get-Service

    Write-Host `n"----------+--------------------+--------------------------------"
    $workStr = "{0,-10} {1,-20} {2,-20}" -f "Status", "Name", "DisplayName"
    Write-Host $workStr
    Write-Host "----------+--------------------+--------------------------------"

    foreach($cur in $list) {
        if ($cur.ServiceName -eq $NULL) {
            continue
        }

        $pos = $cur.DisplayName.IndexOf($word)
        if ($pos -ge 0) {
            $workStr = "{0,-10} {1,-20} {2,-20}" -f $cur.Status, $cur.Name, $cur.DisplayName
            Write-Host $workStr
        }
    }
    Write-Host "----------+--------------------+--------------------------------"`n
}

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
    StartMain
}
elseif ($lowerCmd -eq "stop") {
    StopMain

}
elseif ($lowerCmd -eq "status") {
    f_printService("VMware")
}
else {
    print_msg_and_exit
}
