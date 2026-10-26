import 'cart_item.dart';

enum OrderStatus {
  processing('Diproses'),
  shipped('Dikirim'),
  completed('Selesai');

  const OrderStatus(this.label);
  final String label;
}

class Order {
  const Order({
    required this.id,
    required this.items,
    required this.buyerName,
    required this.businessName,
    required this.phone,
    required this.address,
    required this.note,
    required this.paymentMethod,
    required this.createdAt,
    this.status = OrderStatus.processing,
  });

  final String id;
  final List<CartItem> items;
  final String buyerName;
  final String businessName;
  final String phone;
  final String address;
  final String note;
  final String paymentMethod;
  final DateTime createdAt;
  final OrderStatus status;

  int get total => items.fold(0, (sum, i) => sum + i.subtotal);
  int get totalKg => items.fold(0, (sum, i) => sum + i.qtyKg);
}
