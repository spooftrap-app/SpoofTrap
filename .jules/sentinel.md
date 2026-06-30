## 2024-05-24 - Input Validation for Log Extraction
**Vulnerability:** Argument injection and SSRF risks due to unsanitized input extracted from log files (e.g., IPs, PIDs, PlaceIDs) being passed directly to `Process()` arguments and URLs.
**Learning:** Data extracted from local application log files must be treated as untrusted input. Values such as game titles, usernames, and IPs can be manipulated by malicious actors to inject commands or trigger unauthorized network requests, and therefore must be strictly validated before use.
**Prevention:** Always strictly validate extracted log inputs against expected formats (e.g., using `^[a-fA-F0-9.:]+$` for IPs and `^[0-9]+$` for PIDs/PlaceIDs) before use in sensitive operations.
