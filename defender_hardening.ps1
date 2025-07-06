
# Cyber Immune System: Windows Defender Hardening Script
Set-MpPreference -PUAProtection Enabled
Set-MpPreference -DisableRealtimeMonitoring $false
Set-MpPreference -MAPSReporting Advanced
Set-MpPreference -SubmitSamplesConsent 1
Set-MpPreference -CloudProtectionLevel High
Set-MpPreference -EnableControlledFolderAccess Enabled
