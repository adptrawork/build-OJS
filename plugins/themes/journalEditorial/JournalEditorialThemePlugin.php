<?php
/**
 * @file plugins/themes/journalEditorial/JournalEditorialThemePlugin.php
 *
 * @class JournalEditorialThemePlugin
 *
 * @brief JILP-inspired editorial theme (Bootstrap 5) for OJS 3.5.
 */
namespace APP\plugins\themes\journalEditorial;

use APP\core\Application;
use APP\facades\Repo;
use APP\journal\Journal;
use Illuminate\Support\Facades\DB;
use PKP\facades\Locale;
use PKP\plugins\Hook;
use PKP\plugins\ThemePlugin;
use PKP\security\Role;
use PKP\submission\PKPSubmission;

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
        $this->addStyle('journalEditorial', 'styles/journalEditorial.css', ['priority' => 10]);

        $this->addScript('bootstrap', 'js/bootstrap.bundle.min.js', ['priority' => -10]);
        $this->addScript('journalEditorial-homepage', 'js/journalEditorial.js', ['priority' => 10]);

        Hook::add('TemplateManager::display', [$this, 'assignHomepageData']);
        $this->addMenuArea(['primary', 'user']);
    }

    public function assignHomepageData(string $hookName, array $args): bool
    {
        if (($args[1] ?? null) !== 'frontend/pages/indexJournal.tpl') {
            return false;
        }

        $templateMgr = $args[0];
        $request = Application::get()->getRequest();
        $context = $request->getContext();
        if (!$context instanceof Journal) {
            return false;
        }

        $contextId = $context->getId();
        $locale = Locale::getLocale();

        $templateMgr->assign('jilpArticles', $this->getArticles($contextId, $locale, 9));
        $templateMgr->assign('jilpIssues', $this->getIssues($contextId, $locale, 6));
        $templateMgr->assign('jilpStats', $this->getStats($contextId));
        $templateMgr->assign(
            'announcements',
            \PKP\announcement\Announcement::withContextIds([$contextId])
                ->withActiveByDate()
                ->orderBy(\PKP\announcement\Announcement::CREATED_AT, 'desc')
                ->limit(3)
                ->get()
        );

        $acronym = preg_replace('/[^A-Za-z]/', '', $context->getLocalizedName());
        $acronym = strtoupper(substr($acronym, 0, 4));
        if (strlen($acronym) < 4) {
            $acronym = str_pad($acronym ?: 'J', 4, $acronym ?: 'J');
        }
        $templateMgr->assign('jilpAcronym', $acronym);
        $templateMgr->assign('jilpLetters', str_split($acronym));

        $custom = $this->fetchCustomSettings($contextId, $locale);
        $templateMgr->assign([
            'jilpIndexers' => $this->parseIndexers($custom['jilpIndexers'] ?? $context->getLocalizedData('akdisiIndexers')),
            'jilpFocusScope' => $custom['jilpFocusScope'] ?? $context->getLocalizedData('akdisiFocusScope'),
            'jilpEditorialTeam' => $custom['jilpEditorialTeam'] ?? $context->getLocalizedData('akdisiEditorialTeam'),
            'jilpContactUrl' => $custom['jilpContactUrl'] ?? $context->getLocalizedData('akdisiContactUrl'),
            'jilpAbout' => $context->getLocalizedData('about'),
        ]);

        return false;
    }

    private function getArticles(int $contextId, string $locale, int $limit): array
    {
        $published = Repo::submission()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByStatus([PKPSubmission::STATUS_PUBLISHED])
            ->limit($limit)
            ->orderBy(\PKP\submission\Collector::ORDERBY_DATE_PUBLISHED, \PKP\submission\Collector::ORDER_DIR_DESC)
            ->getMany();

        $articles = [];
        foreach ($published as $submission) {
            $publication = $submission->getCurrentPublication();
            if (!$publication) {
                continue;
            }

            $authors = [];
            foreach (($publication->getData('authors') ?: []) as $author) {
                $authors[] = $author->getFullName(false);
            }

            $issue = null;
            $issueId = $publication->getIssueId();
            if ($issueId) {
                $issue = Repo::issue()->get($issueId, $contextId);
            }

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
                'section' => $this->getSectionTitle($publication->getData('sectionId'), $contextId),
            ];
        }

        return $articles;
    }

    private function getIssues(int $contextId, string $locale, int $limit): array
    {
        $issues = [];
        $collection = Repo::issue()->getCollector()
            ->filterByContextIds([$contextId])
            ->limit($limit)
            ->orderBy(\APP\issue\Collector::ORDERBY_DATE_PUBLISHED, \APP\issue\Collector::ORDER_DIR_DESC)
            ->getMany();

        foreach ($collection as $issue) {
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

    private function getStats(int $contextId): object
    {
        $articles = Repo::submission()->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByStatus([PKPSubmission::STATUS_PUBLISHED])
            ->getCount();

        $issues = Repo::issue()->getCollector()
            ->filterByContextIds([$contextId])
            ->getCount();

        $authorNames = [];
        foreach (Repo::submission()->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByStatus([PKPSubmission::STATUS_PUBLISHED])
            ->getMany() as $submission) {
            foreach (($submission->getCurrentPublication()?->getData('authors') ?: []) as $author) {
                $authorNames[$author->getFullName(false)] = true;
            }
        }
        $authors = count($authorNames);

        $reviewers = Repo::user()->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByRoleIds([Role::ROLE_ID_REVIEWER])
            ->getCount();

        return (object) [
            'articles' => $articles,
            'issues' => $issues,
            'authors' => $authors,
            'reviewers' => $reviewers,
        ];
    }

    private function getSectionTitle(?int $sectionId, int $contextId): string
    {
        if (!$sectionId) {
            return '';
        }
        $section = Repo::section()->get($sectionId, $contextId);
        return $section ? $section->getLocalizedTitle() : '';
    }

    private function parseIndexers($value): array
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

    private function fetchCustomSettings(int $contextId, string $locale): array
    {
        $rows = DB::table('journal_settings')
            ->where('journal_id', $contextId)
            ->whereIn('setting_name', ['jilpIndexers', 'jilpFocusScope', 'jilpEditorialTeam', 'jilpContactUrl'])
            ->get(['setting_name', 'locale', 'setting_value']);

        $settings = [];
        foreach ($rows as $row) {
            $name = $row->setting_name;
            if (!isset($settings[$name]) || $row->locale === $locale) {
                $settings[$name] = $row->setting_value;
            }
        }

        return $settings;
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\journalEditorial\JournalEditorialThemePlugin', '\JournalEditorialThemePlugin');
}
