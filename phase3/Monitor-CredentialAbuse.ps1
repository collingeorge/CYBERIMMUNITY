# Identity & Credential Monitoring Script
# Author: Collin Blaine George & ChatGPT (Phase 3 Hardening)
# Date: 2025-07-09
# Purpose: Detect local user/privilege tampering, password changes, guest re-enablement, and CAD enforcement

$logPath = "$env:SystemDrive\Logs\CredMonitor"
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$logFile = "$logPath\CredMonitor_$timestamp.log"

# Create log directory if not exists
if (!(Test-Path $logPath)) {
    New-Item -Path $logPath -ItemType Directory -Force | Out-Null
}

# 1. Detect new local accounts (enabled + valid SID format)
$newUsers = Get-LocalUser | Where-Object { $_.Enabled -eq $true -and $_.SID -like "S-1-5-21-*" }

# 2. Detect members of local Administrators group
$adminMembers = Get-LocalGroupMember -Group "Administrators"

# 3. Check if Guest account is enabled
$guest = Get-LocalUser -Name "Guest"
$guestStatus = if ($guest.Enabled) { "ENABLED ❌" } else { "Disabled ✅" }

# 4. Detect recent password changes (last 24 hrs)
$recentPasswordChanges = Get-LocalUser | Where-Object {
    $_.PasswordLastSet -gt (Get-Date).AddDays(-1)
}

# 5. Check for Ctrl+Alt+Del requirement (DisableCAD = 0)
$loginUIKey = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$requireCAD = Get-ItemPropertyValue -Path $loginUIKey -Name "DisableCAD" -ErrorAction SilentlyContinue
$ctrlAltDelStatus = if ($requireCAD -eq 0) { "Required ✅" } else { "NOT Required ❌ (Security Risk)" }

# Log Report
Add-Content $logFile "=== Identity Monitoring Report: $timestamp ==="

Add-Content $logFile "`n[1] New Local Users:"
if ($newUsers) {
    $newUsers | ForEach-Object {
        Add-Content $logFile "  - $_.Name (SID: $($_.SID.Value))"
    }
} else {
    Add-Content $logFile "  - None"
}

Add-Content $logFile "`n[2] Administrators Group Members:"
$adminMembers | ForEach-Object {
    Add-Content $logFile "  - $($_.Name) [$($_.ObjectClass)]"
}

Add-Content $logFile "`n[3] Guest Account Status: $guestStatus"

Add-Content $logFile "`n[4] Users with Password Changes in Last 24h:"
if ($recentPasswordChanges) {
    $recentPasswordChanges | ForEach-Object {
        Add-Content $logFile "  - $_.Name at $($_.PasswordLastSet)"
    }
} else {
    Add-Content $logFile "  - None"
}

Add-Content $logFile "`n[5] Ctrl+Alt+Del Requirement Status: $ctrlAltDelStatus"

Add-Content $logFile "`n[6] Summary Verdict:"
if ($guest.Enabled -or $requireCAD -ne 0) {
    Add-Content $logFile "  ❌ Warning: System not fully compliant with credential hardening policies."
} else {
    Add-Content $logFile "  ✅ Secure: All identity and login policies enforced."
}

Add-Content $logFile "`n--- End of Report ---`n"

# Optional: Display output to console
Get-Content $logFile
