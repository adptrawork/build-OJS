-- Seed konten jurnal (tentang, kontak, kebijakan section) agar halaman
-- /about, /about/contact, /about/submissions tidak kosong.
-- Idempotent: REPLACE per setting.
--
-- Catatan: setting yang tidak `multilingual` di schemas/context.json
-- (contact*, support*, mailingAddress, ISSN) HARUS disimpan dengan locale '',
-- kalau disimpan per-locale getData() mengembalikan array dan template fatal.

DELETE FROM journal_settings
WHERE journal_id = 1 AND locale <> '' AND setting_name IN (
  'contactName', 'contactTitle', 'contactAffiliation', 'contactEmail', 'contactPhone',
  'supportName', 'supportEmail', 'supportPhone', 'mailingAddress',
  'publisherInstitution', 'printIssn', 'onlineIssn'
);

REPLACE INTO journal_settings (journal_id, locale, setting_name, setting_value)
VALUES
  (1, 'en', 'about', '<h2>About the Journal</h2><p><strong>AKDISI</strong> is a peer-reviewed, open-access journal publishing original research on Islamic economics, finance, banking, and management. The journal bridges academic work and industry practice for a digital-first economy.</p><h3>Focus and Scope</h3><p>We publish empirical and theoretical studies on Islamic finance, sharia compliance, halal business, and the digital transformation of financial institutions. Submissions must offer a clear contribution to theory or practice.</p><h3>Peer Review</h3><p>Every manuscript is double-blind reviewed by at least two reviewers. Decisions are issued within 4-6 weeks of submission.</p><h3>Open Access</h3><p>All content is published under a Creative Commons Attribution 4.0 licence, with no fees for authors or readers.</p>'),
  (1, 'id', 'about', '<h2>Tentang Jurnal</h2><p><strong>AKDISI</strong> adalah jurnal akses terbuka dengan telaah sejawat yang menerbitkan penelitian orisinal di bidang ekonomi, keuangan, perbankan, dan manajemen Islam. Jurnal ini menghubungkan karya akademik dengan praktik industri pada ekonomi digital.</p><h3>Fokus dan Cakupan</h3><p>Kami menerbitkan kajian empiris dan teoretis tentang keuangan Islam, kepatuhan syariah, bisnis halal, dan transformasi digital lembaga keuangan. Naskah harus memberi kontribusi yang jelas bagi teori atau praktik.</p><h3>Telaah Sejawat</h3><p>Setiap naskah ditelaah secara buta ganda oleh minimal dua reviewer. Keputusan diterbitkan dalam 4-6 pekan setelah penyerahan.</p><h3>Akses Terbuka</h3><p>Seluruh konten diterbitkan dengan lisensi Creative Commons Attribution 4.0, tanpa biaya untuk penulis maupun pembaca.</p>'),

  (1, '', 'contactName', 'Dr. Ahmad Fauzi'),
  (1, '', 'contactTitle', 'Editor-in-Chief'),
  (1, '', 'contactAffiliation', 'Akdisi editorial office'),
  (1, '', 'contactEmail', 'editor@akdisi.my.id'),
  (1, '', 'contactPhone', '+62 812 3456 7890'),
  (1, '', 'mailingAddress', 'Jl. Pendidikan No. 12\nBantul, Yogyakarta 55711\nIndonesia'),
  (1, '', 'supportName', 'Akdisi technical support'),
  (1, '', 'supportEmail', 'support@akdisi.my.id'),

  (1, '', 'publisherInstitution', 'Akdisi Publishing House'),
  (1, '', 'printIssn', '2807-1234'),
  (1, '', 'onlineIssn', '2807-5678');

REPLACE INTO section_settings (section_id, locale, setting_name, setting_value)
VALUES
  (1, 'en', 'title', 'Articles'),
  (1, 'id', 'title', 'Artikel'),
  (1, 'en', 'policy', 'Articles in this section are original research papers that have passed double-blind peer review.'),
  (1, 'id', 'policy', 'Artikel pada bagian ini merupakan hasil penelitian orisinal yang telah melewati telaah sejawat buta ganda.');
