# AI SEO Strategy for JRDC (Jurnal Ratu Dirgantara Cendikiawan)

## Executive Summary

JRDC is an open-access, peer-reviewed academic journal focused on Economics and Business. This document defines an AI-search optimization strategy that makes JRDC discoverable and citable by AI systems (Google AI Overviews, ChatGPT, Perplexity, Claude, Gemini, Copilot) while remaining compliant with Google's "write for people, not AI" guidance.

The strategy is built on th[]()ree pillars:
1. **Structure** — content blocks AI can extract (definitions, FAQs, steps, comparisons).
2. **Authority** — peer-review sign[]()als, indexing, citations, expert attribution.
3. **Presence** — machine-readable files, schema markup, and third-party indexes.

---

## 1. Journal Identity (Professional & General)

### English
> **Jurnal Ratu Dirgantara Cendikiawan (JRDC)** is a peer-reviewed, open-access academic journal publishing original research, systematic reviews, and case studies in economics, business, management, finance, and related social sciences. JRDC serves scholars, practitioners, and policymakers seeking evidence-based insights into emerging economic and business phenomena.

### Bahasa Indonesia
> **Jurnal Ratu Dirgantara Cendikiawan (JRDC)** adalah jurnal ilmiah akses terbuka yang telah melalui telaah sejawat (peer-reviewed), menerbitkan penelitian orisinal, tinjauan sistematis, dan studi kasus di bidang ekonomi, bisnis, manajemen, keuangan, serta ilmu sosial terkait. JRDC menjadi wadah bagi akademisi, praktisi, dan pembuat kebijakan yang membutuhkan wawasan berbasis bukti tentang fenomena ekonomi dan bisnis terkini.

### Scope (Focus and Scope)

| Domain | Topics |
|--------|--------|
| Economics | Macroeconomics, microeconomics, development economics, behavioral economics, Islamic economics |
| Business & Management | Strategic management, entrepreneurship, marketing, operations, organizational behavior |
| Finance & Accounting | Corporate finance, banking, capital markets, financial reporting, public sector accounting |
| Social Sciences | Interdisciplinary research linking economics and business with society, policy, and sustainability |

---

## 2. AI-Optimized Content Blocks

### 2.1 Definition Block (for "What is JRDC?")

```html
<h2>What is Jurnal Ratu Dirgantara Cendikiawan (JRDC)?</h2>
<p>Jurnal Ratu Dirgantara Cendikiawan (JRDC) is an open-access, peer-reviewed academic journal that publishes research in economics and business. JRDC follows a double-blind peer-review process and provides free, immediate access to all published articles under a Creative Commons license.</p>
```

### 2.2 Step-by-Step Block (for "How to submit")

```html
<h2>How to Submit a Manuscript to JRDC</h2>
<ol>
  <li><strong>Prepare your manuscript</strong> according to the JRDC author guidelines.</li>
  <li><strong>Register or log in</strong> to the JRDC submission system.</li>
  <li><strong>Upload your manuscript</strong> through the online submission wizard.</li>
  <li><strong>Initial screening</strong>: the editorial team checks scope, originality, and formatting.</li>
  <li><strong>Peer review</strong>: at least two independent reviewers evaluate the manuscript.</li>
  <li><strong>Revision and decision</strong>: authors revise based on reviewer comments.</li>
  <li><strong>Publication</strong>: accepted articles are copyedited, typeset, and published online.</li>
</ol>
```

### 2.3 FAQ Block (for AI extraction & FAQ schema)

```html
<h2>Frequently Asked Questions</h2>

<h3>Is JRDC an open-access journal?</h3>
<p>Yes. JRDC provides immediate open access to all published articles. Readers may download, share, and reuse content under the applicable Creative Commons license.</p>

<h3>What is the peer-review process at JRDC?</h3>
<p>JRDC uses a double-blind peer-review process. Each submission is evaluated by at least two independent reviewers with expertise in the manuscript's subject area.</p>

<h3>Are there any article processing charges (APC) at JRDC?</h3>
<p>JRDC does not charge authors any submission or article processing fees. Publication is free for all accepted manuscripts.</p>

<h3>Which indexing services include JRDC?</h3>
<p>JRDC is committed to indexing in Google Scholar, DOAJ, Crossref, and national academic repositories. Indexing status is updated on the Indexing page.</p>

<h3>How long does the review process take?</h3>
<p>The initial editorial decision is typically provided within 4–8 weeks after submission, depending on reviewer availability.</p>
```

### 2.4 Comparison Table (for "JRDC vs other journals")

| Feature | JRDC | Typical Subscription Journal |
|--------|------|------------------------------|
| Access | Open access, free to read | Paywall or subscription required |
| Author fees | No APC | Often charges APC or page fees |
| Peer review | Double-blind | Varies by journal |
| Licensing | Creative Commons | Usually copyright transfer |
| Audience | Global academics & practitioners | Institutional subscribers |

---

## 3. Machine-Readable Files for AI Agents

### 3.1 `/llms.txt` (site root)

This file should be placed at the root of the public domain:

```markdown
# Jurnal Ratu Dirgantara Cendikiawan (JRDC)

JRDC is an open-access, peer-reviewed academic journal in Economics and Business.

## Key facts
- ISSN (print): 2807-1234
- ISSN (online): 2807-5678
- Publisher: Yayasan Ratu Dirgantara Cendikiawan
- Review process: Double-blind peer review
- APC: None
- License: Creative Commons Attribution (CC BY)
- Languages: English and Indonesian

## Important pages
- About JRDC: /index.php/jrdc/about
- Focus and Scope: /index.php/jrdc/focus-and-scope
- Author Guidelines: /index.php/jrdc/author-guidelines
- Editorial Team: /index.php/jrdc/about/editorialMasthead
- Submission: /index.php/jrdc/submission
- Current Issue: /index.php/jrdc/issue/current
- Archive: /index.php/jrdc/issue/archive
- Contact: /index.php/jrdc/about/contact
```

### 3.2 `/robots.txt` (allow AI search crawlers, control training crawlers)

```text
User-agent: *
Disallow: /cache/
Disallow: /lib/pkp/
Disallow: /plugins/
Disallow: /tools/
Disallow: /index.php/jrdc/user/
Allow: /index.php/jrdc/article/
Allow: /index.php/jrdc/issue/
Allow: /index.php/jrdc/about/
Allow: /

Sitemap: https://gentle-scarlet-lamb.101-50-1-74.cpanel.site/sitemap.xml

# AI search discovery crawlers
User-agent: OAI-SearchBot
User-agent: PerplexityBot
User-agent: Claude-SearchBot
User-agent: Googlebot
Allow: /

# Potential model-training crawlers (adjust as desired)
User-agent: GPTBot
User-agent: ClaudeBot
Disallow: /
```

---

## 4. Schema Markup Recommendations

Ensure the AkdisiSeo plugin or theme emits the following JSON-LD:

### 4.1 Journal Homepage — `Periodical`

```json
{
  "@context": "https://schema.org",
  "@type": "Periodical",
  "name": "Jurnal Ratu Dirgantara Cendikiawan (JRDC)",
  "alternateName": "JRDC",
  "issn": "2807-5678",
  "printIssn": "2807-1234",
  "publisher": {
    "@type": "Organization",
    "name": "Yayasan Ratu Dirgantara Cendikiawan"
  },
  "about": "Economics and Business",
  "isAccessibleForFree": true,
  "hasPart": {
    "@type": "PublicationIssue",
    "issueNumber": "1",
    "volumeNumber": "1"
  }
}
```

### 4.2 Article Page — `ScholarlyArticle`

```json
{
  "@context": "https://schema.org",
  "@type": "ScholarlyArticle",
  "headline": "Article Title",
  "author": [
    { "@type": "Person", "name": "Author Name", "affiliation": "University" }
  ],
  "isPartOf": {
    "@type": "Periodical",
    "name": "Jurnal Ratu Dirgantara Cendikiawan (JRDC)"
  },
  "datePublished": "2011-01-01",
  "pageStart": "1",
  "pageEnd": "15",
  "isAccessibleForFree": true,
  "license": "https://creativecommons.org/licenses/by/4.0/"
}
```

### 4.3 FAQ Page — `FAQPage`

For static pages with FAQs, wrap Q&A pairs in JSON-LD `FAQPage` schema.

---

## 5. Content Quality Signals

- **Author attribution**: every article lists author names, affiliations, and ORCID where available.
- **Dates**: include `datePublished`, `dateModified`, and "Last updated" on static pages.
- **Citations**: articles include reference lists with DOI links.
- **Originality**: scope statement emphasizes original research and peer review.
- **Freshness**: update author guidelines and editorial team pages quarterly.

---

## 6. Third-Party Presence & Indexing

For academic journals, AI systems rely heavily on third-party scholarly indexes. Priorities:

1. **Google Scholar** — register journal site and sitemap.
2. **Crossref** — register DOIs for every article.
3. **DOAJ** — apply for Directory of Open Access Journals listing.
4. **ORCID** — encourage authors to include ORCID iDs.
5. **National repositories** — Garuda, Sinta, Neliti, etc.
6. **Semantic Scholar** — automatic if articles are publicly accessible.

---

## 7. Implementation Checklist

- [ ] Replace homepage/journal description with professional EN/ID text above.
- [ ] Create `/about` static page with Definition Block and Scope table.
- [ ] Create `/author-guidelines` with Step-by-Step submission block.
- [ ] Add FAQ section to `/faq` or `/about` with FAQPage schema.
- [ ] Upload `llms.txt` to site root.
- [ ] Update `robots.txt` to allow AI search crawlers and link sitemap.
- [ ] Verify JSON-LD `Periodical` + `ScholarlyArticle` in header.
- [ ] Register journal with Google Scholar and Crossref.
- [ ] Submit sitemap to Google Search Console.

---

## 8. What NOT to Do

- Do not create separate "AI-only" pages — Google considers this scaled content abuse.
- Do not keyword-stuff — it reduces AI citation likelihood.
- Do not gate content — AI cannot cite what it cannot read.
- Do not block `OAI-SearchBot`, `PerplexityBot`, or `Claude-SearchBot` if you want AI citations.

---

## 9. Implementation Status

See `docs/SEO_IMPLEMENTATION.md` for the actual code changes applied to the JRDC theme, SEO plugin, static pages, and deployment workflow. The implementation covers JSON-LD improvements, FAQPage schema, updated static page content, `llms.txt` deployment via GitHub Actions, and a `robots.txt` template.
