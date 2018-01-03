Use Memegement;
GO

-- delete old data first

TRUNCATE TABLE Troll;
TRUNCATE TABLE FunObjekt;
TRUNCATE TABLE Bild;
TRUNCATE TABLE Video;
TRUNCATE TABLE Witz;
TRUNCATE TABLE Gruppe;
TRUNCATE TABLE Bewertung;
TRUNCATE TABLE Kommentar;
TRUNCATE TABLE GruppenMitgliedschaft;

GO

-- insert basic data

Insert into Troll ( benutzerName, passwortHash, beitrittsDatum, profilBild) values
  ( 'Troll1' , 'Troll1' , '2010-10-20' , 1 ),
  ( 'Troll2' , 'Troll2' , '2011-10-20' , 2 ),
  ( 'Troll3' , 'Troll3' , '2012-01-10' , 3 ),
  ( 'Troll4' , 'Troll4' , '2013-04-14' , 4 ),
  ( 'Troll5' , 'Troll5' , '2014-11-25' , 5 ),
  ( 'Troll6' , 'wtf' , '2014-11-25' ,6  ),
  ( 'Troll7' , 'wtf' , '2016-03-20' , 7 ),
  ( 'Troll8' , 'xd' , '2017-09-09' , 1 ),
  ( 'Troll9' , 'nice' , '2017-10-10' , 1 ),
  ( 'Troll10' , 'noob' , '2017-12-31' , 4 );

Insert into FunObjekt (id, titel, uploadDatum, durchschnittsBewertung, erstellerName) values
  ( 1 , 'Bild1' , '2010-10-20' , 3.5 , 'Troll1' ),
  ( 2 , 'Bild2' , '2011-10-20' , 2 , 'Troll2' ),
  ( 3 , 'Bild3' , '2012-01-10' , 3 , 'Troll3' ),
  ( 4 , 'Bild4' , '2013-04-14' , 1 , 'Troll4' ),
  ( 5 , 'Bild5' , '2014-11-25' , 5 , 'Troll5' ),
  ( 6 , 'Bild6' , '2014-11-25' , 0 , 'Troll6' ),
  ( 7 , 'Bild7' , '2016-03-20' , 2.45465488 , 'Troll7' ),
  ( 30001 , 'Video1' , '2016-03-20' , 4.7 , 'Troll7' ),
  ( 30002 , 'Video2' , '2017-10-10' , 1.5 , 'Troll8' ),
  ( 60001 , 'Video1' , '2016-03-20' , 4.7 , 'Troll7' ),
  ( 60002 , 'Video1' , '2016-03-20' , 4.7 , 'Troll7' );

Insert into Bild (funObjektId, typ, link) values
  ( 1 , 'png' , 'https://vignette.wikia.nocookie.net/towerkeepers/images/1/13/Armored_troll1.png/revision/latest?cb=20170729004422' ),
  ( 2 , 'png' , 'http://debadotell.com/wp-content/uploads/2017/01/troll2_goblins-fanart-debaDoTell-3.png' ),
  ( 3 , 'png' , 'https://vignette.wikia.nocookie.net/gwent/images/8/8e/Thirsty_Troll3.png/revision/latest?cb=20170929180212' ),
  ( 4 , 'png' , 'https://vignette.wikia.nocookie.net/clubpenguin/images/f/f3/Troll.png/revision/latest?cb=20121222001812' ),
  ( 5 , 'jpg' , 'https://i.pinimg.com/236x/d3/a2/b2/d3a2b2f589cd2691c6fd460debe245f1.jpg' ),
  ( 6 , 'png' , 'https://vignette.wikia.nocookie.net/borderlands/images/0/09/TK5_Pearl_Troll6.png/revision/latest?cb=20100620195937' ),
  ( 7 , 'png' , 'https://www.thezorklibrary.com/history/image/troll7.png' );

Insert into Video (funObjektId, dauer, link) values
  ( 30001 , '00:02:10:40', 'https://www.sonelink.com/troll.video'),
  ( 30002 , '11:59:59:999', 'https://www.sonelink.com/superlong.video');

Insert into Witz (funObjektId, text) VALUES
  ( 60001 , 'Was sagt ein Hai, nachdem es einen Surfer gefressen hat? - \"Nett serviert, so mit Frühstücksbrettchen\"' ),
  ( 60002 , 'Geht eine schwangere Frau in eine Bäckerei und sagt: \"Ich krieg ein Brot.\" - Darauf der Bäcker: "Sachen gibt´s!' );

Insert into Gruppe (id, name, beschreibung, gruendungsDatum, gruenderName, gruppenBild) values
  (1, 'Troll Meme Boys' , 'Leute mit Troll Usernamen' , '2010-10-20' , 'Troll1' , 1 );

Insert into Bewertung (bewerterName, bewertungsObjekt, bewertung, bewertungsDatum) values
  ( 'Troll1' , 1 , 3 , '2011-10-20' ),
  ( 'Troll2' , 1 , 4 , '2011-10-20' );

Insert into Kommentar (kommentiererName, kommentarObjekt, erstellungsDatum, text) values
  ( 'Troll3' , 1 , '2011-10-21' , 'Ich liebe dieses Bild' );

Insert into GruppenMitgliedschaft (trollName, gruppenId, beitrittsDatum) values
  ( 'Troll1' , 1 , '2010-10-20' ),
  ( 'Troll1' , 1 , '2011-10-20' ),
  ( 'Troll1' , 1 , '2012-01-10' ),
  ( 'Troll1' , 1 , '2013-04-14' ),
  ( 'Troll1' , 1 , '2014-11-25' ),
  ( 'Troll1' , 1 , '2014-11-25' ),
  ( 'Troll1' , 1 , '2016-03-20' ),
  ( 'Troll1' , 1 , '2017-09-09' ),
  ( 'Troll1' , 1 , '2017-10-10' ),
  ( 'Troll1' , 1 , '2017-12-31' );