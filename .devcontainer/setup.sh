#!/bin/bash
set -e

echo "🚀 Setting up ADR development environment..."

# Install Homebrew
echo "📦 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install tools via Homebrew
echo "📦 Installing development tools..."
brew install just vale node

# Install Quarto (latest stable)
echo "📦 Installing Quarto..."
cd /tmp
wget -q "https://github.com/quarto-dev/quarto-cli/releases/latest/download/quarto-linux-amd64.deb"
sudo dpkg -i "quarto-linux-amd64.deb"
rm "quarto-linux-amd64.deb"

# Install write-good via npm
echo "📦 Installing write-good..."
npm install -g write-good

# Add Homebrew to PATH permanently
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc

echo "✅ Setup complete!"
echo "Available commands:"
echo "  just          - Show available build commands"
echo "  just build    - Build website and PDF"
echo "  just serve    - Start development server"
echo "  just validate - Validate ADR files and prose"
