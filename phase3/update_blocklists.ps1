# Path to original firewall script
$scriptPath = "$env:USERPROFILE\Downloads\Cyberimmune_Bundle_v2\phase3\firewall_blocklists.ps1"

# Optional: Log file
$logFile = "$env:USERPROFILE\cyberimmune_blocklist_update.log"

# Run the main script and log output
try {
    Write-Output "`n[$(Get-Date)] Running blocklist update..." | Tee-Object -FilePath $logFile -Append
    & $scriptPath | Tee-Object -FilePath $logFile -Append
    Write-Output "[$(Get-Date)] Blocklist update complete.`n" | Tee-Object -FilePath $logFile -Append
} catch {
    Write-Error "Error during blocklist update: $_" | Tee-Object -FilePath $logFile -Append
}