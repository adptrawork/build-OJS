-- Fix hardcoded domains/brands in DB content (DO NOT RUN automatically; review first).
-- Safe to run on the OJS database (db). Idempotent string replacements.

-- 1. Journal contact/support emails (non-multilingual -> locale '')
UPDATE journal_settings
SET setting_value = 'editor@jrdc.my.id'
WHERE journal_id = 1 AND setting_name = 'contactEmail';

UPDATE journal_settings
SET setting_value = 'support@jrdc.my.id'
WHERE journal_id = 1 AND setting_name = 'supportEmail';

-- 2. Template file URL
UPDATE journal_settings
SET setting_value = '/downloads/jrdc-template.docx'
WHERE journal_id = 1 AND setting_name = 'akdisiTemplateFile';

-- 3. Replace legacy brand "AKDISI" with "JRDC" in journal about text
UPDATE journal_settings
SET setting_value = REPLACE(setting_value, 'AKDISI', 'JRDC')
WHERE journal_id = 1 AND setting_name = 'about';

-- 4. Replace legacy brand in custom block settings
UPDATE journal_settings
SET setting_value = REPLACE(setting_value, 'AKDISI', 'JRDC')
WHERE journal_id = 1 AND setting_name IN ('akdisiFocusScope','akdisiEditorialTeam');

-- 5. Replace legacy domain in any journal setting value
UPDATE journal_settings
SET setting_value = REPLACE(setting_value, 'akdisi.my.id', 'jrdc.my.id')
WHERE journal_id = 1;

-- 6. Static page content: replace brand/domain
UPDATE static_page_settings
SET setting_value = REPLACE(REPLACE(setting_value, 'AKDISI', 'JRDC'), 'akdisi.my.id', 'jrdc.my.id')
WHERE 1=1;

-- 7. Optional: rename journal path AKDISI -> JRDC (only if you want URL path change)
-- UPDATE journals SET path = 'JRDC', url_path = 'JRDC' WHERE journal_id = 1;
-- UPDATE journal_settings SET setting_value = REPLACE(setting_value, '/index.php/AKDISI/', '/index.php/JRDC/') WHERE setting_value LIKE '%/index.php/AKDISI/%';
