param($ServiceName, $cmd)


##--------------------------------------------------------##
## Service Start Main
##--------------------------------------------------------##
function StartMain([string]$word) {
    Write-Host `n"Current Status" -ForegroundColor Cyan
    $list_target = get_targetService $word

    Write-Host $word "Services Starting..."

    foreach($cur in $list_target) {
        f_startService $cur.DisplayName
    }

    Write-Host `n"Result Status" -ForegroundColor Cyan
    $result = get_targetService $word
}


##--------------------------------------------------------##
## Service Stop Main
##--------------------------------------------------------##
function StopMain([string]$word) {
    Write-Host `n"Current Status" -ForegroundColor Cyan
    $list_target = get_targetService $word

    Write-Host $word "Services stopping..."

    foreach($cur in $list_target) {
        f_stopService $cur.DisplayName
    }

    Write-Host `n"Result Status" -ForegroundColor Cyan
    $result = get_targetService $word
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
## find target Service and Display Status
##--------------------------------------------------------##
function get_targetService([string]$word) {
    Write-Host "----------+--------------------+--------------------------------"
    $workStr = "{0,-10} {1,-20} {2,-20}" -f "Status", "Name", "DisplayName"
    Write-Host $workStr
    Write-Host "----------+--------------------+--------------------------------"

    $list_target = Get-Service | Where-Object {$_.DisplayName.IndexOf($word) -ge 0}

    foreach($cur in $list_target) {
        $workStr = "{0,-10} {1,-20} {2,-20}" -f $cur.Status, $cur.Name, $cur.DisplayName
        Write-Host $workStr
    }
    Write-Host "----------+--------------------+--------------------------------"`n

    return $list_target
}


##--------------------------------------------------------##
## Display Usage Message And Exit
##--------------------------------------------------------##
function print_msg_and_exit() {
    Write-Host "Usage :" $MyInvocation.MyCommand.Name [ServiceNameString] "[Start | Stop | Status]"
    exit
}


##--------------------------------------------------------##
## Main
##--------------------------------------------------------##
if (-Not($serviceName)) {
    print_msg_and_exit
}

if (-Not($cmd)) {
    print_msg_and_exit
}

$lowerCmd = $cmd.ToLower()

if ($lowerCmd -eq "start") {
    StartMain $serviceName
}
elseif ($lowerCmd -eq "stop") {
    StopMain $serviceName
}
elseif ($lowerCmd -eq "status") {
    $result = get_targetService $serviceName
}
else {
    print_msg_and_exit
}
