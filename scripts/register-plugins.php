<?php

/**
 * @file scripts/register-plugins.php
 *
 * Daftarkan plugin yang ada di filesystem ke tabel `versions`, supaya OJS mau
 * memuatnya. Setara dengan langkah Installer::addPluginVersions() saat install,
 * dijalankan ulang setelah menambah plugin baru (mis. theme jeki).
 *
 * Pakai:
 *   ddev exec php /var/www/html/scripts/register-plugins.php
 */

require __DIR__ . '/../ojs/tools/bootstrap.php';

use PKP\core\Core;
use PKP\site\VersionCheck;
use PKP\db\DAORegistry;
use PKP\plugins\PluginRegistry;
use PKP\site\Version;

$versionDao = DAORegistry::getDAO('VersionDAO');
$fileManager = new \PKP\file\FileManager();
$added = 0;

foreach (PluginRegistry::getCategories() as $category) {
    PluginRegistry::loadCategory($category);
    foreach (PluginRegistry::getPlugins($category) as $plugin) {
        $versionFile = $plugin->getPluginPath() . '/version.xml';
        $version = $fileManager->fileExists($versionFile)
            ? VersionCheck::parseVersionXML($versionFile)['version']
            : new Version(1, 0, 0, 0, Core::getCurrentDate(), 1, 'plugins.' . $category, basename($plugin->getPluginPath()), '', 0, $plugin->isSitePlugin());

        $versionDao->insertVersion($version, true);
        $added++;
    }
}

fwrite(STDOUT, "Plugin terdaftar/diperbarui: {$added}\n");
