<?php
import('lib.pkp.classes.plugins.ThemePlugin');

class JrdcThemePlugin extends ThemePlugin {
    public function init() {
        $this->addStyle('jrdc-styles', 'styles/index.css');
        $this->addScript('jrdc-scripts', 'js/main.js');

        $this->addOption('primaryColor', 'colour', [
            'label' => 'Warna Aksen Utama',
            'description' => 'Warna untuk tombol, tautan aktif, dan aksen.',
            'default' => '#c2410c',
        ]);

        $this->addOption('heroColor', 'colour', [
            'label' => 'Warna Hero Banner',
            'description' => 'Warna latar belakang untuk banner utama.',
            'default' => '#0b2038',
        ]);
    }

    public function getDisplayName() {
        return 'JRDC Modern Academic Theme';
    }

    public function getDescription() {
        return 'Tema OJS 3.3 yang terinspirasi dari desain "Modern Academic Editorial" untuk Jurnal Ekonomi dan Bisnis JRDC.';
    }
}
?>
