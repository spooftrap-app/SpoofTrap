## 2024-05-19 - Command Injection in UpdateChecker
**Vulnerability:** Command injection vulnerability via string interpolation in shell process execution inside `UpdateChecker.swift`'s `relaunchApp` function. The `appPath` variable was injected directly into a shell command: `["-c", "sleep 1 && open \"\(appPath)\""]`.
**Learning:** Using string interpolation inside shell commands executed via `Process()` is dangerous. A malicious app path could allow arbitrary command execution on the system.
**Prevention:** Pass variables as separate arguments to the shell command and reference them securely using `$0`, `$1`, etc. (e.g., `["-c", "sleep 1 && open \"$0\"", appPath]`).
