<?php

/**
 * @file plugins/themes/akdisi/AkdisiThemePlugin.php
 *
 * @class AkdisiThemePlugin
 *
 * @brief Child theme di atas theme "default" untuk OJS 3.3. Semua override
 *   template ada di templates/, semua token desain ada di styles/akdisi.css.
 */

import('lib.pkp.classes.plugins.ThemePlugin');

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
        $this->setParent('defaultthemeplugin');
        $this->addStyle('akdisi', 'styles/akdisi.css');
        $this->addScript('akdisi-slots', 'js/slots.js');
        HookRegistry::register('TemplateManager::display', [$this, 'assignHomepageData']);
    }

    /**
     * Isi variabel template untuk seluruh block beranda.
     */
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

        // Baca custom settings langsung dari tabel settings: SchemaDAO hanya
        // memuat setting yang terdaftar di schema, key akdisi* tidak termasuk.
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
        return false;
    }

    /**
     * Baca custom settings dari journal_settings untuk key akdisi*.
     */
    private function fetchCustomSettings($contextId, $locale)
    {
        $rows = DAORegistry::getDAO('JournalSettingsDAO')->getSettings($contextId);
        $settings = [];
        foreach (['akdisiIndexers', 'akdisiFocusScope', 'akdisiEditorialTeam', 'akdisiTemplateFile', 'akdisiStats', 'akdisiContactUrl'] as $name) {
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

    /**
     * Ambil 6 artikel terbit terbaru dengan metadata ringan.
     */
    private function fetchLatestArticles($contextId)
    {
        $submissionDao = DAORegistry::getDAO('SubmissionDAO');
        $sectionDao = DAORegistry::getDAO('SectionDAO');

        $published = $submissionDao->getExportable(
            $contextId,
            null,
            null,
            null,
            null,
            null,
            null,
            new DBResultRange(6, 1)
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

            $sectionId = $publication->getData('sectionId');
            $section = $sectionId ? $sectionDao->getById($sectionId, $contextId) : null;

            $articles[] = (object) [
                'id' => $submission->getId(),
                'title' => $publication->getLocalizedTitle(),
                'date' => $publication->getData('datePublished'),
                'authors' => implode(', ', $authors),
                'section' => $section ? $section->getLocalizedTitle() : null,
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
    private function fetchStats($contextId, $manualJson)
    {
        $submissionDao = DAORegistry::getDAO('SubmissionDAO');
        $issueDao = DAORegistry::getDAO('IssueDAO');

        $totalArticles = (int) $submissionDao->countRecords(
            'SELECT submission_id FROM submissions WHERE context_id = ? AND status = ?',
            [$contextId, STATUS_PUBLISHED]
        );

        $totalIssues = (int) $issueDao->countRecords(
            'SELECT issue_id FROM issues WHERE journal_id = ? AND published = 1',
            [$contextId]
        );

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
