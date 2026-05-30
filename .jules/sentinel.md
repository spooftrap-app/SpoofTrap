## 2025-02-14 - Fix Command Injection in Relaunch Logic
**Vulnerability:** Command injection in `UpdateChecker.relaunchApp` due to unescaped app path string interpolation in a `/bin/sh -c` argument.
**Learning:** Even internal app paths (like `Bundle.main.bundleURL.path`) are partially user-controlled and should never be interpolated directly into shell strings.
**Prevention:** When using `Process()` with `/bin/sh -c`, always pass dynamic or path variables as separate arguments (e.g., `["-c", "command \"$0\"", path]`) to prevent command injection caused by string interpolation.
