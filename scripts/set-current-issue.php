<?php

/**
 * @file scripts/set-current-issue.php
 *
 * Idempoten: pastikan issue terbaru yang sudah dipublish di jurnal jrdc
 * menjadi current issue. Jika date_published masih NULL, isi dengan
 * 1 Januari tahun issue (fallback ke tanggal sekarang).
 *
 * Pakai:
 *   ddev exec php /var/www/html/scripts/set-current-issue.php
 */

require __DIR__ . '/../ojs/tools/bootstrap.php';

use APP\core\Application;
use Illuminate\Support\Facades\DB;
use PKP\core\PKPPageRouter;

$request = Application::get()->getRequest();
$request->setRouter(new PKPPageRouter());

$journalRow = DB::table('journals')->where('path', 'jrdc')->first();
if (!$journalRow) {
    fwrite(STDERR, "Jurnal jrdc tidak ditemukan.\n");
    exit(1);
}

$contextId = (int) $journalRow->journal_id;

// Ambil issue terbaru yang sudah dipublish.
$issue = DB::table('issues')
    ->where('journal_id', $contextId)
    ->where('published', 1)
    ->orderByDesc('date_published')
    ->orderByDesc('issue_id')
    ->first();

if (!$issue) {
    fwrite(STDERR, "Tidak ada issue yang sudah dipublish di jrdc.\n");
    exit(1);
}

$issueId = (int) $issue->issue_id;
$identification = "Vol. {$issue->volume} No. {$issue->number} ({$issue->year})";
fwrite(STDOUT, "Issue ditemukan: id {$issueId} - {$identification}\n");

// Pastikan date_published terisi.
if (!$issue->date_published) {
    $year = $issue->year ?: date('Y');
    $date = $year . '-01-01 00:00:00';
    DB::table('issues')->where('issue_id', $issueId)->update(['date_published' => $date]);
    fwrite(STDOUT, "date_published diisi: {$date}\n");
} else {
    fwrite(STDOUT, "date_published sudah terisi: " . $issue->date_published . "\n");
}

// Set current issue jika belum.
$current = DB::table('journal_settings')
    ->where('journal_id', $contextId)
    ->where('locale', '')
    ->where('setting_name', 'currentIssueId')
    ->first();

if ($current && (int) $current->setting_value === $issueId) {
    fwrite(STDOUT, "Issue {$issueId} sudah menjadi current issue. Tidak ada perubahan.\n");
    exit(0);
}

DB::table('journal_settings')->updateOrInsert(
    [
        'journal_id' => $contextId,
        'locale' => '',
        'setting_name' => 'currentIssueId',
    ],
    [
        'setting_value' => $issueId,
    ]
);

$prev = $current ? (int) $current->setting_value : '(none)';
fwrite(STDOUT, "Current issue diperbarui: {$prev} -> {$issueId}\n");
exit(0);
