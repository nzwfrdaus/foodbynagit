import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodbynagit/providers/menu_provider.dart';
import 'package:foodbynagit/widgets/menu_card.dart';
import 'package:foodbynagit/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FD),

      appBar: AppBar(
        backgroundColor: const Color(0xFFB891F9),
        elevation: 0,
        title: const Text(
          "FoodByNagit",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearch(context),
            const SizedBox(height: 25),

            const Text(
              "Rekomedasi",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF5C3C96),
              ),
            ),
            const SizedBox(height: 14),

            _buildRecommended(),
            const SizedBox(height: 25),

            const Text(
              "Kategori",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5C3C96),
              ),
            ),
            const SizedBox(height: 10),

            _buildCategoryBar(),
            const SizedBox(height: 30),

            const Text(
              "Semua Menu",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5C3C96),
              ),
            ),

            const SizedBox(height: 10),
            _buildMenuList(),
          ],
        ),
      ),
    );
  }

  // SEARCH BAR
  Widget _buildSearch(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) => context.read<MenuProvider>().setSearch(value),
        decoration: const InputDecoration(
          hintText: "Cari menu favorit kamu...",
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // RECOMMENDED LIST
  Widget _buildRecommended() {
    return Consumer<MenuProvider>(
      builder: (context, prov, _) {
        final rec = prov.recommended;

        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: rec.length,
            itemBuilder: (context, i) {
              final item = rec[i];

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailPage(menu: item)),
                  ),
                  child: MenuCard(menu: item, isHorizontal: true),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // CATEGORY BAR
  Widget _buildCategoryBar() {
    return SizedBox(
      height: 45,
      child: Consumer<MenuProvider>(
        builder: (context, prov, _) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _categoryButton("Semua", prov),
              _categoryButton("Makanan", prov),
              _categoryButton("Minuman", prov),
            ],
          );
        },
      ),
    );
  }

  Widget _categoryButton(String label, MenuProvider prov) {
    final isSelected = prov.selectedCategory == label;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () => prov.setCategory(label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFB891F9) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF5C3C96),
            ),
          ),
        ),
      ),
    );
  }

  // ALL MENU LIST
  Widget _buildMenuList() {
    return Consumer<MenuProvider>(
      builder: (context, prov, _) {
        final menus = prov.menus;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menus.length,
          itemBuilder: (context, i) {
            final menu = menus[i];

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailPage(menu: menu)),
                ),
                child: MenuCard(menu: menu),
              ),
            );
          },
        );
      },
    );
  }
}
