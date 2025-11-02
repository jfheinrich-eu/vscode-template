# GitHub Copilot Instructions

## Language and Communication

- **Always write code, comments, and documentation in English**
- Use clear, descriptive variable and function names in English
- Write commit messages in English following conventional commit format
- All code comments must be in English, regardless of the original repository language

## Code Style and Best Practices

### General Guidelines

- Follow POSIX-compliant shell scripting standards for shell scripts
- Use consistent indentation (2 spaces for shell scripts, 4 spaces for Python)
- Keep functions focused and single-purpose
- Prefer readability over cleverness
- Add comments only when they add value (explain "why", not "what")

### Shell Script Best Practices

- Always use `set -eu` at the beginning of scripts for error handling
- Quote variables to prevent word splitting: `"$var"` instead of `$var`
- Use `$()` for command substitution instead of backticks
- Check for command existence with `command -v` instead of `which`
- Use `mktemp` for temporary files and clean them up in trap handlers
- Validate required environment variables early in the script
- Use meaningful error messages with proper internationalization (i18n) for user-facing messages
  - Note: Code and comments must be in English; i18n applies only to runtime user messages

### Python Best Practices

- Follow PEP 8 style guidelines (4 spaces for indentation)
- Use type hints where appropriate
- Handle exceptions gracefully with specific error messages
- Use context managers (`with` statements) for file operations
- Keep Python snippets simple and focused for shell script integration

### Security Best Practices

- Never hardcode credentials or API tokens in code
- Use environment variables or configuration files for sensitive data
- Validate and sanitize user input
- Use secure communication (HTTPS) for API calls
- Implement proper retry logic with exponential backoff for network requests
- Set appropriate timeouts for network operations

### GitHub Actions and Workflow Best Practices

When working with GitHub Actions workflows, assume the role of an experienced JavaScript developer with years of `actions/github-script` expertise.

#### General Workflow Guidelines

- Use descriptive job and step names that explain their purpose
- Add comments explaining complex workflow logic
- Group related steps logically
- Use meaningful variable names in `env` sections
- Leverage job outputs for data passing between jobs
- Use `if` conditionals to control job/step execution
- Set appropriate timeouts to prevent runaway jobs
- Use `continue-on-error` strategically for non-critical steps

#### `actions/github-script` Best Practices

**CRITICAL**: Always follow these patterns when writing JavaScript in GitHub Actions:

1. **Use Environment Variables Instead of Inline Expressions**

   ```yaml
   # ✅ CORRECT - Safe and reliable
   - name: Process data
     uses: actions/github-script@v7
     env:
       RESULT: ${{ needs.previous-job.outputs.result }}
       OUTPUT_DATA: ${{ needs.previous-job.outputs.data }}
     with:
       script: |
         const result = process.env.RESULT || 'default';
         const data = process.env.OUTPUT_DATA || '';

   # ❌ WRONG - Can cause syntax errors
   - name: Process data
     uses: actions/github-script@v7
     with:
       script: |
         const result = '${{ needs.previous-job.outputs.result }}';
         const data = `${{ needs.previous-job.outputs.data }}`;
   ```

2. **Never Use Template Literals for GitHub Expressions**

   ```javascript
   // ❌ WRONG - Template literals + GitHub expressions = syntax errors
   const body = `Status: ${{ needs.job.outputs.status }}
   Result: ${{ needs.job.outputs.result }}`;

   // ✅ CORRECT - Use string arrays and join()
   const bodyParts = [
     'Status: ' + process.env.STATUS,
     'Result: ' + process.env.RESULT
   ];
   const body = bodyParts.join('\n');
   ```

3. **Handle Escaped Characters from Job Outputs**

   ```javascript
   // GitHub outputs are escaped (%0A for newline, %0D for carriage return, %25 for %)
   const decodeOutput = (str) => {
     if (!str) return "";
     return str
       .replace(/%25/g, "%")
       .replace(/%0A/g, "\n")
       .replace(/%0D/g, "\r");
   };

   const cleanOutput = decodeOutput(process.env.RAW_OUTPUT || "");
   ```

4. **Build Complex Strings Programmatically**

   ````javascript
   // ✅ CORRECT - Build strings piece by piece
   const parts = [];
   parts.push("## Summary");
   parts.push("");
   if (hasErrors) {
     parts.push("### Errors");
     parts.push("```");
     parts.push(errorOutput);
     parts.push("```");
   }
   const body = parts.join("\n");
   ````

5. **Extract Logic into Helper Functions**

   ```javascript
   // ✅ CORRECT - Maintainable and testable
   const getStatusIcon = (status) => {
     if (status === "success") return "✅";
     if (status === "skipped") return "⏭️";
     return "❌";
   };

   const formatResult = (name, result) => {
     return "| " + name + " | " + getStatusIcon(result) + " " + result + " |";
   };
   ```

6. **Always Validate Context Data**

   ```javascript
   // ✅ CORRECT - Check for required data
   const pr = context.payload.pull_request;
   if (!pr || !pr.number) {
     console.log("No PR context available");
     return;
   }
   ```

7. **Use Explicit String Concatenation for Safety**

   ```javascript
   // ✅ CORRECT - Clear and safe
   const message = "Check failed for " + fileName + " with error: " + errorMsg;

   // ⚠️ AVOID - Template literals can be problematic in YAML
   const message = `Check failed for ${fileName} with error: ${errorMsg}`;
   ```

8. **Sanitize User Inputs**
   ```javascript
   // Always sanitize data that might contain special characters
   const sanitize = (str) => String(str || "").replace(/[`${}]/g, "");
   const safeValue = sanitize(userInput);
   ```

#### Workflow Security Best Practices

- Use minimal required permissions with `permissions:` block
- Pin action versions to specific commit SHAs for security
- Use `secrets.GITHUB_TOKEN` instead of personal access tokens when possible
- Validate all external inputs
- Use `continue-on-error: true` carefully to avoid masking failures
- Never log sensitive information
- Use environment variables for all dynamic values in scripts

#### Job Output and Data Passing

- Use `$GITHUB_OUTPUT` for setting job outputs
- Properly escape special characters in outputs
- Document expected output format in comments
- Validate outputs exist before using them in dependent jobs
- Use meaningful output names that describe the data

#### Error Handling in Workflows

- Set appropriate `timeout-minutes` for all jobs
- Use `continue-on-error` strategically
- Capture and report errors appropriately
- Use `if: always()` for cleanup steps
- Provide clear error messages using `echo "::error::message"`

#### Workflow Debugging

- Use `echo "::debug::message"` for debug output
- Add `echo "::notice::message"` for important information
- Use `echo "::warning::message"` for warnings
- Structure logs to be easily searchable

## Code Review Guidelines

When reviewing code, always check for:

### Functionality

- Does the code solve the intended problem?
- Are edge cases handled properly?
- Is error handling comprehensive and appropriate?

### Code Quality

- Is the code readable and maintainable?
- Are variable and function names descriptive?
- Is the code properly documented where necessary?
- Are there any code smells or anti-patterns?

### Performance

- Are there any obvious performance issues?
- Is resource usage (memory, file handles, network) managed properly?
- Are there unnecessary operations or redundant code?

### Security

- Are there any security vulnerabilities?
- Is user input properly validated?
- Are credentials and sensitive data handled securely?
- Are dependencies up to date and free of known vulnerabilities?

### Testing

- Is the code testable?
- Are edge cases covered?
- Are error conditions tested?

### Compatibility

- Is the code compatible with the target environment (POSIX shell, Python 3, etc.)?
- Are all dependencies properly documented?
- Does the code work across different platforms if needed?

## Project-Specific Guidelines

### Confluence Uploader Script

- Maintain i18n support (English and German messages)
- Preserve POSIX compatibility (avoid bash-specific features)
- Keep retry logic and timeout configurations
- Maintain backward compatibility with existing configuration files
- Use Confluence REST API best practices
- Handle API rate limiting gracefully

### Error Handling

- Use the `msg()` function for internationalized error messages
- Use `die()` for fatal errors that should terminate the script
- Use `warn()` for non-fatal warnings
- Use `say()` for informational messages
- Provide actionable error messages that help users resolve issues

### Documentation

- Update README.md when adding new features or changing behavior
- Document environment variables in `.env.example` files
- Include usage examples for new functionality
- Keep inline documentation up to date with code changes

## Commit Guidelines

- Use conventional commit format:
  - `feat:` for new features
  - `fix:` for bug fixes
  - `docs:` for documentation changes
  - `refactor:` for code refactoring
  - `test:` for adding or updating tests
  - `chore:` for maintenance tasks
- Write clear, concise commit messages
- Reference issue numbers when applicable
- Keep commits focused on a single change

## Pull Request Guidelines

- Provide a clear description of the changes
- Link to related issues
- Include testing steps
- Highlight any breaking changes
- Update documentation as needed
- Ensure all CI checks pass before requesting review
