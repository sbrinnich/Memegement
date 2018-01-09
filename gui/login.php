<?php

// Redirect zu index wenn bereits eingeloggt
if(isset($_SESSION['loginUsername'])){
    header('Location: index.php?seite=home', true, 301);
    exit();
}

// Prüfen ob Username und Passwort eingegeben wurden und korrekt sind
if(isset($_POST['username']) && isset($_POST['passwort'])){
    $hashedPasswort = hash('sha256', $_POST['passwort']);

    $connectionInfo = array( "UID"=>$DB_USERNAME,
        "PWD"=>$DB_PASSWORD,
        "Database"=>$DB_NAME);

    $conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

    $hashedPasswort = hash('sha256', $_POST['passwort']);
    $returnValue = 0;

    $procedure_params = array(
        array($_POST['username'], SQLSRV_PARAM_IN),
        array($hashedPasswort, SQLSRV_PARAM_IN),
        array(&$returnValue, SQLSRV_PARAM_INOUT)
    );
    $sql = "EXEC usp_benutzerLoginCheck @benutzerName = ?, @passwortHash = ?, @benutzerAnzahl = ?";
    $stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

    if(sqlsrv_execute($stmt)) {
        sqlsrv_next_result($stmt);

        if($returnValue == 1){
            $_SESSION['loginUsername'] = $_POST['username'];
        }else{
            $_SESSION['status'] = 'Login fehlgeschlagen! Bitte prüfe deine Eingaben und versuche es erneut!';
        }

        sqlsrv_free_stmt($stmt);
        sqlsrv_close($conn);

        if($returnValue == 1) {
            header('Location: index.php?seite=home', true, 301);
            exit();
        }
    }else{
        $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Eingaben konnten nicht überprüft werden!';
        sqlsrv_close($conn);
    }

}
?>

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

        <form id="form_login" method="post" action="?seite=login">
            <input type="text" class="form-control" name="username" placeholder="Username" /><br />
            <input type="password" class="form-control" name="passwort" placeholder="Passwort" /><br />
            <button type="submit" class="btn btn-primary" id="login_button">Login</button>
        </form>
    </div>
</div>