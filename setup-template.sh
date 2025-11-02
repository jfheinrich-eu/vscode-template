#!/bin/sh
# POSIX-compliant shell script for template setup
set -eu

# VS Code Project Template Setup Script
# Run this after creating a new project from the template

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() {
	printf "${GREEN}✅${NC} %s\n" "$1"
}

warn() {
	printf "${YELLOW}⚠️${NC}  %s\n" "$1"
}

error() {
	printf "${RED}❌${NC} %s\n" "$1"
}

step() {
	printf "${BLUE}▶${NC}  %s\n" "$1"
}

echo "🚀 Setting up VS Code project template..."
echo ""

# 1. Setup git commit template
step "Setting up git commit template..."
if [ -f ".vscode/gitmessage.txt" ]; then
	git config commit.template .vscode/gitmessage.txt
	info "Git commit template configured"
else
	warn "No git message template found"
fi
echo ""

# 2. Install development tools (shellcheck, shfmt)
step "Installing development tools..."
if [ -x ".vscode/install-tools.sh" ]; then
	info "Running .vscode/install-tools.sh..."
	.vscode/install-tools.sh
elif [ -f ".vscode/install-tools.sh" ]; then
	chmod +x .vscode/install-tools.sh
	info "Running .vscode/install-tools.sh..."
	.vscode/install-tools.sh
else
	warn "Development tools installation script not found"
	warn "Install shellcheck and shfmt manually or run: .vscode/install-tools.sh"
fi
echo ""

# 3. Install essential VS Code extensions
step "Installing essential VS Code extensions..."

# Check if code command is available
if ! command -v code >/dev/null 2>&1; then
	warn "VS Code CLI 'code' command not found"
	warn "Install VS Code command line tools: Cmd+Shift+P -> 'Shell Command: Install code in PATH'"
	warn "Or manually install recommended extensions from .vscode/extensions.json"
else
	# Essential extensions (one per line for POSIX compatibility)
	install_extension() {
		ext="$1"
		if code --list-extensions 2>/dev/null | grep -q "^${ext}$"; then
			info "$ext already installed"
		else
			step "Installing $ext..."
			if code --install-extension "$ext" >/dev/null 2>&1; then
				info "$ext installed"
			else
				warn "Could not install $ext"
			fi
		fi
	}

	# Core extensions
	install_extension "GitHub.copilot"
	install_extension "GitHub.copilot-chat"
	install_extension "esbenp.prettier-vscode"
	install_extension "ms-python.black-formatter"
	install_extension "redhat.vscode-yaml"
	install_extension "streetsidesoftware.code-spell-checker"
	install_extension "vivaxy.vscode-conventional-commits"

	# Code quality and linting
	install_extension "dbaeumer.vscode-eslint"
	install_extension "ms-python.python"
	install_extension "ms-python.pylint"

	# Git support
	install_extension "eamodio.gitlens"
	install_extension "mhutchie.git-graph"

	# Shell scripting support (NEW)
	install_extension "timonwong.shellcheck"
	install_extension "foxundermoon.shell-format"

	# Additional useful extensions
	install_extension "aaron-bond.better-comments"
	install_extension "yzhang.markdown-all-in-one"
	install_extension "github.vscode-github-actions"
fi
echo ""

# 4. Create project-specific files if they don't exist
step "Setting up project files..."
if [ ! -f "README.md" ]; then
	cat >README.md <<'EOF'
# Project Name

## Description

Add your project description here.

## Setup

1. Install dependencies
2. Configure environment
3. Run the application

## Development

See [SHELL_DEVELOPMENT.md](SHELL_DEVELOPMENT.md) for shell script development setup.
EOF
	info "Created basic README.md"
else
	info "README.md already exists"
fi

if [ ! -f ".gitignore" ]; then
	if [ -f ".gitignore.template" ]; then
		cp .gitignore.template .gitignore
		info "Created .gitignore from template"
	else
		# Create basic .gitignore
		cat >.gitignore <<'EOF'
# OS files
.DS_Store
Thumbs.db

# IDE
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
!.vscode/copilot-instructions.md
!.vscode/gitmessage.txt
!.vscode/README.md
!.vscode/SETUP.md
!.vscode/install-tools.sh
.idea/
*.swp
*.swo
*~

# Environment
.env
.env.local
.env.*.local

# Dependencies
node_modules/
venv/
__pycache__/
*.pyc

# Build outputs
dist/
build/
*.log
EOF
		info "Created basic .gitignore"
	fi
else
	info ".gitignore already exists"
fi
echo ""

# 5. Verify tool installations
step "Verifying development tools..."
tools_missing=0

if command -v shellcheck >/dev/null 2>&1; then
	info "shellcheck installed: $(shellcheck --version | head -n 2 | tail -n 1)"
else
	warn "shellcheck not found - install it for shell script linting"
	tools_missing=1
fi

if command -v shfmt >/dev/null 2>&1; then
	info "shfmt installed: $(shfmt --version)"
else
	warn "shfmt not found - install it for shell script formatting"
	tools_missing=1
fi

if [ $tools_missing -eq 1 ]; then
	warn "Run .vscode/install-tools.sh to install missing tools"
fi
echo ""

# 6. Initialize git if not already done
step "Setting up git repository..."
if [ ! -d ".git" ]; then
	git init
	info "Git repository initialized"

	# Initial commit
	git add .
	git commit -m "feat: initial project setup from template"
	info "Initial commit created"
else
	info "Git repository already initialized"
fi
echo ""

# 7. Display completion message and next steps
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Template setup complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next steps:"
echo ""
echo "  1. ${BLUE}Open project in VS Code:${NC}"
echo "     code ."
echo ""
echo "  2. ${BLUE}Install recommended extensions:${NC}"
echo "     - VS Code will prompt you automatically"
echo "     - Or: Cmd+Shift+P → 'Extensions: Show Recommended Extensions'"
echo ""
echo "  3. ${BLUE}Install development tools (if not done):${NC}"
echo "     .vscode/install-tools.sh"
echo ""
echo "  4. ${BLUE}Customize project:${NC}"
echo "     - Update README.md with project details"
echo "     - Customize .vscode/copilot-instructions.md"
echo "     - Review and adjust .vscode/settings.json"
echo ""
echo "  5. ${BLUE}Configure remote repository:${NC}"
echo "     git remote add origin <your-repo-url>"
echo "     git push -u origin main"
echo ""
echo "📚 Documentation:"
echo "  - Shell development: SHELL_DEVELOPMENT.md"
echo "  - VS Code setup: .vscode/SETUP.md"
echo "  - VS Code config: .vscode/README.md"
echo ""
echo "💡 Tips:"
echo "  - Use Copilot with custom instructions for best results"
echo "  - Shell scripts auto-format on save (shfmt)"
echo "  - ShellCheck runs on type for immediate feedback"
echo "  - Commit messages follow Conventional Commits format"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
