<?php

namespace APP\plugins\generic\akdisiSeo;

use APP\core\Application;
use APP\facades\Repo;
use PKP\handler\PKPHandler;
use PKP\core\PKPRequest;
use PKP\submission\PKPSubmission;
use PKP\submission\Collector as SubmissionCollector;

class AkdisiSeoHandler extends PKPHandler
{
    public function index($args, $request)
    {
        try {
            $journal = $request->getJournal();
            $baseUrl = rtrim($request->getBaseUrl(), '/');
            $path = $journal ? $journal->getPath() : '';

            $urls = [];
            $urls[] = $baseUrl . ($path ? "/index.php/{$path}/en" : '');

            $context = $journal ?: Application::get()->getRequest()->getContext();
            if ($context) {
                $cfg = [$context->getId()];
                $issues = Repo::issue()->getCollector()
                    ->filterByContextIds($cfg)
                    ->filterByPublished(true)
                    ->getMany();
                foreach ($issues as $issue) {
                    $url = $baseUrl . "/index.php/{$path}/en/issue/view/" . $issue->getId();
                    $urls[] = $url;
                }
                $subs = Repo::submission()->getCollector()
                    ->filterByContextIds($cfg)
                    ->filterByStatus([PKPSubmission::STATUS_PUBLISHED])
                    ->orderBy(SubmissionCollector::ORDERBY_DATE_PUBLISHED, SubmissionCollector::ORDER_DIR_DESC)
                    ->getMany();
                foreach ($subs as $s) {
                    $urls[] = $baseUrl . "/index.php/{$path}/en/article/view/" . $s->getId();
                }
            }

            header('Content-Type: application/xml; charset=utf-8');
            echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
            echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";
            foreach ($urls as $u) {
                echo "  <url><loc>" . htmlspecialchars($u, ENT_XML1) . "</loc></url>\n";
            }
            echo "</urlset>\n";
            exit;
        } catch (\Throwable $e) {
            http_response_code(500);
            header('Content-Type: text/plain');
            echo "EXC: " . get_class($e) . ": " . $e->getMessage() . "\n" . $e->getTraceAsString();
            exit;
        }
    }
}
