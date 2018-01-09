<?php

// Redirect zu index wenn nicht eingeloggt
if(!isset($_SESSION['loginUsername'])){
    header('Location: home.php', true, 301);
    exit();
}

?>