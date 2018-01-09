Use Memegement;
GO

create view vi_alleGruppenNachNamen
  as select g.id, g.name, g.beschreibung, g.gruendungsDatum, t.benutzerName, g.gruppenBild, a.mitgliederAnzahl from Gruppe g
      inner join (select gruppenId, count(*) as 'mitgliederAnzahl' from GruppenMitgliedschaft group by gruppenId) a on gruppenId=g.id
      inner join Troll t ON g.gruenderId = t.id
      order by name asc OFFSET 0 ROWS;
GO

create view vi_alleGruppenNachDatum
  as select g.id, g.name, g.beschreibung, g.gruendungsDatum, t.benutzerName, g.gruppenBild, a.mitgliederAnzahl from Gruppe g
      inner join (select gruppenId, count(*) as 'mitgliederAnzahl' from GruppenMitgliedschaft group by gruppenId) a on gruppenId=g.id
      inner join Troll t ON g.gruenderId = t.id
      order by gruendungsDatum desc OFFSET 0 ROWS;
GO

create view vi_alleGruppenNachMitgliederzahl
  as select g.id, g.name, g.beschreibung, g.gruendungsDatum, t.benutzerName, g.gruppenBild, a.mitgliederAnzahl from Gruppe g
      inner join (select gruppenId, count(*) as 'mitgliederAnzahl' from GruppenMitgliedschaft group by gruppenId) a on gruppenId=g.id
      inner join Troll t ON g.gruenderId = t.id
      order by mitgliederAnzahl OFFSET 0 ROWS;
GO