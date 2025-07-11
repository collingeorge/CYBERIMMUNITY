# 🛡 CYBERIMMUNE: Comprehensive Device Hardening & Privacy Framework

A personal cybersecurity hardening project designed to build a “digital immune system” for your devices — focused on Windows 11 Enterprise and iOS 18.5. This project integrates system lockdown scripts, DNS & certificate monitoring, zero trust controls, and privacy enhancements across endpoints.

---

## 🔐 Security Posture Summary

> **Security Level:** This system achieves an **advanced Zero Trust architecture**, comparable to **enterprise blue team standards** — integrating endpoint hardening, network controls, and quantum-safe TLS. It aligns with **NIST SP 800-53**, **NSA Windows hardening guidance**, and post-quantum cryptographic readiness.

### ✅ Achievements:
- Credential Guard + Virtualization-Based Security (VBS)
- BitLocker with AES-256 + PIN (pending finalization)
- PowerShell & ScriptBlock auditing
- Removal of persistence vectors
- Registry lockdown and secure DNS enforcement
- TLS 1.2/1.3 enforcement with quantum-safe cipher suites
- Root certificate & DNSSEC integrity monitoring
- Scheduled validation tasks

### 🧩 Related Projects

| Project | Description | Link |
|--------|-------------|------|
| **QuantumReadiness** | Enables TLS 1.2/1.3, removes legacy protocols, enforces strong cipher suites and quantum-safe crypto | [🔗 GitHub Repo](https://github.com/collingeorge/QUANTUMREADINESS) |
| **Set-NTPConfig** | Configures secure and accurate NTP sync for time integrity (critical for cryptographic verification) | [🔗 GitHub Repo](https://github.com/collingeorge/Set-NTPConfig) |

### 🔗 Key Script Links

| Script | Purpose | Link |
|--------|---------|------|
| `phase1/defender_hardening.ps1` | Lock down Defender, remove attack surface | [View](https://github.com/collingeorge/CYBERIMMUNITY/blob/main/phase1/defender_hardening.ps1) |
| `phase1/norton_compatible_hardening.ps1` | AV-compatible version for Norton or 3rd party | [View](https://github.com/collingeorge/CYBERIMMUNITY/blob/main/phase1/norton_compatible_hardening.ps1) |
| `phase2/anti_persistence.ps1` | Removes persistence vectors from registry | [View](https://github.com/collingeorge/CYBERIMMUNITY/blob/main/phase2/anti_persistence.ps1) |
| `phase2/logging_setup.ps1` | Enables full PowerShell and script logging | [View](https://github.com/collingeorge/CYBERIMMUNITY/blob/main/phase2/logging_setup.ps1) |
| `phase2/registry_hardening.ps1` | Locks down insecure registry keys | [View](https://github.com/collingeorge/CYBERIMMUNITY/blob/main/phase2/registry_hardening.ps1) |
| `quantum_tls_hardening.ps1` | Disables SSL, enforces TLS 1.2/1.3, adds secure cipher suites | [View](https://github.com/collingeorge/QUANTUMREADINESS/blob/main/tls_hardening.ps1) |
| `set_ntp_config.ps1` | Configures secure time sync with trusted NTP servers | [View](https://github.com/collingeorge/Set-NTPConfig/blob/main/Set-NTPConfig.ps1) |

---

## 📁 Directory Structure

```text
CYBERIMMUNITY/
├── README.md
├── LICENSE
├── docs/
│   ├── Phase1.md
│   ├── Phase2.md
│   └── Whitepaper_Draft.md  # (Coming soon)
├── phase1/
│   ├── create_restore_point.ps1
│   ├── defender_hardening.ps1
│   └── norton_compatible_hardening.ps1
├── phase2/
│   ├── anti_persistence.ps1
│   ├── bitlocker_aes256_pin.ps1
│   ├── logging_setup.ps1
│   └── registry_hardening.ps1
├── monitoring/
│   ├── check_root_certs.ps1
│   ├── check_dns_integrity.ps1
│   ├── check_dnssec.ps1
│   └── tasks/
│       ├── DNSSEC_Validation_Monitor.xml
│       ├── DNS_Resolution_Check.xml
│       └── RootCertIntegrityMonitor.xml
```

### Phase 1 (Baseline Hardening)

- `defender_hardening.ps1`: Enforces Windows Defender rules and disables legacy features.
- `norton_compatible_hardening.ps1`: Alternative for systems using Norton or other AVs.
- `create_restore_point.ps1`: Creates a restore point for rollback safety.

### Phase 2 (Advanced Integrity & Credential Isolation)

- `anti_persistence.ps1`: Removes registry-based and WSH startup persistence.
- `logging_setup.ps1`: Enables script and module auditing for PowerShell.
- `bitlocker_aes256_pin.ps1`: Applies full disk encryption with AES-256 and preboot PIN.
- `registry_hardening.ps1`: Locks down key registry paths and disables weak behaviors.

📄 See [Phase 2 Documentation](docs/Phase2.md) for technical controls and threat model.

---

## 📱 iOS 18.5 Security & Privacy

- App-level Face ID protection (via “Protect App” long-press setting).
- Enforces DNS-over-HTTPS using DNS Override (NextDNS or Quad9).
- ProtonVPN for full-device encrypted traffic.
- Screen Time, microphone/camera lockdown, and App Tracking Transparency.

---

## 🌐 Network & DNS Monitoring

Scripts inside `monitoring/` track critical resolution and root trust changes:

- `check_root_certs.ps1`: Compares trusted root CA list against baseline.
- `check_dns_integrity.ps1`: Ensures DNS resolves correctly across providers.
- `check_dnssec.ps1`: Audits DNSSEC trust path from providers like Quad9.

### ⏲ Scheduled Task Profiles

XML files in `monitoring/tasks` automate weekly execution of above scripts at 3:00am.

---

## 🔍 ProtonVPN vs Apple Private Relay

| Feature               | Apple Private Relay               | ProtonVPN                         |
|----------------------|-----------------------------------|----------------------------------|
| Scope                | Safari/web traffic only           | Full device traffic encryption   |
| Privacy              | Obscures IP from websites/Apple   | Masks IP from ISP & local network |
| Platform Support     | iOS/macOS only                    | Cross-platform                   |
| Speed/Performance    | Excellent                         | High (depends on server)         |
| Control              | Minimal (automatic)               | Full configuration control       |

✔️ **Use ProtonVPN for complete security.** Disable Private Relay when active.

---

## ✅ Checklists

### Windows 11 Enterprise

- [x] System restore point created
- [x] Legacy protocols disabled (SMBv1, RDP)
- [x] SmartScreen, DEP, and SEHOP enforced
- [x] Defender or Norton hardening applied
- [x] DNS-over-HTTPS to Quad9 or NextDNS
- [x] Logging and script auditing enabled
- [x] Credential Guard and VBS confirmed
- [x] USB and autorun lockdown
- [x] Root cert and DNS integrity monitoring
- [x] BitLocker (AES-256 with PIN) planned

### iOS 18.5

- [x] App Face ID lock enabled
- [x] DNS Override profile configured
- [x] ProtonVPN active for VPN routing
- [x] Untrusted Wi-Fi auto-join disabled
- [x] Camera/microphone/privacy settings locked down
- [x] Screen Time, updates, and 2FA enabled

---

## 🚀 Usage & Installation

```powershell
# From PowerShell on Windows:
cd Downloads\Cyberimmune_Bundle_v2
powershell -ExecutionPolicy Bypass -File .\phase1\create_restore_point.ps1
powershell -ExecutionPolicy Bypass -File .\phase1\defender_hardening.ps1
powershell -ExecutionPolicy Bypass -File .\phase2 anti_persistence.ps1
powershell -ExecutionPolicy Bypass -File .\phase2\bitlocker_aes256_pin.ps1
powershell -ExecutionPolicy Bypass -File .\phase1\logging_setup.ps1
powershell -ExecutionPolicy Bypass -File .\registry_hardening.ps1
powershell -ExecutionPolicy Bypass -File .\check_dns_integrity.ps1
powershell -ExecutionPolicy Bypass -File .\check_dnssec.ps1
powershell -ExecutionPolicy Bypass -File .\monitoring\check_root_certs.ps1
```

On iOS, install **DNS Override** and **ProtonVPN** from App Store.

---

## ⚖️ License

MIT — Free to use, modify, and distribute. Please attribute original work to **Collin Blaine George**.

---

## 🧠 Contact

For collaboration, feedback, or contributions, open a GitHub issue or contact via GitHub profile.

---

🔒 **Thank you for helping secure the digital future — one system at a time.**
