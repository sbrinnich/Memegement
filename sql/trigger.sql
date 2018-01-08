use Memegement
GO

DROP TRIGGER IF EXISTS tr_neueBewertung;
GO

CREATE TRIGGER  tr_neueBewertung
  ON Bewertung
  FOR INSERT
AS
  DECLARE @BewertungsObjekt int = (Select bewertungsObjekt FROM inserted);
UPDATE FunObjekt SET durchschnittsBewertung = (SELECT avg(bewertung) FROM Bewertung WHERE bewertungsObjekt = @BewertungsObjekt)
WHERE id = @BewertungsObjekt;


DROP TRIGGER IF EXISTS tr_neueGruppe;
GO

CREATE TRIGGER tr_neueGruppe ON Gruppe
AFTER INSERT
AS
  DECLARE @gruppenId int, @erstellerId int, @inCount int;

  SET @inCount = (Select Count(*) FROM inserted);
  IF(@inCount > 0)
      BEGIN
        SET @gruppenId = (Select id FROM inserted);
        SET @erstellerId = (Select gruenderId FROM inserted);
        INSERT INTO GruppenMitgliedschaft (trollId, gruppenId, beitrittsDatum) VALUES
          (@erstellerID, @gruppenId, GETDATE());
      END
GO
