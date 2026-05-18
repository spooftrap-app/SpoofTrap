## 2024-05-18 - Command Injection via String Interpolation in Process.arguments

**Vulnerability:** Found a command injection risk in `UpdateChecker.swift` where the application path was being interpolated directly into a shell string `task.arguments = ["-c", "sleep 1 && open \"\(appPath)\""]`. If an attacker were able to manipulate the bundle path to include malicious shell commands (e.g., `"; echo pwned; #`), it could result in unauthorized command execution.

**Learning:** When using `Process` with `/bin/sh -c`, using Swift string interpolation (`"\(var)"`) is inherently unsafe as the shell will evaluate any metacharacters in the resulting string. Passing it directly without sanitization creates a critical vector for command injection.

**Prevention:** To prevent command injection when using a shell process (`/bin/sh`), never interpolate paths or external data into the shell script itself. Instead, pass the data as a separate positional argument in the `Process.arguments` array (e.g., `["-c", "sleep 1 && /usr/bin/open \"$0\"", appPath]`) so that the shell processes it strictly as a positional parameter `$0` and not as an executable string.
