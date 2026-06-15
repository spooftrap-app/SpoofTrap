
## 2024-05-18 - Command Injection in App Relaunch
**Vulnerability:** Command injection vulnerability in `UpdateChecker.swift` where `Bundle.main.bundleURL.path` was directly interpolated into a `/bin/sh -c` shell string.
**Learning:** `Bundle.main.bundleURL.path` is user-controllable input in macOS apps, as users can rename the application directory. Never interpolate it directly into shell commands.
**Prevention:** Always pass path variables or user-controlled input as separate arguments (e.g., using `$1` in the script string and passing the variable in the arguments array) when executing via `Process()`.
