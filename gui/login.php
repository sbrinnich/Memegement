<?php

session_start();

// Redirect zu index wenn bereits eingeloggt
if(isset($_SESSION['loginUsername'])){
    header('Location: index.php', true, 301);
    exit();
}

// Prüfen ob Username und Passwort eingegeben wurden und korrekt sind
if(isset($_POST['username']) && isset($_POST['passwort'])){
    $hashedPasswort = hash('sha256', $_POST['passwort']);
    // TODO: Stored Procedure aufrufen zum checken
    $loginSuccess = true;
    if($loginSuccess){
        $_SESSION['loginUsername'] = $_POST['username'];
        header('Location: index.php', true, 301);
        exit();
    }else{
        $_SESSION['status'] = 'Login fehlgeschlagen! Bitte prüfe deine Eingaben und versuche es erneut!';
    }
}
?>

<html>
<head>
    <title>Memegement - Login</title>

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
            <a class="navbar-brand" href="index.php">Memegement</a>
        </div>

        <div class="collapse navbar-collapse" id="navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="index.php">Home</a></li>
                <li><a href="#">Bilder</a></li>
                <li><a href="videos.php">Videos</a></li>
                <li><a href="witze.php">Witze</a></li>
                <li><a href="gruppen.php">Gruppen</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <?php
                if(isset($_SESSION['loginUsername'])){
                    ?>
                    <li id="index_login"><?php echo $_SESSION['loginUsername']; ?></li>
                    <?php
                }else{
                    ?>
                    <li><a href="registrieren.php" id="index_login">Registrieren</a></li>
                    <li><a href="login.php" id="index_login">Login</a></li>
                    <?php
                }
                ?>
            </ul>
        </div>
    </div>
</nav>
<!-- END NAVBAR -->

<!-- CONTENT -->
<div class="container" id="login_content">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-4">
            <div class="row" id="login_headline">Login</div>
            <?php
            if(isset($_SESSION['status']) && $_SESSION['status'] != ''){
                ?>
                <div class="alert alert-warning"><?php echo $_SESSION['status']; ?></div>
                <?php
            }
            $_SESSION['status'] = '';
            ?>

            <form id="form_login" method="post" action="/login.php">
                <input type="text" class="form-control" name="username" placeholder="Username" /><br />
                <input type="password" class="form-control" name="passwort" placeholder="Passwort" /><br />
                <button type="submit" class="btn btn-primary" id="login_button">Login</button>
            </form>
        </div>
    </div>
</div>
<!-- END CONTENT -->
</body>
</html>