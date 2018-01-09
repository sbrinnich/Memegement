USE Memegement
GO

CREATE PROCEDURE [dbo].[usp_benutzerAnlegen]
  @benutzerName varchar(15),
  @passwortHash  varchar(256),
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.Troll(benutzerName,passwortHash,beitrittsDatum,profilBild) values
  ( @benutzerName,@passwortHash, GETDATE())
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_gruppeAnlegen]
  @name varchar(20),
  @beschreibung  varchar(1024),
  @gruenderId int
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.Gruppe(name,beschreibung,gruendungsDatum,gruenderId) values
  ( @name,@beschreibung, GETDATE(),@gruenderId)
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_gruppenBildÄndern]
    @id int,
    @gruppenBild int
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
Update dbo.Gruppe SET gruppenBild = @gruppenBild
WHERE id = @id;
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_benutzerBildÄndern]
    @benutzerId int,
    @profilBild int
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
Update dbo.Troll SET profilBild = @profilBild
WHERE id = @benutzerId;
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_gruppeBeitreten]
    @trollId int,
    @gruppenId int
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.GruppenMitgliedschaft(trollId,gruppenId,beitrittsDatum) values
  (@trollId,@gruppenId,GETDATE())
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_funObjektAnlegenVideo]
    @titel varchar(50),
    @erstellerId int,
    @dauer time(7),
    @link varchar(256)
AS
BEGIN TRY
BEGIN TRANSACTION
DECLARE @id int;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.FunObjekt(titel,uploadDatum,erstellerId) values
  (@titel,GETDATE(),@erstellerId);
SET @id = SCOPE_IDENTITY();
INSERT INTO dbo.Video(funObjektId,dauer,link) VALUES
  (@id,@dauer,@link);
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_funObjektAnlegenBild]
    @titel varchar(50),
    @erstellerId int,
    @typ varchar(10),
    @link varchar(256)
AS
BEGIN TRY
BEGIN TRANSACTION
DECLARE @id int;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.FunObjekt(titel,uploadDatum,erstellerId) values
  (@titel,GETDATE(),@erstellerId);
SET @id = SCOPE_IDENTITY();
INSERT INTO dbo.Bild(funObjektId,typ,link) VALUES
  (@id,@typ,@link);
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_funObjektAnlegenWitz]
    @title varchar(50),
    @erstellerId int,
    @text varchar(1024)
AS
BEGIN TRY
BEGIN TRANSACTION
DECLARE @id int;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.FunObjekt(titel,uploadDatum,erstellerId) values
  (@title,GETDATE(),@erstellerId);
SET @id = SCOPE_IDENTITY();
INSERT INTO dbo.Witz(funObjektId,text) VALUES
  (@id,@text);
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_FunObjektBewerten]
    @bewerterId int,
    @bewertungsObjekt int,
    @bewertung float
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.Bewertung(bewerterId,bewertungsObjekt,bewertung,bewertungsDatum) values
  (@bewerterId,@bewertungsObjekt,@bewertung,GETDATE())
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_FunObjektKommentieren]
    @kommentiererId int,
    @kommentarObjekt int,
    @text varchar(256)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.Kommentar(kommentiererId,kommentarObjekt,erstellungsDatum,text) values
  (@kommentiererId,@kommentarObjekt,GETDATE(),@text)
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO

CREATE PROCEDURE [dbo].[usp_FunObjektKommentiereLaden]
@id int
AS
BEGIN TRY
  BEGIN TRANSACTION
   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    SELECT text, erstellungsDatum FROM Kommentar WHERE kommentarObjekt = @id
    ORDER by cast(erstellungsDatum as datetime) asc;
  COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

GO