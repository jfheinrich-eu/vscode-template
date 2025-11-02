# VS Code Project Template

A comprehensive VS Code project template with GitHub Copilot optimization, shell script development tools, and best practices enforcement.

## 🎯 What's Included

### 📁 `.vscode/` Directory

- **`settings.json`** - Comprehensive VS Code settings with:
  - GitHub Copilot optimization and custom instructions
  - ShellCheck and shfmt integration for shell scripts
  - Language-specific formatters (Python, JavaScript, YAML, Shell)
  - Security exclusions for sensitive files
  - Performance optimizations

- **`extensions.json`** - 20+ recommended extensions including:
  - GitHub Copilot & Copilot Chat
  - Code quality tools (ESLint, Pylint, ShellCheck)
  - Shell script formatting (shell-format)
  - Git integration (GitLens, Git Graph)
  - Security tools (SonarLint)

- **`copilot-instructions.md`** - Custom instructions for GitHub Copilot:
  - English-only code and comments enforcement
  - Descriptive variable naming standards
  - Language-specific best practices
  - GitHub Actions and `actions/github-script` expertise
  - Security and error handling guidelines

- **`gitmessage.txt`** - Conventional commits template
- **`README.md`** - Documentation for VS Code configuration
- **`SETUP.md`** - Detailed tool installation guide
- **`install-tools.sh`** - Automated installation script for shellcheck and shfmt

### 📁 `.github/` Directory

- **`copilot-instructions.md`** - Comprehensive GitHub Copilot instructions with:
  - Shell scripting best practices (POSIX compliance)
  - GitHub Actions workflow guidelines
  - Security best practices
  - Code review guidelines

- **`workflows/check-sources.yml`** - Automated validation workflow:
  - Devcontainer validation
  - Dockerfile linting (hadolint)
  - Shell script checking (ShellCheck)
  - Shell script formatting (shfmt)
  - Automated PR comments with results

- **`settings.yml`** - Repository settings configuration
- **`CODEOWNERS`** - Code ownership definitions
- **`README.md`** - GitHub configuration documentation

### 🗂️ Root Files

- **`setup-template.sh`** - Automated project setup script:
  - Git commit template configuration
  - Development tools installation (shellcheck, shfmt)
  - VS Code extensions installation
  - Project files creation (README, .gitignore)
  - Tool verification

- **`SHELL_DEVELOPMENT.md`** - Shell script development guide
- **`template.json`** - Template metadata
- **`.eslintrc.json`** - ESLint configuration
- **`LICENSE`** - Project license

## 🚀 Quick Start

### Option 1: Use GitHub Template

1. Click "Use this template" on GitHub
2. Clone your new repository
3. Run the setup script:

   ```bash
   cd your-new-project
   ./setup-template.sh
   ```

### Option 2: Manual Setup

1. **Clone the template:**

   ```bash
   git clone <template-repo-url> <new-project-name>
   cd <new-project-name>
   ```

2. **Run setup script:**

   ```bash
   chmod +x setup-template.sh
   ./setup-template.sh
   ```

3. **Open in VS Code:**

   ```bash
   code .
   ```

The setup script will:

- ✅ Configure git commit template
- ✅ Install development tools (shellcheck, shfmt)
- ✅ Install VS Code extensions
- ✅ Create project files (.gitignore, README.md)
- ✅ Verify tool installations
- ✅ Initialize git repository

## 🛠️ Development Tools

### Shell Script Development

#### ShellCheck (Linting)

- **Automatic linting** on type
- **Quick fixes** for common issues
- **POSIX compliance** checking
- **Follow source** statements with `-x` flag

#### shfmt (Formatting)

- **Auto-format on save**
- **2-space indentation**
- **POSIX-compliant** style
- **Consistent formatting** across team

**Installation:**

```bash
# Automatic
.vscode/install-tools.sh

# Manual (macOS)
brew install shellcheck shfmt

# Manual (Linux)
sudo apt-get install shellcheck
# See .vscode/SETUP.md for shfmt installation
```

### CI/CD Integration

The GitHub Actions workflow (`.github/workflows/check-sources.yml`) automatically:

- ✅ Validates devcontainer configuration
- ✅ Lints Dockerfiles with hadolint
- ✅ Checks shell scripts with ShellCheck
- ✅ Verifies formatting with shfmt
- ✅ Posts results as PR comments

## 🤖 GitHub Copilot Features

### Custom Instructions

Both `.vscode/copilot-instructions.md` and `.github/copilot-instructions.md` enforce:

- **English-only code**: All code, comments, and documentation in English
- **Descriptive naming**: No single-letter variables (except loop counters)
- **POSIX shell scripts**: Compliant with POSIX standards
- **GitHub Actions expertise**: Best practices for `actions/github-script`
- **Security focus**: No hardcoded credentials, input validation
- **Error handling**: Proper error messages and graceful failures

### Language-Specific Guidelines

#### Shell Scripts

```bash
# ✅ Good - POSIX compliant, descriptive names
check_file_exists() {
  file_path="$1"
  if [ -f "$file_path" ]; then
    return 0
  fi
  return 1
}

# ❌ Bad - Bash-specific, unclear naming
function chk() {
  [[ -f $1 ]] && return 0 || return 1
}
```

#### GitHub Actions

```yaml
# ✅ Good - Use environment variables
- uses: actions/github-script@v7
  env:
    RESULT: ${{ needs.job.outputs.result }}
  with:
    script: |
      const result = process.env.RESULT || 'default';

# ❌ Bad - Inline expressions cause syntax errors
- uses: actions/github-script@v7
  with:
    script: |
      const result = '${{ needs.job.outputs.result }}';
```

## 📦 Extensions Overview

### Essential (Auto-installed by setup script)

- `GitHub.copilot` - AI code completion
- `GitHub.copilot-chat` - AI chat assistant
- `timonwong.shellcheck` - Shell script linting
- `foxundermoon.shell-format` - Shell script formatting
- `esbenp.prettier-vscode` - Code formatter
- `redhat.vscode-yaml` - YAML support

### Code Quality

- `dbaeumer.vscode-eslint` - JavaScript linting
- `ms-python.pylint` - Python linting
- `streetsidesoftware.code-spell-checker` - Spell checking
- `sonarsource.sonarlint-vscode` - Security analysis

### Git & Commits

- `eamodio.gitlens` - Advanced Git features
- `mhutchie.git-graph` - Git graph visualization
- `vivaxy.vscode-conventional-commits` - Commit message helper

See `.vscode/extensions.json` for complete list.

## 🎨 Customization

### For Different Project Types

#### Python Projects

Already configured in `settings.json`:

- Black formatter
- Pylint linting
- Type hints support
- Auto-import organization

#### JavaScript/TypeScript

Already configured in `settings.json`:

- Prettier formatting
- ESLint integration
- Auto-imports
- Complete function calls

#### Shell Scripts

Already configured in `settings.json`:

- ShellCheck linting (on type)
- shfmt formatting (on save)
- 2-space indentation
- POSIX compliance checking

### Add Project-Specific Settings

Edit `.vscode/settings.json`:

```json
{
  // For Docker projects
  "docker.defaultRegistryPath": "your-registry.com",
  
  // For React projects
  "emmet.includeLanguages": {
    "javascript": "javascriptreact"
  },
  
  // For API projects
  "rest-client.requestNameAsCommentValue": true
}
```

## 📚 Documentation

- **`.vscode/README.md`** - VS Code configuration overview
- **`.vscode/SETUP.md`** - Detailed tool installation guide
- **`SHELL_DEVELOPMENT.md`** - Shell script development guide
- **`.github/README.md`** - GitHub configuration and workflows

## 🔒 Security Features

### Copilot Exclusions

Automatically excludes sensitive files from Copilot suggestions:

- `.env*` files
- `**/secrets/**`
- `**/private/**`
- SSH keys, PEM files
- Tokens and passwords

### Vulnerability Scanning

- SonarLint integration
- Automated security alerts (GitHub)
- Dependabot enabled

## 🧪 Testing & Quality

### Pre-commit Checks (via CI/CD)

- ShellCheck validation
- shfmt formatting check
- Devcontainer validation
- Dockerfile linting

### Local Development

- Lint on type (ShellCheck)
- Format on save (shfmt, Prettier, Black)
- Spell checking
- IntelliSense and auto-completion

## 🤝 Best Practices

### Code Quality

1. **Follow language conventions** - Respect established patterns
2. **Descriptive names** - No single-letter variables
3. **English only** - All code and comments
4. **Comments explain why** - Not what the code does

### Shell Scripts

1. **POSIX compliance** - Use `#!/bin/sh` and standard features
2. **Error handling** - Always use `set -eu`
3. **Quote variables** - Prevent word splitting: `"$var"`
4. **Function names** - Descriptive and lowercase with underscores

### Git Commits

1. **Conventional commits** - Use template in `.vscode/gitmessage.txt`
2. **Atomic commits** - One logical change per commit
3. **Clear messages** - Imperative mood, explain why
4. **Reference issues** - Link to issue numbers when applicable

### GitHub Actions

1. **Environment variables** - Never inline `${{ }}` expressions in JavaScript
2. **No template literals** - Use array + join() for multi-line strings
3. **Decode outputs** - Handle escaped characters (%0A, %0D, %25)
4. **Security first** - Pin action versions, minimal permissions

## 🔄 Updating the Template

### Regular Maintenance

1. Update extension versions in `.vscode/extensions.json`
2. Review and update Copilot instructions
3. Update tool versions in workflows
4. Test setup script with fresh installations

### Adding New Features

1. Test changes in a real project first
2. Update all relevant documentation
3. Add to setup script if needed
4. Update this README

## 🐛 Troubleshooting

### Extensions Not Working

```bash
# Reload VS Code window
Cmd+Shift+P → "Developer: Reload Window"

# Reinstall extensions
./setup-template.sh
```

### ShellCheck/shfmt Not Found

```bash
# Run installation script
.vscode/install-tools.sh

# Or install manually
brew install shellcheck shfmt  # macOS
```

### Setup Script Fails

```bash
# Make executable
chmod +x setup-template.sh

# Check syntax
sh -n setup-template.sh

# Run with verbose output
sh -x setup-template.sh
```

## 📝 License

See [LICENSE](LICENSE) file for details.

## 🙏 Contributing

Contributions are welcome! Please:

1. Test changes thoroughly
2. Update documentation
3. Follow conventional commits
4. Ensure CI passes

---

**Happy Coding! 🚀**
