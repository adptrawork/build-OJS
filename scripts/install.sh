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
printf 'en\nid\n\n/var/www/html/ojs/files\nadmin\njeki-admin\njeki-admin\nadmin@jeki.dev\nmysqli\ndb\ndb\ndb\ndb\njeki-ojs.ddev.site/index.php/JEKI/oai\nn\ny\n' \
    | ddev exec -j php ojs/tools/install.php >/dev/null 2>&1 || true

# Bug OJS Installer: baris allowed_hosts yang kita tulis manual semua ke-escape
# ("[\"\"]") sehingga daftar host jadi kosong → 400 host not allowed. Kembali
# tulis JSON yang benar.
sed -i 's|^allowed_hosts = .*|allowed_hosts = ["jeki-ojs.ddev.site"]|' "$ROOT/ojs/config.inc.php"

# Permission folder yang wajib writable (dilakukan juga setup.sh tapi pastikan).
ddev exec -j chmod 777 /var/www/html/ojs/config.inc.php /var/www/html/ojs/cache \
    /var/www/html/ojs/public /var/www/html/ojs/files 2>/dev/null || true

ddev exec -j php /var/www/html/scripts/create-journal.php || true

# Symlink theme & plugin milik project ke dalam ojs/.
ln -sfn ../../../plugins/themes/jeki "$ROOT/ojs/plugins/themes/jeki"
ln -sfn ../../../plugins/generic/jekiSeo "$ROOT/ojs/plugins/generic/jekiSeo"

ddev exec -j php /var/www/html/scripts/register-plugins.php >/dev/null 2>&1 || true

echo "Instal selesai. Admin: admin / jeki-admin"
