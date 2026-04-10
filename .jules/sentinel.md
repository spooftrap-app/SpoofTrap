## 2025-02-14 - Fix Command Injection in UpdateChecker

**Vulnerability:** Found a command injection vulnerability in `UpdateChecker.swift` where `appPath` (which could technically be controlled via filesystem manipulation) was directly interpolated into a `sh -c` command string (`task.arguments = ["-c", "sleep 1 && open \"\(appPath)\""]`). If the application path contained malicious shell metacharacters, it could lead to arbitrary command execution during the app restart phase of the update process.

**Learning:** Shell string interpolation is a common vector for command injection, even when handling local file paths. `Process()` makes it easy to accidentally introduce these risks when calling out to `/bin/sh`.

**Prevention:** When using `sh -c` with `Process()`, never interpolate external variables directly into the command string. Always pass them as trailing arguments and reference them within the script using positional parameters (e.g., `"$0"`).
