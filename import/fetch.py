#!/usr/bin/env python3
import argparse, html, json, os, re, time, urllib.parse, urllib.request, xml.etree.ElementTree as ET
from datetime import datetime, timezone

BASE = "https://journal.uii.ac.id/JEKI"
OAI = BASE + "/oai"
UA = "jeki-ojs-import/0.1 (prototype)"
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RAW = os.path.join(ROOT, "import", "raw")
PAGES = os.path.join(RAW, "pages")
NS = {"oai": "http://www.openarchives.org/OAI/2.0/",
      "dc": "http://purl.org/dc/elements/1.1/",
      "oai_dc": "http://www.openarchives.org/OAI/2.0/oai_dc/"}


def fetch(url, retries=3):
    time.sleep(1.0)
    last = None
    for attempt in range(retries):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=30) as r:
                return r.read().decode("utf-8", errors="replace")
        except Exception as e:
            last = e
            time.sleep(2 ** attempt)
    raise RuntimeError(f"gagal fetch {url}: {last}")


def meta(t, name):
    for m in re.finditer(r'<meta\s+[^>]*name=["\']' + re.escape(name) + r'["\'][^>]*content=["\']([^"\']*)["\']', t, re.I):
        return html.unescape(m.group(1))
    for m in re.finditer(r'<meta\s+[^>]*content=["\']([^"\']*)["\'][^>]*name=["\']' + re.escape(name) + r'["\']', t, re.I):
        return html.unescape(m.group(1))
    return None


def metas(t, name):
    out = []
    for m in re.finditer(r'<meta\s+[^>]*name=["\']' + re.escape(name) + r'["\'][^>]*content=["\']([^"\']*)["\']', t, re.I):
        out.append(html.unescape(m.group(1)))
    for m in re.finditer(r'<meta\s+[^>]*content=["\']([^"\']*)["\'][^>]*name=["\']' + re.escape(name) + r'["\']', t, re.I):
        out.append(html.unescape(m.group(1)))
    return out


def parse_oai_record(rec):
    meta_el = rec.find("oai:metadata/oai_dc:dc", NS)
    if meta_el is None:
        return None
    def dc(tag):
        return [e.text.strip() for e in meta_el.findall(f"dc:{tag}", NS) if e.text]
    identifiers = dc("identifier")
    article_url = None
    doi = None
    for idv in identifiers:
        if "/article/view/" in idv:
            article_url = idv
        elif idv.startswith("10.") or "doi.org" in idv:
            doi = idv.replace("https://doi.org/", "").replace("http://doi.org/", "")
    article_id = None
    if article_url:
        m = re.search(r"/article/view/(\d+)", article_url)
        article_id = m.group(1) if m else None
    galleys = []
    for rel in dc("relation"):
        m = re.search(r"/article/view/(\d+)/(\d+)", rel)
        if m:
            galleys.append({"id": m.group(2), "label": "PDF", "url": rel, "type": "pdf"})
    keywords, jel = [], []
    for subj in dc("subject"):
        if re.fullmatch(r"[A-Z]\d{1,2}", subj.strip()):
            jel.append(subj.strip())
        else:
            keywords.append(subj.strip())
    authors = []
    for i, c in enumerate(dc("creator"), start=1):
        given = family = c
        if "," in c:
            family, given = [x.strip() for x in c.split(",", 1)]
        authors.append({"seq": i, "given": given, "family": family,
                       "affiliation": None, "orcid": None, "email": None, "corresponding": False})
    return {
        "id": article_id, "url": article_url, "issue_id": None, "section": None,
        "title": dc("title")[0] if dc("title") else None, "subtitle": None,
        "abstract": "\n".join(dc("description")) if dc("description") else None,
        "language": dc("language")[0] if dc("language") else None,
        "doi": doi, "pages": None, "page_start": None, "page_end": None,
        "date_published": dc("date")[0] if dc("date") else None,
        "keywords": keywords, "jel": jel, "authors": authors, "galleys": galleys,
        "references": [], "license": dc("rights")[0] if dc("rights") else None,
        "_source": dc("source")[0] if dc("source") else None,
    }


def fetch_oai(limit=None):
    records = []
    token = None
    url = OAI + "?verb=ListRecords&metadataPrefix=oai_dc"
    while True:
        page_url = url if token is None else OAI + "?verb=ListRecords&resumptionToken=" + urllib.parse.quote(token)
        xml_text = fetch(page_url)
        root = ET.fromstring(xml_text)
        for rec in root.findall(".//oai:record", NS):
            r = parse_oai_record(rec)
            if r and r["id"]:
                records.append(r)
                if limit and len(records) >= limit:
                    break
        if limit and len(records) >= limit:
            break
        tok_el = root.find(".//oai:resumptionToken", NS)
        token = tok_el.text.strip() if tok_el is not None and tok_el.text else None
        if not token:
            break
    return records


def parse_article_html(article_id, text):
    res = {}
    m = re.search(r"issue/view/(\d+)", text)
    res["issue_id"] = int(m.group(1)) if m else None
    res["section"] = meta(text, "DC.Type.articleType")
    authors_meta = metas(text, "citation_author")
    insts = metas(text, "citation_author_institution")
    authors = []
    for i, name in enumerate(authors_meta, start=1):
        authors.append({"seq": i, "given": name.strip(), "family": None,
                        "affiliation": insts[i-1].strip() if i-1 < len(insts) else None,
                        "orcid": None, "email": None, "corresponding": False})
    orcids = re.findall(r"orcid\.org/(\d{4}-\d{4}-\d{4}-\d{3}[\dX])", text)
    for i, o in enumerate(orcids):
        if i < len(authors):
            authors[i]["orcid"] = o
    if authors:
        res["authors"] = authors
    fp = meta(text, "citation_firstpage")
    lp = meta(text, "citation_lastpage")
    if fp:
        res["page_start"] = fp
        res["page_end"] = lp
        res["pages"] = f"{fp}-{lp}" if lp else fp
    doi = meta(text, "citation_doi")
    if doi:
        res["doi"] = doi
    d = meta(text, "citation_date")
    if d and "-" in d:
        res["date_published"] = d
    pdf = meta(text, "citation_pdf_url")
    if pdf:
        m = re.search(r"/article/download/(\d+)/(\d+)", pdf)
        if m:
            res["_galley"] = {"id": m.group(2), "label": "PDF", "url": pdf, "type": "pdf"}
    refs = metas(text, "citation_reference")
    res["references"] = [{"seq": i, "raw": r, "doi": None} for i, r in enumerate(refs, start=1)]
    t = meta(text, "citation_title")
    if t:
        res["title"] = t
    lang = meta(text, "citation_language")
    if lang:
        res["language"] = lang
    return res


def parse_issue_page(issue_id, text):
    title = None
    m = re.search(r'<meta\s+name="generator"\s+content="([^"]*)"', text, re.I)
    if m:
        title = m.group(1).split("|")[0].strip()
    volume = number = year = None
    if title:
        mm = re.search(r"Volume\s+(\d+)\s+No\.?\s*(\d+),?\s*\w*\s*(\d{4})", title, re.I)
        if mm:
            volume, number, year = mm.group(1), mm.group(2), mm.group(3)
    date_published = None
    mm = re.search(r"Published:\s*([0-9]{4}-[0-9]{2}-[0-9]{2})", text)
    if mm:
        date_published = mm.group(1)
    cover = None
    mm = re.search(r'src="([^"]*issues/[^"]*\.(?:jpg|png|jpeg))"', text, re.I)
    if mm:
        cover = mm.group(1)
    return {"id": issue_id, "volume": volume, "number": number, "year": year,
            "title": title, "date_published": date_published,
            "url": f"{BASE}/issue/view/{issue_id}", "cover_image": cover}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=None)
    ap.add_argument("--force", action="store_true")
    args = ap.parse_args()

    os.makedirs(RAW, exist_ok=True)
    os.makedirs(PAGES, exist_ok=True)

    print("Mengambil OAI...")
    records = fetch_oai(args.limit)
    print(f"  {len(records)} record OAI")

    with open(os.path.join(RAW, "oai.json"), "w", encoding="utf-8") as f:
        json.dump({"source": BASE, "fetched_at": datetime.now(timezone.utc).isoformat(),
                   "records": records}, f, ensure_ascii=False, indent=2)

    issue_ids = set()
    articles = []
    for r in records:
        aid = r["id"]
        cache_path = os.path.join(PAGES, f"{aid}.html")
        if (not args.force) and os.path.exists(cache_path):
            text = open(cache_path, encoding="utf-8").read()
        else:
            try:
                text = fetch(r["url"])
            except Exception as e:
                print(f"  [WARN] gagal fetch {aid}: {e}")
                text = ""
            if text:
                with open(cache_path, "w", encoding="utf-8") as f:
                    f.write(text)

        enriched = dict(r)
        if text:
            parsed = parse_article_html(aid, text)
            if parsed.get("issue_id"):
                enriched["issue_id"] = parsed["issue_id"]
                issue_ids.add(parsed["issue_id"])
            if parsed.get("section"):
                enriched["section"] = parsed["section"]
            if parsed.get("authors"):
                for i, a in enumerate(enriched["authors"]):
                    if i < len(parsed["authors"]):
                        p = parsed["authors"][i]
                        if p.get("affiliation"):
                            a["affiliation"] = p["affiliation"]
                        if p.get("orcid"):
                            a["orcid"] = p["orcid"]
            if parsed.get("pages"):
                enriched["pages"] = parsed["pages"]
                enriched["page_start"] = parsed["page_start"]
                enriched["page_end"] = parsed["page_end"]
            if parsed.get("doi"):
                enriched["doi"] = parsed["doi"]
            if parsed.get("date_published"):
                if "-" in (parsed["date_published"] or ""):
                    enriched["date_published"] = parsed["date_published"]
            if parsed.get("references"):
                enriched["references"] = parsed["references"]
            if parsed.get("language"):
                enriched["language"] = parsed["language"]
            if parsed.get("_galley"):
                g = parsed["_galley"]
                if not any(x.get("id") == g["id"] for x in enriched.get("galleys", [])):
                    enriched.setdefault("galleys", []).append(g)
        for k in ("_source", "_galley", "_abstract_url"):
            enriched.pop(k, None)
        articles.append(enriched)

    issues = []
    for iid in sorted(issue_ids):
        try:
            text = fetch(f"{BASE}/issue/view/{iid}")
        except Exception as e:
            print(f"  [WARN] issue {iid}: {e}")
            text = ""
        ip = parse_issue_page(iid, text) if text else {"id": iid, "volume": None, "number": None,
            "year": None, "title": None, "date_published": None,
            "url": f"{BASE}/issue/view/{iid}", "cover_image": None}
        issues.append(ip)

    issue_map = {i["id"]: i for i in issues}
    for a in articles:
        if a.get("issue_id") in issue_map and not a.get("date_published"):
            a["date_published"] = issue_map[a["issue_id"]].get("date_published")
        a.pop("_source", None)

    out = {"source": BASE, "fetched_at": datetime.now(timezone.utc).isoformat(),
           "issues": issues, "articles": articles}
    with open(os.path.join(RAW, "articles.json"), "w", encoding="utf-8") as f:
        json.dump(out, f, ensure_ascii=False, indent=2)

    n_doi = sum(1 for a in articles if a.get("doi"))
    n_auth = sum(len(a.get("authors", [])) for a in articles)
    print(f"Selesai: {len(articles)} artikel, {len(issues)} issue, {n_auth} penulis, {n_doi} DOI")


if __name__ == "__main__":
    main()
