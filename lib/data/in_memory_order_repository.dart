import '../models/order.dart';
import 'order_repository.dart';

/// Data sementara di memori: hilang saat aplikasi ditutup (diselesaikan di G2).
class InMemoryOrderRepository implements OrderRepository {
  final List<Order> _orders = [];

  @override
  List<Order> getAll() => List.unmodifiable(_orders.reversed);

  @override
  Order? getById(String id) {
    for (final o in _orders) {
      if (o.id == id) return o;
    }
    return null;
  }

  @override
  void add(Order order) => _orders.add(order);
}
