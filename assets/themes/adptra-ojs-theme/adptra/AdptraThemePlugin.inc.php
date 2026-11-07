<?php
/**
 * @file plugins/themes/adptra/AdptraThemePlugin.inc.php
 * @class AdptraThemePlugin
 * @brief Accessible editorial theme for Open Journal Systems 3.3.
 *
 * This plugin intentionally extends OJS' Default Theme. Core OJS handles
 * authentication, navigation menus, logo uploads, search, issue objects,
 * announcements and article pages. The theme changes presentation only.
 */

import('lib.pkp.classes.plugins.ThemePlugin');

class AdptraThemePlugin extends ThemePlugin
{
    /**
     * Register inherited core features and journal-manager options.
     */
    public function init()
    {
        // Preserve the full Default Theme behavior, including reader/article
        // pages, navigation menus, galley rendering and accessibility helpers.
        $this->setParent('defaultthemeplugin');

        $this->addStyle('adptra-styles', 'styles/index.css');

        // Visual options. Text values are editorial copy, not sample content.
        $this->addOption('primaryColor', 'FieldColor', array(
            'label' => __('plugins.themes.adptra.option.primaryColor'),
            'description' => __('plugins.themes.adptra.option.primaryColor.description'),
            'default' => '#153b5b',
        ));
        $this->addOption('accentColor', 'FieldColor', array(
            'label' => __('plugins.themes.adptra.option.accentColor'),
            'description' => __('plugins.themes.adptra.option.accentColor.description'),
            'default' => '#87501e',
        ));
        $this->addOption('heroTitle', 'FieldText', array(
            'label' => __('plugins.themes.adptra.option.heroTitle'),
            'description' => __('plugins.themes.adptra.option.heroTitle.description'),
            'default' => '',
        ));
        $this->addOption('heroSubtitle', 'FieldTextarea', array(
            'label' => __('plugins.themes.adptra.option.heroSubtitle'),
            'description' => __('plugins.themes.adptra.option.heroSubtitle.description'),
            'default' => '',
        ));
        $this->addOption('heroEyebrow', 'FieldText', array(
            'label' => __('plugins.themes.adptra.option.heroEyebrow'),
            'description' => __('plugins.themes.adptra.option.heroEyebrow.description'),
            'default' => '',
        ));

        // Boolean options are represented with the FieldOptions radio widget
        // for compatibility with OJS 3.3's ThemePlugin option system.
        $this->addOption('showHero', 'FieldOptions', array(
            'type' => 'radio',
            'label' => __('plugins.themes.adptra.option.showHero'),
            'options' => array(
                array('value' => true, 'label' => __('plugins.themes.adptra.option.enabled')),
                array('value' => false, 'label' => __('plugins.themes.adptra.option.disabled')),
            ),
            'default' => true,
        ));
        $this->addOption('showHomepageImage', 'FieldOptions', array(
            'type' => 'radio',
            'label' => __('plugins.themes.adptra.option.showHomepageImage'),
            'options' => array(
                array('value' => true, 'label' => __('plugins.themes.adptra.option.enabled')),
                array('value' => false, 'label' => __('plugins.themes.adptra.option.disabled')),
            ),
            'default' => true,
        ));
        $this->addOption('showCurrentIssue', 'FieldOptions', array(
            'type' => 'radio',
            'label' => __('plugins.themes.adptra.option.showCurrentIssue'),
            'options' => array(
                array('value' => true, 'label' => __('plugins.themes.adptra.option.enabled')),
                array('value' => false, 'label' => __('plugins.themes.adptra.option.disabled')),
            ),
            'default' => true,
        ));
        $this->addOption('showAdditionalHomeContent', 'FieldOptions', array(
            'type' => 'radio',
            'label' => __('plugins.themes.adptra.option.showAdditionalHomeContent'),
            'options' => array(
                array('value' => true, 'label' => __('plugins.themes.adptra.option.enabled')),
                array('value' => false, 'label' => __('plugins.themes.adptra.option.disabled')),
            ),
            'default' => true,
        ));
        $this->addOption('showSearch', 'FieldOptions', array(
            'type' => 'radio',
            'label' => __('plugins.themes.adptra.option.showSearch'),
            'options' => array(
                array('value' => true, 'label' => __('plugins.themes.adptra.option.enabled')),
                array('value' => false, 'label' => __('plugins.themes.adptra.option.disabled')),
            ),
            'default' => true,
        ));
        $this->addOption('showAnnouncements', 'FieldOptions', array(
            'type' => 'radio',
            'label' => __('plugins.themes.adptra.option.showAnnouncements'),
            'options' => array(
                array('value' => true, 'label' => __('plugins.themes.adptra.option.enabled')),
                array('value' => false, 'label' => __('plugins.themes.adptra.option.disabled')),
            ),
            'default' => true,
        ));
        $this->addOption('showJournalDescription', 'FieldOptions', array(
            'type' => 'radio',
            'label' => __('plugins.themes.adptra.option.showJournalDescription'),
            'options' => array(
                array('value' => true, 'label' => __('plugins.themes.adptra.option.enabled')),
                array('value' => false, 'label' => __('plugins.themes.adptra.option.disabled')),
            ),
            'default' => true,
        ));
        $this->addOption('showEditorialLink', 'FieldOptions', array(
            'type' => 'radio',
            'label' => __('plugins.themes.adptra.option.showEditorialLink'),
            'options' => array(
                array('value' => true, 'label' => __('plugins.themes.adptra.option.enabled')),
                array('value' => false, 'label' => __('plugins.themes.adptra.option.disabled')),
            ),
            'default' => true,
        ));

        // Core Appearance controls own the actual journal logo and homepage
        // image uploads. This child theme reuses those uploads rather than
        // implementing a second file-upload/storage pipeline.
        HookRegistry::register('TemplateManager::display', array($this, 'injectThemeVariables'));
    }

    /**
     * Validate editable color values and retain the parent's persistence.
     *
     * @param string $name
     * @param mixed $value
     * @param int|null $contextId
     */
    public function saveOption($name, $value, $contextId = null)
    {
        if ($name === 'primaryColor' || $name === 'accentColor') {
            if (!is_string($value) || !preg_match('/^#[0-9a-fA-F]{6}$/', $value)) {
                $value = null;
            }
        }
        parent::saveOption($name, $value, $contextId);
    }

    /**
     * Inject scoped CSS custom properties into the rendered page head.
     * TemplateManager::display is used because OJS 3.3's theme settings are
     * persisted per journal and must affect every front-end page, not only
     * the homepage. Values are strictly validated before reaching CSS.
     *
     * @param string $hookName
     * @param array $args
     * @return bool
     */
    public function injectThemeVariables($hookName, $args)
    {
        // OJS 3.3 TemplateManager::display hook arguments are:
        // [$templateMgr, $template, $sendContentType, $charset, $output].
        // Add a normal OJS header asset instead of rewriting rendered markup;
        // this keeps the variables in <head> and lets OJS apply frontend scope.
        if (!isset($args[0]) || !is_object($args[0]) || !method_exists($args[0], 'addHeader')) {
            return false;
        }

        $primary = $this->getOption('primaryColor');
        $accent = $this->getOption('accentColor');
        if (!is_string($primary) || !preg_match('/^#[0-9a-fA-F]{6}$/', $primary)) {
            $primary = '#153b5b';
        }
        if (!is_string($accent) || !preg_match('/^#[0-9a-fA-F]{6}$/', $accent)) {
            $accent = '#87501e';
        }

        $style = '<style id="adptra-theme-variables">:root{--adptra-primary:' . $primary . ';--adptra-accent:' . $accent . ';}</style>';
        $templateMgr = $args[0];
        $templateMgr->addHeader('adptra-theme-variables', $style, array(
            'contexts' => array('frontend'),
        ));

        return false;
    }

    /**
     * @return string
     */
    public function getDisplayName()
    {
        return __('plugins.themes.adptra.name');
    }

    /**
     * @return string
     */
    public function getDescription()
    {
        return __('plugins.themes.adptra.description');
    }
}
