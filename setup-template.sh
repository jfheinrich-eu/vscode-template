#!/bin/bash
# Note: Uses bash instead of POSIX sh due to array usage for extension list (line 20)
set -eu

# VS Code Project Template Setup Script
# Run this after creating a new project from the template

echo "🚀 Setting up VS Code project template..."

# 1. Setup git commit template
if [ -f ".vscode/gitmessage.txt" ]; then
    git config commit.template .vscode/gitmessage.txt
    echo "✅ Git commit template configured"
else
    echo "⚠️  No git message template found"
fi

# 2. Install essential extensions
echo "📦 Installing essential VS Code extensions..."

EXTENSIONS=(
    "GitHub.copilot"
    "GitHub.copilot-chat"
    "esbenp.prettier-vscode"
    "ms-python.black-formatter"
    "redhat.vscode-yaml"
    "streetsidesoftware.code-spell-checker"
    "vivaxy.vscode-conventional-commits"
)

for ext in "${EXTENSIONS[@]}"; do
    if code --list-extensions | grep -q "$ext"; then
        echo "  ✅ $ext already installed"
    else
        echo "  📦 Installing $ext..."
        code --install-extension "$ext" 2>/dev/null || echo "  ⚠️  Could not install $ext"
    fi
done

# 3. Create project-specific files if they don't exist
if [ ! -f "README.md" ]; then
    echo "# Project Name" > README.md
    echo "📝 Created basic README.md"
fi

if [ ! -f ".gitignore" ]; then
    cp .gitignore.template .gitignore 2>/dev/null || echo "⚠️  No .gitignore template found"
fi

# 4. Initialize git if not already done
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "feat: initial project setup from template"
    echo "🎯 Git repository initialized"
fi

echo ""
echo "🎉 Template setup complete!"
echo ""
echo "Next steps:"
echo "  1. Open project in VS Code: code ."
echo "  2. Install recommended extensions when prompted"
echo "  3. Customize .vscode/copilot-instructions.md for your project"
echo "  4. Update README.md with project details"
echo "  5. Configure remote repository: git remote add origin <url>"
echo ""