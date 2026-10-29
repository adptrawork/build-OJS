<?php

namespace APP\plugins\generic\jekiSeo;

use APP\core\Application;
use PKP\plugins\GenericPlugin;
use PKP\plugins\Hook;

class JekiSeoPlugin extends GenericPlugin
{
    public function getDisplayName()
    {
        return 'JEKI SEO';
    }

    public function getDescription()
    {
        return 'Sitemap XML ringan untuk demo JEKI.';
    }

    public function register($category, $path, $mainContextId = null)
    {
        if (parent::register($category, $path, $mainContextId)) {
            $enabled = $mainContextId !== null ? $this->getEnabled($mainContextId) : true;
            if ($enabled) {
                Hook::add('LoadHandler', $this->callbackHandleContent(...));
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

            if ($page === 'sitemap' || $page === 'sitemap.xml') {
                $page = 'sitemap';
                $op = 'index';
                $handler = new JekiSeoHandler($this);
                return true;
            }
            return false;
        } catch (\Throwable $e) {
            error_log('JEKI SEO callback: ' . get_class($e) . ': ' . $e->getMessage());
            file_put_contents('/var/www/html/ojs/cache/jeki-seo-error.txt', get_class($e) . ': ' . $e->getMessage() . "\n" . $e->getTraceAsString());
            return false;
        }
    }
}
