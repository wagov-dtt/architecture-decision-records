#!/usr/bin/env bash
set -euo pipefail

version="${HUGO_VERSION:-0.161.1}"
if command -v hugo >/dev/null 2>&1 && hugo version | grep -q '+extended'; then
  exit 0
fi

os="$(uname -s | tr '[:upper:]' '[:lower:]')"
arch="$(uname -m)"
case "$arch" in
  x86_64|amd64) arch="amd64" ;;
  aarch64|arm64) arch="arm64" ;;
  *) echo "Unsupported architecture: $arch" >&2; exit 1 ;;
esac

archive="hugo_extended_${version}_${os}-${arch}.tar.gz"
url="https://github.com/gohugoio/hugo/releases/download/v${version}/${archive}"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

curl -fsSL "$url" -o "$tmp/$archive"
tar -xzf "$tmp/$archive" -C "$tmp" hugo
mkdir -p "$HOME/.local/bin"
install -m 0755 "$tmp/hugo" "$HOME/.local/bin/hugo"
