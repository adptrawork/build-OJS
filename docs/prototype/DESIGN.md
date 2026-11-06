---
name: JRDC Academic Publishing System
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#45464d'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#76777d'
  outline-variant: '#c6c6cd'
  surface-tint: '#565e74'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#131b2e'
  on-primary-container: '#7c839b'
  inverse-primary: '#bec6e0'
  secondary: '#4059aa'
  on-secondary: '#ffffff'
  secondary-container: '#8fa7fe'
  on-secondary-container: '#1d3989'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#2f1500'
  on-tertiary-container: '#c76c00'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dae2fd'
  primary-fixed-dim: '#bec6e0'
  on-primary-fixed: '#131b2e'
  on-primary-fixed-variant: '#3f465c'
  secondary-fixed: '#dce1ff'
  secondary-fixed-dim: '#b6c4ff'
  on-secondary-fixed: '#00164e'
  on-secondary-fixed-variant: '#264191'
  tertiary-fixed: '#ffdcc3'
  tertiary-fixed-dim: '#ffb77d'
  on-tertiary-fixed: '#2f1500'
  on-tertiary-fixed-variant: '#6e3900'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  headline-xl:
    fontFamily: Plus Jakarta Sans
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 48px
    letterSpacing: -0.025em
  headline-xl-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 30px
    fontWeight: '600'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.015em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 30px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 26px
    letterSpacing: 0em
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 28px
    letterSpacing: -0.011em
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: -0.006em
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 18px
    letterSpacing: 0em
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 11px
    fontWeight: '700'
    lineHeight: 14px
    letterSpacing: 0.04em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  gutter: 1.5rem
  gutter-mobile: 1rem
  margin: 3rem
  margin-mobile: 1rem
  margin-tablet: 2rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2.5rem
---

## Brand & Style

This design system is tailored for scholarly rigor, intellectual authority, and high-trust academic dissemination. Rooted in the prestige of scholarly publication, the visual language merges classic editorial refinement with contemporary digital clarity.

The target audience encompasses researchers, peer reviewers, academic faculty, university students, and institutional librarians. The interface must communicate institutional integrity, meticulous review standards, and effortless content legibility.

### Design Movement: Modern Editorial Neoclassicism
A disciplined synthesis of high-contrast structure, pristine information architecture, and delicate typographic hierarchy. It avoids excessive decorative flourishes in favor of:
- Deep tonal contrast with structural containment.
- Thin, razor-sharp hairline borders that delineate peer-reviewed content.
- Academic metadata visibility (DOIs, citation counts, indexing tiers, submission tracking).
- Subtle, purposeful micro-accents of warm gold/amber to mark peer-reviewed status, open access markers, and primary calls-to-action.

## Colors

The palette establishes an authoritative tone through deep oceanic navies, slate structural surfaces, and calibrated warm gold accents.

### Palette Hierarchy & Intent
- **Primary (`#0f172a`, with tonal support `#1e293b`):** Deep Obsidian Navy. Reserved for global navigation, structural headers, high-level typography, and primary governance elements.
- **Secondary (`#1e3a8a`):** Scholarly Royal Navy. Utilized for interactive hyperlinks, active navigation tabs, metadata link anchors, and secondary actions.
- **Tertiary / Accent (`#d97706`, high-vibrancy `#f59e0b`):** Academic Gold / Amber. Represents peer-reviewed certifications, metrics badges, special issue indicators, focus rings, and primary action buttons (e.g., "Submit Manuscript").
- **Neutral Surface Palette:**
  - Base White (`#ffffff`): Paper-like reading canvas for abstracts, full articles, and main panels.
  - Surface Tint (`#f8fafc`): Document background and primary canvas neutral.
  - Surface Variant (`#f1f5f9`): Sidebar backgrounds, metadata drawers, and inactive card states.
  - Border Slate (`#e2e8f0`): Hairline boundary lines between structural regions.
  - Muted Text (`#64748b`): Citation details, author affiliations, and publication timestamps.

## Typography

Typography balances academic legibility with sharp modern execution. 

- **Display & Section Headers (Plus Jakarta Sans):** Selected for its crisp geometric architecture and contemporary presence. It instills an accessible yet distinguished posture across article titles, journal names, and editorial boards.
- **Reading Body (Inter):** Highly legible, neutral workhorse engineered for long-form reading, dense abstract comprehension, reference citations, and data-dense table layouts.
- **Micro-labels, Badges & Metadata (Plus Jakarta Sans):** Set in weights 600 and 700 with open letter-spacing for uppercase publication identifiers (e.g., `ISSN`, `DOI`, `PEER REVIEWED`, `SCOPUS`).

## Layout & Spacing

The layout operates on an asymmetrical fixed-container grid system engineered specifically for scholarly publishing.

### Layout Architecture
- **Desktop (1200px - 1440px max-width):** An asymmetrical 12-column grid.
  - Main scholarly feed / article body: spans 8 columns.
  - Editorial, indexation, indexing, and indexing sidebar: spans 4 columns.
- **Tablet (768px - 1199px):** An 8-column layout. The metadata sidebar shifts beneath the primary article content or collapses into a docked drawer.
- **Mobile (< 768px):** A single 4-column flow with tight outer margins (`1rem`) maximizing viewport area for readability.

### Structural Spacing System
Vertical cadence leverages an 8px base unit. Section separation prioritizes generous gaps (`2.5rem`) to maintain academic clarity and avoid visual clutter in data-dense tables, bibliography lists, and multi-author decks.

## Elevation & Depth

The design system minimizes soft lighting illusions in favor of architectural borders and tonal elevation layers to mirror physical journals and bound research.

### Spatial Depth Principles
- **Foundation Layer (Level 0):** Surface base canvas (`#f8fafc`). Completely flat with zero elevation.
- **Scholarly Surface (Level 1):** Article cards, abstracts, search panels (`#ffffff`). Defined by a crisp 1px perimeter border (`#e2e8f0`) and an ambient, low-spread micro-shadow (`0 1px 3px rgba(15, 23, 42, 0.05)`).
- **Interactive State (Hover / Active):** Cards translate 1px upward on hover, and their border transitions from `#e2e8f0` to `#cbd5e1`, paired with a delicate gold border accent indicator (`#d97706` left border line or accent glow `0 4px 12px rgba(15, 23, 42, 0.08)`).
- **Overlays & Modals (Level 2):** PDF readers, citation export dialogues, and search command palettes use high contrast backing (`#ffffff`), reinforced by a solid slate border (`#94a3b8`) and structured drop (`0 10px 25px -5px rgba(15, 23, 42, 0.15)`).

## Shapes

To mirror the serious tone of an economics and business journal, the shape language uses low roundedness (`roundedness: 1` / `0.25rem` base, up to `0.5rem` for large containers). 

- Rounding is subtle, preserving crisp rectangularity reminiscent of paper documents, legal publications, and financial print registers.
- Buttons, input fields, and tags feature modest 4px corners (`0.25rem`).
- Large cards and preview drawers max out at 8px (`0.5rem`).
- Fully rounded pill shapes are strictly restricted to status indicator dots and micro-badges (such as "In Press" or "Open Access").

## Components

### 1. Buttons
- **Primary (Manuscript Submission / Download PDF):** Deep navy `#0f172a` background, pure white text, 4px border radius. Hover introduces background `#1e293b` with a subtle amber bottom accent line.
- **Secondary (Cite Article / View Metrics):** Crisp `#ffffff` surface with a 1px `#cbd5e1` border and `#1e293b` text. Hover shifts to `#f8fafc` with border `#1e3a8a`.
- **Tertiary / Accent Action:** Solid `#d97706` background with white text for critical CTAs like "Call for Papers".

### 2. Scholarly Cards (Article Index & Current Issue)
- Constructed with `#ffffff` fill and a 1px continuous border (`#e2e8f0`).
- Features a two-tiered hierarchy:
  1. Top metadata strip containing Volume, Issue, Publication Date, and DOI link.
  2. Bold article title (`headline-sm`) followed by author attribution list and concise abstract snippet.
  3. Bottom operational footer featuring direct PDF download link, citation triggers, and view counter.

### 3. Badge Tags
- **Metadata Badges:** Subdued slate styling (`bg: #f1f5f9`, `text: #334155`, border: 1px `#e2e8f0`) for categories such as "Empirical Research", "Case Study", or JEL codes.
- **Open Access Badge:** Gold-tinted pill badge (`bg: #fef3c7`, `text: #92400e`, border: 1px `#fde68a`).
- **Peer-Reviewed Status Badge:** Deep Navy hairline badge (`bg: #eff6ff`, `text: #1e3a8a`, border: 1px `#bfdbfe`).

### 4. Structured Sidebar (Journal Governance & Indexation)
- **Container:** Enclosed in `#f8fafc` background with a right-hand or left-hand border of 1px `#e2e8f0`.
- **Navigation Widgets:**
  - Section headers set in `label-sm` with uppercase styling and gold decorative underline (`2px solid #d97706`).
  - Menu links formatted as clean vertical stacked lists with hover indentation (+4px padding shift) and active indicator via vertical navy bar.
  - Dedicated indexation badges (SINTA, Google Scholar, DOAJ) arrayed in a high-contrast structured grid.

### 5. Form Elements (Search & Manuscript Submission)
- Input fields use pure white canvas (`#ffffff`), 1px slate borders (`#cbd5e1`), and placeholder text in `#94a3b8`.
- Focus state highlights border in `#1e3a8a` with a 2px amber glow (`rgba(217, 119, 6, 0.2)`).
- Checkboxes and radio selectors are square (or circular) with high-contrast `#0f172a` selection marks.

### 6. Citation & Reference Modules
- Indented block cards with a 3px solid `#1e3a8a` left spine, monospaced or crisp sans text, accompanied by one-click "Copy APA", "Copy BibTeX", and "EndNote" quick-action utilities.