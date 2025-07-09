# BitLocker Configuration Script (AES-256 + PIN)
# Enables BitLocker using TPM + PIN and AES-256 encryption

# Require additional authentication at startup (PIN)
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v UseAdvancedStartup /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v UseTPM /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v UseTPMPIN /t REG_DWORD /d 1 /f

# Set encryption to AES-256
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v EncryptionMethodWithXtsOs /t REG_DWORD /d 7 /f

# Enable BitLocker on C: if not already
Enable-BitLocker -MountPoint "C:" -EncryptionMethod Aes256 -UsedSpaceOnly -TpmAndPinProtector

Write-Host "✅ BitLocker AES-256 with PIN policy applied."