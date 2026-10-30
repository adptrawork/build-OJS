-- Static pages untuk JEKI (context_id=1).
-- Jalankan dengan: ddev mysql -uroot -proot db < scripts/static-pages.sql

INSERT INTO static_pages (path, context_id) VALUES
('focus-and-scope', 1),
('editorial-team', 1),
('reviewer', 1),
('reviewer-guide', 1),
('publication-ethics', 1),
('peer-review-process', 1),
('open-access-statement', 1),
('copyright-and-license', 1),
('plagiarism-policy', 1),
('indexing', 1),
('author-guidelines', 1),
('archive-policy', 1),
('author-fees', 1),
('contact-us', 1),
('generative-ai', 1),
('privacy-policy', 1),
('submission-preparation', 1),
('loa', 1),
('faq', 1),
('about', 1);

-- Title & content placeholder untuk locale 'en' dan 'id'.
-- Content akan diisi lewat admin UI; ini hanya skeleton agar menu bisa dibangun.
SET @en_title = 'en';
SET @id_title = 'id';
SET @en_content = 'en';
SET @id_content = 'id';

INSERT INTO static_page_settings (static_page_id, locale, setting_name, setting_value, setting_type)
SELECT static_page_id, 'en', 'title', CONCAT(UCASE(REPLACE(path, '-', ' ')), ' (en)'), 'string' FROM static_pages WHERE context_id = 1
UNION ALL
SELECT static_page_id, 'id', 'title', CONCAT(UCASE(REPLACE(path, '-', ' ')), ' (id)'), 'string' FROM static_pages WHERE context_id = 1
UNION ALL
SELECT static_page_id, 'en', 'content', CONCAT('<p>This is the placeholder content for ', path, '. Please edit via Website Settings &gt; Static Pages.</p>'), 'string' FROM static_pages WHERE context_id = 1
UNION ALL
SELECT static_page_id, 'id', 'content', CONCAT('<p>Ini konten placeholder untuk ', path, '. Silakan edit melalui Website Settings &gt; Static Pages.</p>'), 'string' FROM static_pages WHERE context_id = 1;
