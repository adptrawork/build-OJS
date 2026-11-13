<?php

/**
 * @file plugins/themes/sangulineModern/SangulineModernThemePlugin.inc.php
 *
 * @class SangulineModernThemePlugin
 * @ingroup plugins_themes_sangulinemodern
 *
 * @brief Sanguline Modern child theme for OJS 3.3 (extends Sanguline).
 */

import('lib.pkp.classes.plugins.ThemePlugin');

class SangulineModernThemePlugin extends ThemePlugin {

	/**
	 * @copydoc ThemePlugin::isActive()
	 */
	public function isActive() {
		if (defined('SESSION_DISABLE_INIT')) {
			return true;
		}
		return parent::isActive();
	}

	/**
	 * Initialize the theme.
	 *
	 * @return null
	 */
	public function init() {
		$this->setParent('sangulinethemeplugin');

		// Load locale data for the active request locale (parent only loads
		// its default locale at registration time, so id_ID keys fall back
		// to en_US). getLocaleFilename() below resolves id_ID -> id.
		AppLocale::requireComponents(LOCALE_COMPONENT_PKP_MANAGER, LOCALE_COMPONENT_APP_MANAGER);
		$this->addLocaleData(AppLocale::getLocale());

		// Drop the parent visual layer. The parent JS stays because it powers
		// dropdowns, the abstract toggle, registration toggles and the slider.
		$this->removeStyle('stylesheet');
		$this->removeStyle('font');

		// Parent Bootstrap 4 scripts and main.js are replaced by Bootstrap 5
		// bundle + jrdc.js. jQuery stays because OJS core/plugins use it.
		$this->removeScript('popper');
		$this->removeScript('bsUtil');
		$this->removeScript('bsDropdown');
		$this->removeScript('default');

		// Parent JS URLs contain Windows backslashes (ThemePlugin::_getBaseUrl uses
		// DIRECTORY_SEPARATOR) and return 404 on Apache. Re-register the remaining
		// parent script with a forward-slash URL.
		$request = Application::get()->getRequest();
		$base = $request->getBaseUrl();
		$this->addScript('announcementSlider', $base . '/plugins/themes/sanguline/js/announcement-slider.js', ['baseUrl' => '']);
		$this->addScript('bootstrap', $base . '/plugins/themes/sangulineModern/vendor/bootstrap/bootstrap.bundle.min.js', ['baseUrl' => '']);
		$this->addScript('jrdc', $base . '/plugins/themes/sangulineModern/js/jrdc.js?v=3.3.0.25', ['baseUrl' => '']);

		// Explicitly register navigation menu areas
		$this->addMenuArea(['primary', 'user', 'sidebar']);

		// Geist only. Material Symbols was loaded but never used.
		$this->addStyle(
			'fontGeist',
			'https://fonts.googleapis.com/css2?family=Geist:wght@400;500;600;700&display=swap',
			['baseUrl' => '']
		);

		$this->addOption('modernAccent', 'FieldColor', [
			'label' => 'Modern accent color',
			'description' => 'Optional accent color for Sanguline Modern highlights (hex, e.g. #c2410c). Default is burnt orange (prototype).',
			'default' => '#c2410c',
		]);

		$this->addOption('publishFrequency', 'FieldText', [
			'label' => 'Publication frequency',
			'description' => 'How often the journal is published (shown in the homepage hero, e.g. "April & Oktober").',
			'default' => 'April & Oktober',
		]);

		$this->addOption('heroBadge', 'FieldText', [
			'label' => 'Hero badge',
			'description' => 'Small text badge above the journal name on the homepage hero (e.g. "SCHOLARLY JOURNAL • ECONOMICS AND BUSINESS").',
			'default' => 'SCHOLARLY JOURNAL • ECONOMICS AND BUSINESS',
		]);

		// Bootstrap 5.3.3, vendored locally. Absolute URL avoids Windows backslashes.
		$this->addStyle(
			'bootstrap',
			$base . '/plugins/themes/sangulineModern/vendor/bootstrap/bootstrap.min.css',
			['baseUrl' => '']
		);

		// The parent's init() never runs for a child theme, so its scripts
		// (including jQuery) silently never load — this broke the pdfJsViewer
		// galley page (its inline script fills the iframe src with $(document).ready).
		// Register jQuery (parent expected it to stay too).
		$this->addScript(
			'jQuery',
			$base . '/lib/pkp/lib/vendor/components/jquery/jquery.min.js',
			['baseUrl' => '']
		);

		// Bootstrap Icons via CDN (replaced the parent's dropped Font Awesome
		// layer; fa-* icons never rendered in this child).
		$this->addStyle(
			'bootstrapIcons',
			'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css',
			['baseUrl' => '']
		);

		// Font Awesome is already loaded by core frontend CSS.
		$this->addStyle('stylesheetModern', 'styles/index.less');

		$accent = $this->getOption('modernAccent');
		if (!$accent || !preg_match('/^#[0-9a-fA-F]{3,6}$/', $accent)) {
			$accent = '#c2410c';
		}
		$this->modifyStyle('stylesheetModern', [
			'addLessVariables' => "@modern-primary: {$accent};\n@modern-navy: #0b2038;\n",
		]);
	}

	/**
	 * Get the name of the settings file to be installed on new context creation.
	 *
	 * @return string
	 */
	public function getContextSpecificPluginSettingsFile() {
		return $this->getPluginPath() . '/settings.xml';
	}

	/**
	 * Get the name of the settings file to be installed site-wide.
	 *
	 * @return string
	 */
	public function getInstallSitePluginSettingsFile() {
		return $this->getPluginPath() . '/settings.xml';
	}

	/**
	 * @copydoc ThemePlugin::saveOption()
	 */
	public function saveOption($name, $value, $contextId = null) {
		if ($name == 'modernAccent') {
			if ($value !== '' && $value !== null && !preg_match('/^#[0-9a-fA-F]{3,6}$/', $value)) {
				$value = '';
			}
		}
		parent::saveOption($name, $value, $contextId);
	}

	/**
	 * Usage statistics chart rendering compatibility on OJS 3.3.
	 *
	 * @return bool
	 */
	public function supportsUsageStats() {
		return false;
	}

	/**
	 * Map OJS 3.3 locale keys to the locale folders bundled with this theme.
	 * Mirrors the parent Sanguline implementation so id_ID resolves to the
	 * bundled `id` locale (instead of the missing `id_ID` folder).
	 *
	 * @param string $locale
	 * @return array
	 */
	public function getLocaleFilename($locale) {
		$localeFiles = [];

		foreach ($this->getLocaleCandidates(MASTER_LOCALE) as $candidate) {
			$localePath = $this->getPluginPath() . '/locale/' . $candidate . '/locale.po';
			if (file_exists($localePath)) {
				$localeFiles[] = $localePath;
				break;
			}
		}

		foreach ($this->getLocaleCandidates($locale) as $candidate) {
			$localePath = $this->getPluginPath() . '/locale/' . $candidate . '/locale.po';
			if (file_exists($localePath)) {
				$localeFiles[] = $localePath;
				break;
			}
		}

		return array_values(array_unique($localeFiles));
	}

	/**
	 * Build locale candidates for OJS 3.3 locale keys.
	 *
	 * @param string $locale
	 * @return array
	 */
	protected function getLocaleCandidates($locale) {
		$aliases = [
			'en_US' => 'en',
			'id_ID' => 'id',
		];

		$candidates = [$locale];

		if (isset($aliases[$locale])) {
			$candidates[] = $aliases[$locale];
		}

		if (strpos($locale, '_') !== false) {
			$candidates[] = substr($locale, 0, strpos($locale, '_'));
		}

		return array_values(array_unique(array_filter($candidates)));
	}

	/**
	 * Get the display name of this plugin.
	 *
	 * @return string
	 */
	public function getDisplayName() {
		return 'Sanguline Modern Theme';
	}

	/**
	 * Get the description of this plugin.
	 *
	 * @return string
	 */
	public function getDescription() {
		return 'A modern academic child theme for Sanguline (OJS 3.3), with refined typography, spacing, cards, and navigation while preserving Sanguline compatibility.';
	}
}
