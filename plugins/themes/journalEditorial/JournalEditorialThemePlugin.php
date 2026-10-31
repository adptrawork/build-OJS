<?php
/**
 * @file plugins/themes/journalEditorial/JournalEditorialThemePlugin.php
 *
 * @class JournalEditorialThemePlugin
 *
 * @brief Child theme di atas Default Theme. Homepage modular ala JILP.
 */
namespace APP\plugins\themes\journalEditorial;

use APP\core\Application;
use APP\facades\Repo;
use APP\journal\Journal;
use Illuminate\Support\Facades\DB;
use PKP\facades\Locale;
use PKP\plugins\Hook;
use PKP\submission\PKPSubmission;
use PKP\plugins\ThemePlugin;

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
        $this->addStyle('journalEditorial', 'styles/journalEditorial.css');
        $this->addScript('journalEditorial-homepage', 'js/journalEditorial.js');
        Hook::add('TemplateManager::display', [$this, 'assignHomepageData']);
        $this->addMenuArea(['primary', 'user']);
    }

    public function assignHomepageData(string $hookName, array $args): bool
    {
        if ($args[1] !== 'frontend/pages/indexJournal.tpl') {
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

        // Statistik jurnal
        $totalArticles = Repo::submission()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByStatus([PKPSubmission::STATUS_PUBLISHED])
            ->getCount();

        $totalIssues = Repo::issue()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->getCount();

        $templateMgr->assign('jeStats', (object) [
            'articles' => $totalArticles,
            'issues' => $totalIssues,
        ]);

        // Artikel terbaru (6 publikasi terakhir)
        $published = Repo::submission()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByStatus([PKPSubmission::STATUS_PUBLISHED])
            ->limit(6)
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
            $articles[] = (object) [
                'id' => $submission->getId(),
                'title' => $publication->getLocalizedTitle(),
                'date' => $publication->getData('datePublished'),
                'authors' => implode(', ', $authors),
                'abstract' => $publication->getLocalizedData('abstract'),
            ];
        }
        $templateMgr->assign('jeLatestArticles', $articles);

        // Custom settings
        $custom = $this->fetchCustomSettings($contextId, $locale);
        $templateMgr->assign([
            'jeIndexers' => $custom['jeIndexers'] ?? null,
            'jeFocusScope' => $custom['jeFocusScope'] ?? null,
            'jeEditorialTeam' => $custom['jeEditorialTeam'] ?? null,
            'jeContactUrl' => $custom['jeContactUrl'] ?? null,
        ]);

        return false;
    }

    private function fetchCustomSettings(int $contextId, string $locale): array
    {
        $rows = DB::table('journal_settings')
            ->where('journal_id', $contextId)
            ->whereIn('setting_name', ['jeIndexers', 'jeFocusScope', 'jeEditorialTeam', 'jeContactUrl'])
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
