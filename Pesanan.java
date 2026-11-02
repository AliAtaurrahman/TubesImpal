package com.lilaluna.model;

public class Pesanan {

    private String idPesanan;
    private String namaPelanggan;
    private String jenisKaos;
    private String ukuran;
    private int jumlah;
    private double harga;

    public Pesanan(String idPesanan, String namaPelanggan,
                   String jenisKaos, String ukuran,
                   int jumlah, double harga) {

        this.idPesanan = idPesanan;
        this.namaPelanggan = namaPelanggan;
        this.jenisKaos = jenisKaos;
        this.ukuran = ukuran;
        this.jumlah = jumlah;
        this.harga = harga;
    }

    public boolean validasiPesanan() {

        if (namaPelanggan == null || namaPelanggan.isEmpty()) {
            return false;
        }

        if (jumlah <= 0 || harga <= 0) {
            return false;
        }

        if (!ukuran.matches("S|M|L|XL|XXL")) {
            return false;
        }

        return true;
    }

    public String getIdPesanan() {
        return idPesanan;
    }

    public String getNamaPelanggan() {
        return namaPelanggan;
    }

    public String getJenisKaos() {
        return jenisKaos;
    }

    public String getUkuran() {
        return ukuran;
    }

    public int getJumlah() {
        return jumlah;
    }

    public double getHarga() {
        return harga;
    }
}