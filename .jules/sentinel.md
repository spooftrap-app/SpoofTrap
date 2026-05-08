## 2024-05-08 - Untrusted Input in Log Parsing
**Vulnerability:** Parsed IPs and PIDs from logs and shell commands were used directly in `Process()` arguments and URLs without strict format validation, leading to potential command argument injection and SSRF risks.
**Learning:** Even data from seemingly predictable sources like `pgrep` or local logs can be manipulated by malicious actors to perform unintended actions if not strictly validated against an expected format.
**Prevention:** Always validate extracted inputs (e.g., IPs, PIDs, IDs) using strict regular expressions (e.g., `^[a-fA-F0-9.:]+$` for IPs, `^[0-9]+$` for PIDs) before using them in sensitive operations.
