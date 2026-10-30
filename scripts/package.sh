#!/bin/bash
# Membuat paket distribusi plugin & tema untuk OJS 3.5.
# Format: .tar.gz (standar PKP OJS) dan .zip (fleksibel)
# Siap diunggah melalui menu: Settings > Website > Plugins > Upload A New Plugin
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST="$ROOT/dist"

rm -rf "$DIST"
mkdir -p "$DIST"

echo "=== 1. Packaging Theme Akdisi (plugins.themes) ==="
TMP_THEME=$(mktemp -d /tmp/opencode/pack-theme.XXXXXX)
mkdir -p "$TMP_THEME/akdisi"
cp -r "$ROOT/plugins/themes/akdisi"/* "$TMP_THEME/akdisi/"

# Build tar.gz (Standar OJS PKP)
tar -czf "$DIST/akdisi-theme.tar.gz" -C "$TMP_THEME" akdisi
# Build zip
(cd "$TMP_THEME" && zip -rq "$DIST/akdisi-theme.zip" akdisi)
rm -rf "$TMP_THEME"

echo "=== 2. Packaging SEO Plugin Akdisi (plugins.generic) ==="
TMP_SEO=$(mktemp -d /tmp/opencode/pack-seo.XXXXXX)
mkdir -p "$TMP_SEO/akdisiSeo"
cp -r "$ROOT/plugins/generic/akdisiSeo"/* "$TMP_SEO/akdisiSeo/"

# Build tar.gz (Standar OJS PKP)
tar -czf "$DIST/akdisi-seo.tar.gz" -C "$TMP_SEO" akdisiSeo
# Build zip
(cd "$TMP_SEO" && zip -rq "$DIST/akdisi-seo.zip" akdisiSeo)
rm -rf "$TMP_SEO"

echo "=== Selesai! Berkas tersimpan di folder dist/ ==="
ls -lh "$DIST"
