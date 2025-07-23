#!/bin/bash
set -e

echo "Setting up ADR development environment..."

# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
    export NONINTERACTIVE=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true
fi

# Install Quarto and TinyTeX
if ! command -v quarto >/dev/null 2>&1; then
    curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
    sudo dpkg -i "quarto-linux-amd64.deb" && rm "quarto-linux-amd64.deb"
    quarto install tinytex --update-path
fi

# Install tools
brew install just vale node
npm install -g markdownlint-cli write-good

echo "Setup complete! Run 'just' to see available commands."
