-- Update JRDC journal settings for AI SEO.
-- Run with: ddev mysql < scripts/seed-ai-seo-journal-settings.sql

-- Professional EN/ID descriptions.
UPDATE journal_settings
SET setting_value = 'Jurnal Ratu Dirgantara Cendikiawan (JRDC) is a peer-reviewed, open-access academic journal publishing original research, systematic reviews, and case studies in economics, business, management, finance, and related social sciences. JRDC serves scholars, practitioners, and policymakers seeking evidence-based insights into emerging economic and business phenomena.'
WHERE journal_id = 1 AND setting_name = 'description' AND locale = 'en';

UPDATE journal_settings
SET setting_value = 'Jurnal Ratu Dirgantara Cendikiawan (JRDC) adalah jurnal ilmiah akses terbuka yang telah melalui telaah sejawat (peer-reviewed), menerbitkan penelitian orisinal, tinjauan sistematis, dan studi kasus di bidang ekonomi, bisnis, manajemen, keuangan, serta ilmu sosial terkait. JRDC menjadi wadah bagi akademisi, praktisi, dan pembuat kebijakan yang membutuhkan wawasan berbasis bukti tentang fenomena ekonomi dan bisnis terkini.'
WHERE journal_id = 1 AND setting_name = 'description' AND locale = 'id';

-- Publisher name used in JSON-LD Organization markup.
UPDATE journal_settings
SET setting_value = 'Yayasan Ratu Dirgantara Cendikiawan'
WHERE journal_id = 1 AND setting_name = 'publisherInstitution' AND locale = '';

-- Ensure ISSNs are present (idempotent).
INSERT INTO journal_settings (journal_id, setting_name, locale, setting_value)
VALUES (1, 'printIssn', '', '2807-1234')
ON DUPLICATE KEY UPDATE setting_value = '2807-1234';

INSERT INTO journal_settings (journal_id, setting_name, locale, setting_value)
VALUES (1, 'onlineIssn', '', '2807-5678')
ON DUPLICATE KEY UPDATE setting_value = '2807-5678';
