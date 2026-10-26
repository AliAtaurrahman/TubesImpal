-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 26, 2026 at 10:57 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lilaluna`
-- Jalankan pada lingkungan tugas yang memang boleh dibuat/direset.
CREATE DATABASE IF NOT EXISTS `lilaluna` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lilaluna`;
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `ID_Log` varchar(50) NOT NULL,
  `ID_User` varchar(50) NOT NULL,
  `Tabel_Target` varchar(50) DEFAULT NULL,
  `ID_Referensi` varchar(50) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `Deskripsi` text DEFAULT NULL,
  `waktu_aksi` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_pesanan`
--

CREATE TABLE `detail_pesanan` (
  `ID_detail_Pesanan` varchar(50) NOT NULL,
  `ID_pesanan` varchar(50) NOT NULL,
  `ID_produk` varchar(50) NOT NULL,
  `Kuantitas` int(11) NOT NULL,
  `Diskon` decimal(5,2) DEFAULT 0.00,
  `Keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `ID_Pesanan` varchar(50) NOT NULL,
  `ID_User` varchar(50) NOT NULL,
  `Nama_pelanggan` varchar(100) DEFAULT NULL,
  `Tanggal_pesanan` datetime DEFAULT NULL,
  `Kode_pesanan` varchar(50) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `Total_Item` int(11) DEFAULT NULL,
  `Total_Harga` decimal(12,2) DEFAULT NULL,
  `Catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `ID_Produk` varchar(50) NOT NULL,
  `Nama_Produk` varchar(100) NOT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `stok` int(11) NOT NULL,
  `Harga_Dasar` decimal(12,2) NOT NULL,
  `Kategori` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `ID_User` varchar(50) NOT NULL,
  `Nama_User` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`ID_Log`),
  ADD KEY `ID_User` (`ID_User`);

--
-- Indexes for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD PRIMARY KEY (`ID_detail_Pesanan`),
  ADD KEY `ID_pesanan` (`ID_pesanan`),
  ADD KEY `ID_produk` (`ID_produk`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`ID_Pesanan`),
  ADD UNIQUE KEY `Kode_pesanan` (`Kode_pesanan`),
  ADD KEY `ID_User` (`ID_User`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`ID_Produk`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID_User`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `user` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD CONSTRAINT `detail_pesanan_ibfk_1` FOREIGN KEY (`ID_pesanan`) REFERENCES `pesanan` (`ID_Pesanan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detail_pesanan_ibfk_2` FOREIGN KEY (`ID_produk`) REFERENCES `produk` (`ID_Produk`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `user` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


-- ============================================================
-- REVISI LANJUTAN - BERDASARKAN SKPL / DPPL LILALUNA
-- ============================================================
-- Bagian di atas adalah dump struktur awal yang dipertahankan.
-- Perubahan berikut bersifat incremental agar hasil revisi
-- mudah dibandingkan dengan versi awal di GitHub.
-- Jalankan file ini hanya pada DATABASE KOSONG bernama lilaluna.
-- Jika tabel sudah ada, jangan impor dump awal dua kali.
-- Data contoh di bawah ini bersifat simulasi untuk tugas kelas.

USE `lilaluna`;

-- A. Melengkapi atribut USER untuk register/login dan peran.
-- Kolom password bawaan dipertahankan agar struktur awal dikenali.
-- Isi kolom dengan hash aplikasi (contoh SHA-256 hanya demo).
ALTER TABLE `user`
  ADD COLUMN `Username` VARCHAR(50) NULL AFTER `Nama_User`,
  ADD COLUMN `Peran` ENUM('OWNER','ADMIN','OPERATOR') NOT NULL DEFAULT 'OPERATOR' AFTER `password`,
  ADD COLUMN `Status_Aktif` TINYINT(1) NOT NULL DEFAULT 1 AFTER `Peran`,
  ADD UNIQUE KEY `uq_user_username` (`Username`);

-- B. Melengkapi PRODUK sesuai atribut tugas POS dan form DPPL.
-- Kolom Kategori tetap dipakai untuk jenis kaos.
ALTER TABLE `produk`
  ADD COLUMN `Ukuran` ENUM('S','M','L','XL','XXL') NOT NULL DEFAULT 'M' AFTER `Kategori`,
  ADD COLUMN `Satuan` VARCHAR(20) NOT NULL DEFAULT 'pcs' AFTER `Ukuran`,
  ADD COLUMN `StockMin` INT NOT NULL DEFAULT 0 AFTER `Satuan`,
  ADD CONSTRAINT `ck_produk_harga` CHECK (`Harga_Dasar` > 0),
  ADD CONSTRAINT `ck_produk_stok` CHECK (`stok` >= 0),
  ADD CONSTRAINT `ck_produk_stockmin` CHECK (`StockMin` >= 0);

-- C. Menambah entitas PELANGGAN berdasarkan objek DPPL (add order).
-- Nama_pelanggan di tabel pesanan tetap dipertahankan sebagai snapshot.
CREATE TABLE `pelanggan` (
  `ID_Pelanggan` VARCHAR(50) NOT NULL,
  `Nama_Pelanggan` VARCHAR(100) NOT NULL,
  `No_HP` VARCHAR(20) DEFAULT NULL,
  `Alamat` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`ID_Pelanggan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- D. Menguatkan relasi PESANAN terhadap pelanggan dan validasi.
ALTER TABLE `pesanan`
  ADD COLUMN `ID_Pelanggan` VARCHAR(50) NULL AFTER `ID_User`,
  ADD KEY `idx_pesanan_pelanggan` (`ID_Pelanggan`),
  ADD KEY `idx_pesanan_tanggal` (`Tanggal_pesanan`),
  ADD CONSTRAINT `fk_pesanan_pelanggan` FOREIGN KEY (`ID_Pelanggan`)
    REFERENCES `pelanggan` (`ID_Pelanggan`) ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT `ck_pesanan_total_item` CHECK (`Total_Item` >= 0),
  ADD CONSTRAINT `ck_pesanan_total_harga` CHECK (`Total_Harga` >= 0);

-- E. Detail pesanan: harga saat transaksi dan subtotal hasil hitung.
ALTER TABLE `detail_pesanan`
  ADD COLUMN `Harga_Satuan` DECIMAL(12,2) NOT NULL AFTER `Kuantitas`,
  ADD COLUMN `Subtotal` DECIMAL(14,2) AS
    (ROUND(`Kuantitas` * `Harga_Satuan` * (1 - `Diskon` / 100), 2)) STORED AFTER `Diskon`,
  ADD UNIQUE KEY `uq_detail_item` (`ID_pesanan`,`ID_produk`),
  ADD CONSTRAINT `ck_detail_kuantitas` CHECK (`Kuantitas` > 0),
  ADD CONSTRAINT `ck_detail_harga` CHECK (`Harga_Satuan` > 0),
  ADD CONSTRAINT `ck_detail_diskon` CHECK (`Diskon` BETWEEN 0 AND 100);

-- F. Audit log: stok tetap ada dari rancangan awal;
-- Aksi ditambah supaya aktivitas bisa difilter berdasarkan tipe.
ALTER TABLE `audit_log` DROP FOREIGN KEY `audit_log_ibfk_1`;
ALTER TABLE `audit_log`
  ADD COLUMN `Aksi` ENUM('LOGIN','LOGOUT','CREATE','UPDATE','DELETE','RESET','ERROR')
    NOT NULL DEFAULT 'CREATE' AFTER `ID_User`,
  MODIFY COLUMN `ID_User` VARCHAR(50) NULL,
  MODIFY COLUMN `waktu_aksi` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ADD KEY `idx_audit_aksi` (`Aksi`),
  ADD KEY `idx_audit_waktu` (`waktu_aksi`);

-- G. Mengoreksi kebijakan penghapusan: histori audit tidak ikut terhapus.
ALTER TABLE `audit_log`
  ADD CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`ID_User`)
  REFERENCES `user` (`ID_User`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `pesanan` DROP FOREIGN KEY `pesanan_ibfk_1`;
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`ID_User`)
  REFERENCES `user` (`ID_User`) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE `detail_pesanan` DROP FOREIGN KEY `detail_pesanan_ibfk_1`;
ALTER TABLE `detail_pesanan`
  ADD CONSTRAINT `detail_pesanan_ibfk_1` FOREIGN KEY (`ID_pesanan`)
  REFERENCES `pesanan` (`ID_Pesanan`) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE `detail_pesanan` DROP FOREIGN KEY `detail_pesanan_ibfk_2`;
ALTER TABLE `detail_pesanan`
  ADD CONSTRAINT `detail_pesanan_ibfk_2` FOREIGN KEY (`ID_produk`)
  REFERENCES `produk` (`ID_Produk`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- ============================================================
-- INSERT DATA SIMULASI - MINIMAL 5 DATA PER TABEL
-- ============================================================
INSERT INTO `user` (`ID_User`,`Nama_User`,`Username`,`Email`,`password`,`Peran`) VALUES
('USR001','Farhan Pemilik','farhan','farhan@example.test',SHA2('DemoFarhan#2026',256),'OWNER'),
('USR002','Rizqy Admin','rizqy','rizqy@example.test',SHA2('DemoRizqy#2026',256),'ADMIN'),
('USR003','Ali Operator','ali','ali@example.test',SHA2('DemoAli#2026',256),'OPERATOR'),
('USR004','Radithya Operator','radithya','radithya@example.test',SHA2('DemoRadithya#2026',256),'OPERATOR'),
('USR005','Nadia Operator','nadia','nadia@example.test',SHA2('DemoNadia#2026',256),'OPERATOR');
-- Password menggunakan SHA2 hanya untuk demo; sistem riil gunakan Argon2id/bcrypt.

INSERT INTO `pelanggan` (`ID_Pelanggan`,`Nama_Pelanggan`,`No_HP`,`Alamat`) VALUES
('PLG001','Dina Putri','081200000001','Bandung'),
('PLG002','Raka Saputra','081200000002','Cimahi'),
('PLG003','Salsa Maharani','081200000003','Soreang'),
('PLG004','Bagas Pratama','081200000004','Buahbatu'),
('PLG005','Tania Lestari','081200000005','Dayeuhkolot');

INSERT INTO `produk` (`ID_Produk`,`Nama_Produk`,`Status`,`deskripsi`,`stok`,`Harga_Dasar`,`Kategori`,`Ukuran`,`Satuan`,`StockMin`) VALUES
('PRD001','Kaos Normal S','AKTIF','Kaos sablon standar',80,65000,'Normal','S','pcs',10),
('PRD002','Kaos Normal M','AKTIF','Kaos sablon standar',75,70000,'Normal','M','pcs',10),
('PRD003','Kaos Smooth L','AKTIF','Kaos bahan smooth',60,85000,'Smooth','L','pcs',8),
('PRD004','Kaos Smooth XL','AKTIF','Kaos bahan smooth',50,90000,'Smooth','XL','pcs',8),
('PRD005','Kaos Hardest XXL','AKTIF','Kaos custom premium',30,110000,'Hardest','XXL','pcs',5);

INSERT INTO `pesanan`
(`ID_Pesanan`,`ID_User`,`ID_Pelanggan`,`Nama_pelanggan`,`Tanggal_pesanan`,`Kode_pesanan`,`Status`,`Total_Item`,`Total_Harga`,`Catatan`) VALUES
('PSN001','USR001','PLG001','Dina Putri','2026-10-20 09:15:00','LL-20261020-001','SELESAI',0,0,'Pesanan komunitas'),
('PSN002','USR002','PLG002','Raka Saputra','2026-10-21 10:30:00','LL-20261021-002','DIPROSES',0,0,'Sablon depan'),
('PSN003','USR003','PLG003','Salsa Maharani','2026-10-22 13:20:00','LL-20261022-003','BARU',0,0,'Desain menyusul'),
('PSN004','USR004','PLG004','Bagas Pratama','2026-10-23 15:10:00','LL-20261023-004','DIPROSES',0,0,'Ambil di tempat'),
('PSN005','USR005','PLG005','Tania Lestari','2026-10-24 11:40:00','LL-20261024-005','BARU',0,0,'Pesanan acara');

INSERT INTO `detail_pesanan`
(`ID_detail_Pesanan`,`ID_pesanan`,`ID_produk`,`Kuantitas`,`Harga_Satuan`,`Diskon`,`Keterangan`) VALUES
('DTL001','PSN001','PRD001',10,65000,0,'Sablon logo kecil'),
('DTL002','PSN001','PRD002',5,70000,10,'Sablon belakang'),
('DTL003','PSN002','PRD002',8,70000,0,'Warna hitam'),
('DTL004','PSN002','PRD003',4,85000,5,'Warna putih'),
('DTL005','PSN003','PRD003',6,85000,0,'Desain menyusul'),
('DTL006','PSN003','PRD004',3,90000,0,'Ukuran XL'),
('DTL007','PSN004','PRD001',7,65000,0,'Kaos panitia'),
('DTL008','PSN004','PRD005',2,110000,0,'Kaos koordinator'),
('DTL009','PSN005','PRD004',5,90000,0,'Warna navy'),
('DTL010','PSN005','PRD005',1,110000,0,'Custom nama');

-- Hitung ulang rekap dari detail (agar header tidak mengandung angka arbitrer).
UPDATE `pesanan` p SET
  `Total_Item` = (SELECT COALESCE(SUM(d.`Kuantitas`),0) FROM `detail_pesanan` d WHERE d.`ID_pesanan`=p.`ID_Pesanan`),
  `Total_Harga` = (SELECT COALESCE(SUM(d.`Subtotal`),0) FROM `detail_pesanan` d WHERE d.`ID_pesanan`=p.`ID_Pesanan`);

INSERT INTO `audit_log`
(`ID_Log`,`ID_User`,`Aksi`,`Tabel_Target`,`ID_Referensi`,`stok`,`Deskripsi`,`waktu_aksi`) VALUES
('LOG001','USR001','LOGIN','user','USR001',NULL,'Pengguna berhasil login','2026-10-20 09:00:00'),
('LOG002','USR001','CREATE','pesanan','PSN001',NULL,'Mencatat pesanan baru PSN001','2026-10-20 09:15:00'),
('LOG003','USR002','UPDATE','pesanan','PSN002',NULL,'Mengubah status pesanan PSN002','2026-10-21 11:00:00'),
('LOG004','USR003','CREATE','pesanan','PSN003',NULL,'Mencatat pesanan baru PSN003','2026-10-22 13:20:00'),
('LOG005','USR004','LOGOUT','user','USR004',NULL,'Pengguna keluar dari aplikasi','2026-10-23 17:00:00');

-- ============================================================
-- PENGEMBANGAN FUNGSIONAL SESUAI SKPL/DPPL
-- ============================================================
-- Procedure memperbarui ringkasan header setelah detail berubah.
DELIMITER $$
CREATE PROCEDURE sp_hitung_total_pesanan(IN p_id VARCHAR(50))
BEGIN
  UPDATE `pesanan` p SET
    `Total_Item`=(SELECT COALESCE(SUM(d.`Kuantitas`),0) FROM `detail_pesanan` d WHERE d.`ID_pesanan`=p_id),
    `Total_Harga`=(SELECT COALESCE(SUM(d.`Subtotal`),0) FROM `detail_pesanan` d WHERE d.`ID_pesanan`=p_id)
  WHERE p.`ID_Pesanan`=p_id;
END$$
DELIMITER ;

-- Trigger audit CREATE/UPDATE/DELETE pada pesanan (otomatis untuk aksi baru).
-- Audit demo yang sudah diinsert merupakan histori simulasi, bukan output trigger.
DELIMITER $$
CREATE TRIGGER trg_pesanan_ai AFTER INSERT ON `pesanan` FOR EACH ROW
BEGIN
  INSERT INTO `audit_log` (`ID_Log`,`ID_User`,`Aksi`,`Tabel_Target`,`ID_Referensi`,`Deskripsi`)
  VALUES (UUID(),COALESCE(@audit_user_id,NEW.`ID_User`),'CREATE','pesanan',NEW.`ID_Pesanan`,CONCAT('Membuat pesanan ',NEW.`Kode_pesanan`));
END$$
CREATE TRIGGER trg_pesanan_au AFTER UPDATE ON `pesanan` FOR EACH ROW
BEGIN
  INSERT INTO `audit_log` (`ID_Log`,`ID_User`,`Aksi`,`Tabel_Target`,`ID_Referensi`,`Deskripsi`)
  VALUES (UUID(),COALESCE(@audit_user_id,NEW.`ID_User`),'UPDATE','pesanan',NEW.`ID_Pesanan`,CONCAT('Memperbarui pesanan ',NEW.`Kode_pesanan`));
END$$
CREATE TRIGGER trg_pesanan_bd BEFORE DELETE ON `pesanan` FOR EACH ROW
BEGIN
  INSERT INTO `audit_log` (`ID_Log`,`ID_User`,`Aksi`,`Tabel_Target`,`ID_Referensi`,`Deskripsi`)
  VALUES (UUID(),COALESCE(@audit_user_id,OLD.`ID_User`),'DELETE','pesanan',OLD.`ID_Pesanan`,CONCAT('Menghapus pesanan ',OLD.`Kode_pesanan`));
END$$
DELIMITER ;

-- Rekap otomatis jika detail pesanan ditambah, diubah, atau dihapus.
DELIMITER $$
CREATE TRIGGER trg_detail_ai AFTER INSERT ON `detail_pesanan` FOR EACH ROW
BEGIN
  CALL sp_hitung_total_pesanan(NEW.`ID_pesanan`);
END$$
CREATE TRIGGER trg_detail_au AFTER UPDATE ON `detail_pesanan` FOR EACH ROW
BEGIN
  CALL sp_hitung_total_pesanan(OLD.`ID_pesanan`);
  IF NEW.`ID_pesanan` <> OLD.`ID_pesanan` THEN
    CALL sp_hitung_total_pesanan(NEW.`ID_pesanan`);
  END IF;
END$$
CREATE TRIGGER trg_detail_ad AFTER DELETE ON `detail_pesanan` FOR EACH ROW
BEGIN
  CALL sp_hitung_total_pesanan(OLD.`ID_pesanan`);
END$$
DELIMITER ;

-- View untuk fitur Rangkuman. Pendapatan = transaksi SELESAI.
CREATE VIEW `v_rangkuman_pesanan` AS
SELECT DATE(`Tanggal_pesanan`) AS `Tanggal`, COUNT(*) AS `Jumlah_Pesanan`,
       SUM(`Total_Item`) AS `Jumlah_Item`,
       SUM(CASE WHEN `Status`='SELESAI' THEN `Total_Harga` ELSE 0 END) AS `Pendapatan_Selesai`,
       SUM(CASE WHEN `Status`<>'DIBATALKAN' THEN `Total_Harga` ELSE 0 END) AS `Nilai_Pesanan_Aktif`
FROM `pesanan` GROUP BY DATE(`Tanggal_pesanan`);

-- Contoh SELECT untuk kebutuhan FR-004 s.d. FR-008.
-- Daftar pesanan (dengan pelanggan dan petugas pencatat).
SELECT p.`ID_Pesanan`,p.`Tanggal_pesanan`,p.`Nama_pelanggan`,u.`Nama_User`,
       p.`Status`,p.`Total_Item`,p.`Total_Harga`
FROM `pesanan` p JOIN `user` u ON u.`ID_User`=p.`ID_User`
ORDER BY p.`Tanggal_pesanan` DESC;

-- Pencarian berdasarkan nama / ID (partial match).
SELECT `ID_Pesanan`,`Nama_pelanggan`,`Total_Harga` FROM `pesanan`
WHERE `Nama_pelanggan` LIKE '%Dina%' OR `ID_Pesanan` LIKE '%001%';

-- Sort berdasarkan kuantitas dan rekap harian.
SELECT `ID_Pesanan`,`Total_Item`,`Total_Harga` FROM `pesanan` ORDER BY `Total_Item` DESC;
SELECT * FROM `v_rangkuman_pesanan` ORDER BY `Tanggal` DESC;

-- Riwayat log.
SELECT `waktu_aksi`,`Aksi`,`Tabel_Target`,`ID_Referensi`,`Deskripsi`
FROM `audit_log` ORDER BY `waktu_aksi` DESC;

-- Produk dengan stok minimum.
SELECT `ID_Produk`,`Nama_Produk`,`stok`,`StockMin` FROM `produk`
WHERE `stok`<=`StockMin` ORDER BY `stok`;

-- Bukti minimal 5 data di setiap tabel (5,5,5,5,10,5 = 35 data).
SELECT 'user' AS `Nama_Tabel`,COUNT(*) AS `Jumlah_Data` FROM `user`
UNION ALL SELECT 'pelanggan',COUNT(*) FROM `pelanggan`
UNION ALL SELECT 'produk',COUNT(*) FROM `produk`
UNION ALL SELECT 'pesanan',COUNT(*) FROM `pesanan`
UNION ALL SELECT 'detail_pesanan',COUNT(*) FROM `detail_pesanan`
UNION ALL SELECT 'audit_log',COUNT(*) FROM `audit_log`;
