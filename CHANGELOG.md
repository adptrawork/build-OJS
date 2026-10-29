# Changelog

## 2026-10-29 (sesi 3 — rebuild)

### Changed
- **Rebuild total OJS atas permintaan user**: `ojs/` dihapus + `scripts/` &
  `tasks/` ikut hilang (tidak diketahui siapa penghapusnya). Ditulis ulang
  `setup.sh`, `create-journal.php`, `register-plugins.php`, dan script baru
  `install.sh` (pipeline instal non-interaktif, idempotent).
- DB di-drop dan diinstal bersih: OJS 3.5.0-5, admin `admin / jeki-admin`,
  base_url + `allowed_hosts = ["jeki-ojs.ddev.site"]`.
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
  kategori yang diperlukan (theme/classic, generic/jekiSeo, themes/jeki).

### Verified
- Homepage 200, stylesheet classic `app.min.css` ter-serve.
- Import ulang 5 artikel demo lokalisasi: submission 1–5 ↔ publication 1–5,
  semua `current_publication_id` terlink; issue Vol.1 No.1 (2011) id 1.
- `/article/view/1`, `/article/view/4`, `/sitemap.xml` 200.
- Sitemap memuat 18 URL (bawaan OJS route `Success` kini aktif — jekiSeo
  plugin default tombol memakai handler sendiri; jekiSeo butuh enable row).
- Metadata artikel: core OJS set `citation_*` + `DC.*` (jalan atas theme
  apa pun). **JSON-LD & OG tags dari override theme `jeki` tidak lagi aktif**
  karena tema bertukar ke `classic` (by design menukar theme). Pindahkan ke
  generic plugin kalau kamu harus melakukan best practice SEO.

### Notes
- Login admin: `https://jeki-ojs.ddev.site:8443/index.php/JEKI/en/login`
  (`admin` / `jeki-admin`) — rootless Docker memeberkan port `:8443`.
- Sanguline install dari sesi sebelumnya ikut terhapus bersama `ojs/`;
  zip sumber di `tasks/` juga sudah tidak ada di disk.
- Import pipeline: `ddev exec bash -c 'cd ojs && php tools/importExport.php
  NativeImportExportPlugin import ../import/xml/issue-937.xml JEKI --user_name admin'`.

## 2026-10-29 (sesi 2)

### Added
- Import Native XML pertama berhasil: issue "Vol. 1 No. 1 (2011)" + 5 artikel
  (submission 16–20, publication 11–15, semua `current_publication_id` terlink).
- `JekiThemePlugin::assignHomepageData()` — hook `TemplateManager::display`
  mengisi `$jekiLatestArticles` (6 artikel terbit terbaru) untuk grid S-HOME-07.
- `JekiSeoHandler` — sitemap kini memuat issue + artikel terbit (7 URL).
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
- Referensi demo beralih PERMINTAAN USER: full scrape journal.uii.ac.id/JEKI
  (199 artikel) DIBATALKAN tengah jalan; demo memakai data lokal
  `articles.json` (5 artikel, issue 937) yang sudah tercache. `sample.json`
  rencana lama tidak pernah ada di disk → dipakai `articles.json`.
- README.md — dokumentasi impor CLI (`ddev exec` + `--user_name admin`).
- docs/overrides.md — lintas override theme `jeki` dicatat (sebelumnya
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
- Theme skeleton `plugins/themes/jeki/` (child of default, plain CSS + token).
- `import/fetch.py` — scraper OAI + HTML meta, output articles.json.
- `import/to_native_xml.py` — konverter Native XML (valid terhadap XSD).
- `plugins/generic/jekiSeo/` — plugin sitemap XML + rewrite `/sitemap.xml`.
- `scripts/create-journal.php`, `scripts/register-plugins.php`.

### Changed
- `.ddev/nginx/ojs.conf` — tambah rewrite `/sitemap.xml`.
- `scripts/setup.sh` — patch skip unduhan dataset ROR saat instalasi dev.

### Notes
- Instalasi OJS memakai `allowed_hosts = ["jeki-ojs.ddev.site"]`.
- Dataset ROR (~40 MB) dilewati di dev; aktifkan lagi untuk produksi.
