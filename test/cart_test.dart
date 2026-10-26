import 'package:coffee_supply_platform/models/product.dart';
import 'package:coffee_supply_platform/providers/cart_provider.dart';
import 'package:coffee_supply_platform/utils/format.dart';
import 'package:flutter_test/flutter_test.dart';

const _product = Product(
  id: 't1',
  name: 'Test Bean',
  origin: 'Nowhere',
  category: ProductCategory.roasted,
  pricePerKg: 100000,
  minOrderKg: 10,
  stockKg: 50,
  flavorNotes: ['a'],
  description: 'd',
);

void main() {
  group('CartProvider', () {
    test('jumlah di bawah minimal order dinaikkan ke minimal', () {
      final cart = CartProvider()..add(_product, 5);
      expect(cart.items.single.qtyKg, 10);
      expect(cart.total, 1000000);
    });

    test('penambahan berulang diakumulasi dan dibatasi stok', () {
      final cart = CartProvider()
        ..add(_product, 30)
        ..add(_product, 30);
      expect(cart.items.length, 1);
      expect(cart.items.single.qtyKg, 50);
    });

    test('setQty, remove, dan clear', () {
      final cart = CartProvider()..add(_product, 10);
      cart.setQty('t1', 25);
      expect(cart.totalKg, 25);
      cart.remove('t1');
      expect(cart.isEmpty, isTrue);
      cart.add(_product, 10);
      cart.clear();
      expect(cart.isEmpty, isTrue);
    });
  });

  test('formatRupiah memakai pemisah titik', () {
    expect(formatRupiah(1250000), 'Rp 1.250.000');
    expect(formatRupiah(950), 'Rp 950');
  });
}
