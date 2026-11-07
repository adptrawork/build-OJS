# JRDC Theme for OJS 3.3

**Modern Academic Editorial** theme based on the UI prototype of *Jurnal Ekonomi dan Bisnis JRDC*.

- Warm burnt-orange primary (`#c2410c`)
- Deep navy hero banner
- Full dark mode with persistence
- Fully configurable from **Settings → Website → Appearance**
- Uses default OJS data (current issue, announcements, journal description, galleys, DOIs, etc.)

## Requirements

- Open Journal Systems **3.3.x**
- PHP 7.3+ / 8.x (sesuai OJS 3.3)

## Installation

### Cara 1 — Upload Plugin

1. Zip folder `jrdc` (atau rename folder ini menjadi `jrdc`).
2. Login sebagai Administrator / Journal Manager.
3. Buka **Settings → Website → Plugins → Upload A New Plugin**.
4. Upload file `.tar.gz` atau `.zip`.
5. Aktifkan plugin **JRDC Theme**.
6. Buka **Settings → Website → Appearance → Theme** → pilih **JRDC Theme** → Save.

### Cara 2 — Manual

```bash
# Dari root instalasi OJS
cp -r jrdc-theme plugins/themes/jrdc
chown -R www-data:www-data plugins/themes/jrdc   # sesuaikan user web server
```

Lalu aktifkan seperti langkah 5–6 di atas.

## Theme Options (Admin Panel)

Setelah memilih JRDC Theme, refresh halaman Appearance. Anda akan melihat opsi:

| Option | Default | Keterangan |
|--------|---------|------------|
| **Primary Colour** | `#c2410c` | Warna utama (tombol, badge, active state) |
| **Primary Hover Colour** | `#9a3412` | Warna hover |
| **Hero Navy Colour** | `#0b2038` | Latar hero beranda |
| **Dark Mode Navy** | `#071424` | Navy untuk dark mode |
| **Dark Mode Toggle** | Enable | Tampilkan saklar dark/light di header |
| **Show Issue Cover in Hero** | Yes | Cover issue di dalam hero |
| **Hero Eyebrow Text** | `JURNAL ILMIAH • …` | Label kecil di atas judul |
| **Show Journal Description** | Yes | Blok “Tentang Jurnal” di beranda |
| **Show Announcements** | Yes | Pengumuman di beranda |
| **Number of Announcements** | 3 | Jumlah item pengumuman |
| **Show Current Issue Articles** | Yes | Daftar artikel issue terkini |
| **Sidebar Position** | Right | Right / Left / Hide |
| **Base Font Size** | 16 | Ukuran font root (px) |
| **Load Google Fonts** | Yes | Inter + Merriweather |

Semua warna dan opsi ini langsung mempengaruhi CSS variables dan template tanpa perlu edit kode.

## Struktur File

```
jrdc/
├── index.php
├── JRDCThemePlugin.inc.php   # Plugin class + options
├── version.xml
├── README.md
├── locale/
│   ├── en_US/locale.po
│   └── id_ID/locale.po
├── styles/
│   ├── fonts.css
│   └── index.css             # Design system lengkap
├── js/
│   └── main.js               # Dark mode + mobile nav
└── templates/frontend/
    ├── components/
    │   ├── header.tpl
    │   └── footer.tpl
    ├── objects/
    │   └── article_summary.tpl
    └── pages/
        ├── indexJournal.tpl  # Homepage
        └── article.tpl       # Article landing
```

Tema ini **child theme** dari Default Theme (`setParent('defaultthemeplugin')`). Template yang tidak di-override akan memakai template Default Theme, sehingga tetap kompatibel dengan update OJS.

## Menyesuaikan Lebih Lanjut

1. **Warna & tipografi** → cukup ubah di Appearance.
2. **Logo** → Settings → Website → Appearance → Page Header Logo.
3. **Homepage content** → Additional Homepage Content + Journal Description.
4. **Menu** → Settings → Website → Setup → Navigation Menus (Primary & Footer).
5. **Custom CSS** → Settings → Website → Appearance → Journal Style Sheet (upload file CSS tambahan).

## Catatan Desain

Desain mengikuti prototype di:

https://github.com/adptrawork/build-OJS/tree/main/docs/prototype

- Container max-width `80rem` (7xl)
- Grid 8+4 kolom
- Kartu dengan border soft + radius 1.5rem
- Badge Open Access & Peer Reviewed
- Galley button berbentuk pill
- Sticky header + sticky sidebar

## Lisensi

GNU GPL v3 (sama dengan OJS).

---

Dibuat untuk Jurnal Ekonomi dan Bisnis JRDC / Adptrawork build-OJS.
