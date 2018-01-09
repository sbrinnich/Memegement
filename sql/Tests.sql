EXEC usp_benutzerAnlegen @benutzerName = 'hallo1', @passwortHash = 'sdukhjkbsdfjkbsfjkbsfjkbsfjknhsdjhbsdhbsdjhbsdjkbnsdkbsdjkbsdkbsdnmsdjksdkdjksdfbjksdbkbsdbdsbsdkbsdkbsdkbsdjkbsdjkbsdjb';
SELECT * FROM Troll WHERE benutzerName = 'hallo1';

DECLARE @id INT;
EXEC usp_benutzerIdSuchen 'Phillip1', @id OUTPUT;
PRINT @id;

EXEC usp_gruppeAnlegen @name = 'hallo' ,@beschreibung = 'cool', @gruenderId = 1;
SELECT * FROM Gruppe WHERE beschreibung = 'cool';

EXEC usp_gruppenBildAendern  @id = 1 ,@gruppenBild = 1;
SELECT * FROM Gruppe WHERE id = 1;


EXEC usp_benutzerBildAendern @benutzerId = 1, @profilBild = 2;
SELECT * FROM Troll WHERE benutzerId = 1;

EXEC usp_gruppeBeitreten  @trollId = 6, @gruppenId = 1;
SELECT * FROM GruppenMitgliedschaft WHERE trollId = 6;