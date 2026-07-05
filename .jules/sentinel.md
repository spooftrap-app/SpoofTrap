## 2024-07-05 - [Command Injection in Shell Interpolation]
**Vulnerability:** Command injection via unescaped string interpolation of `Bundle.main.bundleURL.path` in `/bin/sh -c` arguments.
**Learning:** Application bundle paths are user-controllable and can contain shell metacharacters. Direct interpolation into shell commands exposes the application to arbitrary code execution.
**Prevention:** Pass variables as discrete positional arguments to the shell (e.g., `["-c", "sleep 1 && /usr/bin/open \"$1\"", "--", appPath]`) rather than using string interpolation.
