import 'package:flutter/material.dart';
import 'package:foodbynagit/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool expanded;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.purple,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      ),
    );

    if (expanded) {
      return SizedBox(width: double.infinity, child: btn);
    }
    return btn;
  }
}
