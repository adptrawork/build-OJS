# Impor Native XML

Hasil konverter `import/to_native_xml.py`.

## Cara pakai
1. `./scripts/setup.sh` — tarik OJS 3.5.0-5 (skip unduhan dataset ROR dev).
2. `./scripts/install.sh` — instal non-interaktif (admin `admin/jeki-admin`),
   fix `allowed_hosts`, create journal JEKI, symlink theme/plugin, register.
3. Import data demo: `ddev exec bash -c 'cd ojs && php tools/importExport.php
   NativeImportExportPlugin import ../import/xml/issue-937.xml JEKI --user_name admin'`.
4. Aktifkan tema: `ddev mysql db -e "UPDATE journal_settings SET setting_value='classic'
   WHERE journal_id=1 AND setting_name='themePluginPath';"` (classic sudah terpasang dari
   pkp/classic v1_1_3-2).
5. Cara CLI impor detail:
   ```
   ddev exec -j bash -c 'cd ojs && php tools/importExport.php NativeImportExportPlugin import ../import/xml/issue-937.xml JEKI --user_name admin'
   ```
   Root `<issue>` membawa `<sections>`-nya sendiri → tanpa param `issue_id/section_id`.

## Asumsi & batasan
- Satu file XML per issue (issue-N.xml).
- Galley diimpor sebagai remote (URL lama); unduh PDF manual bila perlu.
- Referensi diimpor sebagai citation mentah (string), bukan DOI terstruktur.
- ORCID/afiliasi penulis: afiliasi masuk; ORCID tidak didukung Native XML.
- ID artikel baru ditentukan OJS saat impor; pemetaan URL lama->baru ada di urls.csv (kolom new_url = PENDING, isi manual setelah impor).
- Validasi: `xmllint --schema ojs/plugins/importexport/native/native.xsd file.xml`.
