## 2024-05-15 - Command Injection in Application Relaunch
**Vulnerability:** The `relaunchApp()` function in `UpdateChecker.swift` passed `Bundle.main.bundleURL.path` directly into a shell string `sleep 1 && open "\(appPath)"` via string interpolation.
**Learning:** Bundle paths on macOS are user-controllable (users can rename the app directory). Interpolating them directly into `/bin/sh -c` arguments creates a command injection risk.
**Prevention:** Always pass variables as separate arguments to `/bin/sh -c` (using `$0`, `$1`, etc.) or avoid shell execution entirely when possible. When `sh -c` is required (e.g., for async detached launches), pass arguments securely: `arguments = ["-c", "sleep 1 && open \"$1\"", "--", appPath]`.
