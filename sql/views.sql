create view vi_alleGruppenNachNamen
  as select * from Gruppe order by name asc OFFSET 0 ROWS;

create view vi_alleGruppenNachDatum
  as select * from Gruppe order by gruendungsDatum desc OFFSET 0 ROWS;

create view vi_alleGruppenNachMitgliederzahl
  as select g.id, g.name, g.beschreibung, g.gruendungsDatum, g.gruenderName, g.gruppenBild, a.mitgliederAnzahl from Gruppe g
      inner join (select gruppenId, count(*) as 'mitgliederAnzahl' from GruppenMitgliedschaft group by gruppenId) a on gruppenId=g.id
      order by mitgliederAnzahl OFFSET 0 ROWS;