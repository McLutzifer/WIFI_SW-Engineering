
/*==========================================================
|                                                          |
|   1. Laender Tabelle erzeugen                            |
|                                                          |
==========================================================*/

CREATE TABLE Laender (
  LandID INTEGER PRIMARY KEY,
  Land TEXT NOT NULL UNIQUE
);

/*==========================================================
|                                                          |
|   2. Laender Tabelle mit Daten auffüllen                 |
|                                                          |
==========================================================*/

INSERT INTO Laender (Land) VALUES 
  ('Österreich'),
  ('Deutschland'),
  ('Italien'),
  ('Spanien')
;

/*==========================================================
|                                                          |
|   3. Alle Spalten auswählen                              |
|                                                          |
==========================================================*/

SELECT * FROM Laender;

/*==========================================================
|                                                          |
|   4. Interessen Tabelle erzeugen                         |
|                                                          |
==========================================================*/

CREATE TABLE Interessen (
  InteressenID INTEGER PRIMARY KEY,
  Interesse TEXT NOT NULL UNIQUE
);

/*==========================================================
|                                                          |
|   5. Interessen Tabelle mit Daten auffüllen              |
|                                                          |
==========================================================*/

INSERT INTO Interessen (Interesse) VALUES
  ('Reisen'),
  ('Wandern'),
  ('Lesen'),
  ('Kultur')
;

/*==========================================================
|                                                          |
|   6. Alle Spalten auswählen                              |
|                                                          |
==========================================================*/

SELECT * FROM Interessen;

/*==========================================================
|                                                          |
|   7. Kunden Tabelle erzeugen                             |
|                                                          |
==========================================================*/

CREATE TABLE Kunden (
  KundenID INTEGER PRIMARY KEY,
  Name TEXT NOT NULL,
  LandID INTEGER REFERENCES Laender,
  
  UNIQUE (Name, LandID)
);

/*==========================================================
|                                                          |
|   8. Kunden Tabelle mit Daten auffüllen                  |
|                                                          |
==========================================================*/

INSERT INTO Kunden (Name, LandID) VALUES 
  ('Julia',1),
  ('Hans', 2),
  ('Erika',3),
  ('Max',  4),
  ('Beate',3),
  ('Adam', 1)
;

/*==========================================================
|                                                          |
|   9. Alle Spalten auswählen                              |
|                                                          |
==========================================================*/

SELECT * FROM Kunden;

/*==========================================================
|                                                          |
|   10. KundenInteressen Tabelle erzeugen                  |
|                                                          |
==========================================================*/

CREATE TABLE KundenInteressen  (
  KundenID INTEGER REFERENCES Kunden,
  InteressenID INTEGER REFERENCES Interessen,
  
  PRIMARY KEY (KundenID, InteressenID)
);

/*==========================================================
|                                                          |
|   11. KundenInteressen Tabelle mit Daten auffüllen       |
|                                                          |
==========================================================*/

INSERT INTO KundenInteressen (KundenID, InteressenID) VALUES 
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 1),
  (5, 4),
  (6, 3)
;

/*==========================================================
|                                                          |
|   12. Alle Spalten auswählen                             |
|                                                          |
==========================================================*/

SELECT * FROM KundenInteressen;

/*==========================================================
|                                                          |
|   13. Alle 4 Tabellen zusammenfügen                      |
|                                                          |
==========================================================*/

SELECT 
    *
FROM 
    KundenInteressen 
    JOIN Kunden USING (KundenID)
    JOIN Interessen USING (InteressenID)
    JOIN Laender USING (LandID)
;

/*==========================================================
|                                                          |
|   14. Spalten und Zeilen auswählen                       |
|                                                          |
==========================================================*/

SELECT 
    Name
FROM 
    KundenInteressen 
    JOIN Kunden USING (KundenID)
    JOIN Interessen USING (InteressenID)
    JOIN Laender USING (LandID)
WHERE 
    Land = 'Österreich' AND Interesse = 'Reisen'
;

/*==========================================================
|                                                          |
|   15. Vor der Änderung                                   |
|                                                          |
==========================================================*/

SELECT 
    *
FROM 
    Interessen
;

/*==========================================================
|                                                          |
|   16. Änderung durchführen                               |
|                                                          |
==========================================================*/

UPDATE 
    Interessen
SET 
    Interesse = 'Städtereisen'
WHERE 
    Interesse = 'Reisen'
;

/*==========================================================
|                                                          |
|   17. Nach der Änderung                                  |
|                                                          |
==========================================================*/

SELECT 
    *
FROM 
    Interessen
;

/*==========================================================
|                                                          |
|   18. Alle Reisen wurden automatisch überall geändert    |
|                                                          |
==========================================================*/

SELECT 
    Name, Land, Interesse
FROM 
    KundenInteressen 
    JOIN Kunden USING (KundenID)
    JOIN Interessen USING (InteressenID)
    JOIN Laender USING (LandID)
;

/*==========================================================
|                                                          |
|   19. Löschen                                            |
|                                                          |
==========================================================*/

/* Die Interessen von Beate werden aus dem KundenInteressen geloescht,
  wir brauchen erst die ID-Nummern: KundenID und InteressenID */
SELECT
    KundenID, InteressenID, Name
FROM 
    KundenInteressen
    JOIN Kunden USING (KundenID)
;

/* Die Interessen von Beate werden aus dem KundenInteressen geloescht 
   aber Beate nicht. */
DELETE FROM 
    KundenInteressen
WHERE 
    KundenID = 5 AND InteressenID = 4
;

/*==========================================================
|                                                          |
|   20. Überprüfen                                         |
|                                                          |
==========================================================*/

SELECT
    KundenID, InteressenID, Name
FROM 
    KundenInteressen
    JOIN Kunden USING (KundenID)
;

/* Beate soll immer noch eine Kundin sein */
SELECT
    *
FROM 
    Kunden
;

/*==========================================================
|                                                          |
|   21. Neue Zeile eintragen                               |
|                                                          |
==========================================================*/

INSERT INTO 
    Interessen (Interesse) 
VALUES
  ('Musik')
RETURNING
  InteressenID
;

SELECT 
    *
FROM
    Interessen
;

/*==========================================================
|                                                          |
|   22. Fremdschlüssel Integrität,                         |
|       darf nicht gelingen.                               |
|                                                          |
==========================================================*/

DELETE FROM 
    Kunden
WHERE 
    Name = 'Max'
;

/*==========================================================
|                                                          |
|   23. Aufgabe: Max löschen; Bitte immer ID benutzen!     |
|                                                          |
==========================================================*/



/*==========================================================
|                                                          |
|   24. Aufgabe: eine neue Kundin eintragen, Marianne aus  |
|       Frankreich, ihr Interesse ist Kochkunst            |
|                                                          |
==========================================================*/


