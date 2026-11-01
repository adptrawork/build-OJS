-- Update OJS default privacyStatement setting so /about/privacy displays the full policy.
-- Aligned with COPE / data-protection good practice.

INSERT INTO journal_settings (journal_id, locale, setting_name, setting_value)
VALUES (
  1,
  'en',
  'privacyStatement',
  '<h2>Privacy Policy</h2>
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
<p>For privacy-related questions, please email <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>'
)
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value);

INSERT INTO journal_settings (journal_id, locale, setting_name, setting_value)
VALUES (
  1,
  'id',
  'privacyStatement',
  '<h2>Kebijakan Privasi</h2>
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
<p>Untuk pertanyaan terkait privasi, silakan email <a href="mailto:editor@jrdc.my.id">editor@jrdc.my.id</a>.</p>'
)
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value);
