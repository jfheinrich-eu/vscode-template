#!/bin/sh
# Install development tools for VS Code shell script development
# This script installs shellcheck and shfmt if they are not already installed

set -eu

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Version to install
SHFMT_VERSION="v3.12.0"

# Helper functions
info() {
	printf "${GREEN}[INFO]${NC} %s\n" "$1"
}

warn() {
	printf "${YELLOW}[WARN]${NC} %s\n" "$1"
}

error() {
	printf "${RED}[ERROR]${NC} %s\n" "$1"
	exit 1
}

# Detect OS and architecture
detect_platform() {
	OS=$(uname -s | tr '[:upper:]' '[:lower:]')
	ARCH=$(uname -m)

	case "$ARCH" in
	x86_64)
		ARCH="amd64"
		;;
	aarch64 | arm64)
		ARCH="arm64"
		;;
	*)
		error "Unsupported architecture: $ARCH"
		;;
	esac

	info "Detected platform: $OS $ARCH"
}

# Install shellcheck
install_shellcheck() {
	if command -v shellcheck >/dev/null 2>&1; then
		info "shellcheck is already installed ($(shellcheck --version | head -n 2 | tail -n 1))"
		return 0
	fi

	info "Installing shellcheck..."

	if command -v brew >/dev/null 2>&1; then
		info "Using Homebrew to install shellcheck"
		brew install shellcheck
	elif command -v apt-get >/dev/null 2>&1; then
		info "Using apt to install shellcheck"
		sudo apt-get update
		sudo apt-get install -y shellcheck
	elif command -v dnf >/dev/null 2>&1; then
		info "Using dnf to install shellcheck"
		sudo dnf install -y shellcheck
	elif command -v yum >/dev/null 2>&1; then
		info "Using yum to install shellcheck"
		sudo yum install -y shellcheck
	else
		warn "No package manager found. Please install shellcheck manually."
		warn "See: https://github.com/koalaman/shellcheck#installing"
		return 1
	fi

	if command -v shellcheck >/dev/null 2>&1; then
		info "shellcheck installed successfully"
	else
		error "Failed to install shellcheck"
	fi
}

# Install shfmt
install_shfmt() {
	if command -v shfmt >/dev/null 2>&1; then
		info "shfmt is already installed ($(shfmt --version))"
		return 0
	fi

	info "Installing shfmt..."

	if command -v brew >/dev/null 2>&1; then
		info "Using Homebrew to install shfmt"
		brew install shfmt
	elif command -v go >/dev/null 2>&1; then
		info "Using Go to install shfmt"
		go install mvdan.cc/sh/v3/cmd/shfmt@latest
	else
		info "Installing shfmt from GitHub releases"

		# Determine binary name
		case "$OS" in
		darwin)
			BINARY="shfmt_${SHFMT_VERSION#v}_darwin_${ARCH}"
			;;
		linux)
			BINARY="shfmt_${SHFMT_VERSION#v}_linux_${ARCH}"
			;;
		*)
			error "Unsupported OS: $OS"
			;;
		esac

		URL="https://github.com/mvdan/sh/releases/download/${SHFMT_VERSION}/${BINARY}"
		info "Downloading from: $URL"

		TEMP_FILE=$(mktemp)
		if curl -fsSL "$URL" -o "$TEMP_FILE"; then
			chmod +x "$TEMP_FILE"

			# Try to install to /usr/local/bin (may require sudo)
			if [ -w "/usr/local/bin" ]; then
				mv "$TEMP_FILE" /usr/local/bin/shfmt
			else
				info "Installing to /usr/local/bin requires sudo"
				sudo mv "$TEMP_FILE" /usr/local/bin/shfmt
			fi

			info "shfmt installed successfully"
		else
			rm -f "$TEMP_FILE"
			error "Failed to download shfmt"
		fi
	fi

	if command -v shfmt >/dev/null 2>&1; then
		info "shfmt installed successfully ($(shfmt --version))"
	else
		error "Failed to install shfmt"
	fi
}

# Main installation
main() {
	info "Starting development tools installation"
	info "This will install shellcheck and shfmt for shell script development"
	echo ""

	detect_platform
	echo ""

	install_shellcheck
	echo ""

	install_shfmt
	echo ""

	info "Installation complete!"
	info "Please restart VS Code to ensure extensions detect the new tools"
	echo ""
	info "Verify installation:"
	info "  shellcheck --version"
	info "  shfmt --version"
}

main "$@"
