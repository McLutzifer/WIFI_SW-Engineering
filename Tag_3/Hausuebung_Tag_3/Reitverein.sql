
/*
 * old
 */
CREATE TABLE Trainings_old (
    Startzeit TEXT,
    Vorname TEXT,
    Nachname TEXT,
    Geburtsdatum TEXT,
    PferdName TEXT,
    ReitplatzName TEXT
);

INSERT INTO Trainings_old
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



/*
 * new
 */

CREATE TABLE Pferde (
  PferdeID INTEGER PRIMARY KEY,
  Name TEXT NOT NULL,
    
  UNIQUE (PferdeID, Name)
);

INSERT INTO Pferde (Name) VALUES 
 ('Cinkos'), ('Florian'), ('Pretty'), ('Robin'), ('Aurea');

SELECT * FROM Pferde;


CREATE TABLE Reiter (
  ReiterID INTEGER PRIMARY KEY,
  Vorname TEXT NOT NULL,
  Nachname TEXT NOT NULL,
  Geburtsdatum TEXT NOT NULL,
    
  UNIQUE (ReiterID, Vorname, Nachname)
);

INSERT INTO Reiter (Vorname, Nachname, Geburtsdatum) VALUES
	('Rici',   'Pernold', '1994-01-17'),
	('Kathi',  'Müller',  '2004-11-17'),
	('Lilo',   'Schmidt', '1998-02-07'),
	('Herbert','Maier',   '1998-04-23')
;

SELECT * FROM Reiter;


CREATE TABLE Reitplatz (
	ReitplatzID INTEGER PRIMARY KEY, 
	ReitplatzName TEXT NOT NULL UNIQUE, 
	
	UNIQUE (ReitplatzID, ReitplatzName)
);

INSERT INTO Reitplatz (ReitplatzName) VALUES 
	('Viereck'), ('Sprungplatz'), ('Halle') ;

SELECT * FROM Reitplatz;

drop table Trainings

CREATE TABLE Trainings (
	TrainingsID INTEGER PRIMARY KEY,
	ReiterID INTEGER REFERENCES Reiter NOT NULL,
	PferdeID INTEGER REFERENCES Pferde NOT NULL,
	Startzeit TEXT NOT NULL,
	ReitplatzID INTEGER NOT NULL,
	
	UNIQUE (Startzeit, ReiterID), 
	UNIQUE (ReiterID, PferdeID, Startzeit),
	UNIQUE (PferdeID, Startzeit)
);

INSERT INTO Trainings (ReiterID, PferdeID, Startzeit, ReitplatzID) VALUES 
	(1, 1, '2022-06-17 16:00', 1),
	(2, 1, '2022-06-17 18:00', 1),
	(3, 2, '2022-06-18 16:00', 1),
	(4, 3, '2022-06-18 18:00', 2),
	(1, 4, '2022-06-19 16:00', 1),
	(3, 3, '2022-06-19 16:00', 3),
	(2, 3, '2022-06-19 18:00', 2),
	(3, 5, '2022-06-19 18:00', 3)
;

SELECT * FROM Trainings;


------------------------------------------------------------

/*
 * old
 */
SELECT 
    Startzeit, Vorname, Nachname 
FROM 
    Trainings 
WHERE 
    Startzeit BETWEEN '2022-06-17' AND '2022-06-19'
;

/*
 * new
 */
SELECT 
    Startzeit, Vorname, Nachname 
FROM 
    Trainings JOIN Reiter USING (ReiterID)
WHERE 
    Startzeit BETWEEN '2022-06-17' AND '2022-06-19'
;

------------------------------------------------------------
/*
 * old
 */
-- Ein Pferd geht verloren:
SELECT DISTINCT PferdName FROM Trainings;
-- SELECT * FROM Trainings WHERE ROWID = 5;
DELETE FROM Trainings WHERE ROWID = 5;
SELECT DISTINCT PferdName FROM Trainings;

/*
 * new
 */
SELECT DISTINCT Name FROM Trainings JOIN Pferde USING (PferdeID);
SELECT * FROM Trainings WHERE ROWID = 5;
DELETE FROM Trainings WHERE ROWID = 5;
SELECT DISTINCT Name FROM Trainings JOIN Pferde USING (PferdeID);

------------------------------------------------------------

-- Widersprüchliche Daten:
/*
 * old
 */
UPDATE Trainings SET Geburtsdatum = '1997-03-20' WHERE ROWID = 2;
SELECT * FROM Trainings WHERE Vorname = 'Kathi';

/*
 * new
 */
UPDATE Reiter SET Geburtsdatum = '1997-03-20' WHERE Vorname = 'Kathi' AND Nachname = 'Müller';
SELECT * FROM Trainings JOIN Reiter USING (ReiterID) WHERE Vorname = 'Kathi';
------------------------------------------------------------

-- Ein neues Mitglied kann ich sinnvoll nicht eintragen.

/*
 * new
 */

INSERT INTO Reiter (Vorname, Nachname, Geburtsdatum) VALUES
	('Lukas',   'Iselor', '1989-11-13')
;

SELECT * FROM Reiter;

------------------------------------------------------------

-- keine "wilden Ungarn" mehr möglich ;)
INSERT INTO Trainings (ReiterID, PferdeID, Startzeit, ReitplatzID) VALUES
	(1, 1, '1999-01-01', 1),
	(1, 2, '1999-01-01', 1)
	
-- und auch kein Pferd an zwei Orten gleichzeitig
	
INSERT INTO Trainings (ReiterID, PferdeID, Startzeit, ReitplatzID) VALUES
	(1, 2, '2023-12-24', 1),
	(2, 2, '2023-12-24', 2)
	



