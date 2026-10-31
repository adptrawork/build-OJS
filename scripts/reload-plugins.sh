#!/bin/bash
# Memperbarui plugin & tema kustom secara instan di OJS tanpa perlu upload ulang.
# Skrip ini:
# 1. Memastikan symlink dari plugins/ ke ojs/plugins/ terhubung dengan benar.
# 2. Mendaftarkan versi terbaru dari version.xml ke tabel versions di DB.
# 3. Memastikan status plugin aktif (enabled = 1).
# 4. Membersihkan seluruh cache template OJS.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== 1. Memeriksa Symlink ==="
ln -sfn ../../../plugins/themes/akdisi "$ROOT/ojs/plugins/themes/akdisi"
ln -sfn ../../../plugins/generic/akdisiSeo "$ROOT/ojs/plugins/generic/akdisiSeo"
ln -sfn ../../../plugins/themes/journalEditorial "$ROOT/ojs/plugins/themes/journalEditorial"

echo "=== 2. Memperbarui Versi di Database ==="
ddev exec php /var/www/html/scripts/register-plugins.php

echo "=== 3. Memastikan Plugin & Tema Aktif ==="
ddev mysql -uroot -proot -e "
  INSERT INTO plugin_settings (plugin_name, context_id, setting_name, setting_value, setting_type)
    VALUES ('akdisithemeplugin', 1, 'enabled', '1', 'bool'),
           ('akdisithemeplugin', NULL, 'enabled', '1', 'bool'),
           ('akdisiseoplugin', 1, 'enabled', '1', 'bool'),
           ('journaleditorialthemeplugin', 1, 'enabled', '1', 'bool'),
           ('journaleditorialthemeplugin', NULL, 'enabled', '1', 'bool')
    ON DUPLICATE KEY UPDATE setting_value='1';
" 2>/dev/null || true

echo "=== 4. Membersihkan Cache OJS ==="
ddev exec bash -c 'cd /var/www/html && rm -rf ojs/cache && mkdir -p ojs/cache'

echo "=== Selesai! Plugin & Tema Akdisi telah diperbarui & aktif ==="
