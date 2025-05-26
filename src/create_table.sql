-- Dimensi Pasien
CREATE TABLE dim_pasien (
    id_pasien INT PRIMARY KEY,
    nama_pasien VARCHAR(100),
    alamat TEXT,
    tanggal_lahir DATE,
    jenis_kelamin VARCHAR(10),
    nomor_telepon VARCHAR(20)
);

-- Dimensi Dokter
CREATE TABLE dim_dokter (
    id_dokter INT PRIMARY KEY,
    nama_dokter VARCHAR(100),
    spesialisasi VARCHAR(100),
    nomor_telepon VARCHAR(20)
);

-- Dimensi Obat
CREATE TABLE dim_obat (
    kode_obat VARCHAR(50) PRIMARY KEY,
    nama_obat VARCHAR(100),
    harga_per_satuan DECIMAL(10,2)
);

-- Dimensi Tindakan
CREATE TABLE dim_tindakan (
    nama_tindakan VARCHAR(100) PRIMARY KEY,
    biaya DECIMAL(10,2)
);

-- Fakta Perawatan
CREATE TABLE fakta_perawatan (
    id_perawatan INT PRIMARY KEY,
    id_pasien INT,
    id_dokter INT,
    tanggal_perawatan DATE,
    jenis_perawatan VARCHAR(100),
    total_biaya DECIMAL(12,2),
    status_pembayaran VARCHAR(20),
    FOREIGN KEY (id_pasien) REFERENCES dim_pasien(id_pasien),
    FOREIGN KEY (id_dokter) REFERENCES dim_dokter(id_dokter)
);

-- Fakta Obat
CREATE TABLE fakta_obat (
    id_obat_transaksi INT PRIMARY KEY,
    id_pasien INT,
    kode_obat VARCHAR(50),
    jumlah INT,
    total_harga DECIMAL(12,2),
    tanggal_transaksi DATE,
    FOREIGN KEY (id_pasien) REFERENCES dim_pasien(id_pasien),
    FOREIGN KEY (kode_obat) REFERENCES dim_obat(kode_obat)
);

-- Fakta Tindakan
CREATE TABLE fakta_tindakan (
    id_tindakan INT PRIMARY KEY,
    id_perawatan INT,
    nama_tindakan VARCHAR(100),
    biaya DECIMAL(10,2),
    FOREIGN KEY (id_perawatan) REFERENCES fakta_perawatan(id_perawatan),
    FOREIGN KEY (nama_tindakan) REFERENCES dim_tindakan(nama_tindakan)
);