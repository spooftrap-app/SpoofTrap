## 2024-05-24 - Initial Run
**Vulnerability:** Setup
**Learning:** Setup
**Prevention:** Setup

## 2024-05-24 - Command Injection via Bundle Path
**Vulnerability:** Command Injection in Process Execution
**Learning:** `Bundle.main.bundleURL.path` is technically user-controllable input in macOS because a user can rename the application bundle directory. Using this path directly via string interpolation inside `/bin/sh -c` arguments allows for command injection if the user renames the app to include shell metacharacters.
**Prevention:** Never use string interpolation to pass paths into shell commands. Instead, pass the paths as positional arguments to the shell script using `$1`, and separate the script string from the arguments array using the `--` delimiter. (e.g., `["-c", "sleep 1 && /usr/bin/open \"$1\"", "--", appPath]`)
