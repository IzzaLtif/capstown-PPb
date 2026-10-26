import '../models/order.dart';

/// Kontrak penyimpanan pesanan.
abstract class OrderRepository {
  /// Pesanan terbaru berada di urutan pertama.
  List<Order> getAll();
  Order? getById(String id);
  void add(Order order);
}
