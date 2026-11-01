#!/bin/bash
# Instal OJS bersih di DDEV (dipakai setelah setup.sh menarik kode baru).
# Idempotent hati-hati: installer di-skip bila `installed=On` di config.inc.php.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if grep -q "^installed = On" "$ROOT/ojs/config.inc.php"; then
    echo "OJS sudah ter-instal. Skip. (set installed=Off untuk instal ulang)"
    exit 0
fi

# Baris instalasi (non-interaktif via stdin).
printf 'en\nid\n\n/var/www/html/ojs/files\nadmin\nakdisi-admin\nakdisi-admin\nadmin@jrdc.my.id\nmysqli\ndb\ndb\ndb\ndb\ndev-host.local/index.php/jrdc/oai\nn\ny\n' \
    | ddev exec -j php ojs/tools/install.php >/dev/null 2>&1 || true

# Bug OJS Installer: baris allowed_hosts yang kita tulis manual semua ke-escape
# ("[\"\"]") sehingga daftar host jadi kosong → 400 host not allowed. Kembali
# tulis JSON yang benar.
sed -i 's|^allowed_hosts = .*|allowed_hosts = ["dev-host.local"]|' "$ROOT/ojs/config.inc.php"

# Jangan render PHP notice/deprecation/fatal ke dalam HTML pengunjung
# (Smarty/DC meta memunculkan deprecation; fatal contact page sempat bocor).
sed -i 's|^display_errors = On|display_errors = Off|' "$ROOT/ojs/config.inc.php"

# Permission folder yang wajib writable.
ddev exec -j chmod 777 /var/www/html/ojs/config.inc.php /var/www/html/ojs/cache \
    /var/www/html/ojs/public /var/www/html/ojs/files 2>/dev/null || true

ddev exec -j php /var/www/html/scripts/create-journal.php || true

# Hapus theme legacy yang tidak kompatibel dengan OJS 3.5.
for theme in academicFree sanguline immersion; do
    rm -rf "$ROOT/ojs/plugins/themes/$theme"
done

# Symlink theme & plugin milik project (di folder plugins/) ke dalam ojs/.
rm -f "$ROOT/ojs/plugins/themes/jeki" "$ROOT/ojs/plugins/generic/jekiSeo"
ln -sfn ../../../plugins/themes/akdisi "$ROOT/ojs/plugins/themes/akdisi"
ln -sfn ../../../plugins/generic/akdisiSeo "$ROOT/ojs/plugins/generic/akdisiSeo"
ln -sfn ../../../plugins/themes/journalEditorial "$ROOT/ojs/plugins/themes/journalEditorial"

ddev exec -j php /var/www/html/scripts/register-plugins.php >/dev/null 2>&1 || true

# Aktifkan theme journalEditorial & plugin akdisiSeo di context 1.
ddev mysql -uroot -proot -e "
  UPDATE journal_settings SET setting_value='journalEditorial' WHERE setting_name='themePluginPath' AND journal_id=1;
  INSERT INTO plugin_settings (plugin_name, context_id, setting_name, setting_value, setting_type)
    VALUES ('akdisithemeplugin', 1, 'enabled', '1', 'bool'),
           ('akdisithemeplugin', NULL, 'enabled', '1', 'bool'),
           ('akdisiseoplugin', 1, 'enabled', '1', 'bool'),
           ('journaleditorialthemeplugin', 1, 'enabled', '1', 'bool'),
           ('journaleditorialthemeplugin', NULL, 'enabled', '1', 'bool')
    ON DUPLICATE KEY UPDATE setting_value='1';
" 2>/dev/null || true

# Masukkan demo custom blocks & skeleton static pages.
ddev mysql -uroot -proot db < "$ROOT/scripts/static-pages.sql" 2>/dev/null || true
ddev mysql -uroot -proot db < "$ROOT/scripts/akdisi-custom-blocks.sql" 2>/dev/null || true
ddev mysql -uroot -proot db < "$ROOT/scripts/announcements.sql" 2>/dev/null || true
ddev mysql -uroot -proot db < "$ROOT/scripts/journal-content.sql" 2>/dev/null || true

# Bersihkan cache OJS.
ddev exec bash -c 'cd /var/www/html && rm -rf ojs/cache && mkdir -p ojs/cache'

echo "Instal selesai. Admin: admin / akdisi-admin"
