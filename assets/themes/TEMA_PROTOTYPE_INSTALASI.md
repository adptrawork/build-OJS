# Tema Prototype untuk OJS 3.3

Tema ini adalah konversi dari prototype statis (`docs/prototype/`) ke tema OJS 3.3 yang berfungsi penuh. Menggunakan Tailwind CSS dan vanilla JavaScript, dengan warna dan tipografi sesuai prototype asli.

## Struktur Direktori

```
plugins/themes/prototype/
├── PrototypeThemePlugin.inc.php      # Kelas tema utama
├── index.php                         # Wrapper plugin
├── version.xml                       # Versi plugin
├── settings.xml                      # Pengaturan default
├── tailwind.config.js                # Konfigurasi Tailwind
├── styles/
│   ├── src/jrdc.css                  # Source CSS (Tailwind directives)
│   └── jrdc.css                      # CSS built
├── js/
│   └── jrdc.js                       # JavaScript interaktif
├── templates/                        # Template Smarty
│   ├── frontend/components/
│   │   ├── header.tpl
│   │   ├── headerHead.tpl
│   │   └── footer.tpl
│   ├── frontend/pages/
│   │   └── indexJournal.tpl          # Template beranda kustom
│   ├── common/
│   │   └── sidebar.tpl
│   └── plugins/generic/staticPages/templates/content.tpl
└── locale/                           # Terjemahan
    ├── en_US/
    │   └── locale.po
    └── id_ID/
        └── locale.po
```

## Fitur

1. **Desain sesuai prototype**: Warna primer `#c2410c`, hero `#0b2038`, font Geist + Merriweather
2. **Admin-configurable**: 22 opsi pengaturan di panel admin (warna, hero, footer, sidebar, dll)
3. **Responsif**: Breakpoint 1024px/768px, mobile navigation
4. **Dark mode**: Toggle dengan localStorage persistence
5. **Konten dinamis**: Hero, about card, features, footer, sidebar links dapat diatur via admin
6. **Kompatibel OJS 3.3**: Menggunakan API non-namespaced (`.inc.php`, `HookRegistry`)

## Instalasi

### 1. Upload tema
```bash
# Upload folder 'prototype' ke:
# /var/www/html/ojs-jrdc/plugins/themes/prototype/
```

### 2. Install via CLI (jika tools tersedia)
```bash
php tools/installPluginVersion.php plugins/themes/prototype/version.xml
```

### 3. Aktifkan tema
- Login sebagai admin
- Settings → Website → Appearance
- Pilih "Prototype" dari dropdown Theme
- Save

### 4. Konfigurasi konten
- Masuk ke Settings → Website → Appearance → Prototype Theme
- Isi pengaturan:
  - **Hero**: Kicker, Title, Description, Facts
  - **Warna**: Primary Colour, Hero Colour
  - **Footer**: Title, Description, Links, Email, Address
  - **Sidebar**: Toggle sections, About text, Links, Stats items
  - **Navigasi**: Extra links (format: Label | URL | Note)

### 5. Halaman statis tambahan (jika diperlukan)
Install plugin **StaticPages** dari plugin gallery, lalu buat halaman dengan slug:
- `guidelines` → Guidelines for Authors
- `policies` → Editorial Policies
- `statistics` → Journal Statistics

## Catatan

- Tema menggunakan core OJS templates untuk halaman standar (about, announcements, article, issue, search, editorialTeam, userLogin, userRegister, contact, submissions)
- Halaman kustom (guidelines, policies, statistics) memerlukan plugin StaticPages
- CSS built (`styles/jrdc.css`) sudah termasuk Tailwind utilities + komponen kustom
- Warna admin diterapkan via CSS variables (`--jrdc-primary`, `--jrdc-hero`)
- Error handling: nilai kosong fallback ke default, warna invalid difilter

## Troubleshooting

### HTTP 500 setelah instalasi
Cek error log:
- `cache/error.log`
- `ddev logs -s web`

Kemungkinan penyebab:
1. **Missing CacheManager.inc.php** → Instalasi OJS rusak, perlu restore
2. **Parse error di file tema** → Periksa `PrototypeThemePlugin.inc.php` line 78
3. **Cache OJS** → Hapus `cache/*` dan `cache/t_compile/*`

### Tema tidak muncul di dropdown
- Pastikan `versions` table memiliki row untuk `product='prototype'` dengan `current=1`
- Pastikan `plugin_settings` memiliki `enabled=1` untuk `plugin_name='prototypethemeplugin'`
- Pastikan `journal_settings.themePluginPath='prototype'`

## Backup

Backup tema tersedia di:
- `/mnt/DiskD/Workspace/Backups/ojs-jrdc/2026-11-06-pre-3.3/`

## Kontak

- **DB seeded**: Data prototype (journal settings, 1 section, 1 issue, 3 articles, 3 announcements) sudah ada
- **URL**: `https://jrdc-ojs.ddev.site:8443/index.php/jrdc/`
- **Path journal**: `jrdc`