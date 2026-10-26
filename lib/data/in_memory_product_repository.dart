import '../models/product.dart';
import 'product_repository.dart';

/// Data katalog sementara (hardcoded). Diganti sumber data nyata di G2.
class InMemoryProductRepository implements ProductRepository {
  static const List<Product> _items = [
    Product(
      id: 'p01',
      name: 'Arabika Gayo',
      origin: 'Aceh Tengah, Aceh',
      category: ProductCategory.greenBean,
      pricePerKg: 135000,
      minOrderKg: 20,
      stockKg: 400,
      flavorNotes: ['Cokelat', 'Rempah', 'Body tebal'],
      description:
          'Green bean arabika dari dataran tinggi Gayo. Cocok untuk roastery yang '
          'mencari karakter body tebal dengan acidity lembut untuk single origin '
          'maupun bahan blend.',
    ),
    Product(
      id: 'p02',
      name: 'Arabika Kintamani',
      origin: 'Bangli, Bali',
      category: ProductCategory.greenBean,
      pricePerKg: 145000,
      minOrderKg: 20,
      stockKg: 300,
      flavorNotes: ['Citrus', 'Floral', 'Manis'],
      description:
          'Green bean arabika dengan profil cerah dan bersih. Cocok untuk '
          'seduhan manual dan roast light-medium.',
    ),
    Product(
      id: 'p03',
      name: 'Arabika Toraja',
      origin: 'Tana Toraja, Sulawesi Selatan',
      category: ProductCategory.greenBean,
      pricePerKg: 150000,
      minOrderKg: 20,
      stockKg: 250,
      flavorNotes: ['Herbal', 'Cokelat gelap', 'Earthy'],
      description:
          'Green bean arabika dengan karakter earthy yang khas dan aftertaste '
          'panjang. Cocok untuk medium-dark roast.',
    ),
    Product(
      id: 'p04',
      name: 'Robusta Temanggung',
      origin: 'Temanggung, Jawa Tengah',
      category: ProductCategory.greenBean,
      pricePerKg: 75000,
      minOrderKg: 25,
      stockKg: 600,
      flavorNotes: ['Nutty', 'Pahit', 'Crema tebal'],
      description:
          'Green bean robusta untuk campuran espresso dan kopi susu. '
          'Menghasilkan crema tebal dengan rasa pahit yang tegas.',
    ),
    Product(
      id: 'p05',
      name: 'Robusta Lampung',
      origin: 'Lampung',
      category: ProductCategory.greenBean,
      pricePerKg: 70000,
      minOrderKg: 25,
      stockKg: 800,
      flavorNotes: ['Cokelat', 'Kacang', 'Kuat'],
      description:
          'Green bean robusta harga terjangkau untuk kebutuhan volume besar '
          'seperti kedai kopi dan produksi kopi sachet.',
    ),
    Product(
      id: 'p06',
      name: 'Arabika Bajawa Flores',
      origin: 'Bajawa, Nusa Tenggara Timur',
      category: ProductCategory.roasted,
      pricePerKg: 195000,
      minOrderKg: 10,
      stockKg: 150,
      flavorNotes: ['Karamel', 'Buah', 'Seimbang'],
      description:
          'Biji sangrai medium siap pakai dengan rasa seimbang dan manis. '
          'Cocok untuk kafe yang tidak punya mesin roasting.',
    ),
    Product(
      id: 'p07',
      name: 'Arabika Java Preanger',
      origin: 'Jawa Barat',
      category: ProductCategory.roasted,
      pricePerKg: 180000,
      minOrderKg: 10,
      stockKg: 200,
      flavorNotes: ['Kacang', 'Cokelat susu', 'Lembut'],
      description:
          'Biji sangrai medium dengan body lembut dan pahit rendah, '
          'ramah untuk pelanggan umum.',
    ),
    Product(
      id: 'p08',
      name: 'House Blend Espresso',
      origin: 'Blend Arabika & Robusta',
      category: ProductCategory.roasted,
      pricePerKg: 120000,
      minOrderKg: 10,
      stockKg: 350,
      flavorNotes: ['Cokelat', 'Crema tebal', 'Konsisten'],
      description:
          'Campuran arabika dan robusta sangrai medium-dark untuk base '
          'espresso, latte, dan kopi susu.',
    ),
    Product(
      id: 'p09',
      name: 'Arabika Gayo Bubuk',
      origin: 'Aceh Tengah, Aceh',
      category: ProductCategory.ground,
      pricePerKg: 165000,
      minOrderKg: 5,
      stockKg: 120,
      flavorNotes: ['Rempah', 'Cokelat', 'Gilingan filter'],
      description:
          'Kopi bubuk arabika gilingan sedang untuk seduhan filter dan '
          'V60. Siap seduh tanpa grinder.',
    ),
    Product(
      id: 'p10',
      name: 'Robusta Tubruk Temanggung',
      origin: 'Temanggung, Jawa Tengah',
      category: ProductCategory.ground,
      pricePerKg: 95000,
      minOrderKg: 5,
      stockKg: 200,
      flavorNotes: ['Pahit', 'Kuat', 'Tubruk'],
      description:
          'Kopi bubuk robusta gilingan halus untuk seduhan tubruk '
          'tradisional, cocok untuk warung dan angkringan.',
    ),
  ];

  @override
  List<Product> getAll() => _items;

  @override
  Product? getById(String id) {
    for (final p in _items) {
      if (p.id == id) return p;
    }
    return null;
  }
}
