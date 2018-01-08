Use Memegement;
GO

--delete all constraints
ALTER TABLE Troll
  DROP CONSTRAINT  fk_trollProfilbild;
ALTER TABLE FunObjekt
  DROP CONSTRAINT  fk_erstellerName;
ALTER TABLE Bild
  DROP CONSTRAINT  fk_bildFunObjektID;
ALTER TABLE Video
  DROP CONSTRAINT  fk_videoFunObjektID;
ALTER TABLE Witz
  DROP CONSTRAINT  fk_witzFunObjektID;
ALTER TABLE Gruppe
  DROP CONSTRAINT  fk_gruenderName;
ALTER TABLE Gruppe
  DROP CONSTRAINT  fk_gruppenBild;
ALTER TABLE Bewertung
  DROP CONSTRAINT  fk_bewerterName;
ALTER TABLE Bewertung
  DROP CONSTRAINT  fk_bewertungsObjekt;
ALTER TABLE Kommentar
  DROP CONSTRAINT  fk_kommentiererName;
ALTER TABLE Kommentar
  DROP CONSTRAINT  fk_kommentarObjekt;
ALTER TABLE GruppenMitgliedschaft
  DROP CONSTRAINT  fk_trollName;
ALTER TABLE GruppenMitgliedschaft
  DROP CONSTRAINT  fk_gruppenId;
GO


-- delete old data first
TRUNCATE TABLE FunObjekt;
TRUNCATE TABLE Bild;
TRUNCATE TABLE Video;
TRUNCATE TABLE Witz;
TRUNCATE TABLE Gruppe;
TRUNCATE TABLE Bewertung;
TRUNCATE TABLE Kommentar;
TRUNCATE TABLE GruppenMitgliedschaft;
TRUNCATE TABLE Troll;
GO

-- insert all the constraints again

Alter table Troll
  add constraint fk_trollProfilbild foreign key (profilBild) references Bild(funObjektId);
ALTER TABLE FunObjekt
    ADD CONSTRAINT fk_erstellerName FOREIGN KEY (erstellerName) REFERENCES Troll(benutzerName);
ALTER TABLE Bild
    ADD CONSTRAINT fk_bildFunObjektID FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Video
    ADD CONSTRAINT fk_videoFunObjektID FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Witz
    ADD CONSTRAINT fk_witzFunObjektID FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Gruppe
    ADD CONSTRAINT fk_gruenderName FOREIGN KEY (gruenderName) REFERENCES Troll(benutzerName);
ALTER TABLE Gruppe
    ADD CONSTRAINT fk_gruppenBild FOREIGN KEY (gruppenBild) REFERENCES Bild(funObjektId);
ALTER TABLE Bewertung
    ADD CONSTRAINT fk_bewerterName FOREIGN KEY (bewerterName) REFERENCES Troll(benutzerName);
ALTER TABLE Bewertung
    ADD CONSTRAINT fk_bewertungsObjekt FOREIGN KEY (bewertungsObjekt) REFERENCES FunObjekt(id);
ALTER TABLE Kommentar
    ADD CONSTRAINT fk_kommentiererName FOREIGN KEY (kommentiererName) REFERENCES Troll(benutzerName);
ALTER TABLE Kommentar
    ADD CONSTRAINT fk_kommentarObjekt FOREIGN KEY (kommentarObjekt) REFERENCES FunObjekt(id);
ALTER TABLE GruppenMitgliedschaft
    ADD CONSTRAINT fk_trollName FOREIGN KEY (trollName) REFERENCES Troll(benutzerName);
ALTER TABLE GruppenMitgliedschaft
    ADD CONSTRAINT fk_gruppenId FOREIGN KEY (gruppenId) REFERENCES Gruppe(id);


-- insert basic data



Insert into Troll ( benutzerName, passwortHash, beitrittsDatum) values
  ( 'Troll1' , 'Troll1' , '2010-10-20' ),
  ( 'Troll2' , 'Troll2' , '2011-10-20' ),
  ( 'Troll3' , 'Troll3' , '2012-01-10' ),
  ( 'Troll4' , 'Troll4' , '2013-04-14' ),
  ( 'Troll5' , 'Troll5' , '2014-11-25' ),
  ( 'Troll6' , 'wtf' , '2014-11-25' ),
  ( 'Troll7' , 'wtf' , '2016-03-20' );

Insert into FunObjekt (titel, uploadDatum, durchschnittsBewertung, erstellerName) values
  ('Bild1' , '2010-10-20' , 3.5 , 'Troll1' ),
  ('Bild2' , '2011-10-20' , 2 , 'Troll2' ),
  ('Bild3' , '2012-01-10' , 3 , 'Troll3' ),
  ('Bild4' , '2013-04-14' , 1 , 'Troll4' ),
  ('Bild5' , '2014-11-25' , 5 , 'Troll5' ),
  ('Bild6' , '2014-11-25' , 0 , 'Troll6' ),
  ('Bild7' , '2016-03-20' , 2.45465488 , 'Troll7' ),
  ('Video1' , '2016-03-20' , 4.7 , 'Troll7' ),
  ('Video2' , '2016-03-20' , 4.7 , 'Troll7' ),
  ('Witz1' , '2016-03-20' , 4.7 , 'Troll7' ),
  ('Witz2' , '2013-01-02' , 1.5 , 'Troll1');


Insert into Bild (funObjektId, typ, link) values
  ( 1 , 'png' , 'https://vignette.wikia.nocookie.net/towerkeepers/images/1/13/Armored_troll1.png/revision/latest?cb=20170729004422' ),
  ( 2 , 'png' , 'http://debadotell.com/wp-content/uploads/2017/01/troll2_goblins-fanart-debaDoTell-3.png' ),
  ( 3 , 'png' , 'https://vignette.wikia.nocookie.net/gwent/images/8/8e/Thirsty_Troll3.png/revision/latest?cb=20170929180212' ),
  ( 4 , 'png' , 'https://vignette.wikia.nocookie.net/clubpenguin/images/f/f3/Troll.png/revision/latest?cb=20121222001812' ),
  ( 5 , 'jpg' , 'https://i.pinimg.com/236x/d3/a2/b2/d3a2b2f589cd2691c6fd460debe245f1.jpg' ),
  ( 6 , 'png' , 'https://vignette.wikia.nocookie.net/borderlands/images/0/09/TK5_Pearl_Troll6.png/revision/latest?cb=20100620195937' ),
  ( 7 , 'png' , 'https://www.thezorklibrary.com/history/image/troll7.png' );

Insert into Video (funObjektId, dauer, link) values
  ( 8, '00:02:10:40', 'https://www.sonelink.com/troll.video'),
  ( 9 , '11:59:59:999', 'https://www.sonelink.com/superlong.video');

Insert into Witz (funObjektId, text) VALUES
  ( 10 , 'Was sagt ein Hai, nachdem es einen Surfer gefressen hat? - \"Nett serviert, so mit Frühstücksbrettchen\"' ),
  ( 11 , 'Geht eine schwangere Frau in eine Bäckerei und sagt: \"Ich krieg ein Brot.\" - Darauf der Bäcker: "Sachen gibt´s!' );

Insert into Gruppe (name, beschreibung, gruendungsDatum, gruenderName, gruppenBild) values
  ('Troll Meme Boys' , 'Leute mit Troll Usernamen' , '2010-10-20' , 'Troll1' , 1 );

Insert into Bewertung (bewerterName, bewertungsObjekt, bewertung, bewertungsDatum) values
  ( 'Troll1' , 1 , 3 , '2011-10-20' ),
  ( 'Troll2' , 1 , 4 , '2011-10-20' );

Insert into Kommentar (kommentiererName, kommentarObjekt, erstellungsDatum, text) values
  ( 'Troll3' , 1 , '2011-10-21' , 'Ich liebe dieses Bild' );

Insert into GruppenMitgliedschaft (trollName, gruppenId, beitrittsDatum) values
  ( 'Troll1' , 1 , '2010-10-20' ),
  ( 'Troll2' , 1 , '2011-10-20' ),
  ( 'Troll3' , 1 , '2012-01-10' ),
  ( 'Troll4' , 1 , '2013-04-14' ),
  ( 'Troll5' , 1 , '2014-11-25' ),
  ( 'Troll6' , 1 , '2014-11-25' ),
  ( 'Troll7' , 1 , '2016-03-20' );
GO


--function for trillion entries :D::D:D:D:D:D:D:D:D:D

DECLARE @Input int;
SET @Input = 8;

WHILE @Input < 500001
  BEGIN
    Insert into Troll ( benutzerName, passwortHash, beitrittsDatum) values
      ('Troll'+cast(@Input AS VARCHAR(10)), 'passwordforwinners', '2013-01-01');

    SET @Input = @Input + 1

  END
GO

DECLARE @Input int;
SET @Input = 12;

WHILE @Input < 100001
  BEGIN
    Insert into FunObjekt (titel, uploadDatum, durchschnittsBewertung, erstellerName) values
      ('Bild'+cast(@Input AS VARCHAR(10)) , '2018-01-08' , RAND()*5 , 'Troll'+cast(cast(RAND()*@Input AS INT) AS VARCHAR(10)))
    Insert into Bild (funObjektId, typ, link) values
      (@Input , 'jpg' , 'http://www.bento.de/upload/images/imager/upload/images/713693/putinmeme5_2b2260db5b9416a958a6aca40e039b06.jpg')
    SET @Input = @Input + 1
  END
GO