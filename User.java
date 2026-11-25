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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
    private String password;
    private String username;
    
    public User(String username, String password){
        this.username = username;
        this.password = password;
    }
    
    public boolean login(String email, String pass){
        String query = "SELECT * FROM user WHERE Email = ? AND password = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
              
            System.out.println("Mencoba login dengan Email: [" + email + "] dan Pass: [" + pass + "]");
            
            pstmt.setString(1, email);
            pstmt.setString(2, pass);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                
                System.out.println("BERHASIL! Data ditemukan di database.");
                this.username = rs.getString("Email");
                return true; // Login berhasil
            }else{
                System.out.println("GAGAL! Email/Pass tidak cocok dengan database.");
            }
        } catch (SQLException | NullPointerException e) {
           System.out.println("Sistem Gagal: " + e.getMessage());
        }
        return false; // Login gagal
    }
    
    public boolean register(String nama, String email, String pass) {
        // 1. Query untuk mencari ID terakhir
        String getLastIdQuery = "SELECT ID_User FROM user ORDER BY ID_User DESC LIMIT 1";
        // 2. Query untuk insert
        String insertQuery = "INSERT INTO user (ID_User, Nama_User, Email, password) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            
            // --- LOGIKA MEMBUAT ID OTOMATIS (USR01 -> USR02) ---
            String newId = "USR01"; // Default jika tabel kosong
            try (PreparedStatement pstmtGet = conn.prepareStatement(getLastIdQuery);
                 ResultSet rs = pstmtGet.executeQuery()) {
                if (rs.next()) {
                    String lastId = rs.getString("ID_User"); // Misal dapat "USR01"
                    // Ambil angkanya saja (buang "USR") lalu tambah 1
                    int number = Integer.parseInt(lastId.substring(3)) + 1;
                    // Format kembali menjadi USR + angka (tambah 0 di depan jika perlu)
                    newId = String.format("USR%02d", number); 
                }
            }

            // --- PROSES INSERT ---
            try (PreparedStatement pstmtInsert = conn.prepareStatement(insertQuery)) {
                pstmtInsert.setString(1, newId);
                pstmtInsert.setString(2, nama);
                pstmtInsert.setString(3, email);
                pstmtInsert.setString(4, pass);
                
                int rowsAffected = pstmtInsert.executeUpdate();
                return rowsAffected > 0;
            }
            
        } catch (SQLException e) {
            System.out.println("=== ERROR REGISTRASI DATABASE ===");
            System.out.println("Pesan: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public void logout(){
        //Logika logout
    }
}
