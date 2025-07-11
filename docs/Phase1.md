# Phase 1: Baseline System Hardening for Windows 11 Enterprise

## ✪ Objective

Establish a hardened baseline configuration for Windows 11 Enterprise with secure defaults, service lockdowns, and privacy optimizations. This phase sets the stage for Zero Trust by minimizing attack surface, disabling legacy protocols, and enabling secure DNS and update mechanisms.

---

## ✪ Key Scripts

| Script                             | Description                                      |
|------------------------------------|--------------------------------------------------|
| `defender_hardening.ps1`           | Enables SmartScreen, ASR rules, and Exploit Protection |
| `norton_compatible_hardening.ps1` | Applies hardening compatible with Norton 360     |
| `create_restore_point.ps1`         | Creates a system restore point for rollback safety |

---

## ✪ Security Features Applied

- Disables legacy protocols (SMBv1, Telnet, etc.)
- Enables SmartScreen and Defender protections
- Enforces exploit protection features (DEP, ASLR, SEHOP, CFG)
- Configures DNS-over-HTTPS with Quad9 or NextDNS
- Reduces telemetry to minimum settings
- Sets secure update and firewall defaults

---

## ✪ Task Scheduler

All scripts in Phase 1 are designed to be run manually once or as part of a startup hardening task.

---

## ✪ Compliance Alignment

| Control | Description                                |
|---------|--------------------------------------------|
| CIS     | Microsoft Windows 11 Benchmark (Level 1)   |
| NIST    | SP 800-171: 3.1.1 – Limit system access     |
| MITRE   | T1562.001 – Impair Defenses: Disable AV    |

---

## ✪ Summary

Phase 1 lays the foundation for a hardened Windows environment. It eliminates legacy risks and enforces a secure, private, and auditable baseline, preparing the system for deeper isolation and monitoring in subsequent phases.

---
