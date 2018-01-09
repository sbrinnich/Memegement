<?php

// Redirect zu index wenn nicht eingeloggt
if (!isset($_SESSION['loginUsername'])) {
    header('Location: index.php?seite=home', true, 301);
    exit();
}

?>
<div>
    <a href="?seite=gruppeErstellen" class="btn btn-default">Neue Gruppe erstellen</a>
</div><br/>


<?php
    $allElements[] = null;

    $connectionInfo = array("UID" => $DB_USERNAME,
        "PWD" => $DB_PASSWORD,
        "Database" => $DB_NAME);

    $conn = sqlsrv_connect($DB_HOST, $connectionInfo);

    //$procedure_params = "";
    $stmt = sqlsrv_prepare($conn, "Select * from vi_alleGruppenNachNamen");

    if (sqlsrv_execute($stmt)) {

        while ($row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC ))
        {
            ?>
                <div class="groupElement">
                    <img src="<?php echo $row["link"]; ?>" class="img-circle">
                    <a href="index.php?seite=gruppenSeite&groupID=<?php echo $row["id"] ?>"><h1 class="groupname"><?php echo $row["name"]; ?></h1></a>
                    <h3 class="membercount"><?php echo $row["mitgliederAnzahl"]; ?> Mitglieder</h3>
                </div>

            <?php

        }

        sqlsrv_free_stmt($stmt);
        sqlsrv_close($conn);
    }

?>
