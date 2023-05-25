
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

-- Ein neues Mitglied kann ich sinnvoll nicht eintragen.
