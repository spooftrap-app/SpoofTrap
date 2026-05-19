## 2024-05-18 - Fix command injection in app relaunch

**Vulnerability:** Command injection vulnerability in `UpdateChecker.swift`'s `relaunchApp` method. The `appPath` variable was being string interpolated directly into a `/bin/sh -c` command, allowing a malicious path string to execute arbitrary commands.

**Learning:** Shell command interpolation with user-controlled or environment variables (like application paths, especially those obtained from `Bundle.main.bundleURL.path`) is dangerous when passed to a shell because the path may contain malicious characters that allow command execution.

**Prevention:** Always pass user-controlled or path variables as separate arguments to the shell command and reference them positionally (e.g., passing `$0` as part of the script and `appPath` as an element in the `arguments` array) rather than using string interpolation in Swift.
