## 2024-06-06 - Prevent Command Injection via Process Interpolation
**Vulnerability:** Shell scripts executed via `Process()` and `/bin/sh -c` interpolated the untrusted `Bundle.main.bundleURL.path` application path directly into the command string (`open "\(appPath)"`).
**Learning:** Even though `Bundle.main.bundleURL` might seem safe, it evaluates to the location the user has placed the application directory. A malicious actor could rename the application directory to include shell metacharacters and execute arbitrary commands.
**Prevention:** Always avoid shell string interpolation by using `$0` variables inside the shell script string and passing user-controlled variables securely as positional `Process().arguments`.
