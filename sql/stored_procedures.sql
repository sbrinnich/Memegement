USE Memegement
GO

CREATE PROCEDURE [dbo].[usp_benutzerAnlegen]
  @benutzerName varchar(15),
  @passwortHash  varchar(256)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.Troll(benutzerName,passwortHash,beitrittsDatum) values
  ( @benutzerName,@passwortHash, GETDATE())
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

  SELECT TOP @limit
    F.id, F.titel, F.durchschnittsBewertung, F.erstellerId, B.typ, B.link
  FROM Bild B JOIN FunObjekt F ON B.funObjektId = F.id
  ORDER BY F.id
  OFFSET @offset ROWS;

GO


CREATE PROCEDURE [dbo].[usp_videosAnzeigen]
    @offset INT,
    @limit INT
AS

  SELECT TOP @limit
    F.id, F.titel, F.durchschnittsBewertung, F.erstellerId, V.dauer, V.link
  FROM Video V JOIN FunObjekt F ON V.funObjektId = F.id
  ORDER BY F.id
    OFFSET @offset ROWS;

GO


CREATE PROCEDURE [dbo].[usp_witzeAnzeigen]
    @offset INT,
    @limit INT
AS

  SELECT TOP @limit
    F.id, F.titel, F.durchschnittsBewertung, F.erstellerId, W.text
  FROM Witz W JOIN FunObjekt F ON W.funObjektId = F.id
  ORDER BY F.id
    OFFSET @offset ROWS;

  GO
