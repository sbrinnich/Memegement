<?php


?>

<html>
<head>
    <title>Memegement</title>

    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet"
          href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="style.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<!-- CONTENT -->


    <div class="row">
        <div class="col-md-4"></div>
            <div class="col-md-4">
                <?php

                $connectionInfo = array( "UID"=>$DB_USERNAME,
                    "PWD"=>$DB_PASSWORD,
                    "Database"=>$DB_NAME);

                $conn = sqlsrv_connect( $DB_HOST, $connectionInfo);

                //Statisch
                $Id = 1;
                $Trollname = '';

                $procedure_params = array(
                    array($Id, SQLSRV_PARAM_IN),
                    array(&$Troll, SQLSRV_PARAM_INOUT)
                );
                $sql = "EXEC usp_benutzerProfilAnzeigen @id = ?,@benutzerName ";
                $stmt = sqlsrv_prepare($conn, $sql, $procedure_params);



                if(sqlsrv_execute($stmt)) {
                    sqlsrv_next_result($stmt);

                    sqlsrv_free_stmt($stmt);


                    sqlsrv_close($conn);
                    exit();
                }else{
                    $_SESSION['status'] = 'Ein Fehler ist aufgetreten! Benutzer konnte nicht erstellt werden!';
                }
                sqlsrv_close($conn);



                echo "<h1> " + $_SESSION['loginUsername'] +" </h1>"
                    ;
                ?>
            </div>
        </div>
    </div>

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
                        <?php

                        ?>
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
                        </div>
                    </div>
                    <div class="panel-body index_panelbody index_panelleft">
                        <?php

                        ?>
                    </div>
                </div>
        </div>
    </div>

<!-- END CONTENT -->
</body>
</html>

