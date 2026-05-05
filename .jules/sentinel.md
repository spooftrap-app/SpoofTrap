
## 2024-05-27 - Command Injection & SSRF via Log Extraction
**Vulnerability:** Untrusted input (`PID`, `IP`, `placeId`) parsed from log files was passed directly to shell commands (e.g., `ps -p <pid>`) and network requests (e.g., `ip-api.com/json/<ip>`).
**Learning:** Even local application log files must be treated as untrusted data sources. A malicious user could potentially forge log entries containing shell metacharacters or unexpected URLs, leading to arbitrary command execution or SSRF.
**Prevention:** Always validate extracted variables against strict expected formats (e.g., regex `^[0-9]+$` for PIDs, `^[a-fA-F0-9.:]+$` for IPs) before using them in execution or URL construction paths.
