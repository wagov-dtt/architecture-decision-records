#!/bin/bash
set -e

echo "🚀 Setting up ADR development environment..."

# Check if Rust is installed
if ! command -v cargo >/dev/null 2>&1; then
    echo "📦 Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.cargo/env
else
    echo "✅ Rust already installed"
fi

# Install required tools using just
if command -v just >/dev/null 2>&1; then
    echo "🔧 Installing tools via just..."
    just setup
else
    echo "📦 Installing just first..."
    cargo install just
    echo "🔧 Installing remaining tools..."
    just setup
fi

echo "✅ Setup complete! Available commands:"
echo "  just lint      - Lint and fix formatting issues"
echo "  just serve     - Start local development server"
echo "  just build     - Build documentation"
