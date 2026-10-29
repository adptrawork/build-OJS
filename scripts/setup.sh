#!/bin/bash
# Tarik OJS 3.5.0-5 dari rilis resmi PKP.
# OJS tidak di-commit: repo ini hanya berisi theme, plugin, importer, dan docs.
set -euo pipefail

OJS_VERSION="3.5.0-5"
OJS_URL="https://pkp.sfu.ca/ojs/download/ojs-${OJS_VERSION}.tar.gz"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -d "$ROOT/ojs" ]; then
    echo "ojs/ sudah ada — lewati. Hapus manual kalau mau tarik ulang."
    exit 0
fi

TMP=$(mktemp -d /tmp/opencode/ojs-fetch.XXXXXX)
trap 'rm -rf "$TMP"' EXIT

echo "Mengunduh OJS ${OJS_VERSION}..."
curl -fsSL --max-time 600 -o "$TMP/ojs.tar.gz" "$OJS_URL"
tar xzf "$TMP/ojs.tar.gz" -C "$TMP"
mv "$TMP/ojs-${OJS_VERSION}" "$ROOT/ojs"
mkdir -p "$ROOT/ojs/files"
chmod 777 "$ROOT/ojs/files"

# Patch: lewati unduhan dataset ROR saat instalasi (~40 MB, >100k baris).
# Demo tidak memakai afiliasi ROR; hapus patch ini kalau butuh registry ROR.
python3 - "$ROOT/ojs/lib/pkp/classes/install/Installer.php" <<'PY'
import sys
path = sys.argv[1]
src = open(path).read()
old = """        $updateRorRegistryDataset = new UpdateRorRegistryDataset();
        $updateRorRegistryDataset->execute();"""
new = """        // jeki: unduhan dataset ROR (~40 MB, >100k baris) dilewati di instalasi dev.
        // $updateRorRegistryDataset = new UpdateRorRegistryDataset();
        // $updateRorRegistryDataset->execute();"""
assert old in src, "pola ROR tidak ditemukan — periksa versi OJS"
open(path, "w").write(src.replace(old, new))
print("patch ROR: diterapkan")
PY

echo "Selesai: $ROOT/ojs"
