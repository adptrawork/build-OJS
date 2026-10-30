<?php

/**
 * @file scripts/register-plugins.php
 *
 * Daftarkan plugin yang ada di filesystem ke tabel `versions`, supaya OJS mau
 * memuatnya. Setara dengan langkah Installer::addPluginVersions() saat install.
 * Aman dijalankan di CLI tanpa memicu inisialisasi request context.
 *
 * Pakai:
 *   ddev exec php /var/www/html/scripts/register-plugins.php
 */

require __DIR__ . '/../ojs/tools/bootstrap.php';

use PKP\core\Core;
use PKP\site\VersionCheck;
use PKP\db\DAORegistry;
use PKP\site\Version;

$versionDao = DAORegistry::getDAO('VersionDAO');
$fileManager = new \PKP\file\FileManager();
$added = 0;

$pluginDirs = glob(__DIR__ . '/../ojs/plugins/*/*', GLOB_ONLYDIR);
foreach ($pluginDirs as $dir) {
    $category = basename(dirname($dir));
    $product = basename($dir);
    $versionFile = $dir . '/version.xml';

    if ($fileManager->fileExists($versionFile)) {
        $versionInfo = VersionCheck::parseVersionXML($versionFile);
        $version = $versionInfo['version'];
    } else {
        $version = new Version(
            1,
            0,
            0,
            0,
            Core::getCurrentDate(),
            1,
            'plugins.' . $category,
            $product,
            '',
            0,
            0
        );
    }

    $versionDao->insertVersion($version, true);
    $added++;
}

fwrite(STDOUT, "Plugin terdaftar/diperbarui: {$added}\n");
