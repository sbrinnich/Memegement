USE Memegement
GO

ALTER PROCEDURE [dbo].[usp_benutzerAnlegen]
    @benutzerName varchar(15),
    @passwortHash varchar(256)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.Troll (benutzerName,passwortHash,beitrittsDatum) VALUES
  (@benutzerName,@passwortHash,GETDATE())
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO


CREATE PROCEDURE [dbo].[usp_benutzerIdSuchen]
    @benutzerName varchar(15),
    @id int OUTPUT
AS
  SET NOCOUNT ON
  SELECT @id = id FROM Troll WHERE benutzerName = @benutzerName

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

CREATE PROCEDURE [dbo].[usp_funObjektKommentareLaden]
    @id INT,
    @verfasser VARCHAR(15) OUTPUT,
    @text VARCHAR(256) OUTPUT,
    @erstellungsDatum DATE OUTPUT
AS
  SELECT
    @verfasser = T.benutzerName,
    @text = K.text,
    @erstellungsDatum = K.erstellungsDatum
  FROM Kommentar K JOIN Troll T ON K.kommentiererID = T.id
  WHERE kommentarObjekt = @id
  ORDER BY cast(erstellungsDatum AS DATETIME) ASC;

GO

CREATE PROCEDURE [dbo].[usp_bilderAnzeigen]
  @offset INT,
  @limit INT,
  @id INT OUTPUT,
  @titel VARCHAR(50) OUTPUT,
  @durchschnittsBewertung FLOAT OUTPUT,
  @typ VARCHAR(10) OUTPUT,
  @link VARCHAR(256) OUTPUT
AS

  SELECT
    @id = F.id,
    @titel = F.titel,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @typ = B.typ,
    @link = B.link
  FROM Bild B JOIN FunObjekt F ON B.funObjektId = F.id
  ORDER BY F.id
  OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


CREATE PROCEDURE [dbo].[usp_videosAnzeigen]
  @offset INT,
  @limit INT,
  @id INT OUTPUT,
  @titel VARCHAR(50) OUTPUT,
  @durchschnittsBewertung FLOAT OUTPUT,
  @dauer VARCHAR(10) OUTPUT,
  @link VARCHAR(256) OUTPUT
AS

SELECT
  @id = F.id,
  @titel = F.titel,
  @durchschnittsBewertung = F.durchschnittsBewertung,
  @dauer = V.dauer,
  @link = V.link
  FROM Video V JOIN FunObjekt F ON V.funObjektId = F.id
  ORDER BY F.id
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


CREATE PROCEDURE [dbo].[usp_witzeAnzeigen]
    @offset INT,
    @limit INT,
    @id INT OUTPUT,
    @titel VARCHAR(50) OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @text VARCHAR(1024) OUTPUT
AS

  SELECT
    @id = F.id,
    @titel = F.titel,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @text = W.text
  FROM Witz W JOIN FunObjekt F ON W.funObjektId = F.id
  ORDER BY F.id
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


-- gibt zurück ob ein der angegebene User das Angegebene Passwort hat, 1 ist ja, alles andere ist nein
CREATE PROCEDURE [dbo].[usp_benutzerLoginCheck]
    @benutzerName VARCHAR(15),
    @passwortHash VARCHAR(256),
    @benutzerAnzahl INT OUTPUT
  AS
    SELECT @benutzerAnzahl = COUNT(*) FROM Troll
        WHERE benutzerName = @benutzerName AND
          passwortHash = @passwortHash;

GO


--Gibt Benutzername, Beitrittsdatum, Profilbild-Link für einen bestimmten User zurück
CREATE PROCEDURE [dbo].[usp_benutzerProfilAnzeigen]
      @id INT,
      @benutzerName VARCHAR(15) OUTPUT,
      @beitrittsDatum DATE  OUTPUT,
      @link VARCHAR(256) OUTPUT
  AS
    SELECT @benutzerName=A.benutzerName,
      @beitrittsDatum=A.beitrittsDatum,
      @beitrittsDatum=B.link FROM
      (SELECT * FROM Troll WHERE id = @id) A
      JOIN (SELECT * FROM Bild) B ON A.profilBild = B.funObjektId;

GO


-- zeige eine Bestimme Menge von Bildern/Videos/Witze von einem bestimmten Troll geordnet nach Datum
CREATE PROCEDURE [dbo].[usp_benutzerVideosAnzeigenNachDatum]
  @id INT,
  @offset INT,
  @limit INT,
  @id2 INT OUTPUT,
  @titel VARCHAR(50) OUTPUT,
  @durchschnittsBewertung FLOAT OUTPUT,
  @link VARCHAR(256) OUTPUT,
  @datum DATE OUTPUT
AS
  SELECT
    @id2 = F.id,
    @titel = F.titel,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @link = V.link,
    @datum = F.uploadDatum
  FROM Video V JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON V.funObjektId = F.id
  ORDER BY F.uploadDatum DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

CREATE PROCEDURE [dbo].[usp_benutzerBilderAnzeigenNachDatum]
    @id INT,
    @offset INT,
    @limit INT,
    @id2 INT OUTPUT,
    @titel VARCHAR(50) OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @link VARCHAR(256) OUTPUT,
    @datum DATE OUTPUT
AS
  SELECT
    @id2 = F.id,
    @titel = F.titel,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @link = B.link,
    @datum = F.uploadDatum
  FROM Bild B JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON B.funObjektId = F.id
  ORDER BY F.uploadDatum DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

CREATE PROCEDURE [dbo].[usp_benutzerWitzeAnzeigenNachDatum]
    @id INT,
    @offset INT,
    @limit INT,
    @id2 INT OUTPUT,
    @titel VARCHAR(50) OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @text VARCHAR(1024) OUTPUT,
    @datum DATE OUTPUT
AS
  SELECT
    @id2 = F.id,
    @titel = F.titel,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @text = W.text,
    @datum = F.uploadDatum
  FROM Witz W JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON W.funObjektId = F.id
  ORDER BY F.uploadDatum DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

-- zeige eine Bestimme Menge von Bildern/Videos/Witze von einem bestimmten Troll geordnet nach Bewertung

CREATE PROCEDURE [dbo].[usp_benutzerVideosAnzeigenNachBewertung]
    @id INT,
    @offset INT,
    @limit INT,
    @id2 INT OUTPUT,
    @titel VARCHAR(50) OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @link VARCHAR(256) OUTPUT,
    @datum DATE OUTPUT,
AS
  SELECT
    @id2 = F.id,
    @titel = F.titel,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @link = V.link,
    @datum = F.uploadDatum
  FROM Video V JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON V.funObjektId = F.id
  ORDER BY F.durchschnittsBewertung DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

CREATE PROCEDURE [dbo].[usp_benutzerBilderAnzeigenNachBewertung]
    @id INT,
    @offset INT,
    @limit INT,
    @id2 INT OUTPUT,
    @titel VARCHAR(50) OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @link VARCHAR(256) OUTPUT,
    @datum DATE OUTPUT
AS
  SELECT
    @id2 = F.id,
    @titel = F.titel,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @link = B.link,
    @datum = F.uploadDatum
  FROM Bild B JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON B.funObjektId = F.id
  ORDER BY F.durchschnittsBewertung DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

CREATE PROCEDURE [dbo].[usp_benutzerWitzeAnzeigenNachBewertung]
    @id INT,
    @offset INT,
    @limit INT,
    @id2 INT OUTPUT,
    @titel VARCHAR(50) OUTPUT,
    @durchschnittsBewertung FLOAT OUTPUT,
    @link VARCHAR(256) OUTPUT,
    @datum DATE OUTPUT
AS
  SELECT
    @id2 = F.id,
    @titel = F.titel,
    @durchschnittsBewertung = F.durchschnittsBewertung,
    @link = W.link,
    @datum = F.uploadDatum
  FROM Witz W JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON W.funObjektId = F.id
  ORDER BY F.durchschnittsBewertung DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

-- gruppe nach ID - Alle daten, name, gründerinfo, gründungsdatum, mitgliederanzahl, gruppenbild,

ALTER PROCEDURE [dbo].[usp_gruppenDatenAnzeigen]
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
    @mitgliederAnzahl = (select count(*) as 'mitgliederAnzahl' from GruppenMitgliedschaft group by gruppenId),
    @gruppenBildLink = B.link
  FROM (Select * FROM Gruppe WHERE id = @id) G JOIN Troll T
      ON G.gruenderId = T.id LEFT JOIN Bild B ON G.gruppenBild = B.funObjektId;

GO


-- ein Funobjekt zurückgeben, dass einen Typen hat, der Anzeigt was es is, -> Objekt, titel, ersteller, hochlade datum, durchschnittsbewertung

-- stored procedure, die schaut ob ein troll ein besitzer einer Gruppe ist