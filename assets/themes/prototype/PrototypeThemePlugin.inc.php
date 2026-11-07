<?php

/**
 * @file plugins/themes/prototype/PrototypeThemePlugin.inc.php
 *
 * Bootstrap-based OJS 3.3 theme reproducing the JRDC prototype UI.
 * Maps prototype (Tailwind) layout to Bootstrap 5 + custom CSS.
 */

import('lib.pkp.classes.plugins.ThemePlugin');
import('lib.pkp.classes.plugins.HookRegistry');
import('lib.pkp.classes.core.Registry');

class PrototypeThemePlugin extends ThemePlugin {

	public function isActive() {
		if (defined('SESSION_DISABLE_INIT')) return true;
		return parent::isActive();
	}

	public function init() {
		// Inherit base templates/behaviour from OJS default theme
		$this->setParent('defaultthemeplugin');

		// Assign current issue to index template (OJS does not by default)
		HookRegistry::register('TemplateManager::display', array($this, 'assignCurrentIssue'));

		// ---- Theme Options (Admin Panel) ----
		$this->addOption('primaryColour', 'colour', array(
			'label' => 'plugins.themes.prototype.option.primaryColour.label',
			'description' => 'plugins.themes.prototype.option.primaryColour.description',
			'default' => '#c2410c',
		));
		$this->addOption('primaryHoverColour', 'colour', array(
			'label' => 'plugins.themes.prototype.option.primaryHoverColour.label',
			'description' => 'plugins.themes.prototype.option.primaryHoverColour.description',
			'default' => '#9a3412',
		));
		$this->addOption('navyHeroColour', 'colour', array(
			'label' => 'plugins.themes.prototype.option.navyHeroColour.label',
			'description' => 'plugins.themes.prototype.option.navyHeroColour.description',
			'default' => '#0b2038',
		));
		$this->addOption('navyDarkColour', 'colour', array(
			'label' => 'plugins.themes.prototype.option.navyDarkColour.label',
			'description' => 'plugins.themes.prototype.option.navyDarkColour.description',
			'default' => '#071424',
		));
		$this->addOption('enableDarkMode', 'radio', array(
			'label' => 'plugins.themes.prototype.option.enableDarkMode.label',
			'description' => 'plugins.themes.prototype.option.enableDarkMode.description',
			'options' => array('1' => 'plugins.themes.prototype.option.enableDarkMode.enable', '0' => 'plugins.themes.prototype.option.enableDarkMode.disable'),
			'default' => '1',
		));
		$this->addOption('showHeroCover', 'radio', array(
			'label' => 'plugins.themes.prototype.option.showHeroCover.label',
			'description' => 'plugins.themes.prototype.option.showHeroCover.description',
			'options' => array('1' => 'common.yes', '0' => 'common.no'),
			'default' => '1',
		));
		$this->addOption('heroEyebrow', 'text', array(
			'label' => 'plugins.themes.prototype.option.heroEyebrow.label',
			'description' => 'plugins.themes.prototype.option.heroEyebrow.description',
			'default' => 'JURNAL ILMIAH • EKONOMI DAN BISNIS',
		));
		$this->addOption('showIssueCoverOnHomepage', 'radio', array(
			'label' => 'plugins.themes.prototype.option.showIssueCoverOnHomepage.label',
			'description' => 'plugins.themes.prototype.option.showIssueCoverOnHomepage.description',
			'options' => array('1' => 'common.yes', '0' => 'common.no'),
			'default' => '1',
		));
		$this->addOption('showJournalDescription', 'radio', array(
			'label' => 'plugins.themes.prototype.option.showJournalDescription.label',
			'description' => 'plugins.themes.prototype.option.showJournalDescription.description',
			'options' => array('1' => 'common.yes', '0' => 'common.no'),
			'default' => '1',
		));
		$this->addOption('showAnnouncementsOnHomepage', 'radio', array(
			'label' => 'plugins.themes.prototype.option.showAnnouncementsOnHomepage.label',
			'description' => 'plugins.themes.prototype.option.showAnnouncementsOnHomepage.description',
			'options' => array('1' => 'common.yes', '0' => 'common.no'),
			'default' => '1',
		));
		$this->addOption('announcementsHomepageCount', 'text', array(
			'label' => 'plugins.themes.prototype.option.announcementsHomepageCount.label',
			'description' => 'plugins.themes.prototype.option.announcementsHomepageCount.description',
			'default' => '3',
		));
		$this->addOption('showCurrentIssueArticles', 'radio', array(
			'label' => 'plugins.themes.prototype.option.showCurrentIssueArticles.label',
			'description' => 'plugins.themes.prototype.option.showCurrentIssueArticles.description',
			'options' => array('1' => 'common.yes', '0' => 'common.no'),
			'default' => '1',
		));
		$this->addOption('sidebarPosition', 'radio', array(
			'label' => 'plugins.themes.prototype.option.sidebarPosition.label',
			'description' => 'plugins.themes.prototype.option.sidebarPosition.description',
			'options' => array('right' => 'plugins.themes.prototype.option.sidebarPosition.right', 'left' => 'plugins.themes.prototype.option.sidebarPosition.left', 'none' => 'plugins.themes.prototype.option.sidebarPosition.none'),
			'default' => 'right',
		));
		$this->addOption('baseFontSize', 'text', array(
			'label' => 'plugins.themes.prototype.option.baseFontSize.label',
			'description' => 'plugins.themes.prototype.option.baseFontSize.description',
			'default' => '16',
		));
		$this->addOption('useGoogleFonts', 'radio', array(
			'label' => 'plugins.themes.prototype.option.useGoogleFonts.label',
			'description' => 'plugins.themes.prototype.option.useGoogleFonts.description',
			'options' => array('1' => 'common.yes', '0' => 'common.no'),
			'default' => '1',
		));

		// ---- Styles & Scripts (Bootstrap base + prototype look) ----
		$this->addStyle('bootstrap', 'styles/bootstrap.min.css');
		$this->addStyle('bootstrap-icons', 'styles/bootstrap-icons.min.css');
		$this->addStyle('prototype', 'styles/index.css', array('dependencies' => array('bootstrap')));
		$this->addStyle('prototype-fonts', 'styles/fonts.css');

		$primary = $this->getOption('primaryColour') ?: '#c2410c';
		$primaryHover = $this->getOption('primaryHoverColour') ?: '#9a3412';
		$navyHero = $this->getOption('navyHeroColour') ?: '#0b2038';
		$navyDark = $this->getOption('navyDarkColour') ?: '#071424';
		$baseFont = (int)($this->getOption('baseFontSize') ?: 16);

		$this->modifyStyle('prototype', array(
			'addLessVariables' => "
				@primary: {$primary};
				@primary-hover: {$primaryHover};
				@navy-hero: {$navyHero};
				@navy-dark: {$navyDark};
				@base-font-size: {$baseFont}px;
			"
		));

		$this->addStyle('prototype-variables', ":root {
				--jrdc-primary: {$primary};
				--jrdc-primary-hover: {$primaryHover};
				--jrdc-navy-hero: {$navyHero};
				--jrdc-navy-dark: {$navyDark};
				--jrdc-base-font-size: {$baseFont}px;
			}", array('inline' => true));

		$this->addScript('bootstrap-bundle', 'js/bootstrap.bundle.min.js');
		$this->addScript('prototype', 'js/main.js', array('dependencies' => array('bootstrap-bundle')));

		if ($this->getOption('useGoogleFonts') !== '0') {
			$this->addStyle('prototype-google-fonts', 'https://fonts.googleapis.com/css2?family=Geist:wght@400;500;600;700&family=Merriweather:ital,wght@0,400;0,700;1,400&display=swap', array('baseUrl' => ''));
		}
	}

	/**
	 * Assign the current issue to the index journal template so the
	 * hero cover, issue identification and article list render.
	 */
	public function assignCurrentIssue($hookName, $args) {
		$templateMgr =& $args[0];
		$template =& $args[1];
		if ($template !== 'frontend/pages/indexJournal.tpl') return false;
		$request = Registry::get('request');
		$journal = $request->getJournal();
		if (!$journal) return false;
		$issueDao = DAORegistry::getDAO('IssueDAO');
		$issue = $issueDao->getCurrent($journal->getId(), true);
		if ($issue) {
			import('pages.issue.IssueHandler');
			IssueHandler::_setupIssueTemplate($request, $issue);
			$templateMgr->assign('currentIssue', $issue);
		}
		return false;
	}

	public function getDisplayName() {
		return __('plugins.themes.prototype.name');
	}

	public function getDescription() {
		return __('plugins.themes.prototype.description');
	}
}
