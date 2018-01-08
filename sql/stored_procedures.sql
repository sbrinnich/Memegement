USE Memegement
GO

CREATE PROCEDURE [dbo].[usp_benutzerAnlegen]
  @benutzerName varchar(15),
  @passwortHash  varchar(256),
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
  @name varchar(20),
  @beschreibung  varchar(1024),
  @gruenderName varchar(15),
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
    @benutzerName varchar(15),
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


CREATE PROCEDURE [dbo].[usp_funObjektAnlegenVideo]
    @title varchar(50),
    @durchschnittsBewertung float,
    @erstellerName varchar(1),
    @dauer time(7),
    @link varchar(1)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.FunObjekt(titel,uploadDatum,durchschnittsBewertung,erstellerName) values
  (@title,GETDATE(),@durchschnittsBewertung,@erstellerName);
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
    @trollId int,
    @gruppenId varchar(1)
AS
BEGIN TRY
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO dbo.GruppenMitgliedschaft(trollId,gruppenId,beitrittsDatum) values
  (@trollId,@gruppenId,GETDATE())
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH