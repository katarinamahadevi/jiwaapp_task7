import 'package:flutter/material.dart';

//APPBAR YANG ADA ICON DI KANAN

class AppbarSecondary extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Color backgroundColor;
  final Color iconColor;
  final Color titleColor;
  final FontWeight titleFontWeight;
  final double elevation;
  final IconData rightIcon;
  final VoidCallback onRightIconPressed;

  const AppbarSecondary({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.titleColor = Colors.black,
    this.titleFontWeight = FontWeight.w500,
    this.elevation = 0,
    this.rightIcon = Icons.menu,
    required this.onRightIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor),
        onPressed: onBackPressed ?? () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: titleFontWeight,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(rightIcon, color: iconColor),
          onPressed: onRightIconPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}