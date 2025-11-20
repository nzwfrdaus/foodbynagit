import 'package:flutter/material.dart';
import 'package:foodbynagit/models/menu_model.dart';

class CartProvider with ChangeNotifier {
  final Map<MenuModel, int> _items = {}; // menu + qty

  Map<MenuModel, int> get items => _items;

  // Tambah ke keranjang
  void addToCart(MenuModel menu) {
    if (_items.containsKey(menu)) {
      _items[menu] = _items[menu]! + 1;
    } else {
      _items[menu] = 1;
    }
    notifyListeners();
  }

  // Kurangi qty
  void decreaseQty(MenuModel menu) {
    if (!_items.containsKey(menu)) return;

    if (_items[menu]! > 1) {
      _items[menu] = _items[menu]! - 1;
    } else {
      _items.remove(menu);
    }
    notifyListeners();
  }

  // Hapus item
  void removeItem(MenuModel menu) {
    _items.remove(menu);
    notifyListeners();
  }

  // Bersihkan keranjang
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Total harga
  int get totalPrice {
    int total = 0;
    _items.forEach((menu, qty) {
      total += menu.price * qty;
    });
    return total;
  }
}
