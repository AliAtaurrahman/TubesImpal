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
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 1. CEK URL INI: Apakah nama database-nya sudah benar?
            String url = "jdbc:mysql://localhost:3306/lilaluna_3"; 
            
            // 2. CEK USER & PASS: Apakah MySQL Anda pakai password?
            String user = "root"; 
            String password = ""; // Jika MySQL Anda pakai password, isi di sini. Jika tidak, biarkan kosong.
            
            conn = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            System.out.println("KONEKSI GAGAL: " + e.getMessage()); // Akan muncul di Output NetBeans jika error
        }
        return conn;
    }
}
