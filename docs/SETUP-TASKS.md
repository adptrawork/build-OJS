# Daftar Pekerjaan — JRDC OJS 3.3

Status per: 13 Nov 2026 · OJS `3.3.0.24` · tema `sangulineModern` **1.6.24.0**
Panduan lengkap konfigurasi, akun lokal, dan prosedur pindah server: `docs/JOURNAL-SETUP-GUIDE.md` (§8 pindah produksi, §9 lingkungan lokal).
Semua status di bawah diverifikasi dari database, kode sumber, dan HTTP check — bukan asumsi.

---

## A. SISA PEKERJAAN — hanya yang butuh data/keputusan manusia

| # | Tugas | Kondisi sekarang | Aksi |
|---|---|---|---|
| A1 | Ganti identitas akun staf dengan orang nyata | 6 akun aktif tapi masih `@jrdc.test` (`editor`, `sectioneditor`, `reviewer1/2`, `copyeditor`, `layout`) | Users & Roles → Edit: email, nama asli, password. Sekalian `admin@admin.com` |
| A2 | Ganti `contactEmail`/`supportEmail` jurnal | keduanya menunjuk `editor@jrdc.test`; telepon sengaja dikosongkan | Settings → Journal Contact → isi email & telepon redaksi yang asli |
| A3 | Isi kredensial SMTP produksi | lokal memakai Mailpit (`localhost:1025`), sudah teruji kirim | `config.inc.php` → `smtp_server`, `smtp_port`, `smtp_auth`, `smtp_username`, `smtp_password` |
| A4 | Uji satu siklus penuh: submit → review → copyedit → publish | akun & form sudah siap, tapi belum pernah dijalankan (`review_assignments` = 0) | pakai akun di §9.1: submit sebagai penulis, assign reviewer1/2, cek email di Mailpit, lanjut ke galley |
| A5 | Set prefix DOI Crossref + deposit | 0 artikel ber-DOI, prefix belum diset | Settings → DOI + Tools → Import/Export → Crossref (butuh prefix nyata dari Crossref) |
| A6 | Ganti 5 LoA PDF contoh dengan LoA nyata | PDF LoA saat ini dokumen contoh (ditandai di file) | unggah LoA per artikel saat naskah diterima |
| A7 | Pasang cron di produksi | `scheduled_tasks = On`, lokal dijalankan manual | `*/5 * * * * php tools/runScheduledTasks.php` (atau andalkan ACRON) |

### Opsional — nyalakan hanya bila kebutuhannya ada
| # | Tugas | Syarat |
|---|---|---|
| O1 | Enable `orcidProfile` | ada penulis/reviewer ber-ORCID + Client ID/Secret orcid.org |
| O2 | Enable `citationStyleLanguage` | referensi punya DOI/Crossref |
| O3 | Enable `googleAnalytics` | punya Measurement ID GA4 |
| O4 | Enable `announcementFeed` | pengumuman dipublikasikan rutin |
| O5 | Nyalakan REST API | `restful_urls = On` + `api_key_secret` diset |
| O6 | Blok "Statistik Artikel" di sidebar | butuh data `metrics` yang memadai (baru 17 baris) |
| O7 | Publikasikan ulang issue "Edisi Khusus Ekonomi Digital" | setelah issue punya artikel (sekarang 0 artikel, sengaja di-unpublish) |

---

## B. SUDAH DIKERJAKAN

### B1. Kesiapan publikasi (sesi 13 Nov 2026)
- [x] **Review guidance terisi** — `reviewerGuidelines` + `competingInterests` id_ID & en_US (double-blind, batas waktu 2 minggu respons / 4 minggu review, aturan konflik kepentingan)
- [x] **Review form pertama dibuat** — "Formulir Tinjauan JRDC" / "JRDC Review Form", 6 field naratif (`review_forms` 0 → 1)
- [x] **Judul `id_ID` dilengkapi** — section 3 = "Studi Kasus"; issue 2 = "Vol. 1 No. 1 (2026): Artikel"; issue 3 = "Edisi Khusus Ekonomi Digital"
- [x] **Duplikasi nomor issue diselesaikan** — issue 3 (0 artikel) di-unpublish; arsip kini menampilkan 1 issue
- [x] **`numWeeksPerResponse` 4 → 2** (sesuai kebijakan yang ditulis di review guidance)
- [x] **`scheduled_tasks = On`** — statistik, reminder reviewer, deposit DOI tidak lagi diam
- [x] **`htmlArticleGalley` + `lensGalley` dimatikan** — tidak ada galley HTML/XML (semua PDF)
- [x] **Search index di-rebuild** — 5 artikel terindeks; pencarian "manajemen" mengembalikan 5 hasil
- [x] **Portabilitas domain** — 7 baris berisi domain ddev dikurangi jadi 1 (`emailSignature`, harus absolut); `authorInformation`, `readerInformation`, isi pengumuman sekarang path relatif
- [x] **Tema lepas dari tema induk** — `announcement-slider.js` di-vendor ke `sangulineModern/js/`
- [x] **`downloads/` tidak lagi di-track git** — 30 MB arsip referensi lokal, tetap ada di disk
- [x] **Prosedur pindah produksi didokumentasikan** — `docs/JOURNAL-SETUP-GUIDE.md` §8
- [x] **Verifikasi HTTP** — homepage, archive, issue, artikel, search, about, submissions, indexing, announcement, login, `oai?verb=Identify` semuanya 200

### B2. Lingkungan lokal siap kerja (13 Nov 2026)
- [x] **6 akun staf dibuat** dengan peran yang benar (Journal editor, Section editor, 2 Reviewer, Copyeditor, Layout Editor) — detail & password di `docs/JOURNAL-SETUP-GUIDE.md` §9.1
- [x] **Minat riset reviewer diisi** (3 topik per reviewer, tersimpan di `user_interests`)
- [x] **SMTP → Mailpit teruji** — email benar-benar terkirim dan tertangkap di Mailpit (`smtp = On`, `localhost:1025`); sebelumnya memakai `mail()` yang tidak bisa diverifikasi
- [x] **Review reminder aktif** — `restrictReviewerFileAccess = 1`, `reviewerAccessKeysEnabled = 1`, reminder 3 hari setelah tenggat (hanya tersedia bila `scheduled_tasks = On`)
- [x] **Scheduled tasks dijalankan** tanpa error (`ReviewReminder`, `UsageStatsLoader`, `Crossref/DataCite/DOAJ InfoSender`, `StatisticsReport`)
- [x] **Data placeholder dibersihkan** — `redaksi@contoh-jrdc.ac.id`, `support@contoh-jrdc.ac.id`, nomor `+62 812-0000-0000` dihapus; halaman Dewan Redaksi diisi dari akun nyata (tanpa `[Nama Lengkap]` / `[0000-0000-0000-0000]`)
- [x] **0 sisa placeholder** — `SELECT ... LIKE '%contoh%'` di `journal_settings` = 0

### B3. Navigasi mobile (fix akar masalah, 1.6.24)
- [x] **Root cause ditemukan** — `backdrop-filter: blur(12px)` di `.jrdc-header` menjadikan header *containing block* untuk offcanvas `position: fixed`; panel terkunci setinggi header (104px dari 844px viewport). Dua baris dihapus
- [x] **Terverifikasi** — panel 844×380, `.offcanvas-body` scroll 773px, tombol close terlihat, backdrop click & Escape menutup, tanpa overflow horizontal (390×844 dan 768×1024)
- [x] **Diagnosis 1.6.22 dan 1.6.23 dibatalkan** — BS5 vendored ternyata stok; `header.tpl` dipulihkan dari `14c22695`, `layout.less` dari `583704c7`
- [x] **Kode berlebih dibuang** — handler backdrop duplikat di `jrdc.js` dan cache-buster `?v=3.3.0.25` dihapus
- [x] **Judul panel mobile = nama jurnal** (dinamis), bukan "Site Navigation"
- [x] `version.xml` → `1.6.24.0`, CHANGELOG 1.6.24 ditulis

### B4. Instalasi & infrastruktur
- [x] OJS 3.3.0.24 di ddev (PHP 8.2), nginx PATH_INFO dipulihkan, DB 114 tabel di-import dari Laragon (1.5.1)
- [x] `config.inc.php` diarahkan ke ddev (`host=db`, `files_dir=/var/www/html/ojsData`, `base_url`, `allowed_hosts`)
- [x] Domain mati (laragon `.test`) dibersihkan dari menu, journal settings, announcement (1.6.1)
- [x] Snapshot DB sebelum perubahan berisiko (`before-publish-setup`)

### B5. Tema & tampilan
- [x] Child theme `sangulineModern` + Bootstrap 5.3.3 vendored + design token (1.5.0)
- [x] Rebuild halaman: homepage, issue, TOC, arsip, artikel, pencarian, halaman statis, login (1.5.0)
- [x] Header responsif + offcanvas mobile (lihat B3)
- [x] Ikon Font Awesome → Bootstrap Icons (1.6.4)
- [x] Grid artikel/sidebar diperbaiki — float parent dinetralkan (1.4.0)
- [x] Parity breadcrumb/judul di semua jenis halaman (1.6.2)
- [x] Info grid artikel `auto-fit` (1.6.8)
- [x] Cover issue memakai cover unggahan bila ada (1.6.9–1.6.10)
- [x] Viewer PDF full-height tanpa chrome ganda (1.6.12–1.6.13, 1.6.16)
- [x] Sidebar 7 blok berdata nyata + 3 template .docx asli (1.6.21)
- [x] Kartu LoA di sidebar artikel (1.6.14)
- [x] "Artikel Serupa" di sidebar (1.6.15–1.6.17)

### B6. Data & konten
- [x] Semua yang bisa dinamis dibaca dari OJS (nama jurnal, ISSN, penerbit, email, alamat, frekuensi terbit) (1.6.18)
- [x] Locale `id_ID` + `en_US` untuk seluruh chrome tema (67 key) dan judul menu/section/sidebar (1.6.5)
- [x] DOI dummy dihapus — tidak ada DOI palsu (1.6.6)
- [x] LoA PDF dibuat ulang dengan data nyata (1.6.6)
- [x] 9 halaman statis terisi + judul Indonesia selaras label menu (1.6.2)
- [x] Halaman `/indexing` (Indeksasi & Abstrak) (1.6.21)
- [x] Kata kunci terkontrol + sitasi + biografi penulis untuk 5 artikel (1.6.3)

### B7. SEO & metadata
- [x] `meta description`, canonical, Open Graph, Twitter Card (1.6.6)
- [x] JSON-LD `ScholarlyArticle` + `WebSite` + `Organization`, diverifikasi di 9 tipe halaman (1.6.6)
- [x] Plugin `googleScholar`, `dublinCoreMeta`, `webFeed`, `doipubid` aktif

### B8. Konfigurasi jurnal yang sudah benar
- [x] Masthead: nama, p-ISSN/e-ISSN 2049-3630, penerbit + URL, deskripsi id/en
- [x] Lisensi CC BY 4.0 + License Terms id/en, holder = author, basis tahun = issue
- [x] Akses terbuka, fee publikasi 0, payments OFF
- [x] `disableSubmissions = 0` (penerimaan naskah terbuka)
- [x] Default review mode = `2` (**double-blind**)
- [x] Announcements ON, OAI ON (`enableOai = 1`, `oai = On`)
- [x] 3 section naskah + checklist submission id/en
- [x] Sidebar 7 blok terdaftar, tanpa blok hantu (1.6.11, 1.6.21)

---

## C. Catatan

- **Perubahan database tidak tercakup git.** Semua setting/konten/akun di atas hanya terekam di CHANGELOG + dokumen ini. Kalau DB di-restore dari dump lama, pekerjaan B1/B2/B6/B8 harus diulang.
- **Rollback sesi ini:** `ddev snapshot restore before-publish-setup`. `config.inc.php` tidak di-track git, jadi kembalikan manual bila perlu.
- **Cache browser bisa menipu** saat verifikasi CSS/JS: pakai cache-buster (`?t=`) dan hapus `cache/t_compile/*`, `cache/t_cache/*`, `cache/_db/*`.
- **Root cause 1.6.22 & 1.6.23 salah** (lihat CHANGELOG 1.6.24): BS5 vendored tidak pernah dimodifikasi, dan memindahkan offcanvas keluar header justru merusak navbar desktop.
- **Sebelum go-live:** jalankan checklist §8.5 di `docs/JOURNAL-SETUP-GUIDE.md` pada domain produksi, lalu A1–A3 di atas.
