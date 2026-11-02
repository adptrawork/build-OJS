# SEO / AEO Implementation Notes for JRDC

This document records the AI-search optimization changes applied to the JRDC OJS theme and SEO plugin.

## What changed

### 1. Journal metadata (DB)
- Updated `journal_settings.description` EN/ID with the professional AI-optimized text.
- Updated `publisherInstitution` to **Yayasan Ratu Dirgantara Cendikiawan**.
- Verified `printIssn` and `onlineIssn` values.

SQL seed: `scripts/seed-ai-seo-journal-settings.sql`

### 2. Static page content
Updated in `scripts/gen_static_content.py` (regenerate `scripts/static-content.sql` after edits):
- `/about` — definition block + scope table.
- `/focus-and-scope` — scope table + article types.
- `/author-guidelines` — step-by-step submission guide appended.
- `/faq` — semantic FAQ markup using `<h2>` + `<h3>`/`<p>` pairs (required for FAQPage schema extraction).

### 3. Schema markup
`plugins/generic/akdisiSeo/AkdisiSeoPlugin.php` now emits:
- `Periodical` JSON-LD on the homepage and non-article pages, with:
  - `name`: "Jurnal Ratu Dirgantara Cendikiawan (JRDC)"
  - `alternateName`: "JRDC"
  - `issn` / `printIssn`
  - `isAccessibleForFree: true`
  - `license`: CC BY 4.0
  - `publisher` Organization
  - `hasPart` current issue when available
- `ScholarlyArticle` JSON-LD on article pages, with:
  - `isAccessibleForFree: true`
  - `license`: CC BY 4.0
  - `isPartOf` Periodical with full journal name and ISSN
  - `pageStart` / `pageEnd` parsed from article pages
- `FAQPage` JSON-LD on any static page that contains `<h3>` question + `<p>` answer blocks.

### 4. `llms.txt`
- File already exists at repo root: `llms.txt`.
- `.github/workflows/deploy.yml` now includes an optional step to upload `llms.txt` to the hosting root using `secrets.FTP_ROOT_PATH`.
- Manual alternative: upload `llms.txt` to the public site root via cPanel File Manager / FTP.

### 5. `robots.txt` template
- Template provided at `docs/ROBOTS_JRDC.txt`.
- Do **not** overwrite a live `robots.txt` blindly. Review the `Sitemap:` URL and context path, then deploy the contents to the site root.

## Deploy checklist

1. Run the journal settings seed on the target database:
   ```bash
   ddev mysql < scripts/seed-ai-seo-journal-settings.sql
   ```
2. Run the static page content seed on the target database:
   ```bash
   ddev mysql < scripts/static-content.sql
   ```
3. Clear OJS template cache:
   ```bash
   ddev exec rm -rf ojs/cache/t_cache/*
   ```
4. Verify key pages return 200 and contain expected JSON-LD:
   ```bash
   curl -s https://your-domain.example/index.php/jrdc/ | grep -o 'application/ld+json'
   curl -s https://your-domain.example/index.php/jrdc/faq | grep -o 'FAQPage'
   curl -s https://your-domain.example/index.php/jrdc/about | grep -o 'Jurnal Ratu Dirgantara Cendikiawan'
   ```
5. Upload `llms.txt` to the site root (GitHub Actions if `FTP_ROOT_PATH` is set, or manually).
6. Apply `docs/ROBOTS_JRDC.txt` contents to the live `/robots.txt` after reviewing the sitemap URL.
