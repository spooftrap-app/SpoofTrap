## 2024-05-24 - Validate unauthenticated log-extracted variables before executing process or URLs
**Vulnerability:** Command injection and SSRF via log-extracted unvalidated input in RobloxLogWatcher.swift. Values like pid and ip were parsed from text files and passed directly to Process().arguments and HTTP requests.
**Learning:** Always validate externally sourced data against an expected format (e.g., regex ^[0-9]+$) before appending it to command line arguments or URLs, as malicious actors can inject payloads in logs.
**Prevention:** Use regex validation like ^[a-fA-F0-9.:]+$ for IPs and ^[0-9]+$ for IDs/PIDs to restrict allowed characters strictly.
