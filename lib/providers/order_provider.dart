import 'package:flutter/foundation.dart';

import '../data/order_repository.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  OrderProvider(this._repository);

  final OrderRepository _repository;

  List<Order> get orders => _repository.getAll();

  Order? byId(String id) => _repository.getById(id);

  Order placeOrder({
    required List<CartItem> items,
    required String buyerName,
    required String businessName,
    required String phone,
    required String address,
    required String note,
    required String paymentMethod,
  }) {
    final number = _repository.getAll().length + 1;
    final order = Order(
      id: 'PO-${number.toString().padLeft(4, '0')}',
      items: List.unmodifiable(items),
      buyerName: buyerName,
      businessName: businessName,
      phone: phone,
      address: address,
      note: note,
      paymentMethod: paymentMethod,
      createdAt: DateTime.now(),
    );
    _repository.add(order);
    notifyListeners();
    return order;
  }
}
