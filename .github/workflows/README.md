# GitHub Actions Workflows

This directory contains automated workflows for repository management and code quality checks.

## Workflows

### `sync-repo-settings.yml`

Automatically applies repository settings, branch protection rules, and labels from `.github/settings.yml`.

**Triggers:**
- Manual via `workflow_dispatch`
- Automatic on push to `main` branch when `.github/settings.yml` changes

**Required Setup:**

To avoid 403 errors when updating repository settings and branch protection, you need to create a Personal Access Token (PAT):

1. Go to [GitHub Settings > Developer settings > Personal access tokens > Tokens (classic)](https://github.com/settings/tokens)
2. Click "Generate new token (classic)"
3. Set a name: `Repository Settings Automation`
4. Select scopes:
   - `repo` (Full control of private repositories)
5. Click "Generate token" and copy the token
6. Go to your repository > Settings > Secrets and variables > Actions
7. Click "New repository secret"
8. Name: `REPO_SETTINGS_TOKEN`
9. Value: Paste your PAT
10. Click "Add secret"

**Fallback:** The workflow will fall back to `GITHUB_TOKEN` if `REPO_SETTINGS_TOKEN` is not configured, but this may result in 403 errors for certain operations (repository settings, branch protection).

**Permissions:**
- `contents: write` - Repository operations
- `issues: write` - Label management
- `pull-requests: write` - Branch protection features

### `check-sources.yml`

Validates code quality for devcontainer configurations, Dockerfiles, and shell scripts.

**Triggers:**
- Pull requests to `main` branch
- Push to `main` branch

**Checks:**
- DevContainer configuration validation
- Dockerfile linting with hadolint
- Shell script linting with shellcheck
- Shell script formatting with shfmt

**Features:**
- Differentiated file existence checks
- Conditional job execution (skip if no files to check)
- Detailed error annotations in PR comments
- Individual status checks for each validation type

**Required Tools:**
- [hadolint](https://github.com/hadolint/hadolint) - Dockerfile linter
- [shellcheck](https://github.com/koalaman/shellcheck) - Shell script linter
- [shfmt](https://github.com/mvdan/sh) - Shell script formatter

## Best Practices

When modifying workflows:

1. **Use environment variables** instead of inline GitHub expressions in `actions/github-script`
2. **Avoid template literals** - use string arrays with `join()` instead
3. **Validate context data** before using it
4. **Build strings programmatically** for complex output
5. **Set appropriate timeouts** for all jobs
6. **Use meaningful error messages** with proper logging levels
7. **Test workflows** with both manual and automatic triggers

See `.github/copilot-instructions.md` for detailed GitHub Actions development guidelines.
