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
  RETURN

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
    @id INT
AS
  BEGIN TRY
  BEGIN TRANSACTION
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  SELECT
    text,
    erstellungsDatum
  FROM Kommentar
  WHERE kommentarObjekt = @id
  ORDER BY cast(erstellungsDatum AS DATETIME) ASC;
  COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  END CATCH

GO

CREATE PROCEDURE [dbo].[usp_bilderAnzeigen]
    @offset INT,
    @limit INT
AS

  SELECT
    F.id, F.titel, F.durchschnittsBewertung, F.erstellerId, B.typ, B.link
  FROM Bild B JOIN FunObjekt F ON B.funObjektId = F.id
  ORDER BY F.id
  OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


CREATE PROCEDURE [dbo].[usp_videosAnzeigen]
    @offset INT,
    @limit INT
AS

  SELECT
    F.id, F.titel, F.durchschnittsBewertung, F.erstellerId, V.dauer, V.link
  FROM Video V JOIN FunObjekt F ON V.funObjektId = F.id
  ORDER BY F.id
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO


CREATE PROCEDURE [dbo].[usp_witzeAnzeigen]
    @offset INT,
    @limit INT
AS

  SELECT
    F.id, F.titel, F.durchschnittsBewertung, F.erstellerId, W.text
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
  RETURN

GO


--Gibt Benutzername, Beitrittsdatum, Profilbild-Link für einen bestimmten User zurück
CREATE PROCEDURE [dbo].[usp_benutzerProfilAnzeigen]
      @id INT,
      @benutzerName VARCHAR(15) OUTPUT,
      @beitrittsDatum DATE  OUTPUT,
      @link VARCHAR(256) OUTPUT
  AS
    SELECT A.id, A.benutzerName, A.beitrittsDatum, B.link FROM
      (SELECT * FROM Troll WHERE id = @id) A
      JOIN (SELECT * FROM Bild) B ON A.profilBild = B.funObjektId;

GO


-- zeige eine Bestimme Menge von Bildern/Videos/Witze von einem bestimmten Troll geordnet nach Datum
CREATE PROCEDURE [dbo].[usp_benutzerVideosAnzeigenNachDatum]
    @id INT,
    @offset INT,
    @limit INT
AS
  SELECT
    F.id, F.titel, F.durchschnittsBewertung, V.link
  FROM Video V JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON V.funObjektId = F.id
  ORDER BY F.uploadDatum DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

CREATE PROCEDURE [dbo].[usp_benutzerBilderAnzeigenNachDatum]
    @id INT,
    @offset INT,
    @limit INT
AS
  SELECT
    F.id, F.titel, F.durchschnittsBewertung, B.link
  FROM Bild B JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON B.funObjektId = F.id
  ORDER BY F.uploadDatum DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

CREATE PROCEDURE [dbo].[usp_benutzerWitzeAnzeigenNachDatum]
    @id INT,
    @offset INT,
    @limit INT
AS
  SELECT
    F.id, F.titel, F.durchschnittsBewertung, W.text
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
    @limit INT
AS
  SELECT
    F.id, F.titel, F.durchschnittsBewertung, V.link
  FROM Video V JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON V.funObjektId = F.id
  ORDER BY F.durchschnittsBewertung DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

CREATE PROCEDURE [dbo].[usp_benutzerBilderAnzeigenNachBewertung]
    @id INT,
    @offset INT,
    @limit INT
AS
  SELECT
    F.id, F.titel, F.durchschnittsBewertung, B.link
  FROM Bild B JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON B.funObjektId = F.id
  ORDER BY F.durchschnittsBewertung DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO

CREATE PROCEDURE [dbo].[usp_benutzerWitzeAnzeigenNachBewertung]
    @id INT,
    @offset INT,
    @limit INT
AS
  SELECT
    F.id, F.titel, F.durchschnittsBewertung, W.text
  FROM Witz W JOIN
    (SELECT * FROM FunObjekt WHERE erstellerId = @id) F
      ON W.funObjektId = F.id
  ORDER BY F.durchschnittsBewertung DESC
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY;

GO
