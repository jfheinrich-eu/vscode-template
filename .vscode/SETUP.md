# VS Code Development Environment Setup

This document describes how to set up the recommended development environment for this project.

## Required Tools

### Shell Script Linting and Formatting

#### ShellCheck (Linting)

ShellCheck is a static analysis tool for shell scripts that finds bugs and suggests improvements.

**Installation:**

```bash
# macOS (Homebrew)
brew install shellcheck

# macOS (MacPorts)
sudo port install shellcheck

# Linux (apt)
sudo apt-get install shellcheck

# Linux (dnf)
sudo dnf install shellcheck

# Using binary directly
curl -fsSL "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.darwin.x86_64.tar.xz" | tar -xJv
sudo mv shellcheck-stable/shellcheck /usr/local/bin/
```

**VS Code Extension:**
- Extension ID: `timonwong.shellcheck`
- Already configured in `.vscode/extensions.json`

#### shfmt (Formatting)

shfmt formats shell scripts to a consistent style.

**Installation:**

```bash
# macOS (Homebrew)
brew install shfmt

# Linux/macOS (using go)
go install mvdan.cc/sh/v3/cmd/shfmt@latest

# Using binary directly (macOS ARM64)
curl -fsSL "https://github.com/mvdan/sh/releases/download/v3.12.0/shfmt_v3.12.0_darwin_arm64" -o /tmp/shfmt
chmod +x /tmp/shfmt
sudo mv /tmp/shfmt /usr/local/bin/shfmt

# Using binary directly (macOS Intel)
curl -fsSL "https://github.com/mvdan/sh/releases/download/v3.12.0/shfmt_v3.12.0_darwin_amd64" -o /tmp/shfmt
chmod +x /tmp/shfmt
sudo mv /tmp/shfmt /usr/local/bin/shfmt

# Using binary directly (Linux)
curl -fsSL "https://github.com/mvdan/sh/releases/download/v3.12.0/shfmt_v3.12.0_linux_amd64" -o /tmp/shfmt
chmod +x /tmp/shfmt
sudo mv /tmp/shfmt /usr/local/bin/shfmt
```

**VS Code Extension:**
- Extension ID: `foxundermoon.shell-format`
- Already configured in `.vscode/extensions.json`

### Verification

After installation, verify the tools are available:

```bash
shellcheck --version
shfmt --version
```

## VS Code Configuration

### ShellCheck Settings

The following ShellCheck settings are configured in `.vscode/settings.json`:

- **Enable**: `true` - ShellCheck is enabled for shell scripts
- **Run**: `onType` - Runs ShellCheck as you type
- **Custom Args**: `-x` - Follow source statements for better analysis
- **Quick Fix**: Enabled for automatic fixes

### shfmt Settings

The following shfmt settings are configured in `.vscode/settings.json`:

- **Indent**: 2 spaces (`-i 2`)
- **Binary operators**: At start of line (`-bn`)
- **Switch cases**: Indented (`-ci`)
- **Redirect operators**: Followed by space (`-sr`)
- **Keep padding**: Preserve column alignment (`-kp`)
- **Format on save**: Enabled for shell scripts

## Recommended Extensions

All recommended extensions are listed in `.vscode/extensions.json`. VS Code will prompt you to install them when you open the workspace.

### Essential Extensions for Shell Development:

1. **ShellCheck** (`timonwong.shellcheck`)
   - Lints shell scripts for common errors and best practices

2. **shell-format** (`foxundermoon.shell-format`)
   - Formats shell scripts using shfmt

3. **GitHub Copilot** (`GitHub.copilot`)
   - AI-powered code completion with custom instructions for shell scripts

## Workflow Integration

The GitHub Actions workflow (`.github/workflows/check-sources.yml`) runs the same checks:

- **ShellCheck**: Validates shell scripts for errors
- **shfmt**: Checks formatting compliance

This ensures that local development matches CI/CD requirements.

## Manual Commands

### Run ShellCheck manually:

```bash
# Check a specific file
shellcheck -x setup-template.sh

# Check all shell scripts
find . -type f -name "*.sh" -exec shellcheck -x {} +
```

### Run shfmt manually:

```bash
# Check formatting (list files that need formatting)
shfmt -l -d setup-template.sh

# Format a file in place
shfmt -w setup-template.sh

# Format all shell scripts
shfmt -w -i 2 -bn -ci -sr -kp $(find . -type f -name "*.sh")
```

## Troubleshooting

### ShellCheck not working

1. Verify installation: `which shellcheck`
2. Restart VS Code
3. Check VS Code output panel: "ShellCheck"

### shfmt not working

1. Verify installation: `which shfmt`
2. Restart VS Code
3. Check VS Code output panel: "Shell Format"

### Extension not found

1. Open VS Code Command Palette (Cmd+Shift+P)
2. Run: "Extensions: Show Recommended Extensions"
3. Install missing extensions

## Additional Resources

- [ShellCheck Wiki](https://github.com/koalaman/shellcheck/wiki)
- [shfmt Documentation](https://github.com/mvdan/sh)
- [POSIX Shell Standard](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html)
