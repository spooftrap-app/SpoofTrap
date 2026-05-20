## 2026-05-20 - [RobloxLogWatcher Input Validation]
**Vulnerability:** Command Injection and SSRF risks due to unvalidated inputs extracted from external files.
**Learning:** Data parsed from local log files should not be blindly trusted. Malicious inputs (e.g., manipulated place IDs or IP addresses injected via external logs) could be passed unchecked into system commands (via `Process()`) or external API calls (via `URLSession`), leading to command injection or SSRF vulnerabilities.
**Prevention:** Always validate external or untrusted inputs against strict expected formats (e.g., regex `^[0-9]+$` for numbers, `^[a-fA-F0-9.:]+$` for IPs) before utilizing them in sensitive contexts.
