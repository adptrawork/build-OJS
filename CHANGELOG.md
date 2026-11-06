# Changelog

## 2026-11-06 — Responsif prototipe + hapus label sampul
- Hapus “Vol. 1 No. 1 · 2026 / Edisi Perdana” dari kartu sampul hero (termasuk caption duplikatnya).
- Responsif: breakpoint menu hamburger dinaikkan 768→1024px (header tablet 834px sebelumnya pecah 3 baris); target sentuh menu ponsel ≥44px; meta hero ditumpuk di ≤768px; sampul ≤260px di ponsel; padding kartu & jarak konten dikurangi di ponsel. Terverifikasi via agent-browser di 1440/1024/834/768/375/360px — tanpa overflow horizontal, menu & dropdown ponsel berfungsi.

## 2026-11-06 — Prototype beranda JRDC direvisi (design-taste-frontend)
- `docs/prototype/index.html` + `styles.css` + `script.js` direvisi dari panduan UI:
  satu bahasa (Indonesia), satu menu utama (chip hero & duplikasi Latest/Current dihapus),
  klaim indeks diganti status "dalam proses", statistik manual/"Dibaca" dihapus,
  ISSN/DOI/alamat/telepon placeholder diganti status jujur, sampul CSS tanpa gambar eksternal,
  palet #143C5A/#B23A00, font Manrope+Lora, GSAP/Lenis diganti CSS+vanilla JS, menu ponsel.
- Backup: `/mnt/DiskD/Workspace/Backups/ojs-prototype/`.

## 2026-11-06 — Downgrade to OJS 3.3.0-24 + port themes

- Deleted OJS 3.5 install; installed OJS 3.3.0-24 (PHP 8.1, MariaDB 10.6).
- Ported `journalEditorial` and `akdisi` themes from OJS 3.5 APIs to OJS 3.3:
  - Removed namespaces/`use`; `Hook::add` → `HookRegistry::register`; `Locale::getLocale` → `AppLocale::getLocale`; `Repo::*` → DAOs (`SubmissionDAO::getExportable`, `IssueDAO`, `SectionDAO`, `JournalSettingsDAO`); `DB::table` → `JournalSettingsDAO::getSettings`; `Illuminate\DB` removed.
  - `index.php` wrappers updated to 3.3 style.
  - Templates: `router=PKP\core\PKPApplication::ROUTE_PAGE` removed; `editorialMasthead` links/overrides renamed to `editorialTeam`; `->count()` → `|@count`/`getId()`/`getDatePosted()`; announcements assigned as array.
- Backups: `/mnt/DiskD/Workspace/Backups/ojs-jrdc/2026-11-06-pre-3.3/` (db-ojs35.sql.gz, ojs-jrdc-3.5.tar.gz).
- Verified: both themes render homepage + about/search/issue archive/login without fatal.