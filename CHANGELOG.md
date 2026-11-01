# Changelog

## 2026-11-02 (sesi 16 — seed tim editorial + perbaiki tautan Tim Editorial)

### Added
- Script `scripts/seed-editorial-team.php` untuk mengisi tim editorial JRDC dengan 5 peran akademis (Editor-in-Chief, Managing Editor, Section Editor, Copy Editor, Layout/Production Editor) beserta nama, afiliasi, dan password bcrypt acak. Idempotent: user/assignment yang sudah ada dilewati.

### Changed
- Grup user default `journal editor`, `journal manager`, `section editor`, `copyeditor`, dan `production editor` di context `jrdc` diaktifkan flag masthead dan di-rename ke peran tim editorial (EN/ID).
- Seluruh tautan "Tim Editorial" / "Editorial Team" di tema `journalEditorial` diarahkan ke route OJS 3.5 yang benar: `about/editorialMasthead` (menggantikan `about/editorialTeam` yang sudah tidak ada di OJS 3.5). File yang diperbaiki: `footer.tpl`, `authorResources.tpl`.

### Fixed
- Halaman `/about/editorialMasthead` kosong karena belum ada user dengan peran editorial; kini menampilkan daftar nama, afiliasi, dan peran.

### Verified
- `/index.php/jrdc/id/about/editorialMasthead` → 200, menampilkan 5 peran: Editor Manajemen, Editor-in-Chief, Editor Tata Letak/Produksi, Editor Bagian, Copy Editor dengan nama dan afiliasi.
- Footer & quick link beranda kini mengarah ke `/about/editorialMasthead`.

## 2026-11-02 (sesi 15 — current issue kosong di beranda)

### Added
- Template `templates/frontend/components/homepage/currentIssue.tpl` untuk menampilkan terbitan terkini sebagai kartu dengan slot cover image yang bisa di-upload admin.
- Locale keys `plugins.themes.journalEditorial.currentIssue.*` (EN/ID).
- Script idempotent `scripts/set-current-issue.php` untuk publish issue (mengisi `date_published`) dan menjadikannya `currentIssueId` jurnal `jrdc`.

### Changed
- `JournalEditorialThemePlugin::assignHomepageData()` kini memastikan variabel `$issue` tersedia: bila OJS belum meng-assign current issue, fallback ke issue terbaru yang sudah dipublish.
- `templates/frontend/pages/indexJournal.tpl` memanggil `currentIssue.tpl` setelah hero.

### Fixed
- Section "Terbitan Terkini" / "Current Issue" di beranda kosong karena `currentIssueId` belum di-set setelah import; kini Vol. 1 No. 1 (2011) menjadi current issue.

### Verified
- `/index.php/jrdc/id/` menampilkan section "Terbitan Terkini" dengan judul issue dan tautan ke `/issue/view/1`.
- `/index.php/jrdc?id=index&setLocale=en` menampilkan section "Current Issue" dengan versi bahasa Inggris.

## 2026-11-01 (sesi 14 — perbaiki URL Kirim Naskah / Submit)

### Fixed
- Semua tautan "Kirim Naskah" / "Submit" di tema `journalEditorial` kini mengarah ke `{url page="submission"}` (route OJS 3.5 yang benar untuk memulai submission wizard baru).
- File yang diperbaiki: `hero.tpl`, `authorResources.tpl`, `footer.tpl` (sebelumnya salah memakai `op="submit"` yang memunculkan 404).

### Verified
- Homepage `/index.php/jrdc` (ID & EN) merender href `/index.php/jrdc/submission` pada tombol hero, quick link, dan footer.
- Tautan valid saat pengguna belum login (OJS mengarahkan ke halaman login terlebih dahulu).

## 2026-11-01 (sesi 13 — hapus link Author Fees dari footer)

### Removed
- Tautan "Author Fees" / "Biaya Penulis" dan locale key `plugins.themes.journalEditorial.footer.fees` (EN/ID) dihapus dari footer tema `journalEditorial`.

### Verified
- Footer tidak lagi menampilkan link biaya penulis di locale EN maupun ID.

## 2026-11-01 (sesi 12 — h1 konsisten, a11y 100, CLS 0, pembersihan hardcoded URL)

### Added
- Override template `issueArchive.tpl`, `search.tpl`, `announcements.tpl` di tema (hapus `<h1>` kosong/duplikat).
- CSS override dropdown hover/focus: hapus garis biru (`border-color: #006798`) dari `.pkp_nav_list ul a`, background hover transparan.
- `scripts/fix-hardcoded-urls.sql` (seed pembersihan domain/brand).

### Changed
- Header banner h1 kini render juga di halaman issue (identifikasi issue sebagai judul tunggal).
- Hero `min-height: 520px` + stats bar `transform` (bukan `margin-top`) untuk CLS 0.
- Kontras: hero button teks gelap, `.jilp-article-category` & badge subtle → `#b91c1c`, footer ISSN label teks gelap.
- Link "Read more" → "About the journal"/"View full announcement" (Lighthouse link-text).
- Meta description + theme-color di `headerHead.tpl`; skip link target `#jilpNavMenu`.
- Semua hardcoded URL/domain/brand (jeki-ojs.ddev.site, AKDISI, akdisi.my.id) di scripts, plugin, template, docs dibersihkan → dinamis/relatif (JRDC, jrdc.my.id).
- Journal settings (name, contactEmail, supportEmail, publisherInstitution, dll.) diperbarui ke JRDC.

### Fixed
- Halaman issue/archive/announcement/search: h1 ganda (2) atau kosong (0) → tepat 1.
- `color-contrast` dan `skip-link` Lighthouse → 100/100 a11y.
- `meta-description` dan `link-text` → SEO 100.

### Verified
- Lighthouse: Performance 94, Accessibility 100, Best Practices 100, SEO 100, CLS 0, LCP 2.5s.
- 20 halaman statis × EN/ID → 200; home, artikel, issue → 200; logs bersih.
- Paket `dist/journalEditorial-theme.{tar.gz,zip}` dibangun ulang (0.1.1.5).
- Merge `dev` → `main` selesai; working tree clean.

## 2026-11-01 (sesi 11 — halaman statis + sinkronisasi plugin staticPages resmi)

### Added
- Plugin resmi `staticPages` (namespaced, dari OJS 3.5.0-5) disinkronkan ke `plugins/generic/staticPages` + symlink, menggantikan copy lama non-namespaced yang tidak bisa di-instantiate.
- `content.tpl` plugin dioverride agar konsisten dengan tema journalEditorial (banner breadcrumb + `.jilp-prose`).
- Konten 20 halaman statis diisi EN/ID standar akademik (COPE/OASPA/DOAJ-aligned) untuk JRDC (Ekonomi & Bisnis): about, focus-and-scope, author-guidelines, submission-preparation, publication-ethics, peer-review-process, open-access-statement, copyright-and-license, plagiarism-policy, indexing, archive-policy, author-fees, contact-us, generative-ai, privacy-policy, editorial-team, reviewer, reviewer-guide, loa, faq.
- Footer: tautan ke focus-and-scope, indexing, author-fees; kunci locale baru `footer.focusScope`, `footer.indexing`, `footer.fees` (EN/ID).
- `scripts/gen_static_content.py` + `scripts/static-content.sql` (seed konten).

### Fixed
- Plugin `staticPages` tidak aktif karena copy lama non-namespaced; kini memakai versi resmi 3.5 (lazy_load=0).
- Cache Laravel stale menyebabkan `getSetting('enabled')` mengembalikan null — dibersihkan.
- Nginx rewrite `/sitemap.xml` dari `JEKI` → `jrdc` (sitemap 200).
- Enable `citationStyleLanguage` dan `customBlockManager` (PRD §5); disable `jatsTemplate`, `htmlArticleGalley`, `lensGalley` (PRD §5 OFF).

### Verified
- 40 URL statis (20 halaman × EN/ID) → 200.
- `/sitemap.xml` → 200.
- Home, artikel, issue → 200; logs bersih.

## 2026-11-01 (sesi 10 — palet kustom, breadcrumb seragam, PDF embed, konten JRDC)

### Added
- Palet kustom `#ff5f00` / `#d9302c` / `#eaa23f` diterapkan ke seluruh CSS tema (variabel, tombol, hero, badge, footer, dark mode).
- `article_pdf_embed.tpl` — iframe PDF langsung di halaman artikel (`/article/view/{id}/{galley}`).
- 5 PDF lokal dilampirkan ke galley (sumber jurnal UII) agar embed berfungsi offline.
- Tombol "baca selengkapnya" hero (`.jilp-hero-readmore`) dan kelas `.jilp-pdf-section`.

### Changed
- Banner breadcrumb seragam: `header.tpl` menampilkan satu breadcrumb untuk semua halaman dalam; breadcrumb ganda (`cmp_breadcrumbs`) disembunyikan.
- Breadcrumb artikel: Beranda / Arsip / Issue / Artikel; issue: Beranda / Arsip / Issue; judul banner disembunyikan di artikel & issue.
- "Why Publish With Us" diubah ke `jilp-features-grid` (2 kolom) ala modern-css.com.
- Footer ditulis ulang sebagai grid (brand + 3 kolom tautan) + baris copyright/kredit.
- Tab "Tentang" memakai data dinamis: `$jilpAbout` (journal `about`), `$jilpFocusScope`, `$jilpEditorialTeam`, `$jilpIndexers`, `$jilpContactUrl` dari pengaturan jurnal/admin.
- Plugin membaca pengaturan `akdisiFocusScope`, `akdisiEditorialTeam`, `akdisiContactUrl`, `akdisiIndexers` (fallback ke `jilp*` custom) dan `about`.
- Konten JRDC (Ekonomi & Bisnis) disimpan di `journal_settings.about` (EN/ID), scope & komitmen editorial di `akdisiFocusScope`/`akdisiEditorialTeam`.
- Hero fallback memakai `jilp.hero.fallbackDesc`; tautan "baca selengkapnya" memakai `.jilp-hero-readmore`.
- `parseIndexers()` mendukung HTML legacy (strip tags) selain JSON/koma.
- `allowed_hosts` tetap `["your-domain.example"]`.

### Fixed
- Banner inner tidak lagi muncul di beranda (bug `$requestedPage` kosong → diperlakukan sebagai `index`).
- Duplikasi breadcrumb di arsip/issue/tentang/pencarian disembunyikan.
- Tautan PDF galley kini menunjuk ke file lokal (sebelumnya remote URL artikel sumber).
- Deprecation `PKP\core\PKPApplication::ROUTE_PAGE` di template dihapus (drop `router=`).
- `about` page tidak lagi kosong; konten diambil dari pengaturan jurnal.

### Verified
- 200 untuk `/`, `/issue/archive`, `/issue/view/1`, `/article/view/1..5`, `/about`, `/announcement`, `/search`, `/login`, `/user/register` (ID & EN).
- PDF iframe muncul di `/article/view/2` (`jilp-pdf-section`).
- `ddev logs` bebas dari PHP Fatal/Warning (hanya deprecation yang sudah dibersihkan).
- Paket `dist/journalEditorial-theme.{tar.gz,zip}` dibangun ulang (release 0.1.1.4).

## 2026-10-31 (sesi 9 — halaman dalam tema journalEditorial + pass CSS modern)

### Added
- `header.tpl`: banner halaman dalam bergaya JILP — gradien pink + pola SVG,
  breadcrumb `Beranda / <judul>` dan `<h1>` putih untuk semua halaman kecuali
  beranda; halaman artikel hanya breadcrumb (judul tetap di `article_details`).
  `pkp_structure_main` dapat class `jilp-inner` saat banner tampil.
- `templates/frontend/objects/issue_summary.tpl` — kartu issue Bootstrap
  (cover/fallback ikon, judul, series, tanggal `$dateFormatShort`).
- `scripts/announcements.sql` — aktifkan `enableAnnouncements`, intro EN/ID,
  dan 2 pengumuman dua bahasa (`descriptionShort` ikut diisi untuk ringkasan).
- `scripts/journal-content.sql` — seed `about` (EN/ID), kontak primer &
  dukungan, alamat, penerbit, ISSN, serta judul/kebijakan section EN/ID.
  Keduanya dipanggil di akhir `scripts/install.sh`.
- `JournalEditorialThemePlugin`: `$announcements` (3 pengumuman aktif terbaru)
  di-assign di `assignHomepageData()` sehingga tab "Pengumuman" beranda terisi.

### Changed
- `journalEditorial.css`: bagian "Inner pages" baru — shell 1180px tanpa sidebar,
  kartu putih untuk halaman prosa, tipografi prosa, form (pill pink), kartu hasil
  pencarian, grid arsip issue, kartu pengumuman, masthead, kontak, alert, dan
  pagination; plus override dark-mode lengkap.
- Pass CSS modern (rujukan modern-css.com): `color-scheme` light/dark +
  `accent-color`, `text-wrap: balance` untuk heading & `pretty` untuk paragraf,
  properti logis (`margin-inline-*`, `border-inline-start`, `inset`,
  `text-align: start/end`), sintaks range media query (`width < 992px`),
  `line-clamp` standar, `:focus-visible`, `:user-invalid` untuk validasi form,
  dan `@media (prefers-reduced-motion: reduce)`.
- `footer.tpl`: nama jurnal tidak lagi tampil dua kali saat belum ada logo.
- `install.sh`: `display_errors = Off` di `config.inc.php` agar deprecation/fatal
  PHP tidak tercetak di atas markup halaman (contoh nyata: notice
  `DublinCoreMetaPlugin.php:220` dan fatal `function.mailto.php` pada /contact).

### Fixed
- `/about`, `/about/contact`, `/about/privacy`, `/about/submissions` tidak lagi
  kosong; kontak & ISSN tersimpan dengan locale `''` (bukan per-locale) supaya
  `getData()` mengembalikan string, bukan array — sebelumnya memicu
  `TypeError: htmlspecialchars(): Argument #1 must be of type string, array given`
  di plugin googleScholar & dublinCoreMeta.
- TOC issue: heading section tidak lagi mengambang di atas garis negatif-margin
  bawaan theme default; diganti heading datar dengan garis bawah pink.
- Halaman kontak: clearfix `::before/::after` theme default ikut jadi grid item
  (menyisakan kolom kosong) dan float 50% mengecilkan kartu — direset.
- Margin heading di `/about/submissions`: `:first-child` dibatasi ke anak
  langsung `.page`, sehingga heading di dalam blok konten dapat jarak atas.
- Dark mode: surface `.page` tidak lagi membungkus halaman yang di light mode
  transparan (arsip/issue/artikel/pencarian/pengumuman); heading TOC, nomor
  halaman, tombol galley, dan pagination kini terbaca.

### Verified
- 200 untuk `/issue/archive`, `/issue/view/1`, `/article/view/1`, `/about`,
  `/about/contact`, `/about/privacy`, `/about/submissions`,
  `/about/editorialMasthead`, `/announcement`, `/announcement/view/2`, `/search`,
  `/login`, `/user/register` (ID) dan versi EN via `?setLocale=en`.
- Screenshot desktop 1440px, mobile 390px, dan dark mode untuk arsip, issue,
  artikel, tentang, kontak, penyerahan, pengumuman, pencarian, login, daftar.
- `ddev logs --since 6m` bersih dari PHP Fatal/Warning/TypeError setelah seed.

## 2026-10-31 (sesi 8 — lokalisasi penuh tema journalEditorial EN/ID)

### Changed
- Seluruh teks antarmuka tema dipindah dari hardcoded English ke
  `{translate key="plugins.themes.journalEditorial.*"}` (94 penggantian di
  9 template: header, footer, hero, statistics, editorPicks, articleCard,
  issueCard, indexing, authorResources, whyPublish, tabs).
- `locale/en/locale.po` & `locale/id/locale.po` dibuat (97 entri masing-masing),
  jadi bahasa mengikuti `currentLocale` saat pembaca mengganti bahasa, bukan
  dipaksa Indonesia.
- `articleCard.tpl` memakai `{if $article->section}` / `{if $article->authors}`
  agar fallback terjemahan tetap jalan (`default:` tidak bisa membungkus tag
  `{translate}`).
- Footer: label "Editorial Team" pada kolom Tentang ikut diterjemahkan
  (sebelumnya terlewat karena hanya kemunculan pertama yang diganti).

### Fixed
- Footer menampilkan `© %2026` — Smarty `date_format` memakai format `date()`
  (bukan `strftime`), jadi `"%Y"` menghasilkan `%2026`; diganti `"Y"`.

### Verified
- `/index.php/JRDC/id` = "Pilihan Editor", "Terbitan Terkini", "Untuk Penulis
  & Peneliti", "Mengapa Menerbitkan di Sini", footer "Tautan Cepat / Tentang /
  Untuk Penulis / Kontak & Kantor Redaksi", "© 2026 Akdisi. Seluruh hak cipta
  dilindungi."
- `/index.php/JRDC/en` tetap menampilkan versi Inggris ("Editor's Pick",
  "Current Issue", "No announcements", "All rights reserved").
- Screenshot 1440px kedua locale + footer: tidak ada key mentah
  (`plugins.themes.journalEditorial.*`) yang bocor ke HTML.
- `dist/journalEditorial-theme.{tar.gz,zip}` dibangun ulang dengan
  `./scripts/package.sh --bump` (release 0.1.1.2) dan berisi kedua `locale.po`.

## 2026-10-31 (sesi 7 — tema journalEditorial bergaya JILP / Zenith Pro)

### Added
- Theme `journalEditorial` ditulis ulang mengikuti referensi JILP
  (`e-journal.sastra-unes.com/index.php/JILP`): Bootstrap 5.3.3 + Bootstrap
  Icons di-host lokal di dalam tema, hero gelap dengan cover issue, stat strip
  melayang, kartu Editor's Pick, area tab (Latest / Most Viewed / Most Cited /
  Issues / Announcements / About / Editorial & Indexing), grid indexing,
  quick links penulis, kartu Why Publish, dan footer 5 kolom.
- `templates/frontend/components/header.tpl` & `footer.tpl` — shell Bootstrap
  (navbar sticky, search, toggle dark mode, footer lengkap).
- Partial homepage: `articleCard.tpl`, `issueCard.tpl`, `tabs.tpl`,
  `hero.tpl`, `statistics.tpl`, `editorPicks.tpl`, `indexing.tpl`,
  `authorResources.tpl`, `whyPublish.tpl`.
- `js/journalEditorial.js` — toggle dark mode (localStorage). Tanpa dependensi.
- Token warna pink `#ec4899`, font Outfit (heading) + Inter (body),
  dark mode penuh.

### Changed
- `JournalEditorialThemePlugin` memakai collector `Repo` (submission, issue,
  section, user) untuk artikel, issue, statistik, dan nama penulis;
  custom setting `jilpIndexers` / `jilpFocusScope` / `jilpEditorialTeam` /
  `jilpContactUrl` dibaca dari `journal_settings`.
- Statistik keempat memakai jumlah issue terbit (bukan angka "hari rata-rata"
  yang hardcoded); jumlah penulis dihitung dari author publication terbit.
- Tanggal di kartu memakai `$dateFormatShort` bawaan OJS (sebelumnya
  `date_format:"%Y-%m-%d"` menghasilkan `%2017-%10-%10`).

### Removed
- Template sisa design Stitch/maroon yang tidak terpakai: `aboutJournal`,
  `backToTop`, `floatingActions`, `currentIssue`, `indexers`,
  `latestBySection`, `publicationTimeline`, `sidebar`, `statsStrip`,
  `homepage/{announcements,currentIssue,journalIdentity,latestArticles,publicationFlow}`.

### Verified
- `./scripts/reset.sh` bersih lalu import ulang `import/xml/issue-937.xml`
  (5 artikel + 1 issue); homepage, artikel, issue, archive, dan sitemap 200.
- Screenshot desktop 1440px, mobile 390px, dan dark mode: hero, stat strip,
  4 kartu Editor's Pick, 5 kartu artikel, tab, indexing, quick links, footer
  tampil tanpa error.
- `?slots` tidak lagi dipakai; tidak ada request ke domain eksternal
  (font Google sudah tidak dipakai, Bootstrap lokal).

## 2026-10-31 (sesi 5 — reset ke nol, pemisahan plugin/tema kustom & panduan import)

### Added
- `scripts/package.sh`: Skrip pemaket otomatis seluruh tema dan plugin ke dalam arsip `.tar.gz` (standar PKP) dan `.zip` di folder `dist/` dengan opsi `--bump` untuk menaikkan versi release secara otomatis agar lolos validasi tombol Upgrade OJS.
- `scripts/reload-plugins.sh`: Skrip sinkronisasi instan plugin & tema kustom ke OJS lokal tanpa perlu re-upload (symlink check, DB version register, cache purge).
- `dist/akdisi-theme.tar.gz`, `dist/akdisi-theme.zip`, `dist/akdisi-seo.tar.gz`, `dist/akdisi-seo.zip`: Paket distribusi terverifikasi valid terhadap `PluginHelper::installPlugin`.
- `scripts/reset.sh`: Pipeline 1-perintah untuk reset total instance OJS ke kondisi awal bersih (0 issue, 0 submission) siap untuk praktek import manual.
- Komponen `floatingActions.tpl` (S-HOME-15) untuk quick actions (WhatsApp link via custom setting `akdisiContactUrl` + back to top).
- Penyesuaian `scripts/create-journal.php`: menggunakan facade `Repo::section()` (standar OJS 3.5) menggantikan deprecated SectionDAO.

### Changed
- Rebranding menyeluruh dari JEKI ke **Akdisi** (`https://jrdc.my.id/`): tema `akdisi`, plugin `akdisiSeo`, context path `JRDC`, admin `admin / akdisi-admin`.
- Pemisahan bersih kode kustom: seluruh preset tema (`plugins/themes/akdisi/`) dan generic plugin (`plugins/generic/akdisiSeo/`) tersimpan terpisah di luar folder core OJS (`ojs/`) dan dihubungkan via symlink yang otomatis diregister.
- Palette tema diperbarui ke warna **Maroon / Burgundy** (`#af2e4d`) dengan efek hero typewriter CSS murni.
- `docs/TUTORIAL.md` & `README.md` ditulis ulang dengan panduan lengkap: arsitektur pemisahan, cara reset ke nol, praktek import manual (CLI & GUI) menggunakan `import/xml/issue-937.xml`, serta manipulasi custom blocks dan static pages.

### Verified
- `./scripts/reset.sh` tereksekusi mulus tanpa error: DB bersih, 0 submission, 0 issue.
- Beranda `https://your-domain.example:8443/index.php/JRDC/en` status 200, tema `akdisi` aktif dengan CSS maroon dan 14 blok slot utuh.
- Symlink `ojs/plugins/themes/akdisi` dan `ojs/plugins/generic/akdisiSeo` valid.
- Kredensial login admin `admin` / `akdisi-admin` aktif.

## 2026-10-31 (sesi 4 — blocks & static pages)

### Added
- Skill `ojs-expert` (dari `global-prog/ojs-claude-skill`) di-install lokal di
  `.agents/skills/ojs-expert` — referensi OJS 3.4/3.5 (plugin, theme, hooks,
  REST API, konstanta).
- Theme `akdisi` diaktifkan sebagai tema utama (sebelumnya `classic`).
- Struktur block per folder di `plugins/themes/akdisi/templates/frontend/components/`:
  `hero.tpl`, `statsStrip.tpl`, `aboutJournal.tpl`, `indexers.tpl`,
  `latestBySection.tpl`, `currentIssue.tpl`, `sidebar.tpl`,
  `publicationTimeline.tpl`, `backToTop.tpl`, `footer.tpl`.
- `AkdisiThemePlugin::assignHomepageData()` mengisi data semua block:
  `$akdisiLatestArticles`, `$akdisiStats`, `$akdisiIndexers`, `$akdisiFocusScope`,
  `$akdisiEditorialTeam`, `$akdisiTemplateFile`. Custom settings dibaca langsung
  dari `journal_settings` karena SchemaDAO hanya memuat key yang terdaftar di
  schema.
- `publicationTimeline.tpl` — 6 langkah editorial workflow (S-HOME-13).
- `backToTop.tpl` + `slots.js` — tombol kembali ke atas.
- Static pages skeleton (20 halaman) via `scripts/static-pages.sql`.
- Demo custom blocks via `scripts/akdisi-custom-blocks.sql`.
- `docs/TUTORIAL.md` — dokumentasi lengkap cara kerja block, custom settings,
  static pages, navigation menu, SEO, dan troubleshooting.

### Changed
- `AkdisiSeoPlugin` diperbaiki: lazy-load `0`, route `sitemapxml` (OJS menghapus
  titik), `Locale::getLocale()` via facade, `getTemplateVars()` untuk Smarty 4,
  `getData('authors')` & `getData('keywords')` untuk publication OJS 3.5.
- `headerHead.tpl` theme `akdisi` mengambil alih canonical + Open Graph;
  generator OJS dihapus lewat regex `load_header`.
- `styles/akdisi.css` ditulis ulang: token, layout asimetris hero, stats strip,
  timeline, sidebar, indexers, footer, back-to-top, mobile collapse.

### Verified
- Semua slot S-HOME-02..14 muncul dengan `?slots=1`.
- Homepage 200, canonical + OG + JSON-LD Periodical, generator versi OJS hilang.
- `/article/view/1` 200, canonical + OG + JSON-LD ScholarlyArticle, generator
  versi OJS hilang.
- `/sitemap.xml` 200 berisi 7 URL.
- Static page `/about` 200 dengan title & placeholder content.
- Tidak ada request ke domain eksternal selain `schema.org` di JSON-LD.

## 2026-10-29 (sesi 3 — rebuild)

### Changed
- **Rebuild total OJS atas permintaan user**: `ojs/` dihapus + `scripts/` &
  `tasks/` ikut hilang (tidak diketahui siapa penghapusnya). Ditulis ulang
  `setup.sh`, `create-journal.php`, `register-plugins.php`, dan script baru
  `install.sh` (pipeline instal non-interaktif, idempotent).
- DB di-drop dan diinstal bersih: OJS 3.5.0-5, admin `admin / akdisi-admin`,
  base_url + `allowed_hosts = ["your-domain.example"]`.
- **Tema klasik dipasang** (official theme PKP). OJS 3.5 fresh TIDAK membawa
  theme classic (3.4/3.3 tarball juga tidak) → tarik release resmi
  `pkp/classic v1_1_3-2` untuk OJS 3.5, taruh di `ojs/plugins/themes/classic`,
  daftarkan versi, aktifkan via `journal_settings.themePluginPath='classic'`.

### Fixed
- Installer OJS meng-escape baris `allowed_hosts` menjadi `"[\"\"]"`
  (list kosong → semua host ditolak 400). Script install kini menulis
  kembali JSON yang benar setelah instalasi.
- Register plugin di CLI sering mati di tengah loop karena BrowseBlockPlugin
  gagal tanpa request context — workaround: registrasi plugin baru disasarkan
  kategori yang diperlukan (theme/classic, generic/akdisiSeo, themes/akdisi).

### Verified
- Homepage 200, stylesheet classic `app.min.css` ter-serve.
- Import ulang 5 artikel demo lokalisasi: submission 1–5 ↔ publication 1–5,
  semua `current_publication_id` terlink; issue Vol.1 No.1 (2011) id 1.
- `/article/view/1`, `/article/view/4`, `/sitemap.xml` 200.
- Sitemap memuat 18 URL (bawaan OJS route `Success` kini aktif — akdisiSeo
  plugin default tombol memakai handler sendiri; akdisiSeo butuh enable row).
- Metadata artikel: core OJS set `citation_*` + `DC.*` (jalan atas theme
  apa pun). **JSON-LD & OG tags dari override theme `akdisi` tidak lagi aktif**
  karena tema bertukar ke `classic` (by design menukar theme). Pindahkan ke
  generic plugin kalau kamu harus melakukan best practice SEO.

### Notes
- Login admin: `https://your-domain.example:8443/index.php/JRDC/en/login`
  (`admin` / `akdisi-admin`) — rootless Docker memeberkan port `:8443`.
- Sanguline install dari sesi sebelumnya ikut terhapus bersama `ojs/`;
  zip sumber di `tasks/` juga sudah tidak ada di disk.
- Import pipeline: `ddev exec bash -c 'cd ojs && php tools/importExport.php
  NativeImportExportPlugin import ../import/xml/issue-937.xml JRDC --user_name admin'`.

## 2026-10-29 (sesi 2)

### Added
- Import Native XML pertama berhasil: issue "Vol. 1 No. 1 (2011)" + 5 artikel
  (submission 16–20, publication 11–15, semua `current_publication_id` terlink).
- `AkdisiThemePlugin::assignHomepageData()` — hook `TemplateManager::display`
  mengisi `$akdisiLatestArticles` (6 artikel terbit terbaru) untuk grid S-HOME-07.
- `AkdisiSeoHandler` — sitemap kini memuat issue + artikel terbit (7 URL).
- `create-journal.php` — blok idempotent menstandardisasi abbrev section
  (konvensi `SECTION_REF = UPPERCASE_NO_SPACE`) agar import Native XML match.

### Fixed
- Importer horor berlapis (root cause Native XML):
  1. `NativeXmlPublicationFilter` cocokkan `section_ref` dengan **abbrev**,
     bukan title → publication tak dibuat (0 publications). Fix: standardisasi
     abbrev `ARTICLES` di DB + konverter tulis `<abbrev>` di blok section
     (urut: id → abbrev → title, sesuai XSD).
  2. `currentPublicationId` hanya ditautkan bila `<id type="internal">`
     berada **di dalam `<publication>`** dan cocok dengan attr
     `current_publication_id` pada `<article>` → konverter kini menulis keduanya.
  3. `Section::setAbstractWordCount()` string null → konverter kini selalu
     menulis `abstract_word_count="0"` pada section.
- `indexJournal.tpl` — key locale salah (`journal.noIssues` → `issue.noIssues`,
  `plugins.blocks.browse` → `navigation.categories.browse`, `common.file`
  (jelas tak ada) → teks statis "Article Template").
- Verifikasi pasca-import: `/article/view/16|17` 200 + JSON-LD
  `ScholarlyArticle`; sitemap 200; `?slots=1` 200 dengan slot marker utuh.

### Changed
- Referensi demo beralih PERMINTAAN USER: full scrape journal.uii.ac.id/JRDC
  (199 artikel) DIBATALKAN tengah jalan; demo memakai data lokal
  `articles.json` (5 artikel, issue 937) yang sudah tercache. `sample.json`
  rencana lama tidak pernah ada di disk → dipakai `articles.json`.
- README.md — dokumentasi impor CLI (`ddev exec` + `--user_name admin`).
- docs/overrides.md — lintas override theme `akdisi` dicatat (sebelumnya
  klaim "belum ada", padahal 4 template sudah).

### Notes
- fatal `getLocalizedTitle() on null` di CLI toolkit hilang setelah
  fix no. 2; issue & artikel tampil normal di UI.
- Referensi desain/fitur berikutnya: jurnal.padangtekno.com/jocstec (theme
  `technology`, homepage tanpa JSON-LD/OG/citation meta/canonical — build
  kita sudah lebih kaya metadata; fitur jocstec yang bisa ditiru: cloud
  Keywords, visitor stats, blok Journal Template, badge Accredited/MOU).


### Added
- `tasks/prd-ojs-rebuild.md` — PRD lengkap: arsitektur, slot konten, matriks
  plugin, impor, SEO, perbandingan dengan situs referensi.
- Bootstrap OJS 3.5.0-5 (rilis resmi PKP) di `ojs/`, tidak di-commit.
- DDEV: PHP 8.3, MariaDB 11.8, nginx-fpm, fix `PATH_INFO`.
- `scripts/setup.sh` untuk menarik OJS secara reproducible.
- `.gitignore`, `README.md`.
- Theme skeleton `plugins/themes/akdisi/` (child of default, plain CSS + token).
- `import/fetch.py` — scraper OAI + HTML meta, output articles.json.
- `import/to_native_xml.py` — konverter Native XML (valid terhadap XSD).
- `plugins/generic/akdisiSeo/` — plugin sitemap XML + rewrite `/sitemap.xml`.
- `scripts/create-journal.php`, `scripts/register-plugins.php`.

### Changed
- `.ddev/nginx/ojs.conf` — tambah rewrite `/sitemap.xml`.
- `scripts/setup.sh` — patch skip unduhan dataset ROR saat instalasi dev.

### Notes
- Instalasi OJS memakai `allowed_hosts = ["your-domain.example"]`.
- Dataset ROR (~40 MB) dilewati di dev; aktifkan lagi untuk produksi.

## 2026-10-31 (sesi 6 — tema journalEditorial JILP-inspired)

### Added
- Theme `journalEditorial`: child theme baru berbasis Default Theme dengan homepage modular ala JILP:
  hero, statistics strip, Editor's Pick, Latest Articles, Current Issue, Announcements,
  Journal Identity, Indexing, For Authors, Why Publish Here.
- Design tokens: primary #18324b, accent #267c78, container 1180px, radius 10px.
- Template partials di `templates/frontend/components/homepage/`.
- Paket distribusi `dist/journalEditorial-theme.tar.gz` dan `.zip`.

### Fixed
- Bug aktivasi tema: `setParent('defaultthemeplugin')` (bukan 'default') agar CSS/JS/template parent termuat.
- Bug plugin name mismatch: `journaleditorialthemeplugin` (satu 't') agar match dengan `LOWER(product_class_name)`.
- Smarty object access: gunakan `->` bukan `.` untuk stdClass di template.
