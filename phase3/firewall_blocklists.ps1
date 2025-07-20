<#
.SYNOPSIS
Blocks known malicious IPs via Windows Defender Firewall using curated blocklists.
.DESCRIPTION
Downloads IPs from FireHOL and other threat intel sources, creates blocking rules in Windows Firewall.
#>

# Ensure running as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator." ; exit 1
}

Write-Host "`n🛡 Applying firewall blocklists..." -ForegroundColor Cyan

# Define rule group name for consistency
$ruleGroup = "CYBERIMMUNE_Blocklists"

# Define blocklist sources
$blocklists = @(
    "https://iplists.firehol.org/files/iblocklist_pedophiles.netset",
    "https://iplists.firehol.org/files/firehol_level1.netset",
    "https://iplists.firehol.org/files/firehol_level2.netset",
    "https://iplists.firehol.org/files/firehol_level3.netset",
    "https://iplists.firehol.org/files/firehol_level4.netset",
    "https://iplists.firehol.org/files/firehol_webclient.netset",
    "https://iplists.firehol.org/files/blocklist_de.ipset",
    "https://iplists.firehol.org/files/dshield_1d.netset",
    "https://iplists.firehol.org/files/greensnow.ipset",
    "https://iplists.firehol.org/files/spamhaus_drop.netset",
    "https://iplists.firehol.org/files/ciarmy.ipset",
    "https://iplists.firehol.org/files/alienvault_reputation.ipset",
    "https://iplists.firehol.org/files/dshield.netset",
    "https://iplists.firehol.org/files/dm_tor.ipset",
    "https://iplists.firehol.org/files/voipbl.netset",
    "https://iplists.firehol.org/files/geolite2_country/anonymous.netset",
    "https://iplists.firehol.org/files/geolite2_country/continent_af.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_af.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_am.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_az.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_by.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_cn.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_cu.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_dz.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_eg.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_ge.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_hk.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_id.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_in.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_iq.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_ir.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_kg.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_kp.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_kz.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_lk.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_ly.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_md.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_mn.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_mo.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_my.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_ni.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_pk.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_ru.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_sa.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_sy.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_tj.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_tk.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_tm.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_tw.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_ua.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_uz.netset",
    "https://iplists.firehol.org/files/geolite2_country/country_vn.netset"
)

# Temporary IP storage
$allIPs = @{}

# Download and store valid IPs
foreach ($url in $blocklists) {
    try {
        $raw = Invoke-RestMethod -Uri $url -UseBasicParsing -ErrorAction Stop
        $ips = $raw -split "`n" | Where-Object { $_ -match '^\d{1,3}(\.\d{1,3}){3}(/\d{1,2})?$' -and -not ($_ -like '#*') }
        foreach ($ip in $ips) {
            $allIPs[$ip.Trim()] = $true
        }
        Write-Host "✅ Fetched: $url" -ForegroundColor Green
    } catch {
        Write-Warning "⚠️ Failed to fetch: $url. Error: $_"
    }
}

# Clean up old rules in this group
Get-NetFirewallRule -Group $ruleGroup -ErrorAction SilentlyContinue | Remove-NetFirewallRule -Confirm:$false

# Batch and create new rules
$ipList = $allIPs.Keys
$batchSize = 1000
$i = 0
$batch = @()

foreach ($ip in $ipList) {
    $batch += $ip
    if ($batch.Count -ge $batchSize) {
        New-NetFirewallRule -DisplayName "Blocklist_$i" -Direction Inbound -Action Block -RemoteAddress $batch -Group $ruleGroup -Profile Any
	New-NetFirewallRule -DisplayName "Blocklist_$i" -Direction Outbound -Action Block -RemoteAddress $batch -Group $ruleGroup -Profile Any
        $batch = @(); $i++
    }
}

# Final batch
if ($batch.Count -gt 0) {
    New-NetFirewallRule -DisplayName "Blocklist_$i" -Direction Inbound -Action Block -RemoteAddress $batch -Group $ruleGroup -Profile Any
}

Write-Host "`n✅ Firewall rules successfully applied under group: $ruleGroup" -ForegroundColor Green
