# check_dns_integrity.ps1

$trustedDnsServers = @(
    "9.9.9.9",     # Quad9
    "1.1.1.1",     # Cloudflare
    "8.8.8.8"      # Google
)

$testDomains = @(
    "proton.me",
    "cloudflare.com",
    "microsoft.com"
)

foreach ($domain in $testDomains) {
    foreach ($dns in $trustedDnsServers) {
        $result = nslookup $domain $dns
        Add-Content -Path "$PSScriptRoot\dns_integrity_log.txt" -Value $result
    }
}
Write-Output "✅ DNS integrity test complete. Log saved."
