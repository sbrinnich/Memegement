USE Memegement
GO

DROP TRIGGER IF EXISTS tr_neueBewertung;
GO

CREATE TRIGGER  tr_neueBewertung
  ON Bewertung
  FOR INSERT
AS
  DECLARE @bewertungsObjekt int = (Select bewertungsObjekt FROM inserted),
          @durchschnittsBewertung float = (SELECT avg(bewertung) FROM Bewertung WHERE bewertungsObjekt = @BewertungsObjekt);

  UPDATE FunObjekt SET durchschnittsBewertung = (@durchschnittsBewertung)
      WHERE id = @bewertungsObjekt;
GO


DROP TRIGGER IF EXISTS tr_neueGruppe;
GO

CREATE TRIGGER tr_neueGruppe
  ON Gruppe
  AFTER INSERT
AS
  DECLARE @gruppenId int = (Select id FROM inserted),
          @erstellerId int = (Select gruenderId FROM inserted),
          @inCount int = (Select Count(*) FROM inserted);

  IF(@inCount > 0)
      BEGIN
        INSERT INTO GruppenMitgliedschaft (trollId, gruppenId, beitrittsDatum) VALUES
          (@erstellerID, @gruppenId, GETDATE());
      END
GO


