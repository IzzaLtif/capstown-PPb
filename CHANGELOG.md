# CHANGELOG

## gate-1 — Fondasi

**Jadi**

- Alur utama berjalan dari layar ke layar: Katalog (cari + filter kategori) → Detail produk → Keranjang → Checkout (form tervalidasi) → Pesanan dibuat → Riwayat & detail pesanan.
- Navigasi: `NavigationBar` di layar sempit, `NavigationRail` di layar lebar (breakpoint 720 dp); badge jumlah item di tab Keranjang.
- Tata letak menyesuaikan lebar layar: grid katalog, halaman detail dua kolom saat lebar, konten dibatasi lebar maksimum di tablet/web.
- Data lokal sementara: 10 produk di `InMemoryProductRepository`; pesanan disimpan di `InMemoryOrderRepository`.
- Tampilan terpisah dari data: `screens` → `providers` → kontrak `data` (interface repository).
- Unit test keranjang dan smoke test aplikasi (`flutter test`).

**Macet**

- Data pesanan hilang saat aplikasi ditutup karena baru disimpan di memori. Belum ada penyimpanan lokal/REST; dikerjakan di G2.
- Belum ada foto produk; sementara memakai blok gradasi + ikon kategori.
- Status pesanan masih tetap "Diproses" karena belum ada server yang mengubahnya.
- <ISI: kendala nyata yang kamu temui saat menjalankan, mis. error build/layout beserta dugaan penyebabnya>

**Keputusan**

- Memakai interface repository (`ProductRepository`, `OrderRepository`) + `Provider`, dengan implementasi in-memory untuk G1.
  Alasan: rubrik Arsitektur G1 menuntut tampilan terpisah dari data, dan di G2 sumber data cukup diganti implementasinya tanpa mengubah layar.
  Alternatif yang ditolak: (1) `setState` langsung di tiap layar dengan list global, karena data tercampur dengan UI dan sulit diganti; (2) langsung memakai SQLite sekarang, karena melompati lingkup G1 dan menunda alur UI utuh.

**AI**

- Bagian yang dibantu AI: rancangan struktur folder, seluruh kode awal Flutter G1 (models, data in-memory, providers, layar, widget, test), dan draf README/CHANGELOG. Alat: Claude.
- Prompt kunci: <SALIN APA ADANYA prompt yang kamu pakai ke Claude>
- Yang saya ubah manual setelah menerima jawaban, dan kenapa: <ISI: mis. nama produk/harga agar sesuai bisnis nyata, perbaikan error saat dijalankan, dsb.>
