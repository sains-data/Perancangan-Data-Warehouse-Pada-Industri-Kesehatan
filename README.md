

# Data Warehouse Industri Kesehatan - Kelompok 3


---
<img src="https://femboy.beauty/bn_P9f.gif" class="logo"/>

Selamat datang di repositori **Data Warehouse Industri Kesehatan**!
Repositori ini berisi seluruh dokumen, dataset, dan kode terkait perancangan serta implementasi data warehouse untuk mendukung analitik di sektor rumah sakit dan klinik.

---

## 📚 Daftar Isi

- [Deskripsi Proyek](#deskripsi-proyek)
- [Struktur Repositori](#struktur-repositori)
- [Penjelasan Tiap Folder \& Misi](#penjelasan-tiap-folder--misi)
- [Cara Eksplorasi](#cara-eksplorasi)
- [Roadmap](#roadmap)
- [Kontributor](#kontributor)
- [Lisensi](#lisensi)

---

## Deskripsi Proyek

Proyek ini bertujuan membangun solusi data warehouse terintegrasi untuk industri kesehatan, khususnya rumah sakit dan klinik. Dengan mengintegrasikan data dari berbagai sumber (rekam medis, billing, laboratorium, farmasi), sistem ini mendukung pengambilan keputusan strategis berbasis data, seperti prediksi lonjakan pasien, pengelolaan stok obat, dan analisis kinerja layanan medis.

---

## Struktur Repositori

```
.
├── dataset/
│   └── [Data pasien, dokter, perawatan, tindakan, tagihan, dan obat]
├── misi-1/
│   └── [Dokumentasi analisis awal & perancangan konseptual]
├── misi-2/
│   └── [Dokumentasi desain multidimensi & star schema]
├── misi-3/
│   └── [Dokumentasi desain logikal, fisikal, dan implementasi]
├── misi-4/
│   └── [Akan diisi pada tahap akhir]
├── src/
│   └── [Kode SQL, notebook, script implementasi]
└── README.md
```


---

## Penjelasan Tiap Folder \& Misi

- **dataset/**
Berisi data dummy yang digunakan dalam simulasi dan pengujian data warehouse.
*Contoh: pasien.csv, dokter.csv, obat.csv, dsb.*
- **misi-1/**
Analisis kebutuhan, identifikasi masalah bisnis, dan perancangan awal (ERD, daftar entitas, atribut, serta kebutuhan integrasi data).
- **misi-2/**
Desain skema multidimensi (star schema), penjelasan tabel fakta dan dimensi, serta justifikasi desain untuk kebutuhan analitik.
- **misi-3/**
Implementasi desain logikal dan fisikal seperti pembuatan tabel fakta \& dimensi, penentuan indeks, partisi, dan strategi penyimpanan, serta contoh query analitik
- **misi-4/**
*Coming Soon!*
Akan diisi pada tahap akhir pengembangan.
- **src/**
Kumpulan kode SQL, notebook, maupun script Python/R untuk proses ETL, pembuatan tabel, dan analisis data warehouse.

---

## Cara Eksplorasi

1. **Mulai dari [misi-1/](./misi-1/)**
Baca analisis kebutuhan dan perancangan awal untuk memahami konteks bisnis dan data yang digunakan.
2. **Lanjut ke [misi-2/](./misi-2/)**
Pelajari skema multidimensi dan struktur star schema yang menjadi fondasi data warehouse.
3. **Telusuri [misi-3/](./misi-3/)**
Temukan detail implementasi teknis, termasuk desain logikal, fisikal, serta contoh query analitik.
4. **Jelajahi [dataset/](./dataset/)**
Lihat contoh data yang digunakan untuk simulasi.
5. **Eksperimen dengan [src/](./src/)**
Jalankan kode untuk memahami proses ETL, pembuatan tabel, dan analisis data warehouse.

---

## Roadmap

| Tahap | Status | Keterangan |
| :-- | :-- | :-- |
| Misi 1 | ✅ Selesai | Analisis kebutuhan \& perancangan konseptual |
| Misi 2 | ✅ Selesai | Desain multidimensi \& star schema |
| Misi 3 | ✅ Selesai | Implementasi logikal, fisikal, query analitik |
| Misi 4 | ⏳ Dalam Proses | Implementasi, Reporting, dan Produksi |


---

## Kontributor

Kelompok 3 - Sains Data, Institut Teknologi Sumatera

- Taufiqurrahmansyah E (120450051)
- Marshanda Putri P (121450020)
- Putri Durrotul Shopia (121450116)
- Khoirul Mizan Abdullah (122450010)
- Mutiara Dian Pitaloka (122450047)
- Uliano Wilyam Purba (122450098)

---

## Lisensi

Proyek ini menggunakan lisensi MIT. Silakan lihat file `LICENSE` untuk detail lebih lanjut.

---

> *Repositori ini akan terus diperbarui seiring progres pengerjaan tiap misi. Jangan ragu untuk mengeksplorasi tiap folder dan file untuk memahami keseluruhan proses perancangan data warehouse industri kesehatan!*

---

*Terima kasih telah mengunjungi repositori ini. Saran dan masukan sangat kami apresiasi!*

---