-- Seed pengumuman agar halaman /announcement dan menu Announcements tersedia.
-- Idempotent: hapus pengumuman context 1 lalu buat ulang.

DELETE FROM announcement_settings
WHERE announcement_id IN (
  SELECT announcement_id FROM announcements
  WHERE assoc_type = 256 AND assoc_id = 1
);

DELETE FROM announcements
WHERE assoc_type = 256 AND assoc_id = 1;

REPLACE INTO journal_settings (journal_id, locale, setting_name, setting_value)
VALUES
  (1, '', 'enableAnnouncements', '1'),
  (1, 'en', 'announcementsIntroduction', 'Latest news, calls for papers, and announcements from the journal.'),
  (1, 'id', 'announcementsIntroduction', 'Berita terbaru, panggilan naskah, dan pengumuman dari jurnal.');

INSERT INTO announcements (announcement_id, assoc_type, assoc_id, date_posted, date_expire) VALUES
  (1, 256, 1, '2026-10-01 08:00:00', NULL),
  (2, 256, 1, '2026-10-20 08:00:00', NULL);

INSERT INTO announcement_settings (announcement_id, locale, setting_name, setting_value) VALUES
  (1, 'en', 'title', 'Call for Papers: Volume 2 Number 1 (2027)'),
  (1, 'en', 'descriptionShort', 'We invite researchers to submit original manuscripts in Islamic economics, finance, and management for the upcoming issue.'),
  (1, 'en', 'description', 'We invite researchers to submit original manuscripts in Islamic economics, finance, and management for the upcoming issue.'),
  (1, 'id', 'descriptionShort', 'Kami mengundang para peneliti untuk mengirimkan naskah orisinal di bidang ekonomi, keuangan, dan manajemen Islam untuk terbitan berikutnya.'),
  (1, 'id', 'title', 'Panggilan Naskah: Volume 2 Nomor 1 (2027)'),
  (1, 'id', 'description', 'Kami mengundang para peneliti untuk mengirimkan naskah orisinal di bidang ekonomi, keuangan, dan manajemen Islam untuk terbitan berikutnya.'),
  (2, 'en', 'title', 'Submission System Maintenance'),
  (2, 'en', 'descriptionShort', 'The submission portal will undergo routine maintenance this weekend. Submissions remain open.'),
  (2, 'en', 'description', 'The submission portal will undergo routine maintenance this weekend. Submissions remain open.'),
  (2, 'id', 'descriptionShort', 'Portal pengiriman akan menjalani pemeliharaan rutin akhir pekan ini. Pengiriman naskah tetap terbuka.'),
  (2, 'id', 'title', 'Pemeliharaan Sistem Pengiriman'),
  (2, 'id', 'description', 'Portal pengiriman akan menjalani pemeliharaan rutin akhir pekan ini. Pengiriman naskah tetap terbuka.');
