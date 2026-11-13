<?php
require '../tools/bootstrap.inc.php';
import('classes.core.Services');
$svc = Services::get('file');
$fs = $svc->fs;
$adapter = $fs->getAdapter();
$path = 'journals/1/articles/6/article-6.pdf';
$loc = $adapter->applyPathPrefix($path);
$p = '/home/gadingga/inventive-mauve-porcupine.101-50-1-74.cpanel.site/ojsData/journals/1/articles/6/article-6.pdf';
echo "loc === p: " . var_export($loc === $p, true) . "\n";
echo "strlen loc: " . strlen($loc) . " strlen p: " . strlen($p) . "\n";
echo "loc hex: " . bin2hex($loc) . "\n";
echo "p   hex: " . bin2hex($p) . "\n";
echo "file_exists(loc): " . var_export(file_exists($loc), true) . "\n";
echo "file_exists(p): " . var_export(file_exists($p), true) . "\n";
