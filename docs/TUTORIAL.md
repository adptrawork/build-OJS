# Panduan Lengkap: Membangun, Mengoperasikan & Mengembangkan OJS 3.5 dari Nol dengan Tema & Plugin Akdisi

Dokumen ini adalah **buku panduan induk (master guide)** untuk membangun, mengonfigurasi, mengoperasikan, dan mengembangkan sistem jurnal ilmiah berbasis **Open Journal Systems (OJS) 3.5.0-5** dengan identitas **Akdisi** (`https://akdisi.my.id/`).

Semua arsitektur, tautan URL, kredensial, panduan alur kerja editorial, cara membangun dari awal, hingga praktek import mandiri dijelaskan secara mendetail di sini.

---

## DAFTAR ISI

1. [Informasi Server, URL & Kredensial Akun](#1-informasi-server-url--kredensial-akun)
2. [Arsitektur Pemisahan: Kode Kustom vs Upstream OJS](#2-arsitektur-pemisahan-kode-kustom-vs-upstream-ojs)
3. [Panduan Langkah-demi-Langkah: Membangun OJS dari Nol](#3-panduan-langkah-demi-langkah-membangun-ojs-dari-nol)
4. [Anatomi Desain Tema Akdisi (Maroon / Burgundy)](#4-anatomi-desain-tema-akdisi-maroon--burgundy)
5. [Fitur SEO & Metadata Akademik (Plugin akdisiSeo)](#5-fitur-seo--metadata-akademik-plugin-akdisiseo)
6. [Panduan Praktek Mandiri: Import Artikel & Terbitan (Native XML)](#6-panduan-praktek-mandiri-import-artikel--terbitan-native-xml)
7. [Panduan Penggunaan OJS untuk Editor & Pengelola Jurnal](#7-panduan-penggunaan-ojs-untuk-editor--pengelola-jurnal)
8. [Pengelolaan Halaman Statis & Menu Navigasi](#8-pengelolaan-halaman-statis--menu-navigasi)
9. [Pengelolaan Blok Kustom (Custom Blocks)](#9-pengelolaan-blok-kustom-custom-blocks)
10. [Operasional, Pemeliharaan & Troubleshooting](#10-operasional-pemeliharaan--troubleshooting)

---

## 1. Informasi Server, URL & Kredensial Akun

### Lingkungan Server (Local Development via DDEV)
- **Web Server**: Nginx-FPM (PHP 8.3)
- **Database Server**: MariaDB 11.8
- **OJS Core Version**: 3.5.0-5 (Official Release PKP)
- **Base Domain**: `https://jeki-ojs.ddev.site:8443`

### Daftar URL Lengkap

| Layanan / Halaman | URL Akses | Keterangan |
|---|---|---|
| **Beranda Jurnal (EN)** | `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/en` | Bahasa Inggris (Primary Locale) |
| **Beranda Jurnal (ID)** | `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/id` | Bahasa Indonesia |
| **Login Dashboard Admin** | `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/en/login` | Portal masuk staf editorial |
| **Debug Slot Visual** | `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/en?slots=1` | Menampilkan penanda batas komponen S-HOME-XX |
| **Sitemap XML** | `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/sitemap.xml` | Peta situs XML dinamis untuk crawler Google Scholar / Bing |
| **OAI-PMH Endpoint** | `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/oai` | Protokol pemanenan metadata (OAI 2.0) |
| **Email Inbox (Mailhog)**| `https://jeki-ojs.ddev.site:8026` | Monitoring email kiriman OJS saat penugasan reviewer/notifikasi |
| **phpMyAdmin** | Akses via perintah terminal: `ddev phpmyadmin` | GUI Manajemen database MySQL di browser |

### Kredensial Akun Pengelola

| Parameter | Nilai Kredensial |
|---|---|
| **Username** | `admin` |
| **Password** | `akdisi-admin` |
| **Email** | `admin@akdisi.my.id` |
| **Hak Akses (Roles)** | Site Administrator, Journal Manager, Editor, Production Editor, Reviewer, Author |

> **Catatan Keamanan**: Untuk lingkungan produksi (live production server), segera ubah password akun admin melalui menu **Profile** → **Change Password** dan atur secret salt di file `config.inc.php`.

---

## 2. Arsitektur Pemisahan: Kode Kustom vs Upstream OJS

Masalah klasik pengembang OJS adalah memodifikasi berkas langsung di dalam folder core OJS, yang menyebabkan pembaruan versi (upgrade) menjadi mimpi buruk karena kode tertimpa. 

Repositori ini menerapkan **Clean Separation Pattern**:

```
/mnt/DiskD/Projects/ojs/
│
├── plugins/                           <=== DISIMPAN TERPISAH (VERSION CONTROL GIT)
│   ├── themes/
│   │   └── akdisi/                    # Seluruh template, style, dan script tema kita
│   │       ├── AkdisiThemePlugin.php  # Class Theme OJS 3.5
│   │       ├── styles/akdisi.css      # CSS token, layout, animasi typewriter
│   │       ├── js/slots.js            # Slot debug highlight & scroll back-to-top
│   │       ├── templates/frontend/components/ # File Smarty per blok mandiri
│   │       └── templates/frontend/pages/      # Override halaman indeks beranda
│   │
│   └── generic/
│       └── akdisiSeo/                 # Plugin SEO mandiri
│           ├── AkdisiSeoPlugin.php    # Hook ke TemplateManager & PageHeader
│           ├── AkdisiSeoHandler.php   # Output XML sitemap terbitan & artikel
│           └── version.xml
│
├── ojs/                               <=== VENDOR UPSTREAM PKP (DIABAIKAN OLEH GIT)
│   ├── config.inc.php                 # Konfigurasi sistem (DB, Host, Path)
│   ├── plugins/themes/
│   │   ├── akdisi -> ../../../plugins/themes/akdisi  [SYMLINK KE FOLDER KITA]
│   │   ├── default/                   # Tema bawaan PKP
│   │   └── classic/                   # Tema classic resmi PKP
│   └── plugins/generic/
│       └── akdisiSeo -> ../../../plugins/generic/akdisiSeo [SYMLINK KE FOLDER KITA]
│
├── scripts/                           <=== SKRIP BUILD & RESET OTOMATIS
│   ├── setup.sh                       # Download & ekstraksi OJS 3.5 resmi
│   ├── install.sh                     # Instalasi non-interaktif
│   ├── reset.sh                       # Reset instan ke state 0 (bersih)
│   ├── create-journal.php             # Bootstrap context jurnal AKDISI via Facade OJS 3.5
│   ├── register-plugins.php           # Injeksi plugin ke DB versions
│   ├── static-pages.sql               # 20 halaman statis standar akreditasi
│   └── akdisi-custom-blocks.sql       # Data dummy pengindeks, stats, tim editorial
│
├── import/                            <=== DATA IMPORT & LATIHAN
│   └── xml/
│       └── issue-937.xml              # Native XML 1 issue + 5 artikel siap import
│
└── docs/
    └── TUTORIAL.md                    # Dokumentasi ini
```

---

## 3. Panduan Langkah-demi-Langkah: Membangun OJS dari Nol

Berikut cara membangun seluruh sistem ini dari awal pada mesin baru atau workstation lain:

### Langkah 1: Persiapan Prasyarat Lingkungan
Pastikan workstation memiliki:
- [Docker](https://docs.docker.com/engine/install/) & Docker Compose
- [DDEV](https://ddev.readthedocs.io/en/stable/users/install/ddev-installation/) (v1.23 atau lebih baru)
- Git & cURL

### Langkah 2: Clone Repositori Proyek
```bash
git clone https://github.com/adptrawork/build-OJS.git /mnt/DiskD/Projects/ojs
cd /mnt/DiskD/Projects/ojs
```

### Langkah 3: Menjalankan Lingkungan DDEV
Konfigurasi DDEV sudah disiapkan di `.ddev/config.yaml` dengan docroot `ojs`. Jalankan:
```bash
ddev start
```

### Langkah 4: Mengunduh Core OJS 3.5 Resmi Upstream
Jalankan skrip pembantu untuk mengunduh rilis resmi PKP OJS 3.5.0-5:
```bash
./scripts/setup.sh
```
*Skrip ini akan mengunduh tarball OJS resmi, mengekstraknya ke direktori `ojs/`, membuat folder penyimpanan privat `ojs/files`, dan menerapkan patch lewati unduhan dataset ROR (agar instalasi lokal selesai dalam hitungan detik).*

### Langkah 5: Reset & Instalasi Bersih Otomatis
Jalankan skrip reset sekali perintah:
```bash
./scripts/reset.sh
```
*Proses ini akan:*
1. Mengosongkan dan membuat ulang database `db`.
2. Menghapus file sisa cache dan upload sebelumnya.
3. Menjalankan OJS installer non-interaktif via CLI.
4. Memperbaiki daftar `allowed_hosts = ["jeki-ojs.ddev.site"]` di `config.inc.php`.
5. Menjalankan `scripts/create-journal.php` untuk membuat Jurnal Akdisi.
6. Membangun symlink folder kustom `plugins/themes/akdisi` dan `plugins/generic/akdisiSeo` ke dalam `ojs/plugins/`.
7. Mendaftarkan versi plugin ke tabel `versions`.
8. Mengaktifkan tema `akdisi` dan plugin `akdisiseoplugin` di database.
9. Memuat data awal 20 static pages dan custom blocks.
10. Membersihkan cache template Smarty.

Selesai! Jurnal Akdisi langsung aktif dan siap diakses di browser.

---

## 4. Anatomi Desain Tema Akdisi (Maroon / Burgundy)

Tema Akdisi dibangun sebagai *child theme* dari tema default OJS, namun seluruh tampilannya didefinisikan ulang secara modern mengikuti estetika clean editorial dan brand **Akdisi**:

### Palet Warna & Token Desain (`plugins/themes/akdisi/styles/akdisi.css`)
- **Primary Accent (`--akdisi-colour-accent`)**: `#af2e4d` (Warna Maroon / Burgundy khas Akdisi)
- **Soft Accent (`--akdisi-colour-accent-soft`)**: `#fce7eb` (Badge dan highlight lembut)
- **Ink Text (`--akdisi-colour-ink`)**: `#1a0f12` (Tipografi kontras tinggi yang nyaman dibaca)
- **Muted Text (`--akdisi-colour-ink-soft`)**: `#6b555c` (Keterangan tanggal, penulis, volume)
- **Surface Body (`--akdisi-colour-surface`)**: `#ffffff` (Latar belakang konten utama)
- **Surface Alternate (`--akdisi-colour-surface-alt`)**: `#faf7f8` (Latar belakang strip statistik dan sidebar)

### Efek Animasi Typewriter (CSS Murni)
Di bagian Hero, deskripsi jurnal menampilkan animasi mengetik (*typewriter*) yang halus tanpa dependensi pustaka JavaScript pihak ketiga:
```css
.akdisi-typewriter__text {
  display: inline-block;
  overflow: hidden;
  white-space: nowrap;
  border-right: 2px solid var(--akdisi-colour-accent);
  animation:
    akdisi-typewriter 3s steps(60, end) 1s 1 normal both,
    akdisi-caret 0.75s step-end infinite;
}
```

### Pemisahan Komponen Beranda
Setiap komponen di halaman beranda memiliki file template Smarty `.tpl` sendiri di folder `plugins/themes/akdisi/templates/frontend/components/`:

```
templates/frontend/components/
├── headerHead.tpl           # Injeksi <head>, canonical, OG tags, JSON-LD, hapus generator meta
├── hero.tpl                 # Slot S-HOME-02/03/04: Judul Jurnal, Typewriter Tagline, Call-to-Action
├── statsStrip.tpl           # Slot S-HOME-12: Statistik Review Time, Acceptance Rate, Total Issues
├── aboutJournal.tpl         # Slot S-HOME-05: Profil ringkas jurnal
├── indexers.tpl             # Slot S-HOME-06: Logo terindeks (Google Scholar, DOAJ, Sinta, Scopus)
├── latestBySection.tpl      # Slot S-HOME-07: Daftar 6 artikel terbit terbaru berbentuk kartu
├── currentIssue.tpl         # Slot S-HOME-08: Terbitan terkini (Current Issue) lengkap dengan cover
├── sidebar.tpl              # Slot S-HOME-09/10/11: Focus & Scope, Editorial Team, Download Template
├── publicationTimeline.tpl  # Slot S-HOME-13: 6 Langkah Alur Penerbitan dari Submit hingga Publish
├── floatingActions.tpl      # Slot S-HOME-15: Floating WhatsApp Contact & Back to Top button
├── backToTop.tpl            # Tombol kembali ke atas otomatis
└── footer.tpl               # Slot S-HOME-14: Hak cipta, lisensi Creative Commons, kontak sekretariat
```

---

## 5. Fitur SEO & Metadata Akademik (Plugin akdisiSeo)

Plugin `plugins/generic/akdisiSeo/` berfungsi otomatis di latar belakang untuk memastikan jurnal memenuhi standar indeksasi mesin pencari ilmiah:

1. **Peta Situs Dinamis (`/sitemap.xml`)**:
   Dapat diakses di `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/sitemap.xml`. Menghasilkan XML sitemap standar yang memuat URL beranda, setiap nomor terbitan (issues), dan seluruh artikel aktif yang diterbitkan.
2. **Penghapusan Meta Generator**:
   Menghapus tag `<meta name="generator" content="Open Journal Systems ...">` bawaan PKP agar versi sistem tidak terekspos ke publik demi keamanan.
3. **Canonical URLs & Open Graph Tags**:
   Menyuntikkan canonical link absolut dan tag media sosial (`og:title`, `og:description`, `og:type`, `og:url`, `og:site_name`, `twitter:card`) di beranda dan halaman artikel.
4. **Structured Data JSON-LD Schema.org**:
   - Di Beranda: Menyuntikkan schema `@type: Periodical` dengan nama jurnal dan organisasi penerbit.
   - Di Halaman Artikel: Menyuntikkan schema `@type: ScholarlyArticle` lengkap dengan judul artikel, nama penulis, afiliasi, tanggal terbit, dan tautan PDF.
5. **Google Scholar Meta Tags**:
   Core OJS secara native mengeluarkan `citation_title`, `citation_author`, `citation_publication_date`, `citation_pdf_url` yang bekerja harmonis dengan tema Akdisi.

---

## 6. Panduan Praktek Mandiri: Import Artikel & Terbitan (Native XML)

Dalam repositori ini, telah disiapkan sampel file XML valid:
`import/xml/issue-937.xml` (berisi 1 Issue *Vol. 1 No. 1, Januari 2011* lengkap dengan 5 artikel, daftar pustaka, afiliasi penulis, dan tautan unduhan PDF).

Anda dapat mencoba melakukan import data menggunakan salah satu dari dua metode di bawah ini:

### Cara 1: Import via Baris Perintah CLI (Sangat Disarankan)
Cara ini paling cepat, tidak memiliki risiko batas waktu browser (timeout), dan menghasilkan log proses yang jelas:

1. Pastikan Anda berada di direktori project:
   ```bash
   cd /mnt/DiskD/Projects/ojs
   ```
2. Jalankan perintah import melalui DDEV:
   ```bash
   ddev exec bash -c 'cd /var/www/html/ojs && php tools/importExport.php NativeImportExportPlugin import ../import/xml/issue-937.xml AKDISI --user_name admin'
   ```
3. Bersihkan cache template OJS:
   ```bash
   ddev exec bash -c 'cd /var/www/html && rm -rf ojs/cache && mkdir -p ojs/cache'
   ```
4. Buka beranda `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/en`. Artikel dan terbitan langsung muncul!

---

### Cara 2: Import via Tampilan Web GUI (Dashboard OJS)
Untuk merasakan alur kerja pengguna non-teknis:

1. Buka browser dan login ke:
   `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/en/login`
   - User: `admin` | Pass: `akdisi-admin`
2. Di menu samping kiri, klik **Tools** → **Import/Export**.
3. Klik **Native XML Plugin**.
4. Masuk ke tab **Import**:
   - Klik **Choose File** (Pilih Berkas).
   - Arahkan ke file `/mnt/DiskD/Projects/ojs/import/xml/issue-937.xml`.
   - Klik tombol biru **Import**.
5. Tunggu sistem memvalidasi struktur XML. Saat selesai, sistem akan menampilkan notifikasi daftar naskah yang berhasil diimpor.
6. Masuk ke menu **Issues** → **Back Issues** untuk melihat issue yang baru saja masuk.

---

## 7. Panduan Penggunaan OJS untuk Editor & Pengelola Jurnal

OJS mengimplementasikan alur kerja penerbitan ilmiah berstandar peer-review dalam 4 tahapan utama:

```
[Penulis Mengirim Naskah]
           │
           ▼
┌─────────────────────────┐
│ 1. Submission (Antrean) │ ──> Editor menyeleksi naskah (Desk Reject / Send to Review)
└─────────────────────────┘
           │
           ▼
┌─────────────────────────┐
│ 2. Review (Peer Review) │ ──> Editor menunjuk Reviewer (Double-Blind)
└─────────────────────────┘     Reviewer memberi komentar & rekomendasi (Accept / Revisions / Decline)
           │
           ▼
┌─────────────────────────┐
│ 3. Copyediting (Edit)   │ ──> Penyuntingan tata bahasa, format sitasi, dan layout naskah
└─────────────────────────┘
           │
           ▼
┌─────────────────────────┐
│ 4. Production (Produksi)│ ──> Unggah Galley PDF akhir, tetapkan nomor halaman, DOI
└─────────────────────────┘
           │
           ▼
[Terbitkan ke dalam Terbitan / Publish Issue]
```

### A. Alur Menangani Naskah Masuk (Editorial Workflow)
1. Buka menu **Submissions** di dashboard editorial.
2. Di tab **My Queue** atau **Unassigned**, klik naskah yang masuk.
3. **Tahap Submission**:
   - Periksa kelengkapan file naskah dan kemiripan plagiarisme.
   - Klik **Send to Review** untuk memajukan naskah ke proses penelaahan sejawat.
4. **Tahap Review**:
   - Klik **Add Reviewer**. Pilih reviewer yang tersedia atau undang reviewer luar melalui email.
   - Tentukan tenggat waktu penelaahan (biasanya 2-4 minggu).
   - Setelah reviewer mengirim telaah, editor mengambil keputusan (**Record Decision**):
     * *Accept Submission* (Diterima)
     * *Revisions Required* (Perlu revisi minor/mayor)
     * *Resubmit for Review* (Kirim ulang untuk ditinjau ulang)
     * *Decline Submission* (Ditolak)
5. **Tahap Copyediting**:
   - Naskah yang diterima dikirim ke tahap copyediting (**Send to Copyediting**).
   - Di sini file diperiksa gaya selingkungnya dan diubah menjadi naskah final bersih.
6. **Tahap Production**:
   - Klik **Send to Production**.
   - Di bagian **Galleys**, klik **Add Galley**. Isi label dengan `PDF`, lalu unggah berkas PDF final artikel.
   - Tetapkan rentang halaman (misal: `1-12`) di tab **Publication** → **Issue**.

---

### B. Membuat & Menerbitkan Issue Baru (Issue Management)
1. Buka menu **Issues** → **Future Issues**.
2. Klik tombol **Create Issue**.
3. Masukkan data identitas terbitan:
   - **Volume**: Misal `2`
   - **Number**: Misal `1`
   - **Year**: Misal `2026`
   - **Title**: Misal `Volume 2 No. 1, Juni 2026`
4. Unggah gambar cover terbitan jika ada di bagian **Issue Cover**.
5. Klik **Save**.
6. Untuk memasukkan artikel ke dalam issue ini:
   - Buka naskah di menu **Submissions**, masuk ke tab **Publication** → **Issue**.
   - Pilih issue yang baru dibuat pada dropdown **Assign to Issue**.
   - Klik **Save**.
7. Untuk mempublikasikan issue ke publik:
   - Kembali ke **Issues** → **Future Issues**.
   - Klik panah biru di sebelah issue, lalu pilih **Publish Issue**.
   - Issue langsung terbit dan artikel otomatis tayang di beranda!

---

## 8. Pengelolaan Halaman Statis & Menu Navigasi

Jurnal Akdisi telah dibekali dengan **20 rute halaman statis** penting sesuai kriteria akreditasi SINTA & DOAJ:

```
about, focus-and-scope, editorial-team, reviewer, reviewer-guide,
publication-ethics, peer-review-process, open-access-statement,
copyright-and-license, plagiarism-policy, indexing, author-guidelines,
archive-policy, author-fees, contact-us, generative-ai, privacy-policy,
submission-preparation, loa, faq
```

### Cara Mengedit Konten Halaman Statis
1. Login ke akun admin OJS.
2. Buka menu **Settings** → **Website** → **Static Pages**.
3. Cari halaman yang ingin Anda perbarui (misalnya `author-guidelines` atau `editorial-team`).
4. Klik tombol panah expand di samping nama halaman, lalu klik **Edit**.
5. Gunakan editor visual TinyMCE untuk memasukkan teks pedoman, menyisipkan tabel, atau menambahkan gambar.
6. Klik **Save**. Halaman langsung terbarui di alamat URL publiknya:
   `https://jeki-ojs.ddev.site:8443/index.php/AKDISI/en/author-guidelines`

---

### Cara Mengatur Menu Navigasi (Navigation Menus)
1. Buka **Settings** → **Website** → **Navigation Menus**.
2. Di tab **Navigation Menu Items**, Anda dapat menambahkan item baru (**Add Item**):
   - Masukkan judul menu (contoh: *Author Guidelines*).
   - Pada kolom **Navigation Menu Item Type**, pilih **Static Page**.
   - Pilih halaman statis yang sesuai dari dropdown.
   - Klik **Save**.
3. Pindah ke tab **Navigation Menus**:
   - Pilih menu yang ingin diedit (misal: **User Menu** atau **Primary Navigation Menu**), klik **Edit**.
   - Di daftar *Assigned Menu Items*, seret (*drag and drop*) item yang baru dibuat ke posisi urutan yang Anda inginkan (bisa dijadikan submenu dengan menggesernya sedikit ke kanan).
   - Klik **Save**.

---

## 9. Pengelolaan Blok Kustom (Custom Blocks)

Tema Akdisi membaca data komponen dinamis beranda langsung dari tabel `journal_settings` dengan konteks `journal_id=1`.

### Daftar Kunci Pengaturan Blok:

| Nama Pengaturan | Slot Komponen | Format Nilai | Contoh Nilai |
|---|---|---|---|
| `akdisiIndexers` | **S-HOME-06** (Lembaga Pengindeks) | Teks HTML | `<a href="https://scholar.google.com"><img src="..." alt="Google Scholar"/></a>` |
| `akdisiFocusScope` | **S-HOME-09** (Focus & Scope Sidebar)| Teks HTML | `<p>Jurnal Akdisi fokus pada riset sistem informasi dan transformasi bisnis...</p>` |
| `akdisiEditorialTeam` | **S-HOME-10** (Dewan Editor Sidebar) | Teks HTML | `<ul class="akdisi-editor-list"><li><strong>Editor in Chief:</strong> Dr. ...</li></ul>` |
| `akdisiTemplateFile` | **S-HOME-11** (Download Template) | URL String | `https://jeki-ojs.ddev.site:8443/public/journals/1/template.docx` |
| `akdisiStats` | **S-HOME-12** (Strip Statistik) | Format JSON | `{"avgReviewDays":42,"acceptanceRate":28}` |
| `akdisiContactUrl` | **S-HOME-15** (Floating Contact WhatsApp)| URL String | `https://wa.me/6281234567890` |

### Memperbarui Blok Kustom secara Praktis
Anda cukup mengedit file `scripts/akdisi-custom-blocks.sql` menggunakan teks editor favorit Anda, kemudian jalankan perintah:

```bash
ddev mysql -uroot -proot db < scripts/akdisi-custom-blocks.sql
ddev exec bash -c 'cd /var/www/html && rm -rf ojs/cache && mkdir -p ojs/cache'
```

---

## 10. Operasional, Pemeliharaan & Troubleshooting

### Ringkasan Perintah CLI Cepat (Daily Commands)

```bash
# 1. Bersihkan seluruh cache OJS (wajib dijalankan setelah mengubah .tpl, CSS, atau DB)
ddev exec bash -c 'cd /var/www/html && rm -rf ojs/cache && mkdir -p ojs/cache'

# 2. Reset total sistem OJS ke kondisi awal bersih (0 artikel, 0 terbitan)
./scripts/reset.sh

# 3. Lakukan import data Native XML latihan
ddev exec bash -c 'cd /var/www/html/ojs && php tools/importExport.php NativeImportExportPlugin import ../import/xml/issue-937.xml AKDISI --user_name admin'

# 4. Registrasi ulang versi plugin kustom ke tabel versions OJS
ddev exec php /var/www/html/scripts/register-plugins.php

# 5. Backup database MariaDB ke folder backups/
ddev exec mysqldump -uroot -proot db > backups/backup_manual_$(date +%Y%m%d).sql

# 6. Memeriksa status kontainer DDEV
ddev status

# 7. Membaca 30 baris terakhir log error PHP-FPM jika ada masalah
ddev exec tail -n 30 /var/log/php-fpm.log
```

---

### Masalah yang Sering Terjadi & Solusinya (Troubleshooting)

#### 1. Perubahan CSS atau Template `.tpl` Tidak Muncul di Browser
- **Penyebab**: Smarty menyimpan hasil kompilasi template di dalam folder `cache/t_compile/`.
- **Solusi**: Bersihkan cache dengan perintah:
  ```bash
  ddev exec bash -c 'cd /var/www/html && rm -rf ojs/cache && mkdir -p ojs/cache'
  ```
  Kemudian lakukan *Hard Refresh* di browser (`Ctrl + F5` atau `Cmd + Shift + R`).

#### 2. Pesan Kesalahan `400 Bad Request (Host Not Allowed)`
- **Penyebab**: Domain host yang Anda akses belum terdaftar pada array `allowed_hosts` di `config.inc.php`.
- **Solusi**: Periksa baris `allowed_hosts` pada file `ojs/config.inc.php` dan pastikan domain Anda terdaftar:
  ```ini
  allowed_hosts = ["jeki-ojs.ddev.site"]
  ```

#### 3. Slot Komponen Beranda Tertentu Tidak Tampil
- **Penyebab**: Data untuk komponen tersebut bernilai kosong (`null`). Contoh: jika setting `akdisiIndexers` belum diisi di database, template `indexers.tpl` otomatis disembunyikan.
- **Solusi**: Jalankan `scripts/akdisi-custom-blocks.sql` untuk mengisi data dummy atau periksa nilai setting di database.

#### 4. Import Native XML Gagal dengan Error `Section not found`
- **Penyebab**: Atribut `section_ref` pada berkas XML harus tepat sama dengan singkatan (*abbrev*) section di OJS.
- **Solusi**: Skrip `scripts/create-journal.php` secara otomatis mengatur singkatan section artikel menjadi `ARTICLES`. Pastikan atribut section di berkas XML Anda tertulis `<section ref="ARTICLES">`.

---

*Dokumentasi ini disusun dan diverifikasi pada versi OJS 3.5.0-5.*  
*Untuk pertanyaan seputar pengembangan lanjutan, manfaatkan skill `@ojs-expert`.*
