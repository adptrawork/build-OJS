<?php

/**
 * @file plugins/themes/akdisi/AkdisiThemePlugin.php
 *
 * @class AkdisiThemePlugin
 *
 * @brief Child theme di atas theme "default". Semua override template ada di
 *   templates/, semua token desain ada di styles/akdisi.css.
 */

namespace APP\plugins\themes\akdisi;

use APP\core\Application;
use APP\facades\Repo;
use APP\issue\Issue;
use APP\journal\Journal;
use Illuminate\Support\Facades\DB;
use PKP\facades\Locale;
use PKP\plugins\Hook;
use PKP\submission\Collector as SubmissionCollector;
use PKP\submission\PKPSubmission;
use PKP\plugins\ThemePlugin;

class AkdisiThemePlugin extends ThemePlugin
{
    public function getDisplayName()
    {
        return __('plugins.themes.akdisi.name');
    }

    public function getDescription()
    {
        return __('plugins.themes.akdisi.description');
    }

    public function init()
    {
        error_log('AKDISI THEME: init called');
        $this->setParent('default');
        $this->addStyle('akdisi', 'styles/akdisi.css');
        $this->addScript('akdisi-slots', 'js/slots.js');
        Hook::add('TemplateManager::display', [$this, 'assignHomepageData']);
    }

    /**
     * Isi variabel template untuk seluruh block beranda.
     */
    public function assignHomepageData(string $hookName, array $args): void
    {
        if ($args[1] !== 'frontend/pages/indexJournal.tpl') {
            return;
        }
        $templateMgr = $args[0];
        $request = Application::get()->getRequest();
        $context = $request->getContext();
        if (!$context instanceof Journal) {
            return;
        }

        $contextId = $context->getId();
        $locale = Locale::getLocale();

        // Baca custom settings sekali untuk semua block (S-HOME-06/09/10/11/12).
        // SchemaDAO hanya memuat setting yang terdaftar di schema; custom key
        // seperti akdisiIndexers harus dibaca langsung dari tabel settings.
        $custom = $this->fetchCustomSettings($contextId, $locale);

        // S-HOME-07: artikel terbaru (6 publikasi terakhir).
        $templateMgr->assign('akdisiLatestArticles', $this->fetchLatestArticles($contextId));

        // S-HOME-12: statistik jurnal.
        $templateMgr->assign('akdisiStats', $this->fetchStats($contextId, $custom['akdisiStats'] ?? null));

        // S-HOME-06/09/10/11: konten custom block.
        $templateMgr->assign([
            'akdisiIndexers' => $custom['akdisiIndexers'] ?? null,
            'akdisiFocusScope' => $custom['akdisiFocusScope'] ?? null,
            'akdisiEditorialTeam' => $custom['akdisiEditorialTeam'] ?? null,
            'akdisiTemplateFile' => $custom['akdisiTemplateFile'] ?? null,
            'akdisiContactUrl' => $custom['akdisiContactUrl'] ?? null,
        ]);
    }

    /**
     * Baca custom settings dari journal_settings untuk key akdisi*.
     */
    private function fetchCustomSettings(int $contextId, string $locale): array
    {
        $rows = DB::table('journal_settings')
            ->where('journal_id', $contextId)
            ->whereIn('setting_name', ['akdisiIndexers', 'akdisiFocusScope', 'akdisiEditorialTeam', 'akdisiTemplateFile', 'akdisiStats', 'akdisiContactUrl'])
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

    /**
     * Ambil 6 artikel terbit terbaru dengan metadata ringan.
     */
    private function fetchLatestArticles(int $contextId): array
    {
        $published = Repo::submission()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByStatus([PKPSubmission::STATUS_PUBLISHED])
            ->limit(6)
            ->orderBy(SubmissionCollector::ORDERBY_DATE_PUBLISHED, SubmissionCollector::ORDER_DIR_DESC)
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

            $section = null;
            try {
                $section = Repo::section()->get($publication->getData('sectionId'))?->getLocalizedTitle();
            } catch (\Throwable $e) {
                // ponytail: abaikan section bila API berbeda; tampilkan tanpa section.
            }

            $articles[] = (object) [
                'id' => $submission->getId(),
                'title' => $publication->getLocalizedTitle(),
                'date' => $publication->getData('datePublished'),
                'authors' => implode(', ', $authors),
                'section' => $section,
            ];
        }
        return $articles;
    }

    /**
     * Hitung statistik dasar jurnal dari database.
     * Avg review days & acceptance rate belum dihitung otomatis karena butuh
     * audit log editorial; disediakan field supaya bisa diisi manual lewat
     * journal setting `akdisiStats`.
     */
    private function fetchStats(int $contextId, ?string $manualJson): object
    {
        $totalArticles = Repo::submission()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByStatus([PKPSubmission::STATUS_PUBLISHED])
            ->getCount();

        $totalIssues = Repo::issue()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->getCount();

        $manual = [];
        if ($manualJson && is_string($manualJson)) {
            $manual = json_decode($manualJson, true) ?: [];
        }

        return (object) [
            'articles' => $totalArticles,
            'issues' => $totalIssues,
            'avgReviewDays' => $manual['avgReviewDays'] ?? 0,
            'acceptanceRate' => $manual['acceptanceRate'] ?? 0,
        ];
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\akdisi\AkdisiThemePlugin', '\AkdisiThemePlugin');
}
