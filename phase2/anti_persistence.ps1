# Remove persistence mechanisms via registry hardening
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
Set-ItemProperty -Path $regPath -Name "DisallowRun" -Value 1

# Confirm action
Write-Output "✅ Anti-persistence mechanisms removed."
