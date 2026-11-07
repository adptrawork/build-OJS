# Adptra — OJS 3.3 Theme

A child theme for **Open Journal Systems 3.3.x**. The plugin inherits the PKP Default Theme and changes the editorial presentation while preserving OJS' core page handlers, account controls, article pages, galleys, navigation and publishing data.

> **Prototype reference limitation:** the GitHub `docs/prototype` directory supplied for this task could not be fetched in this environment, even after repository access was enabled. This package is therefore a complete OJS-oriented editorial theme implementation, but its visual appearance cannot honestly be described as an exact reproduction of that uninspected prototype. See [`docs/PROTOTYPE-REVIEW.md`](docs/PROTOTYPE-REVIEW.md).

## Requirements

- OJS 3.3.x (tested against the OJS 3.3 template/API conventions; verify on the exact patch release before production rollout).
- PHP version supported by the installed OJS 3.3 release.
- The stock OJS Default Theme plugin must remain installed/enabled because this is a child theme.

## Installation

### Upload through OJS

1. Back up the OJS database and files.
2. In the journal manager dashboard, open **Settings → Website → Plugins → Installed Plugins**.
3. Select **Upload A New Plugin** and upload `adptra-ojs-theme.tar.gz`.
4. Enable **Adptra — Tema Jurnal** in Theme Plugins if required.
5. Open **Settings → Website → Appearance**, select **Adptra — Tema Jurnal**, and save.
6. Open the theme's **Settings / Theme Options** panel (the options are registered by `AdptraThemePlugin::init()`) and configure colors, banner copy and homepage sections.
7. Clear the template cache and reload the journal homepage.

### Manual installation

Copy the `adptra` directory into:

```text
[ojs-root]/plugins/themes/adptra/
```

Then enable the plugin and select it under **Settings → Website → Appearance → Theme**.

## Theme options

| Option | Function |
|---|---|
| Primary color | Site-wide primary color for the header, links and navigation. |
| Accent color | Accent color for emphasis, rules and buttons. |
| Banner title | Optional homepage heading; defaults to the journal name. |
| Banner description | Optional banner copy; blank hides this text. The journal description remains a separate OJS-managed homepage section. |
| Banner eyebrow | Optional short label above the heading. |
| Show banner | Toggles the hero/banner component. |
| Show banner image | Shows or hides the official OJS Homepage Image within the banner. |
| Show search | Toggles the OJS search form on the homepage. |
| Show announcements | Toggles announcements published in OJS. |
| Show journal description | Toggles the context description from OJS. |
| Show editorial link | Toggles a link to OJS' Editorial Team page. |
| Show current issue | Toggles the current issue and its native table of contents. |
| Show additional homepage content | Toggles the additional homepage HTML content maintained in OJS. |

Color values are validated as six-digit hexadecimal values before being injected into CSS custom properties.

## Content management: no hard-coded journal content

- **Journal logo:** manage through **Settings → Website → Appearance → Journal Thumbnail / Logo** (label may vary slightly by OJS 3.3 patch release). The core header renders it.
- **Homepage banner image:** upload/change through the core **Homepage Image** field in Website → Appearance. The theme reuses OJS' `$homepageImage` object and public file path.
- **Navigation:** manage primary and user menus in **Settings → Website → Navigation Menus**. The theme keeps the parent theme's menu areas.
- **Announcements:** create and publish them in **Settings → Website → Announcements**. Only OJS announcement objects are rendered.
- **Current issue and articles:** the homepage displays the OJS current `$issue` and includes the core `frontend/objects/issue_toc.tpl`, so only published content attached to that issue is shown.
- **Journal description and additional homepage content:** manage these in the journal setup/Website settings. The home template uses `$currentContext` and `$additionalHomeContent` supplied by OJS.
- **Editorial board:** manage editor roles and the Editorial Team page in OJS. The homepage links to that native page instead of copying or fabricating editorial names.
- **Search:** submits to the built-in OJS search page using the `query` parameter.
- **Downloads and citations:** article views, galley/download metrics, and usage reports remain owned by OJS' statistics/usage-statistics plugins and core article templates. OJS 3.3 does not expose a reliable homepage-ready citation/download aggregate in the default journal-index template, so this theme does not invent or query undocumented counts. Enable and configure the relevant OJS statistics plugins to display metrics where supported.

## Design and implementation notes

- `AdptraThemePlugin.inc.php` extends `ThemePlugin`, calls `setParent('defaultthemeplugin')`, adds theme options, registers the CSS, adds color variables through `TemplateManager::addHeader()`, and validates configurable colors.
- `templates/frontend/pages/indexJournal.tpl` overrides only the journal homepage. All other front-end pages continue to use the inherited OJS Default Theme templates.
- `styles/index.css` is plain CSS (no CSS framework, utility framework, preprocessor syntax or external font dependency).
- Vanilla JavaScript is not included because the page interactions in this theme do not require custom client-side behavior. Native OJS navigation and forms remain functional.
- The actual logo, navigation labels/URLs and homepage image are deliberately not duplicated as theme-specific upload fields. They already have official OJS management interfaces and reusing them avoids a second upload/storage pipeline.
- OJS 3.3 has no built-in “featured article” editorial-selection setting that is exposed to this homepage template. The nearest reliable native feature is the Current Issue / Table of Contents component, which links only to real published articles. A curated featured-article module would require a separate supported metadata/plugin configuration.

## Validation and deployment checklist

This source package was syntax-checked for PHP and XML structure in the build environment. It was **not** executed inside a live OJS installation because no OJS runtime/database was available in this session. Before production use:

1. Install on a staging copy with the same OJS 3.3 patch release, PHP version and enabled plugins as production.
2. Check Settings → Website → Appearance and each theme option field.
3. Test the homepage with an issue, without a current issue, with announcements on/off, and with missing optional logo/banner files.
4. Test article, issue archive, search, announcement, login/register and editorial-team pages.
5. Check the interface at mobile/tablet/desktop widths and keyboard-only navigation, and run an accessibility scan (WCAG 2.1 AA target).
6. Confirm color combinations after choosing custom colors; the plugin validates syntax, not contrast ratios.

## File layout

```text
adptra/
├── AdptraThemePlugin.inc.php
├── index.php
├── version.xml
├── settings.xml
├── locale/
│   ├── en_US/locale.xml
│   └── id_ID/locale.xml
├── styles/index.css
├── templates/
│   └── frontend/
│       ├── pages/indexJournal.tpl
│       └── components/adptra/
│           ├── hero.tpl
│           ├── search.tpl
│           ├── editorialLink.tpl
│           ├── announcements.tpl
│           └── currentIssue.tpl
└── docs/
    ├── DEVELOPMENT.md
    └── PROTOTYPE-REVIEW.md
```

## License

GNU General Public License v3.0 or later. See [`LICENSE`](LICENSE).
