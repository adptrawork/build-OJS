<?php

/**
 * @file scripts/create-journal.php
 *
 * Membuat context jurnal JEKI di instance OJS. Dijalankan sekali setelah
 * tools/install.php. Idempotent: kalau path JEKI sudah ada, keluar dengan
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
$existing = $journalDao->getByPath('JEKI');
if ($existing) {
    fwrite(STDOUT, "Jurnal JEKI sudah ada (id {$existing->getId()}). Tidak ada perubahan.\n");
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
    'en' => 'Journal of Economics and Financial Studies',
    'id' => 'Jurnal Ekonomi dan Keuangan Indonesia',
]);
$journal->setData('path', 'JEKI');
$journal->setData('urlPath', 'JEKI');
$journal->setData('primaryLocale', 'en');
$journal->setData('supportedLocales', ['en', 'id']);
$journal->setData('enabled', true);
$journal->setData('publishingMode', Journal::PUBLISHING_MODE_OPEN);

app()->get('context')->add($journal, $request);

fwrite(STDOUT, "Jurnal dibuat: id {$journal->getId()} path {$journal->getPath()}\n");

// Konvensi Native XML importer (termasuk setup lama): section_ref pada
// publication harus sama dengan abbrev section. Default OJS membuat
// 'Articles' dengan abbrev 'ART' gagal match; lakukan standardisasi jadi
// 'Articles'. Idempotent — aman setiap kali dijalankan.
$sectionDao = DAORegistry::getDAO('SectionDAO');
$sections = $sectionDao->getByJournalId($journal->getId());
foreach ($sections as $section) {
    $desired = strtoupper(trim((string) $section->getTitle('en')));
    $desired = preg_replace('/\s+/', '_', $desired);
    if ($desired && $section->getAbbrev() !== $desired) {
        $section->setAbbrev($desired);
        $sectionDao->updateObject($section);
        fwrite(STDOUT, "Abbrev disesuaikan: {$section->getTitle('en')} -> {$desired}\n");
    }
}
