param($cmd)


##--------------------------------------------------------##
## Service Start Main
##--------------------------------------------------------##
function StartMain([string]$word) {
<#
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
#>
    Write-Host "`nCurrent Status" -ForegroundColor Cyan
    $list_target = f_printService $word

    Write-Host $word "Services Starting..."

    foreach($serviceName in $list_target) {
        f_startService $serviceName
    }

    Write-Host "`nResult Status" -ForegroundColor Cyan
    $result = f_printService $word
}


##--------------------------------------------------------##
## Service Stop Main
##--------------------------------------------------------##
function StopMain([string]$word) {
<#
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
#>
    Write-Host "`nCurrent Status" -ForegroundColor Cyan
    $list_target = f_printService $word

    Write-Host $word "Services stopping..."

    foreach($serviceName in $list_target) {
        f_stopService $serviceName
    }

    Write-Host "`nResult Status" -ForegroundColor Cyan
    $result = f_printService $word
}


##--------------------------------------------------------##
## Start Services
##--------------------------------------------------------##
function f_startService([string]$ServiceName) {
    Write-Host "Starting ... " -NoNewline
    Write-Host $ServiceName -ForegroundColor Yellow

    Start-Service $ServiceName
}


##--------------------------------------------------------##
## Stop Services
##--------------------------------------------------------##
function f_StopService([string]$ServiceName) {
    Write-Host "Stoping ... " -NoNewline
    Write-Host $ServiceName -ForegroundColor Yellow

    Stop-Service $ServiceName
}


##--------------------------------------------------------##
## Display Service Status
##--------------------------------------------------------##
function f_printService([string]$word) {
    $list = Get-Service

    Write-Host "----------+--------------------+--------------------------------"
    $workStr = "{0,-10} {1,-20} {2,-20}" -f "Status", "Name", "DisplayName"
    Write-Host $workStr
    Write-Host "----------+--------------------+--------------------------------"

    $list_target = @()

    foreach($cur in $list) {
        if ($cur.ServiceName -eq $NULL) {
            continue
        }

        $pos = $cur.DisplayName.IndexOf($word)
        if ($pos -ge 0) {
            $workStr = "{0,-10} {1,-20} {2,-20}" -f $cur.Status, $cur.Name, $cur.DisplayName
            Write-Host $workStr
            
            $list_target += $cur.DisplayName
        }
    }
    Write-Host "----------+--------------------+--------------------------------"`n
    
    return $list_target
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
    StartMain "Hyper-V"
}
elseif ($lowerCmd -eq "stop") {
    StopMain "Hyper-V"

}
elseif ($lowerCmd -eq "status") {
    $result = f_printService "Hyper-V"
}
else {
    print_msg_and_exit
}
