# Panduan Lengkap Membangun Jurnal JRDC dengan OJS 3.x

*Jurnal Ratu Dirgantara Cendekiawan — dari nol sampai siap diluncurkan. Disusun 4 November 2026 untuk pemula.*

## Baca ini dulu

**Cara memakai panduan.** Kerjakan berurutan, bagian 1 sampai 8. Setiap bagian memakai istilah dari bagian sebelumnya. Langkah yang berisiko diberi tanda **⚠️ Peringatan**.

**Apa yang saya lihat dari situs JEKI** (halaman beranda, diperiksa langsung):

- JEKI memakai **OJS 3.3.0.10**, versi yang sudah lama.
- Tampilannya memakai **tema dari openjournaltheme.com** (tertulis “Ver 1.4”, tema komersial) dan plugin milik vendor yang sama (`ojtPlugin`, antara lain untuk widget Google Scholar Citation).
- Banyak halaman (People, Peer Reviewers, Editorial Policies, Focus and Scope, dan sebagainya) adalah **halaman kustom**, bukan bawaan OJS.

Jadi sebagian tampilan JEKI memang hasil tema berbayar dan modifikasi khusus. Anda tidak bisa menyalinnya 1:1 hanya lewat pengaturan. Panduan ini menunjukkan mana yang bisa dicapai dengan **pengaturan bawaan**, mana yang butuh **plugin**, dan mana yang butuh **tema/kustomisasi**. Logo, teks, dan gambar JEKI adalah milik mereka: **jangan disalin**. JRDC harus memakai identitas dan konten sendiri.

**Catatan akurasi.** Nomor versi dan status dukungan di bawah dicek per awal November 2026. Nama menu OJS bisa sedikit berbeda antar versi; ikuti nama tab yang Anda lihat di layar. Hal yang belum pasti saya tandai **(verifikasi)**.

---

## 1. Dasar OJS

### 1.1 Apa itu OJS

**Open Journal Systems (OJS)** adalah perangkat lunak gratis dan sumber terbuka dari Public Knowledge Project (PKP) untuk mengelola jurnal ilmiah online: penulis mengirim naskah, editor mengatur peninjauan, reviewer menilai, lalu naskah diterbitkan di website. OJS berjalan di server Anda sendiri (PHP + database), jadi Anda yang mengurus server, keamanan, dan cadangan.

### 1.2 Satu jurnal atau banyak jurnal

Satu instalasi OJS bisa menampung **beberapa jurnal** (disebut *context*). Untuk JRDC cukup **satu jurnal**, tetapi OJS tetap memakai struktur yang sama:

- **Site** = tingkat paling atas instalasi (diatur oleh *Site Administrator*).
- **Journal** = jurnal JRDC (diatur oleh *Journal Manager*).

Untuk satu jurnal, Anda bisa membuat alamat utama domain langsung menampilkan JRDC (lihat bagian 2.6). Pilihan ini bisa diubah nanti, jadi tidak perlu khawatir.

### 1.3 Istilah penting

| Istilah | Arti sederhana |
| --- | --- |
| Site Administrator | Pengelola seluruh instalasi: membuat jurnal, pengaturan situs |
| Journal Manager | Pengelola jurnal: pengaturan, tema, plugin, pengguna |
| Editor-in-Chief / Journal Editor | Pimpinan editorial, memutuskan naskah diterima/ditolak |
| Section Editor | Editor bidang tertentu |
| Reviewer | Penelaah naskah (peer review) |
| Author | Penulis yang mengirim naskah |
| Submission | Naskah yang dikirim ke jurnal |
| Section | Kategori naskah, misalnya “Artikel Penelitian”, “Tinjauan Sistematis”, “Studi Kasus” |
| Issue | Satu edisi terbit (Volume dan Nomor, mis. Vol. 1 No. 1) |
| Article | Naskah yang sudah diterbitkan |
| Galley | File naskah versi terbit untuk pembaca (PDF, HTML, XML) |
| Publication | “Versi” sebuah naskah; satu naskah bisa punya beberapa versi |
| Theme | Tampilan website bagian depan |
| Plugin | Modul tambahan yang menambah fitur |
| Block | Kotak di sidebar (mis. daftar informasi, kata kunci) |
| Navigation Menu | Menu di bagian atas/footer website |
| DOI | Pengenal digital permanen sebuah artikel (mis. 10.xxxxx/JRDC.v1i1.1) |
| ISSN | Nomor standar terbitan berkala (cetak/online) |

Bagian depan (yang dilihat pembaca) dan bagian belakang (dashboard editorial di alamat `/jrdc/submissions`) adalah dua hal berbeda. **Tema hanya mengubah bagian depan.**

---

## 2. Persiapan dan instalasi

### 2.1 Versi OJS yang saya rekomendasikan

| Versi | Status | Cocok untuk JRDC? |
| --- | --- | --- |
| **3.5.x (LTS)** | Rilis LTS 3.5.0-5 tersedia sejak 30 Juni 2026 | **Direkomendasikan** untuk instalasi baru bila server memenuhi syarat |
| 3.4.x | Rilis non-LTS, masa dukungan terbatas | Hanya bila tema/plugin yang Anda butuhkan belum mendukung 3.5 |
| 3.3.x | LTS lama, didukung minimal hingga 1 Januari 2027 | Jangan untuk situs baru; ini versi JEKI yang akan segera usang |

**Alasan memilih 3.5 LTS:** (1) dukungan jangka panjang, jadi Anda tidak dipaksa upgrade dalam waktu dekat; (2) mendapat patch keamanan; (3) Anda baru mulai, jadi tidak ada beban migrasi. Cek rilis terbaru di <https://pkp.sfu.ca/software/ojs/> dan pakai nomor patch terbaru (mis. `3.5.0-x`).

**Konsekuensinya:** tema dan plugin pihak ketiga (termasuk tema komersial JEKI) biasanya lebih dulu mendukung 3.3/3.4. Sebelum membeli atau memasang tema/plugin apa pun, **tanyakan atau cek apakah mendukung OJS 3.5** (verifikasi). Plugin kompatibilitas: <https://pkp.github.io/plugin-compatibility/>.

### 2.2 Kebutuhan server

Periksa dengan penyedia hosting atau lewat `php -v`. Untuk **OJS 3.5** (cek README rilis yang Anda unduh):

- **PHP 8.2 atau lebih baru** (OJS 3.4 memerlukan PHP 8.1+; OJS 3.3 memakai PHP 7.3 sampai 8.1).
- **MySQL 5.7.22+ / MariaDB** atau **PostgreSQL**. Untuk pemula, MySQL/MariaDB paling mudah.
- Web server **Apache** (paling mudah, dengan `mod_rewrite`) atau Nginx.
- Ekstensi PHP umum: `curl`, `dom`, `gd`, `intl`, `mbstring`, `mysqli`, `xml`, `zip`, `fileinfo`, `openssl`.
- HTTPS (sertifikat SSL; Let’s Encrypt gratis).
- Ruang disk longgar (naskah dan PDF cepat membesar) dan akses **cron** untuk tugas terjadwal.

**Jika PHP di server Anda di bawah 8.2:** naikkan PHP lewat panel hosting. Bila tidak bisa, gunakan OJS 3.4 (PHP 8.1) sementara, dan rencanakan upgrade.

### 2.3 Pilih metode instalasi

| Metode | Cocok jika | Catatan |
| --- | --- | --- |
| **A. Panel hosting (cPanel/Plesk), unggah paket rilis** | Server Anda berbagi (shared) atau ada cPanel | Paling mudah untuk pemula |
| **B. VPS manual (Linux, SSH)** | Anda punya akses root | Lebih fleksibel dan aman, butuh keahlian server |
| **C. Docker** | Anda terbiasa Docker | Tidak diulas di sini |

Pakai **paket rilis resmi** (file `.tar.gz` dari situs PKP), **bukan** salinan dari GitHub. Salinan GitHub butuh langkah build tambahan (`composer`, `npm`) dan untuk pengembangan, bukan produksi.

### 2.4 Langkah instalasi (metode A/B)

1. **Unduh** OJS 3.5.x LTS dari <https://pkp.sfu.ca/software/ojs/> (file `.tar.gz`).
2. **Buat database dan user database** baru lewat panel hosting (mis. nama `jrdc_ojs`, user `jrdc_user`, kata sandi acak panjang). Beri user hak penuh hanya pada database ini. Catat host, nama, user, sandi.
3. **Unggah dan ekstrak** paket ke direktori web (mis. `public_html/` atau subfolder). Rapikan agar `index.php` OJS ada di akar situs.
4. **Buat folder penyimpanan file di LUAR folder web**, mis. `/home/akun/ojs_files`. Di sinilah naskah yang diunggah disimpan. Beri izin tulis ke folder ini.

> **⚠️ Peringatan penting:** folder ini (`files_dir`) **tidak boleh** berada di dalam `public_html`. Jika ya, naskah rahasia (termasuk naskah yang sedang direview anonim) bisa diunduh siapa saja.

5. Beri izin tulis sementara ke `config.inc.php`, `cache/`, dan `public/`.
6. **Buka domain Anda di browser.** Installer OJS muncul. Isi:
   - Bahasa (Indonesia dan English; bisa ditambah nanti),
   - Akun **Site Administrator** (username dan sandi kuat, email aktif),
   - Data database dari langkah 2,
   - Path folder file dari langkah 4,
   - Locale/zona waktu.
7. Klik **Install**. Bila berhasil Anda diarahkan ke halaman situs.
8. **Kembalikan izin `config.inc.php`** agar tidak bisa ditulis oleh server web (mis. `chmod 440` atau 444).
9. **Aktifkan HTTPS** dan pastikan `force_ssl = On` di `config.inc.php`.
10. **Pasang cron** (tugas terjadwal). Untuk OJS 3.5, satu baris cron setiap menit: `* * * * * php /path/ke/ojs/lib/pkp/tools/scheduler.php run >> /dev/null 2>&1` (OJS 3.3/3.4 memakai `php tools/runScheduledTasks.php`.) Tanpa cron, email pengingat, statistik, dan deposit DOI tidak berjalan.

> **⚠️ Peringatan:** jangan mengubah file di `lib/pkp/`, `classes/`, atau `templates/`. Perubahan itu hilang saat upgrade dan bisa merusak situs. Semua kustomisasi lewat pengaturan, plugin, atau tema.

### 2.5 Pengaturan `config.inc.php` yang perlu dicek

File ini ada di akar OJS. Pembanding resmi: `config.TEMPLATE.inc.php`.

| Bagian/opsi | Isi yang disarankan |
| --- | --- |
| `[general] installed` | `On` |
| `[general] base_url` / `restful_urls` | `restful_urls = On` agar alamat tanpa `index.php`, dengan aturan rewrite di `.htaccess` |
| `[files] files_dir` | di luar folder web |
| `[security] force_ssl` | `On` |
| `[security] salt`, `api_secret_key` | nilai acak unik |
| `[debug] show_stacktrace` / `display_errors` | `Off` di produksi |
| `[email] default` | `smtp` dengan akun email jurnal (mis. `editor@domainanda`) |

### 2.6 Membuat jurnal JRDC

1. Login sebagai Site Administrator. Buka **Administration > Hosted Journals > Create Journal**.
2. Isi **Title**: *Jurnal Ratu Dirgantara Cendekiawan*, **Acronym**: *JRDC*, **Path**: `jrdc` (huruf kecil, tanpa spasi; ini menjadi bagian alamat).
3. Pilih bahasa utama dan simpan. Anda otomatis menjadi Journal Manager.
4. **Agar domain utama langsung membuka JRDC:** *Administration > Site Settings > Setup* lalu pada **Redirect** pilih JRDC. Hasilnya `domainanda/` menampilkan jurnal.
5. Buat akun terpisah untuk pekerjaan harian (jangan memakai akun Site Administrator sehari-hari).

---

## 3. Konfigurasi dasar jurnal

Masuk ke dashboard jurnal, lalu menu **Settings**. Menu utama: **Journal, Website, Workflow, Distribution, Users & Roles**.

### 3.1 Journal > Masthead dan Contact

Isi lengkap, karena data ini dipakai untuk pengindeksan:

- **Journal Title** (Jurnal Ratu Dirgantara Cendekiawan), **Abbreviation** (JRDC).
- **Publisher**: Yayasan Ratu Dirgantara Cendekiawan.
- **Online ISSN / Print ISSN**: isi bila sudah ada. Belum punya? Ajukan ke **ISSN Indonesia (BRIN)**: <https://issn.brin.go.id>. Siapkan identitas penerbit dan edisi contoh. Proses ini memakan waktu, jadi **ajukan sedini mungkin**.
- **Journal Summary** (ringkasan singkat) dan **Editorial Team** (daftar redaksi: nama, afiliasi, ORCID bila ada).
- **About the Journal**: fokus dan ruang lingkup (ekonomi, bisnis, manajemen, keuangan, ilmu sosial), jenis naskah, frekuensi terbit, model akses terbuka.
- **Contact**: alamat, email redaksi (pakai email lembaga, bukan email pribadi), telepon.

### 3.2 Journal > Sections

Buat bagian naskah untuk JRDC, misalnya:

- Artikel Penelitian Asli (Original Research Articles),
- Tinjauan Sistematis (Systematic Reviews),
- Studi Kasus (Case Studies).

Pada setiap section atur: **diperlukan peer review** (centang), apakah masuk indeks, dan editor bagian.

### 3.3 Website > Setup

- **Languages**: aktifkan Indonesia dan English, tentukan bahasa utama. Hati-hati: bila ada dua bahasa, isi field penting di kedua bahasa agar tidak kosong.
- **Information**: teks “For Readers/Authors/Librarians”.
- **Announcements**: aktifkan agar halaman Pengumuman muncul (JEKI memakainya).
- **Navigation**: menu (lihat bagian 4).

### 3.4 Distribution

- **License**: JRDC akses terbuka, jadi pilih lisensi Creative Commons, umumnya **CC BY 4.0** (atau CC BY-SA 4.0). Tulis pernyataan hak cipta yang jelas.
- **Access**: pilih **Open Access** penuh. Tidak ada subscription.
- **Indexing / Search Indexing**: isi deskripsi jurnal, aktifkan *search engine indexing*, dan buat **sitemap** tersedia.
- **DOIs**: aktifkan, lalu hubungkan ke **Crossref** (lihat bagian 6). Awalan DOI (*prefix*) diperoleh dengan mendaftar sebagai anggota Crossref atau lewat sponsor (verifikasi).
- **Payments**: bila ada **Article Processing Charge (APC)**, aktifkan lewat plugin pembayaran manual. Jika belum ada APC, biarkan mati dan **jangan menampilkan klaim bebas biaya yang belum pasti**.
- **Archiving**: pasang arsip digital (mis. LOCKSS/CLOCKSS/Portico, atau bukti penyimpanan di repositori institusi). Ini salah satu syarat DOAJ.

### 3.5 Halaman About dan Editorial Team

Halaman *About* dan *Editorial Team* bawaan OJS mengambil data dari **Masthead** (3.1). Halaman kebijakan lain (Focus and Scope, Peer Review Process, Publication Ethics, Plagiarism, APC, dan sebagainya) dibuat sebagai **halaman statis** dengan plugin **Static Pages** (bagian 4 dan 6).

---

## 4. Membuat tampilan dan struktur yang mirip JEKI

### 4.1 Peta: bagian JEKI dan cara mencapainya

| Bagian di JEKI | Cara di OJS | Level |
| --- | --- | --- |
| Bar atas: Register, Login | Bawaan tema | Bawaan |
| Header: logo/banner jurnal | **Appearance > Setup**: unggah *Journal logo/Header*; atau *Homepage image* | Bawaan |
| Menu: Home, Current, Archives, Announcements | **Website > Setup > Navigation** (menu *Primary*) | Bawaan |
| Menu dropdown: People, About | Item menu bertingkat (*Navigation Menu Items*) | Bawaan |
| Editorial Team, Contact, Submissions, Privacy | Halaman bawaan OJS (`about/editorialTeam`, dll.) | Bawaan |
| Reviewer Board, Publication Ethics, Policies | **Static Pages** | Plugin |
| Kotak “About Journal” dengan tabel (judul, ISSN, DOI prefix, frekuensi, penerbit) | Isi HTML di **Journal Summary/Additional Content**, atau blok kustom | Bawaan + HTML |
| Daftar Announcements di beranda | Pengaturan Announcements + opsi tema (jumlah pengumuman di beranda) | Bawaan/tema |
| Current Issue dengan editorial dan daftar artikel + tombol PDF | Bawaan; tampil bila ada issue terbit dengan *Description* | Bawaan |
| Sidebar panjang (Journal Information, Information for Author, Template, Tools, Collaboration, ISSN, Statcounter) | **Custom Block Manager** (blok HTML) | Plugin bawaan |
| Logo indeks (DOAJ, Garuda, RePEc) di sidebar | Blok kustom berisi gambar + tautan | Plugin bawaan |
| Keywords (awan kata kunci) | Plugin **Keyword Cloud Block** (verifikasi) | Plugin |
| Published Volumes (daftar volume bisa dibuka) | Blok kustom atau fitur tema komersial | Tema/kustom |
| Widget Google Scholar Citation dan statistik “Read Statistic” | Plugin milik vendor tema (`ojtPlugin`) atau kode kustom | **Komersial/kustom** |
| Warna, tipografi, tata letak kartu | **Tema** | Tema |

**Kesimpulan:** sekitar 70 persen struktur JEKI bisa dibuat dengan pengaturan bawaan, Static Pages, dan Custom Block Manager. Sisanya (tata letak halus, widget sitasi, akordeon volume) memerlukan tema yang mendukung atau kustomisasi (bagian 5).

### 4.2 Langkah: halaman depan (homepage)

1. **Settings > Website > Appearance**:
   - **Theme**: pilih tema (bagian 5).
   - **Setup**: unggah logo/banner header, homepage image (opsional), footer, dan blok sidebar yang ingin ditampilkan.
   - **Advanced**: CSS kustom (*Journal style sheet*), favicon, dan *Additional content* (HTML di bawah isi beranda).
2. **Journal Summary** (Settings > Journal > Masthead) tampil di beranda sebagai pengantar; isi dengan paragraf deskripsi JRDC.
3. Tambahkan tabel informasi jurnal (judul, singkatan, ISSN, DOI prefix, frekuensi, penerbit) sebagai HTML di *Additional content*.
4. Agar **Current Issue** tampil: buat issue (bagian 7), isi **Description** (editorial), lalu terbitkan.
5. Agar **Announcements** tampil di beranda: aktifkan di Website > Setup > Announcements, lalu atur jumlah yang tampil di opsi tema bila ada.

### 4.3 Langkah: menu navigasi (struktur JEKI)

**Settings > Website > Setup > Navigation > Navigation Menus > menu Primary > Edit.** Susun:

- Home
- Current
- Archives
- Announcements
- People (induk) → Editorial Team, Reviewer Board
- About (induk) → Submissions, Publication Ethics, Privacy Statement, Contact
- Search (di JEKI berupa tautan terpisah)

Item “Reviewer Board” dan “Publication Ethics” baru muncul sebagai pilihan setelah halaman statisnya dibuat dengan Static Pages. Buat halaman dulu, lalu tambahkan sebagai item menu.

### 4.4 Langkah: daftar isu, artikel, dan halaman informasi

- **Current** dan **Archives** adalah halaman bawaan. Isinya otomatis dari issue yang diterbitkan.
- **Halaman artikel** (judul, penulis, abstrak, kata kunci, DOI, tombol PDF, sitasi) dibuat OJS secara otomatis. Tampilannya ditentukan tema.
- **Halaman untuk penulis/pembaca**: Author Guidelines, Submission Checklist, Copyright Notice, Privacy Statement diisi di **Settings > Workflow > Submission** dan **Settings > Website > Setup > Privacy Statement**. Kebijakan tambahan (etika, plagiarisme, AI, APC, retraksi) dibuat sebagai Static Pages dan ditautkan dari sidebar “Information for Author”.

> **Saran:** jangan menyalin teks kebijakan JEKI. Tulis kebijakan JRDC sendiri; acuan umum yang diakui adalah panduan **COPE** (<https://publicationethics.org>) dan kriteria **DOAJ**.

---

## 5. Tema dan template

### 5.1 Pilihan tema untuk menyerupai JEKI

Tema yang dipakai JEKI adalah produk **openjournaltheme.com** (versi 1.4). Nama persis temanya tidak tercantum di halaman; **tanyakan ke pengelola JEKI atau vendor** bila ingin sama persis. Pilihan realistis untuk JRDC:

| Opsi | Biaya | Keterangan |
| --- | --- | --- |
| **A. Tema komersial openjournaltheme.com** (mis. Academic Pro, Classy, Noble, Unify, Novelty) | Berbayar (pada halaman produk tertera ratusan ribu hingga jutaan rupiah) | Paling mendekati JEKI. Pastikan **kompatibel OJS 3.5** sebelum membeli |
| **B. Academic Free Theme** (vendor yang sama) | Gratis (didapat lewat langganan email di situs mereka) | Syarat minimal OJS 3.3. Fiturnya lebih terbatas dari versi Pro |
| **C. Child theme dari tema Default (kustom sendiri)** | Gratis, butuh keahlian | **Paling fleksibel** dan aman terhadap upgrade. Cocok bila Anda mau mengatur tampilan sendiri |
| D. Tema gratis dari Plugin Gallery (Default, Health Sciences, Immersion, Manuscript, dll.) | Gratis | Layout dasar dengan sidebar kanan paling dekat dengan JEKI adalah tema **Default** |

> **⚠️ Peringatan keamanan:** jangan pernah memasang tema atau plugin “bajakan/nulled” dari situs tak dikenal. Itu jalur utama penyusupan backdoor dan *malware* di situs OJS.

**Rekomendasi untuk JRDC:** mulai dengan tema **Default**, atur identitas visual lewat pengaturan Appearance dan CSS (5.2). Jika kemiripan dengan JEKI belum cukup, lanjut ke **child theme** (5.3) atau beli tema komersial yang sudah mendukung 3.5.

### 5.2 Menyesuaikan tampilan tanpa menulis tema

Di **Settings > Website > Appearance**:

- **Logo / header image**: unggah logo JRDC (disarankan lebar sekitar 1100 piksel, tinggi tidak lebih dari 150 piksel; PNG/SVG transparan untuk logo).
- **Footer**: isi alamat penerbit, hak cipta, kontak.
- **Advanced > Journal style sheet**: tempel CSS kustom. Contoh dasar untuk warna dan font (ganti nilai sesuai identitas JRDC):

```css
:root {
  --jrdc-primary: #12355b;   /* biru tua */
  --jrdc-accent:  #c9a227;   /* emas */
}
body { font-family: "Segoe UI", system-ui, sans-serif; }
.pkp_structure_head { background: var(--jrdc-primary); }
.pkp_navigation_primary > li > a { color: #fff; }
a { color: var(--jrdc-primary); }
.pkp_site_name .is_img img { max-height: 90px; width: auto; }
```

Nama kelas CSS bisa berbeda antar tema. Gunakan *Inspect Element* di browser untuk menemukan kelas yang tepat.

### 5.3 Child theme (kustom tema sendiri)

Child theme adalah tema kecil yang **meminjam tema Default** dan hanya menimpa bagian yang berbeda, sehingga tetap aman saat OJS di-upgrade. Struktur minimal (OJS 3.4/3.5):

```
plugins/themes/jrdcTheme/
├── index.php
├── JrdcThemePlugin.php
├── version.xml
├── locale/id/locale.po          (opsional)
├── styles/jrdc.css
└── templates/                   (hanya file yang ingin diubah)
```

Kelas inti:

```php
<?php
namespace APP\plugins\themes\jrdcTheme;

use PKP\plugins\ThemePlugin;

class JrdcThemePlugin extends ThemePlugin
{
    public function init()
    {
        $this->setParent('defaultthemeplugin'); // BUKAN 'default'
        $this->addStyle('jrdc', 'styles/jrdc.css');
    }
    public function getDisplayName() { return 'Tema JRDC'; }
    public function getDescription() { return 'Child theme tampilan JRDC'; }
}
```

`index.php`: `return new \APP\plugins\themes\jrdcTheme\JrdcThemePlugin();`

`version.xml` berisi `<application>jrdcTheme</application>`, `<type>plugins.themes</type>`, `<release>`, `<date>`, dan elemen `<lazy-load>`/`<class>` (lihat contoh pada tema bawaan versi Anda).

**Kesalahan paling sering:** menulis nama tema induk salah (`'default'`). Nama yang benar adalah nama kelas huruf kecil, `defaultthemeplugin`. Bila salah, CSS induk tidak dimuat dan halaman tampil polos (logo raksasa, font serif).

Untuk mengubah satu template (mis. footer), salin **hanya file itu** dari tema Default ke folder `templates/` dengan path yang sama, lalu edit. Jangan menyalin seluruh folder template induk. Pada OJS 3.3, nama file kelas memakai `.inc.php` dan tanpa namespace; sesuaikan bila Anda memakai versi itu.

Unggah folder tema ke `plugins/themes/`, lalu aktifkan di **Settings > Website > Appearance > Theme**. Kosongkan cache (*Administration > Clear Template Cache*) bila perubahan tidak tampak.

---

## 6. Plugin

Semua plugin diatur di **Settings > Website > Plugins**. Ada tiga sumber:

1. **Terpasang bawaan** (*Installed Plugins*): hanya perlu diaktifkan.
2. **Plugin Gallery** (tab *Plugin Gallery*): pasang dengan satu klik, sudah diperiksa PKP.
3. **Unggah manual** (file `.tar.gz`): dari repositori resmi PKP di GitHub (<https://github.com/pkp>) atau vendor tepercaya.

### 6.1 Daftar plugin

| Plugin | Fungsi | Status | Sumber |
| --- | --- | --- | --- |
| **Google Scholar** | Menambah meta tag agar artikel terindeks di Google Scholar | **Wajib** | Bawaan |
| **DOI + Crossref** | Memberi DOI dan mengirim metadata artikel ke Crossref | **Wajib** (untuk jurnal ber-DOI) | Bawaan |
| **Usage Statistics** | Statistik unduhan/baca (pengganti “Statistic” di JEKI) | **Wajib** | Bawaan |
| **Static Pages** | Membuat halaman kebijakan, etika, dsb. | **Wajib** | Plugin Gallery |
| **Custom Block Manager** | Membuat kotak sidebar HTML sendiri (mirip sidebar JEKI) | **Wajib** untuk meniru JEKI | Bawaan |
| **PDF.js Viewer** | Membaca PDF langsung di halaman | Disarankan | Bawaan |
| **Web Feed (RSS/Atom)** | Umpan berita terbitan | Disarankan | Bawaan |
| **ORCID Profile** | Menautkan penulis ke ORCID | Disarankan | Bawaan |
| **Citation Style Language** | Tombol “Cite this article” (APA, dll.) | Disarankan | Plugin Gallery (verifikasi) |
| **Keyword Cloud Block** | Awan kata kunci di sidebar | Opsional | Plugin Gallery (verifikasi) |
| **Crossref Reference Linking** | Tautan referensi otomatis lewat Crossref | Opsional | Repo PKP (verifikasi 3.5) |
| **Manual Payment / Payments** | Penagihan APC secara manual | Opsional (bila ada APC) | Bawaan |
| **Dimensions / Altmetric badges** | Badge sitasi/atensi artikel | Opsional | Vendor / Gallery |
| **Plagiarism check (iThenticate)** | Cek kemiripan di dalam OJS (berbayar, perlu kontrak) | Opsional | Gallery (verifikasi) |
| **Reviewer Certificate** | Sertifikat otomatis untuk reviewer | Opsional | Plugin Gallery |
| **Google Analytics / Statcounter** | Analitik pengunjung (JEKI memakai Statcounter) | Opsional | Gallery atau kode di footer |
| **Backup** | Cadangan dari dalam OJS | Opsional (bukan pengganti backup server) | Plugin Gallery |

**Tentang plugin “JEKI”:** widget Google Scholar Citation dan hitungan baca di JEKI berasal dari plugin vendor tema (`ojtPlugin`) dan bukan bagian OJS. Anda bisa menggantinya dengan Usage Statistics dan tautan ke profil Google Scholar jurnal.

### 6.2 Cara memasang plugin dengan aman

1. **Backup dulu** (database dan folder) bila situs sudah berisi data.
2. Cek **kompatibilitas dengan versi OJS Anda** di halaman plugin atau <https://pkp.github.io/plugin-compatibility/>.
3. Pasang **satu per satu**, uji, lalu lanjut ke berikutnya. Jangan memasang lima plugin sekaligus.
4. Hanya dari sumber resmi atau vendor yang jelas. Hindari plugin dari forum acak.
5. Setelah pasang, aktifkan di *Installed Plugins* dan baca halaman *Settings* plugin itu.
6. Setelah **upgrade OJS**, periksa lagi semua plugin. Plugin lama yang tidak diperbarui adalah penyebab umum error.

Untuk plugin manual: unggah `.tar.gz` lewat **Upload A New Plugin**. Bila plugin membuat tabel database dan tidak muncul, jalankan perintah PKP `php lib/pkp/tools/installPluginVersion.php plugins/generic/namaPlugin/version.xml` (butuh akses SSH).

---

## 7. Alur kerja editorial

### 7.1 Gambaran alur

1. **Submission**: penulis mengirim naskah (judul, abstrak, penulis, file).
2. **Initial screening**: editor memeriksa kecocokan fokus, format, dan kemiripan (plagiarisme).
3. **Peer review**: reviewer ditugaskan, memberi rekomendasi.
4. **Keputusan**: Accept, Request Revisions, atau Decline.
5. **Copyediting dan Production**: penyuntingan bahasa, pembuatan galley (PDF), pemberian DOI.
6. **Publication**: naskah dijadwalkan ke sebuah issue, issue diterbitkan.

### 7.2 Pengaturan di Settings > Workflow

**Submission:**

- **Submission Checklist**: daftar yang harus dicentang penulis (belum terbit di tempat lain, mengikuti template, dst.).
- **Author Guidelines** dan **Copyright Notice**.
- **Metadata**: wajibkan abstrak, kata kunci, afiliasi, dan (disarankan) ORCID.
- **Privacy Statement**.

**Review:**

- **Review Mode** (anonim ganda / double-blind adalah standar jurnal ekonomi-bisnis).
- Batas waktu respons dan penyelesaian review (mis. 14 sampai 21 hari), pengingat otomatis.
- **Review Form** (kolom penilaian: orisinalitas, metodologi, kontribusi, dst.).
- Pedoman untuk reviewer.
- Pastikan minimal dua reviewer per naskah sebagai kebijakan.

**Emails:** sesuaikan templat email (undangan reviewer, keputusan) agar memakai nama dan tanda tangan JRDC.

**Peran dan pengguna (Users & Roles):** buat akun untuk Editor-in-Chief, Managing Editor, Section Editor, dan daftar reviewer. Satu orang boleh memegang beberapa peran.

### 7.3 Menerbitkan issue

1. **Issues > Future Issues > Create Issue**: isi **Volume, Number, Year, Title**, dan **Description** (tulis pengantar editorial di sini; JEKI menampilkannya di *Current Issue*).
2. Pada setiap naskah yang siap: **Publication > Schedule for Publication**, pilih issue tujuan. Isi DOI bila otomatis.
3. **Publish Issue** bila semua artikel siap. Setelah diterbitkan, issue muncul di *Current* dan *Archives*.

**Upcoming issue (seperti JEKI):** artikel yang sudah diterima bisa dijadwalkan ke issue yang belum diterbitkan, sehingga tampil lebih awal sebagai *online first*. Pelajari fitur ini di dokumentasi PKP untuk versi Anda (verifikasi).

### 7.4 Contoh konkret satu siklus

Penulis A mengirim naskah “Pengaruh Literasi Keuangan terhadap Keputusan Investasi” (section Artikel Penelitian). Editor memeriksa kemiripan, menugaskan dua reviewer (batas 21 hari). Reviewer 1 menyarankan revisi kecil, reviewer 2 revisi besar. Editor memutuskan *Request Revisions*. Penulis mengunggah revisi. Editor memutuskan *Accept*, menugaskan copyeditor, lalu galley PDF dibuat. Naskah dijadwalkan ke Vol. 1 No. 1 dan ditandai DOI. Setelah semua artikel siap, issue diterbitkan.

---

## 8. Checklist peluncuran

Centang semuanya sebelum mengumumkan website ke publik.

### 8.1 Teknis dan keamanan

- [ ] OJS 3.5 LTS (patch terbaru) terpasang; PHP sesuai syarat.
- [ ] HTTPS aktif; `force_ssl = On`.
- [ ] `files_dir` di luar folder web; `config.inc.php` tidak dapat ditulis.
- [ ] `display_errors` dan `show_stacktrace` **Off**.
- [ ] Cron berjalan (cek: email pengingat dan statistik terisi).
- [ ] Akun admin memakai sandi kuat; akun harian terpisah dari Site Administrator.
- [ ] Hanya plugin dan tema dari sumber resmi; plugin tak terpakai dihapus.
- [ ] Email SMTP diuji (kirim email uji dari OJS).

### 8.2 Cadangan data

- [ ] Backup otomatis harian: database, `files_dir`, `public/`, `config.inc.php`, tema dan plugin kustom.
- [ ] Salinan disimpan **di luar server**.
- [ ] **Uji restore** minimal sekali di server percobaan.

### 8.3 Konten

- [ ] Masthead, ISSN, penerbit, kontak lengkap.
- [ ] Editorial Team dan Reviewer Board terisi (nama, afiliasi, negara).
- [ ] Fokus dan ruang lingkup, Peer Review Process, Publication Ethics, Plagiarism, Open Access, Copyright dan License, Privacy.
- [ ] APC (jika ada) tertulis jelas, dan kebijakan penggunaan AI.
- [ ] Author Guidelines dan **template naskah** tersedia.
- [ ] Minimal satu issue contoh terbit (OJS menganggap jurnal “aktif” bila ada isi).

### 8.4 Pengindeksan dan standar

- [ ] Meta tag Google Scholar aktif; satu artikel diuji dengan *view-source*.
- [ ] **OAI-PMH** aktif (alamat `…/oai`), sitemap tersedia.
- [ ] DOI dan Crossref terhubung; satu DOI uji berhasil didaftarkan.
- [ ] ISSN tercantum; jurnal didaftarkan di **Garuda**, **Google Scholar**, dan bila memenuhi syarat **DOAJ**, **Sinta**, dan **Crossref**.
- [ ] Terjadwal terbit teratur (frekuensi jelas) dan identitas publik tidak menyesatkan (tidak mengklaim indeks yang belum dimiliki).
- [ ] Lisensi Creative Commons tampil di setiap artikel.

### 8.5 Pengujian

- [ ] Uji **alur penuh** dengan akun palsu: kirim naskah, review, keputusan, terbitkan di situs percobaan.
- [ ] Uji di **ponsel** dan beberapa browser.
- [ ] Semua tautan menu dan sidebar tidak mati.
- [ ] Kecepatan halaman wajar; gambar tidak terlalu besar.
- [ ] Cek ejaan di semua halaman (Indonesia dan Inggris).

---

## Urutan kerja yang saya sarankan

1. Hari 1: cek PHP/hosting, siapkan database dan folder, pasang OJS (bagian 2).
2. Hari 2 sampai 3: buat jurnal, isi masthead, section, bahasa (bagian 3).
3. Hari 4 sampai 5: Static Pages, menu, blok sidebar, tema Default + CSS (bagian 4 dan 5).
4. Minggu 2: plugin wajib, DOI/Crossref, template naskah (bagian 6).
5. Minggu 3: atur workflow dan uji alur dengan data palsu (bagian 7).
6. Minggu 4: isi konten asli, backup, checklist, luncurkan (bagian 8).

## Yang saya butuhkan dari Anda untuk langkah berikutnya

- Versi PHP, jenis hosting (cPanel/VPS), dan apakah ada akses SSH.
- Apakah ISSN dan awalan DOI sudah dimiliki.
- Logo dan warna identitas JRDC.
- Bila ingin saya buatkan **child theme JRDC**, sebutkan versi OJS yang akan dipasang.
