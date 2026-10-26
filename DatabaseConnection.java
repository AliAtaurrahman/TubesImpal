/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lilaluna;

/**
 *
 * @author Ali Ataurrahman
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://127.0.0.1:3306/lilaluna(3)";
    private static final String USER = "root"; // Sesuaikan username MySQL Anda
    private static final String PASSWORD = ""; // Sesuaikan password MySQL Anda

    public static Connection getConnection() {
        Connection conn = null;
        try {
             
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Koneksi Database Gagal: " + e.getMessage());
        }
        return conn;
    }
}
