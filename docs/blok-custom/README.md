# Blok Custom Footer — JRDC OJS

Tiga blok siap pasang untuk area footer tema Individualize (`.footer-sidebar`).
Blok dibuat lewat plugin **Custom Block Manager**, jadi tidak ada file tema yang perlu diubah.

| File | Block Name (isi persis) | Isi |
|---|---|---|
| `01-identitas-jurnal.html` | `Identitas Jurnal` | Nama jurnal, e-ISSN, frekuensi, penerbit, lisensi |
| `02-untuk-penulis.html` | `Untuk Penulis` | 4 tautan ke halaman pedoman penulis |
| `03-etika-integritas.html` | `Etika & Integritas` | 3 tautan ke kebijakan etika, plagiarisme, AI |

Blok hanya dirender di **footer**, muncul di **semua halaman**, satu kolom di ponsel, dua kolom
di tablet, empat kolom di layar lebar (`xl`). Footer sudah berisi 2 blok bawaan
(*Latest publications* dan *Information*), sehingga total menjadi 5 blok.

---

## Prasyarat

1. Login sebagai admin: `https://jrdc-ojs.ddev.site:8443/index.php/index/login`
2. Plugin **Custom Block Manager** sudah aktif untuk jurnal `jrdc` (sudah dicek: aktif).
3. File `.html` di folder ini terbuka di editor teks.

---

## Cara pasang (ulangi untuk 3 blok)

### 1. Buka pengaturan plugin

Buka:
`https://jrdc-ojs.ddev.site:8443/index.php/jrdc/management/settings/website#plugins/installedPlugins`

Atau lewat menu: **Settings → Website → Plugins → Installed Plugins**.

> Catatan: URL di atas hanya bisa dibuka setelah login sebagai admin jurnal.
> Kalau tab tidak berpindah, klik tab **Plugins** lalu sub-tab **Installed Plugins**.

### 2. Buka Custom Block Manager

Cari baris **Custom Block Manager** di daftar plugin → klik tautan **Manage**.
Muncul jendela **Custom Blocks** berisi tombol **Add Block**.

### 3. Isi formulir

| Kolom | Isi |
|---|---|
| **Block Name** | Judul dari tabel di atas, contoh `Identitas Jurnal` |
| **Content** | HTML dari file `.html` yang sesuai |
| **Show Name** | centang (agar judul blok tampil di atas isi) |

Untuk mengisi **Content** dengan HTML mentah:

1. Klik tombol **Source code** (`<>`) di toolbar editor.
2. Hapus isi kotak, tempel seluruh isi file `.html`.
3. Klik **Save** pada dialog source code, lalu **Save** pada formulir blok.

Alternatif: tempel HTML ke editor langsung, lalu rapikan dengan tombol *bulleted list*.
Cara *Source code* lebih aman karena tautan tidak berubah.

### 4. Ulangi untuk blok ke-2 dan ke-3

Buat berurutan: **Identitas Jurnal → Untuk Penulis → Etika & Integritas**.
Urutan tampil mengikuti urutan pembuatan, tidak ada tombol drag-and-drop.
Kalau urutan terlanjur salah: hapus blok (ikon **Delete** di grid) lalu buat ulang.

### 5. Verifikasi

Buka `https://jrdc-ojs.ddev.site:8443/index.php/jrdc`, scroll ke footer.
Ketiga blok baru muncul setelah *Latest publications* dan *Information*.

Cek cepat lewat terminal:

```bash
curl -sk https://jrdc-ojs.ddev.site:8443/index.php/jrdc | grep -c 'block_custom'
# hasil yang diharapkan: 3
```

Cek tautan di dalam blok mengembalikan 200:

```bash
for p in author-guidelines peer-review-process author-fees about/submissions \
         publication-ethics plagiarism-policy ai-policy; do
  printf '%-22s %s\n' "$p" \
    "$(curl -sk -o /dev/null -w '%{http_code}' "https://jrdc-ojs.ddev.site:8443/index.php/jrdc/$p")"
done
```

---

## Penyesuaian setelah terpasang

| Hal | Cara |
|---|---|
| e-ISSN terbit | Edit blok **Identitas Jurnal** → ganti `xxxx-xxxx` |
| Tambah bahasa Indonesia sebagai locale utama | Isi juga tab bahasa `Bahasa Indonesia` pada Block Name dan Content (blok otomatis memakai locale aktif, dengan fallback ke locale utama jurnal) |
| Ubah teks/tautan | **Manage** → ikon **Edit** pada blok |
| Hapus blok | **Manage** → ikon **Delete** |
| Tambah blok ke-4 | Buat lewat **Add Block**; gaya otomatis ikut tema |

---

## Bersihkan plugin blok yang tidak dipakai (opsional, disarankan)

Masih di **Settings → Website → Plugins → Installed Plugins**, hilangkan centang pada kolom
jurnal untuk plugin berikut, lalu simpan:

| Plugin | Alasan |
|---|---|
| **Subscription Block** | Jurnal akses terbuka, tidak ada langganan |
| **Language Toggle Block** | Baru satu bahasa aktif, blok tidak merender apa pun |
| **Information Block** | Tautan *For Readers/For Authors/For Librarians* menduplikasi menu footer dan berbahasa Inggris |

Kalau **Information Block** dimatikan, footer menyisakan 4 blok: 3 blok custom +
*Latest publications* — pas untuk grid 4 kolom di layar lebar.

---

## Catatan teknis

- Isi blok disimpan di tabel `plugin_settings` dengan nama plugin = judul dalam kebab-case
  (`identitas-jurnal`, `untuk-penulis`, `etika-integritas`).
- Blok bersifat global; tidak ada penargetan per halaman tanpa mengubah template tema.
- Tautan memakai path absolut `/index.php/jrdc/...` karena konten blok tidak diproses
  oleh template `{url}` OJS. Kalau nanti jurnal dipindah ke domain root tanpa `/index.php`,
  tautan perlu disesuaikan.
- Jangan menempelkan `<h2>` di **Content**: judul blok sudah dibuat otomatis dari **Block Name**.
