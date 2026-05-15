#!/bin/bash
# install_treesitter.sh - Build and install tree-sitter-cli from source
#
# Usage: ./install_treesitter.sh [version]
# Example: ./install_treesitter.sh v0.25.10
#
# If no version is specified, defaults to v0.25.10

set -euo pipefail

VERSION="${1:-v0.25.10}"
CLONE_DIR="/tmp/tree-sitter"

echo "==> Installing tree-sitter-cli ${VERSION} from source..."

# Clean up any previous clone
rm -rf "${CLONE_DIR}"

# Clone the repo
echo "==> Cloning tree-sitter repository..."
git clone --depth 1 https://github.com/tree-sitter/tree-sitter.git "${CLONE_DIR}"

# Fetch tags and checkout the desired version
echo "==> Checking out ${VERSION}..."
git -C "${CLONE_DIR}" fetch --tags
git -C "${CLONE_DIR}" checkout "${VERSION}"

# Build and install with locked dependencies
echo "==> Building tree-sitter-cli (this may take a few minutes)..."
cargo install --path "${CLONE_DIR}/cli" --locked

# Clean up
echo "==> Cleaning up..."
rm -rf "${CLONE_DIR}"

# Verify installation
if command -v tree-sitter &>/dev/null; then
    echo "==> Success! $(tree-sitter --version)"
elif [ -x "$HOME/.cargo/bin/tree-sitter" ]; then
    echo "==> Success! $($HOME/.cargo/bin/tree-sitter --version)"
    echo "    NOTE: Make sure ~/.cargo/bin is in your PATH"
    echo "    Add this to your shell rc file:"
    echo "      export PATH=\"\$HOME/.cargo/bin:\$PATH\""
else
    echo "==> ERROR: tree-sitter binary not found after install"
    exit 1
fi
