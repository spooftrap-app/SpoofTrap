## 2024-05-18 - Missing Input Validation in Log Parsing

**Vulnerability:** Extracted strings from local log files (IPs, PlaceIDs, PIDs) were used directly in URLs and shell commands without validation. This created Server-Side Request Forgery (SSRF) and potential command/argument injection risks, as an attacker controlling the log output could inject arbitrary data.
**Learning:** Even "local" data sources like application log files must be treated as untrusted input. The application implicitly trusted that the log format would remain static and benign.
**Prevention:** Always strictly validate extracted data against an expected format (e.g., using regex `^[a-fA-F0-9.:]+$` for IPs and `^[0-9]+$` for IDs) before using it in sensitive operations like network requests or `Process` arguments.
