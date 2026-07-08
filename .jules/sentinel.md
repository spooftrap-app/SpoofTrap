## 2024-05-20 - Log Parsing Injection Risks
**Vulnerability:** Extracted inputs from local log files (IPs, PIDs, PlaceIDs) were directly used in URL requests and system commands without format validation, creating SSRF and argument injection risks if a malicious actor manipulated the log files.
**Learning:** Data from local files (even application logs) must be treated as untrusted input.
**Prevention:** Always strictly validate extracted log inputs against an expected format (e.g., using regex `^[a-fA-F0-9.:]+$`) before use in sensitive operations.
