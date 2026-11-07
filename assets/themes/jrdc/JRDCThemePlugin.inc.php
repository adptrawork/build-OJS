<?php

/**
 * @file plugins/themes/jrdc/JRDCThemePlugin.inc.php
 *
 * Copyright (c) 2024-2026 JRDC / Adptrawork
 * Distributed under the GNU GPL v3.
 *
 * @class JRDCThemePlugin
 * @ingroup plugins.themes.jrdc
 *
 * @brief JRDC Theme for OJS 3.3 — Modern Academic Editorial
 * Based on UI prototype: Jurnal Ekonomi dan Bisnis JRDC
 */

import('lib.pkp.classes.plugins.ThemePlugin');

class JRDCThemePlugin extends ThemePlugin {

	/**
	 * @copydoc ThemePlugin::isActive()
	 */
	public function isActive() {
		if (defined('SESSION_DISABLE_INIT')) return true;
		return parent::isActive();
	}

	/**
	 * Initialize the theme's styles, scripts and options.
	 */
	public function init() {
		// Load parent (Default Theme) so we inherit base templates & behaviour
		$this->setParent('defaultthemeplugin');

		// ---- Theme Options (Admin Panel) ----
		$this->addOption('primaryColour', 'colour', array(
			'label' => 'plugins.themes.jrdc.option.primaryColour.label',
			'description' => 'plugins.themes.jrdc.option.primaryColour.description',
			'default' => '#c2410c',
		));

		$this->addOption('primaryHoverColour', 'colour', array(
			'label' => 'plugins.themes.jrdc.option.primaryHoverColour.label',
			'description' => 'plugins.themes.jrdc.option.primaryHoverColour.description',
			'default' => '#9a3412',
		));

		$this->addOption('navyHeroColour', 'colour', array(
			'label' => 'plugins.themes.jrdc.option.navyHeroColour.label',
			'description' => 'plugins.themes.jrdc.option.navyHeroColour.description',
			'default' => '#0b2038',
		));

		$this->addOption('navyDarkColour', 'colour', array(
			'label' => 'plugins.themes.jrdc.option.navyDarkColour.label',
			'description' => 'plugins.themes.jrdc.option.navyDarkColour.description',
			'default' => '#071424',
		));

		$this->addOption('enableDarkMode', 'radio', array(
			'label' => 'plugins.themes.jrdc.option.enableDarkMode.label',
			'description' => 'plugins.themes.jrdc.option.enableDarkMode.description',
			'options' => array(
				'1' => 'plugins.themes.jrdc.option.enableDarkMode.enable',
				'0' => 'plugins.themes.jrdc.option.enableDarkMode.disable',
			),
			'default' => '1',
		));

		$this->addOption('showHeroCover', 'radio', array(
			'label' => 'plugins.themes.jrdc.option.showHeroCover.label',
			'description' => 'plugins.themes.jrdc.option.showHeroCover.description',
			'options' => array(
				'1' => 'common.yes',
				'0' => 'common.no',
			),
			'default' => '1',
		));

		$this->addOption('heroEyebrow', 'text', array(
			'label' => 'plugins.themes.jrdc.option.heroEyebrow.label',
			'description' => 'plugins.themes.jrdc.option.heroEyebrow.description',
			'default' => 'JURNAL ILMIAH • EKONOMI DAN BISNIS',
		));

		$this->addOption('showIssueCoverOnHomepage', 'radio', array(
			'label' => 'plugins.themes.jrdc.option.showIssueCoverOnHomepage.label',
			'description' => 'plugins.themes.jrdc.option.showIssueCoverOnHomepage.description',
			'options' => array(
				'1' => 'common.yes',
				'0' => 'common.no',
			),
			'default' => '1',
		));

		$this->addOption('showJournalDescription', 'radio', array(
			'label' => 'plugins.themes.jrdc.option.showJournalDescription.label',
			'description' => 'plugins.themes.jrdc.option.showJournalDescription.description',
			'options' => array(
				'1' => 'common.yes',
				'0' => 'common.no',
			),
			'default' => '1',
		));

		$this->addOption('showAnnouncementsOnHomepage', 'radio', array(
			'label' => 'plugins.themes.jrdc.option.showAnnouncementsOnHomepage.label',
			'description' => 'plugins.themes.jrdc.option.showAnnouncementsOnHomepage.description',
			'options' => array(
				'1' => 'common.yes',
				'0' => 'common.no',
			),
			'default' => '1',
		));

		$this->addOption('announcementsHomepageCount', 'text', array(
			'label' => 'plugins.themes.jrdc.option.announcementsHomepageCount.label',
			'description' => 'plugins.themes.jrdc.option.announcementsHomepageCount.description',
			'default' => '3',
		));

		$this->addOption('showCurrentIssueArticles', 'radio', array(
			'label' => 'plugins.themes.jrdc.option.showCurrentIssueArticles.label',
			'description' => 'plugins.themes.jrdc.option.showCurrentIssueArticles.description',
			'options' => array(
				'1' => 'common.yes',
				'0' => 'common.no',
			),
			'default' => '1',
		));

		$this->addOption('sidebarPosition', 'radio', array(
			'label' => 'plugins.themes.jrdc.option.sidebarPosition.label',
			'description' => 'plugins.themes.jrdc.option.sidebarPosition.description',
			'options' => array(
				'right' => 'plugins.themes.jrdc.option.sidebarPosition.right',
				'left' => 'plugins.themes.jrdc.option.sidebarPosition.left',
				'none' => 'plugins.themes.jrdc.option.sidebarPosition.none',
			),
			'default' => 'right',
		));

		$this->addOption('baseFontSize', 'text', array(
			'label' => 'plugins.themes.jrdc.option.baseFontSize.label',
			'description' => 'plugins.themes.jrdc.option.baseFontSize.description',
			'default' => '16',
		));

		$this->addOption('useGoogleFonts', 'radio', array(
			'label' => 'plugins.themes.jrdc.option.useGoogleFonts.label',
			'description' => 'plugins.themes.jrdc.option.useGoogleFonts.description',
			'options' => array(
				'1' => 'common.yes',
				'0' => 'common.no',
			),
			'default' => '1',
		));

		// ---- Styles & Scripts ----
		$this->addStyle('jrdc-fonts', 'styles/fonts.css');
		$this->addStyle('jrdc', 'styles/index.css', array('dependencies' => array('jrdc-fonts')));

		// Pass CSS variables from theme options
		$primary = $this->getOption('primaryColour') ?: '#c2410c';
		$primaryHover = $this->getOption('primaryHoverColour') ?: '#9a3412';
		$navyHero = $this->getOption('navyHeroColour') ?: '#0b2038';
		$navyDark = $this->getOption('navyDarkColour') ?: '#071424';
		$baseFont = (int)($this->getOption('baseFontSize') ?: 16);

		$this->modifyStyle('jrdc', array(
			'addLessVariables' => "
				@primary: {$primary};
				@primary-hover: {$primaryHover};
				@navy-hero: {$navyHero};
				@navy-dark: {$navyDark};
				@base-font-size: {$baseFont}px;
			"
		));

		// Actually we use plain CSS with CSS custom properties, so inject via inline
		$this->addStyle(
			'jrdc-variables',
			'/* injected */',
			array(
				'inline' => true,
				'data' => ":root {
					--jrdc-primary: {$primary};
					--jrdc-primary-hover: {$primaryHover};
					--jrdc-navy-hero: {$navyHero};
					--jrdc-navy-dark: {$navyDark};
					--jrdc-base-font-size: {$baseFont}px;
				}"
			)
		);

		$this->addScript('jrdc', 'js/main.js');

		// Google Fonts (Geist alternative + Merriweather)
		if ($this->getOption('useGoogleFonts') !== '0') {
			$this->addStyle(
				'jrdc-google-fonts',
				'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:ital,wght@0,400;0,700;1,400&display=swap',
				array('baseUrl' => '')
			);
		}
	}

	/**
	 * Get the display name of this theme
	 */
	public function getDisplayName() {
		return __('plugins.themes.jrdc.name');
	}

	/**
	 * Get the description of this plugin
	 */
	public function getDescription() {
		return __('plugins.themes.jrdc.description');
	}
}
