USE Memegement
GO

CREATE PROCEDURE [dbo].[usp_benutzerAnlegen]
  @benutzerName varchar(1),
  @passwortHash  varchar(1),
  @profilBild int
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.Troll(benutzerName,passwortHash,beitrittsDatum,profilBild) values
  ( @benutzerName,@passwortHash, GETDATE(),@profilBild)
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH


CREATE PROCEDURE [dbo].[usp_gruppeAnlegen]
  @id int,
  @name varchar(1),
  @beschreibung  varchar(1),
  @gruenderName varchar(1),
  @gruppenBild int
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.Gruppe(id,name,beschreibung,gruendungsDatum,gruenderName,gruppenBild) values
  ( @id,@name,@beschreibung, GETDATE(),@gruenderName,@gruppenBild)
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH


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

CREATE PROCEDURE [dbo].[usp_benutzerBildÄndern]
    @benutzerName varchar(1),
    @profilBild int
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
Update dbo.Troll SET profilBild = @profilBild
WHERE benutzerName = @benutzerName;
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH


CREATE PROCEDURE [dbo].[usp_gruppeBeitreten]
    @trollName varchar(1),
    @gruppenId varchar(1)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.GruppenMitgliedschaft(trollName,gruppenId,beitrittsDatum) values
  (@trollName,@gruppenId,GETDATE())
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH


CREATE PROCEDURE [dbo].[usp_funObjektAnlegenVideo]
    @id varchar(1),
    @title varchar(1),
    @durchschnittsBewertung float,
    @erstellerName varchar(1),
    @dauer time(7),
    @link varchar(1)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.FunObjekt(id,titel,uploadDatum,durchschnittsBewertung,erstellerName) values
 (@id,@title,GETDATE(),@durchschnittsBewertung,@erstellerName);
INSERT INTO dbo.Video(funObjektId,dauer,link) VALUES
  (@id,@dauer,@link);
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH


CREATE PROCEDURE [dbo].[usp_funObjektAnlegenBild]
    @id varchar(1),
    @title varchar(1),
    @durchschnittsBewertung float,
    @erstellerName varchar(1),
    @typ varchar(1),
    @link varchar(1)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.FunObjekt(id,titel,uploadDatum,durchschnittsBewertung,erstellerName) values
  (@id,@title,GETDATE(),@durchschnittsBewertung,@erstellerName);
INSERT INTO dbo.Bild(funObjektId,typ,link) VALUES
  (@id,@typ,@link);
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH


CREATE PROCEDURE [dbo].[usp_funObjektAnlegenWitz]
    @id varchar(1),
    @title varchar(1),
    @durchschnittsBewertung float,
    @erstellerName varchar(1),
    @text varchar(1)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.FunObjekt(id,titel,uploadDatum,durchschnittsBewertung,erstellerName) values
  (@id,@title,GETDATE(),@durchschnittsBewertung,@erstellerName);
INSERT INTO dbo.Witz(funObjektId,text) VALUES
  (@id,@text);
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH


CREATE PROCEDURE [dbo].[usp_FunObjektBewerten]
    @trollName varchar(1),
    @gruppenId varchar(1)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.GruppenMitgliedschaft(trollName,gruppenId,beitrittsDatum) values
  (@trollName,@gruppenId,GETDATE())
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH