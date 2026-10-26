import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => List.unmodifiable(_items.values);
  bool get isEmpty => _items.isEmpty;

  /// Jumlah jenis produk di keranjang.
  int get itemCount => _items.length;

  int get totalKg => _items.values.fold(0, (sum, i) => sum + i.qtyKg);
  int get total => _items.values.fold(0, (sum, i) => sum + i.subtotal);

  /// Menambah produk. Jumlah akhir selalu di antara minimal order dan stok.
  void add(Product product, int qtyKg) {
    final existing = _items[product.id]?.qtyKg ?? 0;
    final next = (existing + qtyKg)
        .clamp(product.minOrderKg, product.stockKg)
        .toInt();
    _items[product.id] = CartItem(product: product, qtyKg: next);
    notifyListeners();
  }

  void setQty(String productId, int qtyKg) {
    final item = _items[productId];
    if (item == null) return;
    final next = qtyKg
        .clamp(item.product.minOrderKg, item.product.stockKg)
        .toInt();
    _items[productId] = item.copyWith(qtyKg: next);
    notifyListeners();
  }

  void remove(String productId) {
    if (_items.remove(productId) != null) notifyListeners();
  }

  void clear() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }
}
