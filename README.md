# Cyberimmune: Comprehensive Device Hardening & Privacy Guide

A personal cybersecurity hardening project designed to build an “immune system” for your devices — focused on Windows 11 Enterprise and iOS 18.5, integrating network protections, privacy best practices, and app-level security controls.

---

## Table of Contents

* [Overview](#overview)
* [Windows 11 Enterprise Hardening](#windows-11-enterprise-hardening)
* [iOS 18.5 Security & Privacy](#ios-185-security--privacy)
* [Network & DNS Hardening](#network--dns-hardening)
* [ProtonVPN vs Apple Private Relay](#protonvpn-vs-apple-private-relay)
* [Checklist Summaries](#checklist-summaries)
* [Usage & Installation](#usage--installation)
* [License](#license)

---

## Overview

This project consolidates best practices, scripts, and configuration profiles to secure your Windows 11 Enterprise workstation and iOS device from malware, network attacks, and privacy leaks. By combining system hardening, DNS security, and app-level protections with trusted VPN and DNS services, you achieve a layered “cyberimmune” defense.

---

## Windows 11 Enterprise Hardening

### Phase 1: Baseline Hardening Scripts (in `phase1/`)

* `phase1/defender_hardening.ps1` — Full hardening script (for systems using Defender)
* `phase1/norton_compatible_hardening.ps1` — Compatible with Norton 360 or other AVs
* `phase1/create_restore_point.ps1` — Creates a system restore point

### Phase 2: Advanced System Integrity Controls (in `phase2/`)

* `phase2/anti_persistence.ps1` — Removes persistence vectors via registry and WSH
* `phase2/logging_setup.ps1` — Enables PowerShell Module and ScriptBlock logging
* `phase2/bitlocker_aes256_pin.ps1` — Enables AES-256 BitLocker with preboot PIN (coming)

📄 [Read Phase 2 Documentation](docs/Phase2.md)

### Run the Scripts with PowerShell

```powershell
cd $env:USERPROFILE\Downloads\Cyberimmune_Bundle_v2
powershell -ExecutionPolicy Bypass -File .\phase1\create_restore_point.ps1
powershell -ExecutionPolicy Bypass -File .\phase1\defender_hardening.ps1
powershell -ExecutionPolicy Bypass -File .\phase2\anti_persistence.ps1
powershell -ExecutionPolicy Bypass -File .\phase2\logging_setup.ps1
```

---

## iOS 18.5 Security & Privacy

### Key Features

* Requires Face ID/Touch ID for individual app access (long-press app > Protect App)
* Enforces DNS-over-HTTPS using Quad9 or NextDNS via DNS Override app
* Uses ProtonVPN for full-device encrypted network traffic
* Manual DNS Proxy profiles cannot be installed without MDM — DNS Override app recommended
* Leverages iOS built-in security features like Screen Time and App Tracking Transparency

---

## Network & DNS Hardening

### Recommended DNS Providers

* **Quad9** — Blocks known malware and phishing domains with a strong privacy policy
* **NextDNS** — Highly customizable, with enhanced tracking and malware filtering

### DNS Setup on Devices

* **Windows 11** — Configure Quad9 or NextDNS IPs and enable DNS-over-HTTPS via system settings or PowerShell
* **iOS 18.5** — Use DNS Override app to enforce Quad9/NextDNS for Wi-Fi and cellular globally
* **VPN** — Use ProtonVPN Duo subscription for full-device encrypted traffic and IP masking

---

## ProtonVPN vs Apple Private Relay

| Feature               | Apple Private Relay               | ProtonVPN                         |
| --------------------- | --------------------------------- | --------------------------------- |
| Scope                 | Safari/web traffic only           | Full device traffic encryption    |
| Privacy               | Obscures IP from websites & Apple | Masks IP from ISP & network       |
| Speed                 | Very fast                         | Fast, depends on server load      |
| Configuration         | Minimal, automatic                | Full control (servers, protocols) |
| Compatibility         | iOS/macOS only                    | Multi-platform                    |
| Subscription Required | iCloud+                           | ProtonVPN subscription            |

**Recommendation:** Use ProtonVPN as primary VPN for full-device protection. Disable Apple Private Relay when ProtonVPN is active (they cannot run simultaneously).

---

## Checklist Summaries

### Windows 11 Enterprise Checklist

* [x] Create system restore point
* [x] Disable SMBv1 and Remote Desktop if unused
* [x] Enable SmartScreen via registry or Defender settings
* [x] Harden exploit protection (DEP, SEHOP, CFG, etc.)
* [x] Disable telemetry (set AllowTelemetry=0)
* [x] Configure DNS to Quad9 or NextDNS (DoH enabled)
* [x] Use ProtonVPN for encrypted network traffic
* [x] Regularly update OS and security software
* [x] Apply Phase 2 scripts for credential and script auditing hardening
* [x] Optionally use Norton-compatible hardening if Norton AV installed

---

### iOS 18.5 Checklist

* [x] Enable Face ID/Touch ID with app-level protection (long-press app > Protect App)
* [x] Use DNS Override app to enforce Quad9 or NextDNS globally
* [x] Use ProtonVPN for full-device VPN encryption
* [x] Disable Auto-Join on untrusted Wi-Fi
* [x] Disable location, microphone, camera access for unnecessary apps
* [x] Enable Screen Time restrictions and App Tracking Transparency
* [x] Keep iOS and apps up to date
* [x] Use strong passwords and 2FA on Apple ID and apps

---

## Usage & Installation

1. Download or clone the project from GitHub.
2. Run `phase1/create_restore_point.ps1` before making any changes.
3. Apply Phase 1 scripts depending on Defender/Norton usage.
4. Run Phase 2 scripts for enhanced security logging and credential isolation.
5. On iOS, install DNS Override and ProtonVPN from the App Store.
6. Refer to checklist and maintain regular updates and backups.

---

## License

MIT License — Free to use, modify, and share. Please attribute original work to Collin Blaine George.

---

## Contact

For questions or collaboration, reach out via GitHub issues or email.

---

# Thank you for securing your digital life with Cyberimmune!

---
