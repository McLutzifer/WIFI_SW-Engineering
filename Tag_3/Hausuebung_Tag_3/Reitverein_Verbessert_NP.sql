
CREATE TABLE Trainings (
    Startzeit TEXT,
    Vorname TEXT,
    Nachname TEXT,
    Geburtsdatum TEXT,
    PferdName TEXT,
    ReitplatzName TEXT
);

INSERT INTO Trainings 
( Startzeit,          Vorname,  Nachname,  Geburtsdatum, PferdName, ReitplatzName) VALUES
('2022-06-17 16:00', 'Rici',   'Pernold', '1994-01-17', 'Cinkos',  'Viereck'),
('2022-06-17 18:00', 'Kathi',  'Müller',  '2004-11-17', 'Cinkos',  'Viereck'),
('2022-06-18 16:00', 'Lilo',   'Schmidt', '1998-02-07', 'Florian', 'Viereck'),
('2022-06-18 18:00', 'Herbert','Maier',   '1998-04-23', 'Pretty',  'Sprungplatz'),
('2022-06-19 16:00', 'Rici',   'Pernold', '1994-01-17', 'Robin',   'Viereck'),
('2022-06-19 16:00', 'Lilo',   'Schmidt', '1998-02-07', 'Pretty',  'Halle'),
('2022-06-19 18:00', 'Kathi',  'Müller',  '2004-11-17', 'Pretty',  'Sprungplatz'),
('2022-06-19 18:00', 'Lilo',   'Schmidt', '1998-02-07', 'Aurea',   'Halle')
;

SELECT * FROM Trainings;

------------------------------------------------------------

/*
SELECT 
    Startzeit, Vorname, Nachname 
FROM 
    Trainings 
WHERE 
    Startzeit BETWEEN '2022-06-17' AND '2022-06-19'
;

------------------------------------------------------------

-- Ein Pferd geht verloren:
SELECT DISTINCT PferdName FROM Trainings;
-- SELECT * FROM Trainings WHERE ROWID = 5;
DELETE FROM Trainings WHERE ROWID = 5;
SELECT DISTINCT PferdName FROM Trainings;

------------------------------------------------------------

-- Widersprüchliche Daten:
UPDATE Trainings SET Geburtsdatum = '1997-03-20' WHERE ROWID = 2;
SELECT * FROM Trainings WHERE Vorname = 'Kathi';

------------------------------------------------------------

-- Ein neues Mitglied kann ich sinnvoll nicht eintragen.*/

-------------------------------------------------------------

-- Verbesserte Struktur : 

-- 2 neue Tabellen anlegen:

CREATE TABLE Horses (
	Horse_ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL UNIQUE
);


CREATE TABLE Members (
	Member_ID INTEGER PRIMARY KEY, 
	Vorname TEXT NOT NULL,
	Nachname TEXT NOT NULL,
	Geburtsdatum TEXT NOT NULL,
	
	UNIQUE (Vorname, Nachname, Geburtsdatum)	
);

-- Neue Tabellen mit den Daten aus der Trainings-Tabelle befüllen:

INSERT INTO Horses (Name)
SELECT DISTINCT PferdName 
FROM Trainings
;

SELECT * FROM Horses;

INSERT INTO Members (Vorname, Nachname, Geburtsdatum)
SELECT DISTINCT Vorname, Nachname, Geburtsdatum
FROM Trainings 
;

SELECT * FROM Members;

-- Neue Spalten in Trainings hinzufügen als Foreign Keys:

ALTER TABLE Trainings
ADD COLUMN 
	Member_ID INTEGER REFERENCES Members
;	

ALTER TABLE Trainings
ADD COLUMN 
	Horse_ID INTEGER REFERENCES Horses
;


-- Die Foreign Keys in Trainings mit den passenden Daten befüllen:

UPDATE Trainings
SET Horse_ID = (
	SELECT Horses.Horse_ID
	FROM Horses
	WHERE Horses.Name = Trainings.PferdName
)
;

UPDATE Trainings
SET Member_ID = (
	SELECT Members.Member_ID
	FROM Members
	WHERE Members.Vorname = Trainings.Vorname 
	AND Members.Nachname = Trainings.Nachname
	AND Members.Geburtsdatum = Trainings.Geburtsdatum
)
;

SELECT * FROM Trainings;

-- Nunmehr redundante Spalten in Trainings entfernen: 

ALTER TABLE Trainings 
DROP COLUMN Vorname
;

ALTER TABLE Trainings
DROP COLUMN Nachname
;

ALTER TABLE Trainings
DROP COLUMN Geburtsdatum
;

ALTER TABLE Trainings
DROP COLUMN PferdName
;

-- Alle Daten auf einen Blick: 

SELECT * FROM Trainings
JOIN Horses using (Horse_ID)
JOIN Members using (Member_ID)
;

-------------ERGEBNIS------------------------------

-- Pferd geht nicht mehr verloren: 

SELECT * FROM Horses;
DELETE FROM Trainings WHERE ROWID = 5;
SELECT * FROM Horses;

-- Geburtsdatum von Member muss nur einmal geändert werden, weil es Member nur mehr einmal gibt:

UPDATE Members
SET Geburtsdatum = '1997-03-20' 
WHERE Member_ID = 2
;

SELECT * FROM Members 
WHERE Member_ID = 2
;

-- Neue Mitglieder können sinnvoll hinzugefügt werden:

INSERT INTO Members (Vorname, Nachname, Geburtsdatum) VALUES
('Nicole', 'Perak', '1993-09-21')
;

SELECT * FROM Members;















