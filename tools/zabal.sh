#!/bin/bash
# Zabalí skill do zipu pro nahrání do claude.ai (Nastavení → Skills).
set -eu
root="$(cd "$(dirname "$0")/.." && pwd)"
ver="$(cat "$root/skills/oponent/VERZE")"
mkdir -p "$root/dist"
out="$root/dist/oponent-$ver.zip"
rm -f "$out"
(cd "$root/skills" && zip -qr "$out" oponent -x '*.DS_Store')
echo "$out"
