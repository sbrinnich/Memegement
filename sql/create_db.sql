-- Create Database
USE Master;

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
  benutzerName varchar not null primary key,
  passwortHash varchar not null,
  beitrittsDatum date not null,
  profilBild int
);

Create table FunObjekt (
  id int not null primary key identity(1,1),
  titel varchar not null,
  uploadDatum date not null,
  durchschnittsBewertung float,
  erstellerName varchar foreign key references Troll(benutzername)
);

Create table Bild (
  funObjektId int not null primary key foreign key references FunObjekt(id),
  typ varchar not null,
  link varchar not null
);

Create table Video (
  funObjektId int not null primary key foreign key references FunObjekt(id),
  dauer time not null,
  link varchar not null
);

Create table Witz (
  funObjektId int not null primary key foreign key references FunObjekt(id),
  text varchar not null
);

Create table Gruppe (
  id int not null primary key identity(1,1),
  name varchar not null,
  beschreibung varchar,
  gruendungsDatum date not null,
  gruenderName varchar foreign key references Troll(benutzername),
  gruppenBild int foreign key references Bild(funObjektId)
);

Create table Bewertung (
  bewerterName varchar not null foreign key references Troll(benutzername),
  bewertungsObjekt int not null foreign key references FunObjekt(id),
  bewertung float not null,
  bewertungsDatum date not null,
  primary key (bewerterName, bewertungsObjekt)
);

Create table Kommentar (
  kommentiererName varchar not null foreign key references Troll(benutzername),
  kommentarObjekt int not null foreign key references FunObjekt(id),
  erstellungsDatum date not null,
  text varchar not null,
  primary key (kommentiererName, kommentarObjekt, erstellungsDatum)
);

Create table GruppenMitgliedschaft (
  trollName varchar not null foreign key references Troll(benutzername),
  gruppenId int not null foreign key references Gruppe(id),
  beitrittsDatum date not null,
  primary key (trollName, gruppenId)
);

GO

-- Add missing foreign key constraints

Alter table Troll add constraint fkTrollProfilbild foreign key (profilBild) references Bild(funObjektId);
GO