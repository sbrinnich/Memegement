<?php

session_start();

if(!isset($_SESSION['currentPage'])){
    $_SESSION['currentPage'] = 'home';
}

if(isset($_GET['seite'])){
    $_SESSION['currentPage'] = $_GET['seite'];
}
include_once "conf.php";

?>

<html>
<head>
    <title>Memegement</title>

    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet"
          href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="style.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="?seite=home">Memegement</a>
        </div>

        <div class="collapse navbar-collapse" id="navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li <?php if($_SESSION['currentPage'] == 'home') echo 'class="active"'; ?>><a href="?seite=home">Home</a></li>
                <li <?php if($_SESSION['currentPage'] == 'bilder') echo 'class="active"'; ?>><a href="?seite=bilder">Bilder</a></li>
                <li <?php if($_SESSION['currentPage'] == 'videos') echo 'class="active"'; ?>><a href="?seite=videos">Videos</a></li>
                <li <?php if($_SESSION['currentPage'] == 'witze') echo 'class="active"'; ?>><a href="?seite=witze">Witze</a></li>
                <li <?php if($_SESSION['currentPage'] == 'troll') echo 'class="active"'; ?>><a href="?seite=troll">Troll</a></li>
                <li <?php if($_SESSION['currentPage'] == 'gruppen') echo 'class="active"'; ?>><a href="?seite=gruppen">Gruppen</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <?php
                if(isset($_SESSION['loginUsername'])){
                    ?>
                    <li id="index_login"><?php echo $_SESSION['loginUsername']; ?></li>
                    <?php
                }else{
                    ?>
                    <li><a href="?seite=registrieren" id="index_login">Registrieren</a></li>
                    <li><a href="?seite=login" id="index_login">Login</a></li>
                    <?php
                }
                ?>
            </ul>
        </div>
    </div>
</nav>
<!-- END NAVBAR -->

<!-- CONTENT -->
<div class="container" id="content">
    <?php
    switch($_SESSION['currentPage']){
        case 'bilder': include_once "bilder.php";break;
        case 'videos': include_once "videos.php";break;
        case 'witze': include_once "witze.php";break;
        case 'troll': include_once "trollSeite.php";break;
        case 'gruppen': include_once "gruppen.php";break;
        case 'login': include_once "login.php";break;
        case 'registrieren': include_once "registrieren.php";break;
        case 'gruppeErstellen': include_once "gruppeErstellen.php";break;
        default: include_once "home.php";break;
    }

    ?>
</div>
<!-- END CONTENT -->
</body>
</html>