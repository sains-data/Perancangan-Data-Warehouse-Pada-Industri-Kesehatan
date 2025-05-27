-- 1. Total Penjualan Obat per Bulan
SELECT 
    DATE_FORMAT(tanggal_transaksi, '%Y-%m') AS bulan,
    SUM(total_harga) AS total_penjualan
FROM fakta_obat
GROUP BY DATE_FORMAT(tanggal_transaksi, '%Y-%m')
ORDER BY bulan;

-- 2. Rata-rata Transaksi Obat per Pasien
SELECT 
    f.id_pasien,
    p.nama_pasien,
    AVG(f.total_harga) AS rata_rata_transaksi
FROM fakta_obat f
JOIN dim_pasien p ON f.id_pasien = p.id_pasien
GROUP BY f.id_pasien, p.nama_pasien
ORDER BY rata_rata_transaksi DESC;

-- 3. Obat Terlaris Berdasarkan Total Penjualan
SELECT 
    o.nama_obat,
    SUM(f.jumlah) AS total_terjual
FROM fakta_obat f
JOIN dim_obat o ON f.kode_obat = o.kode_obat
GROUP BY o.nama_obat
ORDER BY total_terjual DESC
LIMIT 10;

-- 4. Tren Pertumbuhan Penjualan Obat dari Tahun ke Tahun
SELECT 
    YEAR(tanggal_transaksi) AS tahun,
    SUM(total_harga) AS total_penjualan
FROM fakta_obat
GROUP BY YEAR(tanggal_transaksi)
ORDER BY tahun;

-- 5. Jumlah Tindakan per Dokter
SELECT 
    d.nama_dokter,
    COUNT(t.id_tindakan) AS total_tindakan
FROM fakta_tindakan t
JOIN fakta_perawatan p ON t.id_perawatan = p.id_perawatan
JOIN dim_dokter d ON p.id_dokter = d.id_dokter
GROUP BY d.nama_dokter
ORDER BY total_tindakan DESC;

-- 6. Total Biaya Tindakan per Jenis Tindakan
SELECT 
    nama_tindakan,
    SUM(biaya) AS total_biaya
FROM fakta_tindakan
GROUP BY nama_tindakan
ORDER BY total_biaya DESC;

-- 7. Jumlah Pasien Berdasarkan Jenis Kelamin
SELECT 
    jenis_kelamin,
    COUNT(*) AS jumlah_pasien
FROM dim_pasien
GROUP BY jenis_kelamin;

-- 8. Ringkasan perawatan pasien
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

-- 9. Status pembayaran pasien
CREATE VIEW vw_status_pembayaran AS
SELECT 
    p.nama_pasien,
    f.id_perawatan,
    f.total_biaya,
    f.status_pembayaran
FROM fakta_perawatan f
JOIN dim_pasien p ON f.id_pasien = p.id_pasien;

-- 10. Statistik Tindakan per dokter
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

-- 11. Total biaya obat per pasien
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

-- 12. Total biaya yang harus dibayarkan pasien
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