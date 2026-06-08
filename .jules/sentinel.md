## 2024-06-08 - String Interpolation in Shell Execution (Command Injection)
**Vulnerability:** `Process()` execution in `relaunchApp()` used string interpolation (`"\(appPath)"`) inside a `/bin/sh -c` command.
**Learning:** Even if the string is wrapped in quotes, directly embedding variables like application paths in a shell script argument is a command injection risk, because users can control the path of the application bundle.
**Prevention:** When invoking shell scripts inline, use `$0`, `$1`, etc. within the command string, and pass the variables safely via the trailing elements of the `Process.arguments` array.
