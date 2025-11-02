# Shell Script Development Setup

This guide explains the shell script linting and formatting setup for VS Code.

## Overview

The project uses two essential tools for shell script development:

1. **ShellCheck** - Static analysis and linting
2. **shfmt** - Code formatting

Both tools are integrated into VS Code and the CI/CD pipeline.

## Quick Start

### 1. Install Tools

Run the automated installation script:

```bash
.vscode/install-tools.sh
```

Or install manually:

```bash
# macOS (Homebrew)
brew install shellcheck shfmt

# Linux (apt)
sudo apt-get install shellcheck

# shfmt (manual download for Linux/macOS)
curl -fsSL "https://github.com/mvdan/sh/releases/download/v3.12.0/shfmt_v3.12.0_linux_amd64" -o /tmp/shfmt
chmod +x /tmp/shfmt
sudo mv /tmp/shfmt /usr/local/bin/shfmt
```

### 2. Install VS Code Extensions

VS Code will prompt you to install recommended extensions when opening the workspace.

Or manually install:
- **ShellCheck**: `timonwong.shellcheck`
- **shell-format**: `foxundermoon.shell-format`

### 3. Restart VS Code

After installing tools and extensions, restart VS Code.

## Features

### Automatic Linting (ShellCheck)

- **Runs on type**: Shows issues as you edit
- **Inline errors**: Red squiggles under problematic code
- **Quick fixes**: Right-click for automatic fixes
- **Custom args**: Uses `-x` to follow source statements

### Automatic Formatting (shfmt)

- **Format on save**: Automatically formats when you save
- **Consistent style**: 2-space indent, POSIX-compliant
- **Manual format**: `Cmd+Shift+I` or right-click → "Format Document"

## Configuration

All settings are in `.vscode/settings.json`:

```json
{
  "shellcheck.enable": true,
  "shellcheck.run": "onType",
  "shellcheck.customArgs": ["-x"],
  
  "shellformat.flag": "-i 2 -bn -ci -sr -kp",
  
  "[shellscript]": {
    "editor.defaultFormatter": "foxundermoon.shell-format",
    "editor.formatOnSave": true
  }
}
```

## GitHub Actions Integration

The same checks run in CI/CD (`.github/workflows/check-sources.yml`):

```yaml
- name: ShellCheck scripts
  run: shellcheck -x setup-template.sh scripts/**

- name: shfmt --check
  run: shfmt -l -d setup-template.sh scripts/**
```

This ensures local development matches CI requirements.

## Manual Commands

### Run ShellCheck

```bash
# Single file
shellcheck -x setup-template.sh

# All shell scripts
find . -name "*.sh" -exec shellcheck -x {} +
```

### Run shfmt

```bash
# Check formatting (list files needing formatting)
shfmt -l -d setup-template.sh

# Format in place
shfmt -w -i 2 -bn -ci -sr -kp setup-template.sh

# Format all scripts
shfmt -w -i 2 -bn -ci -sr -kp $(find . -name "*.sh")
```

## Troubleshooting

### ShellCheck not working

1. Verify: `which shellcheck`
2. Restart VS Code
3. Check output: View → Output → "ShellCheck"

### shfmt not working

1. Verify: `which shfmt`
2. Restart VS Code
3. Check output: View → Output → "Shell Format"

### Tools not found after installation

1. Check PATH: `echo $PATH`
2. Verify installation location: `which shellcheck shfmt`
3. Restart terminal and VS Code

## Additional Documentation

- **`.vscode/SETUP.md`** - Detailed setup guide
- **`.vscode/README.md`** - VS Code configuration overview
- **`.vscode/install-tools.sh`** - Automated installation script

## Resources

- [ShellCheck Wiki](https://github.com/koalaman/shellcheck/wiki)
- [shfmt Documentation](https://github.com/mvdan/sh)
- [VS Code Shell Script Extension](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck)
