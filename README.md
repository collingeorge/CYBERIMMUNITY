# Cyberimmune: Comprehensive Device Hardening & Privacy Guide

A personal cybersecurity hardening project designed to build an “immune system” for your devices — focused on Windows 11 Enterprise and iOS 18.5, integrating network protections, privacy best practices, and app-level security controls.

---

## Table of Contents

- [Overview](#overview)  
- [Windows 11 Enterprise Hardening](#windows-11-enterprise-hardening)  
- [iOS 18.5 Security & Privacy](#ios-185-security--privacy)  
- [Network & DNS Hardening](#network--dns-hardening)  
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

### Included Scripts

- `defender_hardening.ps1` — Full hardening script (for systems using Defender)  
- `norton_compatible_hardening.ps1` — Hardening script compatible with Norton 360 or other AVs that suppress Defender  
- `create_restore_point.ps1` — Creates a Windows restore point before applying changes

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

- **Quad9** — Blocks known malware and phishing domains with a strong privacy policy  
- **NextDNS** — Highly customizable, with enhanced tracking and malware filtering

### DNS Setup on Devices

- **Windows 11** — Configure Quad9 or NextDNS IPs and enable DNS-over-HTTPS via system settings or PowerShell  
- **iOS 18.5** — Use DNS Override app to enforce Quad9/NextDNS for Wi-Fi and cellular globally  
- **VPN** — Use ProtonVPN Duo subscription for full-device encrypted traffic and IP masking

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

**Recommendation:** Use ProtonVPN as primary VPN for full-device protection. Disable Apple Private Relay when ProtonVPN is active (they cannot run simultaneously).

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
4. On iOS, install the DNS Override app from the App Store and configure your preferred DNS.  
5. Subscribe and connect to ProtonVPN for encrypted network protection.  
6. Follow the checklists regularly for ongoing security hygiene.

---

## License

MIT License — Free to use, modify, and share. Please attribute original work to Collin Blaine George.

---

## Contact

For questions or collaboration, reach out via GitHub issues or email.

---

# Thank you for securing your digital life with Cyberimmune!

---

---

If you want, I can also help you prepare the actual GitHub repo structure and scripts with README.md, or assist with publishing it. Just say the word!
