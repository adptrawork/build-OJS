---
name: Jurnal Ekonomi dan Bisnis JRDC - OJS Design System
colors:
  primary: '#c2410c'
  primary-hover: '#9a3412'
  navy-hero: '#0b2038'
  navy-dark: '#071424'
  background-light: '#f8fafc'
  background-dark: '#090d16'
  slate-50: '#f8fafc'
  slate-100: '#f1f5f9'
  slate-200: '#e2e8f0'
  slate-300: '#cbd5e1'
  slate-700: '#334155'
  slate-800: '#1e293b'
  slate-900: '#0f172a'
  slate-950: '#020617'
typography:
  fontFamily:
    sans: "Geist, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif"
    serif: "Merriweather, serif"
    display: "Cinzel, serif"
rounded:
  DEFAULT: '0.5rem'
  lg: '0.75rem'
  xl: '1rem'
  '2xl': '1.5rem'
  full: '9999px'
---

## Brand & Style Guidelines

This design system governs the complete set of HTML prototypes for **Jurnal Ekonomi dan Bisnis JRDC** (Open Journal Systems / OJS). It establishes a modern, high-fidelity, accessible, and rigorous academic publishing interface tailored for researchers, reviewers, students, and academic librarians.

### Design Movement: Modern Academic Editorial
Merging the prestige of traditional scholarly publishing with contemporary digital clarity. Key tenets include:
- **High-contrast structural containment**: Crisp hairline borders (`border-slate-200 dark:border-slate-800`), clean card padding, and robust typographic hierarchy.
- **Academic metadata transparency**: Prominent DOIs, publication dates, issue volumes, citation metrics, open access badges, and peer review status indicators.
- **Seamless Dark Mode support**: Fully integrated dark mode (`dark:` classes) toggleable across every page with state persistence.
- **Warm Burnt Orange & Deep Obsidian Navy palette**: Instills institutional authority while highlighting primary CTAs and active states.

## Color Tokens

### 1. Brand & Primary Palette
- **Primary (`#c2410c` / `primary`):** Burnt Orange / Terracotta. Utilized for active states, key action buttons (e.g., "Kirim Naskah"), badge accents, and editorial highlights.
- **Primary Hover (`#9a3412` / `primary-hover`):** Darker shade for interactive button feedback.
- **Hero Navy (`#0b2038` / `navy-hero`):** Deep oceanic navy for major hero banners and institutional branding headers.
- **Dark Navy (`#071424` / `navy-dark`):** Deepest background tone for dark mode hero accents.

### 2. Neutral Surfaces & Backgrounds
- **Light Background (`#f8fafc` / `background-light`):** Clean, paper-like neutral canvas for optimal long-form reading.
- **Dark Background (`#090d16` / `background-dark`):** Immersive dark mode canvas.
- **Slate Borders & Dividers (`#e2e8f0` / `border-slate-200`):** Razor-sharp hairline borders separating content panels.

## Typography

Built upon clean geometric and sans-serif foundations:
- **Primary Sans (Geist):** Used for all headings, body text, metadata, navigation, and form controls to ensure razor-sharp legibility.
- **Serif Accents (Merriweather / Cinzel):** Applied selectively to formal editorial notes, Latin terminology, and journal display typography.

## Layout & Containers

- **Fixed Maximum Container Width (`max-w-7xl mx-auto px-4 sm:px-6 lg:px-8`):** Uniformly applied across all headers, main content sections, breadcrumbs, grids, and footers.
- **Grid Architecture:** 12-column responsive grid system where main articles/content consume 8 columns and sidebars/metadata consume 4 columns.

## Components & Interactive Elements

### 1. Navigation & Header
- Sticky header featuring institutional logo, navigation links (Beranda, Arsip, Tentang, Pengumuman), search bar with instant query support, dark mode toggle, and authentication buttons ("Masuk").

### 2. Scholarly Cards & Tables of Contents
- Two-tier container structure displaying volume/issue metadata, DOI links, author affiliations, view/download counters, and direct PDF download triggers.

### 3. Left Sidebar Navigation
- Consistent 7-item navigation card across all internal pages (Tentang Jurnal, Dewan Redaksi, Kebijakan Etika & Peer Review, Pedoman Penulis & Reviewer, Kirim Naskah Online, Statistik Jurnal, Kontak Sekretariat) with active state highlighting.

### 4. Interactive Modals & Forms
- Fully styled login (`login.html`), registration (`register.html`), manuscript submission checklist, and editorial dashboard (`dashboard.html`).
