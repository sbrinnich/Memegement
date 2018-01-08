Use Memegement;
GO

--delete all constraints
ALTER TABLE Troll
  DROP CONSTRAINT  fk_trollProfilbild;
ALTER TABLE FunObjekt
  DROP CONSTRAINT  fk_erstellerId;
ALTER TABLE Bild
  DROP CONSTRAINT  fk_bildFunObjektId;
ALTER TABLE Video
  DROP CONSTRAINT  fk_videoFunObjektId;
ALTER TABLE Witz
  DROP CONSTRAINT  fk_witzFunObjektId;
ALTER TABLE Gruppe
  DROP CONSTRAINT  fk_gruenderId;
ALTER TABLE Gruppe
  DROP CONSTRAINT  fk_gruppenBild;
ALTER TABLE Bewertung
  DROP CONSTRAINT  fk_bewerterId;
ALTER TABLE Bewertung
  DROP CONSTRAINT  fk_bewertungsObjekt;
ALTER TABLE Kommentar
  DROP CONSTRAINT  fk_kommentiererId;
ALTER TABLE Kommentar
  DROP CONSTRAINT  fk_kommentarObjekt;
ALTER TABLE GruppenMitgliedschaft
  DROP CONSTRAINT  fk_trollId;
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
  ADD CONSTRAINT fk_erstellerId FOREIGN KEY (erstellerId) REFERENCES Troll(id);
ALTER TABLE Bild
  ADD CONSTRAINT fk_bildFunObjektId FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Video
  ADD CONSTRAINT fk_videoFunObjektId FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Witz
  ADD CONSTRAINT fk_witzFunObjektId FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Gruppe
  ADD CONSTRAINT fk_gruenderId FOREIGN KEY (gruenderId) REFERENCES Troll(id);
ALTER TABLE Gruppe
  ADD CONSTRAINT fk_gruppenBild FOREIGN KEY (gruppenBild) REFERENCES Bild(funObjektId);
ALTER TABLE Bewertung
  ADD CONSTRAINT fk_bewerterId FOREIGN KEY (bewerterId) REFERENCES Troll(id);
ALTER TABLE Bewertung
  ADD CONSTRAINT fk_bewertungsObjekt FOREIGN KEY (bewertungsObjekt) REFERENCES FunObjekt(id);
ALTER TABLE Kommentar
  ADD CONSTRAINT fk_kommentiererId FOREIGN KEY (kommentiererId) REFERENCES Troll(id);
ALTER TABLE Kommentar
  ADD CONSTRAINT fk_kommentarObjekt FOREIGN KEY (kommentarObjekt) REFERENCES FunObjekt(id);
ALTER TABLE GruppenMitgliedschaft
  ADD CONSTRAINT fk_trollId FOREIGN KEY (trollId) REFERENCES Troll(id);
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

Insert into FunObjekt (titel, uploadDatum, durchschnittsBewertung, erstellerId) values
  ('Bild1' , '2010-10-20' , 3.5 , 1 ),
  ('Bild2' , '2011-10-20' , 2 , 2 ),
  ('Bild3' , '2012-01-10' , 3 , 3 ),
  ('Bild4' , '2013-04-14' , 1 , 4 ),
  ('Bild5' , '2014-11-25' , 5 , 5 ),
  ('Bild6' , '2014-11-25' , 0 , 6 ),
  ('Bild7' , '2016-03-20' , 2.45465488 , 7 ),
  ('Video1' , '2016-03-20' , 4.7 , 2 ),
  ('Video2' , '2016-03-20' , 4.7 , 7 ),
  ('Witz1' , '2016-03-20' , 4.7 , 7 ),
  ('Witz2' , '2013-01-02' , 1.5 , 1);


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

Insert into Gruppe (name, beschreibung, gruendungsDatum, gruenderId, gruppenBild) values
  ('Troll Meme Boys' , 'Leute mit Troll Usernamen' , '2010-10-20' , 1 , 1 );

Insert into Bewertung (bewerterId, bewertungsObjekt, bewertung, bewertungsDatum) values
  ( 1 , 1 , 3 , '2011-10-20' ),
  ( 2 , 1 , 4 , '2011-10-20' );

Insert into Kommentar (kommentiererId, kommentarObjekt, erstellungsDatum, text) values
  ( 3 , 1 , '2011-10-21' , 'Ich liebe dieses Bild' );

Insert into GruppenMitgliedschaft (trollId, gruppenId, beitrittsDatum) values
  ( 1 , 1 , '2010-10-20' ),
  ( 2 , 1 , '2011-10-20' ),
  ( 3 , 1 , '2012-01-10' ),
  ( 4 , 1 , '2013-04-14' ),
  ( 5 , 1 , '2014-11-25' ),
  ( 6 , 1 , '2014-11-25' ),
  ( 7 , 1 , '2016-03-20' );
GO


--Scripts for trillion entries :D::D:D:D:D:D:D:D:D:D

--Testdata Trolls

DECLARE @Input int;
SET @Input = 8;

WHILE @Input < 500001
  BEGIN
    Insert into Troll ( benutzerName , passwortHash, beitrittsDatum) values
      ('Troll'+cast(@Input AS VARCHAR(10)), 'passwordforwinners', '2013-01-01');

    SET @Input = @Input + 1

  END
GO


--Testdata Bilder

DECLARE @Input int;
SET @Input = 12;

WHILE @Input < 100001
  BEGIN
    Insert into FunObjekt (titel, uploadDatum, durchschnittsBewertung, erstellerId) values
      ('Bild'+cast(@Input AS VARCHAR(10)) , '2018-01-08' , RAND()*5 , (cast((RAND()*@Input) AS INT)%500000) + 1)
    Insert into Bild (funObjektId, typ, link) values
      (@Input , 'jpg' , 'http://www.bento.de/upload/images/imager/upload/images/713693/putinmeme5_2b2260db5b9416a958a6aca40e039b06.jpg')
    SET @Input = @Input + 1
  END
GO


--Testdata Videos

DECLARE @Input int;
SET @Input = 100001

WHILE @Input < 300001
  BEGIN
    INSERT INTO FunObjekt(titel, uploadDatum, durchschnittsBewertung, erstellerId)  VALUES
      ('Video'+cast(@Input AS VARCHAR(10)) , '2018-12-20' , RAND()*5 , (cast((RAND()*@Input) AS INT)%500000) + 1)
    INSERT INTO Video(funObjektId, dauer, link) VALUES
      (@Input , '3:33' , 'https://youtu.be/dQw4w9WgXcQ')
    SET @Input = @Input + 1
  END
GO


--Testdata Witze

DECLARE @Input int;
SET @Input = 300001

WHILE @Input < 500001
  BEGIN
    INSERT INTO FunObjekt(titel, uploadDatum, durchschnittsBewertung, erstellerId) VALUES
      ('Witz'+cast(@Input AS VARCHAR(11)) , '2015-11-20' , RAND()*5 , (cast((RAND()*@Input) AS INT)%500000) + 1)
    INSERT INTO Witz(funObjektId, text) VALUES
      (@Input , 'Ein Zwerg betritt eine Taverne und fragt:"Was ist blau und richt nach roter Farbe?" Der Barkeeper weiß es nicht und der Zwerg schreit: "Blaue Farbe!"')
    SET @Input = @Input + 1
  END
GO


--Testdata Kommentare

DECLARE @Input int;
SET @Input = 1

WHILE @Input < 1000001
  BEGIN
    INSERT INTO Kommentar(kommentiererID, kommentarObjekt, erstellungsDatum, text) VALUES
      (cast(RAND()*500000 AS INT) + 1 , cast(RAND() * 500000 AS INT) + 1 , '2001-01-01' , 'Das ist ja absolut geil!! Weiter so :D')
    SET @Input = @Input + 1
  END
GO


--Testdata Gruppen

DECLARE @Input int;
DECLARE @Gruender int;
SET @Input = 2

WHILE @Input < 1001
  BEGIN
    SET @Gruender = CAST(RAND() * 500000 AS INT) + 1
    INSERT INTO Gruppe(name, beschreibung, gruendungsDatum, gruenderId, gruppenBild) VALUES
      ('Gruppe'+cast(@Input AS VARCHAR(9)) , 'Beste Gruppe ever! NEIN WIR SIND DIE BESTEN! NEIN WIR!' , '2014-03-23' , @Gruender , 2)
    INSERT INTO GruppenMitgliedschaft(trollId, gruppenId, beitrittsDatum) VALUES
      ( @Gruender , @Input , '2000-01-01' )
    SET @Input = @Input + 1
  END
GO


--Testdaten für Gruppenbefüllung

DECLARE @Input int;
DECLARE @Gruppe int;
SET @Input = 1

WHILE @Input < 500000
  BEGIN
    SET @Gruppe = cast(RAND() * 999 AS INT) + 1
    IF (NOT EXISTS(SELECT * FROM GruppenMitgliedschaft WHERE gruppenId = @Gruppe AND trollId = @Input))
      BEGIN
        INSERT INTO GruppenMitgliedschaft(trollId, gruppenId, beitrittsDatum) VALUES
          (@Input , @Gruppe , '2014-08-20')
      END
    SET @Input = @Input + 1
  END
GO

