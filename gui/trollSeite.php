<?php

$connectionInfo = array( "UID"=>$DB_USERNAME,
    "PWD"=>$DB_PASSWORD,
    "Database"=>$DB_NAME);

$conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

$benutzerName = $_SESSION['loginUsername'];
$id = 0;

$procedure_params = array(
    array($benutzerName, SQLSRV_PARAM_IN),
    array(&$id, SQLSRV_PARAM_INOUT),
);

$sql = "EXEC usp_benutzerIdSuchen @benutzerName = ?, @id = ? ";
$stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

if(sqlsrv_execute($stmt)) {
    sqlsrv_next_result($stmt);

    sqlsrv_free_stmt($stmt);


    sqlsrv_close($conn);
}else{
    $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Benutzer konnte nicht erstellt werden!';
    sqlsrv_close($conn);
}

$conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

$procedure_params = array(
    array($id, SQLSRV_PARAM_IN)
);

$sql = "EXEC usp_benutzerProfilAnzeigen @id = ?";
$stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

if(sqlsrv_execute($stmt)) {
    do{
        while($row = sqlsrv_fetch_array($stmt)){
            ?>

            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <?php
                    echo '<img class="img-group" src="'.$row['link'].'" /><h1>'.$row['benutzerName'].'</h1><h3>'.$row['beitrittsDatum']->format('Y-m-d').'</h3>';
                    ?>
                </div>
            </div>

            <?php
        }
    }while(sqlsrv_next_result($stmt));
    sqlsrv_free_stmt($stmt);


    sqlsrv_close($conn);
}else{
    $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Benutzer konnte nicht erstellt werden!';
    sqlsrv_close($conn);
}

?>

<?php
$conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

$procedure_params = array(
array($id, SQLSRV_PARAM_IN)
);

$sql = "EXEC usp_benutzerWitzeAnzeigenNachBewertung @id = ?,@offset = ? ,@limit = ?";
$stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

if(sqlsrv_execute($stmt)) {
do{
while($row = sqlsrv_fetch_array($stmt)){
?>


    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-3">
                <div class="panel panel-default index_panel">

                    <div class="panel-body index_panelbody index_panelleft">
                        Neueste Beiträge
                    </div>
                    <div class="panel-body index_panelbody index_panelleft">
                        <div class="col-md-3">
                            <p style="color: white">Video</p>
                        </div>
                        <div class="col-md-3">
                            <p style="color: white">Bild</p>
                        </div>
                        <div class="col-md-3">
                            <p style="color: white">Witz</p>
                        </div>
                    </div>
                    <div class="panel-body index_panelbody index_panelleft">
                    </div>
                </div>
        </div>

        <div class="col-md-3">
            <div class="panel panel-default index_panel">
                <div class="panel-body index_panelbody index_panelright">
                    Beste Bewertungen
                </div>
                <div class="panel-body index_panelbody index_panelleft">
                    <div class="col-md-3">
                        <p style="color: white">Video</p>
                    </div>
                    <div class="col-md-3">
                        <p style="color: white">Bild</p>
                    </div>
                    <div class="col-md-3">
                        <p style="color: white">Witz</p>
                        <?php
                        echo '<h1>'.$row['text'].'</h1>';
                        ?>
                    </div>
                </div>
                <div class="panel-body index_panelbody index_panelleft">

                </div>
            </div>
        </div>
    </div>


    <?php
}
}while(sqlsrv_next_result($stmt));
    sqlsrv_free_stmt($stmt);


    sqlsrv_close($conn);
}else{
    $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Benutzer konnte nicht erstellt werden!';
    sqlsrv_close($conn);
}
?>