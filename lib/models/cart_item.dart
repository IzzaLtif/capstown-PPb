import 'product.dart';

class CartItem {
  const CartItem({required this.product, required this.qtyKg});

  final Product product;
  final int qtyKg;

  int get subtotal => product.pricePerKg * qtyKg;

  CartItem copyWith({int? qtyKg}) =>
      CartItem(product: product, qtyKg: qtyKg ?? this.qtyKg);
}
