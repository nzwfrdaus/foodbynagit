import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import '../data/menu_data.dart';

class MenuProvider extends ChangeNotifier {
  // Data asli
  final List<MenuModel> _all = List<MenuModel>.from(menuData);

  // Filtered menus
  List<MenuModel> _filtered = [];

  // Kategori
  String _selectedCategory = "Semua";

  // Search query
  String _searchQuery = "";

  // Recommended dihitung satu kali
  late final List<MenuModel> recommended = _all
      .where((m) => m.isRecommended)
      .toList();

  MenuProvider() {
    _filtered = List<MenuModel>.from(_all);
  }

  // Getters
  List<MenuModel> get menus => _filtered;
  String get selectedCategory => _selectedCategory;

  // ---------------------
  // UPDATE SEARCH
  // ---------------------
  void setSearch(String value) {
    _searchQuery = value.trim().toLowerCase();
    _applyFilters();
  }

  // CATEGORY
  void setCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  // FILTER UTAMA
  void _applyFilters() {
    _filtered = _all.where((menu) {
      final matchCategory = _selectedCategory == "Semua"
          ? true
          : menu.category == _selectedCategory;

      final matchSearch = _searchQuery.isEmpty
          ? true
          : menu.name.toLowerCase().contains(_searchQuery);

      return matchCategory && matchSearch;
    }).toList();

    notifyListeners();
  }
}
