<?php

// Redirect zu index wenn nicht eingeloggt
if(!isset($_SESSION['loginUsername'])){
    header('Location: index.php?seite=home', true, 301);
    exit();
}

// Prüfen ob alles eingegeben wurde
if(isset($_POST['gruppenname']) && isset($_POST['beschreibung'])){
    $connectionInfo = array( "UID"=>$DB_USERNAME,
        "PWD"=>$DB_PASSWORD,
        "Database"=>$DB_NAME);

    $conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

    $benutzerId = 0;
    $procedure_params = array(
        array($_SESSION['loginUsername'], SQLSRV_PARAM_IN),
        array(&$benutzerId, SQLSRV_PARAM_INOUT)
    );
    $sql = "EXEC usp_benutzerIdSuchen @benutzerName = ?, @id = ?";
    $stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

    if(sqlsrv_execute($stmt)){
        sqlsrv_next_result($stmt);

        $procedure_params = array(
            array($_POST['gruppenname'], SQLSRV_PARAM_IN),
            array($_POST['beschreibung'], SQLSRV_PARAM_IN),
            array($benutzerId, SQLSRV_PARAM_IN)
        );

        sqlsrv_free_stmt($stmt);

        $sql = "EXEC usp_gruppeAnlegen @name = ?, @beschreibung = ?, @gruenderId = ?";
        $stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

        if(sqlsrv_execute($stmt)) {
            sqlsrv_next_result($stmt);
            sqlsrv_free_stmt($stmt);
            $_SESSION['status'] = 'Gruppe wurde erfolgreich erstellt!';
        }else{
            $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Gruppe konnte nicht erstellt werden!';
        }
    }else{
        $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Gruppe konnte nicht erstellt werden!';
    }
    sqlsrv_close($conn);
}

?>

<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-4">
        <div class="row" id="gruppeErstellen_headline">Neue Gruppe erstellen</div>
        <?php
        if(isset($_SESSION['status']) && $_SESSION['status'] != ''){
            ?>
            <div class="alert alert-warning"><?php echo $_SESSION['status']; ?></div>
            <?php
        }
        $_SESSION['status'] = '';
        ?>

        <form class="form" method="post" action="?seite=gruppeErstellen">
            <input type="text" class="form-control" name="gruppenname" placeholder="Gruppenname" /><br />
            <textarea class="form-control" name="beschreibung" placeholder="Beschreibung"></textarea><br />
            <button type="submit" class="btn btn-primary" class="form_button">Erstellen</button>
        </form>
    </div>
</div>