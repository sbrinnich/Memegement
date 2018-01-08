-- Create Database
USE Fahrrad;
GO

IF EXISTS(SELECT * FROM sysdatabases WHERE name = 'Memegement')
  Drop database Memegement
GO

Create database Memegement;
GO

Use Memegement;
GO

-- Drop Tables
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_CATALOG = 'Memegement' AND TABLE_NAME = 'Troll')
  Alter table Troll drop constraint fkTrollProfilbild;
GO
Drop table if exists Bewertung;
Drop table if exists Kommentar;
Drop table if exists GruppenMitgliedschaft;
Drop table if exists Gruppe;
Drop table if exists Bild;
Drop table if exists Video;
Drop table if exists Witz;
Drop table if exists FunObjekt;
Drop table if exists Troll;
GO

-- Create Tables

Create table Troll (
  id int not null primary key identity (1,1),
  benutzerName varchar(15) not null UNIQUE, -- vll hier keinen varchar als pk sondern eine ID und den Namen unique machen
  passwortHash varchar(256) not null,
  beitrittsDatum date not null,
  profilBild int
);

Create table FunObjekt (
  id int not null primary key identity(1,1),
  titel varchar(50) not null,
  uploadDatum date not null,
  durchschnittsBewertung float,
  erstellerName varchar(15) not null
);

Create table Bild (
  funObjektId int not null primary key,
  typ varchar(10) not null,
  link varchar(256) not null
);

Create table Video (
  funObjektId int not null primary key,
  dauer time not null,
  link varchar(256) not null
);

Create table Witz (
  funObjektId int not null primary key,
  text varchar(1024) not null
);

Create table Gruppe (
  id int not null primary key identity(1,1),
  name varchar(20) not null,
  beschreibung varchar(1024),
  gruendungsDatum date not null,
  gruenderName varchar(15) not null,
  gruppenBild int not null
);

Create table Bewertung (
  bewerterName varchar(15) not null,
  bewertungsObjekt int not null,
  bewertung float not null,
  bewertungsDatum date not null,
  primary key (bewerterName, bewertungsObjekt)
);

Create table Kommentar (
  kommentiererName varchar(15) not null,
  kommentarObjekt int not null,
  erstellungsDatum date not null,
  text varchar(256) not null,
  primary key (kommentiererName, kommentarObjekt, erstellungsDatum)
);

Create table GruppenMitgliedschaft (
  trollName varchar(15) not null,
  gruppenId int not null,
  beitrittsDatum date not null,
  primary key (trollName, gruppenId)
);

GO

-- Add the foreign-key Constraints

Alter table Troll
  add constraint fk_trollProfilbild foreign key (profilBild) references Bild(funObjektId);
ALTER TABLE FunObjekt
  ADD CONSTRAINT fk_erstellerName FOREIGN KEY (erstellerName) REFERENCES Troll(benutzerName);
ALTER TABLE Bild
  ADD CONSTRAINT fk_bildFunObjektID FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Video
  ADD CONSTRAINT fk_videoFunObjektID FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Witz
  ADD CONSTRAINT fk_witzFunObjektID FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Gruppe
  ADD CONSTRAINT fk_gruenderName FOREIGN KEY (gruenderName) REFERENCES Troll(benutzerName);
ALTER TABLE Gruppe
  ADD CONSTRAINT fk_gruppenBild FOREIGN KEY (gruppenBild) REFERENCES Bild(funObjektId);
ALTER TABLE Bewertung
  ADD CONSTRAINT fk_bewerterName FOREIGN KEY (bewerterName) REFERENCES Troll(benutzerName);
ALTER TABLE Bewertung
  ADD CONSTRAINT fk_bewertungsObjekt FOREIGN KEY (bewertungsObjekt) REFERENCES FunObjekt(id);
ALTER TABLE Kommentar
  ADD CONSTRAINT fk_kommentiererName FOREIGN KEY (kommentiererName) REFERENCES Troll(benutzerName);
ALTER TABLE Kommentar
  ADD CONSTRAINT fk_kommentarObjekt FOREIGN KEY (kommentarObjekt) REFERENCES FunObjekt(id);
ALTER TABLE GruppenMitgliedschaft
  ADD CONSTRAINT fk_trollName FOREIGN KEY (trollName) REFERENCES Troll(benutzerName);
ALTER TABLE GruppenMitgliedschaft
  ADD CONSTRAINT fk_gruppenId FOREIGN KEY (gruppenId) REFERENCES Gruppe(id);