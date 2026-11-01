UPDATE static_page_settings SET setting_value='About the Journal' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='about') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>About the Journal</h2>
<p><strong>Journal of Economics and Business Research</strong> (JRDC) is a peer-reviewed, open-access scholarly journal published by Yayasan Ratu Dirgantara Cendikiawan (JRDC). The journal publishes original research, reviews, and short communications in Economics and Business, including management, accounting, finance, marketing, entrepreneurship, and development economics.</p>
<p>JRDC is committed to advancing knowledge, supporting education, and disseminating research and academic thought by providing a credible publication space for academics, researchers, students, and practitioners. All articles are published under a Creative Commons Attribution 4.0 International (CC BY 4.0) license and are freely available online.</p>
<h3>Publisher</h3>
<p>Yayasan Ratu Dirgantara Cendikiawan (JRDC)<br/>Indonesia</p>
<h3>Contact</h3>
<p>Editorial Office: <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a></p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='about') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Tentang Jurnal' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='about') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Tentang Jurnal</h2>
<p><strong>Journal of Economics and Business Research</strong> (JRDC) adalah jurnal ilmiah dengan telaah sejawat (peer-reviewed) dan akses terbuka (open access) yang diterbitkan oleh Yayasan Ratu Dirgantara Cendikiawan (JRDC). Jurnal ini menerbitkan penelitian orisinal, ulasan, dan komunikasi singkat di bidang Ekonomi dan Bisnis, termasuk manajemen, akuntansi, keuangan, pemasaran, kewirausahaan, dan ekonomi pembangunan.</p>
<p>JRDC berkomitmen mendukung pengembangan pendidikan, kemajuan ilmu pengetahuan, dan penyebarluasan hasil penelitian serta pemikiran akademik dengan menyediakan ruang publikasi yang kredibel bagi akademisi, peneliti, mahasiswa, dan praktisi. Seluruh artikel diterbitkan dengan lisensi Creative Commons Attribution 4.0 International (CC BY 4.0) dan tersedia bebas secara daring.</p>
<h3>Penerbit</h3>
<p>Yayasan Ratu Dirgantara Cendikiawan (JRDC)<br/>Indonesia</p>
<h3>Kontak</h3>
<p>Kantor Redaksi: <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a></p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='about') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Focus and Scope' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='focus-and-scope') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Focus and Scope</h2>
<p>The initial publishing focus of JRDC is Economics and Business. The scope covers, but is not limited to:</p>
<ul>
<li>Management (strategy, human resources, operations, organizational behavior)</li>
<li>Accounting (financial, managerial, auditing, taxation)</li>
<li>Finance (corporate finance, Islamic finance, banking, investment, fintech)</li>
<li>Marketing (consumer behavior, digital marketing, branding)</li>
<li>Entrepreneurship and SMEs</li>
<li>Development economics and public policy</li>
<li>Digital economy and business transformation</li>
</ul>
<p>Studies may include theory building, empirical research (quantitative/qualitative/mixed), policy analysis, case studies, and the application of economic and business concepts in various contexts. The scope may expand gradually according to scholarly needs while maintaining Economics and Business as the core orientation.</p>
<h3>Article Types</h3>
<ul>
<li>Original research articles (5,000-8,000 words)</li>
<li>Review articles / systematic reviews (up to 10,000 words)</li>
<li>Short communications (up to 3,000 words)</li>
<li>Case studies and policy briefs</li>
</ul>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='focus-and-scope') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Fokus dan Ruang Lingkup' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='focus-and-scope') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Fokus dan Ruang Lingkup</h2>
<p>Fokus awal penerbitan jurnal JRDC adalah bidang Ekonomi dan Bisnis. Ruang lingkup kajian mencakup, namun tidak terbatas pada:</p>
<ul>
<li>Manajemen (strategi, sumber daya manusia, operasi, perilaku organisasi)</li>
<li>Akuntansi (keuangan, manajerial, audit, perpajakan)</li>
<li>Keuangan (keuangan perusahaan, keuangan syariah, perbankan, investasi, fintech)</li>
<li>Pemasaran (perilaku konsumen, pemasaran digital, branding)</li>
<li>Kewirausahaan dan UMKM</li>
<li>Ekonomi pembangunan dan kebijakan publik</li>
<li>Ekonomi digital dan transformasi bisnis</li>
</ul>
<p>Kajian dapat berupa pengembangan teori, penelitian empiris (kuantitatif/kualitatif/campuran), analisis kebijakan, studi kasus, serta penerapan konsep ekonomi dan bisnis dalam berbagai konteks. Pengembangan ruang lingkup diarahkan secara bertahap sesuai kebutuhan keilmuan, dengan tetap mempertahankan orientasi utama pada bidang Ekonomi dan Bisnis.</p>
<h3>Jenis Artikel</h3>
<ul>
<li>Artikel penelitian orisinal (5.000-8.000 kata)</li>
<li>Artikel ulasan / systematic review (hingga 10.000 kata)</li>
<li>Komunikasi singkat (hingga 3.000 kata)</li>
<li>Studi kasus dan policy brief</li>
</ul>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='focus-and-scope') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Author Guidelines' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='author-guidelines') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Author Guidelines</h2>
<h3>1. General</h3>
<p>Manuscripts must be original, not under review elsewhere, and not previously published. Authors are responsible for the accuracy of all content and must obtain permission for any third-party material.</p>
<h3>2. Manuscript Format</h3>
<ul>
<li>File format: Microsoft Word (.docx) or OpenDocument (.odt).</li>
<li>Font: Times New Roman, 12 pt, 1.5 line spacing.</li>
<li>Margins: 2.5 cm on all sides.</li>
<li>Length: 5,000-8,000 words including references, tables, and figures.</li>
<li>Language: English or Indonesian (consistent throughout).</li>
</ul>
<h3>3. Structure</h3>
<ol>
<li>Title (concise, informative)</li>
<li>Author names, affiliations, and ORCID (if available)</li>
<li>Abstract (150-250 words)</li>
<li>Keywords (3-6)</li>
<li>Introduction</li>
<li>Literature Review / Theoretical Framework</li>
<li>Methodology</li>
<li>Results and Discussion</li>
<li>Conclusion</li>
<li>Acknowledgements (optional)</li>
<li>References (APA 7th edition)</li>
</ol>
<h3>4. References</h3>
<p>Follow APA 7th edition. Include DOI where available. References must be complete and verifiable.</p>
<h3>5. Figures and Tables</h3>
<p>Numbered consecutively, with titles above tables and captions below figures. Submit as editable objects, not images.</p>
<h3>6. Submission</h3>
<p>Submit via the online submission system. Include a cover letter and suggested reviewers (optional).</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='author-guidelines') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Panduan Penulis' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='author-guidelines') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Panduan Penulis</h2>
<h3>1. Umum</h3>
<p>Naskah harus orisinal, tidak sedang ditelaah di jurnal lain, dan belum pernah diterbitkan. Penulis bertanggung jawab atas keakuratan seluruh isi dan harus memperoleh izin untuk materi pihak ketiga.</p>
<h3>2. Format Naskah</h3>
<ul>
<li>Format file: Microsoft Word (.docx) atau OpenDocument (.odt).</li>
<li>Font: Times New Roman, 12 pt, spasi 1,5.</li>
<li>Margin: 2,5 cm semua sisi.</li>
<li>Panjang: 5.000-8.000 kata termasuk referensi, tabel, dan gambar.</li>
<li>Bahasa: Inggris atau Indonesia (konsisten).</li>
</ul>
<h3>3. Struktur</h3>
<ol>
<li>Judul (ringkas, informatif)</li>
<li>Nama penulis, afiliasi, dan ORCID (jika ada)</li>
<li>Abstrak (150-250 kata)</li>
<li>Kata kunci (3-6)</li>
<li>Pendahuluan</li>
<li>Tinjauan Literatur / Kerangka Teori</li>
<li>Metodologi</li>
<li>Hasil dan Pembahasan</li>
<li>Kesimpulan</li>
<li>Ucapan terima kasih (opsional)</li>
<li>Referensi (APA edisi ke-7)</li>
</ol>
<h3>4. Referensi</h3>
<p>Mengikuti APA edisi ke-7. Sertakan DOI jika tersedia. Referensi harus lengkap dan dapat diverifikasi.</p>
<h3>5. Gambar dan Tabel</h3>
<p>Dinomori berurutan, judul di atas tabel dan keterangan di bawah gambar. Kirim sebagai objek yang dapat diedit, bukan gambar.</p>
<h3>6. Penyerahan</h3>
<p>Serahkan melalui sistem penyerahan daring. Sertakan surat pengantar dan saran reviewer (opsional).</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='author-guidelines') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Submission Preparation Checklist' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='submission-preparation') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Submission Preparation Checklist</h2>
<p>Before submitting, please ensure that:</p>
<ul>
<li>The manuscript is original and not under review elsewhere.</li>
<li>All authors have approved the final version.</li>
<li>The manuscript follows the author guidelines (format, length, references).</li>
<li>An abstract and 3-6 keywords are included.</li>
<li>Figures and tables are numbered and have captions.</li>
<li>References are complete and in APA 7th edition.</li>
<li>A cover letter is prepared.</li>
<li>Conflicts of interest are declared.</li>
<li>Ethics approval is obtained where applicable.</li>
<li>The submission file is anonymized for double-blind review (remove author names from manuscript).</li>
</ul>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='submission-preparation') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Daftar Periksa Persiapan Penyerahan' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='submission-preparation') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Daftar Periksa Persiapan Penyerahan</h2>
<p>Sebelum menyerahkan, pastikan bahwa:</p>
<ul>
<li>Naskah orisinal dan tidak sedang ditelaah di tempat lain.</li>
<li>Semua penulis menyetujui versi final.</li>
<li>Naskah mengikuti panduan penulis (format, panjang, referensi).</li>
<li>Abstrak dan 3-6 kata kunci disertakan.</li>
<li>Gambar dan tabel dinomori dan memiliki keterangan.</li>
<li>Referensi lengkap dan dalam APA edisi ke-7.</li>
<li>Surat pengantar disiapkan.</li>
<li>Konflik kepentingan dideklarasikan.</li>
<li>Persetujuan etik diperoleh jika berlaku.</li>
<li>File penyerahan dianonimkan untuk telaah buta ganda (hapus nama penulis dari naskah).</li>
</ul>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='submission-preparation') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Publication Ethics' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='publication-ethics') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Publication Ethics Statement</h2>
<p>JRDC follows the Committee on Publication Ethics (COPE) guidelines and expects all parties (authors, reviewers, editors) to adhere to the highest ethical standards.</p>
<h3>Duties of Authors</h3>
<ul>
<li>Submit original work; no plagiarism or duplicate publication.</li>
<li>Accurately report data and methods; retain raw data.</li>
<li>Disclose conflicts of interest and funding.</li>
<li>Acknowledge all contributors and sources.</li>
<li>Notify the editor of significant errors post-publication.</li>
</ul>
<h3>Duties of Reviewers</h3>
<ul>
<li>Maintain confidentiality of manuscripts.</li>
<li>Provide objective, constructive, and timely reviews.</li>
<li>Declare conflicts of interest; decline if unqualified.</li>
<li>Report suspected misconduct to the editor.</li>
</ul>
<h3>Duties of Editors</h3>
<ul>
<li>Ensure fair, unbiased, and timely peer review.</li>
<li>Uphold confidentiality and prevent conflicts of interest.</li>
<li>Take appropriate action on misconduct (correction, retraction).</li>
<li>Maintain editorial independence.</li>
</ul>
<h3>Misconduct</h3>
<p>Allegations of plagiarism, data fabrication, or unethical research are investigated following COPE flowcharts. Outcomes may include rejection, correction, or retraction.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='publication-ethics') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Etika Publikasi' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='publication-ethics') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Pernyataan Etika Publikasi</h2>
<p>JRDC mengikuti pedoman Committee on Publication Ethics (COPE) dan mengharapkan semua pihak (penulis, reviewer, editor) mematuhi standar etika tertinggi.</p>
<h3>Kewajiban Penulis</h3>
<ul>
<li>Menyerahkan karya orisinal; tanpa plagiarisme atau publikasi ganda.</li>
<li>Melaporkan data dan metode secara akurat; menyimpan data mentah.</li>
<li>Mendeklarasikan konflik kepentingan dan pendanaan.</li>
<li>Mengakui semua kontributor dan sumber.</li>
<li>Memberitahu editor tentang kesalahan signifikan setelah publikasi.</li>
</ul>
<h3>Kewajiban Reviewer</h3>
<ul>
<li>Menjaga kerahasiaan naskah.</li>
<li>Memberikan telaah objektif, konstruktif, dan tepat waktu.</li>
<li>Mendeklarasikan konflik kepentingan; menolak jika tidak kompeten.</li>
<li>Melaporkan dugaan pelanggaran kepada editor.</li>
</ul>
<h3>Kewajiban Editor</h3>
<ul>
<li>Memastikan telaah sejawat adil, tidak bias, dan tepat waktu.</li>
<li>Menjaga kerahasiaan dan mencegah konflik kepentingan.</li>
<li>Mengambil tindakan yang tepat atas pelanggaran (koreksi, retraksi).</li>
<li>Menjaga independensi editorial.</li>
</ul>
<h3>Pelanggaran</h3>
<p>Dugaan plagiarisme, fabrikasi data, atau penelitian tidak etis diselidiki mengikuti alur COPE. Hasilnya dapat berupa penolakan, koreksi, atau retraksi.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='publication-ethics') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Peer Review Process' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='peer-review-process') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Peer Review Process</h2>
<p>JRDC uses a <strong>double-blind peer review</strong>. Both authors and reviewers remain anonymous throughout the process.</p>
<h3>Stages</h3>
<ol>
<li><strong>Initial check</strong> (1-3 days): scope, format, plagiarism screening.</li>
<li><strong>Editor assignment</strong>: editor selects 2+ reviewers.</li>
<li><strong>Review</strong> (2-4 weeks): reviewers evaluate originality, methodology, significance, and clarity.</li>
<li><strong>Decision</strong>: accept, minor revision, major revision, or reject.</li>
<li><strong>Revision</strong> (if required): authors revise and resubmit.</li>
<li><strong>Final decision and publication</strong>.</li>
</ol>
<p>Typical time from submission to first decision: 4-6 weeks. Time to publication: 8-12 weeks after acceptance.</p>
<h3>Decision Types</h3>
<ul>
<li>Accept</li>
<li>Minor revision</li>
<li>Major revision</li>
<li>Reject (with or without resubmission)</li>
</ul>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='peer-review-process') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Proses Telaah Sejawat' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='peer-review-process') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Proses Telaah Sejawat</h2>
<p>JRDC menggunakan <strong>telaah sejawat buta ganda (double-blind)</strong>. Penulis dan reviewer tetap anonim sepanjang proses.</p>
<h3>Tahapan</h3>
<ol>
<li><strong>Pemeriksaan awal</strong> (1-3 hari): ruang lingkup, format, skrining plagiarisme.</li>
<li><strong>Penugasan editor</strong>: editor memilih 2+ reviewer.</li>
<li><strong>Telaah</strong> (2-4 minggu): reviewer mengevaluasi orisinalitas, metodologi, signifikansi, dan kejelasan.</li>
<li><strong>Keputusan</strong>: diterima, revisi minor, revisi mayor, atau ditolak.</li>
<li><strong>Revisi</strong> (jika diperlukan): penulis merevisi dan menyerahkan ulang.</li>
<li><strong>Keputusan final dan publikasi</strong>.</li>
</ol>
<p>Waktu tipikal dari penyerahan hingga keputusan pertama: 4-6 minggu. Waktu hingga publikasi: 8-12 minggu setelah diterima.</p>
<h3>Jenis Keputusan</h3>
<ul>
<li>Diterima</li>
<li>Revisi minor</li>
<li>Revisi mayor</li>
<li>Ditolak (dengan atau tanpa penyerahan ulang)</li>
</ul>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='peer-review-process') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Open Access Statement' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='open-access-statement') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Open Access Statement</h2>
<p>JRDC provides immediate open access to its content on the principle that making research freely available to the public supports a greater global exchange of knowledge. All articles are published under the Creative Commons Attribution 4.0 International (CC BY 4.0) license.</p>
<p>There are no subscription fees, no paywalls, and no embargo periods. Readers may read, download, copy, distribute, and adapt the material for any purpose, provided proper attribution is given.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='open-access-statement') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Pernyataan Akses Terbuka' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='open-access-statement') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Pernyataan Akses Terbuka</h2>
<p>JRDC menyediakan akses terbuka langsung ke kontennya dengan prinsip bahwa membuat penelitian tersedia bebas bagi publik mendukung pertukaran pengetahuan global yang lebih besar. Semua artikel diterbitkan dengan lisensi Creative Commons Attribution 4.0 International (CC BY 4.0).</p>
<p>Tidak ada biaya langganan, tidak ada paywall, dan tidak ada periode embargo. Pembaca dapat membaca, mengunduh, menyalin, mendistribusikan, dan mengadaptasi materi untuk tujuan apa pun, asalkan atribusi yang tepat diberikan.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='open-access-statement') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Copyright and License' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='copyright-and-license') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Copyright and License</h2>
<p>Authors retain copyright of their work. By submitting, authors grant JRDC the right to publish and distribute the article under the Creative Commons Attribution 4.0 International (CC BY 4.0) license.</p>
<h3>CC BY 4.0</h3>
<p>You are free to share and adapt the material for any purpose, including commercial, provided you give appropriate credit, provide a link to the license, and indicate if changes were made.</p>
<h3>Third-Party Material</h3>
<p>Authors are responsible for obtaining permission for any third-party material included in their manuscript.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='copyright-and-license') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Hak Cipta dan Lisensi' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='copyright-and-license') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Hak Cipta dan Lisensi</h2>
<p>Penulis mempertahankan hak cipta atas karyanya. Dengan menyerahkan, penulis memberikan JRDC hak untuk menerbitkan dan mendistribusikan artikel dengan lisensi Creative Commons Attribution 4.0 International (CC BY 4.0).</p>
<h3>CC BY 4.0</h3>
<p>Anda bebas membagikan dan mengadaptasi materi untuk tujuan apa pun, termasuk komersial, asalkan memberikan kredit yang tepat, memberikan tautan ke lisensi, dan menunjukkan jika ada perubahan.</p>
<h3>Materi Pihak Ketiga</h3>
<p>Penulis bertanggung jawab memperoleh izin untuk materi pihak ketiga yang disertakan dalam naskah.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='copyright-and-license') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Plagiarism Policy' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='plagiarism-policy') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Plagiarism Policy</h2>
<p>JRDC screens all submissions for plagiarism using similarity detection software. A similarity index above 20% (excluding references and quotes) may result in rejection or return for revision. Self-plagiarism and duplicate publication are not permitted.</p>
<p>Authors must ensure all sources are properly cited. Detected plagiarism after publication may lead to retraction.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='plagiarism-policy') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Kebijakan Plagiarisme' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='plagiarism-policy') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Kebijakan Plagiarisme</h2>
<p>JRDC menyaring semua penyerahan untuk plagiarisme menggunakan perangkat lunak deteksi kemiripan. Indeks kemiripan di atas 20% (tidak termasuk referensi dan kutipan) dapat mengakibatkan penolakan atau pengembalian untuk revisi. Plagiarisme diri dan publikasi ganda tidak diizinkan.</p>
<p>Penulis harus memastikan semua sumber disitasi dengan benar. Plagiarisme yang terdeteksi setelah publikasi dapat menyebabkan retraksi.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='plagiarism-policy') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Indexing and Abstracting' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='indexing') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Indexing and Abstracting</h2>
<p>JRDC is indexed/abstracted in (or targeting):</p>
<ul>
<li>Google Scholar</li>
<li>Crossref (DOI registration)</li>
<li>DOAJ (application in progress)</li>
<li>SINTA (application in progress)</li>
<li>GARUDA</li>
</ul>
<p>Indexing status is updated as applications are approved. Authors can verify via the journal''s Google Scholar profile.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='indexing') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Pengindeksan dan Abstraksi' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='indexing') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Pengindeksan dan Abstraksi</h2>
<p>JRDC terindeks/terabstrak dalam (atau sedang mengajukan):</p>
<ul>
<li>Google Scholar</li>
<li>Crossref (registrasi DOI)</li>
<li>DOAJ (pengajuan sedang diproses)</li>
<li>SINTA (pengajuan sedang diproses)</li>
<li>GARUDA</li>
</ul>
<p>Status pengindeksan diperbarui seiring persetujuan pengajuan. Penulis dapat memverifikasi melalui profil Google Scholar jurnal.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='indexing') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Archive Policy' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='archive-policy') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Archive Policy</h2>
<p>JRDC is committed to long-term preservation of its content. Articles are archived in:</p>
<ul>
<li>PKP Preservation Network (PKP PN)</li>
<li>Institutional repository (planned)</li>
<li>Regular off-site backups</li>
</ul>
<p>Metadata is exposed via OAI-PMH for harvesting by indexing services.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='archive-policy') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Kebijakan Arsip' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='archive-policy') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Kebijakan Arsip</h2>
<p>JRDC berkomitmen pada pelestarian jangka panjang kontennya. Artikel diarsipkan di:</p>
<ul>
<li>PKP Preservation Network (PKP PN)</li>
<li>Repositori institusi (direncanakan)</li>
<li>Cadangan rutin di luar lokasi</li>
</ul>
<p>Metadata diekspos melalui OAI-PMH untuk dipanen oleh layanan pengindeksan.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='archive-policy') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Author Fees' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='author-fees') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Author Fees</h2>
<p>JRDC does not charge any author fees at present:</p>
<ul>
<li>Article submission charge: none</li>
<li>Article processing charge (APC): none</li>
<li>Publication fee: none</li>
</ul>
<p>The journal is funded by the publisher. If fees are introduced in the future, they will be announced in advance and a waiver policy will be provided for authors from low-income countries.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='author-fees') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Biaya Penulis' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='author-fees') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Biaya Penulis</h2>
<p>JRDC tidak memungut biaya apa pun dari penulis saat ini:</p>
<ul>
<li>Biaya penyerahan artikel: tidak ada</li>
<li>Biaya pemrosesan artikel (APC): tidak ada</li>
<li>Biaya publikasi: tidak ada</li>
</ul>
<p>Jurnal didanai oleh penerbit. Jika biaya diperkenalkan di masa depan, akan diumumkan sebelumnya dan kebijakan pembebasan biaya akan disediakan untuk penulis dari negara berpenghasilan rendah.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='author-fees') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Contact Us' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='contact-us') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Contact &amp; Editorial Office</h2>
<div class="jilp-contact-grid">
<div class="jilp-contact-card">
<i class="bi bi-envelope-fill"></i>
<h3>Editorial Email</h3>
<p><a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a></p>
<p>For submission, editorial decisions, and general inquiries.</p>
</div>
<div class="jilp-contact-card">
<i class="bi bi-life-preserver"></i>
<h3>Technical Support</h3>
<p><a href="mailto:support@jrdc.my.id">support@jrdc.my.id</a></p>
<p>For account, submission system, or website issues.</p>
</div>
<div class="jilp-contact-card">
<i class="bi bi-telephone-fill"></i>
<h3>Phone / WhatsApp</h3>
<p><a href="https://wa.me/6281234567890" target="_blank" rel="noopener">+62 812-3456-7890</a></p>
<p>Available during office hours (WIB).</p>
</div>
<div class="jilp-contact-card">
<i class="bi bi-geo-alt-fill"></i>
<h3>Address</h3>
<p>Yayasan Ratu Dirgantara Cendikiawan (JRDC)<br/>Indonesia</p>
</div>
</div>
<h3>Send a Message</h3>
<p>Please include your name, affiliation, and a clear subject line. For manuscript-related questions, include the submission ID if available. We aim to respond within 2-3 business days.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='contact-us') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Hubungi Kami' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='contact-us') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Kontak &amp; Kantor Redaksi</h2>
<div class="jilp-contact-grid">
<div class="jilp-contact-card">
<i class="bi bi-envelope-fill"></i>
<h3>Email Redaksi</h3>
<p><a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a></p>
<p>Untuk penyerahan naskah, keputusan editorial, dan pertanyaan umum.</p>
</div>
<div class="jilp-contact-card">
<i class="bi bi-life-preserver"></i>
<h3>Dukungan Teknis</h3>
<p><a href="mailto:support@jrdc.my.id">support@jrdc.my.id</a></p>
<p>Untuk masalah akun, sistem penyerahan, atau situs web.</p>
</div>
<div class="jilp-contact-card">
<i class="bi bi-telephone-fill"></i>
<h3>Telepon / WhatsApp</h3>
<p><a href="https://wa.me/6281234567890" target="_blank" rel="noopener">+62 812-3456-7890</a></p>
<p>Tersedia pada jam kerja (WIB).</p>
</div>
<div class="jilp-contact-card">
<i class="bi bi-geo-alt-fill"></i>
<h3>Alamat</h3>
<p>Yayasan Ratu Dirgantara Cendikiawan (JRDC)<br/>Indonesia</p>
</div>
</div>
<h3>Kirim Pesan</h3>
<p>Sertakan nama, afiliasi, dan subjek yang jelas. Untuk pertanyaan terkait naskah, sertakan ID penyerahan jika tersedia. Kami berusaha merespons dalam 2-3 hari kerja.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='contact-us') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Generative AI Policy' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='generative-ai') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Generative AI Policy</h2>
<p>JRDC follows COPE guidance on AI tools. Authors may use generative AI for language editing only; any substantive use must be disclosed in the manuscript (methods/acknowledgements). AI tools cannot be listed as authors. Reviewers and editors must not upload manuscripts to AI tools. Undisclosed AI use may result in rejection or retraction.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='generative-ai') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Kebijakan AI Generatif' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='generative-ai') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Kebijakan AI Generatif</h2>
<p>JRDC mengikuti panduan COPE tentang alat AI. Penulis boleh menggunakan AI generatif hanya untuk pengeditan bahasa; penggunaan substantif harus diungkapkan dalam naskah (metode/ucapan terima kasih). Alat AI tidak dapat dicantumkan sebagai penulis. Reviewer dan editor tidak boleh mengunggah naskah ke alat AI. Penggunaan AI yang tidak diungkapkan dapat mengakibatkan penolakan atau retraksi.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='generative-ai') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Privacy Policy' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='privacy-policy') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Privacy Policy</h2>
<p>This policy explains how <strong>Journal of Economics and Business Research (JRDC)</strong> collects, uses, stores, and protects personal information. It is aligned with common scholarly publishing practice, the <a href="https://publicationethics.org" target="_blank" rel="noopener">Committee on Publication Ethics (COPE)</a> principles, and data-protection good practice.</p>

<h3>1. Information We Collect</h3>
<p>We collect only the personal data needed to operate the journal:</p>
<ul>
<li><strong>Authors and co-authors:</strong> name, affiliation, email address, ORCID iD, mailing address (if required), and submission history.</li>
<li><strong>Reviewers:</strong> name, affiliation, email address, ORCID iD, areas of expertise, and review history.</li>
<li><strong>Readers and registered users:</strong> name, email address, and account preferences.</li>
<li><strong>Technical data:</strong> IP address, browser type, and cookies necessary for login and security.</li>
</ul>

<h3>2. How We Use Your Information</h3>
<ul>
<li>To manage the peer-review and editorial workflow.</li>
<li>To communicate with authors, reviewers, and readers about submissions, publications, and journal announcements.</li>
<li>To publish author and affiliation metadata with accepted articles.</li>
<li>To maintain secure user accounts and prevent misuse.</li>
<li>To generate anonymised usage statistics for journal reporting.</li>
</ul>

<h3>3. Legal Basis for Processing</h3>
<p>Processing is based on:</p>
<ul>
<li>The legitimate interest of operating a scholarly journal.</li>
<li>Consent given when creating an account or submitting a manuscript.</li>
<li>The necessity of fulfilling a publishing contract with the author.</li>
</ul>

<h3>4. Data Sharing</h3>
<p>We do not sell personal data. We share data only when necessary:</p>
<ul>
<li>With indexing and abstracting services (e.g., Crossref, DOAJ, Google Scholar) to register and disseminate publications.</li>
<li>With service providers that host or support the journal platform under strict confidentiality.</li>
<li>When required by law or to protect the rights, property, or safety of JRDC and its users.</li>
</ul>

<h3>5. Data Retention and Security</h3>
<p>Personal data is retained for as long as necessary for journal operations, legal obligations, and scholarly record-keeping. We use technical and organisational measures (encrypted connections, access controls, regular backups) to protect data from unauthorised access, loss, or alteration.</p>

<h3>6. Your Rights</h3>
<p>You may request to access, correct, restrict, or delete your personal data, subject to the need to preserve the scholarly record. To exercise these rights, contact the editorial office at <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>

<h3>7. Cookies</h3>
<p>Our platform uses essential cookies for authentication and session management. We do not use third-party advertising or tracking cookies.</p>

<h3>8. Changes to This Policy</h3>
<p>We may update this policy from time to time. Material changes will be announced on the journal website. Continued use of the site after changes constitutes acceptance of the revised policy.</p>

<h3>9. Contact</h3>
<p>For privacy-related questions, please email <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='privacy-policy') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Kebijakan Privasi' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='privacy-policy') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Kebijakan Privasi</h2>
<p>Kebijakan ini menjelaskan bagaimana <strong>Journal of Economics and Business Research (JRDC)</strong> mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pribadi. Kebijakan ini selaras dengan praktik penerbitan ilmiah umum, prinsip <a href="https://publicationethics.org" target="_blank" rel="noopener">Committee on Publication Ethics (COPE)</a>, dan praktik baik perlindungan data.</p>

<h3>1. Informasi yang Kami Kumpulkan</h3>
<p>Kami hanya mengumpulkan data pribadi yang diperlukan untuk menjalankan jurnal:</p>
<ul>
<li><strong>Penulis dan co-penulis:</strong> nama, afiliasi, alamat email, iD ORCID, alamat surat (jika diperlukan), dan riwayat penyerahan.</li>
<li><strong>Reviewer:</strong> nama, afiliasi, alamat email, iD ORCID, bidang keahlian, dan riwayat telaah.</li>
<li><strong>Pembaca dan pengguna terdaftar:</strong> nama, alamat email, dan preferensi akun.</li>
<li><strong>Data teknis:</strong> alamat IP, jenis peramban, dan cookie yang diperlukan untuk login dan keamanan.</li>
</ul>

<h3>2. Cara Kami Menggunakan Informasi Anda</h3>
<ul>
<li>Mengelola alur kerja telaah sejawat dan editorial.</li>
<li>Berkomunikasi dengan penulis, reviewer, dan pembaca mengenai penyerahan, publikasi, dan pengumuman jurnal.</li>
<li>Menerbitkan metadata penulis dan afiliasi bersama artikel yang diterima.</li>
<li>Menjaga keamanan akun pengguna dan mencegah penyalahgunaan.</li>
<li>Menghasilkan statistik penggunaan yang dianonimkan untuk pelaporan jurnal.</li>
</ul>

<h3>3. Dasar Hukum Pemrosesan</h3>
<p>Pemrosesan didasarkan pada:</p>
<ul>
<li>Kepentingan sah untuk mengoperasikan jurnal ilmiah.</li>
<li>Persetujuan yang diberikan saat membuat akun atau menyerahkan naskah.</li>
<li>Kebutuhan untuk memenuhi kontrak penerbitan dengan penulis.</li>
</ul>

<h3>4. Pembagian Data</h3>
<p>Kami tidak menjual data pribadi. Kami membagikan data hanya jika diperlukan:</p>
<ul>
<li>Kepada layanan pengindeksan dan abstraksi (misalnya Crossref, DOAJ, Google Scholar) untuk mendaftarkan dan menyebarluaskan publikasi.</li>
<li>Kepada penyedia layanan yang menghosting atau mendukung platform jurnal dengan kerahasiaan yang ketat.</li>
<li>Jika diwajibkan oleh hukum atau untuk melindungi hak, properti, atau keselamatan JRDC dan penggunanya.</li>
</ul>

<h3>5. Penyimpanan dan Keamanan Data</h3>
<p>Data pribadi disimpan selama diperlukan untuk operasi jurnal, kewajiban hukum, dan pelestarian arsip ilmiah. Kami menggunakan langkah teknis dan organisasional (koneksi terenkripsi, kontrol akses, cadangan rutin) untuk melindungi data dari akses, kehilangan, atau perubahan yang tidak sah.</p>

<h3>6. Hak Anda</h3>
<p>Anda dapat meminta akses, koreksi, pembatasan, atau penghapusan data pribadi Anda, dengan mempertahankan kebutuhan pelestarian arsip ilmiah. Untuk menggunakan hak ini, hubungi kantor redaksi di <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>

<h3>7. Cookie</h3>
<p>Platform kami menggunakan cookie esensial untuk autentikasi dan manajemen sesi. Kami tidak menggunakan cookie iklan atau pelacakan pihak ketiga.</p>

<h3>8. Perubahan Kebijakan</h3>
<p>Kami dapat memperbarui kebijakan ini dari waktu ke waktu. Perubahan material akan diumumkan di situs jurnal. Penggunaan berkelanjutan atas situs setelah perubahan berarti penerimaan kebijakan yang direvisi.</p>

<h3>9. Kontak</h3>
<p>Untuk pertanyaan terkait privasi, silakan email <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='privacy-policy') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Editorial Team' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='editorial-team') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Editorial Team</h2>
<p><strong>Editor-in-Chief</strong>: [Name], [Affiliation]</p>
<p><strong>Managing Editor</strong>: [Name], [Affiliation]</p>
<p><strong>Section Editors</strong>: [Names], [Affiliations]</p>
<p><strong>Editorial Board</strong>: [Names], [Affiliations]</p>
<p><strong>Reviewers</strong>: The journal maintains a pool of qualified reviewers across Economics and Business disciplines.</p>
<p>To join the editorial team or reviewer pool, please contact <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='editorial-team') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Tim Editorial' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='editorial-team') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Tim Editorial</h2>
<p><strong>Penyunting Utama (Editor-in-Chief)</strong>: [Nama], [Afiliasi]</p>
<p><strong>Penyunting Pelaksana (Managing Editor)</strong>: [Nama], [Afiliasi]</p>
<p><strong>Penyunting Seksi</strong>: [Nama], [Afiliasi]</p>
<p><strong>Dewan Editorial</strong>: [Nama], [Afiliasi]</p>
<p><strong>Reviewer</strong>: Jurnal mempertahankan kumpulan reviewer yang berkualifikasi di berbagai disiplin Ekonomi dan Bisnis.</p>
<p>Untuk bergabung dengan tim editorial atau kumpulan reviewer, hubungi <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='editorial-team') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Become a Reviewer' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='reviewer') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Become a Reviewer</h2>
<p>JRDC invites qualified scholars and practitioners to join our reviewer pool. Reviewers are expected to have expertise in Economics or Business, hold at least a master''s degree (PhD preferred), and be able to review in English or Indonesian.</p>
<p>To register, email your CV and areas of expertise to <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='reviewer') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Menjadi Reviewer' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='reviewer') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Menjadi Reviewer</h2>
<p>JRDC mengundang cendekiawan dan praktisi yang berkualifikasi untuk bergabung dengan kumpulan reviewer kami. Reviewer diharapkan memiliki keahlian di bidang Ekonomi atau Bisnis, minimal gelar magister (doktor lebih disukai), dan mampu menelaah dalam bahasa Inggris atau Indonesia.</p>
<p>Untuk mendaftar, kirim CV dan bidang keahlian ke <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='reviewer') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Reviewer Guidelines' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='reviewer-guide') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Reviewer Guidelines</h2>
<p>Reviewers are asked to evaluate manuscripts on originality, methodology, significance, and clarity. Reviews should be constructive, respectful, and free of personal bias. Confidentiality must be maintained. Conflicts of interest must be declared. Reviews are expected within 2-4 weeks.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='reviewer-guide') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Panduan Reviewer' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='reviewer-guide') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Panduan Reviewer</h2>
<p>Reviewer diminta mengevaluasi naskah berdasarkan orisinalitas, metodologi, signifikansi, dan kejelasan. Telaah harus konstruktif, menghormati, dan bebas bias pribadi. Kerahasiaan harus dijaga. Konflik kepentingan harus dideklarasikan. Telaah diharapkan dalam 2-4 minggu.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='reviewer-guide') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Letter of Acceptance' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='loa') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Letter of Acceptance (LoA)</h2>
<p>Upon acceptance, authors receive a Letter of Acceptance (LoA) signed by the Editor-in-Chief. The LoA confirms the article''s acceptance and anticipated publication issue. Authors may use the LoA for institutional or funding requirements.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='loa') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Surat Penerimaan (LoA)' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='loa') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Surat Penerimaan (LoA)</h2>
<p>Setelah diterima, penulis menerima Surat Penerimaan (LoA) yang ditandatangani oleh Penyunting Utama. LoA mengonfirmasi penerimaan artikel dan perkiraan terbit. Penulis dapat menggunakan LoA untuk keperluan institusi atau pendanaan.</p>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='loa') AND setting_name='content' AND locale='id';
UPDATE static_page_settings SET setting_value='Frequently Asked Questions' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='faq') AND setting_name='title' AND locale='en';
UPDATE static_page_settings SET setting_value='<h2>Frequently Asked Questions</h2>
<dl>
<dt>How long does review take?</dt><dd>First decision typically in 4-6 weeks.</dd>
<dt>Is there a publication fee?</dt><dd>No. JRDC charges no APC or submission fees.</dd>
<dt>Can I submit in Indonesian?</dt><dd>Yes, English or Indonesian are accepted.</dd>
<dt>How do I track my submission?</dt><dd>Log in to the submission system and check your dashboard.</dd>
<dt>What license is used?</dt><dd>CC BY 4.0.</dd>
</dl>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='faq') AND setting_name='content' AND locale='en';
UPDATE static_page_settings SET setting_value='Pertanyaan yang Sering Diajukan' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='faq') AND setting_name='title' AND locale='id';
UPDATE static_page_settings SET setting_value='<h2>Pertanyaan yang Sering Diajukan</h2>
<dl>
<dt>Berapa lama proses telaah?</dt><dd>Keputusan pertama biasanya 4-6 minggu.</dd>
<dt>Apakah ada biaya publikasi?</dt><dd>Tidak. JRDC tidak memungut APC atau biaya penyerahan.</dd>
<dt>Bisakah menyerah dalam bahasa Indonesia?</dt><dd>Ya, Inggris atau Indonesia diterima.</dd>
<dt>Bagaimana melacak penyerahan saya?</dt><dd>Masuk ke sistem penyerahan dan cek dashboard.</dd>
<dt>Lisensi apa yang digunakan?</dt><dd>CC BY 4.0.</dd>
</dl>' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='faq') AND setting_name='content' AND locale='id';
