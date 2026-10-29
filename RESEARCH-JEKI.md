# Riset Website JEKI — journal.uii.ac.id/JEKI

**Tanggal riset:** 29 Oktober 2026
**Target:** https://journal.uii.ac.id/JEKI/index
**Tujuan:** baseline riset sebelum rebuild (platform, konten, UX, risiko migrasi)

---

## 1. Ringkasan Eksekutif

| Aspek | Temuan |
|---|---|
| Platform | **OJS (Open Journal Systems) 3.3.0.10** — bukan framework native/custom |
| Theme | **Academic Pro Extended v2.0** (OpenJournalTheme), child dari `academic_pro3` |
| Hosting | Multi-journal: JEKI = journal ID **49** dari ~60 jurnal di `journal.uii.ac.id` |
| CDN/WAF | Cloudflare + plugin cache `ojtBlazingCachePro 1.4.0.7` (cache HIT, load 5–24 ms) |
| Konten | 12 volume, **24 issue**, **199 artikel** (OAI-PMH), 197 ber-DOI |
| Bahasa | English-only (UI `en-US`; `/index/id` → 404) |
| Status versi | **3.3.x sudah EOL**; rilis terkini 3.5.0-5 / 3.4.0-11 (LTS) |

**Kesimpulan:** ini instalasi OJS standar + theme komersial + set plugin pihak ketiga. Rebuild "dari nol" secara teknis bisa, tapi **workflow editorial (submission → review → production → publish) adalah 80% nilai OJS**. Rebuild yang waras = pertahankan OJS sebagai backend, ganti lapisan presentasi (theme/custom front-end), bukan menulis ulang OJS.

---

## 2. Bukti Teknis (fingerprint)

```
meta generator : "Open Journal Systems 3.3.0.10"
meta generator : "...Academic Pro Extended ver 2.0 by openjournaltheme.com"
cookie         : OJSSID
header         : ojt-blazing-cache: HIT / ojt-blazing-cache-version: 1.4.0.7
server         : cloudflare  (cf-ray, cf-cache-status: DYNAMIC)
```

Path khas OJS: `/JEKI/article/view/{id}`, `/JEKI/issue/view/{id}`, `/JEKI/oai`, `/JEKI/gateway/plugin/...`, `/lib/pkp/...`, `/plugins/...`.

**Catatan keamanan:** versi OJS dibocorkan di meta tag dan query string aset (`?v=3.3.0.10`) → mudah difingerprint. Stack 3.3.x tidak lagi menerima patch keamanan.

---

## 3. Arsitektur & Infrastruktur

- **Cloudflare** di depan origin; HSTS aktif (`max-age=15552000; preload`), HTTP/2, kompresi aktif (102 KB HTML → ~19 KB terkirim).
- TTFB ~285 ms, DOMContentLoaded ~532 ms, load ~595 ms (ter-cache). **75 request, 24 gambar, 1.582 DOM node** untuk homepage.
- Origin PHP (OJS). Tidak ada jejak framework JS (no React/Vue/Next) — render server-side penuh + jQuery.
- `robots.txt` berisi blok disallow pola spam (`*slot*`, `*gacor*`, `*togel*`, `*.shop*`, `?source=`) → indikasi pernah kena **injeksi SEO spam**, bukan sekadar pencegahan.

### Dependency eksternal (single point of failure)
| Domain | Dipakai untuk |
|---|---|
| cdnjs.cloudflare.com | Font Awesome 4.7.0, Slick Carousel 1.9.0 |
| fonts.googleapis.com / gstatic | **Lora**, Merriweather, Roboto |
| cdn.jsdelivr.net | `d3.layout.cloud` (word cloud) |
| d3js.org | d3 v4 |
| c.statcounter.com | StatCounter (analytics lawas) |
| ibb.co | `background-image: url(https://ibb.co/2shHx0T)` → **URL halaman imgbb, bukan file gambar → CSS rusak** |

---

## 4. Front-end Stack

- **Bootstrap 3** + jQuery + jQuery UI (warisan OJS 3.3).
- Theme `academic_pro3` + override `academic_pro_extended` (Swiper, Slick, sticky, readmore, JATS TOC).
- Font: **Roboto** (body), **Merriweather** (site name), **Lora** (heading), Font Awesome 4.7.
- Palet aktual (computed style):
  - body text `#666666`, judul artikel `#2196f3` (biru), tombol `#6c9304` (hijau olive), footer `#afafaf`, heading kustom `#006060` (teal).
  - **Palet tidak koheren** — biru + hijau + teal + abu bercampur tanpa sistem warna.
- Custom CSS jurnal hanya 959 byte, berisi bug: `color: none;` (invalid) dan background imgbb di atas.

---

## 5. Plugin & Fitur Aktif

**Bawaan/inti OJS**
- OAI-PMH (`/JEKI/oai`), RSS/Atom (Announcement + Web Feed), Crossref/DOI, ORCID, Google Scholar meta tags, usage stats, pdf.js viewer.

**Pihak ketiga (OpenJournalTheme)**
- `ojtBlazingCachePro` 1.4.0.7 — full-page cache.
- `ojtPlugin` — modul `googleScholarCitation` (widget sitasi GS live), `volumeByYear` (arsip lipat per tahun).
- `academic_pro3` / `academic_pro_extended` — theme + bundle.

**Plugin PKP/komunitas**
- `citations` (link Scopus/Crossref/PMC/Scholar), `citationStyleLanguage` (RIS/BibTeX/EndNote), `pflPlugin` (Publication Facts Label), `staticPages` (halaman kustom: `/PeerReviewProcess`, `/JournalHistory`, `/CitednessinScopus`, `/FocusandScope`, dst.), custom blocks (sidebar HTML manual).

**Fitur halaman artikel:** DOI, ORCID per penulis, abstrak, keyword (termasuk **kode JEL** seperti G21/Z12), How to Cite otomatis, daftar referensi dengan link DOI, PlumX, Dimensions citation count, read/download counter, lisensi CC BY-SA 4.0.
**Tidak ada:** full-text HTML (PDF-only), dark mode, kontrol ukuran font, pencarian facet modern.

---

## 6. Struktur Informasi (IA)

**Nav utama:** Home · Current · Archives · Announcements · People (Editorial Team, Reviewer Board) · About (Submissions, Publication Ethics, Privacy, Contact) · Search

**Sidebar (11 blok):** Sinta 2 badge + SK, Journal Information, Information for Author (18 link), AI Usage Policy, Information for Review, Template (Google Docs), Journal Profile (DOAJ/RePEc/Garuda), Tools (Mendeley/Grammarly/Turnitin/APA/JEL), Citations Analysis (Scopus/WoS/Dimensions/GS), In Collaboration With, Web Statistics, Google Scholar Citation, ISSN barcodes, Keyword cloud.

> **Temuan UX:** sidebar memuat ±40 link. Di mobile, ini jadi ekor halaman yang sangat panjang. Tidak ada prioritas informasi — semua setara.

**Halaman kustom (staticPages):** `JournalHistory`, `FocusandScope`, `AbstractingIndexing`, `PeerReviewers`, `PeerReviewProcess`, `PublicationEthics`, `CopyrightandLicenseStatement`, `OpenAccessStat`, `plagiarismPolicy`, `RetractionHandling`, `AppealsComplaintsPolicy`, `ConflictofInterest`, `InformedConsentPolicy`, `DataAvailabilityStatement`, `DigitalArchivingPolicy`, `AdvertisingPolicy`, `APC2`, `FAQ`, `AIPolicy`, `ReviewerGuidelines`, `CitednessinScopus`, `CitednessinWOS`.

---

## 7. Inventaris Konten (dari OAI-PMH, 199 record)

```
Tahun   2011:  7   2016:  –    2022: 21   2025: 20
        2017: 13   2019: 13    2023: 20   2026: 26
        2018: 29   2020: 14    2024: 20
        2021: 14
```
- **24 issue** = Volume 1 (2011, judul issue masih Bahasa Indonesia) → Volume 12 No. 2 (Juli 2026).
- 197/199 record punya DOI; pola **`10.20885/JEKI.vol{n}.iss{n}.art{n}`** (turunan volume/issue, bukan ID artikel).
- Rata-rata **2,49 penulis/artikel**; 519 keyword unik; kode JEL dipakai sebagai keyword disiplin.
- Issue terbaru: 15 artikel (hlm. 207–490).
- Metrik pihak ketiga: Google Scholar 3.442 sitasi, h-index 32, i10 106; Scopus 91 sitasi dari 36 dokumen (update Nov 2024); terindeks DOAJ, SINTA 2, RePEc, ProQuest, Dimensions, EBSCO, Garuda, ROAD, BASE, Neliti, SSRN.
- APC: IDR 2.000.000 (penulis Indonesia), IDR 1.500.000 (kolaborasi asing), **gratis** untuk afiliasi luar negeri. Single-blind review, target keputusan 4 minggu.

---

## 8. Audit UX/UI & Aksesibilitas

**Aksesibilitas**
- ✅ Skip-link, landmark ARIA, `lang` valid.
- ❌ **Dua `<h1>`** di homepage ("Jurnal Ekonomi & Keuangan Islam" + "About Journal") dan lompatan hierarki `H1 → H4` (skip H2/H3).
- ❌ 8 dari 24 gambar tanpa `alt`.
- ❌ Blok "About Journal" di header (4 kolom link) disembunyikan lewat CSS (`.col-md-12.about_journal { display:none }`) — tetap dirender, membebani DOM & screen reader.
- ❌ Kontras: footer `#afafaf` di atas latar terang, judul sidebar `#949494` — di bawah WCAG AA.

**Layout**
- ✅ Tidak ada horizontal overflow di 390 px (mobile OK).
- ⚠️ Hero: logo 1130×210 px (`pageHeaderLogoImage_en_US.png`) + thumbnail jurnal 160×224 GIF (kualitas rendah).
- ⚠️ Announcement carousel 9 item (Slick) + tab manual 1–9 → beban interaksi tinggi untuk konten sekunder.
- ⚠️ Keyword cloud pakai D3 v4 dari CDN eksternal untuk 50 kata — berat untuk nilai informasinya.

**Konten**
- Issue 12(2): editorial panjang tanpa struktur heading, tampil sebagai blok teks rapat.
- Tidak ada rekomendasi artikel terkait, tidak ada "cite this" sticky, tidak ada preview PDF inline yang cepat (redirect ke pdf.js viewer).

---

## 9. SEO & Interoperabilitas

| Item | Status |
|---|---|
| Google Scholar meta (`citation_*`) | ✅ lengkap (title, author, institution, DOI, PDF URL, references) |
| Dublin Core meta | ✅ lengkap |
| OAI-PMH | ✅ `/JEKI/oai`, `oai:ojs.jurnal.uii.ac.id:article/{id}` |
| DOI/Crossref | ✅ 197/199 |
| RSS/Atom | ✅ announcement + web feed |
| `canonical` | ❌ **tidak ada** di semua halaman |
| `og:*` / `twitter:*` | ❌ hanya `og:description` (home kosong); **tidak ada `og:image`** |
| JSON-LD (`ScholarlyArticle`) | ❌ tidak ada |
| `sitemap.xml` | ❌ 404 |
| `hreflang` | ❌ tidak ada (satu bahasa, tidak masalah) |
| Meta description homepage | ❌ kosong (ada dua tag `description`, salah satunya duplikat) |

→ Share ke WhatsApp/LinkedIn/X akan tampil tanpa gambar dan tanpa kartu. Ini kehilangan distribusi terbesar untuk jurnal OA.

---

## 10. Risiko & Utang Teknis

1. **OJS 3.3.0.10 EOL** — tidak ada patch keamanan; upgrade 3.3 → 3.5 wajib lewat 3.4 (DB migration bertahap).
2. **Ketergantungan pada theme komersial** OpenJournalTheme (lisensi, kompatibilitas 3.5 belum tentu).
3. **7 origin eksternal** tanpa SRI/self-host → risiko supply-chain + privasi (Google Fonts, d3js.org, imgbb, StatCounter).
4. **CSS kustom rusak** (`ibb.co` sebagai background, `color:none`).
5. **StatCounter** (analytics lawas, cookie pihak ketiga) — perlu diganti (Plausible/Umami/GA4 sesuai kebijakan).
6. **SEO spam residue** — robots.txt menunjukkan riwayat injeksi; perlu audit URL/index Google.
7. **Multi-tenant** — JEKI berbagi instalasi dengan ~60 jurnal; rebuild terpisah = keluar dari portal UII (hilang cross-linking + SSO kampus).

---

## 11. Opsi Rebuild

### Opsi A — Upgrade + custom theme (rekomendasi)
- OJS dinaikkan ke 3.5.x, theme diganti custom (child theme OJS atau theme resmi `Default`/`Pragma` yang di-restyle).
- Pertahankan semua URL (`/article/view/{id}`, `/issue/view/{id}`, `/oai`), DOI, dan metadata.
- **Effort:** rendah–sedang. **Risiko:** rendah. **Hasil:** modern secara visual, tapi terikat markup OJS.
- Tambahan cepat: canonical, OG image (auto-generate dari cover issue), JSON-LD, sitemap via plugin, self-host font.

### Opsi B — Headless: OJS sebagai backend, front-end baru (Next.js/Astro)
- OJS tetap menangani submission/review/production/DOI/OAI; front-end baca data via **OAI-PMH / OJS REST API** (API 3.3 masih terbatas — 3.5 lebih baik) + cache.
- **Effort:** tinggi. Perlu sinkronisasi cache, redirect 301 per URL, dan pekerjaan ganda saat upgrade.
- Layak hanya jika ada kebutuhan produk yang benar-benar tidak bisa dipenuhi theme OJS (mis. portal multi-jurnal, pencarian semantik, personalisasi).

### Opsi C — Bangun ulang penuh (bukan OJS)
- Berarti membangun ulang: submission wizard, peer review workflow, email template, versioning, production, DOI deposit, OAI, statistik, role/permission.
- **Effort:** 6–12 bulan tim. **Tidak disarankan** — OJS gratis, teruji, dan jadi syarat banyak indeks (DOAJ/SINTA).
- Jika tetap dipilih, minimal: OJS tetap jalan sebagai sistem editorial internal, situs publik jadi "muka" saja (varian Opsi B).

---

## 12. Data Model Minimum untuk Rebuild

```
Journal      (id, title, abbrev, pissn, eissn, doiPrefix, publisher, frequency, apc)
Volume       (number, year)
Issue        (volumeId, number, title, datePublished, coverImage, editorialNote, doi)
Section      (name, policy)                    // "Articles", "Editorial"
Article      (id, issueId, sectionId, title, abstract, keywords[], jelCodes[],
              language, pageStart, pageEnd, doi, license, publishedAt, submittedAt)
Author       (name, orcid, affiliation, country, corresponding, seq)
Galley       (articleId, label, type=pdf|html, fileUrl, seq)
Reference    (articleId, raw, doi, seq)
Stats        (articleId, views, downloads)
Page         (slug, title, body)               // staticPages: 22 halaman
Navigation   (menu, order, label, url, parentId)
```

**URL yang wajib dipertahankan (301 jika berubah):**
```
/JEKI/index
/JEKI/issue/archive
/JEKI/issue/view/{issueId}
/JEKI/issue/view/{issueId}/showToc
/JEKI/article/view/{articleId}
/JEKI/article/view/{articleId}/{galleyId}
/JEKI/article/download/{articleId}/{galleyId}
/JEKI/article/view/{articleId}/{galleyId}/{filename}.pdf
/JEKI/oai
/JEKI/about/*, /JEKI/{StaticPageSlug}
```
DOI `10.20885/JEKI.vol12.iss2.art1` **harus** tetap resolve ke halaman baru — kalau URL berubah tanpa 301, sitasi & Google Scholar putus.

---

## 13. Checklist Migrasi

- [ ] Dump & backup: database OJS, `files/` (PDF galley), `public/journals/49/`.
- [ ] Inventaris 199 artikel + 197 DOI → verifikasi tiap DOI resolve.
- [ ] Export metadata (OAI `oai_dc` + `mods`/`jats` bila tersedia) sebagai arsip netral.
- [ ] Map URL lama → baru, siapkan aturan 301 di edge (Cloudflare).
- [ ] Redirect `/article/download/*` tetap ke file PDF asli (jangan lewat viewer) untuk Google Scholar.
- [ ] Pertahankan `citation_*` meta & `citation_pdf_url`.
- [ ] Submit ulang/pertahankan verifikasi Google Scholar, DOAJ, Crossref, Garuda, SINTA.
- [ ] Uji: 10 artikel acak (view, PDF, cite, references), 5 issue, pencarian, mobile 390 px.
- [ ] Pantau 404 di Search Console 30 hari pertama.

---

## 14. Yang Perlu Dikonfirmasi ke Pemilik Jurnal

1. Apakah rebuild harus tetap di dalam portal `journal.uii.ac.id` (multi-journal UII) atau boleh domain sendiri?
2. Apakah workflow editorial (submission/review) ikut dimigrasi, atau tetap di OJS?
3. Lisensi theme OpenJournalTheme — masih aktif? Boleh dipakai ulang?
4. Siapa pemilik akses: Cloudflare, DNS, server origin, DB OJS, Crossref, DOAJ?
5. Target: sekadar facelift, atau ada fitur baru (multi-bahasa ID/EN, pencarian semantik, integrasi Scopus/SINTA otomatis)?
6. Kebijakan analytics & cookie (StatCounter → apa penggantinya)?

---

## 15. Batasan Riset

- Screenshot tersimpan di `research-assets/home-desktop.png` dan `research-assets/home-mobile.png`, tetapi **tidak dapat dianalisis secara visual** oleh model ini; seluruh penilaian desain di atas diturunkan dari DOM, CSS computed style, dan struktur markup.
- Area admin/editor (dashboard, submission wizard) tidak diakses — butuh kredensial.
- Angka trafik historis tidak tersedia (StatCounter milik pihak ketiga).
