import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  const CustomSearchBar({
    Key? key,
    this.hintText = 'Search menu',
    this.icon = Icons.search,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE5E5E5),
    this.iconColor = const Color(0xFF3B1D52),
    this.textColor = const Color(0xFFBDBDBD),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Text(
              hintText,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
