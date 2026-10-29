#!/usr/bin/env python3
import argparse, csv, json, os, xml.etree.ElementTree as ET

NS = "http://pkp.sfu.ca"
ET.register_namespace("", NS)


def L(tag, locale, text):
    e = ET.Element(f"{{{NS}}}{tag}")
    e.set("locale", locale)
    e.text = text
    return e


def issue_identification(issue):
    ii = ET.Element(f"{{{NS}}}issue_identification")
    if issue.get("volume") is not None:
        v = ET.SubElement(ii, f"{{{NS}}}volume"); v.text = str(issue["volume"])
    if issue.get("number") is not None:
        n = ET.SubElement(ii, f"{{{NS}}}number"); n.text = str(issue["number"])
    if issue.get("year") is not None:
        y = ET.SubElement(ii, f"{{{NS}}}year"); y.text = str(issue["year"])
    if issue.get("title"):
        ii.append(L("title", "en", issue["title"]))
    return ii


def build_issue(issue, articles):
    el = ET.Element(f"{{{NS}}}issue")
    el.set("published", "1")
    el.set("current", "0")
    el.append(issue_identification(issue))
    if issue.get("date_published"):
        dp = ET.SubElement(el, f"{{{NS}}}date_published"); dp.text = issue["date_published"]
    sections = ET.SubElement(el, f"{{{NS}}}sections")
    sections_set = {a.get("section") or "Articles" for a in articles}
    for idx, sec_name in enumerate(sorted(sections_set)):
        sec = ET.SubElement(sections, f"{{{NS}}}section")
        sec.set("ref", sec_name.upper().replace(" ", "_"))
        sec.set("seq", str(idx))
        sec.set("editor_restricted", "0")
        sec.set("meta_indexed", "1")
        sec.set("meta_reviewed", "1")
        sec.set("abstracts_not_required", "0")
        sec.set("abstract_word_count", "0")
        sec.set("hide_author", "0")
        sa = ET.SubElement(sec, f"{{{NS}}}abbrev"); sa.set("locale", "en"); sa.text = sec_name.upper().replace(" ", "_")
        st = ET.SubElement(sec, f"{{{NS}}}title"); st.set("locale", "en"); st.text = sec_name
    arts = ET.SubElement(el, f"{{{NS}}}articles")
    for a in articles:
        art = ET.SubElement(arts, f"{{{NS}}}article")
        art.set("stage", "submission")
        art.set("locale", a.get("language") or "en")
        if a.get("date_published"):
            art.set("date_submitted", a["date_published"])
        art.set("status", "3")
        if a.get("id"):
            ide = ET.SubElement(art, f"{{{NS}}}id"); ide.set("type", "internal"); ide.set("advice", "ignore"); ide.text = str(a["id"])
            art.set("current_publication_id", str(a["id"]))
        if a.get("doi"):
            ide = ET.SubElement(art, f"{{{NS}}}id"); ide.set("type", "doi"); ide.set("advice", "update"); ide.text = a["doi"]
        pub = ET.SubElement(art, f"{{{NS}}}publication")
        pub.set("section_ref", (a.get("section") or "Articles").upper().replace(" ", "_"))
        pub.set("seq", str(a.get("seq", 1)))
        pub.set("status", "3")
        if a.get("id"):
            # ID internal di dalam publication = kunci importer menautkan
            # currentPublicationId (dicocokkan dengan attr article
            # current_publication_id yang sudah diset di atas).
            pi = ET.SubElement(pub, f"{{{NS}}}id"); pi.set("type", "internal"); pi.set("advice", "ignore"); pi.text = str(a["id"])
        if a.get("date_published"):
            pub.set("date_published", a["date_published"])
        pub.append(L("title", a.get("language") or "en", a.get("title") or ""))
        if a.get("subtitle"):
            pub.append(L("subtitle", a.get("language") or "en", a["subtitle"]))
        if a.get("abstract"):
            pub.append(L("abstract", a.get("language") or "en", a["abstract"]))
        if a.get("keywords"):
            kw = ET.Element(f"{{{NS}}}keywords"); kw.set("locale", a.get("language") or "en")
            for k in a["keywords"]:
                ke = ET.SubElement(kw, f"{{{NS}}}keyword")
                ne = ET.SubElement(ke, f"{{{NS}}}name"); ne.text = k
            pub.append(kw)
        if a.get("jel"):
            subj = ET.Element(f"{{{NS}}}subjects"); subj.set("locale", a.get("language") or "en")
            for j in a["jel"]:
                se = ET.SubElement(subj, f"{{{NS}}}subject")
                ne = ET.SubElement(se, f"{{{NS}}}name"); ne.text = j
            pub.append(subj)
        if a.get("authors"):
            auths = ET.SubElement(pub, f"{{{NS}}}authors")
            for au in a["authors"]:
                author = ET.SubElement(auths, f"{{{NS}}}author")
                author.set("user_group_ref", "Author")
                author.set("seq", str(au.get("seq", 1)))
                author.set("id", str(au.get("seq", 1)))
                if au.get("corresponding"):
                    author.set("primary_contact", "true")
                gn = ET.SubElement(author, f"{{{NS}}}givenname"); gn.set("locale", a.get("language") or "en"); gn.text = au.get("given") or ""
                if au.get("family"):
                    fn = ET.SubElement(author, f"{{{NS}}}familyname"); fn.set("locale", a.get("language") or "en"); fn.text = au["family"]
                if au.get("affiliation"):
                    aff = ET.SubElement(author, f"{{{NS}}}affiliation")
                    an = ET.SubElement(aff, f"{{{NS}}}name"); an.set("locale", a.get("language") or "en"); an.text = au["affiliation"]
                em = ET.SubElement(author, f"{{{NS}}}email"); em.text = ""
                if au.get("orcid"):
                    orc = ET.SubElement(author, f"{{{NS}}}orcid"); orc.text = "https://orcid.org/" + au["orcid"]
        for g in a.get("galleys", []):
            if g.get("url"):
                rep = ET.SubElement(pub, f"{{{NS}}}article_galley")
                rep.set("locale", a.get("language") or "en")
                nm = ET.SubElement(rep, f"{{{NS}}}name"); nm.set("locale", a.get("language") or "en"); nm.text = g.get("label") or "PDF"
                seq = ET.SubElement(rep, f"{{{NS}}}seq"); seq.text = "1"
                remote = ET.SubElement(rep, f"{{{NS}}}remote"); remote.set("src", g["url"])
        if a.get("references"):
            cits = ET.Element(f"{{{NS}}}citations"); cits.set("locale", a.get("language") or "en")
            for ref in a["references"]:
                c = ET.SubElement(cits, f"{{{NS}}}citation"); c.text = ref.get("raw", "")
            pub.append(cits)
        pub.append(issue_identification(issue))
        if a.get("pages"):
            pg = ET.SubElement(pub, f"{{{NS}}}pages"); pg.text = a["pages"]
    return el


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--input", required=True)
    ap.add_argument("--out", required=True)
    args = ap.parse_args()

    with open(args.input, encoding="utf-8") as f:
        data = json.load(f)

    issues = data.get("issues", [])
    articles = data.get("articles", [])
    by_issue = {}
    for a in articles:
        by_issue.setdefault(a.get("issue_id"), []).append(a)

    out_dir = args.out.rstrip("/")
    os.makedirs(out_dir, exist_ok=True)
    base_dir = os.path.dirname(out_dir)

    known_ids = {i["id"] for i in issues}
    for iid in by_issue:
        if iid not in known_ids and iid is not None:
            issues.append({"id": iid, "volume": None, "number": None, "year": None,
                           "title": None, "date_published": None, "url": None})
            known_ids.add(iid)

    urls_rows = []
    count = 0
    for issue in issues:
        iid = issue["id"]
        arts = by_issue.get(iid, [])
        if not arts:
            continue
        root = ET.Element(f"{{{NS}}}issues")
        root.append(build_issue(issue, arts))
        ET.indent(root, space="  ")
        out_path = os.path.join(out_dir, f"issue-{iid}.xml")
        with open(out_path, "w", encoding="utf-8") as f:
            f.write('<?xml version="1.0" encoding="UTF-8"?>\n')
            f.write(ET.tostring(root, encoding="unicode"))
            f.write("\n")
        for a in arts:
            if a.get("url"):
                urls_rows.append((a["url"], "PENDING", "article"))
            for g in a.get("galleys", []):
                if g.get("url"):
                    urls_rows.append((g["url"], "PENDING", "galley"))
        count += 1

    csv_path = os.path.join(base_dir, "urls.csv")
    with open(csv_path, "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["old_url", "new_url", "type"])
        w.writerows(urls_rows)

    readme_path = os.path.join(base_dir, "README.md")
    with open(readme_path, "w", encoding="utf-8") as f:
        f.write("# Impor Native XML\n\n")
        f.write("Hasil konverter `import/to_native_xml.py`.\n\n")
        f.write("## Cara pakai\n")
        f.write("1. Jalankan `python3 import/fetch.py` (hasilkan articles.json).\n")
        f.write("2. Jalankan `python3 import/to_native_xml.py --input import/raw/articles.json --out import/xml/`.\n")
        f.write("3. Di OJS admin: Tools -> Import/Export -> Native XML, unggah `import/xml/issue-*.xml`.\n\n")
        f.write("## Asumsi & batasan\n")
        f.write("- Satu file XML per issue (issue-N.xml).\n")
        f.write("- Galley diimpor sebagai remote (URL lama); unduh PDF manual bila perlu.\n")
        f.write("- Referensi diimpor sebagai citation mentah (string), bukan DOI terstruktur.\n")
        f.write("- ORCID/afiliasi penulis: afiliasi masuk; ORCID tidak didukung Native XML.\n")
        f.write("- ID artikel baru ditentukan OJS saat impor; pemetaan URL lama->baru ada di urls.csv (kolom new_url = PENDING, isi manual setelah impor).\n")
        f.write("- Validasi: `xmllint --schema ojs/plugins/importexport/native/native.xsd file.xml`.\n")

    print(f"Generated: {count} issue files, {len(urls_rows)} url mappings")


if __name__ == "__main__":
    main()
