<?php
/**
 * @file plugins/themes/journalEditorial/JournalEditorialThemePlugin.php
 *
 * @class JournalEditorialThemePlugin
 *
 * @brief JILP-inspired editorial theme (Bootstrap 5) for OJS 3.3.
 */

import('lib.pkp.classes.plugins.ThemePlugin');

class JournalEditorialThemePlugin extends ThemePlugin
{
    public function getDisplayName()
    {
        return __('plugins.themes.journalEditorial.name');
    }

    public function getDescription()
    {
        return __('plugins.themes.journalEditorial.description');
    }

    public function init()
    {
        $this->setParent('defaultthemeplugin');

        // Bootstrap first, then the theme override.
        $this->addStyle('bootstrap', 'styles/bootstrap.min.css', ['priority' => -10]);
        $this->addStyle('bootstrap-icons', 'styles/bootstrap-icons.min.css', ['priority' => -9]);
        // Theme CSS gets a filemtime cache-buster: OJS only appends the app
        // version, so browser caches would otherwise keep old theme CSS.
        $themeCss = $this->_getBaseDir('styles/journalEditorial.css');
        $themeCssVersion = is_file($themeCss) ? (string) filemtime($themeCss) : '0';
        $this->addStyle('journalEditorial', 'styles/journalEditorial.css?v=' . $themeCssVersion, ['priority' => 10]);

        $this->addScript('bootstrap', 'js/bootstrap.bundle.min.js', ['priority' => -10]);
        $this->addScript('journalEditorial-homepage', 'js/journalEditorial.js', ['priority' => 10]);

        HookRegistry::register('TemplateManager::display', [$this, 'assignHomepageData']);
        $this->addMenuArea(['primary', 'user']);
    }

    public function assignHomepageData($hookName, $args)
    {
        if (($args[1] ?? null) !== 'frontend/pages/indexJournal.tpl') {
            return false;
        }

        $templateMgr = $args[0];
        $request = Application::get()->getRequest();
        $context = $request->getContext();
        if (!$context) {
            return false;
        }

        $contextId = $context->getId();
        $locale = AppLocale::getLocale();

        $issueDao = DAORegistry::getDAO('IssueDAO');

        // Ensure the current issue is available for the homepage section.
        // OJS assigns $issue only when a current issue is configured; fall back
        // to the latest published issue so the slot never stays empty.
        $issue = $templateMgr->getTemplateVars('issue');
        if (!$issue) {
            $issue = $issueDao->getCurrent($contextId, true);
        }
        if (!$issue) {
            $latest = $issueDao->getPublishedIssues($contextId, new DBResultRange(1, 1));
            $issue = $latest->next();
        }
        if ($issue) {
            $templateMgr->assign('issue', $issue);
        }

        $templateMgr->assign('jilpArticles', $this->getArticles($contextId, $locale, 9));
        $templateMgr->assign('jilpIssues', $this->getIssues($contextId, $locale, 6));
        $templateMgr->assign('jilpStats', $this->getStats($contextId));
        $announcements = DAORegistry::getDAO('AnnouncementDAO')->getAnnouncementsNotExpiredByAssocId(
            ASSOC_TYPE_JOURNAL,
            $contextId,
            new DBResultRange(3, 1)
        );
        $templateMgr->assign('announcements', $announcements->toArray());

        $acronym = preg_replace('/[^A-Za-z]/', '', $context->getLocalizedName());
        $acronym = strtoupper(substr($acronym, 0, 4));
        if (strlen($acronym) < 4) {
            $acronym = str_pad($acronym ?: 'J', 4, $acronym ?: 'J');
        }
        $templateMgr->assign('jilpAcronym', $acronym);
        $templateMgr->assign('jilpLetters', str_split($acronym));

        $custom = $this->fetchCustomSettings($contextId, $locale);
        $templateMgr->assign([
            'jilpIndexers' => $this->parseIndexers($custom['jilpIndexers'] ?? ($custom['akdisiIndexers'] ?? null)),
            'jilpFocusScope' => $custom['jilpFocusScope'] ?? ($custom['akdisiFocusScope'] ?? null),
            'jilpEditorialTeam' => $custom['jilpEditorialTeam'] ?? ($custom['akdisiEditorialTeam'] ?? null),
            'jilpContactUrl' => $custom['jilpContactUrl'] ?? ($custom['akdisiContactUrl'] ?? null),
            'jilpAbout' => $context->getLocalizedData('about'),
        ]);

        return false;
    }

    private function getArticles($contextId, $locale, $limit)
    {
        $submissionDao = DAORegistry::getDAO('SubmissionDAO');
        $issueDao = DAORegistry::getDAO('IssueDAO');
        $sectionDao = DAORegistry::getDAO('SectionDAO');

        $published = $submissionDao->getExportable(
            $contextId,
            null,
            null,
            null,
            null,
            null,
            null,
            new DBResultRange($limit, 1)
        );

        $articles = [];
        while ($submission = $published->next()) {
            $publication = $submission->getCurrentPublication();
            if (!$publication) {
                continue;
            }

            $authors = [];
            foreach (($publication->getData('authors') ?: []) as $author) {
                $authors[] = $author->getFullName(false);
            }

            $issueId = $publication->getData('issueId');
            $issue = $issueId ? $issueDao->getById($issueId, $contextId) : null;

            $sectionId = $publication->getData('sectionId');
            $section = $sectionId ? $sectionDao->getById($sectionId, $contextId) : null;

            $start = $publication->getStartingPage();
            $end = $publication->getEndingPage();
            $pages = $start ? ($end && $end !== $start ? $start . '-' . $end : $start) : '';

            $articles[] = (object) [
                'id' => $submission->getId(),
                'title' => $publication->getLocalizedTitle($locale),
                'authors' => implode(', ', $authors),
                'abstract' => $publication->getLocalizedData('abstract', $locale),
                'date' => $publication->getData('datePublished'),
                'pages' => $pages,
                'doi' => $publication->getStoredPubId('doi'),
                'issueId' => $issueId,
                'issueTitle' => $issue ? $issue->getIssueIdentification() : '',
                'section' => $section ? $section->getLocalizedTitle() : '',
            ];
        }

        return $articles;
    }

    private function getIssues($contextId, $locale, $limit)
    {
        $issueDao = DAORegistry::getDAO('IssueDAO');
        $collection = $issueDao->getPublishedIssues($contextId, new DBResultRange($limit, 1));

        $issues = [];
        while ($issue = $collection->next()) {
            $issues[] = (object) [
                'id' => $issue->getId(),
                'title' => $issue->getIssueIdentification(),
                'date' => $issue->getDatePublished(),
                'cover' => $issue->getLocalizedCoverImageUrl(),
                'volume' => $issue->getVolume(),
                'number' => $issue->getNumber(),
                'year' => $issue->getYear(),
            ];
        }

        return $issues;
    }

    private function getStats($contextId)
    {
        $submissionDao = DAORegistry::getDAO('SubmissionDAO');
        $issueDao = DAORegistry::getDAO('IssueDAO');

        $articles = (int) $submissionDao->countRecords(
            'SELECT submission_id FROM submissions WHERE context_id = ? AND status = ?',
            [$contextId, STATUS_PUBLISHED]
        );

        $issues = (int) $issueDao->countRecords(
            'SELECT issue_id FROM issues WHERE journal_id = ? AND published = 1',
            [$contextId]
        );

        $authors = (int) $submissionDao->countRecords(
            'SELECT DISTINCT au.author_id
             FROM authors au
             JOIN publications p ON p.publication_id = au.publication_id
             JOIN submissions s ON s.submission_id = p.submission_id
             WHERE s.context_id = ? AND s.status = ?',
            [$contextId, STATUS_PUBLISHED]
        );

        $reviewers = (int) $submissionDao->countRecords(
            'SELECT DISTINCT uug.user_id
             FROM user_user_groups uug
             JOIN user_groups ug ON ug.user_group_id = uug.user_group_id
             WHERE ug.context_id = ? AND ug.role_id = ?',
            [$contextId, ROLE_ID_REVIEWER]
        );

        return (object) [
            'articles' => $articles,
            'issues' => $issues,
            'authors' => $authors,
            'reviewers' => $reviewers,
        ];
    }

    private function parseIndexers($value)
    {
        $default = ['SINTA', 'Garuda', 'Crossref', 'Google Scholar', 'DOAJ', 'BASE', 'Dimensions', 'OpenAIRE', 'Scilit', 'WorldCat', 'Neliti', 'Moraref'];
        if (is_array($value)) {
            return array_values(array_filter($value));
        }
        if (!$value || !is_string($value)) {
            return $default;
        }
        $decoded = json_decode($value, true);
        if (is_array($decoded)) {
            return array_values(array_filter($decoded));
        }
        // If the value looks like HTML (legacy rich indexers), strip tags and split.
        if (strip_tags($value) !== $value) {
            $text = strip_tags($value);
            return array_values(array_filter(array_map('trim', preg_split('/[\n,]+/', $text))));
        }
        return array_values(array_filter(array_map('trim', explode(',', $value))));
    }

    private function fetchCustomSettings($contextId, $locale)
    {
        $rows = DAORegistry::getDAO('JournalSettingsDAO')->getSettings($contextId);
        $settings = [];
        foreach (['jilpIndexers', 'jilpFocusScope', 'jilpEditorialTeam', 'jilpContactUrl', 'akdisiIndexers', 'akdisiFocusScope', 'akdisiEditorialTeam', 'akdisiContactUrl'] as $name) {
            if (!isset($rows[$name])) {
                continue;
            }
            $value = $rows[$name];
            if (is_array($value)) {
                $value = $value[$locale] ?? reset($value);
            }
            $settings[$name] = $value;
        }
        return $settings;
    }
}
