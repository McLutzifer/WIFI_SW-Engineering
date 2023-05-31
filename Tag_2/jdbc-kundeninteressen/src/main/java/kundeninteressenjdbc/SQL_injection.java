package kundeninteressenjdbc;

import java.io.*;
import java.sql.*;

public class SQL_injection {

    private static Connection conn;
    
    public static void main(String[] args) throws Exception {
        try {
            conn = DriverManager.getConnection("jdbc:sqlite::memory:");
            try (Statement stm = conn.createStatement()) {
                stm.execute("CREATE TABLE Students (Name)");
            }
            // Joke from https://xkcd.com/327/
            String name  = "Robert";
            String malicious = "Robert');\n DROP TABLE Students;\n -- ";
            badInsert(name); // change name to malicious and it will drop the table
            printTable();
            goodInsert(malicious); // it properly handles even malicious input
            printTable();
            print("Done!");
        }
        catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        finally {
            if (conn != null) conn.close();
        }
    }

    static void badInsert(String name) throws Exception {
        String s = "INSERT INTO Students (Name) VALUES ('"+name+"')";
        print("Bad insert is about to execute:");
        print(s);
        ScriptRunner sr = new ScriptRunner(conn, false, false);
        sr.runScript(new StringReader(s)); 
    }
    
    static void goodInsert(String name) throws SQLException {
        String sql = "INSERT INTO Students (Name) VALUES (?)";       
        try (PreparedStatement insert = conn.prepareStatement(sql)) {
            insert.setString(1, name);
            int nrows = insert.executeUpdate();
            print("goodInsert() inserted "+nrows+" row");
        }
    }
    
    static void printTable() throws SQLException {
        String sql = "SELECT * FROM Students";
        try (Statement stm = conn.createStatement()) {
            try (ResultSet rs = stm.executeQuery(sql)) {
                print("---------------------------------------------------------");
                print(sql);
                for (int i=1; rs.next(); ++i) {
                    print(i + "  " + rs.getString("Name"));
                }
                print("---------------------------------------------------------");
            }
        }
    }
    
    static void print(Object o) {
        System.out.println(o);
    }
}
