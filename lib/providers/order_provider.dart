import 'package:flutter/material.dart';
import 'package:foodbynagit/models/menu_model.dart';

class OrderItem {
  final MenuModel menu;
  final String customerName;
  final String tableNumber;
  final int quantity;
  final DateTime orderedAt;

  OrderItem({
    required this.menu,
    required this.customerName,
    required this.tableNumber,
    this.quantity = 1,
    DateTime? orderedAt,
  }) : orderedAt = orderedAt ?? DateTime.now();
}

class OrderProvider extends ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => List.unmodifiable(_orders);

  void addOrder(OrderItem order) {
    _orders.insert(0, order);
    notifyListeners();
  }

  void removeOrder(int index) {
    if (index >= 0 && index < _orders.length) {
      _orders.removeAt(index);
      notifyListeners();
    }
  }

  void clear() {
    _orders.clear();
    notifyListeners();
  }
}
