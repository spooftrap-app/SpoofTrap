## 2026-05-09 - Untrusted Input from Local Log Files

**Vulnerability:** Values parsed directly from local game logs (`RobloxLogWatcher.swift` parsing IPs and PIDs) were passed directly to `Process` arguments (`/bin/ps`, `ping`) and URL requests (`http://ip-api.com`) without validation. This created Command Injection and Server-Side Request Forgery (SSRF) risks, as an attacker could theoretically inject malicious strings into the local log file, which would then be executed or requested by the app.

**Learning:** Data extracted from local log files must be treated as untrusted input just like data from a network request.

**Prevention:** Always validate extracted log values against strict expected formats (e.g., `^[a-fA-F0-9.:]+$` for IPs, `^[0-9]+$` for PIDs) before using them in sensitive operations like `Process()` arguments or URLs.