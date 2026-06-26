
## 2024-06-26 - Command Injection via String Interpolation in Process()
**Vulnerability:** The application was passing `Bundle.main.bundleURL.path` directly into a shell command string using interpolation (e.g., `-c "sleep 1 && open \"\(appPath)\""`). This exposes the application to command injection if an attacker renames the application directory to contain shell metacharacters.
**Learning:** Even internal properties like `Bundle.main.bundleURL.path` must be treated as untrusted, user-controllable input in macOS apps, as users can manipulate the application directory name.
**Prevention:** When using Swift's `Process()` for shell execution, always pass user-controlled or path variables as separate arguments (e.g., using `$1` in the script string and passing the variable in the array after the `--` delimiter) to prevent command injection vulnerabilities caused by string interpolation.
