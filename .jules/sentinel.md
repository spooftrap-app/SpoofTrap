## 2024-05-24 - Command Injection via Bundle URL in Relaunch
**Vulnerability:** Command injection vulnerability in `UpdateChecker.swift` when relaunching the app. `Bundle.main.bundleURL.path` was directly interpolated into a shell script string (`"sleep 1 && open \"\(appPath)\""`) passed to `/bin/sh -c`.
**Learning:** `Bundle.main.bundleURL.path` must be treated as untrusted, user-controllable input in macOS apps, as users can manipulate the application directory name.
**Prevention:** Always pass user-controlled or path variables as separate arguments to `Process()` (e.g., using `$1` in the script string and passing the variable in the arguments array `["-c", "sleep 1 && /usr/bin/open \"$1\"", "--", appPath]`) to prevent command injection vulnerabilities caused by string interpolation.
