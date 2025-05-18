-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2025 at 06:38 PM
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
-- Database: `klinik_kesehatan`
--

-- --------------------------------------------------------

--
-- Table structure for table `dim_dokter`
--

CREATE TABLE `dim_dokter` (
  `id_dokter` int(11) NOT NULL,
  `nama_dokter` varchar(100) NOT NULL,
  `spesialisasi` varchar(50) DEFAULT NULL,
  `sub_spesialisasi` varchar(50) DEFAULT NULL,
  `nomor_telepon` varchar(15) DEFAULT NULL,
  `unit_kerja` varchar(50) DEFAULT NULL,
  `row_effective_date` date DEFAULT NULL,
  `row_expiration_date` date DEFAULT NULL,
  `current_flag` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dim_jenis_perawatan`
--

CREATE TABLE `dim_jenis_perawatan` (
  `id_jenis` int(11) NOT NULL,
  `jenis_perawatan` varchar(50) NOT NULL,
  `deskripsi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dim_obat`
--

CREATE TABLE `dim_obat` (
  `id_obat` varchar(10) NOT NULL,
  `nama_obat` varchar(100) NOT NULL,
  `kategori_obat` varchar(50) DEFAULT NULL,
  `sub_kategori_obat` varchar(50) DEFAULT NULL,
  `satuan` varchar(20) DEFAULT NULL,
  `harga_per_satuan` decimal(10,2) DEFAULT NULL,
  `dosis_standar` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dim_pasien`
--

CREATE TABLE `dim_pasien` (
  `id_pasien` int(11) NOT NULL,
  `nama_pasien` varchar(100) NOT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `kota` varchar(50) DEFAULT NULL,
  `provinsi` varchar(50) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` char(1) DEFAULT NULL,
  `nomor_telepon` varchar(15) DEFAULT NULL,
  `row_effective_date` date DEFAULT NULL,
  `row_expiration_date` date DEFAULT NULL,
  `current_flag` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dim_tindakan`
--

CREATE TABLE `dim_tindakan` (
  `id_tindakan` int(11) NOT NULL,
  `nama_tindakan` varchar(100) NOT NULL,
  `kategori_tindakan` varchar(50) DEFAULT NULL,
  `sub_kategori_tindakan` varchar(50) DEFAULT NULL,
  `deskripsi_tindakan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dim_waktu`
--

CREATE TABLE `dim_waktu` (
  `id_waktu` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `hari` varchar(10) DEFAULT NULL,
  `bulan` varchar(10) DEFAULT NULL,
  `nama_bulan` varchar(20) DEFAULT NULL,
  `kuartal` int(11) DEFAULT NULL,
  `tahun` int(11) DEFAULT NULL,
  `hari_dalam_minggu` int(11) DEFAULT NULL,
  `minggu_dalam_tahun` int(11) DEFAULT NULL,
  `hari_libur` tinyint(1) DEFAULT NULL,
  `weekend` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fact_obat`
--

CREATE TABLE `fact_obat` (
  `id_obat_transaksi` int(11) NOT NULL,
  `fk_pasien` int(11) DEFAULT NULL,
  `fk_obat` varchar(10) DEFAULT NULL,
  `fk_perawatan` int(11) DEFAULT NULL,
  `fk_waktu` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL,
  `status_tersedia` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fact_perawatan`
--

CREATE TABLE `fact_perawatan` (
  `id_perawatan` int(11) NOT NULL,
  `fk_pasien` int(11) DEFAULT NULL,
  `fk_dokter` int(11) DEFAULT NULL,
  `fk_jenis_perawatan` int(11) DEFAULT NULL,
  `fk_waktu` int(11) DEFAULT NULL,
  `total_biaya` decimal(12,2) DEFAULT NULL,
  `jumlah_tindakan` int(11) DEFAULT NULL,
  `status_pembayaran` varchar(20) DEFAULT NULL,
  `durasi_perawatan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fact_tindakan`
--

CREATE TABLE `fact_tindakan` (
  `id_record` int(11) NOT NULL,
  `id_tindakan` int(11) DEFAULT NULL,
  `fk_perawatan` int(11) DEFAULT NULL,
  `fk_tipe` int(11) DEFAULT NULL,
  `fk_waktu` int(11) DEFAULT NULL,
  `biaya` decimal(10,2) DEFAULT NULL,
  `durasi` int(11) DEFAULT NULL,
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dim_dokter`
--
ALTER TABLE `dim_dokter`
  ADD PRIMARY KEY (`id_dokter`);

--
-- Indexes for table `dim_jenis_perawatan`
--
ALTER TABLE `dim_jenis_perawatan`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `dim_obat`
--
ALTER TABLE `dim_obat`
  ADD PRIMARY KEY (`id_obat`);

--
-- Indexes for table `dim_pasien`
--
ALTER TABLE `dim_pasien`
  ADD PRIMARY KEY (`id_pasien`);

--
-- Indexes for table `dim_tindakan`
--
ALTER TABLE `dim_tindakan`
  ADD PRIMARY KEY (`id_tindakan`);

--
-- Indexes for table `dim_waktu`
--
ALTER TABLE `dim_waktu`
  ADD PRIMARY KEY (`id_waktu`);

--
-- Indexes for table `fact_obat`
--
ALTER TABLE `fact_obat`
  ADD PRIMARY KEY (`id_obat_transaksi`);

--
-- Indexes for table `fact_perawatan`
--
ALTER TABLE `fact_perawatan`
  ADD PRIMARY KEY (`id_perawatan`);

--
-- Indexes for table `fact_tindakan`
--
ALTER TABLE `fact_tindakan`
  ADD PRIMARY KEY (`id_record`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
