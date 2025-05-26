-- Contoh staging table dari data sumber
CREATE TABLE staging_pasien (
    id_pasien INT,
    nama_pasien VARCHAR(100),
    alamat TEXT,
    tanggal_lahir VARCHAR(20), -- Masih format string dari CSV
    jenis_kelamin VARCHAR(10),
    nomor_telepon VARCHAR(20)
);

CREATE TABLE staging_dokter (
    id_dokter INT,
    nama_dokter VARCHAR(100),
    spesialisasi VARCHAR(100),
    nomor_telepon VARCHAR(20)
);

CREATE TABLE staging_obat (
    kode_obat VARCHAR(50),
    nama_obat VARCHAR(100),
    harga_per_satuan VARCHAR(20) -- harga mungkin string harus konversi ke decimal
);

CREATE TABLE staging_tindakan (
    nama_tindakan VARCHAR(100),
    biaya VARCHAR(20) -- string, harus konversi ke decimal
);

CREATE TABLE staging_perawatan (
    id_perawatan INT,
    id_pasien INT,
    id_dokter INT,
    tanggal_perawatan VARCHAR(20),
    jenis_perawatan VARCHAR(100),
    total_biaya VARCHAR(20),
    status_pembayaran VARCHAR(20)
);

CREATE TABLE staging_obat_transaksi (
    id_obat_transaksi INT,
    id_pasien INT,
    kode_obat VARCHAR(50),
    jumlah INT,
    total_harga VARCHAR(20),
    tanggal_transaksi VARCHAR(20)
);

CREATE TABLE staging_tindakan (
    id_tindakan INT,
    id_perawatan INT,
    nama_tindakan VARCHAR(100),
    biaya VARCHAR(20)
);

INSERT INTO dim_pasien (id_pasien, nama_pasien, alamat, tanggal_lahir, jenis_kelamin, nomor_telepon)
SELECT
    id_pasien,
    nama_pasien,
    alamat,
    TRY_CAST(tanggal_lahir AS DATE),
    LOWER(jenis_kelamin),
    nomor_telepon
FROM staging_pasien
WHERE id_pasien NOT IN (SELECT id_pasien FROM dim_pasien);

INSERT INTO dim_dokter (id_dokter, nama_dokter, spesialisasi, nomor_telepon)
SELECT
    id_dokter,
    nama_dokter,
    spesialisasi,
    nomor_telepon
FROM staging_dokter
WHERE id_dokter NOT IN (SELECT id_dokter FROM dim_dokter);

INSERT INTO dim_obat (kode_obat, nama_obat, harga_per_satuan)
SELECT
    kode_obat,
    nama_obat,
    CAST(harga_per_satuan AS DECIMAL(10,2))
FROM staging_obat
WHERE kode_obat NOT IN (SELECT kode_obat FROM dim_obat);

INSERT INTO dim_tindakan (nama_tindakan, biaya)
SELECT
    nama_tindakan,
    CAST(biaya AS DECIMAL(10,2))
FROM staging_tindakan
WHERE nama_tindakan NOT IN (SELECT nama_tindakan FROM dim_tindakan);

INSERT INTO fakta_perawatan (id_perawatan, id_pasien, id_dokter, tanggal_perawatan, jenis_perawatan, total_biaya, status_pembayaran)
SELECT
    id_perawatan,
    id_pasien,
    id_dokter,
    TRY_CAST(tanggal_perawatan AS DATE),
    jenis_perawatan,
    CAST(total_biaya AS DECIMAL(12,2)),
    status_pembayaran
FROM staging_perawatan
WHERE id_perawatan NOT IN (SELECT id_perawatan FROM fakta_perawatan);

INSERT INTO fakta_obat (id_obat_transaksi, id_pasien, kode_obat, jumlah, total_harga, tanggal_transaksi)
SELECT
    id_obat_transaksi,
    id_pasien,
    kode_obat,
    jumlah,
    CAST(total_harga AS DECIMAL(12,2)),
    TRY_CAST(tanggal_transaksi AS DATE)
FROM staging_obat_transaksi
WHERE id_obat_transaksi NOT IN (SELECT id_obat_transaksi FROM fakta_obat);

INSERT INTO fakta_tindakan (id_tindakan, id_perawatan, nama_tindakan, biaya)
SELECT
    id_tindakan,
    id_perawatan,
    nama_tindakan,
    CAST(biaya AS DECIMAL(10,2))
FROM staging_tindakan
WHERE id_tindakan NOT IN (SELECT id_tindakan FROM fakta_tindakan);
