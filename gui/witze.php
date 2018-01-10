<?php

$connectionInfo = array( "UID"=>$DB_USERNAME,
    "PWD"=>$DB_PASSWORD,
    "Database"=>$DB_NAME);

$conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

$offset = 0;
$limit = 100;

$procedure_params = array(
    array($offset, SQLSRV_PARAM_IN),
    array($limit, SQLSRV_PARAM_IN)
);
$sql = "EXEC usp_witzeAnzeigen @offset = ?, @limit = ?";
$stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

if(sqlsrv_execute($stmt)) {
    do{
        while($row = sqlsrv_fetch_array($stmt)){
            ?>

            <div class="row funObjekt_container">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                    <a href="index.php?seite=funObjekt&id=<?php echo $row['id']; ?>" class="index_link">
                        <div class="row">
                            <div class="col-md-12 objekte_titel"><?php echo $row['titel']; ?>
                                <span class="objekte_ersteller">von <?php echo $row['benutzerName']; ?></span>
                            </div>
                        </div>
                        <div class="row objekte_object">
                            <img src="<?php echo $row['link']; ?>" class="objekte_image" />
                        </div>
                        <div class="row">
                            <div class="col-md-6 objekte_datum">Hochgeladen am <?php echo $row['uploadDatum']->format('Y-m-d'); ?></div>
                            <div class="col-md-3 objekte_bewertung">Bewertung: <?php echo $row['durchschnittsBewertung']; ?></div>
                        </div>
                    </a>
                </div>
            </div>

            <?php
        }
    }while(sqlsrv_next_result($stmt));

    sqlsrv_free_stmt($stmt);
}else{
    echo print_r(sqlsrv_errors(), true);
    $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Benutzer konnte nicht erstellt werden!';
}
sqlsrv_close($conn);

?>