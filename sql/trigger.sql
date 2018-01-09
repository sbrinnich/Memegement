USE Memegement
GO

-- Bei einer neuen Bewertung muss die Durchschnittsbewertung des FunObjekts aktualisiert werden.

DROP TRIGGER IF EXISTS tr_neueBewertung;
GO

CREATE TRIGGER  tr_neueBewertung
  ON Bewertung
  AFTER INSERT
AS
  DECLARE @bewertungsObjekt int = (Select bewertungsObjekt FROM inserted),
          @durchschnittsBewertung float = (SELECT avg(bewertung) FROM Bewertung WHERE bewertungsObjekt = @BewertungsObjekt);

  UPDATE FunObjekt SET durchschnittsBewertung = (@durchschnittsBewertung)
      WHERE id = @bewertungsObjekt;
GO

-- Bei einer neuen Gruppe soll der Gründer automatisch als Gruppenmitglied hinzugefügt werden.

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

-- Bei einem neuen User soll geprüft werden ob der Name gültig und der Hash lang genug sind

DROP TRIGGER IF EXISTS tr_neuerUser;
GO

CREATE TRIGGER tr_neuerUser
  ON Troll
AFTER INSERT
AS
  DECLARE @benutzerName VARCHAR(15) = (Select benutzerName FROM inserted),
  @passwortHash VARCHAR(256) = (Select passwortHash FROM inserted);

  IF(ltrim(rtrim(isNull(@benutzerName,''))) = '' OR @passwortHash < 64)
      BEGIN
        RAISERROR ('Benutzername oder Passwort zu kurz', 10,1);
        ROLLBACK
      END

GO

-- Bei einem neuen FunObjekt soll geprüft werden ob der titel gültig und die Durchschnittsbewertung NULL sind

DROP TRIGGER IF EXISTS tr_neuesFunObjekt;
GO

CREATE TRIGGER tr_neuesFunObjekt
  ON FunObjekt
AFTER INSERT
AS
  DECLARE @titel VARCHAR(50) = (Select titel FROM inserted),
  @bewertung FLOAT = (Select durchschnittsBewertung FROM inserted);

  IF(ltrim(rtrim(isNull(@titel,''))) = '' OR @bewertung IS NOT NULL)
    BEGIN
      RAISERROR ('titel zu kurz oder Bewertung nicht NULL', 10,1);
      ROLLBACK
    END

GO

-- Bei einem neuen Kommentar soll geprüft werden ob der text gültig ist

DROP TRIGGER IF EXISTS tr_neuesKommentar;
GO

CREATE TRIGGER tr_neuesKommentar
  ON Kommentar
AFTER INSERT
AS
  DECLARE @text VARCHAR(50) = (Select text FROM inserted);

  IF(ltrim(rtrim(isNull(@text,''))) = '')
    BEGIN
      RAISERROR ('Text ungültig', 10,1);
      ROLLBACK
    END

GO


