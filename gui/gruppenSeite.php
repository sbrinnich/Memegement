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

echo "test 0";

if(sqlsrv_execute($stmt)) {
    echo "test 1";
    sqlsrv_next_result($stmt);

    echo "TEST 2";

    ?>

    <img src="<?php echo $gruppenBildLink ?>">


    <?php

}else{
    echo "Error Executing";
    echo print_r(sqlsrv_errors(), true);
}


?>