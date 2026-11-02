/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lilaluna;

/**
 *
 * @author Ali Ataurrahman
 */
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class FormAddOrder extends JFrame {
     private OrderController controller;
     private JTextField txtId, txtNama, txtJenis, txtUkuran, txtJumlah, txtHarga;
     
     public FormAddOrder(OrderController controller) {
        this.controller = controller;
        setTitle("LILALUNA - Add Order");
        setSize(350, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new GridLayout(7, 2, 5, 5));

        // UI Elements
        add(new JLabel(" ID:")); txtId = new JTextField(); add(txtId);
        add(new JLabel(" Nama Pelanggan:")); txtNama = new JTextField(); add(txtNama);
        add(new JLabel(" Jenis Kaos:")); txtJenis = new JTextField(); add(txtJenis);
        add(new JLabel(" Ukuran (S/M/L/XL/XXL):")); txtUkuran = new JTextField(); add(txtUkuran);
        add(new JLabel(" Jumlah:")); txtJumlah = new JTextField(); add(txtJumlah);
        add(new JLabel(" Harga:")); txtHarga = new JTextField(); add(txtHarga);

        JButton btnSimpan = new JButton("SIMPAN");
        add(new JLabel("")); 
        add(btnSimpan);

        // Action Listener (Langkah 1-7 di UI)
        btnSimpan.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                prosesSimpanData();
            }
        });
    }
     
     private void prosesSimpanData() {
        try {
            String id = txtId.getText();
            String nama = txtNama.getText();
            String jenis = txtJenis.getText();
            String ukuran = txtUkuran.getText().toUpperCase();
            int jumlah = Integer.parseInt(txtJumlah.getText());
            double harga = Double.parseDouble(txtHarga.getText());

            // Memanggil Controller
            boolean isSukses = controller.tambahPesanan(id, nama, jenis, ukuran, jumlah, harga);

            if (isSukses) {
                // Skenario Normal (Data Valid)
                JOptionPane.showMessageDialog(this, "Pesanan Berhasil Disimpan!", "Sukses", JOptionPane.INFORMATION_MESSAGE);
                clearForm();
            } else {
                // Skenario Alternatif (Data Tidak Valid)
                JOptionPane.showMessageDialog(this, "Validasi Gagal!\nPastikan data terisi dan ukuran sesuai.", "Error", JOptionPane.ERROR_MESSAGE);
            }
        } catch (NumberFormatException ex) {
            // Skenario Alternatif (Format Angka Salah)
            JOptionPane.showMessageDialog(this, "Jumlah dan Harga harus berupa angka!", "Error Format", JOptionPane.ERROR_MESSAGE);
        }
    }
     
    private void clearForm() {
        txtId.setText(""); txtNama.setText(""); txtJenis.setText("");
        txtUkuran.setText(""); txtJumlah.setText(""); txtHarga.setText("");
    }

}
