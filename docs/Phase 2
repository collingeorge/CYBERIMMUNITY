# Phase 2: Advanced Host Hardening & Integrity Enforcement

## *Credential Isolation, Logging Enforcement, and Anti-Persistence Measures for Zero Trust Compliance*

---

## ✪ Abstract

Phase 2 of the Cyberimmune project introduces integrity-focused system configurations that go beyond baseline hardening. This phase implements credential isolation through Microsoft’s Credential Guard, enforces PowerShell and script-level auditing, restricts USB-based data exfiltration, and removes known persistence vectors. These measures build upon Phase 1’s foundational system lockdown, elevating the system toward NIST-aligned Zero Trust compliance.

---

## ✪ Objectives

* Enforce **credential memory isolation** (via Virtualization-Based Security and Credential Guard).
* Enable **PowerShell and script auditing** for traceable forensic visibility.
* Disable **removable storage** and persistence-enabling mechanisms.
* Lay groundwork for forensic baselining and intrusion detection.

---

## ✪ Step-by-Step Technical Controls

### ✅ 2.1: Credential Guard & VBS Enforcement

* **Command Used:**

```powershell
Get-CimInstance -Namespace "root\Microsoft\Windows\DeviceGuard" -ClassName "Win32_DeviceGuard"
```

* **Verification Output:**

  * `SecurityServicesRunning: {1}`
  * `VirtualizationBasedSecurityStatus: 2`
* **Risk Addressed:** Prevents theft of credentials from LSASS memory.
* **Compliance References:**

  * [NIST SP 800-53 Rev. 5 IA-2(12)](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final)
  * [Microsoft Credential Guard Overview](https://learn.microsoft.com/en-us/windows/security/identity-protection/credential-guard/credential-guard)

---

### ✅ 2.2: PowerShell Logging Enforcement

* **Script:** `logging_setup.ps1`
* **Actions Performed:**

  * Enables **Module Logging**
  * Enables **Script Block Logging**
  * Applies Audit policy changes via `auditpol.exe`
* **Registry Keys:**

```reg
HKLM\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
HKLM\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
```

* **Purpose:** Captures all PowerShell-based actions for post-event forensics.
* **Compliance Reference:** [MITRE ATT\&CK T1059.001 - PowerShell](https://attack.mitre.org/techniques/T1059/001/)

---

### ✅ 2.3: Anti-Persistence Mechanism Removal

* **Script:** `anti_persistence.ps1`
* **Actions Performed:**

  * Disables "Run" keys in registry (HKCU & HKLM)
  * Disables Windows Script Host
  * Disables AutoRun for all drives
* **Purpose:** Prevents lateral persistence techniques often used by malware.
* **Compliance Reference:** [MITRE ATT\&CK T1547.001 - Registry Run Keys/Startup Folder](https://attack.mitre.org/techniques/T1547/001/)

---

### ⏳ 2.4: BitLocker AES-256 + PIN at Boot

* **Script:** `bitlocker_aes256_pin.ps1`
* **Function:** Enables AES-256 XTS encryption and prompts user to set boot-time PIN.
* **Why Important:** Ensures system is unreadable unless authenticated pre-boot.
* **Compliance Reference:**

  * [NIST SP 800-111 - Storage Encryption](https://csrc.nist.gov/publications/detail/sp/800-111/final)
  * [FIPS 140-2 Validated BitLocker](https://learn.microsoft.com/en-us/windows/security/information-protection/bitlocker/bitlocker-overview)

---

## ✪ Threat Model Alignment

| Threat                     | Control Introduced             | Status     |
| -------------------------- | ------------------------------ | ---------- |
| Credential dumping (LSASS) | Credential Guard               | ✅ Active   |
| Malware persistence        | Run keys disabled, WSH blocked | ✅ Active   |
| PowerShell abuse           | Module/script logging enforced | ✅ Active   |
| Cold boot/drive theft      | BitLocker + PIN (pending)      | ⏳ Upcoming |

---

## ✪ Phase 2 Summary Table

| Script                     | Function                          | Verified | Task Scheduled |
| -------------------------- | --------------------------------- | -------- | -------------- |
| `anti_persistence.ps1`     | Remove run keys, disable AutoRun  | ✅ Yes    | ✅ Yes          |
| `logging_setup.ps1`        | Enable PowerShell logging & audit | ✅ Yes    | ✅ Yes          |
| `bitlocker_aes256_pin.ps1` | Encrypt with AES-256 + PIN        | ⏳ Soon   | ⏳ Planned      |

---

## ✪ Conclusion

Phase 2 completes the foundational Zero Trust posture for Windows 11 by activating credential isolation, forensic-grade logging, and attack surface minimization. These controls reduce the system’s susceptibility to modern threats including ransomware, privilege escalation, and memory-based attacks. Finalizing BitLocker encryption in Phase 2 will ensure full physical disk confidentiality.

---

## ✪ Next Phase

**Phase 3:** *Network Defense & Isolation (Firewall, DNS Sinkhole, VPN Enforcement)*
Coming Soon.
