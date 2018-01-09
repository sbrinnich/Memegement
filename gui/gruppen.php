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


<!--<div class="dropdown pull-right">-->
<!--    <a class="dropdown-toggle text-muted" data-toggle="dropdown" href="#" id="dropdown-sortmode" title="Sort">-->
<!--        <small><span class="glyphicon glyphicon-sort"></span>&nbsp;Sort</small>-->
<!--    </a>-->
<!--    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdown-sortmode">-->
<!--        <li role="menuitem"><a href=# id="date"><span class="glyphicon glyphicon-sort-by-attributes-alt"></span> Nach Erstellungsdatum</a></li>-->
<!--        <li role="menuitem"><a href=# id="memberCount"><span class="glyphicon glyphicon-sort-by-order-alt"></span> Nach Mitgliederanzahl</a></li>-->
<!--        <li role="menuitem"><a href=# id="name"><span class="glyphicon glyphicon-sort-by-alphabet"></span> Nach Namen</a></li>-->
<!--    </ul>-->
<!--</div>-->

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
                    <h1 class="groupname"><?php echo $row["name"]; ?></h1>
                    <h2 class="membercount"><?php echo $row["mitgliederAnzahl"]; ?> Mitglieder</h2>
                </div>

            <?php

        }

        sqlsrv_free_stmt($stmt);
        sqlsrv_close($conn);
    }

?>
