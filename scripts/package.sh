#!/bin/bash
# Skrip pembuat paket distribusi plugin & tema untuk OJS 3.5.
# Format: .tar.gz (standar PKP OJS) dan .zip
#
# Penggunaan:
#   ./scripts/package.sh         # Buat paket versi saat ini
#   ./scripts/package.sh --bump  # Naikkan build version (misal: 0.1.0.0 -> 0.1.0.1) agar OJS menerima Upgrade
#   ./scripts/package.sh 0.2.0.0 # Set versi spesifik
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST="$ROOT/dist"

BUMP=false
TARGET_VER=""

if [ "${1:-}" = "--bump" ]; then
    BUMP=true
elif [ -n "${1:-}" ]; then
    TARGET_VER="$1"
fi

bump_file() {
    local file="$1"
    python3 - "$file" "$BUMP" "$TARGET_VER" <<'PY'
import sys, re, datetime

file_path = sys.argv[1]
do_bump = sys.argv[2] == "true"
target_ver = sys.argv[3]

with open(file_path, "r") as f:
    content = f.read()

cur_ver_m = re.search(r"<release>([0-9.]+)</release>", content)
cur_ver = cur_ver_m.group(1) if cur_ver_m else "1.0.0.0"

new_ver = cur_ver
if target_ver:
    new_ver = target_ver
elif do_bump:
    parts = cur_ver.split(".")
    while len(parts) < 4:
        parts.append("0")
    parts[-1] = str(int(parts[-1]) + 1)
    new_ver = ".".join(parts)

if new_ver != cur_ver:
    content = re.sub(r"<release>[0-9.]+</release>", f"<release>{new_ver}</release>", content)
    today = datetime.date.today().strftime("%Y-%m-%d")
    content = re.sub(r"<date>[0-9-]+</date>", f"<date>{today}</date>", content)
    with open(file_path, "w") as f:
        f.write(content)

print(new_ver)
PY
}

THEME_VER=$(bump_file "$ROOT/plugins/themes/akdisi/version.xml")
JE_VER=$(bump_file "$ROOT/plugins/themes/journalEditorial/version.xml")
SEO_VER=$(bump_file "$ROOT/plugins/generic/akdisiSeo/version.xml")

echo "=== Packaging Akdisi Theme (v${THEME_VER}), Journal Editorial (v${JE_VER}) & Akdisi SEO (v${SEO_VER}) ==="

rm -rf "$DIST"
mkdir -p "$DIST"

# 1. Package Theme
TMP_THEME=$(mktemp -d /tmp/opencode/pack-theme.XXXXXX)
mkdir -p "$TMP_THEME/akdisi"
cp -r "$ROOT/plugins/themes/akdisi"/* "$TMP_THEME/akdisi/"

tar -czf "$DIST/akdisi-theme.tar.gz" -C "$TMP_THEME" akdisi
(cd "$TMP_THEME" && zip -rq "$DIST/akdisi-theme.zip" akdisi)
rm -rf "$TMP_THEME"

# 1b. Package Journal Editorial Theme
TMP_JE=$(mktemp -d /tmp/opencode/pack-je.XXXXXX)
mkdir -p "$TMP_JE/journalEditorial"
cp -r "$ROOT/plugins/themes/journalEditorial"/* "$TMP_JE/journalEditorial/"

tar -czf "$DIST/journalEditorial-theme.tar.gz" -C "$TMP_JE" journalEditorial
(cd "$TMP_JE" && zip -rq "$DIST/journalEditorial-theme.zip" journalEditorial)
rm -rf "$TMP_JE"

# 2. Package SEO Plugin
TMP_SEO=$(mktemp -d /tmp/opencode/pack-seo.XXXXXX)
mkdir -p "$TMP_SEO/akdisiSeo"
cp -r "$ROOT/plugins/generic/akdisiSeo"/* "$TMP_SEO/akdisiSeo/"

tar -czf "$DIST/akdisi-seo.tar.gz" -C "$TMP_SEO" akdisiSeo
(cd "$TMP_SEO" && zip -rq "$DIST/akdisi-seo.zip" akdisiSeo)
rm -rf "$TMP_SEO"

echo "=== Paket berhasil dibuat di dist/ ==="
ls -lh "$DIST"
