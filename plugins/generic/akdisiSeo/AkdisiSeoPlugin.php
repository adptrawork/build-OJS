<?php

/**
 * @file plugins/generic/akdisiSeo/AkdisiSeoPlugin.php
 *
 * @class AkdisiSeoPlugin
 *
 * @brief SEO plugin untuk AKDISI: sitemap XML + data SEO + JSON-LD.
 *   Canonical/OG dirender oleh theme akdisi lewat headerHead.tpl.
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
    public function getDisplayName()
    {
        return 'AKDISI SEO';
    }

    public function getDescription()
    {
        return 'Sitemap XML, canonical data, dan JSON-LD untuk demo AKDISI.';
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
            error_log('AKDISI SEO callback: ' . get_class($e) . ': ' . $e->getMessage());
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
            }
        } catch (\Throwable $e) {
            error_log('AKDISI SEO inject: ' . $e->getMessage());
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
                'isPartOf' => [
                    '@type' => 'Periodical',
                    'name' => $context->getLocalizedName(),
                    'issn' => $context->getData('issn'),
                ],
            ];
            $keywords = $publication->getData('keywords', $locale) ?: [];
            if ($keywords) {
                $data['keywords'] = implode(', ', $keywords);
            }
            return json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        } catch (\Throwable $e) {
            error_log('AKDISI SEO buildArticleJsonLd: ' . $e->getMessage());
            return null;
        }
    }

    private function buildPeriodicalJsonLd(Journal $context, string $baseUrl, string $locale): ?string
    {
        try {
            $data = [
                '@context' => 'https://schema.org',
                '@type' => 'Periodical',
                'name' => $context->getLocalizedName(),
                'url' => Application::get()->getRequest()->url($context->getPath()),
            ];
            if ($context->getData('issn')) {
                $data['issn'] = $context->getData('issn');
            }
            $publisherName = $context->getLocalizedData('publisherInstitution') ?: $context->getLocalizedName();
            if ($publisherName) {
                $data['publisher'] = ['@type' => 'Organization', 'name' => $publisherName];
            }
            return json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        } catch (\Throwable $e) {
            error_log('AKDISI SEO buildPeriodicalJsonLd: ' . $e->getMessage());
            return null;
        }
    }
}
