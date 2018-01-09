<?php

$connectionInfo = array( "UID"=>$DB_USERNAME,
    "PWD"=>$DB_PASSWORD,
    "Database"=>$DB_NAME);

$conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

$offset = 0;
$limit = 100;
$id = 0;
$titel = '';
$durchschnittsBewertung = 0.0;
$typ = '';
$link = '';

$procedure_params = array(
    array($offset, SQLSRV_PARAM_IN),
    array($limit, SQLSRV_PARAM_IN),
    array(&$id, SQLSRV_PARAM_INOUT),
    array(&$titel, SQLSRV_PARAM_INOUT),
    array(&$durchschnittsBewertung, SQLSRV_PARAM_INOUT),
    array(&$typ, SQLSRV_PARAM_INOUT),
    array(&$link, SQLSRV_PARAM_INOUT)
);
$sql = "EXEC usp_bilderAnzeigen @offset = ?, @limit = ?, @id = ?, @titel = ?, @durchschnittsBewertung = ?, @typ = ?, @link = ?";
$stmt = sqlsrv_prepare($conn, $sql, $procedure_params);

if(sqlsrv_execute($stmt)) {
    sqlsrv_next_result($stmt);
    for($i = 0; $i < $limit-$offset; $i++) {

        ?>

        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <a href="index.php?seite=funObjekt&id=<?php echo $id; ?>" class="index_link">
                    <div class="row">
                        <div class="col-md-12 objekte_titel"><?php echo $titel; ?>
                            <span class="objekte_ersteller">von Ersteller</span>
                        </div>
                    </div>
                    <div class="row objekte_object">
                        <img src="<?php echo $link; ?>" class="objekte_image" />
                    </div>
                    <div class="row">
                        <div class="col-md-6 objekte_datum">Hochgeladen am XX.XX.XXXX</div>
                        <div class="col-md-3 objekte_bewertung">Bewertung: <?php echo $durchschnittsBewertung; ?></div>
                    </div>
                </a>
            </div>
        </div>

        <?php

        sqlsrv_next_result($stmt);
    }
    sqlsrv_free_stmt($stmt);
}else{
    echo print_r(sqlsrv_errors(), true);
    $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Benutzer konnte nicht erstellt werden!';
}
sqlsrv_close($conn);

?>