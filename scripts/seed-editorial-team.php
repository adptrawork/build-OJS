<?php

/**
 * @file scripts/seed-editorial-team.php
 *
 * Seed tim editorial JRDC (5 peran akademis) ke instance OJS yang sudah
 * berjalan. Idempotent: user/assignment yang sudah ada dilewati, tidak
 * dibuat duplikat.
 *
 * Pakai:
 *   ddev exec php /var/www/html/scripts/seed-editorial-team.php
 */

require __DIR__ . '/../ojs/tools/bootstrap.php';

use APP\core\Application;
use APP\facades\Repo;
use PKP\core\Core;
use PKP\db\DAORegistry;
use PKP\user\User;
use PKP\userGroup\relationships\UserUserGroup;
use PKP\userGroup\UserGroup;

$request = Application::get()->getRequest();
$request->setRouter(new \PKP\core\PKPPageRouter());

$journalDao = DAORegistry::getDAO('JournalDAO');
$journal = $journalDao->getByPath('jrdc');
if (!$journal) {
    fwrite(STDERR, "Jurnal dengan path 'jrdc' tidak ditemukan.\n");
    exit(1);
}
$contextId = $journal->getId();

// Kelompok default OJS yang akan dijadikan peran masthead.
// Key = nama grup dalam bahasa Inggris (case-insensitive), value = [en, id].
$roleGroups = [
    'editor-in-chief'        => ['Editor-in-Chief',          'Editor-in-Chief'],
    'managing editor'        => ['Managing Editor',          'Editor Manajemen'],
    'section editor'         => ['Section Editor',           'Editor Bagian'],
    'copy editor'            => ['Copy Editor',              'Copy Editor'],
    'layout/production editor' => ['Layout/Production Editor', 'Editor Tata Letak/Produksi'],
];

// Cari user group milik context dan rename + aktifkan masthead.
$groupByKey = [];
$groups = UserGroup::withContextIds([$contextId])->get();
foreach ($groups as $group) {
    $nameArray = $group->name ?: [];
    $currentName = strtolower((string) ($nameArray['en'] ?? $group->getLocalizedData('name')));
    if (!isset($roleGroups[$currentName])) {
        continue;
    }
    [$nameEn, $nameId] = $roleGroups[$currentName];

    $group->name = ['en' => $nameEn, 'id' => $nameId];
    $group->masthead = true;
    $group->save();

    $groupByKey[$currentName] = $group;
    fwrite(STDOUT, "Grup #{$group->id} -> {$nameEn} (masthead on)\n");
}

$missing = array_diff_key($roleGroups, $groupByKey);
if ($missing) {
    fwrite(STDERR, "User group default tidak ditemukan: " . implode(', ', array_keys($missing)) . "\n");
    exit(1);
}

// Data tim editorial (nama realistis, afiliasi, peran).
$members = [
    [
        'group' => 'editor-in-chief',
        'username' => 'eic.wijaya',
        'email' => 'a.wijaya@jrdc.my.id',
        'givenName' => ['en' => 'Ahmad',       'id' => 'Ahmad'],
        'familyName' => ['en' => 'Wijaya',      'id' => 'Wijaya'],
        'affiliation' => ['en' => 'Universitas Indonesia', 'id' => 'Universitas Indonesia'],
    ],
    [
        'group' => 'managing editor',
        'username' => 'me.rina',
        'email' => 'r.setyawati@jrdc.my.id',
        'givenName' => ['en' => 'Rina',        'id' => 'Rina'],
        'familyName' => ['en' => 'Setyawati',   'id' => 'Setyawati'],
        'affiliation' => ['en' => 'Universitas Gadjah Mada', 'id' => 'Universitas Gadjah Mada'],
    ],
    [
        'group' => 'section editor',
        'username' => 'se.budi',
        'email' => 'b.santoso@jrdc.my.id',
        'givenName' => ['en' => 'Budi',        'id' => 'Budi'],
        'familyName' => ['en' => 'Santoso',     'id' => 'Santoso'],
        'affiliation' => ['en' => 'Institut Teknologi Bandung', 'id' => 'Institut Teknologi Bandung'],
    ],
    [
        'group' => 'copy editor',
        'username' => 'ce.dewi',
        'email' => 'd.kusuma@jrdc.my.id',
        'givenName' => ['en' => 'Dewi',        'id' => 'Dewi'],
        'familyName' => ['en' => 'Kusuma',      'id' => 'Kusuma'],
        'affiliation' => ['en' => 'Universitas Airlangga', 'id' => 'Universitas Airlangga'],
    ],
    [
        'group' => 'layout/production editor',
        'username' => 'lpe.eko',
        'email' => 'e.prasetyo@jrdc.my.id',
        'givenName' => ['en' => 'Eko',         'id' => 'Eko'],
        'familyName' => ['en' => 'Prasetyo',    'id' => 'Prasetyo'],
        'affiliation' => ['en' => 'Universitas Brawijaya', 'id' => 'Universitas Brawijaya'],
    ],
];

$created = 0;
$assigned = 0;
foreach ($members as $member) {
    $group = $groupByKey[$member['group']];
    $user = Repo::user()->getByUsername($member['username']);

    if (!$user) {
        $password = bin2hex(random_bytes(12));
        $hash = password_hash($password, PASSWORD_BCRYPT, ['cost' => 12]);

        $user = new User();
        $user->setUsername($member['username']);
        $user->setPassword($hash);
        $user->setEmail($member['email']);
        $user->setDateRegistered(Core::getCurrentDate());
        $user->setCountry('ID');

        foreach (['en', 'id'] as $locale) {
            $user->setGivenName($member['givenName'][$locale], $locale);
            $user->setFamilyName($member['familyName'][$locale], $locale);
            $user->setAffiliation($member['affiliation'][$locale], $locale);
        }

        $userId = Repo::user()->add($user);
        $user = Repo::user()->get($userId);
        $created++;

        fwrite(STDOUT, "User dibuat: {$member['username']} / {$member['email']} (pass: {$password})\n");
    } else {
        fwrite(STDOUT, "User sudah ada: {$member['username']} (id {$user->getId()})\n");
    }

    $alreadyAssigned = UserUserGroup::withUserId($user->getId())
        ->withUserGroupIds([$group->id])
        ->withActive()
        ->exists();

    if (!$alreadyAssigned) {
        Repo::userGroup()->assignUserToGroup(
            $user->getId(),
            $group->id,
            null,
            null,
            true
        );
        $assigned++;
        fwrite(STDOUT, "  -> ditugaskan ke {$group->name['en']}\n");
    } else {
        fwrite(STDOUT, "  -> sudah aktif di {$group->name['en']}\n");
    }
}

Repo::userGroup()->forgetEditorialCache($contextId);

fwrite(STDOUT, "\nSelesai. Dibuat: {$created} user, assignment baru: {$assigned}.\n");
