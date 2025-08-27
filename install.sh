#!/usr/bin/env bash
# Quick start script for nvim-config

set -e

echo "🚀 KurisuNya Neovim Configuration Setup"
echo "======================================"

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo "❌ Neovim is not installed. Please install Neovim first."
    exit 1
fi

# Check Neovim version
nvim_version=$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
echo "📋 Neovim version: $nvim_version"

# Check for required dependencies
echo "🔍 Checking dependencies..."

check_dependency() {
    if command -v "$1" &> /dev/null; then
        echo "  ✓ $1"
    else
        echo "  ⚠️  $1 (recommended)"
    fi
}

check_dependency "git"
check_dependency "node"
check_dependency "python3"
check_dependency "rg"
check_dependency "fd"

# Backup existing config if it exists
if [ -d "$HOME/.config/nvim" ]; then
    echo "📦 Backing up existing Neovim configuration..."
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Clone configuration
echo "📥 Installing Neovim configuration..."
git clone https://github.com/KurisuNya/nvim-config "$HOME/.config/nvim"

echo "✅ Installation complete!"
echo ""
echo "🎯 Next steps:"
echo "  1. Launch Neovim: nvim"
echo "  2. Wait for plugins to install automatically"
echo "  3. Run health check: :HealthCheck"
echo "  4. Check documentation in docs/ folder"
echo ""
echo "📚 Useful commands:"
echo "  :Lazy          - Plugin manager"
echo "  :Mason         - LSP installer"
echo "  :checkhealth   - Neovim health check"
echo "  :HealthCheck   - Custom health check"