<html>
<head>
    <title>Memegement - Detailansicht</title>

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
            <a class="navbar-brand" href="index.php">Memegement</a>
        </div>

        <div class="collapse navbar-collapse" id="navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="index.php">Home</a></li>
                <li><a href="bilder.php">Bilder</a></li>
                <li><a href="videos.php">Videos</a></li>
                <li><a href="witze.php">Witze</a></li>
                <li><a href="gruppen.php">Gruppen</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#" id="index_login">Login</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- END NAVBAR -->

<!-- CONTENT -->
<div class="container" id="funObjekt_content">
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
            <div class="row center_align">
                <button id="funObjekt_buttonBewerten">Bewerten</button> <!-- TODO Nur anzeigen wenn eingeloggt -->
            </div>
            <div class="row center_align">
                <!-- TODO Make button work -->
                <button id="funObjekt_buttonProfilbild">Als Profilbild setzen</button> <!-- TODO Nur anzeigen wenn eingeloggt -->
            </div>
            <div class="row center_align">
                <!-- TODO Make button work -->
                <button id="funObjekt_buttonGruppenbild">Als Gruppenbild setzen</button> <!-- TODO Nur anzeigen wenn Besitzer einer Gruppe -->
            </div>
        </div>
    </div>
    <!-- END DETAILS -->

    <!-- KOMMENTARE -->
    <div class="row" id="funObjekt_kommentarHeadline">Kommentare</div>
    <div class="row" id="funObjekt_writeKommentar">
        <input type="text" placeholder="Kommentieren..." id="funObjekt_kommentarInputField" />
        <button>Senden</button> <!-- TODO Make button work -->
    </div>

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
</div>
<!-- END CONTENT -->
</body>
</html>