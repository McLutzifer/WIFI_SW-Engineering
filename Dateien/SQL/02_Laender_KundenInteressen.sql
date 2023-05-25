
/*==========================================================
|                                                          |
|   1. Laender Tabelle erzeugen                            |
|                                                          |
==========================================================*/

CREATE TABLE Laender (
  LandID INTEGER PRIMARY KEY,
  Land TEXT NOT NULL
);

/*==========================================================
|                                                          |
|   2. Laender Tabelle mit Daten auffüllen                 |
|                                                          |
==========================================================*/

INSERT INTO Laender (LandID, Land) VALUES 
  (1, 'Österreich'),
  (2, 'Deutschland'),
  (3, 'Italien'),
  (4, 'Spanien')
;

/*==========================================================
|                                                          |
|   3. Alle Spalten auswählen                              |
|                                                          |
==========================================================*/

SELECT * FROM Laender;

/*==========================================================
|                                                          |
|   4. KundenInteressen erzeugen                           |
|                                                          |
==========================================================*/

CREATE TABLE KundenInteressen  (
  Name TEXT NOT NULL,
  LandID INTEGER REFERENCES Laender,
  Interesse TEXT NOT NULL
);

/*==========================================================
|                                                          |
|   5. KundenInteressen mit Daten auffüllen                |
|                                                          |
==========================================================*/

INSERT INTO KundenInteressen (Name, LandID, Interesse) VALUES 
  ('Julia', 1, 'Reisen'),
  ('Hans',  2, 'Wandern'),
  ('Erika', 3, 'Lesen'),
  ('Max',   4, 'Reisen'),
  ('Beate', 3, 'Kultur'),
  ('Adam',  1, 'Lesen')
;

/*==========================================================
|                                                          |
|   6. Alle Spalten auswählen                              |
|                                                          |
==========================================================*/

SELECT * FROM KundenInteressen;

/*==========================================================
|                                                          |
|   7. Die zwei Tabellen zusammenfügen                     |
|                                                          |
==========================================================*/

SELECT * FROM KundenInteressen JOIN Laender USING (LandID);

/*==========================================================
|                                                          |
|   8. Spalten und Zeilen gleichzeitig auswählen           |
|                                                          |
==========================================================*/

/* SELECT Name FROM KundenInteressen JOIN Laender USING (LandID) WHERE Land = 'Österreich' AND Interesse = 'Reisen'; */

SELECT 
    Name 
FROM 
    KundenInteressen 
    JOIN Laender USING (LandID)
WHERE 
    Land = 'Österreich' AND Interesse = 'Reisen'
;

/*==========================================================
|                                                          |
|   9. Alle Tabellen löschen                               |
|                                                          |
==========================================================*/

DROP TABLE KundenInteressen;

DROP TABLE Laender;













