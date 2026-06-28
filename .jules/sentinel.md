## 2025-02-14 - Command Injection in Process Arguments via String Interpolation
**Vulnerability:** String interpolation in shell commands (`/bin/sh -c`) using user-controllable application paths (like `Bundle.main.bundleURL.path`) allows attackers to inject malicious commands if the application is renamed.
**Learning:** Even internal app paths are untrusted input. Directly interpolating them into `/bin/sh` arguments creates injection vectors.
**Prevention:** Always pass dynamic or path variables as discrete arguments to the shell (e.g., `$1`) and map them safely using `Process.arguments` to avoid shell interpolation.
