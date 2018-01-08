use Memegement
GO

DROP TRIGGER IF EXISTS tr_newRating;
GO

CREATE TRIGGER  tr_newRating
  ON Memegement.dbo.Bewertung
  FOR INSERT
AS
  DECLARE @BewertungsObjekt int = (Select bewertungsObjekt FROM inserted)
UPDATE Memegement.dbo.FunObjekt SET durchschnittsBewertung = (SELECT avg(bewertung) FROM Bewertung WHERE bewertungsObjekt = @BewertungsObjekt)
WHERE id = @BewertungsObjekt;