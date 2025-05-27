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