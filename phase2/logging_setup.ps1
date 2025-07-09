# Enable Module Logging
$modLogPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging"
if (-not (Test-Path $modLogPath)) {
    New-Item -Path $modLogPath -Force | Out-Null
}
Set-ItemProperty -Path $modLogPath -Name "EnableModuleLogging" -Value 1

# Enable Script Block Logging
$sbLogPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
if (-not (Test-Path $sbLogPath)) {
    New-Item -Path $sbLogPath -Force | Out-Null
}
Set-ItemProperty -Path $sbLogPath -Name "EnableScriptBlockLogging" -Value 1

# Confirm action
Write-Output "✅ Logging configuration complete."
