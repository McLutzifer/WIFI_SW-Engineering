package kundeninteressenjdbc;

import java.io.*;
import java.sql.*;

class KundenInteressen {

    private static Connection conn;

    public static void main(String[] args) throws Exception {
        try {
            conn = DriverManager.getConnection("jdbc:sqlite::memory:");
            // See quirks:
            // https://www.sqlite.org/quirks.html#foreign_key_enforcement_is_off_by_default
            conn.createStatement().execute("PRAGMA foreign_keys = ON");
            conn.setAutoCommit(false);
            // Create the tables and fill them with data:
            ScriptRunner sr = new ScriptRunner(conn, false, false);
            sr.runScript(new StringReader(INIT_TABLE)); 
            // Do the actual work:
            run();
        }
        finally {
            if (conn != null) conn.close();
        }
        print("Done!");
    }

    static void run() throws SQLException {
        printTable();  
        // TODO: Add a new entry: (Marianne, Frankreich, Kochkunst)

        String name = "Marianne";
        String country = "Frankreich";
        String interesse = "Kochkunst";

        // TODO Frankreich zu Ländern hinzufügen
        int landID = insertLandInteresse("Laender", "Land", country, "LandID");
        // TODO Kochkunst zu Interessen hinzufügen
        int interessenID = insertLandInteresse("Interessen", "Interesse", interesse, "InteressenID");
        // TODO Marianne zu Kunden hinzufügen
        int kundenID = insertKunde(name, landID);
        // TODO Marianne und Kochkunst zu KundenInteressen hinzufügen
        insertKundenInteresse(kundenID, interessenID);

        printTable();
    }


    static int insertLandInteresse(String table, String column, String value, String id) throws SQLException {
        String sql = String.format("INSERT INTO %s (%s) VALUES (?) RETURNING %s", table, column, id);
        try (PreparedStatement insert = conn.prepareStatement(sql)) {
            insert.setString(1, value);
            try (ResultSet rs = insert.executeQuery()) {
                rs.next();
                return rs.getInt(id);
            }
        }
    }


    static int insertKunde(String name, int landID) throws SQLException{
        String sql = "INSERT INTO Kunden (Name, LandID) VALUES (?, ?) RETURNING KundenID";
        try (PreparedStatement insert = conn.prepareStatement(sql)) {
            insert.setString(1, name);
            insert.setInt(2, landID);
            try (ResultSet rs = insert.executeQuery()) {
                rs.next();
                return rs.getInt("KundenID");
            }
        }
    }


    static void insertKundenInteresse(int kundenID, int interessenID) throws SQLException {
        String sql = "INSERT INTO KundenInteressen (KundenID, InteressenID) VALUES (?, ?)";
        try (PreparedStatement insert = conn.prepareStatement(sql)) {
            insert.setInt(1, kundenID);
            insert.setInt(2, interessenID);
            insert.execute();
        }
    }


    static void printTable() throws SQLException {
        try (Statement stm = conn.createStatement()) {
            try (ResultSet rs = stm.executeQuery(SELECT_ALL)) {
                print("---------------------------------------------------------");
                String fmt = "Name: %s, Land: %s, Interesse: %s\n";
                while(rs.next())
                    printf(fmt, rs.getString("Name"), rs.getString("Land"), rs.getString("Interesse"));
                print("---------------------------------------------------------");
            }
        }
    }

    static String INIT_TABLE = ""
            + "CREATE TABLE Laender ( \n"
            + "  LandID INTEGER PRIMARY KEY, \n"
            + "  Land TEXT NOT NULL UNIQUE \n"
            + "); \n"
            + " \n"
            + "INSERT INTO Laender (Land) VALUES  \n"
            + " ('Österreich'), \n"
            + " ('Deutschland'), \n"
            + " ('Italien'), \n"
            + " ('Spanien') \n"
            + "; \n"
            + " \n"
            + "CREATE TABLE Interessen ( \n"
            + "  InteressenID INTEGER PRIMARY KEY, \n"
            + "  Interesse TEXT NOT NULL UNIQUE \n"
            + "); \n"
            + " \n"
            + "INSERT INTO Interessen (Interesse) VALUES \n"
            + "  ('Reisen'), \n"
            + "  ('Wandern'), \n"
            + "  ('Lesen'), \n"
            + "  ('Kultur') \n"
            + "; \n"
            + " \n"
            + "CREATE TABLE Kunden ( \n"
            + "  KundenID INTEGER PRIMARY KEY, \n"
            + "  Name TEXT NOT NULL, \n"
            + "  LandID INTEGER REFERENCES Laender, \n"
            + "   \n"
            + "  UNIQUE (Name, LandID) \n"
            + "); \n"
            + " \n"
            + "INSERT INTO Kunden (Name, LandID) VALUES  \n"
            + " ('Julia',1), \n"
            + " ('Hans', 2), \n"
            + " ('Erika',3), \n"
            + " ('Max',  4), \n"
            + " ('Beate',3), \n"
            + " ('Adam', 1) \n"
            + "; \n"
            + " \n"
            + " \n"
            + "CREATE TABLE KundenInteressen  ( \n"
            + "  KundenID INTEGER REFERENCES Kunden, \n"
            + "  InteressenID INTEGER REFERENCES Interessen, \n"
            + "  PRIMARY KEY (KundenID, InteressenID) \n"
            + "); \n"
            + " \n"
            + " \n"
            + "INSERT INTO KundenInteressen (KundenID, InteressenID) VALUES  \n"
            + " (1, 1), \n"
            + " (2, 2), \n"
            + " (3, 3), \n"
            + " (4, 1), \n"
            + " (5, 4), \n"
            + " (6, 3) \n"
            + "; ";

    static String SELECT_ALL = ""
            + "SELECT  "
            + "    Name, Interesse, Land "
            + "FROM  "
            + "    KundenInteressen  "
            + "    JOIN Kunden USING (KundenID) "
            + "    JOIN Interessen USING (InteressenID) "
            + "    JOIN Laender USING (LandID)";

    static void print(Object o) {
        System.out.println(o);
    }

    static void printf(String fmt, Object... objs) {
        System.out.printf(fmt, objs);
    }
}
