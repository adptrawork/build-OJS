<?php

/**
 * @file plugins/generic/akdisiSeo/AkdisiSeoPlugin.php
 *
 * @class AkdisiSeoPlugin
 *
 * @brief SEO plugin untuk JRDC: sitemap XML + data SEO + JSON-LD.
 *   Canonical/OG dirender oleh theme journalEditorial lewat headerHead.tpl.
 */

namespace APP\plugins\generic\akdisiSeo;

use APP\core\Application;
use APP\facades\Repo;
use APP\journal\Journal;
use PKP\facades\Locale;
use PKP\plugins\GenericPlugin;
use PKP\plugins\Hook;

class AkdisiSeoPlugin extends GenericPlugin
{
    private const JOURNAL_FULL_NAME = 'Jurnal Ratu Dirgantara Cendikiawan (JRDC)';
    private const JOURNAL_SHORT_NAME = 'JRDC';
    private const LICENSE_URL = 'https://creativecommons.org/licenses/by/4.0/';
    private const ABOUT = 'Economics and Business';

    public function getDisplayName()
    {
        return 'JRDC SEO';
    }

    public function getDescription()
    {
        return 'Sitemap XML, canonical data, dan JSON-LD untuk JRDC.';
    }

    public function register($category, $path, $mainContextId = null)
    {
        if (parent::register($category, $path, $mainContextId)) {
            $enabled = $mainContextId !== null ? $this->getEnabled($mainContextId) : true;
            if ($enabled) {
                Hook::add('LoadHandler', $this->callbackHandleContent(...));
                Hook::add('TemplateManager::display', $this->callbackInjectSeo(...));
            }
            return true;
        }
        return false;
    }

    public function callbackHandleContent($hookName, $args)
    {
        try {
            $page = &$args[0];
            $op = &$args[1];
            $handler = &$args[3];

            // OJS mengubah sitemap.xml menjadi sitemapxml saat routing.
            if ($page === 'sitemap' || $page === 'sitemap.xml' || $page === 'sitemapxml') {
                $page = 'sitemap';
                $op = 'index';
                $handler = new AkdisiSeoHandler($this);
                return true;
            }
            return false;
        } catch (\Throwable $e) {
            error_log('JRDC SEO callback: ' . get_class($e) . ': ' . $e->getMessage());
            return false;
        }
    }

    public function callbackInjectSeo($hookName, $args)
    {
        try {
            $templateMgr = $args[0];
            $request = Application::get()->getRequest();
            $context = $request->getContext();
            if (!$context instanceof Journal) {
                return;
            }

            $baseUrl = rtrim($request->getBaseUrl(), '/');
            $path = $context->getPath();
            $locale = Locale::getLocale();

            // Bangun canonical URL sesuai halaman yang sedang dibuka.
            $page = $request->getRequestedPage();
            $op = $request->getRequestedOp();
            $args = $request->getRequestedArgs();
            $currentUrl = $request->url($path, $page ?: null, $op ?: null, $args ?: null, ['locale' => $locale]);

            $publication = $templateMgr->getTemplateVars('publication');

            $templateMgr->assign([
                'akdisiCanonicalUrl' => $currentUrl,
                'akdisiBaseUrl' => $baseUrl,
                'akdisiJournalPath' => $path,
                'akdisiLocale' => $locale,
                'akdisiCurrentPublication' => $publication,
            ]);

            if ($publication) {
                $jsonLd = $this->buildArticleJsonLd($publication, $context, $baseUrl, $locale);
                if ($jsonLd) {
                    $templateMgr->addHeader('akdisiJsonLdArticle', '<script type="application/ld+json">' . $jsonLd . '</script>');
                }
            } else {
                $jsonLd = $this->buildPeriodicalJsonLd($context, $baseUrl, $locale);
                if ($jsonLd) {
                    $templateMgr->addHeader('akdisiJsonLdPeriodical', '<script type="application/ld+json">' . $jsonLd . '</script>');
                }

                // Inject FAQPage schema on static pages that contain FAQ-style h3/p blocks.
                $content = $templateMgr->getTemplateVars('content');
                if ($content) {
                    $faqJsonLd = $this->buildFaqJsonLd((string) $content);
                    if ($faqJsonLd) {
                        $templateMgr->addHeader('akdisiJsonLdFaq', '<script type="application/ld+json">' . $faqJsonLd . '</script>');
                    }
                }
            }
        } catch (\Throwable $e) {
            error_log('JRDC SEO inject: ' . $e->getMessage());
        }
    }

    private function buildArticleJsonLd($publication, Journal $context, string $baseUrl, string $locale): ?string
    {
        try {
            $title = $publication->getLocalizedTitle();
            if (!$title) {
                return null;
            }
            $authors = [];
            $authorList = $publication->getData('authors') ?: [];
            foreach ($authorList as $author) {
                $authorData = [
                    '@type' => 'Person',
                    'name' => $author->getFullName(false),
                ];
                $affiliation = $author->getLocalizedData('affiliation');
                if ($affiliation) {
                    $authorData['affiliation'] = ['@type' => 'Organization', 'name' => $affiliation];
                }
                $orcid = $author->getOrcid();
                if ($orcid) {
                    $authorData['sameAs'] = $orcid;
                }
                $authors[] = $authorData;
            }

            $data = [
                '@context' => 'https://schema.org',
                '@type' => 'ScholarlyArticle',
                'headline' => $title,
                'author' => $authors,
                'datePublished' => $publication->getData('datePublished') ?: date('Y-m-d'),
                'url' => Application::get()->getRequest()->url($context->getPath(), 'article', 'view', [$publication->getData('submissionId')]),
                'isAccessibleForFree' => true,
                'license' => $this->getLicenseUrl($context),
                'isPartOf' => [
                    '@type' => 'Periodical',
                    'name' => self::JOURNAL_FULL_NAME,
                    'alternateName' => self::JOURNAL_SHORT_NAME,
                    'issn' => $context->getData('onlineIssn') ?: $context->getData('issn'),
                ],
            ];

            $printIssn = $context->getData('printIssn');
            if ($printIssn) {
                $data['isPartOf']['printIssn'] = $printIssn;
            }

            $pages = $publication->getData('pages');
            if ($pages) {
                $pageParts = array_filter(array_map('trim', preg_split('/[-–]/u', $pages)));
                if (isset($pageParts[0])) {
                    $data['pageStart'] = $pageParts[0];
                }
                if (isset($pageParts[1])) {
                    $data['pageEnd'] = $pageParts[1];
                }
            }

            $keywords = $publication->getData('keywords', $locale) ?: [];
            if ($keywords) {
                $data['keywords'] = implode(', ', $keywords);
            }
            return json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        } catch (\Throwable $e) {
            error_log('JRDC SEO buildArticleJsonLd: ' . $e->getMessage());
            return null;
        }
    }

    private function buildPeriodicalJsonLd(Journal $context, string $baseUrl, string $locale): ?string
    {
        try {
            $data = [
                '@context' => 'https://schema.org',
                '@type' => 'Periodical',
                'name' => self::JOURNAL_FULL_NAME,
                'alternateName' => self::JOURNAL_SHORT_NAME,
                'url' => Application::get()->getRequest()->url($context->getPath()),
                'about' => self::ABOUT,
                'isAccessibleForFree' => true,
                'license' => $this->getLicenseUrl($context),
            ];

            $onlineIssn = $context->getData('onlineIssn') ?: $context->getData('issn');
            if ($onlineIssn) {
                $data['issn'] = $onlineIssn;
            }
            $printIssn = $context->getData('printIssn');
            if ($printIssn) {
                $data['printIssn'] = $printIssn;
            }

            $publisherName = $context->getLocalizedData('publisherInstitution') ?: self::JOURNAL_FULL_NAME;
            if ($publisherName) {
                $data['publisher'] = ['@type' => 'Organization', 'name' => $publisherName];
            }

            // Include current issue if one is published.
            try {
                $currentIssue = Repo::issue()->getCurrent($context->getId());
                if ($currentIssue && $currentIssue->getDatePublished()) {
                    $data['hasPart'] = [
                        '@type' => 'PublicationIssue',
                        'issueNumber' => $currentIssue->getNumber() ?: '',
                        'volumeNumber' => $currentIssue->getVolume() ?: '',
                    ];
                }
            } catch (\Throwable $e) {
                // Ignore: current issue is optional metadata.
            }

            return json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        } catch (\Throwable $e) {
            error_log('JRDC SEO buildPeriodicalJsonLd: ' . $e->getMessage());
            return null;
        }
    }

    private function buildFaqJsonLd(string $content): ?string
    {
        if (!preg_match_all('/<h3[^>]*>(.*?)<\/h3>\s*<p[^>]*>(.*?)<\/p>/is', $content, $matches, PREG_SET_ORDER)) {
            return null;
        }

        $mainEntity = [];
        foreach ($matches as $m) {
            $question = trim(strip_tags($m[1]));
            $answer = trim(strip_tags($m[2]));
            if ($question && $answer) {
                $mainEntity[] = [
                    '@type' => 'Question',
                    'name' => $question,
                    'acceptedAnswer' => [
                        '@type' => 'Answer',
                        'text' => $answer,
                    ],
                ];
            }
        }

        if (!$mainEntity) {
            return null;
        }

        $data = [
            '@context' => 'https://schema.org',
            '@type' => 'FAQPage',
            'mainEntity' => $mainEntity,
        ];
        return json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }

    private function getLicenseUrl(Journal $context): string
    {
        return $context->getData('licenseUrl') ?: self::LICENSE_URL;
    }
}
