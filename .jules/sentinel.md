## 2024-05-27 - Command Injection via Path Interpolation
**Vulnerability:** In `UpdateChecker.swift`, the application path `Bundle.main.bundleURL.path` was directly interpolated into a shell script executed by `Process()`: `["-c", "sleep 1 && open \"\(appPath)\""]`. If the user renamed the application bundle to include shell metacharacters, it would trigger arbitrary command execution upon the app relaunching itself during an update.
**Learning:** `Bundle.main.bundleURL.path` is user-controllable input in macOS environments. Direct string interpolation of user-controllable input into shell execution contexts is unsafe.
**Prevention:** Always pass user-controllable or variable data as separate, trailing arguments to the script (e.g., `$0`) when utilizing `/bin/sh -c` via Swift's `Process`.
