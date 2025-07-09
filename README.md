# Cyberimmune: Comprehensive Device Hardening & Privacy Guide

A personal cybersecurity hardening project designed to build an “immune system” for your devices — focused on Windows 11 Enterprise and iOS 18.5, integrating network protections, privacy best practices, and app-level security controls.

---

## Table of Contents

- [Overview](#overview)  
- [Windows 11 Enterprise Hardening](#windows-11-enterprise-hardening)  
- [iOS 18.5 Security & Privacy](#ios-185-security--privacy)  
- [Network & DNS Hardening](#network--dns-hardening)  
- [Scheduled Integrity & DNSSEC Monitoring](#scheduled-integrity--dnssec-monitoring)  
- [ProtonVPN vs Apple Private Relay](#protonvpn-vs-apple-private-relay)  
- [Checklist Summaries](#checklist-summaries)  
- [Usage & Installation](#usage--installation)  
- [License](#license)  

---

## Overview

This project consolidates best practices, scripts, and configuration profiles to secure your Windows 11 Enterprise workstation and iOS device from malware, network attacks, and privacy leaks. By combining system hardening, DNS security, and app-level protections with trusted VPN and DNS services, you achieve a layered “cyberimmune” defense.

---

## Windows 11 Enterprise Hardening

### Key Features

- Disables legacy and insecure protocols (SMBv1, Remote Desktop)  
- Enforces SmartScreen and Exploit Protection  
- Limits telemetry and data collection  
- Compatible with third-party antivirus solutions (e.g., Norton 360)  
- Includes PowerShell scripts for automation  
- Automated scheduled tasks for continuous integrity monitoring  

### Included Scripts

- `defender_hardening.ps1` — Full hardening script (for systems using Defender)  
- `norton_compatible_hardening.ps1` — Hardening script compatible with Norton 360 or other AVs that suppress Defender  
- `create_restore_point.ps1` — Creates a Windows restore point before applying changes  
- `check_root_certs.ps1` — Checks for unexpected changes in trusted Root CA store  
- `check_dns_integrity.ps1` — Monitors DNS resolution consistency  
- `check_dnssec.ps1` — Validates DNSSEC support on configured DNS servers  

### Run the Scripts with PowerShell

```
cd $env:USERPROFILE\Downloads
powershell -ExecutionPolicy Bypass -File .\create_restore_point.ps1
powershell -ExecutionPolicy Bypass -File .\defender_hardening.ps1
powershell -ExecutionPolicy Bypass -File .\norton_compatible_hardening.ps1
powershell -ExecutionPolicy Bypass -File .\check_root_certs.ps1
powershell -ExecutionPolicy Bypass -File .\check_dns_integrity.ps1
powershell -ExecutionPolicy Bypass -File .\check_dnssec.ps1
```

### Scheduled Tasks

Automated scheduled tasks run weekly to:

- Validate Root CA certificate store integrity  
- Monitor DNS resolution integrity  
- Verify DNSSEC validation status  

---

## iOS 18.5 Security & Privacy

### Key Features

- Requires Face ID/Touch ID for individual app access (long-press app > Protect App)  
- Enforces DNS-over-HTTPS using Quad9 or NextDNS via DNS Override app  
- Uses ProtonVPN for full-device encrypted network traffic  
- Manual DNS Proxy profiles cannot be installed without MDM — DNS Override app recommended  
- Leverages iOS built-in security features like Screen Time and App Tracking Transparency  

---

## Network & DNS Hardening

### Recommended DNS Providers

- **Quad9** — Blocks known malware and phishing domains with strong privacy policy  
- **NextDNS** — Highly customizable, with enhanced tracking and malware filtering  

### DNS Setup on Devices

- **Windows 11** — Configure Quad9 or NextDNS IPs and enable DNS-over-HTTPS via system settings or PowerShell  
- **iOS 18.5** — Use DNS Override app to enforce Quad9/NextDNS for Wi-Fi and cellular globally  
- **VPN** — Use ProtonVPN Duo subscription for full-device encrypted traffic and IP masking  

---

## Scheduled Integrity & DNSSEC Monitoring

Continuous monitoring of your system’s trustworthiness and DNS security is essential to prevent stealthy man-in-the-middle attacks and DNS spoofing.

- **Root CA Store Integrity** — Weekly verification that no unauthorized certificates have been added or removed from the trusted Root CA store.  
- **DNS Integrity** — Checks DNS responses over time to detect anomalies or hijacking attempts.  
- **DNSSEC Validation** — Confirms that your configured DNS servers correctly validate DNSSEC-signed domains, ensuring cryptographic authenticity of DNS data.

Logs from these checks are saved locally for audit and troubleshooting.

---

## ProtonVPN vs Apple Private Relay

| Feature                | Apple Private Relay               | ProtonVPN                         |
|------------------------|---------------------------------|----------------------------------|
| Scope                  | Safari/web traffic only          | Full device traffic encryption   |
| Privacy                | Obscures IP from websites & Apple | Masks IP from ISP & network       |
| Speed                  | Very fast                       | Fast, depends on server load     |
| Configuration          | Minimal, automatic              | Full control (servers, protocols)|
| Compatibility          | iOS/macOS only                 | Multi-platform                   |
| Subscription Required  | iCloud+                        | ProtonVPN subscription           |

**Recommendation:** Use ProtonVPN as your primary VPN for full-device protection. Disable Apple Private Relay when ProtonVPN is active, as they cannot run simultaneously.

---

## Project Phases

- [Phase 1: Core System Hardening (Windows & iOS)](#windows-11-enterprise-hardening)
- [Phase 2: Advanced Host Hardening & Integrity Enforcement](docs/Phase%202.md) ← 🆕
- Phase 3: Network Defense & Isolation (Coming Soon)

---

## Checklist Summaries

### Windows 11 Enterprise Checklist

- [ ] Create system restore point  
- [ ] Disable SMBv1 and Remote Desktop if unused  
- [ ] Enable SmartScreen via registry or Defender settings  
- [ ] Harden exploit protection (DEP, SEHOP, CFG, etc.)  
- [ ] Disable telemetry (set AllowTelemetry=0)  
- [ ] Configure DNS to Quad9 or NextDNS (DoH enabled)  
- [ ] Use ProtonVPN for encrypted network traffic  
- [ ] Regularly update OS and security software  
- [ ] Optionally, use Norton-compatible hardening if Norton AV installed  
- [ ] Schedule weekly tasks to check Root CA store, DNS integrity, and DNSSEC  

---

### iOS 18.5 Checklist

- [ ] Enable Face ID/Touch ID with app-level protection (long-press app > Protect App)  
- [ ] Use DNS Override app to enforce Quad9 or NextDNS globally  
- [ ] Use ProtonVPN for full-device VPN encryption  
- [ ] Disable Auto-Join on untrusted Wi-Fi  
- [ ] Disable location, microphone, camera access for unnecessary apps  
- [ ] Enable Screen Time restrictions and App Tracking Transparency  
- [ ] Keep iOS and apps up to date  
- [ ] Use strong passwords and 2FA on Apple ID and apps  

---

## Usage & Installation

1. Download and review the PowerShell hardening scripts.  
2. Run `create_restore_point.ps1` before making system changes.  
3. Run the appropriate hardening script depending on your antivirus setup.  
4. Set up scheduled tasks for root cert, DNS integrity, and DNSSEC monitoring.  
5. On iOS, install the DNS Override app from the App Store and configure your preferred DNS.  
6. Subscribe and connect to ProtonVPN for encrypted network protection.  
7. Follow the checklists regularly for ongoing security hygiene.  

---

## License

MIT License — Free to use, modify, and share. Please attribute original work to Collin Blaine George.

---

## Contact

For questions or collaboration, reach out via GitHub issues or email.

---

# Thank you for securing your digital life with Cyberimmune!
