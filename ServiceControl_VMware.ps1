param($cmd)


##--------------------------------------------------------##
## Service Start Main
##--------------------------------------------------------##
function StartMain([string]$word) {
<#
    f_startService "VMware Authorization Service"
    f_startService "VMware DHCP Service"
    f_startService "VMware NAT Service"
    f_startService "VMware USB Arbitration Service"
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
    f_StopService "VMware Authorization Service"
    f_StopService "VMware DHCP Service"
    f_StopService "VMware NAT Service"
    f_StopService "VMware USB Arbitration Service"
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
    StartMain "VMware"
}
elseif ($lowerCmd -eq "stop") {
    StopMain "VMware"

}
elseif ($lowerCmd -eq "status") {
    $result = f_printService "VMware"
}
else {
    print_msg_and_exit
}
