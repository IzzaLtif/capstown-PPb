import 'package:flutter/foundation.dart';

import '../data/product_repository.dart';
import '../models/product.dart';

class CatalogProvider extends ChangeNotifier {
  CatalogProvider(this._repository);

  final ProductRepository _repository;

  String _query = '';
  ProductCategory? _category;

  String get query => _query;
  ProductCategory? get category => _category;

  /// Produk setelah difilter kategori dan kata kunci pencarian.
  List<Product> get products {
    final q = _query.trim().toLowerCase();
    return _repository.getAll().where((p) {
      final matchCategory = _category == null || p.category == _category;
      final matchQuery = q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.origin.toLowerCase().contains(q);
      return matchCategory && matchQuery;
    }).toList();
  }

  Product? byId(String id) => _repository.getById(id);

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setCategory(ProductCategory? value) {
    _category = value;
    notifyListeners();
  }
}
