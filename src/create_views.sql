-- Ringkasan perawatan pasien
CREATE VIEW vw_ringkasan_perawatan_pasien AS
SELECT 
    f.id_perawatan,
    p.nama_pasien,
    d.nama_dokter,
    f.tanggal_perawatan,
    f.jenis_perawatan,
    f.total_biaya,
    f.status_pembayaran
FROM fakta_perawatan f
JOIN dim_pasien p ON f.id_pasien = p.id_pasien
JOIN dim_dokter d ON f.id_dokter = d.id_dokter;

-- Status pembayaran pasien
CREATE VIEW vw_status_pembayaran AS
SELECT 
    p.nama_pasien,
    f.id_perawatan,
    f.total_biaya,
    f.status_pembayaran
FROM fakta_perawatan f
JOIN dim_pasien p ON f.id_pasien = p.id_pasien;

-- Statistik Tindakan per dokter
CREATE VIEW vw_tindakan_per_dokter AS
SELECT 
    d.nama_dokter,
    t.nama_tindakan,
    COUNT(t.id_tindakan) AS jumlah_tindakan,
    SUM(t.biaya) AS total_biaya_tindakan
FROM fakta_tindakan t
JOIN fakta_perawatan f ON t.id_perawatan = f.id_perawatan
JOIN dim_dokter d ON f.id_dokter = d.id_dokter
GROUP BY d.nama_dokter, t.nama_tindakan;

-- Total biaya obat per pasien
CREATE VIEW vw_total_obat_pasien AS
SELECT 
    p.nama_pasien,
    o.kode_obat,
    do.nama_obat,
    SUM(o.jumlah) AS total_jumlah,
    SUM(o.total_harga) AS total_pengeluaran
FROM fakta_obat o
JOIN dim_pasien p ON o.id_pasien = p.id_pasien
JOIN dim_obat do ON o.kode_obat = do.kode_obat
GROUP BY p.nama_pasien, o.kode_obat, do.nama_obat;

-- Total biaya yang harus dibayarkan pasien
CREATE VIEW vw_total_biaya_pasien AS
SELECT 
    p.nama_pasien,
    COALESCE(SUM(fp.total_biaya), 0) AS biaya_perawatan,
    COALESCE(SUM(fo.total_harga), 0) AS biaya_obat,
    COALESCE(SUM(fp.total_biaya), 0) + COALESCE(SUM(fo.total_harga), 0) AS total_biaya
FROM dim_pasien p
LEFT JOIN fakta_perawatan fp ON p.id_pasien = fp.id_pasien
LEFT JOIN fakta_obat fo ON p.id_pasien = fo.id_pasien
GROUP BY p.nama_pasien;
