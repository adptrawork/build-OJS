# Template override

Daftar file theme `default` yang di-override theme `akdisi`. Setiap upgrade OJS
(patch 3.5.x) wajib memeriksa file di daftar ini terhadap versi baru.

| File override | Alasan | Terakhir dicek |
|---|---|---|
| `indexJournal.tpl` | Homepage custom: hero + card grid (slot `?slots=1`) | 2026-10-29 |
| `article.tpl` | Halaman artikel dengan slot data + JSON-LD head | 2026-10-29 |
| `issue.tpl` | Halaman issue dengan slot data | 2026-10-29 |
| `components/headerHead.tpl` | canonical, OG tags, JSON-LD (`{literal}` wrap) | 2026-10-29 |

Aturan:

- Override seminimal mungkin. Kalau bisa diselesaikan lewat CSS atau theme
  option, jangan override template.
- Setiap override dicatat di sini **sebelum** di-commit.
- Perubahan struktur markup OJS (bukan sekadar class) adalah tanda bahaya:
  periksa apakah hook resmi bisa dipakai.
