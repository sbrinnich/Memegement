<?php

if(!isset($_GET['id'])){
    header('Location: index.php?seite=home', true, 301);
    exit();
}


if(isset($_POST['kommentarText']) && $_POST['kommentarText'] != '' &&
    isset($_SESSION['loginUsername']) && $_SESSION['loginUsername'] != ''){

    $connectionInfo = array( "UID"=>$DB_USERNAME,
        "PWD"=>$DB_PASSWORD,
        "Database"=>$DB_NAME);

    $conn = sqlsrv_connect($DB_HOST, $connectionInfo);

    $benutzerId = 0;
    $procedure_params = array(
        array($_SESSION['loginUsername'], SQLSRV_PARAM_IN),
        array(&$benutzerId, SQLSRV_PARAM_INOUT)
    );
    $sql = "EXEC usp_benutzerIdSuchen @benutzerName = ?, @id = ?";
    $stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

    if(sqlsrv_execute($stmt)) {
        sqlsrv_next_result($stmt);

        $procedure_params = array(
            array($benutzerId, SQLSRV_PARAM_IN),
            array($_GET['id'], SQLSRV_PARAM_IN),
            array($_POST['kommentarText'], SQLSRV_PARAM_IN)
        );

        sqlsrv_free_stmt($stmt);

        $sql = "EXEC usp_funObjektKommentieren @kommentiererId = ?, @kommentarObjekt = ?, @text = ?";
        $stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

        if (sqlsrv_execute($stmt)) {
            sqlsrv_next_result($stmt);
            sqlsrv_free_stmt($stmt);
        } else {
            $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Benutzer konnte nicht erstellt werden!';
        }
    }else{
        $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Gruppe konnte nicht erstellt werden!';
    }
    sqlsrv_close($conn);
}

?>

<!-- DETAILS -->
<div class="row">
    <div class="col-md-7">
        <!-- TODO Placeholder für funObjekt (bild, video, witz) ersetzen -->
        <div style="background-color:black;height:300px;width:80%;"></div>
    </div>
    <div class="col-md-4" id="funObjekt_details">
        <!-- TODO Placeholder ersetzen -->
        <div class="row" id="funObjekt_titel">Title Placeholder</div>
        <div class="row" id="funObjekt_ersteller">von Troll Placeholder</div>
        <div class="row" id="funObjekt_erstellDatum">Hochgeladen am XX.XX.XXXX</div>
        <div class="row" id="funObjekt_bewertung">Durchschnittsbewertung:
            <span class="glyphicon glyphicon-star"></span>
            <span class="glyphicon glyphicon-star"></span>
            <span class="glyphicon glyphicon-star"></span>
            <span class="glyphicon glyphicon-star"></span>
            <span class="glyphicon glyphicon-star-empty"></span>
        </div>
        <?php
            if(isset($_SESSION['loginUsername']) && $_SESSION['loginUsername'] != '') {
                ?>
                <div class="row center_align">
                    <button id="funObjekt_buttonBewerten">Bewerten</button>
                </div>
                <div class="row center_align">
                    <!-- TODO Make button work -->
                    <button id="funObjekt_buttonProfilbild">Als Profilbild setzen</button>
                </div>
                <?php
            }
        ?>
        <div class="row center_align">
            <!-- TODO Make button work -->
            <button id="funObjekt_buttonGruppenbild">Als Gruppenbild setzen</button> <!-- TODO Nur anzeigen wenn Besitzer einer Gruppe -->
        </div>
    </div>
</div>
<!-- END DETAILS -->

<!-- KOMMENTARE -->
<div class="row" id="funObjekt_kommentarHeadline">Kommentare</div>
<?php
    if(isset($_SESSION['loginUsername']) && $_SESSION['loginUsername'] != '') {
        ?>
        <form method="post" action="index.php?seite=funObjekt&id=<?php echo $_GET['id']; ?>">
            <div class="row" id="funObjekt_writeKommentar">
                <input type="text" placeholder="Kommentieren..." id="funObjekt_kommentarInputField" name="kommentarText"/>
                <button type="submit" class="btn btn-primary">Senden</button> <!-- TODO Make button work -->
            </div>
        </form>
        <?php
    }
?>

<!-- TODO Alle verfügbaren Kommentare in diesem Format anzeigen -->
<div class="row kommentar">
    <div class="col-md-1">
        <div style="width:80%;height:40px;background-color:grey"></div>
    </div>
    <div class="col-md-10">
        <div class="row">
            <div class="kommentar_Head"><span class="kommentar_trollName">Troll</span> am XX.XX.XXXX um XX:XX</div>
            <span class="kommentar_text">Hier steht ein Placeholder für ein Kommentar!</span>
        </div>
    </div>
</div>
<!-- END KOMMENTARE -->