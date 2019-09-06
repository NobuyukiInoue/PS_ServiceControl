param($cmd)


##--------------------------------------------------------##
## Service Start Main
##--------------------------------------------------------##
function StartMain() {
    Write-Host "Hyper-V Services Starting..."
    f_startService "Hyper-V ホスト コンピューティング サービス"
    f_startService "Hyper-V Guest Service Interface"
    f_startService "Hyper-V Heartbeat Service"
    f_startService "Hyper-V Data Exchange Service"
    f_startService "Hyper-V リモート デスクトップ仮想化サービス"
    f_startService "Hyper-V Guest Shutdown Service"
    f_startService "Hyper-V Time Synchronization Service"
    f_startService "Hyper-V PowerShell Direct Service"
    f_startService "Hyper-V ボリューム シャドウ コピー リクエスター"
    f_startService "Hyper-V Virtual Machine Management"
    f_printService("Hyper-V")
}

##--------------------------------------------------------##
## Service Stop Main
##--------------------------------------------------------##
function StopMain() {
    Write-Host "Hyper-V Services stopping..."
    f_stopService "Hyper-V ホスト コンピューティング サービス"
    f_stopService "Hyper-V Guest Service Interface"
    f_stopService "Hyper-V Heartbeat Service"
    f_stopService "Hyper-V Data Exchange Service"
    f_stopService "Hyper-V リモート デスクトップ仮想化サービス"
    f_stopService "Hyper-V Guest Shutdown Service"
    f_stopService "Hyper-V Time Synchronization Service"
    f_stopService "Hyper-V PowerShell Direct Service"
    f_stopService "Hyper-V ボリューム シャドウ コピー リクエスター"
    f_stopService "Hyper-V Virtual Machine Management"
    f_printService("Hyper-V")
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
    f_printService("Hyper-V")
}
else {
    print_msg_and_exit
}
