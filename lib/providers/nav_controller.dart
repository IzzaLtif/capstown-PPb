import 'package:flutter/foundation.dart';

/// Menyimpan tab aktif agar layar mana pun bisa berpindah tab
/// (mis. dari layar sukses pesanan ke tab Pesanan).
class NavController extends ChangeNotifier {
  static const int catalog = 0;
  static const int cart = 1;
  static const int orders = 2;

  int _index = catalog;
  int get index => _index;

  void go(int index) {
    if (index == _index) return;
    _index = index;
    notifyListeners();
  }
}
