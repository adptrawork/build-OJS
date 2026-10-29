<?php
require __DIR__ . '/../ojs/tools/bootstrap.php';
use PKP\plugins\PluginRegistry;
use APP\core\Application;
$request = Application::get()->getRequest();
$themes = PluginRegistry::loadCategory('themes');
foreach ($themes as $class => $p) echo get_class($p), "\n";
$context = $request->getContext();
echo "context: ", $context ? $context->getPath() : 'none', "\n";
echo "themePluginPath: ", $context ? $context->getData('themePluginPath') : '-', "\n";
