## 2024-06-04 - [Fix Command Injection in UpdateChecker]
**Vulnerability:** Command injection vulnerability via string interpolation of `appPath` into a shell command in `relaunchApp()` inside `Sources/UpdateChecker.swift`.
**Learning:** `Bundle.main.bundleURL.path` can be manipulated by altering the folder or file name before executing the app. Direct string interpolation into `sh -c` arguments can execute arbitrary commands if the path contains shell metacharacters.
**Prevention:** Always pass user-controlled or variable paths as separate array items mapped to positional parameters (e.g., `["-c", "sleep 1 && /usr/bin/open \"$0\"", appPath]`) when using `Process` instead of interpolating them directly into the shell string.
