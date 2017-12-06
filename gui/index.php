<?php

	session_start();

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
            <!-- NAVBAR -->
            <nav class="navbar navbar-inverse">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">Memegement</a>
                    </div>

                    <div class="collapse navbar-collapse" id="navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="#">Index</a></li>
                            <li><a href="#">Bilder</a></li>
                            <li><a href="#">Videos</a></li>
                            <li><a href="#">Witze</a></li>
                            <li><a href="#">Gruppen</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#" id="index_login">Login</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
            <!-- END NAVBAR -->

            <!-- CONTENT -->
            <div class="container-fluid" id="index_content">
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-3">
                        <div class="panel panel-default index_panel">
                            <div class="panel-body index_panelbody index_panelleft">
                                Bilder
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-default index_panel">
                            <div class="panel-body index_panelbody index_panelright">
                                Videos
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-3">
                        <div class="panel panel-default index_panel">
                            <div class="panel-body index_panelbody index_panelleft">
                                Witze
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-default index_panel">
                            <div class="panel-body index_panelbody index_panelright">
                                Gruppen
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END CONTENT -->
    </body>
</html>