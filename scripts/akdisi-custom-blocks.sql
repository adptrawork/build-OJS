-- Isi custom blocks AKDISI lewat journal_settings (context_id=1).
-- Jalankan dengan: ddev mysql -uroot -proot db < scripts/akdisi-custom-blocks.sql

DELETE FROM journal_settings WHERE journal_id=1 AND setting_name IN ('akdisiIndexers','akdisiFocusScope','akdisiEditorialTeam','akdisiTemplateFile','akdisiStats','akdisiContactUrl');

INSERT INTO journal_settings (journal_id, locale, setting_name, setting_value) VALUES
(1, 'en', 'akdisiIndexers', '<a href="#">Google Scholar</a><a href="#">DOAJ</a><a href="#">SINTA</a><a href="#">Crossref</a>'),
(1, 'id', 'akdisiIndexers', '<a href="#">Google Scholar</a><a href="#">DOAJ</a><a href="#">SINTA</a><a href="#">Crossref</a>'),
(1, 'en', 'akdisiFocusScope', '<p>AKDISI publishes empirical and theoretical research in economics, finance, and Islamic finance.</p>'),
(1, 'id', 'akdisiFocusScope', '<p>AKDISI menerbitkan penelitian empiris dan teoritis di bidang ekonomi, keuangan, dan keuangan syariah.</p>'),
(1, 'en', 'akdisiEditorialTeam', '<ul><li>Editor-in-Chief: Prof. Dr. Jane Smith</li><li>Managing Editor: Dr. John Doe</li></ul>'),
(1, 'id', 'akdisiEditorialTeam', '<ul><li>Penyunting Utama: Prof. Dr. Jane Smith</li><li>Penyunting Pelaksana: Dr. John Doe</li></ul>'),
(1, 'en', 'akdisiTemplateFile', '/downloads/akdisi-template.docx'),
(1, 'id', 'akdisiTemplateFile', '/downloads/akdisi-template.docx'),
(1, 'en', 'akdisiStats', '{"avgReviewDays":42,"acceptanceRate":28}'),
(1, 'id', 'akdisiStats', '{"avgReviewDays":42,"acceptanceRate":28}'),
(1, 'en', 'akdisiContactUrl', 'https://wa.me/6281234567890'),
(1, 'id', 'akdisiContactUrl', 'https://wa.me/6281234567890');
