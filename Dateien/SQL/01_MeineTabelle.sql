
/*==========================================================
|                                                          |
|   1. MeineTabelle erzeugen                               |
|                                                          |
==========================================================*/

CREATE TABLE MeineTabelle  (
  Name,
  Land,
  Interesse
);

/*==========================================================
|                                                          |
|   2. MeineTabelle mit Daten auffüllen                    |
|                                                          |
==========================================================*/

INSERT INTO MeineTabelle (Name, Land, Interesse) VALUES 
  ('Julia','Österreich', 'Reisen'),
  ('Hans', 'Deutschland','Wandern'),
  ('Erika','Italien',    'Lesen'),
  ('Max',  'Spanien',    'Reisen'),
  ('Beate','Italien',    'Kultur'),
  ('Adam', 'Österreich', 'Lesen')
;

/*==========================================================
|                                                          |
|   3. Alle Spalten auswählen                              |
|                                                          |
==========================================================*/

SELECT * FROM MeineTabelle;

/*==========================================================
|                                                          |
|   4. Nur bestimmte Spalten auswählen                     |
|                                                          |
==========================================================*/

SELECT Name, Interesse FROM MeineTabelle;

/*==========================================================
|                                                          |
|   5. Zeilen auswählen                                    |
|                                                          |
==========================================================*/

SELECT * FROM MeineTabelle WHERE Land = 'Österreich';

/*==========================================================
|                                                          |
|   6. Spalten und Zeilen gleichzeitig auswählen           |
|                                                          |
==========================================================*/

SELECT Name, Interesse FROM MeineTabelle WHERE Land = 'Österreich';

/*==========================================================
|                                                          |
|   7. Bedingungen kombinieren (Österreich UND Reisen)     |
|                                                          |
==========================================================*/

SELECT Name FROM MeineTabelle WHERE Land = 'Österreich' AND Interesse = 'Reisen';

/*==========================================================
|                                                          |
|   8. Tabelle löschen                                     |
|                                                          |
==========================================================*/

DROP TABLE MeineTabelle;













