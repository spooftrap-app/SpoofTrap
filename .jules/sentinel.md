## 2024-07-01 - Command Injection via Bundle Path
**Vulnerability:** Command injection in `UpdateChecker.swift` due to interpolating `Bundle.main.bundleURL.path` directly into a shell string `["-c", "sleep 1 && open \"\(appPath)\""]`.
**Learning:** `Bundle.main.bundleURL.path` is untrusted input because users can rename the application directory to include malicious shell characters (e.g., `SpoofTrap"; rm -r /tmp; "`).
**Prevention:** Never use direct string interpolation for paths in shell commands. Always pass untrusted paths as separate arguments (e.g., `["-c", "sleep 1 && /usr/bin/open \"$1\"", "--", appPath]`) when using `Process` with `/bin/sh`.
