# Developer notes

## Theme inheritance

The plugin is built for OJS 3.3's legacy plugin-loading convention:

- `index.php` includes `AdptraThemePlugin.inc.php` and returns the plugin instance.
- `AdptraThemePlugin` imports and extends `ThemePlugin`.
- `init()` calls `$this->setParent('defaultthemeplugin')`, then registers plain CSS, theme options and the frontend header hook.
- Dynamic colors are added with the OJS `TemplateManager::addHeader()` API; the hook does not mutate rendered HTML.
- `version.xml` declares `plugins.themes`, the class name and lazy loading.

Do not convert this plugin to the OJS 3.4+ namespace/autoload format while keeping the OJS 3.3 target.

## Adding an option

1. Register it in `AdptraThemePlugin::init()` using an option field supported by the installed OJS 3.3 version.
2. Add the key to both `locale/id_ID/locale.xml` and `locale/en_US/locale.xml`.
3. Read it in the Smarty template using `$activeTheme->getOption('optionName')`.
4. Sanitize values before using them in HTML, URLs or CSS. Do not echo arbitrary admin-supplied CSS/HTML without a deliberate sanitization policy.

## Template overrides

Only `frontend/pages/indexJournal.tpl` is replaced. Keep the original OJS templates for article, issue, search, login, registration and editorial pages inherited from the default theme. Prefer including core OJS objects (such as `frontend/objects/issue_toc.tpl`) rather than reimplementing core publication behavior.

## CSS

`styles/index.css` is plain CSS. Avoid adding a CSS framework or resetting OJS component styles globally. Keep focus indicators, reduced-motion support, and responsive layout rules in place.

## Theme options vs settings.xml

`settings.xml` is the plugin enablement state required by the PKP plugin settings schema. Theme visual options are declared through the official `ThemePlugin::addOption()` API and stored per journal by OJS; they are not duplicated as static values in `settings.xml`.
