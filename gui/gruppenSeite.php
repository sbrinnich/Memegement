<?php

// Redirect zu index wenn nicht eingeloggt
if(!isset($_SESSION['loginUsername'])){
    header('Location: index.php?seite=home', true, 301);
    exit();
}

$currentGroupID = 1;

if(isset($_GET["groupID"])){
    $currentGroupID = $_GET["groupID"];
}



$name = '';
$beschreibung = '';
$gruendungsDatum = '';
$gruenderName = '';
$mitgliederAnzahl = '';
$gruppenBildLink = '';

$groupInformation = array(
    array($currentGroupID, SQLSRV_PARAM_IN),
    array(&$name, SQLSRV_PARAM_INOUT),
    array(&$beschreibung, SQLSRV_PARAM_INOUT),
    array(&$gruendungsDatum, SQLSRV_PARAM_INOUT),
    array(&$gruenderName, SQLSRV_PARAM_INOUT),
    array(&$mitgliederAnzahl, SQLSRV_PARAM_INOUT),
    array(&$gruppenBildLink, SQLSRV_PARAM_INOUT)
);

$connectionInfo = array( "UID"=>$DB_USERNAME,
    "PWD"=>$DB_PASSWORD,
    "Database"=>$DB_NAME);

$conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

$sql = "EXEC usp_gruppenDatenAnzeigen @id = ? , @name = ? , @beschreibung = ? , @gruendungsDatum = ? , @gruenderName = ? , @mitgliederAnzahl = ? , @gruppenBildLink = ?";
$stmt = sqlsrv_prepare($conn, $sql, $groupInformation);

if(sqlsrv_execute($stmt)) {
    sqlsrv_next_result($stmt);

    ?>

    <img class="img-group" src="<?php echo $gruppenBildLink ?>">
    <div class="div-group-site">
        <h1 class="group-name-xxl"><?php echo $name ?></h1><br/><br/>
        <h2 class="group-creator">Gegründet von: <?php echo $gruenderName ?></h2><br/><br/>
        <h3 class="group-date">am: <?php echo $gruendungsDatum ?></h3><br/><br/>
        <h3 class="group-members"><?php echo $mitgliederAnzahl ?> Mitglieder</h3><br/><br/><br/><br/>
        <form method="post" action=#>
            <input value="Gruppe beitreten" class="btn btn-primary" type="submit" name="join_group"/>
        </form>
    </div>


    <?php
    sqlsrv_free_stmt($stmt);
    sqlsrv_close($conn);
}else{
    echo print_r(sqlsrv_errors(), true);
}

if(isset($_POST["join_group"])) {
    $CurrentUserID = 0;

    $parameterGetID = array(
        array($_SESSION['loginUsername'] , SQLSRV_PARAM_IN),
        array(&$CurrentUserID , SQLSRV_PARAM_INOUT)
    );

    $connectionInfo = array( "UID"=>$DB_USERNAME,
        "PWD"=>$DB_PASSWORD,
        "Database"=>$DB_NAME);

    $conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

    $sql = "EXEC usp_benutzerIdSuchen @benutzerName = ? , @id = ?";
    $stmt = sqlsrv_prepare($conn, $sql, $parameterGetID);

    if(sqlsrv_execute($stmt)){
        sqlsrv_next_result($stmt);

        if($CurrentUserID != 0){
            $joinGroupParameter = array(
                    array($CurrentUserID, SQLSRV_PARAM_IN),
                    array($currentGroupID, SQLSRV_PARAM_IN)
            );
            $sql = "EXEC usp_gruppeBeitreten @trollId = ? , @gruppenId = ?";
            $stmt = sqlsrv_prepare($conn, $sql, $joinGroupParameter);

            if(sqlsrv_execute($stmt)){
                sqlsrv_next_result($stmt);

            }else{
                echo print_r(sqlsrv_errors(), true);
            }

        }else{
            echo "No User-ID found!";
        }
    }else{
        echo print_r(sqlsrv_errors(), true);
    }

    sqlsrv_free_stmt($stmt);
    sqlsrv_close($conn);

}

?>