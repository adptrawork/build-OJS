# Impor Native XML

Hasil konverter `import/to_native_xml.py`.

## Cara pakai
1. Jalankan `python3 import/fetch.py` (hasilkan articles.json).
2. Jalankan `python3 import/to_native_xml.py --input import/raw/articles.json --out import/xml/`.
3. Di OJS admin: Tools -> Import/Export -> Native XML, unggah `import/xml/issue-*.xml`.

## Asumsi & batasan
- Satu file XML per issue (issue-N.xml).
- Galley diimpor sebagai remote (URL lama); unduh PDF manual bila perlu.
- Referensi diimpor sebagai citation mentah (string), bukan DOI terstruktur.
- ORCID/afiliasi penulis: afiliasi masuk; ORCID tidak didukung Native XML.
- ID artikel baru ditentukan OJS saat impor; pemetaan URL lama->baru ada di urls.csv (kolom new_url = PENDING, isi manual setelah impor).
- Validasi: `xmllint --schema ojs/plugins/importexport/native/native.xsd file.xml`.
