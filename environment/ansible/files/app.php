<?php

// trying to connect to external website
$fp = fsockopen("www.example.com", 80, $errno, $errstr, 30);
if (!$fp) {
        echo "$errstr ($errno)<br /><br />\n";
        echo "<img src='crying_cat.jpg' />";
} else {
        echo "External access possible<br /><br />\n";
        echo "<img src='happy_cat.jpg' />";
}

?>
