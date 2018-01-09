-- Create Database
USE Master;
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
  benutzerName varchar(15) not null UNIQUE,
  passwortHash varchar(256) not null,
  beitrittsDatum date not null,
  profilBild int
);

Create table FunObjekt (
  id int not null primary key identity(1,1),
  titel varchar(50) not null,
  uploadDatum date not null,
  durchschnittsBewertung float,
  erstellerId int not null
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
  gruenderId int not null,
  gruppenBild int not null
);

Create table Bewertung (
  bewerterId int not null,
  bewertungsObjekt int not null,
  bewertung float not null,
  bewertungsDatum date not null,
  primary key (bewerterId, bewertungsObjekt)
);

Create table Kommentar (
  kommentiererID int not null,
  kommentarObjekt int not null,
  erstellungsDatum date not null,
  text varchar(256) not null,
  primary key (kommentiererID, kommentarObjekt, erstellungsDatum)
);

Create table GruppenMitgliedschaft (
  trollId int not null,
  gruppenId int not null,
  beitrittsDatum date not null,
  primary key (trollId, gruppenId)
);

GO

-- Add the foreign-key Constraints

Alter table Troll
  add constraint fk_trollProfilbild foreign key (profilBild) references Bild(funObjektId);
ALTER TABLE FunObjekt
  ADD CONSTRAINT fk_erstellerId FOREIGN KEY (erstellerId) REFERENCES Troll(id);
ALTER TABLE Bild
  ADD CONSTRAINT fk_bildFunObjektId FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Video
  ADD CONSTRAINT fk_videoFunObjektId FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Witz
  ADD CONSTRAINT fk_witzFunObjektId FOREIGN KEY (funObjektId) REFERENCES FunObjekt(id);
ALTER TABLE Gruppe
  ADD CONSTRAINT fk_gruenderId FOREIGN KEY (gruenderId) REFERENCES Troll(id);
ALTER TABLE Gruppe
  ADD CONSTRAINT fk_gruppenBild FOREIGN KEY (gruppenBild) REFERENCES Bild(funObjektId);
ALTER TABLE Bewertung
  ADD CONSTRAINT fk_bewerterId FOREIGN KEY (bewerterId) REFERENCES Troll(id);
ALTER TABLE Bewertung
  ADD CONSTRAINT fk_bewertungsObjekt FOREIGN KEY (bewertungsObjekt) REFERENCES FunObjekt(id);
ALTER TABLE Kommentar
  ADD CONSTRAINT fk_kommentiererId FOREIGN KEY (kommentiererId) REFERENCES Troll(id);
ALTER TABLE Kommentar
  ADD CONSTRAINT fk_kommentarObjekt FOREIGN KEY (kommentarObjekt) REFERENCES FunObjekt(id);
ALTER TABLE GruppenMitgliedschaft
  ADD CONSTRAINT fk_trollId FOREIGN KEY (trollId) REFERENCES Troll(id);
ALTER TABLE GruppenMitgliedschaft
  ADD CONSTRAINT fk_gruppenId FOREIGN KEY (gruppenId) REFERENCES Gruppe(id);

GO