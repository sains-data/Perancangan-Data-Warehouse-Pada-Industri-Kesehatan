-- Indexing pada fakta_perawatan
CREATE INDEX idx_perawatan_pasien ON fakta_perawatan(id_pasien);
CREATE INDEX idx_perawatan_dokter ON fakta_perawatan(id_dokter);

-- Indexing pada fakta_obat
CREATE INDEX idx_obat_pasien ON fakta_obat(id_pasien);
CREATE INDEX idx_obat_kode ON fakta_obat(kode_obat);

-- Indexing pada fakta_tindakan
CREATE INDEX idx_tindakan_perawatan ON fakta_tindakan(id_perawatan);
CREATE INDEX idx_tindakan_nama ON fakta_tindakan(nama_tindakan);