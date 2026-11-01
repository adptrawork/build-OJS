# -*- coding: utf-8 -*-
"""Generate SQL to fill static_pages content (EN/ID) for JRDC journal."""
import json

TITLES = {'about': ('About the Journal', 'Tentang Jurnal'), 'focus-and-scope': ('Focus and Scope', 'Fokus dan Ruang Lingkup'), 'author-guidelines': ('Author Guidelines', 'Panduan Penulis'), 'submission-preparation': ('Submission Preparation Checklist', 'Daftar Periksa Persiapan Penyerahan'), 'publication-ethics': ('Publication Ethics', 'Etika Publikasi'), 'peer-review-process': ('Peer Review Process', 'Proses Telaah Sejawat'), 'open-access-statement': ('Open Access Statement', 'Pernyataan Akses Terbuka'), 'copyright-and-license': ('Copyright and License', 'Hak Cipta dan Lisensi'), 'plagiarism-policy': ('Plagiarism Policy', 'Kebijakan Plagiarisme'), 'indexing': ('Indexing and Abstracting', 'Pengindeksan dan Abstraksi'), 'archive-policy': ('Archive Policy', 'Kebijakan Arsip'), 'author-fees': ('Author Fees', 'Biaya Penulis'), 'contact-us': ('Contact Us', 'Hubungi Kami'), 'generative-ai': ('Generative AI Policy', 'Kebijakan AI Generatif'), 'privacy-policy': ('Privacy Policy', 'Kebijakan Privasi'), 'editorial-team': ('Editorial Team', 'Tim Editorial'), 'reviewer': ('Become a Reviewer', 'Menjadi Reviewer'), 'reviewer-guide': ('Reviewer Guidelines', 'Panduan Reviewer'), 'loa': ('Letter of Acceptance', 'Surat Penerimaan (LoA)'), 'faq': ('Frequently Asked Questions', 'Pertanyaan yang Sering Diajukan')}

PAGES = {
 "about": {
  "en": """<h2>About the Journal</h2>
<p><strong>Journal of Economics and Business Research</strong> (JRDC) is a peer-reviewed, open-access scholarly journal published by Yayasan Ratu Dirgantara Cendikiawan (JRDC). The journal publishes original research, reviews, and short communications in Economics and Business, including management, accounting, finance, marketing, entrepreneurship, and development economics.</p>
<p>JRDC is committed to advancing knowledge, supporting education, and disseminating research and academic thought by providing a credible publication space for academics, researchers, students, and practitioners. All articles are published under a Creative Commons Attribution 4.0 International (CC BY 4.0) license and are freely available online.</p>
<h3>Publisher</h3>
<p>Yayasan Ratu Dirgantara Cendikiawan (JRDC)<br/>Indonesia</p>
<h3>Contact</h3>
<p>Editorial Office: <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a></p>""",
  "id": """<h2>Tentang Jurnal</h2>
<p><strong>Journal of Economics and Business Research</strong> (JRDC) adalah jurnal ilmiah dengan telaah sejawat (peer-reviewed) dan akses terbuka (open access) yang diterbitkan oleh Yayasan Ratu Dirgantara Cendikiawan (JRDC). Jurnal ini menerbitkan penelitian orisinal, ulasan, dan komunikasi singkat di bidang Ekonomi dan Bisnis, termasuk manajemen, akuntansi, keuangan, pemasaran, kewirausahaan, dan ekonomi pembangunan.</p>
<p>JRDC berkomitmen mendukung pengembangan pendidikan, kemajuan ilmu pengetahuan, dan penyebarluasan hasil penelitian serta pemikiran akademik dengan menyediakan ruang publikasi yang kredibel bagi akademisi, peneliti, mahasiswa, dan praktisi. Seluruh artikel diterbitkan dengan lisensi Creative Commons Attribution 4.0 International (CC BY 4.0) dan tersedia bebas secara daring.</p>
<h3>Penerbit</h3>
<p>Yayasan Ratu Dirgantara Cendikiawan (JRDC)<br/>Indonesia</p>
<h3>Kontak</h3>
<p>Kantor Redaksi: <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a></p>""",
 },
 "focus-and-scope": {
  "en": """<h2>Focus and Scope</h2>
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
</ul>""",
  "id": """<h2>Fokus dan Ruang Lingkup</h2>
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
</ul>""",
 },
 "author-guidelines": {
  "en": """<h2>Author Guidelines</h2>
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
<p>Submit via the online submission system. Include a cover letter and suggested reviewers (optional).</p>""",
  "id": """<h2>Panduan Penulis</h2>
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
<p>Serahkan melalui sistem penyerahan daring. Sertakan surat pengantar dan saran reviewer (opsional).</p>""",
 },
 "submission-preparation": {
  "en": """<h2>Submission Preparation Checklist</h2>
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
</ul>""",
  "id": """<h2>Daftar Periksa Persiapan Penyerahan</h2>
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
</ul>""",
 },
 "publication-ethics": {
  "en": """<h2>Publication Ethics Statement</h2>
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
<p>Allegations of plagiarism, data fabrication, or unethical research are investigated following COPE flowcharts. Outcomes may include rejection, correction, or retraction.</p>""",
  "id": """<h2>Pernyataan Etika Publikasi</h2>
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
<p>Dugaan plagiarisme, fabrikasi data, atau penelitian tidak etis diselidiki mengikuti alur COPE. Hasilnya dapat berupa penolakan, koreksi, atau retraksi.</p>""",
 },
 "peer-review-process": {
  "en": """<h2>Peer Review Process</h2>
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
</ul>""",
  "id": """<h2>Proses Telaah Sejawat</h2>
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
</ul>""",
 },
 "open-access-statement": {
  "en": """<h2>Open Access Statement</h2>
<p>JRDC provides immediate open access to its content on the principle that making research freely available to the public supports a greater global exchange of knowledge. All articles are published under the Creative Commons Attribution 4.0 International (CC BY 4.0) license.</p>
<p>There are no subscription fees, no paywalls, and no embargo periods. Readers may read, download, copy, distribute, and adapt the material for any purpose, provided proper attribution is given.</p>""",
  "id": """<h2>Pernyataan Akses Terbuka</h2>
<p>JRDC menyediakan akses terbuka langsung ke kontennya dengan prinsip bahwa membuat penelitian tersedia bebas bagi publik mendukung pertukaran pengetahuan global yang lebih besar. Semua artikel diterbitkan dengan lisensi Creative Commons Attribution 4.0 International (CC BY 4.0).</p>
<p>Tidak ada biaya langganan, tidak ada paywall, dan tidak ada periode embargo. Pembaca dapat membaca, mengunduh, menyalin, mendistribusikan, dan mengadaptasi materi untuk tujuan apa pun, asalkan atribusi yang tepat diberikan.</p>""",
 },
 "copyright-and-license": {
  "en": """<h2>Copyright and License</h2>
<p>Authors retain copyright of their work. By submitting, authors grant JRDC the right to publish and distribute the article under the Creative Commons Attribution 4.0 International (CC BY 4.0) license.</p>
<h3>CC BY 4.0</h3>
<p>You are free to share and adapt the material for any purpose, including commercial, provided you give appropriate credit, provide a link to the license, and indicate if changes were made.</p>
<h3>Third-Party Material</h3>
<p>Authors are responsible for obtaining permission for any third-party material included in their manuscript.</p>""",
  "id": """<h2>Hak Cipta dan Lisensi</h2>
<p>Penulis mempertahankan hak cipta atas karyanya. Dengan menyerahkan, penulis memberikan JRDC hak untuk menerbitkan dan mendistribusikan artikel dengan lisensi Creative Commons Attribution 4.0 International (CC BY 4.0).</p>
<h3>CC BY 4.0</h3>
<p>Anda bebas membagikan dan mengadaptasi materi untuk tujuan apa pun, termasuk komersial, asalkan memberikan kredit yang tepat, memberikan tautan ke lisensi, dan menunjukkan jika ada perubahan.</p>
<h3>Materi Pihak Ketiga</h3>
<p>Penulis bertanggung jawab memperoleh izin untuk materi pihak ketiga yang disertakan dalam naskah.</p>""",
 },
 "plagiarism-policy": {
  "en": """<h2>Plagiarism Policy</h2>
<p>JRDC screens all submissions for plagiarism using similarity detection software. A similarity index above 20% (excluding references and quotes) may result in rejection or return for revision. Self-plagiarism and duplicate publication are not permitted.</p>
<p>Authors must ensure all sources are properly cited. Detected plagiarism after publication may lead to retraction.</p>""",
  "id": """<h2>Kebijakan Plagiarisme</h2>
<p>JRDC menyaring semua penyerahan untuk plagiarisme menggunakan perangkat lunak deteksi kemiripan. Indeks kemiripan di atas 20% (tidak termasuk referensi dan kutipan) dapat mengakibatkan penolakan atau pengembalian untuk revisi. Plagiarisme diri dan publikasi ganda tidak diizinkan.</p>
<p>Penulis harus memastikan semua sumber disitasi dengan benar. Plagiarisme yang terdeteksi setelah publikasi dapat menyebabkan retraksi.</p>""",
 },
 "indexing": {
  "en": """<h2>Indexing and Abstracting</h2>
<p>JRDC is indexed/abstracted in (or targeting):</p>
<ul>
<li>Google Scholar</li>
<li>Crossref (DOI registration)</li>
<li>DOAJ (application in progress)</li>
<li>SINTA (application in progress)</li>
<li>GARUDA</li>
</ul>
<p>Indexing status is updated as applications are approved. Authors can verify via the journal's Google Scholar profile.</p>""",
  "id": """<h2>Pengindeksan dan Abstraksi</h2>
<p>JRDC terindeks/terabstrak dalam (atau sedang mengajukan):</p>
<ul>
<li>Google Scholar</li>
<li>Crossref (registrasi DOI)</li>
<li>DOAJ (pengajuan sedang diproses)</li>
<li>SINTA (pengajuan sedang diproses)</li>
<li>GARUDA</li>
</ul>
<p>Status pengindeksan diperbarui seiring persetujuan pengajuan. Penulis dapat memverifikasi melalui profil Google Scholar jurnal.</p>""",
 },
 "archive-policy": {
  "en": """<h2>Archive Policy</h2>
<p>JRDC is committed to long-term preservation of its content. Articles are archived in:</p>
<ul>
<li>PKP Preservation Network (PKP PN)</li>
<li>Institutional repository (planned)</li>
<li>Regular off-site backups</li>
</ul>
<p>Metadata is exposed via OAI-PMH for harvesting by indexing services.</p>""",
  "id": """<h2>Kebijakan Arsip</h2>
<p>JRDC berkomitmen pada pelestarian jangka panjang kontennya. Artikel diarsipkan di:</p>
<ul>
<li>PKP Preservation Network (PKP PN)</li>
<li>Repositori institusi (direncanakan)</li>
<li>Cadangan rutin di luar lokasi</li>
</ul>
<p>Metadata diekspos melalui OAI-PMH untuk dipanen oleh layanan pengindeksan.</p>""",
 },
 "author-fees": {
  "en": """<h2>Author Fees</h2>
<p>JRDC does not charge any author fees at present:</p>
<ul>
<li>Article submission charge: none</li>
<li>Article processing charge (APC): none</li>
<li>Publication fee: none</li>
</ul>
<p>The journal is funded by the publisher. If fees are introduced in the future, they will be announced in advance and a waiver policy will be provided for authors from low-income countries.</p>""",
  "id": """<h2>Biaya Penulis</h2>
<p>JRDC tidak memungut biaya apa pun dari penulis saat ini:</p>
<ul>
<li>Biaya penyerahan artikel: tidak ada</li>
<li>Biaya pemrosesan artikel (APC): tidak ada</li>
<li>Biaya publikasi: tidak ada</li>
</ul>
<p>Jurnal didanai oleh penerbit. Jika biaya diperkenalkan di masa depan, akan diumumkan sebelumnya dan kebijakan pembebasan biaya akan disediakan untuk penulis dari negara berpenghasilan rendah.</p>""",
 },
 "contact-us": {
  "en": """<h2>Contact Us</h2>
<p><strong>Editorial Office</strong><br/>
Yayasan Ratu Dirgantara Cendikiawan (JRDC)<br/>
Indonesia</p>
<p>Email: <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a><br/>
Support: <a href="mailto:support@jrdc.my.id">support@jrdc.my.id</a><br/>
WhatsApp: <a href="https://wa.me/6281234567890">+62 812-3456-7890</a></p>""",
  "id": """<h2>Hubungi Kami</h2>
<p><strong>Kantor Redaksi</strong><br/>
Yayasan Ratu Dirgantara Cendikiawan (JRDC)<br/>
Indonesia</p>
<p>Email: <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a><br/>
Dukungan: <a href="mailto:support@jrdc.my.id">support@jrdc.my.id</a><br/>
WhatsApp: <a href="https://wa.me/6281234567890">+62 812-3456-7890</a></p>""",
 },
 "generative-ai": {
  "en": """<h2>Generative AI Policy</h2>
<p>JRDC follows COPE guidance on AI tools. Authors may use generative AI for language editing only; any substantive use must be disclosed in the manuscript (methods/acknowledgements). AI tools cannot be listed as authors. Reviewers and editors must not upload manuscripts to AI tools. Undisclosed AI use may result in rejection or retraction.</p>""",
  "id": """<h2>Kebijakan AI Generatif</h2>
<p>JRDC mengikuti panduan COPE tentang alat AI. Penulis boleh menggunakan AI generatif hanya untuk pengeditan bahasa; penggunaan substantif harus diungkapkan dalam naskah (metode/ucapan terima kasih). Alat AI tidak dapat dicantumkan sebagai penulis. Reviewer dan editor tidak boleh mengunggah naskah ke alat AI. Penggunaan AI yang tidak diungkapkan dapat mengakibatkan penolakan atau retraksi.</p>""",
 },
 "privacy-policy": {
  "en": """<h2>Privacy Policy</h2>
<p>JRDC collects only the personal information necessary for editorial and publishing processes (names, affiliations, email addresses, ORCID). Data is used solely for journal operations and is not shared with third parties except as required by indexing services. Users may request data correction or deletion by contacting the editorial office.</p>""",
  "id": """<h2>Kebijakan Privasi</h2>
<p>JRDC hanya mengumpulkan informasi pribadi yang diperlukan untuk proses editorial dan publikasi (nama, afiliasi, alamat email, ORCID). Data digunakan semata-mata untuk operasi jurnal dan tidak dibagikan kepada pihak ketiga kecuali diwajibkan oleh layanan pengindeksan. Pengguna dapat meminta koreksi atau penghapusan data dengan menghubungi kantor redaksi.</p>""",
 },
 "editorial-team": {
  "en": """<h2>Editorial Team</h2>
<p><strong>Editor-in-Chief</strong>: [Name], [Affiliation]</p>
<p><strong>Managing Editor</strong>: [Name], [Affiliation]</p>
<p><strong>Section Editors</strong>: [Names], [Affiliations]</p>
<p><strong>Editorial Board</strong>: [Names], [Affiliations]</p>
<p><strong>Reviewers</strong>: The journal maintains a pool of qualified reviewers across Economics and Business disciplines.</p>
<p>To join the editorial team or reviewer pool, please contact <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>""",
  "id": """<h2>Tim Editorial</h2>
<p><strong>Penyunting Utama (Editor-in-Chief)</strong>: [Nama], [Afiliasi]</p>
<p><strong>Penyunting Pelaksana (Managing Editor)</strong>: [Nama], [Afiliasi]</p>
<p><strong>Penyunting Seksi</strong>: [Nama], [Afiliasi]</p>
<p><strong>Dewan Editorial</strong>: [Nama], [Afiliasi]</p>
<p><strong>Reviewer</strong>: Jurnal mempertahankan kumpulan reviewer yang berkualifikasi di berbagai disiplin Ekonomi dan Bisnis.</p>
<p>Untuk bergabung dengan tim editorial atau kumpulan reviewer, hubungi <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>""",
 },
 "reviewer": {
  "en": """<h2>Become a Reviewer</h2>
<p>JRDC invites qualified scholars and practitioners to join our reviewer pool. Reviewers are expected to have expertise in Economics or Business, hold at least a master's degree (PhD preferred), and be able to review in English or Indonesian.</p>
<p>To register, email your CV and areas of expertise to <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>""",
  "id": """<h2>Menjadi Reviewer</h2>
<p>JRDC mengundang cendekiawan dan praktisi yang berkualifikasi untuk bergabung dengan kumpulan reviewer kami. Reviewer diharapkan memiliki keahlian di bidang Ekonomi atau Bisnis, minimal gelar magister (doktor lebih disukai), dan mampu menelaah dalam bahasa Inggris atau Indonesia.</p>
<p>Untuk mendaftar, kirim CV dan bidang keahlian ke <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>""",
 },
 "reviewer-guide": {
  "en": """<h2>Reviewer Guidelines</h2>
<p>Reviewers are asked to evaluate manuscripts on originality, methodology, significance, and clarity. Reviews should be constructive, respectful, and free of personal bias. Confidentiality must be maintained. Conflicts of interest must be declared. Reviews are expected within 2-4 weeks.</p>""",
  "id": """<h2>Panduan Reviewer</h2>
<p>Reviewer diminta mengevaluasi naskah berdasarkan orisinalitas, metodologi, signifikansi, dan kejelasan. Telaah harus konstruktif, menghormati, dan bebas bias pribadi. Kerahasiaan harus dijaga. Konflik kepentingan harus dideklarasikan. Telaah diharapkan dalam 2-4 minggu.</p>""",
 },
 "loa": {
  "en": """<h2>Letter of Acceptance (LoA)</h2>
<p>Upon acceptance, authors receive a Letter of Acceptance (LoA) signed by the Editor-in-Chief. The LoA confirms the article's acceptance and anticipated publication issue. Authors may use the LoA for institutional or funding requirements.</p>""",
  "id": """<h2>Surat Penerimaan (LoA)</h2>
<p>Setelah diterima, penulis menerima Surat Penerimaan (LoA) yang ditandatangani oleh Penyunting Utama. LoA mengonfirmasi penerimaan artikel dan perkiraan terbit. Penulis dapat menggunakan LoA untuk keperluan institusi atau pendanaan.</p>""",
 },
 "faq": {
  "en": """<h2>Frequently Asked Questions</h2>
<dl>
<dt>How long does review take?</dt><dd>First decision typically in 4-6 weeks.</dd>
<dt>Is there a publication fee?</dt><dd>No. JRDC charges no APC or submission fees.</dd>
<dt>Can I submit in Indonesian?</dt><dd>Yes, English or Indonesian are accepted.</dd>
<dt>How do I track my submission?</dt><dd>Log in to the submission system and check your dashboard.</dd>
<dt>What license is used?</dt><dd>CC BY 4.0.</dd>
</dl>""",
  "id": """<h2>Pertanyaan yang Sering Diajukan</h2>
<dl>
<dt>Berapa lama proses telaah?</dt><dd>Keputusan pertama biasanya 4-6 minggu.</dd>
<dt>Apakah ada biaya publikasi?</dt><dd>Tidak. JRDC tidak memungut APC atau biaya penyerahan.</dd>
<dt>Bisakah menyerah dalam bahasa Indonesia?</dt><dd>Ya, Inggris atau Indonesia diterima.</dd>
<dt>Bagaimana melacak penyerahan saya?</dt><dd>Masuk ke sistem penyerahan dan cek dashboard.</dd>
<dt>Lisensi apa yang digunakan?</dt><dd>CC BY 4.0.</dd>
</dl>""",
 },
}

def sql_escape(s):
    return s.replace("\\", "\\\\").replace("'", "''")

lines = []
for path, data in PAGES.items():
    for locale in ("en", "id"):
        title = TITLES[path][0] if locale == "en" else TITLES[path][1]
        content = data[locale]
        lines.append(
            "UPDATE static_page_settings SET setting_value='%s' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='%s') AND setting_name='title' AND locale='%s';"
            % (sql_escape(title), path, locale)
        )
        lines.append(
            "UPDATE static_page_settings SET setting_value='%s' WHERE static_page_id=(SELECT static_page_id FROM static_pages WHERE path='%s') AND setting_name='content' AND locale='%s';"
            % (sql_escape(content), path, locale)
        )

out = "\n".join(lines) + "\n"
with open("/mnt/DiskD/Projects/ojs/scripts/static-content.sql", "w", encoding="utf-8") as f:
    f.write(out)
print("pages:", len(PAGES), "statements:", len(lines))
