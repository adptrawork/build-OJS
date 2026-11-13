<?php
$p = '/home/gadingga/inventive-mauve-porcupine.101-50-1-74.cpanel.site/ojsData/journals/1/articles/6/article-6.pdf';
echo "open_basedir: " . ini_get('open_basedir') . "\n";
echo "exists: " . (file_exists($p) ? 'yes' : 'no') . "\n";
echo "is_file: " . (is_file($p) ? 'yes' : 'no') . "\n";
