<?php

/**
 * @file scripts/create-journal.php
 *
 * Membuat context jurnal AKDISI di instance OJS. Dijalankan sekali setelah
 * tools/install.php. Idempotent: kalau path AKDISI sudah ada, keluar dengan
 * pesan, bukan error.
 *
 * Pakai:
 *   ddev exec php /var/www/html/scripts/create-journal.php
 */

require __DIR__ . '/../ojs/tools/bootstrap.php';

use APP\core\Application;
use APP\journal\Journal;
use PKP\db\DAORegistry;

$request = Application::get()->getRequest();

$journalDao = DAORegistry::getDAO('JournalDAO');
$existing = $journalDao->getByPath('AKDISI');
if ($existing) {
    fwrite(STDOUT, "Jurnal AKDISI sudah ada (id {$existing->getId()}). Tidak ada perubahan.\n");
    exit(0);
}

// Service butuh user untuk audit trail (created_by) dan penyimpanan file.
$admin = \APP\facades\Repo::user()->getByUsername('admin');
if (!$admin) {
    fwrite(STDERR, "User 'admin' tidak ditemukan.\n");
    exit(1);
}
\PKP\core\Registry::set('user', $admin);
// CLI tidak punya router; service butuh URL absolut untuk nilai default locale.
$request->setRouter(new \PKP\core\PKPPageRouter());

$journal = new Journal();
$journal->setData('name', [
    'en' => 'Akdisi',
    'id' => 'Akdisi',
]);
$journal->setData('description', [
    'en' => 'Mitra digital untuk bisnis yang ingin tumbuh',
    'id' => 'Mitra digital untuk bisnis yang ingin tumbuh',
]);
$journal->setData('path', 'AKDISI');
$journal->setData('urlPath', 'AKDISI');
$journal->setData('primaryLocale', 'en');
$journal->setData('supportedLocales', ['en', 'id']);
$journal->setData('enabled', true);
$journal->setData('publishingMode', Journal::PUBLISHING_MODE_OPEN);

app()->get('context')->add($journal, $request);

fwrite(STDOUT, "Jurnal dibuat: id {$journal->getId()} path {$journal->getPath()}\n");

// Konvensi Native XML importer: section_ref pada publication harus sama
// dengan abbrev section. Default OJS membuat 'Articles' dengan abbrev 'ART';
// lakukan standardisasi jadi 'ARTICLES'.
$sections = \APP\facades\Repo::section()
    ->getCollector()
    ->filterByContextIds([$journal->getId()])
    ->getMany();

foreach ($sections as $section) {
    $title = (string) ($section->getTitle('en') ?: $section->getLocalizedTitle());
    $desired = strtoupper(trim($title));
    $desired = preg_replace('/\s+/', '_', $desired);
    if ($desired) {
        \APP\facades\Repo::section()->edit($section, [
            'abbrev' => [
                'en' => $desired,
                'id' => $desired,
            ],
        ]);
        fwrite(STDOUT, "Abbrev disesuaikan: {$title} -> {$desired}\n");
    }
}
