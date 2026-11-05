# Konten Halaman OJS 3.5 — Jurnal Ekonomi dan Bisnis JRDC

Dokumen kerja untuk mengisi halaman statis, halaman *About*, dan metadata jurnal pada OJS 3.5
(tema Individualize). Semua teks berbahasa Indonesia, siap tempel ke editor OJS.

Referensi struktur: `docs/COMPANY_PROFILE.md`.

---

## 0. Cara pakai

1. Ganti nilai di tabel **Placeholder** (bagian 1) dengan data resmi jurnal.
2. Isi metadata di **Settings → Journal → Journal Settings** (bagian 2).
3. Tempel isi `about` pada halaman *About the Journal* (bagian 3).
4. Buat halaman kebijakan lewat plugin **Static Pages** (bagian 4). Satu halaman = satu entri
   (`Title`, `Path`, `Content`).
5. Susun menu di **Settings → Website → Navigation** (bagian 6).
6. Sebelum publish, jalankan checklist SEO di bagian 8.

Catatan teknis OJS 3.5:

- Halaman *About* hanya merender satu field `about`. Kebijakan fokus/scope, peer review,
  frekuensi, lisensi, biaya, dan etika **tidak lagi** jadi field terpisah; tempatkan sebagai
  Static Pages.
- OJS **tidak** menyediakan meta description per halaman. Yang ada hanya `searchDescription`
  global pada Journal Settings. Nilai meta description per halaman di bawah ini dipakai kalau
  nanti dibuat override tema (`customHeaders` atau templates), atau sebagai ringkasan untuk
  menu/kartu beranda.
- OJS 3.5 **tidak** membangkitkan `sitemap.xml` (tidak ada plugin bawaan). Lihat bagian 8.
- OJS tidak menambahkan `<link rel="canonical">` secara otomatis pada semua template. Kalau
  dibutuhkan, tambahkan lewat override tema.
- H1 halaman berasal dari `Title` halaman statis. Jangan ulangi H1 di dalam `Content`.

---

## 1. Placeholder

| Placeholder | Nilai usulan | Catatan |
|---|---|---|
| Nama jurnal | Jurnal Ekonomi dan Bisnis JRDC | Ganti bila sudah ada SK/ISSN |
| Singkatan | JEB-JRDC | Dipakai di sitasi dan header |
| URL path jurnal | `jeb-jrdc` | Huruf kecil, tanpa spasi |
| e-ISSN | `xxxx-xxxx` | Isi setelah terbit dari ISSN Indonesia |
| p-ISSN | `xxxx-xxxx` | Kosongkan bila hanya daring |
| Tahun mulai | 2026 | Sesuaikan |
| Frekuensi | 2 nomor/tahun (April, Oktober) | Sesuaikan |
| Email jurnal | `jurnal@jrdc.ac.id` | Ganti domain resmi |
| Telepon/WA | `+62 xxx-xxxx-xxxx` | |
| Alamat | `Jl. ... , Kota ..., Indonesia` | Alamat lengkap kantor |
| Penerbit | Yayasan Ratu Dirgantara Cendikiawan (JRDC) | |
| Ketua Yayasan | `Nama` | Untuk halaman *Tentang Penerbit* |
| DOI prefix | `10.xxxxx` | Dari Crossref, bila diaktifkan |
| Lisensi | CC BY 4.0 | |
| Similarity maksimum | 20% | |

---

## 2. Metadata jurnal (Settings → Journal → Journal Settings)

| Field OJS | Isi |
|---|---|
| Journal Name | Jurnal Ekonomi dan Bisnis JRDC |
| Acronym / Abbreviation | JEB-JRDC |
| URL Path | `jeb-jrdc` |
| Publisher | Yayasan Ratu Dirgantara Cendikiawan |
| ISSN (online) | `xxxx-xxxx` |
| ISSN (print) | `xxxx-xxxx` (bila ada) |
| Open Access | Ya, tanpa embargo |
| License URL | `https://creativecommons.org/licenses/by/4.0/` |
| Keywords | ekonomi; bisnis; manajemen; akuntansi; keuangan; pemasaran; kewirausahaan; ekonomi pembangunan |
| Contact Name | `Nama Penanggung Jawab` |
| Contact Email | `jurnal@jrdc.ac.id` |
| Contact Phone | `+62 xxx-xxxx-xxxx` |
| Mailing Address | `Jl. ..., Kota ..., Indonesia` |
| Country | Indonesia |
| Review Mode | Double-blind |
| Reviewer response time | 2 minggu |
| Review deadline | 4 minggu |

### 2.1 `Description` (deskripsi jurnal untuk metadata/OAI)

> Jurnal Ekonomi dan Bisnis JRDC adalah jurnal ilmiah akses terbuka yang diterbitkan oleh
> Yayasan Ratu Dirgantara Cendikiawan (JRDC). Jurnal mempublikasikan hasil penelitian dan kajian
> di bidang ekonomi dan bisnis, meliputi manajemen, akuntansi, keuangan, pemasaran,
> kewirausahaan, dan ekonomi pembangunan. Seluruh naskah menjalani telaah sejawat double-blind
> dan diterbitkan dua kali setahun. Artikel tersedia daring tanpa biaya bagi penulis maupun
> pembaca dengan lisensi Creative Commons Attribution 4.0.

### 2.2 `Search Description` (meta description global, ≤160 karakter)

> Jurnal ilmiah akses terbuka bidang ekonomi dan bisnis dari Yayasan Ratu Dirgantara
> Cendekiawan. Telaah sejawat double-blind, terbit dua kali setahun.

### 2.3 Deskripsi pendek untuk kartu beranda / daftar jurnal

> Jurnal Ekonomi dan Bisnis JRDC menerbitkan penelitian dan kajian bidang ekonomi dan bisnis
> dengan telaah sejawat double-blind dan akses terbuka penuh.

### 2.4 Tagline tema

> Riset ekonomi dan bisnis yang terbuka untuk semua.

---

## 3. Halaman About (`about`)

**Lokasi OJS:** Settings jurnal → About the Journal
**Judul tampil:** About the Journal / Tentang Jurnal (judul ini otomatis, bukan bagian konten)

### Isi

Yayasan Ratu Dirgantara Cendikiawan (JRDC) menerbitkan Jurnal Ekonomi dan Bisnis JRDC sebagai
wadah publikasi ilmiah bidang ekonomi dan bisnis. Jurnal ini menjadi ruang bagi akademisi,
peneliti, mahasiswa, dan praktisi untuk menyampaikan hasil penelitian, kajian konseptual, studi
kasus, maupun analisis kebijakan yang relevan dengan perkembangan ekonomi dan bisnis.

Fokus awal penerbitan mencakup manajemen, akuntansi, keuangan, pemasaran, kewirausahaan, dan
ekonomi pembangunan. Ruang lingkup dikembangkan secara bertahap mengikuti kebutuhan keilmuan,
dengan tetap berpegang pada orientasi utama bidang ekonomi dan bisnis.

Setiap naskah yang masuk diperiksa kelengkapan dan kesesuaiannya dengan ruang lingkup, kemudian
ditelaah oleh mitra bestari melalui mekanisme telaah sejawat double-blind. Keputusan editorial
didasarkan pada mutu keilmuan, orisinalitas, ketepatan metode, dan kontribusi terhadap
perkembangan ilmu serta praktik. Jurnal menerapkan prinsip integritas akademik, keterbukaan
akses, dan penghormatan terhadap hak penulis.

Jurnal diterbitkan dua kali setahun, pada April dan Oktober. Seluruh artikel tersedia dalam
akses terbuka penuh di bawah lisensi Creative Commons Attribution 4.0, tanpa biaya submission,
proses editorial, maupun publication.

### Visi

Menjadi penerbit jurnal ilmiah yang kredibel dan berorientasi pada pengembangan ilmu pengetahuan
di bidang ekonomi dan bisnis melalui publikasi yang berkualitas, berintegritas, dan bermanfaat
bagi masyarakat akademik maupun praktisi.

### Misi

1. Mendukung pengembangan ilmu pengetahuan di bidang ekonomi dan bisnis melalui penerbitan hasil
   penelitian dan kajian ilmiah.
2. Menyelenggarakan penerbitan jurnal yang mengutamakan mutu artikel, ketepatan proses
   editorial, dan standar publikasi ilmiah.
3. Mendorong budaya penelitian, penulisan, dan publikasi ilmiah di kalangan akademisi, peneliti,
   dan mahasiswa.
4. Memfasilitasi penyebarluasan hasil penelitian yang relevan bagi pengembangan teori,
   pengambilan keputusan, dan praktik ekonomi dan bisnis.
5. Menjunjung tinggi etika publikasi, integritas akademik, dan keterbukaan akses terhadap
   pengetahuan ilmiah.

### Penerbit

Yayasan Ratu Dirgantara Cendikiawan (JRDC)
`Jl. ..., Kota ..., Indonesia`
`jurnal@jrdc.ac.id`

---

## 4. Static Pages

Buat melalui **Settings → Website → Plugins → Static Pages** (plugin aktif) → *Add Page*.
Kolom `Path` menjadi URL: `https://<domain>/index.php/<journal-path>/<path>`.
Judul halaman menjadi H1.

Ringkasan:

| No | Title | Path | Prioritas |
|---|---|---|---|
| 1 | Focus and Scope | `focus-and-scope` | Wajib |
| 2 | Peer Review Process | `peer-review-process` | Wajib |
| 3 | Author Guidelines | `author-guidelines` | Wajib (bisa juga pakai field bawaan) |
| 4 | Publication Frequency | `publication-frequency` | Wajib |
| 5 | Open Access Policy | `open-access-policy` | Wajib |
| 6 | Copyright and Licensing | `copyright-and-licensing` | Wajib |
| 7 | Author Fees | `author-fees` | Wajib |
| 8 | Archiving | `archiving` | Wajib |
| 9 | Publication Ethics | `publication-ethics` | Wajib |
| 10 | Plagiarism and Similarity Policy | `plagiarism-policy` | Wajib |
| 11 | Reviewer Guidelines | `reviewer-guidelines` | Penting |
| 12 | Section Policies | `section-policies` | Penting |
| 13 | Artificial Intelligence Policy | `ai-policy` | Penting |
| 14 | Indexing and Abstracting | `indexing-and-abstracting` | Penting |
| 15 | About the Publisher | `about-the-publisher` | Opsional |
| 16 | Contact and Editorial Office | `contact` | Penting |

### 4.1 Focus and Scope

**Path:** `focus-and-scope`
**SEO title:** Fokus dan Ruang Lingkup | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Ruang lingkup Jurnal Ekonomi dan Bisnis JRDC: manajemen,
akuntansi, keuangan, pemasaran, kewirausahaan, dan ekonomi pembangunan.

Jurnal Ekonomi dan Bisnis JRDC mempublikasikan hasil penelitian dan kajian ilmiah di bidang
ekonomi dan bisnis. Ruang lingkup mencakup, namun tidak terbatas pada:

- Manajemen: manajemen strategik, sumber daya manusia, operasi, dan tata kelola organisasi.
- Akuntansi: akuntansi keuangan, manajemen, sektor publik, audit, dan pelaporan keberlanjutan.
- Keuangan: pasar modal, manajemen risiko, perbankan, keuangan syariah, dan keuangan publik.
- Pemasaran: perilaku konsumen, pemasaran digital, merek, dan riset pasar.
- Kewirausahaan: usaha baru, inovasi, usaha mikro dan kecil, serta ekosistem kewirausahaan.
- Ekonomi pembangunan: kebijakan fiskal dan moneter, ketenagakerjaan, kemiskinan, dan
  pembangunan daerah.

Jenis tulisan yang diterima:

1. Artikel penelitian kuantitatif, kualitatif, atau metode campuran.
2. Kajian konseptual dan telaah literatur sistematis.
3. Studi kasus dengan kontribusi teoretis atau praktis yang jelas.
4. Analisis kebijakan ekonomi dan bisnis.

Naskah harus memiliki kontribusi keilmuan atau praktis yang dinyatakan secara eksplisit,
menggunakan metode yang dijelaskan dengan memadai, dan menaati etika penelitian. Naskah yang
hanya berupa opini, ringkasan tanpa analisis, atau laporan kegiatan internal tidak diterima.

### 4.2 Peer Review Process

**Path:** `peer-review-process`
**SEO title:** Proses Telaah Sejawat | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Alur telaah sejawat double-blind Jurnal Ekonomi dan Bisnis
JRDC, dari pemeriksaan awal hingga keputusan editorial.

Seluruh naskah penelitian yang lolos pemeriksaan awal menjalani telaah sejawat secara
double-blind: identitas penulis dan penelaah tidak saling diketahui. Tahapan proses:

1. **Pemeriksaan awal (7 hari kerja).** Pemeriksaan kelengkapan berkas, kesesuaian ruang
   lingkup, kesamaan teks, dan kepatuhan pada pedoman penulis. Naskah yang tidak memenuhi syarat
   dikembalikan tanpa telaah substantif.
2. **Penugasan editor.** Editor bagian menilai kesesuaian naskah dan menunjuk minimal dua
   mitra bestari.
3. **Telaah sejawat (4 minggu).** Penelaah menilai orisinalitas, ketepatan metode, kecukupan
   data, kejelasan argumentasi, dan kontribusi. Penelaah dapat menerima, meminta revisi, atau
   menolak.
4. **Keputusan editorial.** Berdasarkan rekomendasi penelaah, editor menetapkan salah satu:
   diterima tanpa revisi, diterima dengan revisi minor, revisi mayor, atau ditolak.
5. **Revisi penulis (2–4 minggu).** Penulis menyertakan surat tanggapan yang menjawab setiap
   catatan penelaah.
6. **Pemeriksaan akhir dan tata letak.** Editor memeriksa hasil revisi dan menyiapkan artikel
   untuk terbit.

Keputusan akhir berada pada editor. Penulis yang tidak setuju dapat mengajukan keberatan
tertulis kepada editor dengan alasan substantif, dan keberatan akan ditinjau sekali lagi.
Penelaah dan editor wajib menyatakan tidak memiliki konflik kepentingan. Naskah yang ditolak
tidak disimpan untuk digunakan pihak lain, dan identitas serta isi naskah dijaga
kerahasiaannya.

### 4.3 Author Guidelines

**Path:** `author-guidelines`
**SEO title:** Pedoman Penulis | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Persyaratan naskah, format, gaya sitasi APA 7, dan alur
pengiriman naskah ke Jurnal Ekonomi dan Bisnis JRDC.

#### Jenis dan bahasa naskah

Naskah ditulis dalam bahasa Indonesia atau bahasa Inggris, dengan panjang 6.000–10.000 kata
(termasuk daftar pustaka), diketik pada A4, margin 2,5 cm, huruf Times New Roman 12 pt, spasi
1,5, dan rata kiri-kanan. Naskah dikirim dalam format `.docx` melalui situs jurnal. Naskah yang
dikirim lewat surel tidak diproses.

#### Struktur naskah

1. Judul (maksimal 15 kata, informatif, tanpa singkatan yang tidak lazim).
2. Nama penulis, afiliasi, kota, negara, dan ORCID (bila ada), tanpa gelar akademik.
3. Abstrak 150–250 kata dalam bahasa Indonesia dan bahasa Inggris, memuat tujuan, metode, hasil,
   dan simpulan. Cantumkan 3–5 kata kunci.
4. Pendahuluan: latar belakang, kesenjangan penelitian, tujuan, dan kebaruan.
5. Tinjauan pustaka dan pengembangan hipotesis atau kerangka analisis.
6. Metode: desain, populasi dan sampel, teknik pengumpulan data, variabel, dan teknik analisis.
7. Hasil dan pembahasan.
8. Simpulan, keterbatasan, dan saran.
9. Pernyataan kontribusi penulis, pendanaan, dan konflik kepentingan.
10. Daftar pustaka.

#### Gaya sitasi

Gunakan APA edisi ke-7. Sitasi dalam teks: (Nama, tahun) atau Nama (tahun). Daftar pustaka
disusun alfabetis, hanya memuat sumber yang disitasi, dengan DOI bila tersedia. Contoh:

> Kusuma, R., & Hartono, B. (2025). Digital transformation and SME performance in Indonesia.
> *Jurnal Ekonomi dan Bisnis*, 12(1), 45–62. https://doi.org/10.xxxxx/xxxxx

#### Tabel, gambar, dan lampiran

Tabel dan gambar diberi nomor berurutan, diberi judul, dan dirujuk dalam teks. Data mentah yang
panjang diletakkan sebagai lampiran. Gambar dikirim dengan resolusi minimal 300 dpi.

#### Ketentuan etika

- Naskah belum pernah terbit dan tidak sedang dipertimbangkan di jurnal lain.
- Kesamaan teks maksimal 20% dan tidak ada kesamaan tunggal di atas 5%.
- Penelitian yang melibatkan manusia memerlukan persetujuan etik atau pernyataan bahwa
  partisipasi berlangsung secara sukarela dengan data dianonimkan.
- Penggunaan alat bantu kecerdasan buatan wajib diungkapkan pada bagian metode atau pernyataan
  terpisah. Alat bantu tidak dapat dicantumkan sebagai penulis.
- Penulis bertanggung jawab atas izin penggunaan materi pihak ketiga.

#### Alur pengiriman

1. Daftar akun atau masuk ke situs jurnal.
2. Pilih *New Submission*, lengkapi semua langkah, dan unggah berkas naskah serta berkas
   pendukung.
3. Pastikan metadata semua penulis sudah benar, termasuk afiliasi dan ORCID.
4. Pantau status melalui dasbor. Rata-rata waktu keputusan pertama adalah 4–6 minggu.
5. Setelah diterima, penulis memeriksa tata letak final sebelum terbit.

Pertanyaan dapat dikirim ke `jurnal@jrdc.ac.id`.

### 4.4 Publication Frequency

**Path:** `publication-frequency`
**SEO title:** Frekuensi Terbit | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Jurnal Ekonomi dan Bisnis JRDC terbit dua kali setahun, pada
April dan Oktober.

Jurnal Ekonomi dan Bisnis JRDC terbit dua kali setahun, yaitu nomor April dan nomor Oktober.
Setiap nomor memuat artikel yang telah menyelesaikan proses telaah sejawat dan tata letak.
Artikel yang telah diterima dapat diterbitkan lebih awal sebagai artikel daring (*ahead of
print*) tanpa menunggu penerbitan nomor, dengan penanda halaman dan DOI yang tetap.

### 4.5 Open Access Policy

**Path:** `open-access-policy`
**SEO title:** Kebijakan Akses Terbuka | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Seluruh artikel Jurnal Ekonomi dan Bisnis JRDC tersedia bebas
dengan lisensi CC BY 4.0, tanpa embargo dan tanpa biaya.

Jurnal Ekonomi dan Bisnis JRDC menerapkan akses terbuka penuh. Seluruh artikel dapat dibaca,
diunduh, disalin, disebarkan, dan digunakan kembali secara bebas untuk kepentingan pendidikan
dan penelitian, dengan syarat mencantumkan atribusi kepada penulis dan sumber asli sesuai
lisensi Creative Commons Attribution 4.0 (CC BY 4.0).

Kebijakan yang berlaku:

- Tidak ada embargo. Artikel langsung tersedia saat diterbitkan.
- Tidak ada biaya berlangganan, biaya baca, maupun biaya publikasi.
- Penulis tetap memegang hak cipta dan memberi izin penggunaan kepada publik melalui lisensi
  CC BY 4.0.
- Penulis boleh mengunggah versi terbit artikel ke repositori institusi atau laman pribadi
  dengan tautan ke DOI resmi.
- Penerbit menyimpan metadata dan berkas artikel untuk pelestarian jangka panjang.

### 4.6 Copyright and Licensing

**Path:** `copyright-and-licensing`
**SEO title:** Hak Cipta dan Lisensi | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Penulis memegang hak cipta; artikel diterbitkan dengan lisensi
Creative Commons Attribution 4.0.

Penulis memegang hak cipta atas artikelnya. Dengan menerbitkan di jurnal ini, penulis memberikan
izin kepada penerbit untuk mempublikasikan, menyimpan, dan mendistribusikan artikel dalam bentuk
yang telah diterbitkan, serta menyetujui penggunaan lisensi Creative Commons Attribution 4.0
(CC BY 4.0).

Ketentuan lisensi:

- Siapa pun boleh menyalin, mendistribusikan, dan mengadaptasi artikel, termasuk untuk tujuan
  komersial, dengan syarat mencantumkan nama penulis, judul artikel, nama jurnal, dan DOI.
- Penulis dapat membuat perjanjian tambahan untuk distribusi non-eksklusif versi terbit.
- Materi pihak ketiga (gambar, tabel, dataset) tetap tunduk pada lisensi asalnya. Penulis wajib
  memperoleh izin dan mencantumkan atribusi yang sesuai.
- Penerbit tidak menuntut pengalihan hak cipta.

### 4.7 Author Fees

**Path:** `author-fees`
**SEO title:** Biaya Publikasi | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Tidak ada biaya submission, telaah, maupun publication di
Jurnal Ekonomi dan Bisnis JRDC.

Jurnal Ekonomi dan Bisnis JRDC tidak memungut biaya dalam bentuk apa pun:

- Biaya submission: tidak ada.
- Biaya telaah sejawat: tidak ada.
- Article processing charge (APC): tidak ada.
- Biaya tata letak, DOI, dan pemeliharaan artikel: tidak ada.

Apabila di kemudian hari kebijakan biaya berubah, perubahan akan diumumkan di situs jurnal
paling lambat enam bulan sebelum berlaku dan tidak diberlakukan surut terhadap naskah yang sudah
dikirim.

### 4.8 Archiving

**Path:** `archiving`
**SEO title:** Pengarsipan dan Pelestarian | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Artikel diarsipkan melalui PKP Preservation Network, LOCKSS,
dan cadangan berkala penerbit.

Untuk menjamin ketersediaan jangka panjang, jurnal menerapkan:

1. **PKP Preservation Network (PKP PN).** Artikel yang memenuhi syarat diarsipkan secara
   terdistribusi melalui jaringan pelestarian PKP.
2. **LOCKSS.** Penyimpanan salinan pada jaringan perpustakaan mitra, dengan konfigurasi
   yang diaktifkan pada pengaturan jurnal.
3. **DOI melalui Crossref.** Identitas artikel dan tautannya dijaga melalui pendaftaran DOI.
4. **Cadangan penerbit.** Basis data dan berkas artikel dicadangkan secara berkala dan disimpan
   terpisah dari server produksi.

### 4.9 Publication Ethics

**Path:** `publication-ethics`
**SEO title:** Etika Publikasi | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Standar etika publikasi Jurnal Ekonomi dan Bisnis JRDC
mengacu pada pedoman COPE bagi penulis, editor, penelaah, dan penerbit.

Jurnal ini mengikuti prinsip dan pedoman Committee on Publication Ethics (COPE).

**Kewajiban penulis**

- Melaporkan hasil penelitian secara jujur, akurat, dan tanpa manipulasi data.
- Menyebutkan sumber, data, dan kontribusi pihak lain secara lengkap.
- Tidak mengirim naskah yang sama ke jurnal lain selama proses berlangsung.
- Menyatakan pendanaan, konflik kepentingan, dan penggunaan alat bantu kecerdasan buatan.
- Bertanggung jawab atas isi artikel dan kesesuaiannya dengan etika penelitian.

**Kewajiban editor**

- Menilai naskah berdasarkan mutu keilmuan, bukan latar belakang penulis.
- Menjaga kerahasiaan naskah dan identitas penelaah.
- Menyatakan konflik kepentingan dan menyerahkan penanganan naskah kepada editor lain bila
  terjadi konflik.
- Memastikan proses telaah sejawat berjalan wajar dan tepat waktu.

**Kewajiban penelaah**

- Menjaga kerahasiaan naskah dan tidak menggunakannya sebelum terbit.
- Menolak menelaah bila tidak kompeten atau memiliki konflik kepentingan.
- Memberikan penilaian yang argumentatif, spesifik, dan sopan.

**Kewajiban penerbit**

- Menjaga kebebasan editorial dari kepentingan komersial.
- Menyediakan sarana pelaporan dugaan pelanggaran etika.
- Menjamin akses terbuka dan pelestarian artikel.

**Penanganan pelanggaran**

Dugaan plagiarisme, fabrikasi, falsifikasi, duplikasi publikasi, atau konflik kepentingan
diselidiki oleh editor. Tindakan dapat berupa klarifikasi, koreksi, penerbitan ulang pernyataan,
atau penarikan artikel (*retraction*) dengan keterangan yang dapat diakses publik. Penarikan
artikel tidak menghapus catatan terbit; artikel ditandai sebagai ditarik beserta alasannya.

### 4.10 Plagiarism and Similarity Policy

**Path:** `plagiarism-policy`
**SEO title:** Kebijakan Plagiarisme | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Batas kesamaan teks 20% dengan pemeriksaan Turnitin; naskah
yang melanggar dikembalikan atau ditolak.

Setiap naskah diperiksa kesamaan teksnya sebelum penugasan penelaah.

- Batas kesamaan keseluruhan: 20%.
- Batas kesamaan pada satu sumber: 5%.
- Daftar pustaka dan kutipan langsung yang diberi tanda kutip tidak dihitung, tetapi tetap
  diperiksa kewajarannya.
- Penulis wajib menghindari plagiarisme diri (*self-plagiarism*), termasuk menyalin bagian
  artikelnya sendiri tanpa rujukan.
- Naskah yang terindikasi plagiarisme dikembalikan untuk diperbaiki atau ditolak.
- Pelanggaran berulang mengakibatkan larangan mengirim naskah untuk periode tertentu.

Pemeriksaan dilakukan dengan Turnitin atau perangkat sejenis. Hasil pemeriksaan disimpan sebagai
bagian dari berkas editorial.

### 4.11 Reviewer Guidelines

**Path:** `reviewer-guidelines`
**SEO title:** Pedoman Penelaah | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Panduan penilaian naskah bagi mitra bestari Jurnal Ekonomi dan
Bisnis JRDC: kerahasiaan, konflik kepentingan, dan butir penilaian.

Terima kasih telah bersedia menelaah naskah untuk jurnal ini. Telaah Anda menentukan mutu
publikasi.

**Sebelum menelaah**

- Pastikan naskah sesuai dengan bidang keahlian Anda.
- Nyatakan konflik kepentingan, lalu tolak undangan bila ada.
- Jaga kerahasiaan naskah dan jangan membagikannya kepada pihak lain.
- Tentukan tenggat: 4 minggu. Hubungi editor bila membutuhkan tambahan waktu.

**Butir penilaian**

1. Kesesuaian dengan ruang lingkup jurnal.
2. Kebaruan dan kontribusi terhadap teori atau praktik.
3. Kejelasan rumusan masalah dan tujuan.
4. Ketepatan metode, sampel, dan analisis.
5. Kecukupan dan kejelasan penyajian hasil.
6. Kedalaman pembahasan dan kaitannya dengan literatur.
7. Ketepatan simpulan dan keterbatasan.
8. Kualitas penulisan, struktur, dan sitasi.
9. Kepatuhan etika: plagiarisme, izin penelitian, dan konflik kepentingan.

**Format komentar**

- Ringkasan singkat isi naskah.
- Kekuatan utama naskah.
- Catatan per bagian, dengan nomor halaman atau nomor baris.
- Catatan untuk editor (rahasia), termasuk rekomendasi: terima, revisi minor, revisi mayor,
  atau tolak.

Sampaikan kritik pada isi naskah, bukan pada penulis. Komentar harus cukup spesifik agar penulis
dapat melakukan perbaikan. Jangan meminta penulis mengutip karya Anda kecuali benar-benar
relevan.

### 4.12 Section Policies

**Path:** `section-policies`
**SEO title:** Kebijakan Bagian | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Ketentuan bagian artikel penelitian, kajian konseptual, dan
studi kasus di Jurnal Ekonomi dan Bisnis JRDC.

**Artikel Penelitian**
Memuat penelitian empiris dengan metode kuantitatif, kualitatif, atau campuran. Wajib melalui
telaah sejawat double-blind. Panjang 6.000–10.000 kata.

**Kajian Konseptual dan Telaah Literatur**
Memuat pengembangan gagasan, kerangka teoretis, atau telaah literatur sistematis dengan
kontribusi yang jelas. Wajib melalui telaah sejawat double-blind. Panjang 5.000–9.000 kata.

**Studi Kasus**
Memuat analisis kasus organisasi, industri, atau kebijakan dengan pembahasan teoretis dan
implikasi praktis. Wajib melalui telaah sejawat double-blind. Panjang 5.000–8.000 kata.

**Editorial dan Ulasan Buku**
Ditulis atas undangan editor. Tidak melalui telaah sejawat. Panjang maksimal 2.000 kata.

### 4.13 Artificial Intelligence Policy

**Path:** `ai-policy`
**SEO title:** Kebijakan Penggunaan AI | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Ketentuan penggunaan alat bantu kecerdasan buatan dalam
penulisan naskah dan proses telaah sejawat.

Alat bantu kecerdasan buatan (AI generatif) dapat digunakan untuk membantu penyuntingan bahasa,
penelusuran pustaka, atau pengolahan data, dengan ketentuan:

- AI tidak dapat dicantumkan sebagai penulis atau rekan penulis.
- Penulis bertanggung jawab penuh atas seluruh isi artikel, termasuk bagian yang dibantu AI.
- Penggunaan AI wajib diungkapkan pada bagian metode atau pernyataan terpisah: nama alat,
  versi, dan fungsi penggunaannya.
- AI tidak boleh digunakan untuk menghasilkan data, gambar, atau sitasi yang tidak nyata.
- Penelaah dilarang mengunggah naskah ke layanan AI yang menyimpan atau mempublikasikan data,
  karena melanggar kerahasiaan naskah.
- Editor dapat meminta klarifikasi atau menolak naskah yang tidak mengungkapkan penggunaan AI
  secara memadai.

### 4.14 Indexing and Abstracting

**Path:** `indexing-and-abstracting`
**SEO title:** Indeksasi dan Abstraksi | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Status indeksasi Jurnal Ekonomi dan Bisnis JRDC, layanan
OAI-PMH, dan pendaftaran DOI.

Status saat ini:

- Google Scholar — terindeks
- Garuda — terindeks
- Crossref (DOI) — terdaftar
- DOAJ — dalam proses
- Dimensions, Scilit, Semantic Scholar — dalam proses

**Layanan metadata**
Jurnal menyediakan protokol OAI-PMH di tingkat situs:
`https://<domain>/index.php/index/oai?verb=Identify`
Pemanen dapat memfilter per jurnal dengan parameter `set=<journal-path>`, misalnya
`?verb=ListRecords&metadataPrefix=oai_dc&set=jeb-jrdc`. Format metadata mengikuti plugin yang
diaktifkan (umumnya `oai_dc`).

**DOI**
Setiap artikel terdaftar mendapat DOI melalui Crossref. Gunakan DOI resmi saat menyitasi
artikel, bukan URL halaman.

Penerbit tidak menjanjikan penerimaan pada layanan indeksasi tertentu. Status akan diperbarui
pada halaman ini.

### 4.15 About the Publisher

**Path:** `about-the-publisher`
**SEO title:** Tentang Penerbit | Yayasan Ratu Dirgantara Cendekiawan
**Meta description (referensi):** Yayasan Ratu Dirgantara Cendekiawan (JRDC) adalah penerbit
jurnal ilmiah bidang ekonomi dan bisnis.

Yayasan Ratu Dirgantara Cendekiawan (JRDC) berfokus pada penerbitan jurnal ilmiah, khususnya
bidang ekonomi dan bisnis. Melalui kegiatan penerbitan, JRDC mendukung pengembangan pendidikan,
kemajuan ilmu pengetahuan, serta penyebarluasan hasil penelitian dan pemikiran akademik.

JRDC berperan sebagai penerbit yang mendorong terbentuknya ruang publikasi ilmiah bagi
akademisi, peneliti, mahasiswa, dan praktisi untuk berbagi pengetahuan, mengembangkan kajian,
serta memperkuat hubungan antara penelitian dan praktik ekonomi dan bisnis.

**Visi**
Menjadi penerbit jurnal ilmiah yang kredibel dan berorientasi pada pengembangan ilmu pengetahuan
di bidang ekonomi dan bisnis melalui publikasi yang berkualitas, berintegritas, dan bermanfaat
bagi masyarakat akademik maupun praktisi.

**Misi**
Mendukung pengembangan ilmu pengetahuan, menyelenggarakan penerbitan bermutu, mendorong budaya
penelitian dan publikasi, memfasilitasi penyebarluasan hasil penelitian, serta menjunjung etika
publikasi dan keterbukaan akses.

**Kontak**
Yayasan Ratu Dirgantara Cendekiawan (JRDC)
`Jl. ..., Kota ..., Indonesia`
`jurnal@jrdc.ac.id`

### 4.16 Contact and Editorial Office

**Path:** `contact`
**SEO title:** Kontak dan Kantor Redaksi | Jurnal Ekonomi dan Bisnis JRDC
**Meta description (referensi):** Alamat, surel, dan jam layanan kantor redaksi Jurnal Ekonomi
dan Bisnis JRDC.

**Kantor redaksi**
Jurnal Ekonomi dan Bisnis JRDC
Yayasan Ratu Dirgantara Cendekiawan
`Jl. ..., Kota ..., Indonesia`

**Surel:** `jurnal@jrdc.ac.id`
**Telepon/WhatsApp:** `+62 xxx-xxxx-xxxx`
**Jam layanan:** Senin–Jumat, 08.00–16.00 WIB

**Penanggung jawab**
Pemimpin Redaksi: `Nama`
Sekretariat: `Nama`

Untuk pertanyaan tentang proses editorial, status naskah, atau kerja sama, gunakan surel jurnal.
Untuk pelaporan dugaan pelanggaran etika, tulis pada subjek `[Etika]`.

---

## 5. Homepage blocks (tema Individualize)

Tema Individualize menampilkan blok beranda yang dapat diatur pada **Settings → Website →
Appearance → Theme**.

| Blok | Isi |
|---|---|
| Tagline | Riset ekonomi dan bisnis yang terbuka untuk semua. |
| About the Journal with Homepage Menu | Deskripsi pendek (bagian 2.3) + menu: Fokus dan Ruang Lingkup, Pedoman Penulis, Proses Telaah, Etika Publikasi, Biaya. |
| How to Submit | Kirim naskah melalui situs jurnal setelah mendaftar akun. Siapkan berkas `.docx` tanpa identitas penulis, abstrak 150–250 kata, dan daftar pustaka APA 7. Kesamaan teks maksimal 20%. |
| Latest Articles | Aktifkan bila artikel terbit berkelanjutan. |
| Current Issue (Table of Contents) | Aktifkan setelah nomor pertama terbit. |
| Partners / Sponsors | Butuh plugin Partner Logos; isi logo JRDC dan mitra. |
| Highlights | Hanya tersedia pada OJS 3.5; isi 3–4 sorotan (akses terbuka, double-blind, tanpa biaya, DOI). |

---

## 6. Navigasi

Buat menu di **Settings → Website → Setup → Navigation**, lalu tugaskan ke area tema.

**Primary Navigation**

| Label | Tujuan |
|---|---|
| Beranda | `/index.php/<journal-path>` |
| Tentang | `/about` |
| Fokus dan Ruang Lingkup | `/focus-and-scope` |
| Dewan Redaksi | `/about/editorialMasthead` (halaman OJS) |
| Untuk Penulis | `/author-guidelines` |
| Etika Publikasi | `/publication-ethics` |
| Indeksasi | `/indexing-and-abstracting` |
| Kontak | `/contact` |

**Homepage Navigation Area** (blok *About the Journal with Homepage Menu*)

| Label | Tujuan |
|---|---|
| Fokus dan Ruang Lingkup | `/focus-and-scope` |
| Pedoman Penulis | `/author-guidelines` |
| Proses Telaah | `/peer-review-process` |
| Frekuensi Terbit | `/publication-frequency` |
| Biaya | `/author-fees` |
| Etika | `/publication-ethics` |

**User Navigation**

| Label | Tujuan |
|---|---|
| Kirim Naskah | `/submission` |
| Pedoman Penulis | `/author-guidelines` |
| Pedoman Penelaah | `/reviewer-guidelines` |
| Kebijakan Privasi | `/privacy` |

---

## 7. Field bawaan lain

### 7.1 Submission Checklist (`submissionChecklist`)

1. Naskah belum pernah diterbitkan dan tidak sedang dikirim ke jurnal lain.
2. Berkas naskah dalam format `.docx` tanpa nama dan afiliasi penulis (untuk telaah
   double-blind).
3. Abstrak 150–250 kata dalam bahasa Indonesia dan Inggris, disertai 3–5 kata kunci.
4. Daftar pustaka menggunakan APA edisi ke-7 dan hanya memuat sumber yang disitasi.
5. Tabel dan gambar diberi nomor, judul, dan dirujuk dalam teks.
6. Kesamaan teks maksimal 20% dan tidak ada kesamaan tunggal di atas 5%.
7. Pernyataan pendanaan, konflik kepentingan, dan penggunaan AI sudah dicantumkan.
8. Semua penulis menyetujui pengiriman dan pencantuman nama serta urutannya.
9. Penulis memahami bahwa tidak ada biaya publikasi dan artikel terbit dengan lisensi CC BY
   4.0.

### 7.2 Copyright Notice (`copyrightNotice`)

Penulis memegang hak cipta dan memberikan izin publikasi kepada Jurnal Ekonomi dan Bisnis JRDC.
Artikel diterbitkan dengan lisensi Creative Commons Attribution 4.0 (CC BY 4.0), sehingga siapa
pun dapat menggunakan, menyalin, dan mendistribusikan artikel dengan mencantumkan atribusi
kepada penulis dan sumber asli.

### 7.3 Privacy Statement (`privacyStatement`)

Nama dan alamat surel yang dimasukkan pada situs jurnal hanya digunakan untuk keperluan yang
dinyatakan dan tidak akan diberikan kepada pihak lain tanpa izin.

Data yang dikumpulkan meliputi identitas akun, afiliasi, alamat surel, dan berkas naskah.
Data digunakan untuk pengelolaan naskah, komunikasi editorial, penerbitan artikel, dan
pencatatan metadata. Data tidak dijual atau dibagikan untuk tujuan pemasaran.

Penulis dan pembaca dapat meminta pembaruan atau penghapusan data pribadi dengan menghubungi
`jurnal@jrdc.ac.id`. Data editorial tertentu, seperti metadata artikel yang telah terbit,
dipertahankan untuk keperluan pengarsipan dan sitasi. Situs ini menggunakan cookie untuk
menjaga sesi masuk dan menyimpan preferensi bahasa.

### 7.4 Review Guidelines (`reviewGuidelines`)

Telaah dilakukan secara double-blind dalam waktu 4 minggu. Nilai kesesuaian ruang lingkup,
kebaruan, ketepatan metode, kecukupan data, kedalaman pembahasan, dan kepatuhan etika. Berikan
komentar spesifik per bagian dan rekomendasi akhir. Jaga kerahasiaan naskah dan nyatakan konflik
kepentingan.

### 7.5 Open Access Policy (`openAccessPolicy`)

Artikel tersedia bebas tanpa embargo dan tanpa biaya, dengan lisensi CC BY 4.0.

---

## 8. SEO dan teknis OJS

### 8.1 Yang bisa diatur dari OJS

| Item | Lokasi | Catatan |
|---|---|---|
| Meta description global | Journal Settings → Search Description | Berlaku untuk halaman jurnal |
| Judul halaman | `Title` halaman statis / artikel | Jadi H1 |
| Kata kunci jurnal | Journal Settings → Keywords | Tidak lagi dipakai Google, tetap berguna untuk metadata internal |
| Metadata Google Scholar | Plugin Google Scholar (aktif) | Menghasilkan `<meta name="citation_*">` pada artikel |
| DOI | Plugin Crossref | Wajib prefix dan konfigurasi deposit |
| OAI-PMH | `/index.php/index/oai?verb=Identify` | Untuk pemanen metadata, filter dengan `set` |
| Arsip jurnal | Issue archive | Gunakan URL tetap, hindari parameter |
| Gambar/galley | Article galley | Beri nama berkas deskriptif dan teks alternatif |

### 8.2 `robots.txt`

OJS 3.5 tidak membangkitkan `robots.txt`. Letakkan berkas statis di akar docroot
(`ojs-jrdc/robots.txt`), contoh:

```
User-agent: *
Allow: /

Disallow: /index.php/index/login
Disallow: /index.php/index/user
Disallow: /index.php/index/admin
Disallow: /index.php/index/api/
Disallow: /index.php/index/$$$call$$$/
Disallow: /*/workflow
Disallow: /*/submission

Sitemap: https://jeb-jrdc.example.org/sitemap.xml
```

Jangan memblokir `/styles/`, `/js/`, `/plugins/`, atau `/lib/` karena dibutuhkan untuk render.

### 8.3 `sitemap.xml`

Tidak ada plugin sitemap bawaan pada OJS 3.5. Pilihan:

1. Buat sitemap statis berisi URL beranda, halaman statis, arsip nomor, dan artikel, lalu
   perbarui setiap terbit. Maksimal 50.000 URL per berkas.
2. Bangkitkan sitemap dari basis data lewat skrip berkala dan simpan di docroot.

Daftar URL minimum:

- `/index.php/<path>` (beranda)
- `/index.php/<path>/issue/archive`
- `/index.php/<path>/about`
- semua halaman statis di bagian 4
- satu URL per artikel terbit

### 8.4 Canonical dan hreflang

Tidak tersedia otomatis. Bila jurnal hanya satu bahasa, canonical tidak mendesak. Bila
diterbitkan dalam dua bahasa, tambahkan lewat override tema:

```html
<link rel="alternate" hreflang="id" href="https://domain/index.php/path/id/halaman">
<link rel="alternate" hreflang="en" href="https://domain/index.php/path/en/halaman">
<link rel="alternate" hreflang="x-default" href="https://domain/index.php/path/halaman">
```

### 8.5 Judul dan deskripsi halaman

Pola judul (≤60 karakter, unik):

```
<Nama Halaman> | Jurnal Ekonomi dan Bisnis JRDC
```

Contoh:

- `Fokus dan Ruang Lingkup | Jurnal Ekonomi dan Bisnis JRDC`
- `Pedoman Penulis | Jurnal Ekonomi dan Bisnis JRDC`

Panjang nama jurnal membuat judul beberapa halaman melewati 60 karakter. Bila perlu, gunakan
singkatan pada judul halaman kebijakan: `| JEB-JRDC`.

### 8.6 Aksesibilitas dan performa

- Kontras teks minimal 4,5:1 pada tema; gunakan mode warna sederhana Individualize.
- Semua gambar unggahan diberi teks alternatif.
- Aset tema dibangun dengan `npm run build` (sudah dijalankan) agar `styles/build.css` dan
  `js/build.js` tersedia.
- Aktifkan cache OJS setelah uji: `cache` pada `config.inc.php`, dan `template_cache`.
- Uji Core Web Vitals pada artikel dengan galley PDF terbesar.

---

## 9. Checklist sebelum publish

- [ ] Semua placeholder pada bagian 1 sudah diganti.
- [ ] Description, Search Description, Keywords, ISSN terisi.
- [ ] Halaman `about` sudah diisi dan memuat visi, misi, serta alamat penerbit.
- [ ] 16 halaman statis dibuat dengan path yang sama seperti tabel bagian 4.
- [ ] Menu primary dan homepage menunjuk ke path yang benar (tidak ada tautan 404).
- [ ] Review mode double-blind dan `reviewGuidelines` aktif.
- [ ] Submission checklist dan copyright notice terisi.
- [ ] Lisensi CC BY 4.0 tampil pada halaman artikel.
- [ ] Plugin Google Scholar dan Crossref aktif; DOI tersimpan pada artikel uji.
- [ ] `robots.txt` ada dan tidak memblokir aset.
- [ ] OAI-PMH merespons `?verb=Identify`.
- [ ] Halaman uji lolos Lighthouse SEO tanpa error struktur judul.
- [ ] Meta description tidak duplikat di semua halaman (perlu override tema bila ingin unik).

---

## 10. Rujukan

- PKP, *Learning OJS 3.5* — https://docs.pkp.sfu.ca/learning-ojs/3.5/en/
- PKP, *OJS Administrator Guide* — https://docs.pkp.sfu.ca/admin-guide/3.5/en/
- PKP Preservation Network — https://www.pkp.sfu.ca/pkp-pn
- COPE, *Core Practices* — https://publicationethics.org/core-practices
- Creative Commons, *CC BY 4.0* — https://creativecommons.org/licenses/by/4.0/
- APA, *Publication Manual*, edisi ke-7
- Google Search Central, *Title links* dan *Snippets* —
  https://developers.google.com/search/docs/appearance
- DOAJ, *Guide to Applying* — https://doaj.org/apply/guide/
- Garuda — https://garuda.kemdikbud.go.id/
