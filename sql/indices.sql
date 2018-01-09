USE Memegement

create index ix_trollnamen on Troll (benutzerName);

create index ix_funobjektTitel on FunObjekt (titel);

--create index ix_funobjektDatum on FunObjekt (uploadDatum);
--create index ix_funobjektBewertung on FunObjekt (durchschnittsBewertung);

create index ix_gruppennamen on Gruppe (name);

CREATE INDEX ix_kommentarObjekt on Kommentar (kommentarObjekt);