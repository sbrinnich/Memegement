USE Memegement
GO

DROP PROCEDURE IF EXISTS usp_benutzerAnlegen;
GO


CREATE PROCEDURE [dbo].[usp_benutzerAnlegen]
    @benutzerName VARCHAR(15),
    @passwortHash VARCHAR(256)
AS
  BEGIN TRY
  BEGIN TRANSACTION
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  INSERT INTO dbo.Troll (benutzerName, passwortHash, beitrittsDatum) VALUES
    (@benutzerName, @passwortHash, GETDATE())
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_benutzerIdSuchen;
GO


CREATE PROCEDURE [dbo].[usp_benutzerIdSuchen]
    @benutzerName VARCHAR(15),
    @id           INT OUTPUT
AS
  SET NOCOUNT ON
  SELECT @id = id
  FROM Troll
  WHERE benutzerName = @benutzerName

GO


DROP PROCEDURE IF EXISTS usp_gruppeAnlegen;
GO


CREATE PROCEDURE [dbo].[usp_gruppeAnlegen]
    @name         VARCHAR(20),
    @beschreibung VARCHAR(1024),
    @gruenderId   INT
AS
  BEGIN TRY
  BEGIN TRANSACTION
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  INSERT INTO dbo.Gruppe (name, beschreibung, gruendungsDatum, gruenderId) VALUES
    (@name, @beschreibung, GETDATE(), @gruenderId)
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_gruppenBildAendern;
GO


CREATE PROCEDURE [dbo].[usp_gruppenBildAendern]
    @id          INT,
    @gruppenBild INT
AS
  BEGIN TRY
  BEGIN TRANSACTION
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  UPDATE dbo.Gruppe
  SET gruppenBild = @gruppenBild
  WHERE id = @id;
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_benutzerBildAendern;
GO


CREATE PROCEDURE [dbo].[usp_benutzerBildAendern]
    @benutzerId INT,
    @profilBild INT
AS
  BEGIN TRY
  BEGIN TRANSACTION
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  UPDATE dbo.Troll
  SET profilBild = @profilBild
  WHERE id = @benutzerId;
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_gruppeBeitreten;
GO


CREATE PROCEDURE [dbo].[usp_gruppeBeitreten]
    @trollId   INT,
    @gruppenId INT
AS
  BEGIN TRY
  BEGIN TRANSACTION
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  INSERT INTO dbo.GruppenMitgliedschaft (trollId, gruppenId, beitrittsDatum) VALUES
    (@trollId, @gruppenId, GETDATE())
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_funObjektAnlegenVideo;
GO


CREATE PROCEDURE [dbo].[usp_funObjektAnlegenVideo]
    @titel       VARCHAR(50),
    @erstellerId INT,
    @dauer       TIME(7),
    @link        VARCHAR(256)
AS
  BEGIN TRY
  BEGIN TRANSACTION
  DECLARE @id INT;
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  INSERT INTO dbo.FunObjekt (titel, uploadDatum, erstellerId) VALUES
    (@titel, GETDATE(), @erstellerId);
  SET @id = SCOPE_IDENTITY();
  INSERT INTO dbo.Video (funObjektId, dauer, link) VALUES
    (@id, @dauer, @link);
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_funObjektAnlegenBild;
GO


CREATE PROCEDURE [dbo].[usp_funObjektAnlegenBild]
    @titel       VARCHAR(50),
    @erstellerId INT,
    @typ         VARCHAR(10),
    @link        VARCHAR(256)
AS
  BEGIN TRY
  BEGIN TRANSACTION
  DECLARE @id INT;
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  INSERT INTO dbo.FunObjekt (titel, uploadDatum, erstellerId) VALUES
    (@titel, GETDATE(), @erstellerId);
  SET @id = SCOPE_IDENTITY();
  INSERT INTO dbo.Bild (funObjektId, typ, link) VALUES
    (@id, @typ, @link);
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_funObjektAnlegenWitz;
GO


CREATE PROCEDURE [dbo].[usp_funObjektAnlegenWitz]
    @title       VARCHAR(50),
    @erstellerId INT,
    @text        VARCHAR(1024)
AS
  BEGIN TRY
  BEGIN TRANSACTION
  DECLARE @id INT;
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  INSERT INTO dbo.FunObjekt (titel, uploadDatum, erstellerId) VALUES
    (@title, GETDATE(), @erstellerId);
  SET @id = SCOPE_IDENTITY();
  INSERT INTO dbo.Witz (funObjektId, text) VALUES
    (@id, @text);
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_funObjektBewerten;
GO


CREATE PROCEDURE [dbo].[usp_funObjektBewerten]
    @bewerterId       INT,
    @bewertungsObjekt INT,
    @bewertung        FLOAT
AS
  BEGIN TRY
  BEGIN TRANSACTION
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  INSERT INTO dbo.Bewertung (bewerterId, bewertungsObjekt, bewertung, bewertungsDatum) VALUES
    (@bewerterId, @bewertungsObjekt, @bewertung, GETDATE())
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_funObjektKommentieren;
GO


CREATE PROCEDURE [dbo].[usp_funObjektKommentieren]
    @kommentiererId  INT,
    @kommentarObjekt INT,
    @text            VARCHAR(256)
AS
  BEGIN TRY
  BEGIN TRANSACTION
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
  INSERT INTO dbo.Kommentar (kommentiererId, kommentarObjekt, erstellungsDatum, text) VALUES
    (@kommentiererId, @kommentarObjekt, GETDATE(), @text)
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO


DROP PROCEDURE IF EXISTS usp_funObjektKommentareLaden;
GO


CREATE PROCEDURE [dbo].[usp_funObjektKommentareLaden]
    @id               INT,
    @verfasser        VARCHAR(15),
    @text             VARCHAR(256),
    @erstellungsDatum DATE
AS
  SELECT
    T.benutzerName,
    K.text,
    K.erstellungsDatum
  FROM Kommentar K
    JOIN Troll T ON K.kommentiererID = T.id
  WHERE kommentarObjekt = @id
  ORDER BY cast(erstellungsDatum AS DATETIME) ASC;

GO


DROP PROCEDURE IF EXISTS usp_bilderAnzeigen;
GO


CREATE PROCEDURE [dbo].[usp_bilderAnzeigen]
    @offset                 INT,
    @limit                  INT,
    @id                     INT,
    @titel                  VARCHAR(50),
    @durchschnittsBewertung FLOAT,
    @typ                    VARCHAR(10),
    @link                   VARCHAR(256)
AS

  SELECT
    F.id,
    F.titel,
    F.durchschnittsBewertung,
    B.typ,
    B.link
  FROM Bild B
    JOIN FunObjekt F ON B.funObjektId = F.id
    JOIN Troll T ON F.erstellerId = T.id
  ORDER BY F.id
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


DROP PROCEDURE IF EXISTS usp_videosAnzeigen;
GO


CREATE PROCEDURE [dbo].[usp_videosAnzeigen]
    @offset                 INT,
    @limit                  INT,
    @id                     INT,
    @titel                  VARCHAR(50),
    @durchschnittsBewertung FLOAT,
    @dauer                  VARCHAR(10),
    @link                   VARCHAR(256)
AS

  SELECT
    F.id,
    F.titel,
    F.durchschnittsBewertung,
    V.dauer,
    V.link
  FROM Video V
    JOIN FunObjekt F ON V.funObjektId = F.id
    JOIN Troll T ON F.erstellerId = T.id
  ORDER BY F.id
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


DROP PROCEDURE IF EXISTS usp_witzeAnzeigen;
GO


CREATE PROCEDURE [dbo].[usp_witzeAnzeigen]
    @offset                 INT,
    @limit                  INT,
    @id                     INT,
    @titel                  VARCHAR(50),
    @durchschnittsBewertung FLOAT,
    @text                   VARCHAR(1024)
AS

  SELECT
    F.id,
    F.titel,
    F.durchschnittsBewertung,
    W.text
  FROM Witz W
    JOIN FunObjekt F ON W.funObjektId = F.id
    JOIN Troll T ON F.erstellerId = T.id
  ORDER BY F.id
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


-- gibt zurück ob ein der angegebene User das Angegebene Passwort hat, 1 ist ja, alles andere ist nein

DROP PROCEDURE IF EXISTS usp_benutzerLoginCheck;
GO


CREATE PROCEDURE [dbo].[usp_benutzerLoginCheck]
    @benutzerName   VARCHAR(15),
    @passwortHash   VARCHAR(256),
    @benutzerAnzahl INT OUTPUT
AS
  SELECT @benutzerAnzahl = COUNT(*)
  FROM Troll
  WHERE benutzerName = @benutzerName AND
        passwortHash = @passwortHash;

GO


--Gibt Benutzername, Beitrittsdatum, Profilbild-Link für einen bestimmten User zurück

DROP PROCEDURE IF EXISTS usp_benutzerProfilAnzeigen;
GO


CREATE PROCEDURE [dbo].[usp_benutzerProfilAnzeigen]
    @id             INT
AS
  SELECT
      A.benutzerName,
      A.beitrittsDatum,
      B.link
  FROM
    (SELECT *
     FROM Troll
     WHERE id = @id) A
    LEFT JOIN (SELECT * FROM Bild) B ON A.profilBild = B.funObjektId;

GO


-- zeige eine Bestimme Menge von Bildern/Videos/Witze von einem bestimmten Troll geordnet nach Datum

DROP PROCEDURE IF EXISTS usp_benutzerVideosAnzeigenNachDatum;
GO


CREATE PROCEDURE [dbo].[usp_benutzerVideosAnzeigenNachDatum]
    @id                     INT,
    @offset                 INT,
    @limit                  INT,
    @id2                    INT,
    @titel                  VARCHAR(50),
    @durchschnittsBewertung FLOAT,
    @link                   VARCHAR(256),
    @datum                  DATE
AS
  SELECT
    F.id,
    F.titel,
    F.durchschnittsBewertung,
    V.link,
    F.uploadDatum
  FROM Video V
    JOIN
    (SELECT *
     FROM FunObjekt
     WHERE erstellerId = @id) F
      ON V.funObjektId = F.id
  ORDER BY F.uploadDatum DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


DROP PROCEDURE IF EXISTS usp_benutzerBilderAnzeigenNachDatum;
GO


CREATE PROCEDURE [dbo].[usp_benutzerBilderAnzeigenNachDatum]
    @id                     INT,
    @offset                 INT,
    @limit                  INT,
    @id2                    INT,
    @titel                  VARCHAR(50),
    @durchschnittsBewertung FLOAT,
    @link                   VARCHAR(256),
    @datum                  DATE
AS
  SELECT
    F.id,
    F.titel,
    F.durchschnittsBewertung,
    B.link,
    F.uploadDatum
  FROM Bild B
    JOIN
    (SELECT *
     FROM FunObjekt
     WHERE erstellerId = @id) F
      ON B.funObjektId = F.id
  ORDER BY F.uploadDatum DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


DROP PROCEDURE IF EXISTS usp_benutzerWitzeAnzeigenNachDatum;
GO


CREATE PROCEDURE [dbo].[usp_benutzerWitzeAnzeigenNachDatum]
    @id                     INT,
    @offset                 INT,
    @limit                  INT,
    @id2                    INT,
    @titel                  VARCHAR(50),
    @durchschnittsBewertung FLOAT,
    @text                   VARCHAR(1024),
    @datum                  DATE
AS
  SELECT
    F.id,
    F.titel,
    F.durchschnittsBewertung,
    W.text,
    F.uploadDatum
  FROM Witz W
    JOIN
    (SELECT *
     FROM FunObjekt
     WHERE erstellerId = @id) F
      ON W.funObjektId = F.id
  ORDER BY F.uploadDatum DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

-- zeige eine Bestimme Menge von Bildern/Videos/Witze von einem bestimmten Troll geordnet nach Bewertung

DROP PROCEDURE IF EXISTS usp_benutzerVideosAnzeigenNachBewertung;
GO


CREATE PROCEDURE [dbo].[usp_benutzerVideosAnzeigenNachBewertung]
    @id                     INT,
    @offset                 INT,
    @limit                  INT,
    @id2                    INT,
    @titel                  VARCHAR(50),
    @durchschnittsBewertung FLOAT,
    @link                   VARCHAR(256),
    @datum                  DATE
AS
  SELECT
    F.id,
    F.titel,
    F.durchschnittsBewertung,
    V.link,
    F.uploadDatum
  FROM Video V
    JOIN
    (SELECT *
     FROM FunObjekt
     WHERE erstellerId = @id) F
      ON V.funObjektId = F.id
  ORDER BY F.durchschnittsBewertung DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


DROP PROCEDURE IF EXISTS usp_benutzerBilderAnzeigenNachBewertung;
GO


CREATE PROCEDURE [dbo].[usp_benutzerBilderAnzeigenNachBewertung]
    @id                     INT,
    @offset                 INT,
    @limit                  INT,
    @id2                    INT,
    @titel                  VARCHAR(50),
    @durchschnittsBewertung FLOAT,
    @link                   VARCHAR(256),
    @datum                  DATE
AS
  SELECT
    F.id,
    F.titel,
    F.durchschnittsBewertung,
    B.link,
    F.uploadDatum
  FROM Bild B
    JOIN
    (SELECT *
     FROM FunObjekt
     WHERE erstellerId = @id) F
      ON B.funObjektId = F.id
  ORDER BY F.durchschnittsBewertung DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


DROP PROCEDURE IF EXISTS usp_benutzerWitzeAnzeigenNachBewertung;
GO


CREATE PROCEDURE [dbo].[usp_benutzerWitzeAnzeigenNachBewertung]
    @id                     INT,
    @offset                 INT,
    @limit                  INT,
    @id2                    INT,
    @titel                  VARCHAR(50),
    @durchschnittsBewertung FLOAT,
    @text                   VARCHAR(1024),
    @datum                  DATE
AS
  SELECT
    F.id,
    F.titel,
    F.durchschnittsBewertung,
    W.text,
    F.uploadDatum
  FROM Witz W
    JOIN
    (SELECT *
     FROM FunObjekt
     WHERE erstellerId = @id) F
      ON W.funObjektId = F.id
  ORDER BY F.durchschnittsBewertung DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

-- gruppe nach ID - Alle daten, name, gründerinfo, gründungsdatum, mitgliederanzahl, gruppenbild,

DROP PROCEDURE IF EXISTS usp_gruppenDatenAnzeigen;
GO


CREATE PROCEDURE [dbo].[usp_gruppenDatenAnzeigen]
  @id INT,
  @name VARCHAR(20) OUTPUT,
  @beschreibung VARCHAR(1024) OUTPUT,
  @gruendungsDatum DATE OUTPUT,
  @gruenderName VARCHAR(15) OUTPUT,
  @mitgliederAnzahl INT OUTPUT,
  @gruppenBildLink VARCHAR(256) OUTPUT
AS
  SELECT
    @name = G.name,
    @beschreibung = G.beschreibung,
    @gruendungsDatum = G.gruendungsDatum,
    @gruenderName = T.benutzerName,
    @mitgliederAnzahl = (select count(*) as 'mitgliederAnzahl' from GruppenMitgliedschaft where gruppenId = @id),
    @gruppenBildLink = B.link
  FROM Gruppe G JOIN Troll T
      ON G.gruenderId = T.id LEFT JOIN Bild B ON G.gruppenBild = B.funObjektId WHERE G.id = @id;

GO


CREATE PROCEDURE [dbo].[usp_bildInfosAnzeigen]
    @id INT,
    @titel VARCHAR(50) OUTPUT,
    @erstellerName VARCHAR(15) OUTPUT,
    @uploadDatum DATE OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @link VARCHAR(256) OUTPUT
  AS
  SELECT
    @titel = F.titel,
    @erstellerName = T.benutzerName,
    @uploadDatum = F.uploadDatum,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @link = B.link
  FROM (SELECT * FROM Bild WHERE funObjektId = @id) B
    JOIN FunObjekt F ON B.funObjektId = F.id JOIN Troll T ON F.erstellerId = T.id

GO

CREATE PROCEDURE [dbo].[usp_videoInfosAnzeigen]
    @id INT,
    @titel VARCHAR(50) OUTPUT,
    @erstellerName VARCHAR(15) OUTPUT,
    @uploadDatum DATE OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @link VARCHAR(256) OUTPUT
AS
  SELECT
    @titel = F.titel,
    @erstellerName = T.benutzerName,
    @uploadDatum = F.uploadDatum,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @link = V.link
  FROM (SELECT * FROM Video WHERE funObjektId = @id) V
    JOIN FunObjekt F ON V.funObjektId = F.id JOIN Troll T ON F.erstellerId = T.id

GO

CREATE PROCEDURE [dbo].[usp_witzInfosAnzeigen]
    @id INT,
    @titel VARCHAR(50) OUTPUT,
    @erstellerName VARCHAR(15) OUTPUT,
    @uploadDatum DATE OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @text VARCHAR(1024) OUTPUT
AS
  SELECT
    @titel = F.titel,
    @erstellerName = T.benutzerName,
    @uploadDatum = F.uploadDatum,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @text = W.text
  FROM (SELECT * FROM Witz WHERE funObjektId = @id) W
    JOIN FunObjekt F ON W.funObjektId = F.id JOIN Troll T ON F.erstellerId = T.id

GO


-- Das angeforderte Funobjekt mit Typen, Titel, Erstellernamen, uploadDatum, durchschnittsbewertung

CREATE PROCEDURE [dbo].[usp_funObjektAnzeigen]
    @id INT,
    @typ VARCHAR(1) OUTPUT, -- gibt an ob Bild (B), Video (V), oder Witz (W)
    @titel VARCHAR(50) OUTPUT,
    @erstellerName VARCHAR(15) OUTPUT,
    @uploadDatum DATE OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @link VARCHAR(256) OUTPUT,
    @text VARCHAR(1024) OUTPUT
AS
  DECLARE @count INT = 0;

  SELECT @count = COUNT(*) FROM Bild WHERE funObjektId = @id;
  IF(@count = 1)
      BEGIN
        EXEC usp_bildInfosAnzeigen @id, @titel OUTPUT ,
                                   @erstellerName OUTPUT,
                                   @uploadDatum OUTPUT,
                                   @durchschnittsBewertung OUTPUT,
                                   @link OUTPUT ;
        SET @text = 'Dies ist ein Bild';
        SET @typ = 'B';
        RETURN
      END
  ELSE
  BEGIN
    SELECT @count = COUNT(*) FROM Video WHERE funObjektId = @id;
    IF (@count = 1)
      BEGIN
        EXEC usp_videoInfosAnzeigen @id, @titel OUTPUT ,
                                   @erstellerName OUTPUT,
                                   @uploadDatum OUTPUT,
                                   @durchschnittsBewertung OUTPUT,
                                   @link OUTPUT ;
        SET @text = 'Dies ist ein Video';
        SET @typ = 'V';
        RETURN
      END
    ELSE
      BEGIN
        SELECT @count = COUNT(*) FROM Witz WHERE funObjektId = @id;
        IF (@count = 1)
          BEGIN
            EXEC usp_witzInfosAnzeigen @id, @titel OUTPUT ,
                                       @erstellerName OUTPUT,
                                       @uploadDatum OUTPUT,
                                       @durchschnittsBewertung OUTPUT,
                                       @text OUTPUT ;
            SET @link = NULL;
            SET @typ = 'W';
          END
        ELSE -- nothing :(
          BEGIN
            RETURN
          END
      END
  END


GO


-- stored procedure, die schaut ob ein troll ein besitzer einer Gruppe ist