## 2024-07-07 - Fix missing input validation on parsed log data
**Vulnerability:** Untrusted input from local application logs (IPs, PIDs, PlaceIDs) was passed directly into `Process()` arguments and network `URL()` initializers, creating SSRF and command/argument injection risks.
**Learning:** Application log contents cannot be implicitly trusted, as malicious actors can spoof log lines or manipulate environment conditions to inject malicious data.
**Prevention:** Always strictly validate data extracted from logs against rigid expected formats (e.g., using explicit regex like `^[0-9]+$`) before using it in any sensitive operations.
