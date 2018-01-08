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