
## 2026-05-12 - Prevent Command Injection via String Interpolation in Shell Tasks
**Vulnerability:** String interpolation of application paths into shell commands (e.g., `["-c", "sleep 1 && open \"\(appPath)\""]`) allows for command injection if the application path (or any other user-controlled variable) contains unescaped malicious characters.
**Learning:** Even internal variables like `Bundle.main.bundleURL.path` can theoretically be manipulated by a local user renaming the application bundle, leading to unintended command execution.
**Prevention:** Always pass variables as separate arguments to the shell command using `$0`, `$1`, etc. (e.g., `["-c", "sleep 1 && /usr/bin/open \"$0\"", appPath]`).
