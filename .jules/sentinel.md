## 2024-06-23 - Command Injection in Application Relaunch
**Vulnerability:** Command injection vulnerability in `UpdateChecker.swift` caused by interpolating untrusted input `Bundle.main.bundleURL.path` directly into a shell command `sh -c`.
**Learning:** `Bundle.main.bundleURL.path` can be manipulated by users (e.g., renaming the `.app` folder to contain shell metacharacters), leading to arbitrary code execution when used in unquoted or poorly quoted string interpolations within shell execution contexts.
**Prevention:** Always pass variables as separate arguments to the shell script (e.g., passing `$1` to `sh -c` and appending the variable in the argument list after `--`) instead of relying on string interpolation.
