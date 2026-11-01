# Akdisi OJS 3.5 Development & Theme Workspace

Repositori ini mengelola sistem jurnal ilmiah **Akdisi** berbasis **Open Journal Systems (OJS) 3.5.0-5** dengan arsitektur pemisahan kode kustom (Clean Separation Pattern) di lingkungan **DDEV** (PHP 8.3, MariaDB 11.8).

---

## 📌 Ringkasan Cepat & Kredensial

| Layanan / Halaman | URL Akses | Keterangan |
|---|---|---|
| **Beranda Jurnal (EN)** | [https://your-domain.example:8443/index.php/JRDC/en](https://your-domain.example:8443/index.php/JRDC/en) | Halaman beranda utama |
| **Login Admin** | [https://your-domain.example:8443/index.php/JRDC/en/login](https://your-domain.example:8443/index.php/JRDC/en/login) | **User:** `admin` \| **Pass:** `akdisi-admin` |
| **Debug Slot Layout** | [https://your-domain.example:8443/index.php/JRDC/en?slots=1](https://your-domain.example:8443/index.php/JRDC/en?slots=1) | Visualisasi slot modular S-HOME-XX |
| **Sitemap XML** | [https://your-domain.example:8443/index.php/JRDC/sitemap.xml](https://your-domain.example:8443/index.php/JRDC/sitemap.xml) | Peta situs XML SEO |
| **Mailhog (Web Inbox)** | [https://your-domain.example:8026](https://your-domain.example:8026) | Monitoring pengiriman email OJS |

---

## 🏗️ Arsitektur Pemisahan Kode

Kode kustom disimpan **terpisah di luar folder core OJS upstream** (`ojs/` diabaikan oleh `.gitignore`):

```
/mnt/DiskD/Projects/ojs/
├── plugins/themes/akdisi/    <-- Tema Akdisi (Maroon / Burgundy, struktur modular blok)
├── plugins/generic/akdisiSeo/<-- Plugin SEO (Sitemap XML, Canonical, OG Tags, JSON-LD)
├── ojs/                      <-- Core OJS 3.5 upstream PKP (terhubung via symlink)
├── scripts/                  <-- Skrip build, reset, registrasi, dan seed database
├── import/xml/               <-- Sampel file Native XML untuk latihan import mandiri
└── docs/TUTORIAL.md          <-- Master documentation (panduan build, operasional & import)
```

---

## 🚀 Perintah Cepat

```bash
# 1. Reset total OJS ke kondisi awal bersih (0 artikel, 0 terbitan)
./scripts/reset.sh

# 2. Update instan tema & plugin kustom (sinkronisasi file, DB & cache tanpa re-upload)
./scripts/reload-plugins.sh

# 3. Paketkan ulang arsip & naikkan versi build untuk upgrade via Web UI
./scripts/package.sh --bump

# 4. Praktek import manual artikel/issue (CLI)
ddev exec bash -c 'cd /var/www/html/ojs && php tools/importExport.php NativeImportExportPlugin import ../import/xml/issue-937.xml JRDC --user_name admin'

# 5. Bersihkan cache template OJS
ddev exec bash -c 'cd /var/www/html && rm -rf ojs/cache && mkdir -p ojs/cache'
```

---

## 📦 Paket Plugin & Pola Update (Web UI Upload)

Arsip tema dan plugin siap dipasang tersedia di direktori `dist/`:

- `dist/akdisi-theme.tar.gz` & `dist/akdisi-theme.zip` — Tema Akdisi
- `dist/akdisi-seo.tar.gz` & `dist/akdisi-seo.zip` — Plugin SEO Akdisi

### 🔄 Pola Update yang Didukung:
1. **Update via Web UI (OJS Production)**: Jalankan `./scripts/package.sh --bump` untuk menaikkan versi, lalu masuk ke **Installed Plugins** → klik plugin → klik tombol **Upgrade** (OJS mewajibkan versi baru lebih tinggi daripada versi lama).
2. **Update Instan via CLI (Local Development)**: Jalankan `./scripts/reload-plugins.sh`. Kode kustom langsung aktif tanpa perlu upload ulang.
3. **Reset Total**: Jalankan `./scripts/reset.sh` jika ingin mengulang dari titik nol.

---

## 📖 Dokumentasi Lengkap

Panduan mendalam yang mencakup:
- Langkah demi langkah membangun OJS dari nol sampai jadi
- Alur kerja editorial (Submission, Review, Copyediting, Production)
- Cara membuat dan menerbitkan issue baru
- Panduan import artikel manual (CLI & GUI)
- Konfigurasi 20 halaman statis dan menu navigasi
- Manajemen blok kustom dan troubleshooting

Dapat dibaca secara lengkap di berkas: **[docs/TUTORIAL.md](docs/TUTORIAL.md)**.
