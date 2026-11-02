package lilaluna;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class OrderController {
    private List<Pesanan> databasePesanan = new ArrayList<>();
    private List<String> auditLog = new ArrayList<>();

    public boolean tambahPesanan(String id, String nama, String jenis, String ukuran, int jumlah, double harga) {
        Pesanan pesananBaru = new Pesanan(id, nama, jenis, ukuran, jumlah, harga);

        if (!pesananBaru.validasiPesanan()) {
            auditLog.add("GAGAL: data pesanan ID " + id + " tidak valid");
            return false;
        }
        for (Pesanan p : databasePesanan) {
            if (p.getIdPesanan().equals(id)) {
                auditLog.add("GAGAL: ID " + id + " sudah ada");
                return false;
            }
        }

        databasePesanan.add(pesananBaru);
        auditLog.add("Menambahkan pesanan ID: " + id + " untuk " + nama);
        return true;
    }

    public List<Pesanan> getDatabasePesanan() {
        return Collections.unmodifiableList(databasePesanan);
    }

    public List<String> getAuditLog() {
        return auditLog;
    }
}