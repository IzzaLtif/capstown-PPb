# ☕ Coffee Supply Platform

Aplikasi pemesanan kopi B2B: kafe, roastery, dan toko memesan green bean, roasted bean, dan kopi bubuk langsung dari supplier.

> Capstone Project Pemrograman Perangkat Bergerak · Domain **Local Business Solutions** · Status: **Gate 1 (Fondasi)**

## Fitur (G1)

- **Katalog** dengan pencarian nama/asal kopi dan filter kategori (Green Bean, Roasted Bean, Kopi Bubuk)
- **Detail produk**: harga per kg, minimal order, stok, catatan rasa, pengatur jumlah
- **Keranjang** dengan ubah jumlah, hapus item, dan total otomatis
- **Checkout** dengan form tervalidasi dan pilihan metode pembayaran
- **Riwayat pesanan** dan detail pesanan
- **Responsif**: tampilan menyesuaikan HP portrait, HP landscape, dan tablet/web

Alur utama: `Katalog → Detail → Keranjang → Checkout → Pesanan dibuat → Riwayat`

## Teknologi

| Bagian           | Pilihan               |
| ---------------- | --------------------- |
| Framework        | Flutter (Material 3)  |
| State management | Provider              |
| Data (G1)        | In-memory (sementara) |

## Menjalankan

Prasyarat: Flutter SDK dan Git.

```bash
git clone https://github.com/IzzaLtif/capstown-PPb.git
cd capstown-PPb
flutter pub get
flutter run            # atau: flutter run -d chrome
```

Perintah lain:

```bash
flutter analyze
flutter test
```

Jika folder `android/` atau `web/` belum ada:

```bash
flutter create . --project-name coffee_supply_platform --platforms=android,web
```

## Struktur Proyek

```
lib/
├── models/      Product, CartItem, Order (data murni, tanpa UI)
├── data/        kontrak repository + implementasi data lokal sementara
├── providers/   state (ChangeNotifier) penghubung data dan UI
├── screens/     layar penuh
├── widgets/     komponen UI yang dipakai ulang
└── utils/       format rupiah dan tanggal
test/            unit test keranjang dan smoke test aplikasi
```

## Arsitektur

Layar hanya berbicara dengan `providers/`, dan `providers/` hanya berbicara dengan kontrak di `data/` (`ProductRepository`, `OrderRepository`). Karena itu sumber data bisa diganti di G2 (REST API dan penyimpanan lokal) tanpa mengubah `screens/`.

## Responsif

- Lebar < 720 dp: `NavigationBar` di bawah
- Lebar ≥ 720 dp: `NavigationRail` di samping
- Grid katalog menyesuaikan jumlah kolom dengan lebar layar
- Halaman detail berubah menjadi dua kolom pada layar lebar

## Roadmap

| Gate | Fokus                                              | Status |
| ---- | -------------------------------------------------- | ------ |
| G1   | UI utuh, navigasi, data lokal sementara, responsif | ✅     |
| G2   | REST API, penyimpanan lokal, mode offline          | ⏳     |
| G3   | State terpusat, test, dua fitur perangkat          | ⏳     |
| G4   | Profiling, signed build, dokumentasi               | ⏳     |

## Catatan Pengembangan

Riwayat tiap gate, kendala, keputusan teknis, dan deklarasi pemakaian AI ada di [CHANGELOG.md](CHANGELOG.md).
