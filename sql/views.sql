Use Memegement;
GO

ALTER view vi_alleGruppenNachNamen
  as select g.id, g.name, g.beschreibung, CONVERT(VARCHAR(10), g.gruendungsDatum, 103) gruendungsdatum , t.benutzerName, B.link, a.mitgliederAnzahl from Gruppe g
      inner join (select gruppenId, count(*) as 'mitgliederAnzahl' from GruppenMitgliedschaft group by gruppenId) a on gruppenId=g.id
      inner join Troll t ON g.gruenderId = t.id
      inner JOIN Bild B ON g.gruppenBild = B.funObjektId
      order by name asc OFFSET 0 ROWS;
GO

ALTER view vi_alleGruppenNachDatum
  as select g.id, g.name, g.beschreibung, CONVERT(VARCHAR(10), g.gruendungsDatum, 103) gruendungsdatum , t.benutzerName, B.link, a.mitgliederAnzahl from Gruppe g
      inner join (select gruppenId, count(*) as 'mitgliederAnzahl' from GruppenMitgliedschaft group by gruppenId) a on gruppenId=g.id
      inner join Troll t ON g.gruenderId = t.id
      inner JOIN Bild B ON g.gruppenBild = B.funObjektId
      order by gruendungsDatum desc OFFSET 0 ROWS;
GO

ALTER view vi_alleGruppenNachMitgliederzahl
  as select g.id, g.name, g.beschreibung, CONVERT(VARCHAR(10), g.gruendungsDatum, 103) gruendungsdatum , t.benutzerName, B.link, a.mitgliederAnzahl from Gruppe g
      inner join (select gruppenId, count(*) as 'mitgliederAnzahl' from GruppenMitgliedschaft group by gruppenId) a on gruppenId=g.id
      inner join Troll t ON g.gruenderId = t.id
      inner JOIN Bild B ON g.gruppenBild = B.funObjektId
      order by mitgliederAnzahl OFFSET 0 ROWS;
GO