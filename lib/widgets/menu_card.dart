import 'package:flutter/material.dart';
import '../models/menu_model.dart';

class MenuCard extends StatelessWidget {
  final MenuModel menu;
  final bool isHorizontal;
  final VoidCallback? onTap;

  const MenuCard({
    super.key,
    required this.menu,
    this.isHorizontal = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isHorizontal ? 180 : double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 7,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: isHorizontal
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                menu.image,
                height: isHorizontal ? 110 : 160,
                width: isHorizontal ? 180 : double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 10),

            // NAME
            Text(
              menu.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5C3C96),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // PRICE
            Text(
              "Rp ${menu.price}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
