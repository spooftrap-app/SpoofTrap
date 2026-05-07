## 2024-05-07 - Prevent Argument Injection and SSRF in Log Parsing
**Vulnerability:** The application extracted values like PID, Place ID, and IP address from untrusted local log files and directly used them as arguments in system commands (`Process()`) and HTTP requests (`URLSession`). Because log files could be manipulated to contain maliciously crafted sequences, this could result in Argument Injection or Server-Side Request Forgery (SSRF).
**Learning:** Data from local log files must be considered untrusted and validated just like user input, especially when used to construct commands or network requests.
**Prevention:** Implement strict regex validation (`^[a-fA-F0-9.:]+$`, `^[0-9]+$`) immediately after parsing untrusted inputs before they are passed into downstream logic.
