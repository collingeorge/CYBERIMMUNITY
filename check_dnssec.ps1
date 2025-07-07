# check_dnssec.ps1

$logPath = "$PSScriptRoot\dnssec_audit_log.txt"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$log = @()
$log += "🧪 DNSSEC Integrity Check - $date"

# This domain should FAIL to resolve if DNSSEC is working
$dnssecFail = nslookup dnssec-failed.org 2>&1
if ($dnssecFail -match "can't find|NXDOMAIN|Server failed") {
    $log += "✅ dnssec-failed.org correctly blocked (DNSSEC validation enforced)."
} else {
    $log += "❌ dnssec-failed.org resolved. DNSSEC validation may be bypassed."
    $log += $dnssecFail
}

# This domain should SUCCEED to resolve
$dnssecPass = nslookup dnssec-tools.org 2>&1
if ($dnssecPass -match "Address") {
    $log += "✅ dnssec-tools.org resolved successfully (Valid DNSSEC domain)."
} else {
    $log += "❌ dnssec-tools.org failed to resolve. Unexpected."
    $log += $dnssecPass
}

$log += "`n--------------------------------------------------`n"
$log | Out-File -FilePath $logPath -Append -Encoding UTF8
Write-Output "✅ DNSSEC audit complete. Results logged."
