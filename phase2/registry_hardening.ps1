# registry_hardening.ps1
# Part of Cyberimmune Phase 2

Write-Host "`n[+] Enabling LSA Protection..." -ForegroundColor Cyan
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RunAsPPL" -Value 1

Write-Host "[+] Disabling Remote Desktop (RDP)..." -ForegroundColor Cyan
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 1

Write-Host "[+] Disabling USB mass storage devices..." -ForegroundColor Cyan
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR" -Name "Start" -Value 4

Write-Host "`n✅ Registry hardening complete." -ForegroundColor Green
