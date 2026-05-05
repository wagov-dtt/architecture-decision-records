#!/usr/bin/env bash
set -euo pipefail

version="${DART_SASS_VERSION:-1.99.0}"
if command -v sass >/dev/null 2>&1 && sass --version | grep -q "^${version}"; then
  exit 0
fi

os="$(uname -s | tr '[:upper:]' '[:lower:]')"
arch="$(uname -m)"
case "$os" in
  linux|darwin) ;;
  *) echo "Unsupported OS: $os" >&2; exit 1 ;;
esac
case "$arch" in
  x86_64|amd64) arch="x64" ;;
  aarch64|arm64) arch="arm64" ;;
  *) echo "Unsupported architecture: $arch" >&2; exit 1 ;;
esac

archive="dart-sass-${version}-${os}-${arch}.tar.gz"
url="https://github.com/sass/dart-sass/releases/download/${version}/${archive}"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

curl -fsSL "$url" -o "$tmp/$archive"
tar -xzf "$tmp/$archive" -C "$tmp"
install_dir="$HOME/.local/share/dart-sass-${version}"
rm -rf "$install_dir"
mkdir -p "$(dirname "$install_dir")" "$HOME/.local/bin"
cp -R "$tmp/dart-sass" "$install_dir"
ln -sfn "$install_dir/sass" "$HOME/.local/bin/sass"
