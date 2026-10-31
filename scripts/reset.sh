#!/bin/bash
# Reset OJS ke kondisi awal bersih ("mulai dari nol").
# - Drop & buat ulang database MariaDB
# - Bersihkan folder upload files/, public/, cache/
# - Jalankan pipeline instalasi bersih & buat journal AKDISI
# - Symlink plugin & theme kustom dari luar folder ojs/
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== 1. Reset Database ==="
ddev mysql -uroot -proot -e "DROP DATABASE IF EXISTS db; CREATE DATABASE db;"

echo "=== 2. Bersihkan file runtime & upload ==="
rm -rf "$ROOT/ojs/files"/* "$ROOT/ojs/cache"/* "$ROOT/ojs/public"/* 2>/dev/null || true
mkdir -p "$ROOT/ojs/files" "$ROOT/ojs/cache" "$ROOT/ojs/public"
chmod -R 777 "$ROOT/ojs/files" "$ROOT/ojs/cache" "$ROOT/ojs/public" 2>/dev/null || true

echo "=== 2b. Hapus theme legacy yang tidak kompatibel dengan OJS 3.5 ==="
for theme in academicFree sanguline immersion; do
    if [ -d "$ROOT/ojs/plugins/themes/$theme" ]; then
        rm -rf "$ROOT/ojs/plugins/themes/$theme"
        echo "  removed: $theme"
    fi
done

echo "=== 3. Set config installed = Off ==="
sed -i 's|^installed = .*|installed = Off|' "$ROOT/ojs/config.inc.php"

echo "=== 4. Jalankan install.sh ==="
bash "$ROOT/scripts/install.sh"

echo "=== 5. Reset selesai! State: BERSIH (0 submissions, 0 issues) ==="
