---
name: ojs-development
description: Panduan praktis pengembangan, kustomisasi, deployment, konfigurasi, dan pemeliharaan Open Journal Systems (OJS), terutama OJS 3.3 dan 3.4 serta penanganan instalasi legacy OJS 2.x.
---

# Skill Pengembangan Open Journal Systems (OJS)

Gunakan panduan ini saat mengerjakan instalasi, konfigurasi, pengembangan plugin, tema, template, modifikasi, integrasi, upgrade, troubleshooting, atau maintenance OJS. Prioritasnya adalah perubahan sekecil mungkin yang aman, sesuai versi, mudah dirawat, dan mengikuti mekanisme resmi PKP.

## 1. Kapan skill ini digunakan

Aktifkan skill ketika tugas menyentuh salah satu hal berikut:

- Instalasi baru, migrasi, upgrade, konfigurasi `config.inc.php`, PHP, database, web server, cron, atau permission.
- Pengembangan atau perbaikan plugin (generic, block, theme, import/export, report, dan kategori lain).
- Kustomisasi tampilan, child theme, Smarty template, LESS/CSS, JavaScript, locale, atau asset.
- Perubahan alur editorial, metadata, formulir, DOI, OAI, email, statistik, pencarian, atau integrasi eksternal.
- Audit keamanan, backup/restore, log, cache, performa, dan pemeliharaan instalasi.

## 2. Prinsip kerja inti

1. **Sederhana dulu.** Pahami kebutuhan minimum dan pilih solusi paling kecil yang menyelesaikannya. Jangan membuat framework, service layer, abstraksi, dependency, atau proses deployment baru tanpa kebutuhan nyata.
2. **Gunakan fitur bawaan OJS terlebih dahulu.** Periksa pengaturan jurnal/situs, plugin bawaan, Plugin Gallery, tema yang tersedia, konfigurasi email, workflow, dan REST API sebelum menulis kode.
3. **Jangan modifikasi core.** Hindari mengubah file di `classes/`, `lib/pkp/`, `pages/`, `templates/`, atau file inti lain. Implementasikan kebutuhan melalui plugin, child theme, hook, konfigurasi, atau API yang disediakan OJS.
4. **Cocokkan versi secara tepat.** Pastikan versi *dan build/patch* OJS, bukan hanya “OJS 3”. Periksa cabang plugin/tema, `version.xml`, catatan rilis, `README` dan `UPGRADE` pada paket OJS yang benar.
5. **Jangan menganggap 3.3, 3.4, dan 3.5 kompatibel.** Dokumentasi PKP yang saat ini tampil sebagai versi 3.5 dapat membantu memahami konsep, tetapi contoh kode dan persyaratan harus diverifikasi terhadap cabang 3.3 atau 3.4.
6. **Perubahan harus dapat dipulihkan.** Simpan perubahan dalam Git, buat backup sebelum perubahan database/deployment, dan jelaskan file yang diubah serta cara menguji atau membatalkannya.
7. **Jangan menebak API atau hook.** Cari nama hook, signature callback, class induk, dan contoh yang benar pada source code OJS/PKP untuk versi target sebelum menggunakannya.

## 3. Identifikasi versi dan kondisi proyek

Sebelum mengubah kode atau server:

- Identifikasi versi lengkap OJS melalui panel **Administration → System Information**, metadata rilis pada source, dan/atau database version record. Catat juga build/patch.
- Periksa branch atau tag source: gunakan `stable-3_3_0` untuk OJS 3.3.x dan `stable-3_4_0` untuk OJS 3.4.x bila tersedia. Hindari branch `main` untuk produksi kecuali memang sedang menguji pengembangan berikutnya.
- Periksa versi PHP, ekstensi PHP, database, web server, dan konfigurasi CLI PHP. Bandingkan dengan `README`/persyaratan paket OJS yang persis sama; jangan memakai persyaratan dari dokumentasi versi terbaru untuk instalasi lama.
- Tinjau status Git, plugin aktif, theme aktif, konfigurasi khusus, `files_dir`, dan custom code yang sudah ada sebelum melakukan perubahan.
- Saat membaca `config.inc.php`, jangan menyalin, menampilkan, atau menyimpan password database, API key, `salt`, `api_secret_key`, atau rahasia lain ke log, commit, prompt, maupun dokumentasi.

**Dukungan versi:** periksa [kebijakan keamanan OJS](https://github.com/pkp/ojs/blob/main/SECURITY.md) sebelum menyarankan upgrade/ekspos publik. OJS 2.x sudah berstatus tidak didukung dalam kebijakan PKP yang dirujuk; status dan masa dukungan 3.3/3.4 dapat berubah. Jangan menjanjikan patch keamanan untuk cabang yang sudah mencapai EOL.

## 4. Peta direktori penting

Nama dan isi dapat sedikit berbeda antar-rilis. Gunakan ini sebagai orientasi, bukan asumsi bahwa semua direktori wajib ada.

| Lokasi | Fungsi | Panduan |
|---|---|---|
| `config.inc.php` | Konfigurasi instalasi: database, URL, locale, email, cache, file, security, dan lainnya. | Rahasiakan kredensial; bandingkan dengan `config.TEMPLATE.inc.php` dari rilis yang sama. |
| `classes/` | Kode aplikasi OJS khusus aplikasi. | Baca untuk memahami API; jangan edit sebagai jalur kustomisasi normal. |
| `lib/pkp/` | Library bersama PKP yang dipakai OJS/OMP/OPS. | Hindari perubahan langsung. |
| `pages/`, `controllers/` | Handler halaman dan controller aplikasi. | Periksa sebelum memilih hook/API; jangan menimpa file inti. |
| `templates/` | Template Smarty aplikasi. | Temukan template asal; override melalui theme/plugin jika dibutuhkan. |
| `plugins/` | Plugin yang disertakan/ditambahkan. | Simpan custom plugin di kategori dan direktori plugin yang tepat. |
| `locale/` | File bahasa dan pesan aplikasi. | Gunakan locale/plugin sendiri untuk pesan tambahan; hindari mengubah locale core. |
| `dbscripts/xml/` | Descriptor instalasi dan upgrade database aplikasi. | Jangan ubah untuk fitur jurnal; perubahan skema plugin harus dimiliki plugin. |
| `tools/` | Utilitas CLI, termasuk upgrade dan scheduled tasks. | Jalankan dari root instalasi, dengan PHP CLI yang sesuai. |
| `public/` | File publik yang memang dapat diakses web, seperti gambar/asset. | Jangan simpan file submission privat di sini; batasi eksekusi script di server. |
| `cache/` | Cache template/data dan file sementara. | Dapat dibersihkan sesuai panduan OJS, bukan dihapus sembarangan saat proses berjalan. |
| `files_dir` (lokasi dari konfigurasi) | File submission dan dokumen privat jurnal. | **Wajib di luar web root** dan hanya dapat diakses oleh user proses aplikasi. |

Kategori plugin yang umum antara lain `generic`, `blocks`, `themes`, `importexport`, `reports`, `pubIds`, `metadata`, `gateways`, dan `paymethod`. Daftar kategori dapat berbeda menurut versi/aplikasi. Periksa kategori yang benar pada source OJS target.

## 5. Memilih mekanisme kustomisasi

Pilih mekanisme terkecil yang sesuai:

- **Pengaturan OJS** untuk konfigurasi yang sudah disediakan antarmuka.
- **Plugin bawaan/Plugin Gallery** untuk fungsi yang sudah tersedia dan kompatibel.
- **Theme plugin atau child theme** untuk tampilan, stylesheet, asset, dan override template frontend.
- **Block plugin** untuk komponen sidebar yang dapat diaktifkan dan ditempatkan dari pengaturan Appearance.
- **Generic plugin** untuk integrasi, hook, halaman/handler tambahan, field/form tambahan, atau perilaku aplikasi yang tidak cocok dengan kategori lebih khusus.
- **Kategori plugin khusus** seperti `importexport`, `reports`, atau `pubIds` bila fungsi yang dibuat memang sesuai dengan tanggung jawab kategori itu.
- **Modifikasi core** hanya sebagai patch sementara yang sangat terpaksa, terdokumentasi, dapat diterapkan ulang, dan disertai rencana menghilangkannya. Jangan memilihnya sebagai solusi default.

Plugin Gallery PKP tidak mencakup semua plugin di internet. Untuk plugin eksternal, verifikasi pemelihara, repository, release/tag, lisensi, riwayat perubahan, isu keamanan, dan kompatibilitas versi. Arsip `.tar.gz` yang diunggah harus memiliki satu folder teratas dengan nama plugin yang benar. Setelah instalasi, plugin biasanya masih harus diaktifkan secara terpisah.

## 6. Alur kerja pengembangan plugin

Ikuti alur ringkas ini:

1. **Pastikan kebutuhan.** Periksa plugin yang ada, hook atau API yang tersedia, dan apakah perubahan dapat dilakukan melalui konfigurasi atau theme.
2. **Ambil template yang sesuai.** Mulai dari [PKP pluginTemplate](https://github.com/pkp/pluginTemplate), lalu pilih branch yang sesuai (`stable-3_3_0` atau `stable-3_4_0`). Jangan mengasumsikan `main` cocok untuk instalasi stabil.
3. **Gunakan struktur plugin lokal.** Bentuk umum plugin OJS 3 mencakup folder di `plugins/<kategori>/<namaPlugin>/`, kelas plugin, `index.php`, `version.xml`, dan seperlunya folder `classes/`, `controllers/`, `templates/`, `locale/`, `styles/`, `js/`, atau `tests/`. Ikuti struktur contoh pada branch yang dipilih; tidak semua file wajib ada.
4. **Ikuti API versi target.** OJS 3.3 masih banyak menggunakan class global dan pola `import()`/nama file `.inc.php` pada kode lama. OJS 3.4 memperkenalkan penggunaan namespace dan autoloading yang lebih luas; pola class, `use`, path file, dan theme/plugin dari 3.3 tidak boleh disalin mentah ke 3.4. Bandingkan implementasi branch resmi.
5. **Registrasikan hook secara benar.** Panggil implementasi `parent::register(...)` dan daftarkan hook hanya sesuai lifecycle plugin. API `Hook::add` merupakan bentuk yang diprioritaskan pada codebase lebih baru; `HookRegistry::register` ditemukan pada pola lama dan memiliki alias kompatibilitas. Gunakan bentuk serta signature yang dipakai source versi target. Pastikan callback memeriksa status aktif bila diperlukan.
6. **Gunakan API OJS/PKP.** Manfaatkan request/context, repository/DAO, form, settings, template manager, dan helper file yang disediakan. Hindari query langsung ke tabel inti. Jika tabel milik plugin memang diperlukan, gunakan prefix/nama tabel sendiri, query terparameterisasi, dan upgrade script yang dapat dijalankan berulang dengan aman.
7. **Pisahkan tampilan dan logika.** Simpan markup di `templates/`, pesan di `locale/`, serta CSS/JS di asset plugin. Gunakan `getTemplateResource()` untuk template plugin. Escape output sesuai konteks; jangan mencetak input pengguna langsung ke HTML/JavaScript.
8. **Jaga versi plugin.** Perbarui `version.xml`, nomor rilis, tanggal, class dan metadata kompatibilitas sesuai dokumentasi PKP. Untuk perubahan skema, sediakan jalur install/upgrade plugin yang eksplisit; jangan mengandalkan perubahan database manual.
9. **Uji sebelum rilis.** Uji instalasi, aktivasi, pengaturan, operasi normal, deaktivasi, upgrade dari versi plugin sebelumnya, dan log PHP/OJS. Uji di staging dengan build OJS dan PHP yang sama dengan produksi.
10. **Kemas dengan benar.** Arsip rilis harus berisi folder plugin pada tingkat teratas, bukan file plugin yang tersebar langsung di root arsip. Sertakan README singkat, lisensi, versi kompatibel, cara instalasi, serta batasan yang diketahui.

### Catatan plugin generik, block, dan theme

- **Generic:** cocok untuk fungsi lintas halaman, integrasi layanan, penambahan field, atau perilaku yang disisipkan lewat hook. Hindari menjadikannya tempat bagi semua fitur jika tersedia kategori khusus.
- **Block:** gunakan base class block plugin dan template block miliknya. Tampilan/posisi sidebar tetap bergantung pada theme dan konfigurasi sidebar; block tidak otomatis muncul pada theme yang tidak menyediakan sidebar.
- **Theme:** theme adalah plugin pada kategori `themes`. Gunakan theme bawaan sebagai parent bila sesuai, buat child theme terpisah, dan aktifkan plugin theme sebelum memilihnya pada pengaturan Appearance jurnal.
- **Hook dan override template:** temukan nama hook dan template pada source rilis yang sedang dipakai. Override hanya template yang perlu, dengan path relatif yang sama seperti template asal. Perlu diingat, override dapat menutupi perbaikan template dari upgrade OJS.

## 7. Pengembangan theme dan template

1. Mulai dari **Website → Appearance**: logo, warna, font, navigasi, sidebar, dan opsi theme bawaan sering cukup tanpa kode.
2. Bila perlu perubahan kode, gunakan child theme/plugin theme baru; jangan edit theme bawaan atau `templates/` core. Lihat [PKP Theming Guide](https://docs.pkp.sfu.ca/pkp-theming-guide/en/) dan contoh [defaultChild](https://github.com/NateWr/defaultChild).
3. Parent theme yang tepat ditentukan oleh `setParent()`/mekanisme versi theme. Periksa contoh child theme untuk branch OJS 3.3 atau 3.4.
4. Override template hanya jika styling atau konfigurasi theme tidak cukup. Pertahankan path template asal dan salin hanya template yang memang harus diubah; tinjau ulang override saat upgrade.
5. Gunakan mekanisme theme untuk mendaftarkan LESS/CSS dan JavaScript, hindari inline script/stylesheet yang tidak perlu, serta jaga aksesibilitas, responsive layout, kontras, dan keyboard navigation.
6. Setelah perubahan, bersihkan **template cache** melalui panel administrasi atau mekanisme resmi bila hasil belum terlihat. Jangan menghapus `files_dir` atau data jurnal saat membersihkan cache.

## 8. Konfigurasi server, keamanan, dan deployment

- **Persyaratan runtime:** ambil requirement PHP, ekstensi, database, dan web server dari `README`/dokumen instalasi rilis OJS yang tepat. Periksa PHP CLI dan PHP-FPM/Apache; versinya dapat berbeda.
- **Web root:** arahkan document root ke direktori aplikasi sebagaimana ditentukan konfigurasi server, tetapi letakkan `files_dir` sepenuhnya di luar lokasi yang dapat diakses melalui HTTP. Ini melindungi file submission privat.
- **Izin file:** berikan hak tulis hanya pada direktori yang memang perlu (umumnya `cache/`, `public/`, dan `files_dir`, sesuai versi dan instalasi). Hindari `chmod -R 777`; jangan membuat seluruh codebase writable oleh proses web.
- **Eksekusi script:** konfigurasi web server agar file upload/cache tidak dapat mengeksekusi PHP atau script lain. Sesuaikan dengan Apache/Nginx dan struktur hosting; jangan asal menyalin aturan `.htaccess` antar-server.
- **HTTPS:** pasang sertifikat TLS dan paksa HTTPS melalui konfigurasi yang benar. Jika memakai reverse proxy, atur trusted proxy/header forwarding hanya bila proxy berada di bawah kendali Anda.
- **`config.inc.php`:** gunakan `salt` dan `api_secret_key` acak yang unik per instalasi; lindungi file konfigurasi dan jangan commit kredensial. Pada OJS 3.4, opsi `allowed_hosts` ditambahkan untuk mitigasi Host-header injection dan direkomendasikan untuk dikonfigurasi sesuai hostname yang valid.
- **Akun dan database:** gunakan password admin yang kuat dan unik, akun database khusus dengan hak secukupnya untuk operasi yang diperlukan OJS, dan jangan berbagi database OJS dengan aplikasi lain. Batasi akses administratif dan akses server.
- **Upload:** pertahankan validasi tipe/ukuran file OJS, batasi akses direktori publik, dan perlakukan lampiran yang tidak dikenal sebagai file berisiko. Jangan menganggap plugin pembatas upload menggantikan konfigurasi server yang aman.
- **Production mode:** jangan tampilkan error/debug ke pengunjung. Simpan log di lokasi yang tidak dapat diakses publik, pantau error PHP/OJS, penggunaan disk, email queue, dan failed jobs.
- **Backup:** backup **database, `files_dir`, `public/`, `config.inc.php`, serta catatan versi/source dan plugin kustom**. Simpan salinan terpisah dari server produksi dan uji restore secara berkala. Backup hanya source code atau hanya database tidak cukup. PKP PN bukan pengganti backup instalasi.
- **Scheduled tasks:** untuk cabang OJS 3.3/3.4, periksa `scheduled_tasks` dan definisi task, lalu jadwalkan `php tools/runScheduledTasks.php` melalui cron/Task Scheduler sesuai dokumentasi rilis. Jalankan dengan user sistem yang benar dan periksa log. Jangan memakai perintah scheduler dari cabang OJS yang lebih baru tanpa memastikan kompatibilitas.

## 9. Upgrade dan maintenance

### Upgrade rutin OJS 3.x

1. Periksa release notes, `README`, `UPGRADE`, requirement runtime, plugin compatibility, dan breaking changes untuk versi tujuan.
2. Buat staging clone dari database dan file produksi. Jalankan upgrade di staging terlebih dahulu dan uji login, submission, review/editorial workflow, publikasi, download file, DOI/OAI, email, scheduled tasks, theme, dan plugin.
3. Pada jadwal maintenance, batasi aktivitas penulisan, buat backup lengkap terbaru, dan catat versi serta plugin aktif.
4. Deploy source release bersih yang sesuai. Jangan menimpa rilis baru dengan seluruh folder source lama; pindahkan hanya konfigurasi, data, plugin kustom, dan asset yang memang perlu setelah ditinjau. Jangan membawa file/folder asing atau file yang tidak berasal dari paket OJS.
5. Jalankan prosedur upgrade database resmi dari root instalasi, umumnya melalui `php tools/upgrade.php upgrade` pada OJS 3.3/3.4, dengan mengikuti instruksi `UPGRADE` untuk rilis tersebut. Jangan menjalankan perintah ini pada produksi tanpa backup dan persetujuan operasional.
6. Verifikasi versi di panel administrasi, log, permission, plugin/theme, tautan, file lama, email dan jadwal task. Bersihkan cache jika diperlukan.

### Migrasi OJS 2.x ke 3.x

Perlakukan sebagai **migrasi besar**, bukan upgrade patch biasa. OJS 2.x memiliki struktur data, format file, template dan API plugin yang berbeda. Buat salinan sandbox lengkap database + files, audit plugin/theme dan custom code, uji migrasi dari versi sumber yang didukung, lalu validasi data dan file secara menyeluruh. Plugin OJS 2.x tidak otomatis kompatibel dengan OJS 3.x dan biasanya perlu ditulis ulang/adaptasi. Jangan menghapus instalasi lama sebelum hasil migrasi diterima dan backup restore terbukti.

### Troubleshooting dasar

- Mulai dari versi/build, log web/PHP, log OJS, status plugin, dan konfigurasi yang relevan; hindari menebak dari pesan error singkat.
- Setelah perubahan template/theme, bersihkan template cache. Setelah perubahan locale/config, bersihkan cache terkait melalui fasilitas resmi.
- Jika plugin gagal aktif, periksa PHP error log, namespace/class/file naming, `version.xml`, hak baca file, kompatibilitas branch dan urutan aktivasi; jangan mengedit database untuk memaksa plugin aktif.
- Jika submission file tidak terbuka, periksa path absolut `files_dir`, kepemilikan/permission, dan relasi file; jangan mengubah `files_dir` menjadi subfolder di web root.
- Jika scheduled tasks/email tidak berjalan, periksa konfigurasi email, cron, PHP CLI, user eksekusi, task XML/definisi task, dan log eksekusi.

## 10. Anti-pola yang harus dihindari

- Mengedit langsung `lib/pkp/`, `classes/`, template core, atau theme bawaan untuk perubahan yang seharusnya menjadi plugin/child theme.
- Menginstal plugin hanya karena “berhasil diupload”, tanpa memeriksa versi, sumber, pemelihara, dan kompatibilitasnya.
- Menggunakan contoh dari OJS 3.5/branch `main` pada OJS 3.3/3.4 tanpa adaptasi.
- Mem-port plugin OJS 2.x ke OJS 3.x dengan sekadar mengganti nama file atau namespace.
- Menulis SQL terhadap tabel inti, mengganti struktur database secara manual, atau mengubah data produksi tanpa migrasi dan backup.
- Menaruh `files_dir` di `public_html`, `htdocs`, atau web root; mengatur permission `777`; atau membiarkan script dapat dieksekusi dari direktori upload/cache.
- Menyalin semua template core ke theme/plugin sehingga upgrade berikutnya sulit diikuti.
- Menambah dependency, framework, endpoint, queue worker, atau lapisan abstraksi yang tidak diminta dan tidak diperlukan.
- Menghapus cache, plugin, file, atau folder secara rekursif tanpa memastikan path dan dampaknya.
- Menjalankan upgrade, migrasi database, atau perintah destruktif di produksi tanpa backup, staging, dan otorisasi.
- Menganggap proses backup selesai tanpa uji pemulihan.

## 11. Checklist sebelum menyatakan pekerjaan selesai

- [ ] Versi OJS/build dan kompatibilitas PHP/database telah dipastikan.
- [ ] Solusi menggunakan konfigurasi/fitur/plugin/theme bawaan bila memadai.
- [ ] Tidak ada modifikasi core yang tidak terhindarkan.
- [ ] Perubahan kode terlokalisasi, terdokumentasi, dan tersimpan dalam Git.
- [ ] Tidak ada secret, kredensial, atau data produksi sensitif di source/log.
- [ ] `files_dir` berada di luar web root dan permission tidak terlalu longgar.
- [ ] Plugin/theme diuji pada versi OJS yang tepat; template dan locale telah diperiksa.
- [ ] Backup dan prosedur restore tersedia sebelum perubahan operasional.
- [ ] Log, scheduled tasks, email, workflow jurnal, serta file artikel diuji sesuai ruang lingkup tugas.
- [ ] Ringkasan perubahan, hasil pengujian, batasan versi, dan langkah deployment/rollback disampaikan.

## 12. Referensi utama

Utamakan sumber berikut. Untuk contoh kode, selalu pilih branch/tag yang sesuai dengan versi OJS proyek.

### OpenCode

- [OpenCode Agent Skills](https://opencode.ai/docs/skills) — lokasi skill, frontmatter, dan discovery.

### Dokumentasi resmi PKP/OJS

- [PKP Documentation Hub](https://docs.pkp.sfu.ca/) — pintu masuk dokumentasi resmi.
- [PKP Plugin Guide and Inventory](https://docs.pkp.sfu.ca/plugin-inventory/en/) — Plugin Gallery, instalasi, aktivasi, dan plugin yang tersedia.
- [PKP Developer Plugin Guide](https://docs.pkp.sfu.ca/dev/plugin-guide/en/) — API plugin dan template. Dokumentasi yang tampil saat ini dapat mengikuti versi lebih baru; cocokkan contoh dengan source branch 3.3/3.4.
- [PKP Theming Guide](https://docs.pkp.sfu.ca/pkp-theming-guide/en/) — theme, child theme, template, dan asset.
- [PKP Admin Guide](https://docs.pkp.sfu.ca/admin-guide/en/) — instalasi, konfigurasi dan operasional server; persyaratan versi lama tetap harus diperiksa pada paket rilisnya.
- [PKP Security Guide](https://docs.pkp.sfu.ca/admin-guide/en/securing-your-system/) — TLS, permission, `files_dir`, backup, dan pengamanan server.
- [OJS 3.4.0 Release Notes](https://github.com/pkp/ojs/blob/main/docs/release-notes/README-3.4.0) — perubahan konfigurasi, locale, class autoloading, hooks, dan kompatibilitas.
- [OJS configuration template](https://github.com/pkp/ojs/blob/main/config.TEMPLATE.inc.php) — dokumentasi parameter `config.inc.php`; gunakan template dari branch rilis proyek bila memerlukan detail 3.3/3.4.
- [PKP pluginTemplate](https://github.com/pkp/pluginTemplate) — template plugin resmi dengan branch stabil untuk OJS 3.3 dan 3.4.
- [PKP Classic Theme](https://github.com/pkp/classic) — contoh theme resmi, struktur aset, build, dan aktivasi.
- [PKP OJS Security Policy](https://github.com/pkp/ojs/blob/main/SECURITY.md) — status dukungan dan kebijakan keamanan versi.
- [OJS 2.x Technical Reference](https://docs.pkp.sfu.ca/ojs-2-technical-reference/en/) dan [Learning OJS 2](https://docs.pkp.sfu.ca/learning-ojs-2/en/) — referensi legacy.
- [OJS 2.x → 3.x Upgrade Guide](https://docs.pkp.sfu.ca/upgrading-ojs-2-to-3/en/) — perencanaan migrasi dan sandbox upgrade.

### Komunitas dan contoh implementasi

- [PKP Community Forum](https://forum.pkp.sfu.ca/) — troubleshooting dan klarifikasi maintainer PKP. Prioritaskan jawaban staf PKP dan jawaban yang konsisten dengan source resmi.
- [PKP Forum: theme customization dan child theme](https://forum.pkp.sfu.ca/t/ojs-3-need-help-with-theme-customization/21210) — pola override melalui child theme, bukan mengubah theme bawaan.
- [PKP Forum: keamanan instalasi plugin](https://forum.pkp.sfu.ca/t/plugin-installation-security-issues/73383) — permission, `files_dir`, dan pembatasan eksekusi script.
- [PKP Forum: `files_dir` dan risiko web root](https://forum.pkp.sfu.ca/t/cannot-view-my-dashboard-after-migration/89192/4) — klarifikasi tim PKP tentang penyimpanan file privat.
- [Contoh child theme OJS 3](https://github.com/NateWr/defaultChild) — contoh struktur child theme dan penambahan stylesheet/script.

---

**Aturan terakhir untuk agen:** bila dokumentasi umum dan kode aktual versi target berbeda, ikuti source code, release notes, serta dokumentasi yang disertakan pada paket OJS target. Jika masih belum pasti, jelaskan ketidakpastian dan jangan mengubah core atau database dengan asumsi.
