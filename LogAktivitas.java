package com.lilaluna.model;

import java.time.LocalDateTime;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class LogAktivitas {

    private String idLog;
    private LocalDateTime waktu;
    private String aksi;

    public LogAktivitas() {
    }

    public void simpanLog(String detail) {

        // Membuat ID log yang berbeda setiap kali program dijalankan
        idLog = "LOG" + System.currentTimeMillis();
        waktu = LocalDateTime.now();
        aksi = detail;

        try {

            Connection conn = Koneksi.getConnection();

            String sql = "INSERT INTO log_aktivitas (idLog, waktu, aksi) VALUES (?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, idLog);
            ps.setObject(2, waktu);
            ps.setString(3, aksi);

            ps.executeUpdate();

            System.out.println("Log aktivitas berhasil disimpan ke database.");
            System.out.println("ID Log: " + idLog);
            System.out.println("Waktu: " + waktu);
            System.out.println("Aksi: " + aksi);

        } catch (Exception e) {

            System.out.println("Gagal menyimpan log: " + e.getMessage());

        }
    }
}