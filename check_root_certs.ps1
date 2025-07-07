# check_root_certs.ps1

$baselinePath = "$PSScriptRoot\baseline_root_certs.txt"

# Generate baseline if it doesn't exist
if (-Not (Test-Path $baselinePath)) {
    Write-Output "🛡️  Baseline file not found. Creating trusted baseline of Root CA store..."
    Get-ChildItem -Path Cert:\LocalMachine\Root |
        Select-Object Thumbprint, Subject |
        Sort-Object Thumbprint |
        Out-String |
        Set-Content -Path $baselinePath
    Write-Output "✅ Baseline saved to: $baselinePath"
    exit
}

# Current snapshot
$currentCerts = Get-ChildItem -Path Cert:\LocalMachine\Root |
    Select-Object Thumbprint, Subject |
    Sort-Object Thumbprint |
    Out-String

# Load baseline
$baselineCerts = Get-Content $baselinePath -Raw

# Compare snapshots
$diff = Compare-Object -ReferenceObject $baselineCerts -DifferenceObject $currentCerts

if ($diff) {
    Write-Warning "⚠️ Root certificate store has changed!"
    $timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
    $diff | Out-File "$PSScriptRoot\root_store_diff_$timestamp.txt"
} else {
    Write-Output "✅ Root CA store unchanged."
}
