## 2026-05-24 - [Strict format validation for parsed log inputs]
**Vulnerability:** Untrusted input extracted from application log files (such as game titles, usernames, and IPs) was being passed into external commands and network requests without strict format validation, leading to potential command/argument injection or SSRF vulnerabilities.
**Learning:** Even when using Process.arguments array to avoid shell interpolation, untrusted input starting with hyphens or spaces can cause argument injection vulnerabilities. And any input coming from logs should be treated as untrusted.
**Prevention:** Strictly validate such inputs against expected formats using regex (e.g., ^[a-fA-F0-9.:]+$ for IPs, ^[0-9]+$ for PIDs) before use.
