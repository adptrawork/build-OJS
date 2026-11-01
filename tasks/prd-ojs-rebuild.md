# PRD: Rebuild Situs Jurnal — OJS 3.5 Monolith + Theme Baru

**Versi:** 1.0
**Status:** Draft
**Tanggal:** 2026-10-29
**Referensi:** `RESEARCH-JEKI.md`, baseline `journal.uii.ac.id/JEKI`
**Sifat:** Prototipe. Konten diputuskan belakangan; untuk sekarang hanya slot.

---

## 1. Ringkasan

Membangun instance OJS 3.5.0-5 mandiri dengan theme baru, menggunakan situs
JEKI sebagai referensi konten dan baseline mutu. Bukan migrasi, bukan fork,
bukan headless. Tujuannya membuktikan bahwa OJS bisa tampil dan berperilaku
lebih baik daripada situs referensi tanpa kehilangan fungsi editorial.

Karena konten belum diputuskan, situs dibangun sebagai **kerangka slot**:
setiap tempat konten punya nama, sumber data, batas panjang, dan empty state.
Desain dan layout bisa diselesaikan sebelum satu kata pun ditulis editor.

---

## 2. Keputusan yang dikunci

| Area | Keputusan | Alasan |
|---|---|---|
| Versi | OJS 3.5.0-5 (tag terbaru) | 3.3 EOL, 3.4 akan menyusul; tidak ada alasan memulai dari versi lama |
| Arsitektur | Monolith | Satu runtime, satu deploy, satu backup; integrasi Scholar/OAI/CSL sudah jadi |
| Frontend | Child theme di `plugins/themes/jeki` | Ikut pipeline OJS, tidak perlu build step |
| CSS | Plain CSS + design token (LESS variables) | Lihat §3 |
| Data | Scrape publik (OAI + HTML + PDF) | Tidak ada akses DB |
| Plugin pihak ketiga | Nol | Setiap dependensi eksternal = titik gagal saat patch OJS |
| Indeksasi | `noindex` selama prototipe | Menghindari duplikasi konten dengan situs referensi |

---

## 3. Theme: Tailwind, Bootstrap 5, atau tulis sendiri?

**Keputusan: tulis sendiri, plain CSS di atas pipeline LESS OJS. Tanpa framework.**

Alasannya spesifik, bukan selera:

1. **Kita tidak menguasai markup.** Theme hanya meng-override ~8 template.
   Sisanya — arsip issue, pencarian, form submission, galley viewer, modal —
   dirender oleh OJS dengan class-nya sendiri. Utility class Tailwind hanya
   berguna kalau semua markup milik kita. Menambahkan `class="..."` ke template
   yang tidak kita override = mem-fork OJS.
2. **OJS sudah punya sistem token.** Theme `default` memakai LESS
   (`styles/variables.less`) yang dikompilasi oleh OJS sendiri, plus theme
   option bawaan (`typography`, `baseColour`). Mewarisi itu berarti warna,
   tipografi, dan spacing bisa diatur tanpa satu baris build config.
3. **Tailwind butuh Node di jalur deploy.** Itu satu toolchain lagi yang harus
   hidup setiap kali theme diubah — untuk 8 template.
4. **Bootstrap 5 membawa JS yang tidak dipakai.** OJS frontend tidak butuh
   Bootstrap JS (dropdown/modal sudah ada); menambahkannya berarti +25 KB dan
   potensi konflik dengan komponen OJS.
5. **Preseden buruk.** Theme komersial di situs referensi adalah sumber CSS
   rusak (`url(https://ibb.co/...)`, `color: none`). Mengganti satu framework
   pihak ketiga dengan yang lain mengulang pola yang sama.

Yang dipakai: design token (`--jeki-*`), CSS modern (grid, `clamp()`,
`prefers-color-scheme` tidak dipakai), font self-hosted, ikon SVG inline.
Target: < 25 KB CSS terkompilasi untuk halaman depan.

Kalau nanti butuh UI kustom yang banyak (mis. landing page event), Bootstrap
boleh ditambahkan **hanya di halaman itu** — bukan di seluruh theme.

---

## 4. Slot konten

Setiap slot punya: ID, lokasi, sumber, batas, dan empty state. Theme merender
placeholder saat data kosong. Dengan `?slots=1`, semua slot diberi outline
putus-putus + label ID supaya penempatan bisa ditinjau tanpa konten asli.

### 4.1 Halaman depan

| ID | Lokasi | Sumber | Batas | Empty state |
|---|---|---|---|---|
| S-HOME-01 | Bar atas, di atas header | setting teks | 120 char | tidak dirender |
| S-HOME-02 | Hero: judul jurnal, tagline, E-ISSN | setting jurnal | tagline 160 char | tagline disembunyikan |
| S-HOME-03 | Hero: CTA "Submit" + "Author Guidelines" | tetap | — | selalu tampil |
| S-HOME-04 | Sampul issue terkini + meta | otomatis (OJS) | — | "Belum ada issue" |
| S-HOME-05 | Ringkasan "About the Journal" | deskripsi jurnal | 600 char | disembunyikan |
| S-HOME-06 | Strip logo pengindeks (6 kotak) | custom block | 6 × SVG 120×40 | strip tidak dirender |
| S-HOME-07 | Artikel terbaru (6 kartu) | otomatis | — | "Belum ada artikel" |
| S-HOME-08 | Pengumuman (3 item) | otomatis | — | disembunyikan |
| S-HOME-09 | Sidebar: Focus & Scope | static page | 400 char | disembunyikan |
| S-HOME-10 | Sidebar: Editorial Team (3 nama) | static page | — | disembunyikan |
| S-HOME-11 | Sidebar: Template artikel (unduhan) | file | 1 file | tombol disembunyikan |
| S-HOME-12 | Footer: publisher, alamat, kontak | setting | — | — |
| S-HOME-13 | Footer: E-ISSN, lisensi, tautan OAI, sitemap | otomatis | — | — |

### 4.2 Halaman artikel

| ID | Lokasi | Sumber | Catatan |
|---|---|---|---|
| S-ART-01 | Breadcrumb | otomatis | Home › Vol › Issue › Artikel |
| S-ART-02 | Judul + subtitle | otomatis | `<h1>` tunggal |
| S-ART-03 | Penulis + afiliasi + ORCID | otomatis | ORCID hanya jika terisi |
| S-ART-04 | Abstrak | otomatis | tanpa batas, styled |
| S-ART-05 | Kata kunci + JEL | otomatis | chip |
| S-ART-06 | DOI + "How to Cite" | otomatis + CSL | copy button |
| S-ART-07 | Tombol galley (PDF/HTML) | otomatis | label + ukuran file |
| S-ART-08 | Referensi | otomatis | daftar, DOI jadi tautan |
| S-ART-09 | Lisensi + copyright | setting | |
| S-ART-10 | Metrik (views/downloads) | otomatis | opsional, bisa kosong |

### 4.3 Halaman issue & statis

| ID | Lokasi | Sumber |
|---|---|---|
| S-ISS-01 | Sampul + judul issue + tanggal | otomatis |
| S-ISS-02 | Editorial note | otomatis |
| S-ISS-03 | Daftar isi per section | otomatis |
| S-PAGE-01..22 | 22 halaman statis | `staticPages`, isi menyusul |
| S-PAGE-99 | Halaman "kebijakan belum tersedia" | fallback |

### 4.4 Aturan slot

- Konten asli tidak pernah di-hardcode di template. Semua lewat setting,
  static page, custom block, atau data OJS.
- Slot tanpa data tidak menyisakan ruang kosong (kecuali S-HOME-04 yang punya
  empty state eksplisit).
- Placeholder dev hanya aktif dengan `?slots=1`; tidak pernah tampil di build
  biasa.

---

## 5. Plugin: dipakai vs tidak

Diverifikasi langsung terhadap tree `3_5_0-5` (bukan dari daftar artikel).

| Plugin | Status | Alasan |
|---|---|---|
| `googleScholar` | **ON** | meta `citation_*`; syarat indeksasi |
| `citationStyleLanguage` | **ON** | How to Cite, RIS/BibTeX |
| `staticPages` | **ON** | 22 halaman kebijakan |
| `customBlockManager` | **ON** | sidebar + strip pengindeks |
| `webFeed` | **ON** | RSS/Atom |
| `pdfJsViewer` | **ON** | viewer PDF |
| `dublinCoreMeta` | **ON** | OAI `oai_dc` |
| `usageEvent` | **ON** | statistik lokal |
| `crossref` | OFF | butuh keanggotaan berbayar; prototipe tidak deposit |
| `doaj` (importexport) | OFF | butuh ISSN & jurnal nyata |
| `native` (importexport) | **ON** | jalur impor konten |
| `pubmed`, `jatsTemplate`, `htmlArticleGalley` | OFF | di luar cakupan |
| `recommendByAuthor`, `recommendBySimilarity` | OFF | query tambahan, nilai kecil |
| `announcementFeed`, `driver`, `lensGalley`, `credit` | OFF | tidak dipakai |
| `orcidProfile` | **TIDAK TERSEDIA** | tidak ada di tree 3.5; repo plugin berhenti di `stable-3_4_0` |
| `quickSubmit` | **TIDAK TERSEDIA** | tidak ada di tree 3.5; impor massal lewat `native` |
| Theme komersial / pihak ketiga | OFF | sumber masalah di situs referensi |
| Analytics (GA/Matomo), PlumX, WhatsApp, Turnitin, reCAPTCHA | OFF | domain eksternal; target "0 request pihak ketiga" |

Plugin kustom: **satu** — `jekiSeo` (route `/sitemap.xml`, cache 1 jam).
Canonical, OG, dan JSON-LD tidak perlu plugin; cukup template override.

---

## 6. Impor konten

Sumber: OAI `oai_dc` (199 record) + HTML halaman artikel + PDF.

```
fetch.py        OAI + halaman artikel -> import/raw/*.json   (1 req/s)
to_native_xml.py  JSON -> OJS Native XML, per issue
import.sh       php tools/importExport.php NativeImportExportPlugin import ...
```

Aturan:

- Impor **per issue**, bukan 199 artikel sekaligus — supaya bisa diulang.
- PDF disimpan apa adanya; checksum dicatat.
- Referensi, afiliasi, ORCID dari hasil scrape ditandai *best effort*;
  diverifikasi pada 10 artikel sampel, tidak diklaim setara.
- `urls.csv` memetakan URL lama → URL baru untuk 301.

---

## 7. Lapisan SEO

| Item | Implementasi |
|---|---|
| `canonical` | template `head` (semua halaman) |
| OG + Twitter Card | template `head`, gambar dari sampul/logo |
| JSON-LD `ScholarlyArticle` | template halaman artikel |
| JSON-LD `Periodical` | template halaman depan |
| `sitemap.xml` | plugin `jekiSeo` |
| `robots.txt` | `Disallow: /` selama prototipe |
| Versi OJS di HTML | dihapus dari template |
| Heading | tepat satu `<h1>` per halaman |

---

## 8. User stories

### US-001: Instance OJS 3.5 berjalan
Sebagai developer, saya ingin OJS 3.5.0-5 hidup di DDEV agar punya basis kerja.

- [x] DDEV start tanpa error; PHP 8.3, MariaDB 11.8
- [x] Install selesai; halaman depan dan management terbuka (journal path jrdc)
- [x] `PATH_INFO` benar (tidak ada redirect loop)
- [x] Verifikasi di browser

### US-002: Kerangka theme dengan slot
Sebagai developer, saya ingin theme kosong yang sudah punya semua slot agar
desain bisa ditinjau tanpa konten.

- [x] Theme `journalEditorial` aktif, `setParent('defaultthemeplugin')
- [~] Slot S-ART-01/02/PDF, S-ISS-01/03, S-PAGE dirender; S-HOME slot IDs belum dianotasi
- [x] Slot tanpa data disembunyikan (empty state)
- [x] Verifikasi di browser

### US-003: Impor issue
Sebagai developer, saya ingin 24 issue masuk agar arsip punya struktur nyata.

- [ ] 24 issue, 12 volume, penomoran benar
- [ ] Impor bisa diulang tanpa duplikat
- [x] Verifikasi di browser

### US-004: Impor artikel + PDF
- [~] 5 artikel demo (bukan 199; import pipeline tersedia)
- [x] 5 PDF lokal dilampirkan ke galley
- [x] Metadata `citation_*` tampil di artikel
- [x] Verifikasi di browser

### US-005: Halaman depan
- [x] Slot beranda terisi dari data nyata (hero, stats, editor picks, tabs, indexing, footer)
- [x] Request 23, domain eksternal 0 (Lighthouse)
- [x] Verifikasi di browser

### US-006: Halaman artikel
- [x] Slot artikel terisi; How to Cite (CSL) aktif
- [x] PDF terbuka di viewer (iframe)
- [x] Verifikasi di browser

### US-007: SEO
- [x] canonical di semua halaman; JSON-LD valid
- [x] `/sitemap.xml` 200
- [x] Versi OJS tidak terekspos

### US-008: Siklus editorial
- [ ] Submit → assign reviewer → review → accept → publish selesai
- [ ] Artikel hasil publish muncul di halaman depan

---

## 9. Non-goals

- Crossref/DOI deposit, ISSN, DOAJ, PKP PN, SINTA
- ORCID (plugin belum tersedia di 3.5)
- Multi-journal, executive dashboard, backup manager, SSO
- Analytics pihak ketiga
- Deploy produksi (belum ada host)
- Migrasi user/role/riwayat review (tidak ada sumbernya)

---

## 10. Target terukur

| Metrik | Referensi | Target |
|---|---|---|
| Request homepage | 75 | < 35 |
| Domain eksternal | 7 | 0 |
| DOM node | 1.582 | < 1.000 |
| `<h1>` per halaman | 2 | 1 |
| Gambar tanpa `alt` | 8 | 0 |
| `canonical` | tidak ada | 100% |
| `sitemap.xml` | 404 | 200 |
| JSON-LD artikel | tidak ada | 100% |
| axe violations | ada | 0 |
| CSS terkompilasi | — | < 25 KB |

---

## 11. Perbandingan dengan situs referensi (materi demo)

### 11.1 Prinsip

1. **Bandingkan yang bisa diukur ulang oleh klien**, bukan skor yang kita pilih
   sendiri.
2. **Setiap angka punya kondisi**: perangkat, throttling, cache, waktu ukur.
   Angka tanpa kondisi tidak dipakai.
3. **Sebut keunggulan referensi lebih dulu.** Kredibilitas datang dari mengakui
   apa yang tidak bisa kita samai, bukan menutupinya.
4. **Kalau metrik kita kalah, tampilkan.** Satu angka yang jujur lebih kuat
   daripada sepuluh angka yang dipilih.

### 11.2 Metode ukur (harus identik untuk kedua situs)

| Aspek | Ketentuan |
|---|---|
| Tool | Lighthouse (versi sama), axe DevTools, DevTools Network |
| Mode | Mobile emulation, throttling "Simulated Slow 4G" |
| Cache | Incognito, cache disabled, satu tab |
| Run | 3× per halaman, ambil **median** (bukan nilai terbaik) |
| Halaman uji | Home, 1 artikel, 1 arsip issue — jenis yang sama di kedua situs |
| Dicatat | Tanggal, versi browser, versi tool, jaringan |

Situs referensi **diukur ulang pada hari demo**, bukan memakai angka riset
lama. Angka lama hanya untuk perencanaan.

### 11.3 Tabel klaim

| Metrik | Referensi (terukur) | Target kita | Verifikasi | Jenis |
|---|---|---|---|---|
| Request homepage | 75 | < 35 | DevTools Network | terukur |
| Domain eksternal | 7 | 0 | DevTools Network | terukur |
| DOM node | 1.582 | < 1.000 | DevTools Elements | terukur |
| CSS terkirim | — | < 25 KB | Network size | terukur |
| LCP (lab, mobile) | ukur ulang | < 2,5 s | Lighthouse | terukur |
| CLS | ukur ulang | < 0,1 | Lighthouse | terukur |
| TBT | ukur ulang | < 200 ms | Lighthouse | terukur |
| Pelanggaran axe | ada | 0 | axe DevTools | terukur |
| `<h1>` per halaman | 2 | 1 | manual | terukur |
| Gambar tanpa `alt` | 8 | 0 | axe | terukur |
| `canonical` | tidak ada | 100% | view-source | terukur |
| `sitemap.xml` | 404 | 200 | curl | terukur |
| JSON-LD artikel | tidak ada | valid | Rich Results Test | terukur |
| Versi OJS terekspos | ya | tidak | view-source | terukur |
| Peringkat Google | — | — | — | **tidak diklaim** |

### 11.4 Yang tidak kita klaim

| Klaim yang menggoda | Kenapa tidak | Yang boleh dikatakan |
|---|---|---|
| "Lebih cepat" | Bergantung jaringan, cache, dan server | "Lebih ringan: 35 request vs 75, 0 domain eksternal" |
| "Lebih baik untuk Google Scholar" | Butuh 2–8 minggu untuk terlihat | "Tag `citation_*` lengkap; `citation_pdf_url` menunjuk file PDF langsung" |
| "SEO lebih baik" | Peringkat bukan hasil kerja theme | "canonical, sitemap, JSON-LD ada dan valid" |
| "Lebih aman" | Demo bukan produksi | "Berjalan di OJS 3.5 yang masih dirawat, bukan 3.3 EOL" |
| "Menggantikan situs asli" | Bukan proyek migrasi | "Prototipe untuk membuktikan pendekatan" |
| "Skor Lighthouse 100" | Mudah dicapai di halaman kosong, tidak bermakna | Tampilkan skor per halaman, apa adanya |

### 11.5 Keunggulan referensi yang harus disebut lebih dulu

- Domain dan otoritas 12 tahun; backlink yang tidak bisa ditiru demo.
- 12 volume, 24 issue, 199 artikel nyata; 197 DOI terdaftar di Crossref.
- Terindeks Google Scholar, dengan tim editorial dan riwayat review nyata.
- Situs kita: prototipe. Keunggulannya teknis (berat halaman, aksesibilitas,
  kebersihan metadata), **bukan** reputasi atau jangkauan.

### 11.6 Skenario demo 5 menit

1. Buka kedua situs, mode mobile, halaman sejenis berdampingan.
2. Network tab: hitung request dan domain eksternal.
3. Lighthouse: LCP, CLS, TBT — median 3 run.
4. axe: jumlah pelanggaran.
5. Halaman artikel: view-source, tunjukkan `citation_*`, JSON-LD, canonical.
6. Tutup: "ini yang bisa diukur. Yang tidak bisa saya ukur, tidak saya klaim."

### 11.7 Format penyajian

Setiap slide/angka memuat: nilai, kondisi ukur, tanggal, dan tool. Tanpa
kondisi, angka tidak ditampilkan. Range (min–median–max) lebih dipercaya
daripada satu angka bulat.

---

## 12. Risiko

| Risiko | Mitigasi |
|---|---|
| Scrape diblokir / lambat | 1 req/s, simpan `raw/`, jangan fetch ulang |
| Data scrape tidak lengkap | tandai best effort; jangan klaim paritas |
| Native XML tidak cocok | uji 1 issue dulu sebelum 24 |
| Patch 3.5.x merusak override | catat di `docs/overrides.md`, uji tiap patch |
| Scope creep plugin | setiap plugin harus lolos target §10 |

---

## 13. Struktur repo

```
build-OJS/
├─ .ddev/                    # PHP, MariaDB, nginx + PATH_INFO
├─ import/                   # fetch.py, to_native_xml.py, raw/, pdfs/, urls.csv
├─ plugins/
│  ├─ themes/jeki/           # child theme
│  └─ generic/jekiSeo/       # sitemap
├─ scripts/                  # setup, import, verify
├─ docs/
└─ README.md
```

OJS 3.5 ditarik dari tag resmi saat setup — tidak di-commit.

---

## 14. Estimasi

| Langkah | Durasi |
|---|---|
| Bootstrap + install | 1 hari |
| Impor konten | 3–5 hari |
| Theme + slot | 2–3 minggu |
| SEO | 3–5 hari |
| Editorial + UAT | 2–3 hari |
| Verifikasi | 2 hari |
| **Total** | **5–6 minggu** |

---

## 15. Pertanyaan terbuka

1. Konten final (teks kebijakan, tim editorial, logo pengindeks) — ditunda.
2. Email: benar-benar dikirim (butuh SMTP) atau di-log ke file selama demo?
3. Cakupan impor: 199 artikel penuh atau subset 40–50?
