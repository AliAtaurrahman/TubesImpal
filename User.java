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
    
    public void logout(){
        //Logika logout
    }
}
