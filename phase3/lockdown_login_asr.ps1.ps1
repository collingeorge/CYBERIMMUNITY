# Requires Administrator privileges

# 1. Require CTRL+ALT+DEL at logon
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name "DisableCAD" -Value 0

# 2. Do NOT display last username
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name "DontDisplayLastUserName" -Value 1

# 3. Always show username + password fields (remove user list)
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name 'UserSwitch' -Value 0
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name 'ShowOtherUsers' -Value 1

# 4. Disable guest account (default RID 501)
Get-LocalUser | Where-Object {$_.SID -like '*-501'} | ForEach-Object {
    Disable-LocalUser -Name $_.Name
}

# 5. Disable RDP connections
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 1

# 6. Enable Attack Surface Reduction (ASR) rules (Defender must be active)
# Rule: Block credential stealing from LSASS (required for hardened environments)
# Rule: Block credential stealing via WDigest downgrade
Set-MpPreference -AttackSurfaceReductionRules_Ids `
    D4F940AB-401B-4EFC-AADC-AD5F3C50688A, `
    75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84 `
    -AttackSurfaceReductionRules_Actions Enabled

Write-Host "✅ Login lockdown and ASR rules applied successfully."
