# Panduan Setup & Operasional OJS 3.3 — JRDC

> Versi OJS: **3.3.0.24** · Jurnal: `jrdc` · Tema: `sangulineModern`
> Audiens: pengelola jurnal (editor/admin) baru, editor berpengalaman, penulis/reviewer, dan tim IT.
> Semua status "kondisi saat ini" di dokumen ini diverifikasi langsung dari database dan kode instalasi ini.

---

## 0. Ringkasan cepat (checklist)

**Urutan setup:** Site Settings → Journal Settings (Masthead, Contact, Sections) → Users & Roles → Workflow Settings (Submission → Review) → Website Settings (Appearance, Plugins) → Distribution Settings (License, Indexing, Access, Archiving) → uji coba submit → buka publik.

**Wajib sebelum go-live:**
- [ ] Nama jurnal, ISSN, penerbit, URL penerbit benar
- [ ] Semua section punya judul `id_ID` **dan** `en_US`
- [ ] Minimal 1 Editor, 1 Section Editor, 2 Reviewer aktif
- [ ] Author Guidelines, Copyright Notice, Submission Checklist terisi
- [ ] Review Guidelines + Competing Interests + minimal 1 Review Form
- [ ] Mode review sesuai kebijakan tertulis (disarankan double-blind)
- [ ] Lisensi, License Terms, holder copyright konsisten
- [ ] Email server berfungsi + `scheduled_tasks = On` (cron atau ACRON)
- [ ] Halaman statis (Etika, Biaya, Fokus, Plagiarisme, Retraksi, Akses Terbuka) semua 200 & berisi
- [ ] Sidebar hanya blok berdata nyata (tanpa placeholder)
- [ ] OAI-PMH diuji: `/index.php/jrdc/oai?verb=Identify`
- [ ] Backup DB + `files_dir` + `config.inc.php`

---

## 1. Urutan konfigurasi awal

### Langkah 0 — Situs (Site Administration)
- `Site Settings`: judul situs, bahasa utama & bahasa yang didukung.
- Pastikan `oai = On` (kondisi sekarang: **On**).
- `restful_urls` (kondisi sekarang: **Off**) → REST API `/api/v1` nonaktif. Nyalakan hanya bila akan memakai API.
- Sumber: [Site Administration](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/site-administration) · [Admin Guide — Getting Started](https://docs.pkp.sfu.ca/admin-guide/3.3/en/getting-started)

### Langkah 1 — Journal Settings (identitas & struktur)
1. **Masthead** — nama jurnal, singkatan, ISSN, penerbit, URL penerbit, deskripsi, gambar homepage, favicon.
   *Kondisi sekarang:* nama, p-ISSN/e-ISSN 2049-3630, publisher + URL, deskripsi id/en terisi.
2. **Contact** — nama, email, telepon, afiliasi.
3. **Sections** — satu section per jenis naskah, judul di **semua** bahasa yang didukung.
   *Kondisi sekarang:* 3 section; **section 3 ("Case Study") belum punya judul `id_ID`**.
4. **Categories** (opsional) — hanya bila akan memakai blok Browse atau filter kategori.
- Sumber: [Journal Settings](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/journal-setup) — *Masthead*, *Contact*, *Sections*, *Categories*

### Langkah 2 — Users & Roles
1. Buat minimal: 1 Journal Manager/Editor, 1 Section Editor, 2–3 Reviewer, 1 Copyeditor, 1 Layout Editor.
2. Isi profil reviewer: afiliasi, minat riset (dipakai fitur pemilihan reviewer otomatis), opsi "willing to review".
3. **Site Access Options**: buka registrasi mandiri untuk penulis; tentukan apakah submission hanya untuk user terdaftar.
   *Kondisi sekarang:* 7 user — `admin` (site admin + journal manager) ditambah 6 akun staf lokal (`editor`, `sectioneditor`, `reviewer1`, `reviewer2`, `copyeditor`, `layout`, semuanya `@jrdc.test`; lihat §9). `review_assignments` = 0 karena siklus review belum pernah dijalankan.
- Sumber: [Users and Roles](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/users-and-roles) — *Managing Users*, *Permissions and Roles*, *Site Access Options* · [User Account Management](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/user-accounts)

### Langkah 3 — Workflow Settings

**Submission**
- *Disable Submissions*: **OFF** selama masa penerimaan naskah (sekarang `disableSubmissions = 0`, benar).
- *Metadata*: Keywords **ON**, References **ON** bila jurnal meminta daftar pustaka terstruktur.
- *Components*: sisakan Article Text (wajib), Research Instrument, Image, dsb. Komponen `Dependent file` tidak dipublikasikan.
- *Checklist*: 5–8 item (orisinalitas, format, etika, kesiapan data). Sudah terisi id+en.
- *Author Guidelines* + *Copyright Notice*: wajib, ini yang dibaca penulis.

**Review** — kondisi sekarang vs anjuran:

| Setting | Nilai sekarang | Anjuran |
|---|---|---|
| Default Review Mode | `2` = double-blind | pertahankan (lihat §4) |
| Restrict File Access | `1` (aktif) | pertahankan; reviewer harus menerima undangan sebelum bisa lihat file |
| One-click Reviewer Access | `1` (aktif) | pertahankan (konsekuensi: editor tak bisa ubah email/CC/BCC undangan) |
| numWeeksPerResponse | `2` | sesuai kebijakan tertulis (2 minggu) |
| numWeeksPerReview | 4 | 3–4 minggu |
| Automated Email Reminders | **ON** (`scheduled_tasks = On`; field ini hanya muncul bila scheduled tasks aktif) | butuh email server + cron/ACRON |
| Review Guidelines | terisi id_ID + en_US (double-blind, tenggat 2/4 minggu) | pertahankan, perbarui bila kebijakan berubah |
| Competing Interests | terisi id_ID + en_US | pertahankan, perbarui bila kebijakan berubah |
| Review Forms | **1 form** — "Formulir Tinjauan JRDC" (6 field naratif) | tambah field skor/rekomendasi bila perlu |

- Sumber: [Workflow Settings](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/settings-workflow) — *Submission*, *Review* (*Setup*, *Review Guidance*, *Review Forms*, *Emails*)

### Langkah 4 — Website Settings
- **Appearance → Theme**: pilih `sangulineModern` (aktif), atur sidebar, logo, footer, navigasi.
- **Appearance → Setup**: halaman informasi jurnal, kontak, sidebar, bahasa.
- **Plugins**: aktifkan hanya plugin yang dipakai (lihat `docs/SETUP-TASKS.md`).
- Sumber: [Website Settings](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/settings-website) — *Appearance*, *Setup*, *Plugins*

### Langkah 5 — Distribution Settings
- **License**: CC BY 4.0 (sekarang sudah), isi *License Terms*, holder = author, basis tahun = issue.
- **Search Indexing**: deskripsi jurnal + custom meta tags.
- **Payments**: **OFF** (fee 0, akses terbuka) — jangan enable PayPal/manual.
- **Access**: open access, tanpa langganan.
- **Archiving**: LOCKSS/CLOCKSS bila tersedia; minimal cantumkan kebijakan preservasi.
- Sumber: [Distribution Settings](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/settings-distribution) — *License*, *Search Indexing*, *Payments*, *Access*, *Archiving*

---

## 2. Fitur & modul: apa yang dinyalakan, apa yang dimatikan

### Nyalakan (dan alasannya)
| Fitur/plugin | Alasan |
|---|---|
| `usageEvent` + `usageStats` | statistik artikel & laporan; tanpa ini tidak ada data kunjungan/unduhan |
| `acron` (atau cron) | menjalankan scheduled tasks tanpa cron; wajib bila `scheduled_tasks` diandalkan |
| `googleScholar`, `dublinCoreMeta`, `webFeed` | indeksasi & sindikasi metadata |
| `staticPages` | 9 halaman kebijakan jurnal |
| `pdfJsViewer` | viewer PDF embedded di halaman artikel |
| `recommendBySimilarity` | blok "Artikel Serupa" di sidebar |
| `customBlockManager` | seluruh blok sidebar dikelola dari sini |
| `tinymce` | editor rich text (abstrak, kebijakan, email) |
| `doipub` | hanya berguna **setelah** prefix DOI Crossref diset |

### Matikan (dan alasannya)
| Fitur/plugin | Alasan |
|---|---|
| `htmlArticleGalley`, `lensGalley` | 0 galley HTML/XML di instalasi ini (semua galley PDF) |
| `subscription` + `paypal`/`manual` | jurnal akses terbuka, fee 0 |
| `browse`, `developedBy` | tidak dipakai; sidebar sudah 7 blok berisi |
| `driver` | indeks lama, deprecated |
| tema `academic`, `default`, `sanguline` | child theme tidak butuh parent aktif |

### Opsional — nyalakan hanya bila kebutuhannya ada
| Fitur/plugin | Syarat |
|---|---|
| `orcidProfile` | ada penulis/reviewer ber-ORCID + Client ID/Secret dari orcid.org |
| `citationStyleLanguage` | referensi punya DOI/Crossref (format CSL layak ditampilkan) |
| `googleAnalytics` | punya Measurement ID GA4 |
| `announcementFeed` | pengumuman dipublikasikan rutin (RSS khusus pengumuman) |
| `recommendByAuthor` | hanya bila ingin blok tambahan per penulis (tumpang tindih dengan `recommendBySimilarity`) |

### Tidak perlu di-enable
Plugin **Import/Export** (`crossref`, `doaj`, `datacite`, `native`, `pubmed`, `users`) selalu tersedia di **Tools → Import/Export** — di 3.3 daftar itu dimuat dengan `PluginRegistry::loadCategory('importexport')` tanpa filter enabled.

### Catatan non-plugin yang sering dilupakan
- `scheduled_tasks = On` (sudah aktif). Di lokal task dijalankan manual: `ddev exec php tools/runScheduledTasks.php`. Produksi: cron `*/5 * * * * php tools/runScheduledTasks.php`, **atau** biarkan `acron` memicu lewat request.
- Email: lokal memakai SMTP ke Mailpit (`smtp_server = localhost`, `smtp_port = 1025`) — semua email OJS bisa dilihat di https://ojs-boostrap.ddev.site:8026, tidak ada yang keluar dari mesin. Produksi: ganti ke SMTP nyata + autentikasi (lihat §8.2).
- REST API butuh `restful_urls = On` **dan** `api_key_secret` diset.

---

## 3. Alur kerja naskah & setting yang menopangnya

| Tahap | Apa yang terjadi | Setting penopang |
|---|---|---|
| **Submission** | penulis daftar → isi metadata → upload → checklist → submit | Workflow → Submission (Metadata, Components, Checklist, Guidelines); Site Access Options; `disableSubmissions` |
| **Submission stage (editor)** | editor menilai kelayakan, cek plagiarisme, *Send to Review* atau *Decline* | penugasan section editor; email acknowledgment; Discussion |
| **Review** | editor pilih reviewer → accept/decline → isi review form → rekomendasi → keputusan (Accept / Revisions / Resubmit / Decline) | Workflow → Review (mode, deadline, reminder, review form); profil & minat reviewer |
| **Copyediting** | copyeditor menyunting file, penulis menyetujui | Workflow → Emails; komponen Copyedited; Discussion |
| **Production** | layout editor membuat galley (PDF/HTML), editor finalisasi metadata | Publication Galleys; `pdfJsViewer` (tampilan); `htmlArticleGalley`/`lensGalley` hanya bila ada galley HTML/XML |
| **Publication** | artikel masuk issue → *Schedule for Publication* → terbit | Issue Settings (vol/no/tahun/cover); Distribution (lisensi, DOI); Pub IDs |
| **Pasca-terbit** | statistik, OAI, deposit DOI, pengumuman | `usageStats` + tabel `metrics`; `oai` + `dublinCoreMeta`; `doipub` + Tools → Import/Export (Crossref); `webFeed` |

Sumber: [Editorial Workflow](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/editorial-workflow) (*Tasks*, *Submission Notifications*, *Submission Dashboard*, *Review*, *Copyediting*) · [Production and Publication](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/production-publication) (*Format Article for Publication*, *Finalize Metadata*, *Create Issue*, *Add the Article to an Issue*, *Schedule for Publication*) · [Authoring](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/authoring) · [Reviewing](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/reviewing) · [Tools](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/tools#importexport)

---

## 4. Model tinjauan sejawat (peer review)

**Rekomendasi: double-blind** — reviewer anonim **dan** penulis anonim. Nilai OJS `defaultReviewMode = 2` (`SUBMISSION_REVIEW_METHOD_DOUBLEANONYMOUS`). Instalasi ini sudah 2.

Alasan:
- Mengurangi bias afiliasi, senioritas, gender, dan "efek nama besar" — dua arah.
- Paling umum dipakai jurnal ilmiah; paling mudah dipertahankan saat permohonan indeksasi/akreditasi karena kebijakannya mudah dinyatakan eksplisit.
- Didukung penuh OJS 3.3: penyamaran nama di file, email, dan form review.

Pilih model lain hanya bila ada alasan kuat:

| Model | Kapan dipakai |
|---|---|
| **Single-blind** (reviewer anonim) | komunitas peneliti kecil; reviewer perlu konteks karya sebelumnya |
| **Open review** | jurnal bereksperimen transparansi; butuh kesiapan reviewer & tata kelola konflik kepentingan lebih berat |

Yang wajib menyertai pilihan apa pun: **Review Guidelines**, **Competing Interests policy**, **review form**, dan pernyataan kebijakan review di halaman *Tentang Jurnal*.

Sumber: [Journal Policies & Workflows — Editorial Workflow Policies](https://docs.pkp.sfu.ca/journal-policies-workflows/en/editorial-workflow-policies) — *Peer Review Policy*, *Author & Reviewer Anonymous*, *Reviewer Anonymous*, *Bias in Peer Review* · [COPE — Ethical Guidelines for Peer Reviewers (PDF)](https://publicationethics.org/files/Ethical_Guidelines_For_Peer_Reviewers_2.pdf) · [COPE Core Practices](https://publicationethics.org/core-practices)

---

## 5. Pengaturan yang ditinjau ulang sebelum jurnal dibuka publik

**Struktur & kebijakan**
- Section: judul lengkap semua bahasa; section mana yang me-review, mana yang tidak.
- Review policy tertulis (model review, jumlah reviewer, batas waktu, dasar keputusan).
- Etika publikasi, konflik kepentingan, plagiarisme, retraksi/penarikan naskah — halaman statis harus berisi, bukan template kosong.
- Author Guidelines memuat format file, gaya sitasi, panjang, dan ketentuan data.

**Operasional**
- Email server (SMTP) teruji; template email sudah disesuaikan.
- `scheduled_tasks` + cron/ACRON aktif; statistik mulai terisi.
- Review form siap dipakai; reminder review aktif.
- Registrasi penulis terbuka; akun editor & reviewer sudah dibuat.

**Publikasi**
- Issue: volume/nomor/tahun unik, cover terunggah, artikel terhubung.
- Lisensi & copyright konsisten di semua artikel.
- Statistik & OAI-PMH berfungsi; feed RSS valid.

**Bila memakai DOI/Crossref**
- Prefix nyata (bukan `10.1000`), suffix pattern, dan `doipub` dikonfigurasi.
- Uji deposit lewat Tools → Import/Export → Crossref; cek status di Crossref.
- Sumber: [DOI Plugin Guide](https://docs.pkp.sfu.ca/doi-plugin/en/) — *Enabling the Plugin*, *Configuring the Plugin*, *When Are DOIs Assigned?*, *DOI Registration*

**Bila mengejar indeksasi**
- Sumber: [Indexing Guide](https://docs.pkp.sfu.ca/indexing-guide/en/) (*Preparing your OJS journal for indexing applications*) · [Google Scholar](https://docs.pkp.sfu.ca/google-scholar/en/) · [Journal Policies & Workflows](https://docs.pkp.sfu.ca/journal-policies-workflows/en/) (*Copyright and Licensing*, *Ethics Statements and Policies*, *Corrections and Retractions*, *OA Policies*)

---

## 6. Workflow ringkas

```
Penulis submit ─► Editor cek kelayakan ─► Reviewer (double-blind) ─► Keputusan
      │                   │                        │
      │                   └─ Decline/Desk reject   └─ Revisi ─► review ulang
      ▼
  Copyediting ─► Production (galley PDF) ─► Issue ─► Schedule for Publication
                                                          │
                        Statistik ◄─ OAI/DC ◄─ DOI/Crossref ◄─ RSS/Google Scholar
```

---

## 7. Sumber resmi

| Sumber | Bagian relevan |
|---|---|
| [Learning OJS 3.3](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/) | hub seluruh bab |
| [Journal Settings](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/journal-setup) | Masthead, Contact, Sections, Categories |
| [Website Settings](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/settings-website) | Appearance, Setup, Plugins, Sidebar, Navigation |
| [Workflow Settings](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/settings-workflow) | Submission, Review, Emails |
| [Distribution Settings](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/settings-distribution) | License, Search Indexing, Payments, Access, Archiving |
| [Users and Roles](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/users-and-roles) | Managing Users, Permissions and Roles, Site Access Options |
| [Editorial Workflow](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/editorial-workflow) | Review, Copyediting, Submission Dashboard |
| [Production and Publication](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/production-publication) | Create Issue, Schedule for Publication |
| [Statistics](https://docs.pkp.sfu.ca/learning-ojs/3.3/en/statistics) | definisi metrik, Report Generator |
| [Admin Guide 3.3](https://docs.pkp.sfu.ca/admin-guide/3.3/en/) | [Scheduled Tasks](https://docs.pkp.sfu.ca/admin-guide/3.3/en/deploy-scheduled-tasks), [Email](https://docs.pkp.sfu.ca/admin-guide/3.3/en/deploy-email), [Securing Your System](https://docs.pkp.sfu.ca/admin-guide/3.3/en/securing-your-system) |
| [DOI Plugin Guide](https://docs.pkp.sfu.ca/doi-plugin/en/) | konfigurasi & registrasi DOI |
| [Journal Policies & Workflows](https://docs.pkp.sfu.ca/journal-policies-workflows/en/) | Editorial Workflow Policies, Ethics, Copyright, Retractions |
| [Indexing Guide](https://docs.pkp.sfu.ca/indexing-guide/en/) | persiapan permohonan indeksasi |
| [Google Scholar](https://docs.pkp.sfu.ca/google-scholar/en/) | metadata & persiapan crawling |
| [Plugin Inventory](https://docs.pkp.sfu.ca/plugin-inventory/en/) | daftar plugin resmi |
| [COPE — Ethical Guidelines for Peer Reviewers](https://publicationethics.org/files/Ethical_Guidelines_For_Peer_Reviewers_2.pdf) | etika reviewer |
| [COPE Core Practices](https://publicationethics.org/core-practices) | tata kelola & etika publikasi |

> Catatan verifikasi: `docs.pkp.sfu.ca` memasang proteksi bot, sehingga bab-bab di atas dicocokkan langsung dengan sumber `pkp/pkp-docs` (`learning-ojs/3.3/en/SUMMARY.md`, `admin-guide/en/`, `doi-plugin/en/`, `journal-policies-workflows/en/`, `indexing-guide/en/`).

---

## 8. Memindahkan ke produksi (ganti domain saja)

Situs saat ini sengaja dibuat **portabel**: tidak ada URL domain di dalam tema, template, maupun blok sidebar. Yang tersisa hanyalah konfigurasi server dan satu baris `emailSignature`.

### 8.1 Yang perlu disalin
1. **Folder OJS lengkap** (termasuk `plugins/themes/sangulineModern/`). Tema anak self-contained: tidak lagi memuat aset dari tema induk `sanguline`.
2. **`files_dir`** (`ojsData/` di instalasi ini) — berisi PDF artikel, LoA, cover issue, template .docx. Lokasi sebaiknya **di luar** webroot.
3. **Dump database** (`mysqldump --default-character-set=utf8mb4`), lalu import ke server produksi.

### 8.2 `config.inc.php` yang wajib diubah
```ini
[general]
base_url = "https://domain-baru.example"          ; tanpa trailing slash
allowed_hosts = "[\"domain-baru.example\"]"
scheduled_tasks = On

[database]
host = ... ; username = ... ; password = ... ; name = ...

[files]
files_dir = "/path/di/luar/webroot/ojsData"

[email]
smtp = On
smtp_server = ...
smtp_port = 587
smtp_auth = tls
smtp_username = ...
smtp_password = ...
```
- Jika di belakang reverse proxy/HTTPS: set `https = On` dan `proxy = ...` sesuai Admin Guide (Securing Your System).
- `restful_urls` biarkan `Off` kecuali akan memakai REST API (butuh `api_key_secret`).

### 8.3 Satu baris DB yang masih memuat domain
Hanya **`journal_settings.emailSignature`** (harus absolut karena dipakai di email). Setelah import:
```sql
UPDATE journal_settings
   SET setting_value = REPLACE(setting_value, 'https://ojs-boostrap.ddev.site:8443', 'https://domain-baru.example')
 WHERE setting_name = 'emailSignature';
```
Semua link lain (`authorInformation`, `readerInformation`, isi pengumuman, menu navigasi, blok sidebar) sudah memakai path relatif atau token `[baseUrl]`, jadi tidak perlu diubah.

### 8.4 Setelah import
```bash
rm -rf cache/t_compile/* cache/t_cache/* cache/_db/* cache/fc-*
php tools/rebuildSearchIndex.php
```
- Pastikan `cache/`, `files_dir/`, dan `public/` writable oleh user web server.
- Cron (pilih salah satu): `*/5 * * * * php /path/ojs/tools/runScheduledTasks.php` **atau** biarkan plugin ACRON memicu lewat request.
- Jika pindah dari `php 8.2` ke versi lain: OJS 3.3 aman di PHP 7.4–8.2, jangan 8.3+ (deprecation warnings).

### 8.5 Verifikasi pasca-pindah
- [ ] `/index.php/jrdc/` 200, aset CSS/JS termuat (satu stylesheet tema, satu `announcement-slider.js`, satu `jrdc.js`)
- [ ] `/index.php/jrdc/issue/archive`, `/issue/view/{id}`, `/article/view/{id}` 200
- [ ] `/index.php/jrdc/oai?verb=Identify` mengembalikan XML
- [ ] Pencarian mengembalikan hasil (index sudah di-rebuild)
- [ ] Panel navigasi mobile: buka/tutup, body scroll, tanpa overflow horizontal
- [ ] Email uji terkirim (registrasi/notifikasi)
- [ ] Statistik bertambah setelah ada kunjungan (`metrics`)


---

## 9. Lingkungan lokal (ddev) — akun & konfigurasi yang sudah terpasang

Semua di bawah ini **sudah aktif** di instalasi lokal. Saat pindah ke produksi cukup diganti nilainya (lihat §8), strukturnya tidak perlu dibangun ulang.

### 9.1 Akun staf

| Username | Peran (user group) | Email | Password awal |
|---|---|---|---|
| `admin` | Site Admin + Journal manager | `admin@admin.com` | *(password lama, ganti sebelum produksi)* |
| `editor` | Journal editor | `editor@jrdc.test` | `JrdcDev2026!` |
| `sectioneditor` | Section editor | `sectioneditor@jrdc.test` | `JrdcDev2026!` |
| `reviewer1` | Reviewer | `reviewer1@jrdc.test` | `JrdcDev2026!` |
| `reviewer2` | Reviewer | `reviewer2@jrdc.test` | `JrdcDev2026!` |
| `copyeditor` | Copyeditor | `copyeditor@jrdc.test` | `JrdcDev2026!` |
| `layout` | Layout Editor | `layout@jrdc.test` | `JrdcDev2026!` |

- Domain `@jrdc.test` dipakai supaya jelas akun uji lokal dan tidak mungkin mengirim email ke alamat nyata.
- Minat riset reviewer sudah diisi (dipakai fitur pencarian reviewer): `reviewer1` = manajemen, ekonomi digital, studi kasus; `reviewer2` = manajemen, kebijakan publik, metode kualitatif.
- **Ganti sebelum produksi:** email, nama asli, dan password tiap akun (Users & Roles). `contactEmail` + `supportEmail` jurnal saat ini menunjuk ke `editor@jrdc.test`, ikut diganti.

### 9.2 Halaman Dewan Redaksi

`/about/editorialTeam` diisi dari akun di atas (Ketua Penyunting, Penyunting Bagian, Penyunting Pelaksana, Tata Letak) — tanpa nama/institusi/ORCID fiktif. Nama mitra bestari tidak dicantumkan karena jurnal memakai double-blind. Perbarui teksnya di **Settings → Masthead → Editorial Team** bila susunan redaksi berubah.

### 9.3 Email (Mailpit)

- `config.inc.php` → `[email]`: `smtp = On`, `smtp_server = localhost`, `smtp_port = 1025`.
- Semua email OJS (undangan reviewer, notifikasi, verifikasi) tertangkap di https://ojs-boostrap.ddev.site:8026 — tidak ada yang keluar dari mesin.
- Uji cepat: kirim satu email dari OJS, cek Mailpit; inbox kosong berarti konfigurasi salah.

### 9.4 Scheduled tasks

`scheduled_tasks = On`. Di ddev tidak ada cron, jadi jalankan manual bila perlu:

```bash
ddev exec php tools/runScheduledTasks.php
```

Terakhir diverifikasi berjalan tanpa error (`ReviewReminder`, `UsageStatsLoader`, `Crossref/DataCite/DOAJ InfoSender`, `StatisticsReport`).

### 9.5 Pengaturan review yang terpasang

| Setting | Nilai |
|---|---|
| Default Review Mode | `2` (double-blind) |
| Restrict File Access | `1` |
| One-click Reviewer Access | `1` |
| numWeeksPerResponse / numWeeksPerReview | `2` / `4` |
| Review reminder (response / submit) | 3 hari setelah tenggat |
| Review Guidelines | terisi id_ID + en_US |
| Competing Interests | terisi id_ID + en_US |
| Review Forms | 1 form, 6 field naratif |

### 9.6 Email template (override di database)

15 template inti di-override di `email_templates` + `email_templates_settings` (context 1, id_ID + en_US) dengan wording profesional. Semua enabled; hanya memakai placeholder yang benar-benar di-assign OJS (verifikasi end-to-end lewat Mailpit).

| Key | Kapan terkirim |
|---|---|
| SUBMISSION_ACK | penulis mengirim naskah |
| REVIEW_REQUEST (+ ONECLICK + SUBSEQUENT) | editor mengundang reviewer (ONECLICK dipakai karena `reviewerAccessKeysEnabled = 1`) |
| REVIEW_CONFIRM | reviewer menerima undangan |
| REVIEW_REMIND_AUTO (+ ONECLICK) | pengingat otomatis setelah tenggat |
| EDITOR_DECISION_REVISIONS / ACCEPT / DECLINE | editor memutuskan naskah |
| COPYEDIT_REQUEST | penugasan copyeditor |
| LAYOUT_REQUEST | penugasan layout editor |
| PUBLISH_NOTIFY | edisi baru diterbitkan |
| USER_REGISTER | pendaftaran akun |
| PASSWORD_RESET_CONFIRM | permintaan reset kata sandi |

Yang tidak di-override (default OJS) tetap tersedia dan dipakai bila fiturnya aktif. Template yang tidak pernah terkirim di jurnal ini (SUBSCRIPTION_*, LOCKSS_*, ORCID_*, USER_VALIDATE) tidak bisa di-disable lewat UI (`can_disable = 0`) dan tidak pernah terpicu karena plugin/fiturnya mati.

---

## 10. Auto-deploy via GitHub Actions (SSH)

File: `.github/workflows/deploy.yml` (trigger: push ke `main` atau manual `workflow_dispatch`).

Secrets yang harus di-set di GitHub → Settings → Secrets and variables → Actions:
| Secret | Nilai |
|---|---|
| `SSH_HOST` | `101.50.1.74` |
| `SSH_PORT` | `45022` |
| `SSH_USER` | `gadingga` |
| `SSH_PRIVATE_KEY` | isi file `~/.ssh/jrdc_deploy_new` (seluruhnya, termasuk header/footer) |
| `DEPLOY_PATH` | `/home/gadingga/inventive-mauve-porcupine.101-50-1-74.cpanel.site` |

Catatan:
- `config.inc.php`, `ojsData/`, `public/journals/`, `public/site/`, `cache/`, `downloads/` di-exclude — tidak akan ditimpa (data produksi aman).
- Setiap deploy menjalankan `php tools/upgrade.php upgrade` + clear cache otomatis.
- DB import tetap manual (tidak diotomatisasi demi keamanan).
- Untuk memakai key baru: `ssh-keygen -t ed25519 -C "deploy-jrdc" -f ~/.ssh/jrdc_deploy_new -N ""`, lalu import public key ke panel hosting dan authorize.
