<?php

// Redirect zu index wenn nicht eingeloggt
if(!isset($_SESSION['loginUsername'])){
    header('Location: index.php?seite=home', true, 301);
    exit();
}

?>