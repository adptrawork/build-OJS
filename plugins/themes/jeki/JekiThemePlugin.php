<?php

/**
 * @file plugins/themes/jeki/JekiThemePlugin.php
 *
 * @class JekiThemePlugin
 *
 * @brief Child theme di atas theme "default". Semua override template ada di
 *   templates/, semua token desain ada di styles/jeki.css.
 */

namespace APP\plugins\themes\jeki;

use APP\core\Application;
use APP\facades\Repo;
use PKP\plugins\Hook;
use PKP\submission\Collector as SubmissionCollector;
use PKP\submission\PKPSubmission;
use PKP\plugins\ThemePlugin;

class JekiThemePlugin extends ThemePlugin
{
    public function getDisplayName()
    {
        return __('plugins.themes.jeki.name');
    }

    public function getDescription()
    {
        return __('plugins.themes.jeki.description');
    }

    public function init()
    {
        $this->setParent('default');
        $this->addStyle('jeki', 'styles/jeki.css');
        $this->addScript('jeki-slots', 'js/slots.js');
        Hook::add('TemplateManager::display', [$this, 'assignHomepageData']);
    }

    /**
     * Isi $jekiLatestArticles untuk grid beranda (S-HOME-07): 6 artikel
     * terbit terbaru dari context aktif. Sisa slot homepage tetap di tangan
     * block plugins bawaan — tidak digandakan di sini.
     */
    public function assignHomepageData(string $hookName, array $args): void
    {
        if ($args[1] !== 'frontend/pages/indexJournal.tpl') {
            return;
        }
        $context = Application::get()->getRequest()->getContext();
        if (!$context) {
            return;
        }
        $published = Repo::submission()
            ->getCollector()
            ->filterByContextIds([$context->getId()])
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
            $articles[] = (object) [
                'id' => $submission->getId(),
                'title' => $publication->getLocalizedTitle(),
            ];
        }
        $args[0]->assign('jekiLatestArticles', $articles);
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\jeki\JekiThemePlugin', '\JekiThemePlugin');
}
