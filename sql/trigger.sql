use Memegement
GO

DROP TRIGGER IF EXISTS tr_newRating;
GO

CREATE TRIGGER  tr_newRating
  ON Memegement.dbo.Bewertung
  FOR INSERT
AS
  DECLARE @BewertungsObjekt int = (Select bewertungsObjekt FROM inserted)

IF EXISTS(SELECT bewertungsObjekt FROM inserted)
  UPDATE Memegement.dbo.FunObjekt SET durchschnittsBewertung = (SELECT avg(bewertung) FROM Bewertung WHERE bewertungsObjekt = @BewertungsObjekt)
    WHERE id = @BewertungsObjekt;

ELSE
  DECLARE @Username VARCHAR
  DECLARE @Title VARCHAR
  INSERT INTO Memegement.dbo.FunObjekt (titel, uploadDatum , durchschnittsBewertung, erstellerName) VALUES
    (@Title, (SELECT CONVERT (date, SYSDATETIME())), 0, @Username );

