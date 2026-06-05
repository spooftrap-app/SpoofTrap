## 2024-06-05 - Fix Command Injection in Update Relaunch

**Vulnerability:** Command injection vulnerability in `UpdateChecker.swift` due to string interpolation of `Bundle.main.bundleURL.path` into a `/bin/sh -c` command.
**Learning:** Even internal properties like bundle paths can be manipulated by users (e.g. renaming the application folder), meaning they must be treated as untrusted input.
**Prevention:** Always pass variables as separate arguments to `/bin/sh -c` (e.g. `["-c", "sleep 1 && /usr/bin/open \"$0\"", appPath]`) instead of interpolating them directly into the shell string. Also use absolute paths for system binaries (`/usr/bin/open`) to prevent PATH hijacking.
