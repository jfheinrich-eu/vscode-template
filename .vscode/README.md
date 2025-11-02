# VS Code Configuration

This directory contains VS Code workspace configuration for the project.

## Files

- **`settings.json`** - Workspace settings including:
  - GitHub Copilot configuration with custom instructions
  - Language-specific formatters and linters
  - ShellCheck and shfmt configuration for shell scripts
  - Code quality and AI enhancement settings

- **`extensions.json`** - Recommended VS Code extensions
  - Essential formatters and language support
  - GitHub Copilot and AI assistance
  - Code quality and linting tools (ShellCheck, ESLint, Pylint)
  - Git and commit message support
  - Shell scripting support (ShellCheck, shell-format)

- **`copilot-instructions.md`** - Custom instructions for GitHub Copilot
  - Enforces English for all code and comments
  - Defines naming standards and best practices
  - Language-specific guidelines (Python, JavaScript, Shell, YAML)
  - GitHub Actions and `actions/github-script` expertise

- **`gitmessage.txt`** - Git commit message template
  - Conventional commits format
  - Guides for proper commit messages

- **`SETUP.md`** - Development environment setup guide
  - Instructions for installing shellcheck and shfmt
  - VS Code extension installation
  - Manual command reference

- **`install-tools.sh`** - Automated tool installation script
  - Installs shellcheck and shfmt
  - Cross-platform support (macOS, Linux)
  - Auto-detects package managers

## Quick Start

1. **Install recommended extensions:**
   - VS Code will prompt you to install recommended extensions when opening the workspace
   - Or manually: `Cmd+Shift+P` → "Extensions: Show Recommended Extensions"

2. **Install development tools:**
   ```bash
   # Run the automated installation script
   .vscode/install-tools.sh
   
   # Or install manually (see SETUP.md for details)
   brew install shellcheck shfmt  # macOS
   ```

3. **Restart VS Code** to ensure all extensions and tools are loaded

## Shell Script Development

### Linting (ShellCheck)

- **Automatic**: Runs on type as you edit
- **Manual**: Right-click → "Format Document" or `Cmd+Shift+I`
- **Configuration**: See `settings.json` → `shellcheck.*`

### Formatting (shfmt)

- **Automatic**: Runs on save
- **Manual**: Right-click → "Format Document" or `Cmd+Shift+I`
- **Configuration**: See `settings.json` → `shellformat.*`
- **Style**: 2-space indent, POSIX-compliant

## GitHub Copilot

GitHub Copilot is configured with custom instructions for:

- **Language requirements**: All code and comments in English
- **Naming standards**: Descriptive variable names, no single letters
- **Shell scripts**: POSIX compliance, proper error handling
- **GitHub Actions**: Expert-level `actions/github-script` patterns
- **Security**: No hardcoded credentials, input validation

See `copilot-instructions.md` for complete guidelines.

## Troubleshooting

### Extensions not working

1. Check installed extensions: `Cmd+Shift+X`
2. Reload window: `Cmd+Shift+P` → "Developer: Reload Window"
3. Check extension output: View → Output → Select extension

### ShellCheck/shfmt not found

1. Verify installation: `which shellcheck && which shfmt`
2. Run installation script: `.vscode/install-tools.sh`
3. Restart VS Code
4. Check PATH in terminal: `echo $PATH`

### Settings not applied

1. Check for syntax errors in `settings.json`
2. Reload window: `Cmd+Shift+P` → "Developer: Reload Window"
3. Check workspace settings override user settings

## Resources

- [VS Code Settings Reference](https://code.visualstudio.com/docs/getstarted/settings)
- [VS Code Extensions](https://marketplace.visualstudio.com/vscode)
- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [ShellCheck Wiki](https://github.com/koalaman/shellcheck/wiki)
- [shfmt Documentation](https://github.com/mvdan/sh)
