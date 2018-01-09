<?php

// Redirect zu index wenn bereits eingeloggt
if(isset($_SESSION['loginUsername'])){
    header('Location: index.php?seite=home', true, 301);
    exit();
}

// Prüfen ob alles eingegeben wurde
if(isset($_POST['username']) && isset($_POST['passwort']) && isset($_POST['passwort_repeat'])){
    if($_POST['passwort'] != $_POST['passwort_repeat']){
        $_SESSION['status'] = 'Passwörter stimmen nicht überein! Bitte versuche es erneut!';
    }else {
        $hashedPasswort = hash('sha256', $_POST['passwort']);

        // TODO: Stored Procedure aufrufen zum abspeichern





        $_SESSION['loginUsername'] = $_POST['username'];
        header('Location: index.php?seite=home', true, 301);
        exit();
    }
}

?>
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-4">
        <div class="row" id="register_headline">Registrieren</div>
        <?php
        if(isset($_SESSION['status']) && $_SESSION['status'] != ''){
            ?>
            <div class="alert alert-warning"><?php echo $_SESSION['status']; ?></div>
            <?php
        }
        $_SESSION['status'] = '';
        ?>

        <form id="form_register" method="post" action="?seite=registrieren">
            <input type="text" class="form-control" name="username" placeholder="Username" /><br />
            <input type="password" class="form-control" name="passwort" placeholder="Passwort" /><br />
            <input type="password" class="form-control" name="passwort_repeat" placeholder="Passwort Wiederholen" /><br />
            <button type="submit" class="btn btn-primary" id="register_button">Registrieren</button>
        </form>
    </div>
</div>