import '../models/product.dart';

/// Kontrak sumber data produk. Di G1 diisi data lokal sementara;
/// di G2 cukup diganti implementasinya (REST API) tanpa menyentuh UI.
abstract class ProductRepository {
  List<Product> getAll();
  Product? getById(String id);
}
