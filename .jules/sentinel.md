## 2024-05-15 - Unvalidated Output Log Data

**Vulnerability:** Extracted strings from application output logs (such as process IDs and IPs) were being fed directly into external API requests and Subprocess/shell commands without adequate validation.
**Learning:** Even though logs originate from the local machine, attackers or manipulating game servers can coerce log outputs to include malformed parameters that lead to SSRF (e.g. placeIds or manipulated IP parameters) or command injection via crafted strings resolving to external paths instead of IDs.
**Prevention:** Strictly validate parsed inputs (using tight regex constraints like `^[0-9]+$` for process IDs or `^[a-fA-F0-9.:]+$` for IPs) before utilizing them in sensitive functions.
