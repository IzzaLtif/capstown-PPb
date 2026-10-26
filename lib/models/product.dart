enum ProductCategory {
  greenBean('Green Bean'),
  roasted('Roasted Bean'),
  ground('Kopi Bubuk');

  const ProductCategory(this.label);
  final String label;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.origin,
    required this.category,
    required this.pricePerKg,
    required this.minOrderKg,
    required this.stockKg,
    required this.flavorNotes,
    required this.description,
  });

  final String id;
  final String name;
  final String origin;
  final ProductCategory category;
  final int pricePerKg;
  final int minOrderKg;
  final int stockKg;
  final List<String> flavorNotes;
  final String description;
}
