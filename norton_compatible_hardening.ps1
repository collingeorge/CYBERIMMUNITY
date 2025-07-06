# Disable SMBv1 (legacy, insecure)
Disable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -NoRestart

# Disable Remote Desktop (unless explicitly needed)
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 1

# Enable SmartScreen via Registry (Explorer)
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'SmartScreenEnabled' -Value 'RequireAdmin'

# Enable SmartScreen for Microsoft Edge
New-Item -Path 'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -Force | Out-Null
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -Name 'EnabledV9' -Value 1 -Type DWord

# Disable Telemetry (Windows 11 Enterprise respects this)
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0

# Harden Exploit Protection (safe with Norton)
Set-ProcessMitigation -System -Enable DEP, SEHOP, BottomUp, HighEntropy, CFG

Write-Host "✅ Cyber immune system hardening complete. Safe for use with Norton 360."
