# VS Code Project Template

This repository serves as a template for new projects with optimized VS Code settings for GitHub Copilot and development best practices.

## What's Included

### 📁 `.vscode/` Configuration
- **`settings.json`** - Optimized VS Code settings for AI/Copilot integration
- **`extensions.json`** - Recommended extensions for development
- **`copilot-instructions.md`** - Custom instructions for GitHub Copilot
- **`gitmessage.txt`** - Conventional commits template

### 🚀 **Quick Start**

1. **Use this template:**
   - Click "Use this template" on GitHub
   - Or clone: `git clone <template-repo-url> <new-project-name>`

2. **Install recommended extensions:**
   - VS Code will prompt to install recommended extensions
   - Or run: `code --install-extension` for each extension

3. **Setup git commit template:**
   ```bash
   git config commit.template .vscode/gitmessage.txt
   ```

4. **Customize for your project:**
   - Update project-specific settings in `settings.json`
   - Modify `.gitignore` for your tech stack
   - Adjust `copilot-instructions.md` for project-specific guidelines

## Features

### 🤖 **AI-Enhanced Development**
- GitHub Copilot optimized settings
- Custom instructions for code quality
- English-only code generation
- Best practices enforcement

### 📝 **Code Quality**
- Automatic formatting on save
- ESLint/Pylint integration
- Conventional commits support
- Spell checking for English

### 🔧 **Developer Experience**
- Consistent indentation rules
- Security-focused file exclusions
- Performance optimizations
- Language-specific configurations

## Customization

### For Different Project Types

#### Python Projects
```json
{
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter",
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true
  }
}
```

#### Node.js Projects
```json
{
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

#### Shell Script Projects
```json
{
  "[shellscript]": {
    "files.eol": "\n",
    "editor.insertSpaces": true,
    "editor.tabSize": 2
  }
}
```

## Extension Categories

### Essential (Always Install)
- GitHub.copilot
- GitHub.copilot-chat
- ms-vscode.vscode-json

### Code Quality
- dbaeumer.vscode-eslint
- ms-python.pylint
- streetsidesoftware.code-spell-checker

### Git Integration
- eamodio.gitlens
- vivaxy.vscode-conventional-commits

### Language Support
- ms-python.python
- redhat.vscode-yaml
- esbenp.prettier-vscode

## Project-Specific Adaptations

### Add to `settings.json` based on your needs:

```json
{
  // For Web Development
  "emmet.includeLanguages": {
    "javascript": "javascriptreact"
  },
  
  // For Docker Projects
  "docker.defaultRegistryPath": "your-registry.com",
  
  // For API Development
  "rest-client.requestNameAsCommentValue": true,
  
  // For Documentation Projects
  "[markdown]": {
    "editor.wordWrap": "on",
    "editor.quickSuggestions": false
  }
}
```

## Best Practices

1. **Keep template updated** - Regularly update the template with new best practices
2. **Team consistency** - Ensure all team members use the same template
3. **Project adaptation** - Customize settings for specific project needs
4. **Extension management** - Keep recommended extensions list current

## Contributing

When updating this template:

1. Test changes in a real project first
2. Update documentation for any new features
3. Consider backward compatibility
4. Follow conventional commits for changes

## License

This template is provided as-is for development use.